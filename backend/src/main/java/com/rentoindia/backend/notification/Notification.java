package com.rentoindia.backend.notification;

import com.rentoindia.backend.common.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

import java.util.UUID;

@Entity
@Table(name = "notifications")
public class Notification extends BaseEntity {
    @Column(nullable = false)
    public UUID userId;
    public String title;
    @Column(length = 1000)
    public String subtitle;
    public String category = "Alerts";   // Orders / Requests / Offers / Alerts
    public String icon;                  // icon key understood by the app
    public String actionType;            // e.g. rentalRequest
    public String refId;                 // id of related order/trip/...
    public boolean unread = true;
}
