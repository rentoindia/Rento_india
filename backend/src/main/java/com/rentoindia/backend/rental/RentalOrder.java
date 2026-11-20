package com.rentoindia.backend.rental;

import com.rentoindia.backend.common.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Table;
import jakarta.persistence.Version;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/** A customer's rental of one product. Drives the whole order timeline shown in both apps. */
@Entity
@Table(name = "rental_orders")
public class RentalOrder extends BaseEntity {

    /** Order of declaration = order of the timeline (CANCELLED is handled separately). */
    public enum Status {
        PLACED, VENDOR_ACCEPTED, PAYMENT_CONFIRMED, RIDER_ASSIGNED, OUT_FOR_DELIVERY, DELIVERED,
        RENTAL_ACTIVE, RETURN_SCHEDULED, RETURN_COLLECTED, COMPLETED, CANCELLED
    }

    @Version
    public long version;

    public String orderNo;                      // ORD-10245

    @Column(nullable = false)
    public UUID customerId;
    public String customerName;
    public String customerPhone;
    public String customerEmail;

    public UUID productId;
    public UUID lenderId;                       // null = platform inventory
    @Column(nullable = false)
    public String productName;
    public String categoryLabel;
    public String imageUrl;
    public String vendorName;

    public double ratePerDay;
    public double securityDeposit;
    public double deliveryFee;
    public double platformFee;
    public double pickupFee;
    public double discount;
    public String couponCode;
    public double coinsRedeemed;

    public Instant startDate;
    public Instant endDate;

    public String deliveryAddress;
    public double deliveryLat;
    public double deliveryLng;
    public Instant deliveryDate;
    public String deliverySlot;
    public Instant actualDeliveredTime;
    public Instant returnPickupDate;
    public String returnPickupSlot;

    public boolean purchaseRequested;
    public boolean availableForPurchase;
    public Double purchasePrice;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    public Status status = Status.PLACED;
    public boolean rejectedByVendor = false;
    public boolean vendorAccepted = false;      // lender (or platform) agreed to rent this out
    public boolean stockReleased = false;
    public String cancelReason;

    public String paymentMethod;
    public String paymentStatus = "PENDING";    // PENDING | PAID | FAILED | REFUNDED
    public String transactionId;
    public double paidAmount;
    public Instant paidAt;
    public double refundedAmount;

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb")
    public List<Map<String, Object>> activity = new ArrayList<>();   // [{status,title,description,timestamp}]

    /** Handover codes: the customer shows deliveryOtp to the rider, the vendor shows pickupOtp. */
    public String pickupOtp;
    public String deliveryOtp;

    // -------- derived money helpers
    public int days() {
        if (startDate == null || endDate == null) return 1;
        long d = java.time.Duration.between(startDate, endDate).toDays();
        return d <= 0 ? 1 : (int) d;
    }

    public double rentalAmount() {
        return ratePerDay * days();
    }

    /** What the customer pays at checkout (deposit is shown separately in the app). */
    public double checkoutTotal() {
        return rentalAmount() + deliveryFee + platformFee + pickupFee - discount;
    }

    public double totalAmount() {
        return checkoutTotal() + securityDeposit;
    }
}
