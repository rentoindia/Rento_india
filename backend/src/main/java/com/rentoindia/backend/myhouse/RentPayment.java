package com.rentoindia.backend.myhouse;

import com.rentoindia.backend.common.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "rent_payments")
public class RentPayment extends BaseEntity {
    @Column(nullable = false)
    public UUID propertyId;
    public String propertyTitle;
    @Column(nullable = false)
    public UUID tenantId;
    public String tenantName;
    public UUID ownerId;
    public String month;                   // 2026-09
    @Column(nullable = false)
    public double amount;
    public String status = "PAID";
    public String method;
    public String transactionId;
    public Instant paidAt;
}
