package com.rentoindia.backend.delivery;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Collection;
import java.util.List;
import java.util.UUID;

public interface TripRepository extends JpaRepository<Trip, UUID> {
    List<Trip> findByStatusOrderByCreatedAtAsc(Trip.Status status);
    List<Trip> findByRiderIdOrderByCreatedAtDesc(UUID riderId);
    List<Trip> findByOrderIdOrderByCreatedAtDesc(UUID orderId);
    List<Trip> findByRiderIdAndStatusIn(UUID riderId, Collection<Trip.Status> statuses);
}
