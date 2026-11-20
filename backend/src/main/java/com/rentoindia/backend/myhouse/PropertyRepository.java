package com.rentoindia.backend.myhouse;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.UUID;

public interface PropertyRepository extends JpaRepository<Property, UUID> {

    /** Tenant search. Pass "" (never null) for text filters; minRent 0 and maxRent Double.MAX_VALUE mean "no limit". */
    @Query("select p from Property p where p.status = :status "
            + "and (:city = '' or lower(p.city) = lower(:city)) "
            + "and (:locality = '' or lower(p.locality) = lower(:locality)) "
            + "and (:bhk = '' or p.bhk = :bhk) "
            + "and (:furnishing = '' or p.furnishing = :furnishing) "
            + "and (:suitableFor = '' or p.suitableFor = :suitableFor) "
            + "and p.monthlyRent >= :minRent "
            + "and p.monthlyRent <= :maxRent "
            + "and (:q = '' or lower(p.title) like lower(concat('%', :q, '%')) "
            + "     or lower(p.locality) like lower(concat('%', :q, '%')))")
    Page<Property> search(@Param("status") Property.Status status, @Param("city") String city,
                          @Param("locality") String locality, @Param("bhk") String bhk,
                          @Param("furnishing") String furnishing, @Param("suitableFor") String suitableFor,
                          @Param("minRent") double minRent, @Param("maxRent") double maxRent,
                          @Param("q") String q, Pageable pageable);

    List<Property> findByOwnerIdOrderByCreatedAtDesc(UUID ownerId);

    List<Property> findAllByOrderByCreatedAtDesc();

    long countByStatus(Property.Status status);
}
