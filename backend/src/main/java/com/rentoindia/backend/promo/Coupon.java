package com.rentoindia.backend.promo;

import com.rentoindia.backend.common.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "coupons")
public class Coupon extends BaseEntity {
    @Column(nullable = false, unique = true)
    public String code;
    public UUID campaignId;
    public String discountType = "PERCENT";     // PERCENT | FLAT
    public double discountValue = 10;
    public double maxDiscount = 0;              // 0 = no cap (for PERCENT)
    public double minOrder = 0;
    public Instant startAt;
    public Instant endAt;
    public boolean active = true;
    public String description;
    public int usedCount = 0;

    public String discountLabel() {
        String v = discountValue == Math.floor(discountValue) ? String.valueOf((long) discountValue) : String.valueOf(discountValue);
        return "PERCENT".equals(discountType) ? v + "% OFF" : "\u20B9" + v + " OFF";
    }

    public boolean isLive(Instant now) {
        return active && (startAt == null || !now.isBefore(startAt)) && (endAt == null || !now.isAfter(endAt));
    }

    public double discountFor(double subtotal) {
        if (subtotal <= 0 || subtotal < minOrder) return 0;
        double d = "PERCENT".equals(discountType) ? subtotal * discountValue / 100.0 : discountValue;
        if ("PERCENT".equals(discountType) && maxDiscount > 0) d = Math.min(d, maxDiscount);
        return Math.min(d, subtotal);
    }
}
