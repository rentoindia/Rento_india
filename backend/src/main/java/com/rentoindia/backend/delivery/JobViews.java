package com.rentoindia.backend.delivery;

import com.rentoindia.backend.common.Obj;
import com.rentoindia.backend.ride.ParcelBooking;
import com.rentoindia.backend.ride.RideBooking;

/**
 * What a rider sees for a job. Handover OTPs are deliberately NOT included:
 * the customer/sender gets the code and tells it to the rider.
 */
public final class JobViews {

    private JobViews() {}

    public static Obj trip(Trip t) {
        return Obj.of()
                .with("kind", "TRIP")
                .with("id", t.id)
                .with("orderId", t.orderId)
                .with("requestType", t.type == Trip.Type.RETURN_PICKUP ? "returnPickup" : "delivery")
                .with("itemName", t.itemName)
                .with("category", t.category)
                .with("qty", t.qty)
                .with("imageUrl", t.imageUrl)
                .with("priority", t.priority)
                .with("distanceKm", t.distanceKm)
                .with("estimatedMinutes", t.estimatedMinutes)
                .with("earnings", t.earnings)
                .with("rating", 4.8)
                .with("pickupLabel", t.pickupLabel)
                .with("pickupAddress", t.pickupAddress)
                .with("pickupLat", t.pickupLat)
                .with("pickupLng", t.pickupLng)
                .with("dropLabel", t.dropLabel)
                .with("dropAddress", t.dropAddress)
                .with("dropLat", t.dropLat)
                .with("dropLng", t.dropLng)
                .with("customerPhone", t.customerPhone)
                .with("status", t.status.name())
                .with("riderId", t.riderId)
                .with("createdAt", t.createdAt);
    }

    public static Obj parcel(ParcelBooking p) {
        return Obj.of()
                .with("kind", "PARCEL")
                .with("id", p.id)
                .with("code", p.code)
                .with("parcelType", p.parcelType)
                .with("parcelSize", p.parcelSize)
                .with("weightKg", p.weightKg)
                .with("needsSpecialHandling", p.specialHandling)
                .with("instructions", p.instructions)
                .with("senderName", p.senderName)
                .with("senderPhone", p.senderPhone)
                .with("pickupLabel", p.pickupLabel)
                .with("pickupAddress", p.pickupAddress)
                .with("pickupLat", p.pickupLat)
                .with("pickupLng", p.pickupLng)
                .with("receiverName", p.receiverName)
                .with("receiverPhone", p.receiverPhone)
                .with("dropLabel", p.dropLabel)
                .with("dropAddress", p.dropAddress)
                .with("dropLat", p.dropLat)
                .with("dropLng", p.dropLng)
                .with("distanceKm", p.distanceKm)
                .with("estimatedMinutes", p.estimatedMinutes)
                .with("earnings", p.riderPayout)
                .with("status", p.status.name())
                .with("riderId", p.riderId)
                .with("createdAt", p.createdAt);
    }

    public static Obj ride(RideBooking r) {
        return Obj.of()
                .with("kind", "RIDE")
                .with("id", r.id)
                .with("code", r.code)
                .with("passengerName", r.passengerName)
                .with("passengerPhone", r.passengerPhone)
                .with("passengerCount", r.passengerCount)
                .with("pickupLabel", r.pickupLabel)
                .with("pickupAddress", r.pickupAddress)
                .with("pickupLat", r.pickupLat)
                .with("pickupLng", r.pickupLng)
                .with("dropLabel", r.dropLabel)
                .with("dropAddress", r.dropAddress)
                .with("dropLat", r.dropLat)
                .with("dropLng", r.dropLng)
                .with("distanceKm", r.distanceKm)
                .with("estimatedMinutes", r.durationMinutes)
                .with("fare", r.fare)
                .with("earnings", r.riderPayout)
                .with("paymentMethod", r.paymentMethod)
                .with("status", r.status.name())
                .with("riderId", r.riderId)
                .with("createdAt", r.createdAt);
    }
}
