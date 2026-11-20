package com.rentoindia.backend.ride;

import com.rentoindia.backend.common.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Table;
import jakarta.persistence.Version;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/** Parcel delivery: sender -> receiver, carried by a rider. */
@Entity
@Table(name = "parcel_bookings")
public class ParcelBooking extends BaseEntity {

    public enum Status { PENDING, ASSIGNED, IN_TRANSIT, DELIVERED, CANCELLED }

    @Version
    public long version;

    public String code;                          // PD10244

    @Column(nullable = false)
    public UUID senderId;
    public String senderName;
    public String senderPhone;
    public UUID riderId;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    public Status status = Status.PENDING;

    public String pickupLabel;
    public String pickupAddress;
    public double pickupLat;
    public double pickupLng;

    public String receiverName;
    public String receiverPhone;
    public String dropLabel;
    public String dropAddress;
    public double dropLat;
    public double dropLng;

    public String parcelType = "other";
    public String parcelSize = "small";
    public double weightKg = 1;
    public boolean specialHandling = false;
    @Column(length = 1000)
    public String instructions;
    @Column(length = 1000)
    public String description;

    public String vehicleId;
    public double distanceKm = 3;
    public int estimatedMinutes = 20;

    public double deliveryCharge;
    public double platformFee;
    public double gstPercent = 18;
    public double fare;                          // total payable
    public double riderPayout;

    public String paymentMethod = "CASH";
    public String paymentStatus = "PENDING";
    public String transactionId;

    public String pickupOtp;
    public String deliveryOtp;
    public Instant pickupVerifiedAt;
    public Instant deliveryVerifiedAt;
    public String pickupCondition;               // good | damaged
    public String deliveryCondition;
    public String pickupNotes;
    public String deliveryNotes;
    public int pickupProofCount = 0;
    public int deliveryProofCount = 0;

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb")
    public List<Map<String, Object>> activities = new ArrayList<>();

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb")
    public List<Map<String, Object>> internalNotes = new ArrayList<>();
}
