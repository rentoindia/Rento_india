package com.rentoindia.backend.admin;

import com.rentoindia.backend.common.ApiException;
import com.rentoindia.backend.common.ApiResponse;
import com.rentoindia.backend.common.Body;
import com.rentoindia.backend.common.Obj;
import com.rentoindia.backend.common.Times;
import com.rentoindia.backend.delivery.Rider;
import com.rentoindia.backend.delivery.RiderDocument;
import com.rentoindia.backend.delivery.RiderDocumentRepository;
import com.rentoindia.backend.delivery.RiderRepository;
import com.rentoindia.backend.delivery.RiderViews;
import com.rentoindia.backend.notification.NotificationService;
import com.rentoindia.backend.realtime.EventHub;
import com.rentoindia.backend.ride.ParcelBooking;
import com.rentoindia.backend.ride.ParcelBookingRepository;
import com.rentoindia.backend.ride.RideBooking;
import com.rentoindia.backend.ride.RideBookingRepository;
import com.rentoindia.backend.ride.RideService;
import com.rentoindia.backend.ride.RideService.Aud;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/** Delivery admin: riders + their documents, person rides ("deliveries"), parcels, SOS. */
@RestController
@RequestMapping("/api/v1/admin/logistics")
public class AdminLogisticsController {

    private final RiderRepository riders;
    private final RiderDocumentRepository docs;
    private final RideBookingRepository rides;
    private final ParcelBookingRepository parcels;
    private final RideService rideService;
    private final NotificationService notifications;
    private final EventHub hub;

    public AdminLogisticsController(RiderRepository riders, RiderDocumentRepository docs, RideBookingRepository rides,
                                    ParcelBookingRepository parcels, RideService rideService,
                                    NotificationService notifications, EventHub hub) {
        this.riders = riders;
        this.docs = docs;
        this.rides = rides;
        this.parcels = parcels;
        this.rideService = rideService;
        this.notifications = notifications;
        this.hub = hub;
    }

    private Rider rider(String id) {
        return riders.findById(Body.parseUuid(id)).orElseThrow(() -> ApiException.notFound("Rider not found"));
    }

    private Obj riderView(Rider r) {
        return RiderViews.of(r, docs.findByRiderIdOrderByCreatedAtDesc(r.id));
    }

    // ------------------------------------------------------------------- riders

    @GetMapping("/riders")
    public ApiResponse<List<Obj>> listRiders() {
        return ApiResponse.ok(riders.findAllByOrderByCreatedAtDesc().stream().map(this::riderView).toList());
    }

    @GetMapping("/riders/{id}")
    public ApiResponse<Obj> getRider(@PathVariable String id) {
        return ApiResponse.ok(riderView(rider(id)));
    }

    /** {status: ACTIVE|INACTIVE|SUSPENDED|PENDING, reason?, until?, note?} */
    @PostMapping("/riders/{id}/status")
    @Transactional
    public ApiResponse<Obj> setStatus(@PathVariable String id, @RequestBody Map<String, Object> b) {
        Rider r = rider(id);
        Rider.Status s = Body.enumOf(Rider.Status.class, Body.str(b, "status"), null);
        if (s == null) throw ApiException.badRequest("Unknown status");
        r.status = s;
        if (s == Rider.Status.SUSPENDED) {
            r.suspensionReason = Body.str(b, "reason");
            r.suspendUntil = Times.parse(Body.str(b, "until"));
            r.additionalNote = Body.str(b, "note");
            r.suspendedOn = Instant.now();
            r.online = false;
        } else {
            r.suspensionReason = null;
            r.suspendUntil = null;
            r.suspendedOn = null;
        }
        if (s != Rider.Status.ACTIVE) r.online = false;
        r = riders.save(r);
        String msg = switch (s) {
            case ACTIVE -> "Your rider account is approved. You can go online now.";
            case SUSPENDED -> "Your rider account has been suspended." + (r.suspensionReason == null ? "" : " Reason: " + r.suspensionReason);
            case INACTIVE -> "Your rider account was deactivated.";
            default -> "Your rider account is under review.";
        };
        notifications.notify(r.userId, "Rider account update", msg, "Alerts", "two_wheeler", null, r.id.toString());
        hub.toUser(r.userId, "rider.status", Obj.of().with("status", r.status.name()));
        Obj v = riderView(r);
        hub.toAdmins("rider.updated", v);
        return ApiResponse.ok(v);
    }

