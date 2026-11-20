package com.rentoindia.backend.wallet;

import com.rentoindia.backend.common.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Table;

import java.util.UUID;

@Entity
@Table(name = "wallet_transactions")
public class WalletTx extends BaseEntity {

    public enum Type { EARNED, REDEEMED, REFUND }

    @Column(nullable = false)
    public UUID userId;
    @Column(nullable = false)
    public double amount;                 // always positive; type gives the sign
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    public Type type;
    public String description;
    public String orderId;
}
