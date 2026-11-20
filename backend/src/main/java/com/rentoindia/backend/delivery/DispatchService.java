package com.rentoindia.backend.delivery;

import com.rentoindia.backend.common.ApiException;
import com.rentoindia.backend.common.Body;
import com.rentoindia.backend.common.Obj;
import com.rentoindia.backend.notification.NotificationService;
import com.rentoindia.backend.realtime.EventHub;
import com.rentoindia.backend.rental.OrderService;
import com.rentoindia.backend.rental.RentalOrder;
import com.rentoindia.backend.rental.RentalOrderRepository;
import com.rentoindia.backend.ride.ParcelBooking;
import com.rentoindia.backend.ride.ParcelBookingRepository;
import com.rentoindia.backend.ride.RideBooking;
import com.rentoindia.backend.ride.RideBookingRepository;
import com.rentoindia.backend.ride.RideService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * Everything a rider does with jobs. A "job" is one of three kinds:
 *   TRIP   - rental delivery / return pickup (delivery.Trip)
 *   PARCEL - parcel booking  (ride.ParcelBooking)
 *   RIDE   - person ride     (ride.RideBooking)
 * Jobs store the rider's USER id in riderId.
 */
@Service
public class DispatchService {

    private final TripRepository trips;
    private final ParcelBookingRepository parcels;
    private final RideBookingRepository rides;
    private final RiderRepository riders;
    private final RentalOrderRepository orders;
    private final OrderService orderService;
    private final RideService rideService;
    private final NotificationService notifications;
    private final EventHub hub;

    public DispatchService(TripRepository trips, ParcelBookingRepository parcels, RideBookingRepository rides,
                           RiderRepository riders, RentalOrderRepository orders, OrderService orderService,
                           RideService rideService, NotificationService notifications, EventHub hub) {
        this.trips = trips;
        this.parcels = parcels;
        this.rides = rides;
        this.riders = riders;
        this.orders = orders;
        this.orderService = orderService;
        this.rideService = rideService;
        this.notifications = notifications;
        this.hub = hub;
    }

    // ------------------------------------------------------------------ helpers

    public Rider riderOf(UUID userId) {
        return riders.findByUserId(userId).orElseThrow(() -> ApiException.forbidden("Please register as a rider first"));
    }

    private Rider activeRider(UUID userId) {
        Rider r = riderOf(userId);
        if (r.status == Rider.Status.PENDING) throw ApiException.forbidden("Your rider account is still under review");
        if (r.status == Rider.Status.SUSPENDED) throw ApiException.forbidden("Your rider account is suspended");
        if (r.status == Rider.Status.INACTIVE) throw ApiException.forbidden("Your rider account is inactive");
        return r;
    }

    private static void requireOtp(String expected, String given) {
        if (expected == null || given == null || !expected.trim().equals(given.trim())) {
            throw ApiException.badRequest("Incorrect OTP. Ask the customer for the 4-digit code.");
        }
    }

    private void credit(Rider rider, double amount) {
        rider.totalJobs++;
        rider.completedJobs++;
        rider.totalEarnings += amount;
        rider.pendingPayout += amount;
        riders.save(rider);
    }

    // ------------------------------------------------------------------ listing

    /** Open jobs for an online, approved rider. Newest first. */
    public List<Obj> available(UUID userId) {
        Rider r = riders.findByUserId(userId).orElse(null);
        if (r == null || r.status != Rider.Status.ACTIVE || !r.online) return List.of();
        List<Obj> out = new ArrayList<>();
        trips.findByStatusOrderByCreatedAtAsc(Trip.Status.REQUESTED).forEach(t -> out.add(JobViews.trip(t)));
        parcels.findByStatusOrderByCreatedAtAsc(ParcelBooking.Status.PENDING).forEach(p -> out.add(JobViews.parcel(p)));
        rides.findByStatusOrderByCreatedAtAsc(RideBooking.Status.REQUESTED).forEach(x -> out.add(JobViews.ride(x)));
        out.sort(Comparator.comparing((Obj o) -> String.valueOf(o.get("createdAt"))).reversed());
        return out;
    }

    public List<Obj> current(UUID userId) {
        List<Obj> out = new ArrayList<>();
        trips.findByRiderIdAndStatusIn(userId, List.of(Trip.Status.ACCEPTED, Trip.Status.PICKED_UP))
                .forEach(t -> out.add(JobViews.trip(t)));
        parcels.findByRiderIdAndStatusIn(userId, List.of(ParcelBooking.Status.ASSIGNED, ParcelBooking.Status.IN_TRANSIT))
                .forEach(p -> out.add(JobViews.parcel(p)));
        rides.findByRiderIdAndStatusIn(userId, List.of(RideBooking.Status.ASSIGNED, RideBooking.Status.IN_PROGRESS))
                .forEach(x -> out.add(JobViews.ride(x)));
        return out;
    }

