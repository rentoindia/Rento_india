package com.rentoindia.backend.myhouse;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface TenancyApplicationRepository extends JpaRepository<TenancyApplication, UUID> {
    List<TenancyApplication> findByTenantIdOrderByCreatedAtDesc(UUID tenantId);
    List<TenancyApplication> findByOwnerIdOrderByCreatedAtDesc(UUID ownerId);
    List<TenancyApplication> findAllByOrderByCreatedAtDesc();
    boolean existsByPropertyIdAndTenantIdAndStatus(UUID propertyId, UUID tenantId, TenancyApplication.Status status);
    long countByStatus(TenancyApplication.Status status);
}
