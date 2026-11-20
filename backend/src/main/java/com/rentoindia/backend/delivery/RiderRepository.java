package com.rentoindia.backend.delivery;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface RiderRepository extends JpaRepository<Rider, UUID> {
    Optional<Rider> findByUserId(UUID userId);
    List<Rider> findAllByOrderByCreatedAtDesc();
    long countByStatus(Rider.Status status);
    long countByOnlineTrue();
}
