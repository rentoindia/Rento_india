package com.rentoindia.backend.ride;

import com.rentoindia.backend.auth.User;
import com.rentoindia.backend.auth.UserRepository;
import com.rentoindia.backend.common.ApiException;
import com.rentoindia.backend.common.Body;
import com.rentoindia.backend.common.Obj;
import com.rentoindia.backend.delivery.JobViews;
import com.rentoindia.backend.delivery.Pricing;
import com.rentoindia.backend.delivery.Rider;
import com.rentoindia.backend.delivery.RiderRepository;
import com.rentoindia.backend.notification.NotificationService;
import com.rentoindia.backend.realtime.EventHub;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.SecureRandom;
import java.time.Instant;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/** Person-ride and parcel bookings: creation, cancellation, SOS, and the JSON views of both. */
@Service
public class RideService {

    /** Who is looking at the data. Handover OTPs are only visible to OWNER (passenger/sender) and ADMIN. */
    public enum Aud { OWNER, ADMIN, RIDER, PUBLIC }

    private static final SecureRandom RANDOM = new SecureRandom();

    private final RideBookingRepository rides;
    private final ParcelBookingRepository parcels;
    private final UserRepository users;
    private final RiderRepository riders;
    private final NotificationService notifications;
    private final EventHub hub;

    public RideService(RideBookingRepository rides, ParcelBookingRepository parcels, UserRepository users,
                       RiderRepository riders, NotificationService notifications, EventHub hub) {
        this.rides = rides;
        this.parcels = parcels;
        this.users = users;
        this.riders = riders;
        this.notifications = notifications;
        this.hub = hub;
    }

    private static String otp() {
        return String.format("%04d", RANDOM.nextInt(10000));
    }

    public static void activity(List<Map<String, Object>> list, String title) {
        Map<String, Object> e = new LinkedHashMap<>();
        e.put("title", title);
        e.put("state", "done");
        e.put("timestamp", Instant.now().toString());
        list.add(e);
    }

    // ======================================================================== rides

    public RideBooking getRide(UUID id) {
        return rides.findById(id).orElseThrow(() -> ApiException.notFound("Ride not found"));
    }

    public ParcelBooking getParcel(UUID id) {
        return parcels.findById(id).orElseThrow(() -> ApiException.notFound("Parcel not found"));
    }

    @Transactional
    public RideBooking createRide(UUID passengerId, Map<String, Object> b) {
        User u = users.findById(passengerId).orElseThrow(() -> ApiException.unauthorized("Login required"));
        RideBooking r = new RideBooking();
        r.code = String.format("TRP%05d", 10001 + rides.count());
        r.passengerId = passengerId;
        r.passengerName = u.fullName == null || u.fullName.isBlank() ? "Passenger" : u.fullName;
        r.passengerPhone = u.phone;
        r.passengerCount = Math.max(1, Body.intv(b, "passengerCount", 1));
        r.pickupLabel = Body.str(b, "pickupLabel", "");
        r.pickupAddress = Body.str(b, "pickupAddress", "");
        r.pickupLat = Body.dbl(b, "pickupLat", 0);
        r.pickupLng = Body.dbl(b, "pickupLng", 0);
        r.dropLabel = Body.str(b, "dropLabel", "");
        r.dropAddress = Body.str(b, "dropAddress", "");
        r.dropLat = Body.dbl(b, "dropLat", 0);
        r.dropLng = Body.dbl(b, "dropLng", 0);
        if (r.pickupAddress.isBlank() && r.pickupLabel.isBlank()) throw ApiException.badRequest("Pickup location is required");
        if (r.dropAddress.isBlank() && r.dropLabel.isBlank()) throw ApiException.badRequest("Destination is required");
        r.vehicleType = Body.str(b, "vehicleType", "bike");
        r.notes = Body.str(b, "notes");
        r.promoCode = Body.str(b, "promoCode");
        r.paymentMethod = Body.str(b, "paymentMethod", "CASH").toUpperCase();

        double km = Body.dbl(b, "distanceKm", 0);
        if (km <= 0) km = Pricing.haversineKm(r.pickupLat, r.pickupLng, r.dropLat, r.dropLng);
        if (km <= 0) km = 3;
        r.distanceKm = Pricing.round2(km);
        int mins = Body.intv(b, "durationMinutes", 0);
        r.durationMinutes = mins > 0 ? mins : Pricing.minutesFor(km);

        double fare = Body.dbl(b, "fare", 0);
        if (fare <= 0) fare = Pricing.rideFare(r.distanceKm, r.durationMinutes, r.vehicleType);
        r.fare = Pricing.round2(fare);
        r.baseFare = Pricing.round2(fare * 0.35);
        r.distanceCharge = Pricing.round2(fare * 0.45);
        r.timeCharge = Pricing.round2(fare * 0.10);
        r.convenienceFee = Pricing.round2(fare * 0.05);
        r.platformFee = Pricing.round2(fare - r.baseFare - r.distanceCharge - r.timeCharge - r.convenienceFee);
        r.riderPayout = Pricing.round2(fare * 0.80);
        r.platformCommission = Pricing.round2(fare - r.riderPayout);
        r.startOtp = otp();
        activity(r.activities, "Ride Requested");
        r = rides.save(r);

        hub.toRiders("dispatch.new", JobViews.ride(r));
        hub.toAdmins("ride.created", rideView(r, Aud.ADMIN));
        notifications.notify(passengerId, "Finding your captain", "We are looking for a captain near you.",
                "Orders", "directions_car", null, r.id.toString());
        return r;
    }