    /** Finished + cancelled jobs (trip history screen). */
    public List<Obj> history(UUID userId) {
        List<Obj> out = new ArrayList<>();
        for (Trip t : trips.findByRiderIdOrderByCreatedAtDesc(userId)) {
            if (t.status == Trip.Status.DELIVERED || t.status == Trip.Status.CANCELLED) out.add(record(JobViews.trip(t), t.updatedAt, t.status == Trip.Status.DELIVERED));
        }
        for (ParcelBooking p : parcels.findByRiderIdOrderByCreatedAtDesc(userId)) {
            if (p.status == ParcelBooking.Status.DELIVERED || p.status == ParcelBooking.Status.CANCELLED) out.add(record(JobViews.parcel(p), p.updatedAt, p.status == ParcelBooking.Status.DELIVERED));
        }
        for (RideBooking x : rides.findByRiderIdOrderByCreatedAtDesc(userId)) {
            if (x.status == RideBooking.Status.COMPLETED || x.status == RideBooking.Status.CANCELLED) out.add(record(JobViews.ride(x), x.updatedAt, x.status == RideBooking.Status.COMPLETED));
        }
        out.sort(Comparator.comparing((Obj o) -> String.valueOf(o.get("completedAt"))).reversed());
        return out;
    }

    private static Obj record(Obj job, Instant when, boolean completed) {
        return job.with("completedAt", when).with("completed", completed);
    }

    public Obj earnings(UUID userId) {
        Instant startOfToday = Instant.now().truncatedTo(ChronoUnit.DAYS);
        Instant weekAgo = Instant.now().minus(7, ChronoUnit.DAYS);
        double today = 0, week = 0, total = 0;
        int todayJobs = 0;
        for (Obj o : history(userId)) {
            if (!Boolean.TRUE.equals(o.get("completed"))) continue;
            double e = o.get("earnings") instanceof Number n ? n.doubleValue() : 0;
            Instant when = (Instant) o.get("completedAt");
            total += e;
            if (when != null && when.isAfter(weekAgo)) week += e;
            if (when != null && when.isAfter(startOfToday)) {
                today += e;
                todayJobs++;
            }
        }
        Rider r = riders.findByUserId(userId).orElse(null);
        return Obj.of().with("today", today).with("todayJobs", todayJobs).with("week", week).with("total", total)
                .with("pendingPayout", r == null ? 0 : r.pendingPayout);
    }

    // ------------------------------------------------------------------- accept

    @Transactional
    public Obj accept(UUID userId, String kind, UUID id) {
        Rider rider = activeRider(userId);
        switch (kind.toUpperCase()) {
            case "TRIP" -> {
                Trip t = trips.findById(id).orElseThrow(() -> ApiException.notFound("Job not found"));
                if (t.status != Trip.Status.REQUESTED) throw ApiException.conflict("Another rider already took this job");
                t.status = Trip.Status.ACCEPTED;
                t.riderId = userId;
                trips.save(t);
                orders.findById(t.orderId).ifPresent(o -> {
                    if (t.type == Trip.Type.DELIVERY) {
                        orderService.system(o, RentalOrder.Status.RIDER_ASSIGNED, "Rider Assigned", rider.name + " will deliver your order");
                    } else {
                        orderService.publish(o);
                    }
                });
                taken("TRIP", t.id);
                publishTrip(t);
                return JobViews.trip(t);
            }
            case "PARCEL" -> {
                ParcelBooking p = parcels.findById(id).orElseThrow(() -> ApiException.notFound("Job not found"));
                if (p.status != ParcelBooking.Status.PENDING) throw ApiException.conflict("Another rider already took this job");
                p.status = ParcelBooking.Status.ASSIGNED;
                p.riderId = userId;
                RideService.activity(p.activities, "Rider assigned: " + rider.name);
                parcels.save(p);
                taken("PARCEL", p.id);
                notifications.notify(p.senderId, "Rider assigned", rider.name + " is on the way to pick up your parcel.",
                        "Orders", "two_wheeler", null, p.id.toString());
                rideService.publishParcel(p);
                return JobViews.parcel(p);
            }
            case "RIDE" -> {
                RideBooking x = rides.findById(id).orElseThrow(() -> ApiException.notFound("Job not found"));
                if (x.status != RideBooking.Status.REQUESTED) throw ApiException.conflict("Another rider already took this job");
                x.status = RideBooking.Status.ASSIGNED;
                x.riderId = userId;
                RideService.activity(x.activities, "Captain assigned: " + rider.name);
                rides.save(x);
                taken("RIDE", x.id);
                notifications.notify(x.passengerId, "Captain on the way", rider.name + " accepted your ride.",
                        "Orders", "directions_car", null, x.id.toString());
                rideService.publishRide(x);
                return JobViews.ride(x);
            }
            default -> throw ApiException.badRequest("Unknown job kind: " + kind);
        }
    }

