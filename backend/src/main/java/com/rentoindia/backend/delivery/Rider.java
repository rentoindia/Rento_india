package com.rentoindia.backend.delivery;

import com.rentoindia.backend.common.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Table;

import java.time.Instant;
import java.util.UUID;

/** Delivery partner / captain. One row per rider account (userId). */
@Entity
@Table(name = "riders")
public class Rider extends BaseEntity {

    public enum Status { PENDING, ACTIVE, INACTIVE, SUSPENDED }

    @Column(nullable = false, unique = true)
    public UUID userId;

    public String riderCode;
    public String name;
    public String phone;
    public String email;
    public String dob;
    public String address;
    public String aadhaarMasked;
    public String emergencyContact;

    public String vehicleType;
    public String vehicleNumber;
    public String brandModel;
    public String rcNumber;
    public String insuranceValidTill;

    public String bankAccountNumber;
    public String bankIfsc;
    public String deliveryZone;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    public Status status = Status.PENDING;

    public boolean online = false;
    public double lat;
    public double lng;
    public Instant lastLocationAt;

    public int totalJobs = 0;
    public int completedJobs = 0;
    public int cancelledJobs = 0;
    public double rating = 5.0;
    public double totalEarnings = 0;
    public double pendingPayout = 0;

    public String suspensionReason;
    public Instant suspendUntil;
    public String additionalNote;
    public Instant suspendedOn;
}
