package com.rentoindia.backend.promo;

import com.rentoindia.backend.common.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "campaigns")
public class Campaign extends BaseEntity {
    @Column(nullable = false)
    public String name;
    public boolean draft = false;
    public Instant startAt;
    public Instant endAt;
    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb")
    public List<String> channels = new ArrayList<>();
    public double totalBudget;
    public double usedBudget;
    public int totalImpressions;
    public int totalClicks;
    public int totalConversions;
}
