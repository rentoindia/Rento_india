package com.rentoindia.backend.auth;

import com.rentoindia.backend.common.BaseEntity;
import jakarta.persistence.CollectionTable;
import jakarta.persistence.Column;
import jakarta.persistence.ElementCollection;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Table;

import java.time.Instant;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "users")
public class User extends BaseEntity {

    @Column(nullable = false, unique = true, length = 15)
    public String phone;

    @Column(unique = true)
    public String email;

    public String fullName;
    public String passwordHash;          // only set for admin accounts

    public boolean phoneVerified = false;
    public boolean blocked = false;      // admin can block a user
    public boolean verified = false;     // admin "verified" badge
    public String location;
    public String profileImageUrl;
    public double rating = 0;
    public int disputes = 0;
    public Instant lastLoginAt;

    // lender profile (rental marketplace)
    public boolean lenderVerified = false;
    public String aadhaarNumber;
    public String homeAddress;

    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name = "user_roles", joinColumns = @JoinColumn(name = "user_id"))
    @Enumerated(EnumType.STRING)
    @Column(name = "role")
    public Set<Role> roles = new HashSet<>();
}
