package com.rentoindia.backend.rental;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface RentalOrderRepository extends JpaRepository<RentalOrder, UUID> {
    List<RentalOrder> findByCustomerIdOrderByCreatedAtDesc(UUID customerId);
    List<RentalOrder> findByLenderIdOrderByCreatedAtDesc(UUID lenderId);
    List<RentalOrder> findAllByOrderByCreatedAtDesc();
    long countByStatus(RentalOrder.Status status);
    long countByCustomerId(UUID customerId);
}
