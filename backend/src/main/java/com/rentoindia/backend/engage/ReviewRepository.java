package com.rentoindia.backend.engage;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ReviewRepository extends JpaRepository<Review, UUID> {
    List<Review> findByProductNameIgnoreCaseOrderByCreatedAtDesc(String productName);
    Optional<Review> findFirstByProductNameIgnoreCaseAndUserId(String productName, UUID userId);
    List<Review> findAllByOrderByCreatedAtDesc();
}
