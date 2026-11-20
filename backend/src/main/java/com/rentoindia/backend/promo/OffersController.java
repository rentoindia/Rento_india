package com.rentoindia.backend.promo;

import com.rentoindia.backend.common.ApiException;
import com.rentoindia.backend.common.ApiResponse;
import com.rentoindia.backend.common.Body;
import com.rentoindia.backend.common.Obj;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;
import java.util.List;
import java.util.Map;

/** Offers/coupons shown to shoppers. GET is public; validate needs a login. */
@RestController
@RequestMapping("/api/v1/offers")
public class OffersController {

    private final CouponRepository coupons;
    private final CouponService couponService;

    public OffersController(CouponRepository coupons, CouponService couponService) {
        this.coupons = coupons;
        this.couponService = couponService;
    }

    @GetMapping
    public ApiResponse<List<Obj>> live() {
        Instant now = Instant.now();
        List<Obj> out = coupons.findAllByOrderByCreatedAtDesc().stream().filter(c -> c.isLive(now))
                .map(c -> Obj.of().with("code", c.code).with("discountLabel", c.discountLabel())
                        .with("minOrder", c.minOrder).with("description", c.description)
                        .with("validTill", c.endAt)).toList();
        return ApiResponse.ok(out);
    }

    @PostMapping("/validate")
    public ApiResponse<Obj> validate(@RequestBody Map<String, Object> b) {
        String code = Body.str(b, "code", "");
        if (code.isBlank()) throw ApiException.badRequest("Enter a coupon code");
        double discount = couponService.validate(code, Body.dbl(b, "subtotal", 0));
        return ApiResponse.ok(Obj.of().with("valid", true).with("discount", discount).with("code", code.trim().toUpperCase()));
    }
}
