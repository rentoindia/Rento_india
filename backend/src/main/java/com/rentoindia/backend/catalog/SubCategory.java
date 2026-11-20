package com.rentoindia.backend.catalog;

import com.rentoindia.backend.common.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

import java.util.UUID;

@Entity
@Table(name = "sub_categories")
public class SubCategory extends BaseEntity {
    @Column(nullable = false)
    public UUID categoryId;
    @Column(nullable = false)
    public String name;
    public boolean active = true;
}
