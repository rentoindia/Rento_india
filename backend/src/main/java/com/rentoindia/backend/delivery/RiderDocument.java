package com.rentoindia.backend.delivery;

import com.rentoindia.backend.common.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Table;

import java.util.UUID;

@Entity
@Table(name = "rider_documents")
public class RiderDocument extends BaseEntity {

    public enum Type { AADHAAR, DRIVING_LICENSE, VEHICLE_RC, INSURANCE, PUC, PAN_CARD, PROFILE_PHOTO }

    public enum Status { PENDING, VERIFIED, REJECTED }

    @Column(nullable = false)
    public UUID riderId;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    public Type type;

    public String documentNumber;
    public String fileUrl;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    public Status status = Status.PENDING;

    public String rejectReason;
}
