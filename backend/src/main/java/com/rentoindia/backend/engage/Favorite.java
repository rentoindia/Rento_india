package com.rentoindia.backend.engage;

import com.rentoindia.backend.common.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.UUID;

/** Wishlist entry. The whole card the app shows is kept in `data` so any screen can restore it. */
@Entity
@Table(name = "favorites")
public class Favorite extends BaseEntity {
    @Column(nullable = false)
    public UUID userId;
    @Column(nullable = false)
    public String productName;
    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb")
    public Map<String, Object> data = new LinkedHashMap<>();
}
