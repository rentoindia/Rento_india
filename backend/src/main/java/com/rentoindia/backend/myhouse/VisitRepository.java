package com.rentoindia.backend.myhouse;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface VisitRepository extends JpaRepository<Visit, UUID> {
    List<Visit> findByTenantIdOrderByCreatedAtDesc(UUID tenantId);
    List<Visit> findByOwnerIdOrderByCreatedAtDesc(UUID ownerId);
}