    // ------------------------------------------------------------- pickup / drop

    @Transactional
    public Obj verifyPickup(UUID userId, String kind, UUID id, Map<String, Object> b) {
        activeRider(userId);
        String otp = Body.str(b, "otp");
        switch (kind.toUpperCase()) {
            case "TRIP" -> {
                Trip t = trips.findById(id).orElseThrow(() -> ApiException.notFound("Job not found"));
                mustBeMine(t.riderId, userId);
                if (t.status != Trip.Status.ACCEPTED) throw ApiException.conflict("This job is not waiting for pickup");
                requireOtp(t.pickupOtp, otp);
                t.status = Trip.Status.PICKED_UP;
                trips.save(t);
                orders.findById(t.orderId).ifPresent(o -> {
                    if (t.type == Trip.Type.DELIVERY) {
                        orderService.system(o, RentalOrder.Status.OUT_FOR_DELIVERY, "Out for Delivery", "Your item is on the way");
                    }
                });
                publishTrip(t);
                return JobViews.trip(t);
            }
            case "PARCEL" -> {
                ParcelBooking p = parcels.findById(id).orElseThrow(() -> ApiException.notFound("Job not found"));
                mustBeMine(p.riderId, userId);
                if (p.status != ParcelBooking.Status.ASSIGNED) throw ApiException.conflict("This job is not waiting for pickup");
                requireOtp(p.pickupOtp, otp);
                p.status = ParcelBooking.Status.IN_TRANSIT;
                p.pickupVerifiedAt = Instant.now();
                p.pickupCondition = Body.str(b, "condition", "good");
                p.pickupNotes = Body.str(b, "notes");
                p.pickupProofCount = Body.intv(b, "proofCount", 0);
                RideService.activity(p.activities, "Parcel picked up");
                parcels.save(p);
                rideService.publishParcel(p);
                return JobViews.parcel(p);
            }
            case "RIDE" -> {
                RideBooking x = rides.findById(id).orElseThrow(() -> ApiException.notFound("Job not found"));
                mustBeMine(x.riderId, userId);
                if (x.status != RideBooking.Status.ASSIGNED) throw ApiException.conflict("This ride has not been accepted yet");
                requireOtp(x.startOtp, otp);
                x.status = RideBooking.Status.IN_PROGRESS;
                RideService.activity(x.activities, "Ride started");
                rides.save(x);
                rideService.publishRide(x);
                return JobViews.ride(x);
            }
            default -> throw ApiException.badRequest("Unknown job kind: " + kind);
        }
    }

    @Transactional
    public Obj verifyDrop(UUID userId, String kind, UUID id, Map<String, Object> b) {
        Rider rider = activeRider(userId);
        String otp = Body.str(b, "otp");
        switch (kind.toUpperCase()) {
            case "TRIP" -> {
                Trip t = trips.findById(id).orElseThrow(() -> ApiException.notFound("Job not found"));
                mustBeMine(t.riderId, userId);
                if (t.status != Trip.Status.PICKED_UP) throw ApiException.conflict("Pickup has not been completed");
                requireOtp(t.dropOtp, otp);
                t.status = Trip.Status.DELIVERED;
                trips.save(t);
                credit(rider, t.earnings);
                orders.findById(t.orderId).ifPresent(o -> {
                    if (t.type == Trip.Type.DELIVERY) {
                        orderService.system(o, RentalOrder.Status.DELIVERED, "Delivered", "Your item was delivered");
                    } else {
                        orderService.system(o, RentalOrder.Status.RETURN_COLLECTED, "Return Collected", "The item was collected and returned");
                    }
                });
                publishTrip(t);
                return JobViews.trip(t);
            }
            case "PARCEL" -> {
                ParcelBooking p = parcels.findById(id).orElseThrow(() -> ApiException.notFound("Job not found"));
                mustBeMine(p.riderId, userId);
                if (p.status != ParcelBooking.Status.IN_TRANSIT) throw ApiException.conflict("Parcel has not been picked up");
                requireOtp(p.deliveryOtp, otp);
                p.status = ParcelBooking.Status.DELIVERED;
                p.deliveryVerifiedAt = Instant.now();
                p.deliveryCondition = Body.str(b, "condition", "good");
                p.deliveryNotes = Body.str(b, "notes");
                p.deliveryProofCount = Body.intv(b, "proofCount", 0);
                p.paymentStatus = "PAID";
                RideService.activity(p.activities, "Parcel delivered");
                parcels.save(p);
                credit(rider, p.riderPayout);
                notifications.notify(p.senderId, "Parcel delivered", "Parcel " + p.code + " was delivered to " + p.receiverName + ".",
                        "Orders", "check", null, p.id.toString());
                rideService.publishParcel(p);
                return JobViews.parcel(p);
            }
            case "RIDE" -> {
                RideBooking x = rides.findById(id).orElseThrow(() -> ApiException.notFound("Job not found"));
                mustBeMine(x.riderId, userId);
                if (x.status != RideBooking.Status.IN_PROGRESS) throw ApiException.conflict("Ride has not started");
                x.status = RideBooking.Status.COMPLETED;
                x.paymentStatus = "PAID";
                x.paidOn = Instant.now();
                if (x.transactionId == null) x.transactionId = "TXN" + System.currentTimeMillis();
                RideService.activity(x.activities, "Ride completed");
                rides.save(x);
                credit(rider, x.riderPayout);
                notifications.notify(x.passengerId, "Ride completed", "Thanks for riding! Fare: \u20B9" + Math.round(x.fare),
                        "Orders", "check", null, x.id.toString());
                rideService.publishRide(x);
                return JobViews.ride(x);
            }
            default -> throw ApiException.badRequest("Unknown job kind: " + kind);
        }
    }