    /** {status: VERIFIED|REJECTED|PENDING, reason?} */
    @PostMapping("/documents/{id}/review")
    @Transactional
    public ApiResponse<Obj> reviewDocument(@PathVariable String id, @RequestBody Map<String, Object> b) {
        RiderDocument d = docs.findById(Body.parseUuid(id)).orElseThrow(() -> ApiException.notFound("Document not found"));
        RiderDocument.Status s = Body.enumOf(RiderDocument.Status.class, Body.str(b, "status"), null);
        if (s == null) throw ApiException.badRequest("Unknown status");
        d.status = s;
        d.rejectReason = s == RiderDocument.Status.REJECTED ? Body.str(b, "reason", "Document not clear") : null;
        docs.save(d);
        Rider r = riders.findById(d.riderId).orElse(null);
        if (r != null && r.status == Rider.Status.PENDING) {
            // all documents verified -> the rider is approved automatically
            List<RiderDocument> all = docs.findByRiderIdOrderByCreatedAtDesc(r.id);
            boolean allOk = !all.isEmpty() && all.stream().allMatch(x -> x.status == RiderDocument.Status.VERIFIED);
            if (allOk) {
                r.status = Rider.Status.ACTIVE;
                riders.save(r);
                notifications.notify(r.userId, "Rider account approved",
                        "All your documents are verified. You can go online now.", "Alerts", "two_wheeler", null, r.id.toString());
                hub.toUser(r.userId, "rider.status", Obj.of().with("status", r.status.name()));
            }
        }
        if (r != null) {
            notifications.notify(r.userId, "Document " + s.name().toLowerCase(),
                    d.type.name().replace('_', ' ') + " was " + s.name().toLowerCase()
                            + (d.rejectReason == null ? "." : ": " + d.rejectReason),
                    "Alerts", "description", null, d.id.toString());
            hub.toAdmins("rider.updated", riderView(r));
        }
        return ApiResponse.ok(RiderViews.document(d));
    }

    @PostMapping("/riders/{id}/payout")
    @Transactional
    public ApiResponse<Obj> payout(@PathVariable String id) {
        Rider r = rider(id);
        double paid = r.pendingPayout;
        r.pendingPayout = 0;
        riders.save(r);
        if (paid > 0) {
            notifications.notify(r.userId, "Payout processed", "\u20B9" + Math.round(paid) + " has been sent to your bank account.",
                    "Alerts", "payments", null, null);
        }
        return ApiResponse.ok(Obj.of().with("paid", paid));
    }

    // ----------------------------------------------------- person rides ("deliveries")

    @GetMapping("/rides")
    public ApiResponse<List<Obj>> listRides() {
        return ApiResponse.ok(rides.findAllByOrderByCreatedAtDesc().stream().map(r -> rideService.rideView(r, Aud.ADMIN)).toList());
    }

    @GetMapping("/rides/{id}")
    public ApiResponse<Obj> getRide(@PathVariable String id) {
        return ApiResponse.ok(rideService.rideView(rideService.getRide(Body.parseUuid(id)), Aud.ADMIN));
    }

    @PostMapping("/rides/{id}/cancel")
    public ApiResponse<Obj> cancelRide(@PathVariable String id, @RequestBody(required = false) Map<String, Object> b) {
        RideBooking r = rideService.cancelRide(rideService.getRide(Body.parseUuid(id)), Body.str(b, "reason", "Cancelled by admin"));
        return ApiResponse.ok(rideService.rideView(r, Aud.ADMIN));
    }

    @PostMapping("/rides/{id}/resolve-sos")
    public ApiResponse<Obj> resolveSos(@PathVariable String id) {
        return ApiResponse.ok(rideService.rideView(rideService.resolveSos(rideService.getRide(Body.parseUuid(id))), Aud.ADMIN));
    }

    @PostMapping("/rides/{id}/notes")
    @Transactional
    public ApiResponse<Obj> addRideNote(@PathVariable String id, @RequestBody Map<String, Object> b) {
        RideBooking r = rideService.getRide(Body.parseUuid(id));
        r.internalNotes = appendNote(r.internalNotes, Body.str(b, "text", ""));
        rides.save(r);
        return ApiResponse.ok(rideService.rideView(r, Aud.ADMIN));
    }

    // ------------------------------------------------------------------ parcels

    @GetMapping("/parcels")
    public ApiResponse<List<Obj>> listParcels() {
        return ApiResponse.ok(parcels.findAllByOrderByCreatedAtDesc().stream().map(p -> rideService.parcelView(p, Aud.ADMIN)).toList());
    }

    @GetMapping("/parcels/{id}")
    public ApiResponse<Obj> getParcel(@PathVariable String id) {
        return ApiResponse.ok(rideService.parcelView(rideService.getParcel(Body.parseUuid(id)), Aud.ADMIN));
    }

    @PostMapping("/parcels/{id}/cancel")
    public ApiResponse<Obj> cancelParcel(@PathVariable String id, @RequestBody(required = false) Map<String, Object> b) {
        ParcelBooking p = rideService.cancelParcel(rideService.getParcel(Body.parseUuid(id)), Body.str(b, "reason", "Cancelled by admin"));
        return ApiResponse.ok(rideService.parcelView(p, Aud.ADMIN));
    }

    @PostMapping("/parcels/{id}/notes")
    @Transactional
    public ApiResponse<Obj> addParcelNote(@PathVariable String id, @RequestBody Map<String, Object> b) {
        ParcelBooking p = rideService.getParcel(Body.parseUuid(id));
        p.internalNotes = appendNote(p.internalNotes, Body.str(b, "text", ""));
        parcels.save(p);
        return ApiResponse.ok(rideService.parcelView(p, Aud.ADMIN));
    }

    private static List<Map<String, Object>> appendNote(List<Map<String, Object>> current, String text) {
        if (text.isBlank()) throw ApiException.badRequest("Note text is required");
        Map<String, Object> n = new LinkedHashMap<>();
        n.put("id", UUID.randomUUID().toString());
        n.put("text", text.trim());
        n.put("createdAt", Instant.now().toString());
        List<Map<String, Object>> list = new java.util.ArrayList<>(current);
        list.add(0, n);
        return list;
    }
}