    @Transactional
    public RideBooking cancelRide(RideBooking r, String reason) {
        if (r.status == RideBooking.Status.CANCELLED) return r;
        if (r.status == RideBooking.Status.IN_PROGRESS || r.status == RideBooking.Status.COMPLETED) {
            throw ApiException.badRequest("This ride can no longer be cancelled");
        }
        UUID rider = r.riderId;
        r.status = RideBooking.Status.CANCELLED;
        activity(r.activities, "Ride Cancelled" + (reason == null || reason.isBlank() ? "" : " - " + reason));
        r = rides.save(r);
        hub.toRiders("dispatch.cancelled", Obj.of().with("kind", "RIDE").with("id", r.id));
        if (rider != null) hub.toUser(rider, "dispatch.cancelled", Obj.of().with("kind", "RIDE").with("id", r.id));
        publishRide(r);
        return r;
    }

    @Transactional
    public RideBooking triggerSos(RideBooking r) {
        r.sosStatus = "ACTIVE";
        r.sosTriggeredAt = Instant.now();
        activity(r.activities, "SOS triggered by passenger");
        r = rides.save(r);
        hub.toAdmins("sos.triggered", Obj.of().with("id", r.id).with("code", r.code)
                .with("passengerName", r.passengerName).with("passengerPhone", r.passengerPhone)
                .with("pickupAddress", r.pickupAddress).with("dropAddress", r.dropAddress));
        publishRide(r);
        return r;
    }

    @Transactional
    public RideBooking resolveSos(RideBooking r) {
        r.sosStatus = "RESOLVED";
        activity(r.activities, "SOS resolved by admin");
        r = rides.save(r);
        publishRide(r);
        return r;
    }

    public void publishRide(RideBooking r) {
        hub.toUser(r.passengerId, "ride.updated", rideView(r, Aud.OWNER));
        if (r.riderId != null) hub.toUser(r.riderId, "ride.updated", rideView(r, Aud.RIDER));
        hub.toAdmins("ride.updated", rideView(r, Aud.ADMIN));
        hub.publish("ride:" + r.id, "ride.updated", rideView(r, Aud.PUBLIC));
    }

    // ===================================================================== parcels

