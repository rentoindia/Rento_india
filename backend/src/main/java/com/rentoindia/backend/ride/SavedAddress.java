package com.rentoindia.backend.ride;

import com.rentoindia.backend.common.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

import java.util.UUID;

@Entity
@Table(name = "saved_addresses")
public class SavedAddress extends BaseEntity {
    @Column(nullable = false)
    public UUID userId;
    public String label;          // Home / Work / Other
    public String title;
    public String fullAddress;
    public String contactName;
    public String contactPhone;
    public double lat;
    public double lng;
    public boolean isDefault = false;
}
