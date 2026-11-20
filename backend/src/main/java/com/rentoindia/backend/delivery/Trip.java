package com.rentoindia.backend.delivery;

import com.rentoindia.backend.common.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Table;
import jakarta.persistence.Version;

import java.util.UUID;

/**
 * A rental delivery or return-pickup job created from a rental order.
 * (Parcel and person-ride jobs live in the ride package.)
 */
@Entity
@Table(name = "delivery_trips")
public class Trip extends BaseEntity {

    public enum Type { DELIVERY, RETURN_PICKUP }

    public enum Status { REQUESTED, ACCEPTED, PICKED_UP, DELIVERED, CANCELLED }

    @Version
    public long version;

    @Column(nullable = false)
    public UUID orderId;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    public Type type = Type.DELIVERY;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    public Status status = Status.REQUESTED;

    public UUID riderId;
    public UUID customerId;

    public String itemName;
    public String category;
    public int qty = 1;
    public String imageUrl;
    public String priority = "ACTIVE NOW";   // ACTIVE NOW | SCHEDULED | URGENT

    public String pickupLabel;
    public String pickupAddress;
    public double pickupLat;
    public double pickupLng;
    public String dropLabel;
    public String dropAddress;
    public double dropLat;
    public double dropLng;
    public String customerPhone;

    public double distanceKm = 3;
    public int estimatedMinutes = 20;
    public double earnings = 100;

    public String pickupOtp;
    public String dropOtp;
}
