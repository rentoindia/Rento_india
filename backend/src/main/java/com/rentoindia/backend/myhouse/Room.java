package com.rentoindia.backend.myhouse;

import com.rentoindia.backend.common.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

import java.util.UUID;

@Entity
@Table(name = "property_rooms")
public class Room extends BaseEntity {
    @Column(nullable = false)
    public UUID propertyId;
    public String name;                    // Room 101
    public String status = "VACANT";       // VACANT | OCCUPIED | MAINTENANCE
    public double rent;
    public UUID tenantId;
    public String tenantName;
}
