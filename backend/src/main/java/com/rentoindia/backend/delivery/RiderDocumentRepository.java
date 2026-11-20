package com.rentoindia.backend.delivery;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface RiderDocumentRepository extends JpaRepository<RiderDocument, UUID> {
    List<RiderDocument> findByRiderIdOrderByCreatedAtDesc(UUID riderId);
    Optional<RiderDocument> findFirstByRiderIdAndType(UUID riderId, RiderDocument.Type type);
    List<RiderDocument> findAllByOrderByCreatedAtDesc();
}
