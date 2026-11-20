package com.rentoindia.backend.catalog;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface CategoryRepository extends JpaRepository<Category, UUID> {
    List<Category> findAllByOrderBySortOrderAscNameAsc();
    List<Category> findByActiveTrueOrderBySortOrderAscNameAsc();
    Optional<Category> findByNameIgnoreCase(String name);
}