    /** Rider backs out before pickup: the job goes back to the open pool for other riders. */
    @Transactional
    public Obj release(UUID userId, String kind, UUID id, String reason) {
        Rider rider = activeRider(userId);
        rider.cancelledJobs++;
        riders.save(rider);
        switch (kind.toUpperCase()) {
            case "TRIP" -> {
                Trip t = trips.findById(id).orElseThrow(() -> ApiException.notFound("Job not found"));
                mustBeMine(t.riderId, userId);
                if (t.status != Trip.Status.ACCEPTED) throw ApiException.badRequest("Cannot cancel after pickup");
                t.status = Trip.Status.REQUESTED;
                t.riderId = null;
                trips.save(t);
                hub.toRiders("dispatch.new", JobViews.trip(t));
                publishTrip(t);
            }
            case "PARCEL" -> {
                ParcelBooking p = parcels.findById(id).orElseThrow(() -> ApiException.notFound("Job not found"));
                mustBeMine(p.riderId, userId);
                if (p.status != ParcelBooking.Status.ASSIGNED) throw ApiException.badRequest("Cannot cancel after pickup");
                p.status = ParcelBooking.Status.PENDING;
                p.riderId = null;
                RideService.activity(p.activities, "Rider cancelled (" + (reason == null ? "no reason" : reason) + "). Finding a new rider");
                parcels.save(p);
                hub.toRiders("dispatch.new", JobViews.parcel(p));
                rideService.publishParcel(p);
            }
            case "RIDE" -> {
                RideBooking x = rides.findById(id).orElseThrow(() -> ApiException.notFound("Job not found"));
                mustBeMine(x.riderId, userId);
                if (x.status != RideBooking.Status.ASSIGNED) throw ApiException.badRequest("Cannot cancel after the ride started");
                x.status = RideBooking.Status.REQUESTED;
                x.riderId = null;
                RideService.activity(x.activities, "Captain cancelled. Finding a new captain");
                rides.save(x);
                hub.toRiders("dispatch.new", JobViews.ride(x));
                rideService.publishRide(x);
            }
            default -> throw ApiException.badRequest("Unknown job kind: " + kind);
        }
        return Obj.of().with("released", true);
    }

    // --------------------------------------------------------------- live position

    /** Called every few seconds by the rider app. Updates the rider and, if a job is given, streams it live. */
    public void location(UUID userId, double lat, double lng, String kind, UUID jobId) {
        Rider r = riderOf(userId);
        r.lat = lat;
        r.lng = lng;
        r.lastLocationAt = Instant.now();
        riders.save(r);
        if (kind != null && jobId != null) {
            Obj ev = Obj.of().with("riderId", userId).with("lat", lat).with("lng", lng).with("jobId", jobId);
            String k = kind.toLowerCase();
            hub.publish(k + ":" + jobId, "location", ev);
            if ("trip".equals(k)) {
                trips.findById(jobId).ifPresent(t -> hub.publish("order:" + t.orderId, "location", ev));
            }
            hub.toAdmins("rider.location", Obj.of().with("riderId", userId).with("lat", lat).with("lng", lng));
        }
    }

    // ----------------------------------------------------------------- internals

    private static void mustBeMine(UUID jobRider, UUID userId) {
        if (jobRider == null || !jobRider.equals(userId)) throw ApiException.forbidden("This job is assigned to another rider");
    }

    private void taken(String kind, UUID id) {
        hub.toRiders("dispatch.taken", Obj.of().with("kind", kind).with("id", id));
    }

    private void publishTrip(Trip t) {
        Obj v = JobViews.trip(t);
        hub.publish("trip:" + t.id, "job.updated", v);
        if (t.riderId != null) hub.toUser(t.riderId, "job.updated", v);
        hub.toAdmins("trip.updated", v);
    }
}
