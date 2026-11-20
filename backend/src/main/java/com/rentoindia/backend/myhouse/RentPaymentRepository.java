package com.rentoindia.backend.myhouse;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface RentPaymentRepository extends JpaRepository<RentPayment, UUID> {
    List<RentPayment> findByTenantIdOrderByCreatedAtDesc(UUID tenantId);
    List<RentPayment> findByOwnerIdOrderByCreatedAtDesc(UUID ownerId);
    List<RentPayment> findAllByOrderByCreatedAtDesc();
    boolean existsByPropertyIdAndTenantIdAndMonth(UUID propertyId, UUID tenantId, String month);
}
