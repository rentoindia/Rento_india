package com.rentoindia.backend.catalog;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface SubCategoryRepository extends JpaRepository<SubCategory, UUID> {
    List<SubCategory> findByCategoryIdOrderByNameAsc(UUID categoryId);
}
