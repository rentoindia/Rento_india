package com.rentoindia.backend.myhouse;

import com.rentoindia.backend.common.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Table;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/** A house / flat listed by an owner. Becomes visible to tenants once an admin approves it. */
@Entity
@Table(name = "properties")
public class Property extends BaseEntity {

    public enum Status { PENDING, APPROVED, REJECTED }

    @Column(nullable = false)
    public UUID ownerId;
    public String ownerName;
    public String ownerPhone;

    public String code;                    // #PRPR25456
    @Column(nullable = false)
    public String title;
    public String bhk;                     // 1 BHK / 2 BHK / Studio
    public String propertyType;            // Apartment / Independent House / PG
    public String addressLine;
    public String locality;
    public String city;
    public String state;
    public String pincode;
    public double lat;
    public double lng;

    public double monthlyRent;
    public double securityDeposit;
    public double maintenanceCharge;
    public String furnishing;              // Furnished / Semi-Furnished / Unfurnished
    public String suitableFor;             // Family / Bachelor / Girls Only
    public double areaSqft;
    public int totalUnits = 1;
    public int availableUnits = 1;

    @Column(length = 3000)
    public String description;

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb")
    public List<String> images = new ArrayList<>();

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb")
    public List<String> facilities = new ArrayList<>();

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb")
    public Map<String, Object> details = new LinkedHashMap<>();   // anything else the owner form collects

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    public Status status = Status.PENDING;
    public String rejectReason;
}
