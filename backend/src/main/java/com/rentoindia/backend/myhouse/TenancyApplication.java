package com.rentoindia.backend.myhouse;

import com.rentoindia.backend.common.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Table;

import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "tenancy_applications")
public class TenancyApplication extends BaseEntity {

    public enum Status { PENDING, APPROVED, REJECTED, WITHDRAWN }

    @Column(nullable = false)
    public UUID propertyId;
    public String propertyTitle;
    @Column(nullable = false)
    public UUID tenantId;
    public String tenantName;
    public String tenantPhone;
    public UUID ownerId;
    public Instant moveInDate;
    public int occupants = 1;
    @Column(length = 1000)
    public String message;
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    public Status status = Status.PENDING;
    public String decisionNote;
}
