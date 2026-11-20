package com.rentoindia.backend.promo;

import com.rentoindia.backend.common.ApiException;
import org.springframework.stereotype.Service;

import java.time.Instant;

@Service
public class CouponService {

    private final CouponRepository coupons;

    public CouponService(CouponRepository coupons) {
        this.coupons = coupons;
    }

    /** Returns the discount in rupees, or throws a 400 with a user-friendly reason. */
    public double validate(String code, double subtotal) {
        Coupon c = coupons.findByCodeIgnoreCase(code.trim())
                .orElseThrow(() -> ApiException.badRequest("Invalid coupon code"));
        if (!c.isLive(Instant.now())) throw ApiException.badRequest("This coupon is not active");
        if (subtotal < c.minOrder) {
            throw ApiException.badRequest("Minimum order value for this coupon is \u20B9" + (long) c.minOrder);
        }
        return c.discountFor(subtotal);
    }

    public void markUsed(String code) {
        coupons.findByCodeIgnoreCase(code.trim()).ifPresent(c -> {
            c.usedCount++;
            coupons.save(c);
        });
    }
}
