package com.rentoindia.backend.myhouse;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface MaintenanceRequestRepository extends JpaRepository<MaintenanceRequest, UUID> {
    List<MaintenanceRequest> findByRequesterIdOrderByCreatedAtDesc(UUID requesterId);
    List<MaintenanceRequest> findByOwnerIdOrderByCreatedAtDesc(UUID ownerId);
    List<MaintenanceRequest> findAllByOrderByCreatedAtDesc();
    long countByStatus(String status);
}
