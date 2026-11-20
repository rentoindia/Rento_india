package com.rentoindia.backend.ride;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Collection;
import java.util.List;
import java.util.UUID;

public interface RideBookingRepository extends JpaRepository<RideBooking, UUID> {
    List<RideBooking> findByPassengerIdOrderByCreatedAtDesc(UUID passengerId);
    List<RideBooking> findByStatusOrderByCreatedAtAsc(RideBooking.Status status);
    List<RideBooking> findByRiderIdOrderByCreatedAtDesc(UUID riderId);
    List<RideBooking> findByRiderIdAndStatusIn(UUID riderId, Collection<RideBooking.Status> statuses);
    List<RideBooking> findAllByOrderByCreatedAtDesc();
    long countByStatus(RideBooking.Status status);
    long countBySosStatus(String sosStatus);
}