    @Transactional
    public ParcelBooking createParcel(UUID senderId, Map<String, Object> b) {
        User u = users.findById(senderId).orElseThrow(() -> ApiException.unauthorized("Login required"));
        ParcelBooking p = new ParcelBooking();
        p.code = String.format("PD%05d", 10001 + parcels.count());
        p.senderId = senderId;
        p.senderName = Body.str(b, "senderName", u.fullName == null || u.fullName.isBlank() ? "Sender" : u.fullName);
        p.senderPhone = Body.str(b, "senderPhone", u.phone);
        p.pickupLabel = Body.str(b, "pickupLabel", "");
        p.pickupAddress = Body.str(b, "pickupAddress", "");
        p.pickupLat = Body.dbl(b, "pickupLat", 0);
        p.pickupLng = Body.dbl(b, "pickupLng", 0);
        p.receiverName = Body.str(b, "receiverName", "");
        p.receiverPhone = Body.str(b, "receiverPhone", "");
        p.dropLabel = Body.str(b, "dropLabel", "");
        p.dropAddress = Body.str(b, "dropAddress", "");
        p.dropLat = Body.dbl(b, "dropLat", 0);
        p.dropLng = Body.dbl(b, "dropLng", 0);
        if (p.receiverName.isBlank()) throw ApiException.badRequest("Receiver name is required");
        if (p.pickupAddress.isBlank() && p.pickupLabel.isBlank()) throw ApiException.badRequest("Pickup address is required");
        if (p.dropAddress.isBlank() && p.dropLabel.isBlank()) throw ApiException.badRequest("Drop address is required");
        p.parcelType = Body.str(b, "parcelType", "other");
        p.parcelSize = Body.str(b, "parcelSize", "small");
        p.weightKg = Math.max(0, Body.dbl(b, "weightKg", 1));
        p.specialHandling = Body.bool(b, "needsSpecialHandling", false);
        p.instructions = Body.str(b, "instructions");
        p.description = Body.str(b, "description");
        p.vehicleId = Body.str(b, "vehicleId");
        p.paymentMethod = Body.str(b, "paymentMethod", "CASH").toUpperCase();

        double km = Body.dbl(b, "distanceKm", 0);
        if (km <= 0) km = Pricing.haversineKm(p.pickupLat, p.pickupLng, p.dropLat, p.dropLng);
        if (km <= 0) km = 3;
        p.distanceKm = Pricing.round2(km);
        int mins = Body.intv(b, "estimatedMinutes", 0);
        p.estimatedMinutes = mins > 0 ? mins : Pricing.minutesFor(km);

        double fare = Body.dbl(b, "fare", 0);
        if (fare <= 0) fare = Pricing.parcelFare(p.distanceKm, p.weightKg);
        p.fare = Pricing.round2(fare);
        // fare = (delivery charge + platform fee) + GST
        double beforeGst = fare / (1 + p.gstPercent / 100.0);
        p.platformFee = Pricing.round2(beforeGst * 0.10);
        p.deliveryCharge = Pricing.round2(beforeGst - p.platformFee);
        p.riderPayout = Pricing.round2(p.deliveryCharge * 0.85);
        p.pickupOtp = otp();
        p.deliveryOtp = otp();
        activity(p.activities, "Parcel Booked");
        p = parcels.save(p);

        hub.toRiders("dispatch.new", JobViews.parcel(p));
        hub.toAdmins("parcel.created", parcelView(p, Aud.ADMIN));
        notifications.notify(senderId, "Parcel booked", "Parcel " + p.code + " is waiting for a rider.",
                "Orders", "inventory", null, p.id.toString());
        return p;
    }

    @Transactional
    public ParcelBooking cancelParcel(ParcelBooking p, String reason) {
        if (p.status == ParcelBooking.Status.CANCELLED) return p;
        if (p.status == ParcelBooking.Status.IN_TRANSIT || p.status == ParcelBooking.Status.DELIVERED) {
            throw ApiException.badRequest("This parcel can no longer be cancelled");
        }
        UUID rider = p.riderId;
        p.status = ParcelBooking.Status.CANCELLED;
        activity(p.activities, "Parcel Cancelled" + (reason == null || reason.isBlank() ? "" : " - " + reason));
        p = parcels.save(p);
        hub.toRiders("dispatch.cancelled", Obj.of().with("kind", "PARCEL").with("id", p.id));
        if (rider != null) hub.toUser(rider, "dispatch.cancelled", Obj.of().with("kind", "PARCEL").with("id", p.id));
        publishParcel(p);
        return p;
    }

    public void publishParcel(ParcelBooking p) {
        hub.toUser(p.senderId, "parcel.updated", parcelView(p, Aud.OWNER));
        if (p.riderId != null) hub.toUser(p.riderId, "parcel.updated", parcelView(p, Aud.RIDER));
        hub.toAdmins("parcel.updated", parcelView(p, Aud.ADMIN));
        hub.publish("parcel:" + p.id, "parcel.updated", parcelView(p, Aud.PUBLIC));
    }

    // ======================================================================== views

    public Obj riderBrief(UUID riderUserId) {
        if (riderUserId == null) return null;
        Rider r = riders.findByUserId(riderUserId).orElse(null);
        if (r == null) return null;
        return Obj.of().with("id", r.userId).with("name", r.name).with("phone", r.phone)
                .with("vehicleModel", r.brandModel).with("vehicleType", r.vehicleType)
                .with("vehicleNumber", r.vehicleNumber).with("rating", r.rating)
                .with("lat", r.lat).with("lng", r.lng);
    }

