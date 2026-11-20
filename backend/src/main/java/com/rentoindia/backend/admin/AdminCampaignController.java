package com.rentoindia.backend.admin;

import com.rentoindia.backend.common.ApiException;
import com.rentoindia.backend.common.ApiResponse;
import com.rentoindia.backend.common.Body;
import com.rentoindia.backend.common.Obj;
import com.rentoindia.backend.common.Times;
import com.rentoindia.backend.promo.Campaign;
import com.rentoindia.backend.promo.CampaignRepository;
import com.rentoindia.backend.promo.Coupon;
import com.rentoindia.backend.promo.CouponRepository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/admin/campaigns")
public class AdminCampaignController {

    private final CampaignRepository campaigns;
    private final CouponRepository coupons;

    public AdminCampaignController(CampaignRepository campaigns, CouponRepository coupons) {
        this.campaigns = campaigns;
        this.coupons = coupons;
    }

    private static String statusOf(Campaign c) {
        if (c.draft) return "DRAFT";
        Instant now = Instant.now();
        if (c.startAt != null && now.isBefore(c.startAt)) return "SCHEDULED";
        if (c.endAt != null && now.isAfter(c.endAt)) return "EXPIRED";
        return "ACTIVE";
    }

    private static String couponStatus(Coupon c) {
        Instant now = Instant.now();
        if (!c.active) return "INACTIVE";
        if (c.startAt != null && now.isBefore(c.startAt)) return "SCHEDULED";
        if (c.endAt != null && now.isAfter(c.endAt)) return "EXPIRED";
        return "ACTIVE";
    }

    private static Obj couponView(Coupon c) {
        return Obj.of().with("id", c.id).with("campaignId", c.campaignId).with("code", c.code)
                .with("discountLabel", c.discountLabel()).with("discountType", c.discountType)
                .with("discountValue", c.discountValue).with("maxDiscount", c.maxDiscount)
                .with("minOrder", c.minOrder).with("status", couponStatus(c)).with("startDate", c.startAt)
                .with("endDate", c.endAt).with("usedCount", c.usedCount).with("description", c.description);
    }

    private Obj view(Campaign c) {
        List<Obj> cs = coupons.findByCampaignId(c.id).stream().map(AdminCampaignController::couponView).toList();
        return Obj.of().with("id", c.id).with("name", c.name).with("status", statusOf(c))
                .with("startDate", c.startAt).with("endDate", c.endAt).with("channels", c.channels)
                .with("totalBudget", c.totalBudget).with("usedBudget", c.usedBudget)
                .with("totalImpressions", c.totalImpressions).with("totalClicks", c.totalClicks)
                .with("totalConversions", c.totalConversions).with("coupons", cs);
    }

    private Campaign load(String id) {
        return campaigns.findById(Body.parseUuid(id)).orElseThrow(() -> ApiException.notFound("Campaign not found"));
    }

    private static void apply(Campaign c, Map<String, Object> b) {
        if (Body.has(b, "name")) c.name = Body.str(b, "name", c.name);
        if (Body.has(b, "draft")) c.draft = Body.bool(b, "draft", false);
        if (Body.has(b, "startDate")) c.startAt = Times.parse(Body.str(b, "startDate"));
        if (Body.has(b, "endDate")) c.endAt = Times.parse(Body.str(b, "endDate"));
        if (Body.has(b, "channels")) c.channels = new ArrayList<>(Body.strings(b, "channels"));
        if (Body.has(b, "totalBudget")) c.totalBudget = Body.dbl(b, "totalBudget", c.totalBudget);
        if (Body.has(b, "usedBudget")) c.usedBudget = Body.dbl(b, "usedBudget", c.usedBudget);
    }

    @GetMapping
    public ApiResponse<List<Obj>> list() {
        return ApiResponse.ok(campaigns.findAllByOrderByCreatedAtDesc().stream().map(this::view).toList());
    }

    @PostMapping
    public ApiResponse<Obj> create(@RequestBody Map<String, Object> b) {
        Campaign c = new Campaign();
        apply(c, b);
        if (c.name == null || c.name.isBlank()) throw ApiException.badRequest("Campaign name is required");
        return ApiResponse.ok(view(campaigns.save(c)));
    }

    @PutMapping("/{id}")
    public ApiResponse<Obj> update(@PathVariable String id, @RequestBody Map<String, Object> b) {
        Campaign c = load(id);
        apply(c, b);
        return ApiResponse.ok(view(campaigns.save(c)));
    }

    @DeleteMapping("/{id}")
    @Transactional
    public ApiResponse<Void> delete(@PathVariable String id) {
        Campaign c = load(id);
        coupons.deleteAll(coupons.findByCampaignId(c.id));
        campaigns.delete(c);
        return ApiResponse.ok(null);
    }

    @PostMapping("/{id}/coupons")
    public ApiResponse<Obj> addCoupon(@PathVariable String id, @RequestBody Map<String, Object> b) {
        Campaign camp = load(id);
        String code = Body.str(b, "code", "").trim().toUpperCase();
        if (code.isEmpty()) throw ApiException.badRequest("Coupon code is required");
        if (coupons.findByCodeIgnoreCase(code).isPresent()) throw ApiException.conflict("Coupon code already exists");
        Coupon c = new Coupon();
        c.code = code;
        c.campaignId = camp.id;
        applyCoupon(c, b);
        if (c.startAt == null) c.startAt = camp.startAt;
        if (c.endAt == null) c.endAt = camp.endAt;
        return ApiResponse.ok(couponView(coupons.save(c)));
    }

    @PutMapping("/coupons/{id}")
    public ApiResponse<Obj> updateCoupon(@PathVariable String id, @RequestBody Map<String, Object> b) {
        Coupon c = coupons.findById(Body.parseUuid(id)).orElseThrow(() -> ApiException.notFound("Coupon not found"));
        applyCoupon(c, b);
        return ApiResponse.ok(couponView(coupons.save(c)));
    }

    @PostMapping("/coupons/{id}/toggle")
    public ApiResponse<Obj> toggleCoupon(@PathVariable String id) {
        Coupon c = coupons.findById(Body.parseUuid(id)).orElseThrow(() -> ApiException.notFound("Coupon not found"));
        c.active = !c.active;
        return ApiResponse.ok(couponView(coupons.save(c)));
    }

    private static void applyCoupon(Coupon c, Map<String, Object> b) {
        if (Body.has(b, "discountType")) c.discountType = Body.str(b, "discountType", c.discountType).toUpperCase();
        if (Body.has(b, "discountValue")) c.discountValue = Body.dbl(b, "discountValue", c.discountValue);
        if (Body.has(b, "maxDiscount")) c.maxDiscount = Body.dbl(b, "maxDiscount", c.maxDiscount);
        if (Body.has(b, "minOrder")) c.minOrder = Body.dbl(b, "minOrder", c.minOrder);
        if (Body.has(b, "startDate")) c.startAt = Times.parse(Body.str(b, "startDate"));
        if (Body.has(b, "endDate")) c.endAt = Times.parse(Body.str(b, "endDate"));
        if (Body.has(b, "active")) c.active = Body.bool(b, "active", true);
        if (Body.has(b, "description")) c.description = Body.str(b, "description");
    }
}
