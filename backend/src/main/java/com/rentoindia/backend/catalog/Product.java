package com.rentoindia.backend.catalog;

import com.rentoindia.backend.common.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Table;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * One product that can be rented. Created either by an admin (lenderId == null,
 * platform inventory) or by a verified lender from the user app.
 * Nested lists are stored as JSON columns to keep the schema small.
 */
@Entity
@Table(name = "products")
public class Product extends BaseEntity {

    public enum Status { ACTIVE, INACTIVE, OUT_OF_STOCK }

    public UUID lenderId;            // null = platform-owned
    public String vendorName;

    @Column(nullable = false)
    public String name;
    public String sku;
    public String category;
    public String subcategory;
    public String brand;

    public double mrp;
    @Column(nullable = false)
    public double pricePerDay;
    public double pricePerWeek;
    public double pricePerMonth;
    public double securityDeposit;

    @Column(length = 4000)
    public String description;

    public String mainImage;
    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb")
    public List<String> imageUrls = new ArrayList<>();
    public String videoUrl;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    public Status status = Status.ACTIVE;

    public boolean featured = false;

    public int totalStock = 1;
    public int availableStock = 1;
    public int rentedStock = 0;
    public int maintenanceStock = 0;

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb")
    public List<Map<String, Object>> specs = new ArrayList<>();          // [{label,value}]

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb")
    public List<Map<String, Object>> variants = new ArrayList<>();

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb")
    public List<Map<String, Object>> statusHistory = new ArrayList<>();  // [{type,timestamp,description}]

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb")
    public List<Map<String, Object>> inventoryLogs = new ArrayList<>();  // [{date,change,reason}]

    public double averageRating = 0;
    public int reviewCount = 0;
}
