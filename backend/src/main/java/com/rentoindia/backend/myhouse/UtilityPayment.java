package com.rentoindia.backend.myhouse;

import com.rentoindia.backend.common.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

import java.time.Instant;
import java.util.UUID;

/** Electricity / water / gas bill paid from the app (BBPS integration plugs in here later). */
@Entity
@Table(name = "utility_payments")
public class UtilityPayment extends BaseEntity {
    @Column(nullable = false)
    public UUID userId;
    public String category;                // Electricity | Water | Gas ...
    public String provider;                // e.g. TNEB, Indane Gas
    public String accountNumber;
    @Column(nullable = false)
    public double amount;
    public String status = "PAID";
    public String method;
    public String transactionId;
    public Instant paidAt;
}
