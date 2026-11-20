package com.rentoindia.backend.auth;

import com.rentoindia.backend.common.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

import java.time.Instant;

@Entity
@Table(name = "otp_codes")
public class OtpCode extends BaseEntity {

    @Column(nullable = false, length = 15)
    public String phone;

    @Column(nullable = false, length = 8)
    public String code;

    @Column(nullable = false)
    public Instant expiresAt;

    public boolean used = false;
    public int attemptCount = 0;
}
