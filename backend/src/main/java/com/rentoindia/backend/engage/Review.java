package com.rentoindia.backend.engage;

import com.rentoindia.backend.common.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

import java.util.UUID;

@Entity
@Table(name = "reviews")
public class Review extends BaseEntity {
    public UUID productId;
    @Column(nullable = false)
    public String productName;
    @Column(nullable = false)
    public UUID userId;
    public String userName;
    @Column(nullable = false)
    public double rating;
    public String title;
    @Column(length = 2000)
    public String comment;
}
