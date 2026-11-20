package com.rentoindia.backend.myhouse;

import com.rentoindia.backend.common.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Entity
@Table(name = "maintenance_requests")
public class MaintenanceRequest extends BaseEntity {
    public String code;                    // MT10245
    public UUID propertyId;
    public String propertyTitle;
    public String location;
    @Column(nullable = false)
    public UUID requesterId;
    public String requesterName;
    public String requesterPhone;
    public UUID ownerId;
    @Column(nullable = false)
    public String issue;                   // Electrical Issue
    public String category;                // electrical | plumbing | ac | cleaning | fan | other
    public String priority = "MEDIUM";     // HIGH | MEDIUM | LOW
    @Column(length = 2000)
    public String description;
    public String status = "OPEN";         // OPEN | ASSIGNED | IN_PROGRESS | RESOLVED | REJECTED
    public String assignedToName;
    public String assignedToPhone;
    public double cost;
    public String paymentStatus = "PENDING";   // PENDING | PAID
    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb")
    public List<String> photos = new ArrayList<>();
    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb")
    public List<Map<String, Object>> timeline = new ArrayList<>();
}
