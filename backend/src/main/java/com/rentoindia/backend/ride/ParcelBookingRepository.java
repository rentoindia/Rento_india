package com.rentoindia.backend.ride;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Collection;
import java.util.List;
import java.util.UUID;

public interface ParcelBookingRepository extends JpaRepository<ParcelBooking, UUID> {
    List<ParcelBooking> findBySenderIdOrderByCreatedAtDesc(UUID senderId);
    List<ParcelBooking> findByStatusOrderByCreatedAtAsc(ParcelBooking.Status status);
    List<ParcelBooking> findByRiderIdOrderByCreatedAtDesc(UUID riderId);
    List<ParcelBooking> findByRiderIdAndStatusIn(UUID riderId, Collection<ParcelBooking.Status> statuses);
    List<ParcelBooking> findAllByOrderByCreatedAtDesc();
    long countByStatus(ParcelBooking.Status status);
}
