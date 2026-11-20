package com.rentoindia.backend.catalog;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface BrandRepository extends JpaRepository<Brand, UUID> {
    List<Brand> findAllByOrderByNameAsc();
    List<Brand> findByActiveTrueOrderByNameAsc();
    Optional<Brand> findByNameIgnoreCase(String name);
}
