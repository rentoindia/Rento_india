package com.rentoindia.backend.catalog;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ProductRepository extends JpaRepository<Product, UUID> {

    /** Filters by status + optional category/subcategory/text. Pass "" (never null) for "no filter". */
    @Query("select p from Product p where p.status = :status "
            + "and (:category = '' or p.category = :category) "
            + "and (:sub = '' or p.subcategory = :sub) "
            + "and (:q = '' or lower(p.name) like lower(concat('%', :q, '%')))")
    Page<Product> searchByStatus(@Param("status") Product.Status status, @Param("category") String category,
                                 @Param("sub") String sub, @Param("q") String q, Pageable pageable);

    /** Any status. */
    @Query("select p from Product p where "
            + "(:category = '' or p.category = :category) "
            + "and (:q = '' or lower(p.name) like lower(concat('%', :q, '%')))")
    Page<Product> searchAny(@Param("category") String category, @Param("q") String q, Pageable pageable);

    default Page<Product> searchActive(String category, String sub, String q, Pageable pageable) {
        return searchByStatus(Product.Status.ACTIVE, category, sub, q, pageable);
    }

    List<Product> findByFeaturedTrueAndStatusOrderByCreatedAtDesc(Product.Status status);

    List<Product> findByLenderIdOrderByCreatedAtDesc(UUID lenderId);

    Optional<Product> findFirstByNameIgnoreCase(String name);

    long countByCategory(String category);

    long countByBrand(String brand);

    long countByStatus(Product.Status status);
}
