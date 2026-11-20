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

/** A person-ride (taxi) booking: passenger -> captain. Shown as "Delivery/Trip" in the admin app. */
@Entity
@Table(name = "ride_bookings")
public class RideBooking extends BaseEntity {

    public enum Status { REQUESTED, ASSIGNED, IN_PROGRESS, COMPLETED, CANCELLED }

    @Version
    public long version;

    public String code;                          // TRP10245

    @Column(nullable = false)
    public UUID passengerId;
    public String passengerName;
    public String passengerPhone;
    public int passengerCount = 1;

    public UUID riderId;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    public Status status = Status.REQUESTED;

    public String pickupLabel;
    public String pickupAddress;
    public double pickupLat;
    public double pickupLng;
    public String dropLabel;
    public String dropAddress;
    public double dropLat;
    public double dropLng;

    public String vehicleType;
    public double distanceKm = 3;
    public int durationMinutes = 15;
    public String notes;
    public String promoCode;

    public double baseFare;
    public double distanceCharge;
    public double timeCharge;
    public double convenienceFee;
    public double platformFee;
    public double fare;                          // total payable
    public double riderPayout;
    public double platformCommission;

    public String paymentMethod = "CASH";
    public String paymentStatus = "PENDING";     // PENDING | PAID | FAILED
    public String transactionId;
    public Instant paidOn;

    public String startOtp;

    public String sosStatus = "NONE";            // NONE | ACTIVE | RESOLVED
    public Instant sosTriggeredAt;

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb")
    public List<Map<String, Object>> activities = new ArrayList<>();   // [{title,state,timestamp}]

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb")
    public List<Map<String, Object>> internalNotes = new ArrayList<>();// [{id,text,createdAt}]
}
