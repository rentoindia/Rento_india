package com.rentoindia.backend.myhouse;

import com.rentoindia.backend.common.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "property_visits")
public class Visit extends BaseEntity {
    @Column(nullable = false)
    public UUID propertyId;
    public String propertyTitle;
    @Column(nullable = false)
    public UUID tenantId;
    public String tenantName;
    public UUID ownerId;
    public Instant visitDate;
    public String slot;
    public String status = "REQUESTED";    // REQUESTED | CONFIRMED | COMPLETED | CANCELLED
}