    /** Builds the JSON for one audience (see Aud). */
    public Obj rideView(RideBooking r, Aud aud) {
        Obj v = Obj.of()
                .with("id", r.id).with("code", r.code).with("status", r.status.name())
                .with("requestedAt", r.createdAt).with("updatedAt", r.updatedAt)
                .with("passengerId", r.passengerId).with("passengerName", r.passengerName)
                .with("passengerPhone", r.passengerPhone).with("passengerCount", r.passengerCount)
                .with("riderId", r.riderId).with("rider", riderBrief(r.riderId))
                .with("pickupLabel", r.pickupLabel).with("pickupAddress", r.pickupAddress)
                .with("pickupLat", r.pickupLat).with("pickupLng", r.pickupLng)
                .with("dropLabel", r.dropLabel).with("dropAddress", r.dropAddress)
                .with("dropLat", r.dropLat).with("dropLng", r.dropLng)
                .with("vehicleType", r.vehicleType).with("distanceKm", r.distanceKm)
                .with("durationMinutes", r.durationMinutes).with("notes", r.notes)
                .with("fare", r.fare).with("baseFare", r.baseFare).with("distanceCharge", r.distanceCharge)
                .with("timeCharge", r.timeCharge).with("convenienceFee", r.convenienceFee)
                .with("platformFee", r.platformFee).with("riderPayout", r.riderPayout)
                .with("platformCommission", r.platformCommission)
                .with("paymentMethod", r.paymentMethod).with("paymentStatus", r.paymentStatus)
                .with("transactionId", r.transactionId).with("paidOn", r.paidOn)
                .with("sosStatus", r.sosStatus).with("sosTriggeredAt", r.sosTriggeredAt)
                .with("activities", r.activities);
        if (aud == Aud.ADMIN) v.with("internalNotes", r.internalNotes);
        if (aud == Aud.ADMIN || aud == Aud.OWNER) v.with("startOtp", r.startOtp);
        return v;
    }

    public Obj parcelView(ParcelBooking p, Aud aud) {
        Obj v = Obj.of()
                .with("id", p.id).with("code", p.code).with("status", p.status.name())
                .with("orderDate", p.createdAt).with("updatedAt", p.updatedAt)
                .with("senderId", p.senderId).with("senderName", p.senderName).with("senderPhone", p.senderPhone)
                .with("pickupLabel", p.pickupLabel).with("pickupAddress", p.pickupAddress)
                .with("pickupLat", p.pickupLat).with("pickupLng", p.pickupLng)
                .with("receiverName", p.receiverName).with("receiverPhone", p.receiverPhone)
                .with("dropLabel", p.dropLabel).with("dropAddress", p.dropAddress)
                .with("dropLat", p.dropLat).with("dropLng", p.dropLng)
                .with("parcelType", p.parcelType).with("parcelSize", p.parcelSize).with("weightKg", p.weightKg)
                .with("needsSpecialHandling", p.specialHandling).with("instructions", p.instructions)
                .with("description", p.description).with("vehicleId", p.vehicleId)
                .with("distanceKm", p.distanceKm).with("estimatedMinutes", p.estimatedMinutes)
                .with("deliveryCharge", p.deliveryCharge).with("platformFee", p.platformFee)
                .with("gstPercent", p.gstPercent).with("fare", p.fare).with("riderPayout", p.riderPayout)
                .with("paymentMethod", p.paymentMethod).with("paymentStatus", p.paymentStatus)
                .with("transactionId", p.transactionId)
                .with("riderId", p.riderId).with("rider", riderBrief(p.riderId))
                .with("pickupVerifiedAt", p.pickupVerifiedAt).with("deliveryVerifiedAt", p.deliveryVerifiedAt)
                .with("pickupCondition", p.pickupCondition).with("deliveryCondition", p.deliveryCondition)
                .with("pickupNotes", p.pickupNotes).with("deliveryNotes", p.deliveryNotes)
                .with("pickupProofCount", p.pickupProofCount).with("deliveryProofCount", p.deliveryProofCount)
                .with("activities", p.activities);
        if (aud == Aud.ADMIN) v.with("internalNotes", p.internalNotes);
        if (aud == Aud.ADMIN || aud == Aud.OWNER) {
            // the sender shows these codes to the rider (pickup) and receiver (delivery)
            v.with("pickupOtp", p.pickupOtp).with("deliveryOtp", p.deliveryOtp);
        }
        return v;
    }
}
