package com.rentoindia.backend.myhouse;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface UtilityPaymentRepository extends JpaRepository<UtilityPayment, UUID> {
    List<UtilityPayment> findByUserIdOrderByCreatedAtDesc(UUID userId);
    List<UtilityPayment> findAllByOrderByCreatedAtDesc();
}
