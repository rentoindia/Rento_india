package com.rentoindia.backend.promo;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface CouponRepository extends JpaRepository<Coupon, UUID> {
    Optional<Coupon> findByCodeIgnoreCase(String code);
    List<Coupon> findByCampaignId(UUID campaignId);
    List<Coupon> findAllByOrderByCreatedAtDesc();
}
