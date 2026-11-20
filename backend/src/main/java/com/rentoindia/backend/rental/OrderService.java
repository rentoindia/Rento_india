package com.rentoindia.backend.rental;

import com.rentoindia.backend.auth.User;
import com.rentoindia.backend.auth.UserRepository;
import com.rentoindia.backend.catalog.Product;
import com.rentoindia.backend.catalog.ProductRepository;
import com.rentoindia.backend.catalog.ProductService;
import com.rentoindia.backend.common.ApiException;
import com.rentoindia.backend.common.Body;
import com.rentoindia.backend.common.Obj;
import com.rentoindia.backend.common.Times;
import com.rentoindia.backend.delivery.JobViews;
import com.rentoindia.backend.delivery.Pricing;
import com.rentoindia.backend.delivery.Trip;
import com.rentoindia.backend.delivery.TripRepository;
import com.rentoindia.backend.notification.NotificationService;
import com.rentoindia.backend.payment.PaymentService;
import com.rentoindia.backend.promo.CouponService;
import com.rentoindia.backend.realtime.EventHub;
import com.rentoindia.backend.wallet.WalletService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.SecureRandom;
import java.time.Instant;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import static com.rentoindia.backend.rental.RentalOrder.Status;

@Service
public class OrderService {

    public enum Audience { CUSTOMER, LENDER, ADMIN, PUBLIC }

    private static final SecureRandom RANDOM = new SecureRandom();

    @org.springframework.beans.factory.annotation.Value("${app.wallet.cashback-percent:100}")
    private double cashbackPercent;

    private final RentalOrderRepository orders;
    private final ProductRepository products;
    private final ProductService productService;
    private final UserRepository users;
    private final TripRepository trips;
    private final WalletService wallet;
    private final NotificationService notifications;
    private final CouponService coupons;
    private final PaymentService payments;
    private final EventHub hub;

    public OrderService(RentalOrderRepository orders, ProductRepository products, ProductService productService,
                        UserRepository users, TripRepository trips, WalletService wallet,
                        NotificationService notifications, CouponService coupons, PaymentService payments,
                        EventHub hub) {
        this.orders = orders;
        this.products = products;
        this.productService = productService;
        this.users = users;
        this.trips = trips;
        this.wallet = wallet;
        this.notifications = notifications;
        this.coupons = coupons;
        this.payments = payments;
        this.hub = hub;
    }

    public RentalOrder get(UUID id) {
        return orders.findById(id).orElseThrow(() -> ApiException.notFound("Order not found"));
    }

    private static String otp() {
        return String.format("%04d", RANDOM.nextInt(10000));
    }

    // ===================================================================== create

    @Transactional
    public RentalOrder create(UUID customerId, Map<String, Object> b) {
        User customer = users.findById(customerId).orElseThrow(() -> ApiException.unauthorized("Login required"));

        Product p = null;
        UUID pid = Body.uuid(b, "productId");
        if (pid != null) p = products.findById(pid).orElse(null);
        String name = Body.str(b, "productName", Body.str(b, "name"));
        if (p == null && name != null && !name.isBlank()) p = products.findFirstByNameIgnoreCase(name.trim()).orElse(null);
        if (p == null && (name == null || name.isBlank())) throw ApiException.badRequest("productName is required");

        RentalOrder o = new RentalOrder();
        o.orderNo = String.format("ORD-%06d", 100000 + RANDOM.nextInt(900000));
        o.customerId = customerId;
        o.customerName = customer.fullName == null || customer.fullName.isBlank() ? "Customer" : customer.fullName;
        o.customerPhone = customer.phone;
        o.customerEmail = customer.email;

        if (p != null) {
            if (p.status != Product.Status.ACTIVE) throw ApiException.badRequest("This product is currently unavailable");
            if (p.availableStock < 1) throw ApiException.badRequest("This product is out of stock right now");
            p.availableStock--;
            p.rentedStock++;
            if (p.availableStock == 0) {
                p.status = Product.Status.OUT_OF_STOCK;
                productService.history(p, "OUT_OF_STOCK", "All units rented out");
            }
            products.save(p);
            o.productId = p.id;
            o.lenderId = p.lenderId;
            o.productName = p.name;
            o.categoryLabel = p.category;
            o.imageUrl = p.mainImage;
            o.vendorName = p.vendorName == null || p.vendorName.isBlank() ? "RENTO India" : p.vendorName;
            o.ratePerDay = p.pricePerDay;
            o.securityDeposit = p.securityDeposit;
        } else {
            // item is not in the database (older app catalog) - trust the values sent by the app
            o.productName = name.trim();
            o.categoryLabel = Body.str(b, "categoryLabel", "");
            o.imageUrl = Body.str(b, "imageUrl");
            o.vendorName = Body.str(b, "vendorName", "RENTO India");
            o.ratePerDay = Math.max(0, Body.dbl(b, "ratePerDay", 0));
            o.securityDeposit = Math.max(0, Body.dbl(b, "securityDeposit", 0));
        }

        Instant now = Instant.now();
        o.startDate = Times.parse(Body.str(b, "startDate"));
        if (o.startDate == null) o.startDate = now;
        o.endDate = Times.parse(Body.str(b, "endDate"));
        if (o.endDate == null) o.endDate = o.startDate.plusSeconds(86400);
        if (!o.endDate.isAfter(o.startDate)) throw ApiException.badRequest("End date must be after the start date");

        o.deliveryFee = Math.max(0, Body.dbl(b, "deliveryFee", 120));
        o.platformFee = Math.max(0, Body.dbl(b, "platformFee", 40));
        o.pickupFee = Math.max(0, Body.dbl(b, "pickupFee", 100));
        o.deliveryAddress = Body.str(b, "deliveryAddress", "");
        o.deliveryLat = Body.dbl(b, "deliveryLat", 0);
        o.deliveryLng = Body.dbl(b, "deliveryLng", 0);
        o.deliveryDate = Times.parse(Body.str(b, "deliveryDate"));
        o.deliverySlot = Body.str(b, "deliverySlot");
        o.purchaseRequested = Body.bool(b, "purchaseRequested", false);
        o.availableForPurchase = Body.bool(b, "isAvailableForPurchase", false);
        if (Body.has(b, "purchasePrice")) o.purchasePrice = Body.dbl(b, "purchasePrice", 0);

        double discount = 0;
        String code = Body.str(b, "couponCode");
        if (code != null && !code.isBlank()) {
            discount += coupons.validate(code, o.rentalAmount());
            o.couponCode = code.trim().toUpperCase();
            coupons.markUsed(code);
        }
        o.discount = discount;
        o.pickupOtp = otp();
        o.deliveryOtp = otp();

        boolean platformOwned = o.lenderId == null;
        o.vendorAccepted = platformOwned;
        o.status = platformOwned ? Status.VENDOR_ACCEPTED : Status.PLACED;
        addActivity(o, Status.PLACED, "Order Placed", "Order placed by " + o.customerName);
        if (platformOwned) addActivity(o, Status.VENDOR_ACCEPTED, "Vendor Accepted", o.vendorName + " accepted the order");

        o = orders.save(o);

        double coins = Body.dbl(b, "coinsToRedeem", 0);
        if (coins > 0) {
            double used = wallet.redeem(customerId, coins, "Coins used on order " + o.orderNo, o.id.toString());
            if (used > 0) {
                o.coinsRedeemed = used;
                o.discount += used;
                o = orders.save(o);
            }
        }

        notifications.notify(customerId, "Order Placed",
                "Your order " + o.orderNo + " for " + o.productName + " has been placed.",
                "Orders", "check", null, o.id.toString());
        if (o.lenderId != null) {
            notifications.notify(o.lenderId, "New Rental Request",
                    o.customerName + " wants to rent your " + o.productName + ".",
                    "Requests", "inbox", "rentalRequest", o.id.toString());
        }
        hub.toAdmins("order.created", view(o, Audience.ADMIN));
        publish(o);
        return o;
    }

    // =============================================================== lender decision

    @Transactional
    public RentalOrder respond(RentalOrder o, UUID lenderId, boolean accept, String reason) {
        if (o.lenderId == null || !o.lenderId.equals(lenderId)) throw ApiException.forbidden("This is not your request");
        if (o.vendorAccepted || o.status == Status.CANCELLED) throw ApiException.conflict("This request was already answered");
        if (accept) {
            o.vendorAccepted = true;
            if (o.status == Status.PLACED) o.status = Status.VENDOR_ACCEPTED;
            addActivity(o, Status.VENDOR_ACCEPTED, "Vendor Accepted", o.vendorName + " accepted the request");
            o = orders.save(o);
            notifications.notify(o.customerId, "Request Accepted",
                    o.vendorName + " accepted your request for " + o.productName + ".",
                    "Orders", "check", null, o.id.toString());
            if ("PAID".equals(o.paymentStatus)) createTrip(o, Trip.Type.DELIVERY);   // already paid -> send a rider now
            publish(o);
            return o;
        }
        o.rejectedByVendor = true;
        String why = reason == null || reason.isBlank() ? "Declined by the vendor" : reason;
        notifications.notify(o.customerId, "Request Declined",
                o.vendorName + " could not accept your request for " + o.productName + ". Any payment is refunded.",
                "Orders", "cancel", null, o.id.toString());
        return cancel(o, why, "vendor");
    }

    // ===================================================================== payment

    @Transactional
    public RentalOrder pay(RentalOrder o, Map<String, Object> b) {
        if (o.status == Status.CANCELLED) throw ApiException.badRequest("This order was cancelled");
        if (o.status.ordinal() >= Status.PAYMENT_CONFIRMED.ordinal()) return o;     // already paid -> idempotent
        if ("PAID".equals(o.paymentStatus)) return o;

        String method = Body.str(b, "paymentMethod", "UPI");
        boolean cash = method.equalsIgnoreCase("COD") || method.equalsIgnoreCase("CASH");
        if (payments.configured() && !cash) {
            boolean ok = payments.verifySignature(Body.str(b, "razorpayOrderId"), Body.str(b, "razorpayPaymentId"),
                    Body.str(b, "razorpaySignature"));
            if (!ok) throw ApiException.badRequest("Payment could not be verified");
        }
        o.paymentMethod = method;
        o.transactionId = Body.str(b, "transactionId", Body.str(b, "razorpayPaymentId",
                "TXN" + System.currentTimeMillis()));
        double coins = Body.dbl(b, "coinsToRedeem", 0);
        if (coins > 0) {
            double used = wallet.redeem(o.customerId, coins, "Coins used on order " + o.orderNo, o.id.toString());
            o.coinsRedeemed += used;
        }
        double amount = Body.dbl(b, "amount", 0);
        o.paymentStatus = "PAID";
        o.paidAmount = amount > 0 ? amount : Math.max(0, o.totalAmount() - o.coinsRedeemed);
        o.paidAt = Instant.now();
        o.status = Status.PAYMENT_CONFIRMED;
        addActivity(o, Status.PAYMENT_CONFIRMED, "Payment Confirmed", "Payment of \u20B9" + Math.round(o.paidAmount) + " received");
        o = orders.save(o);

        double cashback = Math.floor(o.rentalAmount() * cashbackPercent / 100.0);
        if (cashback > 0) wallet.earn(o.customerId, cashback, "Cashback on order " + o.orderNo, o.id.toString());

        if (o.vendorAccepted) createTrip(o, Trip.Type.DELIVERY);      // lender-owned items wait for the lender's OK

        notifications.notify(o.customerId, "Payment Successful",
                "Payment of \u20B9" + Math.round(o.paidAmount) + " for order " + o.orderNo + " succeeded.",
                "Orders", "payments", null, o.id.toString());
        if (o.lenderId != null) {
            notifications.notify(o.lenderId, "Payment Received",
                    o.customerName + " paid for " + o.productName + (o.vendorAccepted ? ". A rider will pick it up soon." : ". Please accept the request."),
                    "Orders", "payments", null, o.id.toString());
        }
        publish(o);
        return o;
    }

    // =========================================================== customer actions

    /** Customer sets the order live once the item has been handed over. */
    @Transactional
    public RentalOrder markRentalActive(RentalOrder o) {
        if (o.status != Status.DELIVERED) throw ApiException.badRequest("The item has not been delivered yet");
        return system(o, Status.RENTAL_ACTIVE, "Rental Active", "Rental period started");
    }

    @Transactional
    public RentalOrder scheduleReturn(RentalOrder o, Instant date, String slot) {
        if (o.status != Status.DELIVERED && o.status != Status.RENTAL_ACTIVE) {
            throw ApiException.badRequest("Return can be scheduled once the item is delivered");
        }
        o.returnPickupDate = date == null ? Instant.now().plusSeconds(86400) : date;
        o.returnPickupSlot = slot;
        o.status = Status.RETURN_SCHEDULED;
        addActivity(o, Status.RETURN_SCHEDULED, "Return Scheduled", "Pickup scheduled" + (slot == null ? "" : " (" + slot + ")"));
        o = orders.save(o);
        createTrip(o, Trip.Type.RETURN_PICKUP);
        notifications.notify(o.customerId, "Return Scheduled", "Pickup for " + o.productName + " is scheduled.",
                "Orders", "event", null, o.id.toString());
        if (o.lenderId != null) {
            notifications.notify(o.lenderId, "Return Scheduled", o.customerName + " scheduled the return of " + o.productName + ".",
                    "Orders", "event", null, o.id.toString());
        }
        publish(o);
        return o;
    }

    /** Customer edits things that can still change (delivery slot/address, purchase request). */
    @Transactional
    public RentalOrder updateDetails(RentalOrder o, Map<String, Object> b) {
        if (Body.has(b, "deliverySlot")) o.deliverySlot = Body.str(b, "deliverySlot");
        if (Body.has(b, "deliveryDate")) o.deliveryDate = Times.parse(Body.str(b, "deliveryDate"));
        if (Body.has(b, "deliveryAddress") && o.status.ordinal() < Status.OUT_FOR_DELIVERY.ordinal()) {
            o.deliveryAddress = Body.str(b, "deliveryAddress", o.deliveryAddress);
        }
        if (Body.has(b, "purchaseRequested")) o.purchaseRequested = Body.bool(b, "purchaseRequested", false);
        if (Body.has(b, "purchasePrice")) o.purchasePrice = Body.dbl(b, "purchasePrice", 0);
        if (Body.has(b, "isAvailableForPurchase")) o.availableForPurchase = Body.bool(b, "isAvailableForPurchase", false);
        o = orders.save(o);
        publish(o);
        return o;
    }

    @Transactional
    public RentalOrder cancel(RentalOrder o, String reason, String byWho) {
        if (o.status == Status.CANCELLED) return o;
        if (o.status.ordinal() >= Status.OUT_FOR_DELIVERY.ordinal()) {
            throw ApiException.badRequest("This order is already on its way and can no longer be cancelled");
        }
        o.status = Status.CANCELLED;
        o.cancelReason = reason == null || reason.isBlank() ? "Cancelled by " + byWho : reason;
        addActivity(o, Status.CANCELLED, "Order Cancelled", o.cancelReason);
        releaseStock(o);
        if ("PAID".equals(o.paymentStatus)) {
            o.paymentStatus = "REFUNDED";
            o.refundedAmount = o.paidAmount;
            wallet.refund(o.customerId, o.paidAmount, "Refund for cancelled order " + o.orderNo, o.id.toString());
        }
        o = orders.save(o);
        for (Trip t : trips.findByOrderIdOrderByCreatedAtDesc(o.id)) {
            if (t.status == Trip.Status.REQUESTED || t.status == Trip.Status.ACCEPTED) {
                t.status = Trip.Status.CANCELLED;
                trips.save(t);
                hub.toRiders("dispatch.cancelled", Obj.of().with("kind", "TRIP").with("id", t.id));
                if (t.riderId != null) hub.toUser(t.riderId, "dispatch.cancelled", Obj.of().with("kind", "TRIP").with("id", t.id));
            }
        }
        notifications.notify(o.customerId, "Order Cancelled", "Order " + o.orderNo + " was cancelled.",
                "Orders", "cancel", null, o.id.toString());
        publish(o);
        return o;
    }

    // =============================================== lender / admin / rider driven

    @Transactional
    public RentalOrder complete(RentalOrder o) {
        if (o.status == Status.COMPLETED) return o;
        if (o.status.ordinal() < Status.DELIVERED.ordinal() || o.status == Status.CANCELLED) {
            throw ApiException.badRequest("This order cannot be completed yet");
        }
        o.status = Status.COMPLETED;
        addActivity(o, Status.COMPLETED, "Order Completed", "Rental completed");
        releaseStock(o);
        o = orders.save(o);
        if (o.securityDeposit > 0) {
            wallet.refund(o.customerId, o.securityDeposit, "Security deposit refund - " + o.orderNo, o.id.toString());
        }
        notifications.notify(o.customerId, "Rental Completed",
                "Your deposit of \u20B9" + Math.round(o.securityDeposit) + " has been refunded to your wallet.",
                "Orders", "check", null, o.id.toString());
        publish(o);
        return o;
    }

    /** Generic system/admin status change (rider events, admin override). */
    @Transactional
    public RentalOrder system(RentalOrder o, Status s, String title, String description) {
        if (o.status == s) return o;
        if (s != Status.CANCELLED && s.ordinal() < o.status.ordinal()) return o;   // never go backwards
        o.status = s;
        if (s == Status.DELIVERED) o.actualDeliveredTime = Instant.now();
        addActivity(o, s, title, description);
        if (s == Status.RETURN_COLLECTED) releaseStock(o);
        o = orders.save(o);
        notifications.notify(o.customerId, title, description + " (" + o.orderNo + ")", "Orders", "local_shipping", null, o.id.toString());
        publish(o);
        // item is back with us: close the rental and refund the deposit
        if (s == Status.RETURN_COLLECTED) return complete(o);
        return o;
    }

    /** Customer extends an active rental. The extra days are charged at the same daily rate. */
    @Transactional
    public RentalOrder extend(RentalOrder o, Instant newEnd) {
        if (o.status != Status.DELIVERED && o.status != Status.RENTAL_ACTIVE) {
            throw ApiException.badRequest("Only an active rental can be extended");
        }
        if (newEnd == null || !newEnd.isAfter(o.endDate)) throw ApiException.badRequest("Pick a date after the current end date");
        long extraDays = Math.max(1, java.time.Duration.between(o.endDate, newEnd).toDays());
        double extra = extraDays * o.ratePerDay;
        o.endDate = newEnd;
        o.paidAmount += extra;
        o.status = Status.RENTAL_ACTIVE;
        addActivity(o, Status.RENTAL_ACTIVE, "Rental Extended", "Extended by " + extraDays + " day(s) - \u20B9" + Math.round(extra));
        o = orders.save(o);
        notifications.notify(o.customerId, "Rental extended", o.productName + " is now due on " + newEnd.toString().substring(0, 10) + ".",
                "Orders", "event", null, o.id.toString());
        if (o.lenderId != null) {
            notifications.notify(o.lenderId, "Rental extended", o.customerName + " extended " + o.productName + ".",
                    "Orders", "event", null, o.id.toString());
        }
        publish(o);
        return o;
    }

    /** Customer buys the rented item instead of returning it. */
    @Transactional
    public RentalOrder purchase(RentalOrder o) {
        if (!o.availableForPurchase) throw ApiException.badRequest("This item is not available for purchase");
        if (o.status != Status.DELIVERED && o.status != Status.RENTAL_ACTIVE) {
            throw ApiException.badRequest("You can buy the item once it has been delivered");
        }
        double price = o.purchasePrice == null ? 0 : o.purchasePrice;
        o.status = Status.COMPLETED;
        o.paidAmount += price;
        addActivity(o, Status.COMPLETED, "Item Purchased", "Purchased for \u20B9" + Math.round(price));
        o.stockReleased = true;      // the unit is sold, it does NOT go back to stock
        o = orders.save(o);
        if (o.productId != null) {
            products.findById(o.productId).ifPresent(p -> {
                p.rentedStock = Math.max(0, p.rentedStock - 1);
                p.totalStock = Math.max(0, p.totalStock - 1);
                products.save(p);
            });
        }
        notifications.notify(o.customerId, "Purchase complete", "You bought " + o.productName + ".",
                "Orders", "check", null, o.id.toString());
        if (o.lenderId != null) {
            notifications.notify(o.lenderId, "Item sold", o.customerName + " bought " + o.productName + ".",
                    "Orders", "payments", null, o.id.toString());
        }
        publish(o);
        return o;
    }

    // ================================================================== internals

    private void releaseStock(RentalOrder o) {
        if (o.stockReleased || o.productId == null) return;
        products.findById(o.productId).ifPresent(p -> {
            p.availableStock = p.availableStock + 1;
            p.rentedStock = Math.max(0, p.rentedStock - 1);
            if (p.status == Product.Status.OUT_OF_STOCK) p.status = Product.Status.ACTIVE;
            products.save(p);
        });
        o.stockReleased = true;
    }

    private void addActivity(RentalOrder o, Status s, String title, String description) {
        Map<String, Object> e = new LinkedHashMap<>();
        e.put("status", s.name());
        e.put("title", title);
        e.put("description", description);
        e.put("timestamp", Instant.now().toString());
        List<Map<String, Object>> list = new ArrayList<>(o.activity);
        list.add(e);
        o.activity = list;
    }

    private void createTrip(RentalOrder o, Trip.Type type) {
        User lender = o.lenderId == null ? null : users.findById(o.lenderId).orElse(null);
        String vendorAddress = lender != null && lender.homeAddress != null && !lender.homeAddress.isBlank()
                ? lender.homeAddress : "RENTO India Hub";
        Trip t = new Trip();
        t.orderId = o.id;
        t.type = type;
        t.customerId = o.customerId;
        t.itemName = o.productName;
        t.category = o.categoryLabel;
        t.imageUrl = o.imageUrl;
        t.customerPhone = o.customerPhone;
        double km = 4.0;
        if (type == Trip.Type.DELIVERY) {
            t.pickupLabel = o.vendorName;
            t.pickupAddress = vendorAddress;
            t.dropLabel = o.customerName;
            t.dropAddress = o.deliveryAddress;
            t.dropLat = o.deliveryLat;
            t.dropLng = o.deliveryLng;
            t.pickupOtp = o.pickupOtp;      // vendor hands over
            t.dropOtp = o.deliveryOtp;      // customer receives
        } else {
            t.pickupLabel = o.customerName;
            t.pickupAddress = o.deliveryAddress;
            t.pickupLat = o.deliveryLat;
            t.pickupLng = o.deliveryLng;
            t.dropLabel = o.vendorName;
            t.dropAddress = vendorAddress;
            t.pickupOtp = o.deliveryOtp;    // customer hands back
            t.dropOtp = o.pickupOtp;        // vendor receives
        }
        double calc = Pricing.haversineKm(t.pickupLat, t.pickupLng, t.dropLat, t.dropLng);
        if (calc > 0) km = Pricing.round2(calc);
        t.distanceKm = km;
        t.estimatedMinutes = Pricing.minutesFor(km);
        t.earnings = Pricing.tripEarnings(km);
        t.priority = "ACTIVE NOW";
        t = trips.save(t);
        hub.toRiders("dispatch.new", JobViews.trip(t));
    }

    public void publish(RentalOrder o) {
        hub.toUser(o.customerId, "order.updated", view(o, Audience.CUSTOMER));
        if (o.lenderId != null) hub.toUser(o.lenderId, "order.updated", view(o, Audience.LENDER));
        hub.toAdmins("order.updated", view(o, Audience.ADMIN));
        hub.publish("order:" + o.id, "order.updated", view(o, Audience.PUBLIC));
    }

    // ======================================================================= views

    public static Obj view(RentalOrder o, Audience a) {
        double total = o.totalAmount();
        Obj v = Obj.of()
                .with("id", o.id)
                .with("orderNo", o.orderNo)
                .with("status", o.status.name())
                .with("createdAt", o.createdAt)
                .with("updatedAt", o.updatedAt)
                .with("customerId", o.customerId)
                .with("customerName", o.customerName)
                .with("customerPhone", o.customerPhone)
                .with("customerEmail", o.customerEmail)
                .with("productId", o.productId)
                .with("lenderId", o.lenderId)
                .with("productName", o.productName)
                .with("categoryLabel", o.categoryLabel)
                .with("imageUrl", o.imageUrl)
                .with("vendorName", o.vendorName)
                .with("ratePerDay", o.ratePerDay)
                .with("securityDeposit", o.securityDeposit)
                .with("deliveryFee", o.deliveryFee)
                .with("platformFee", o.platformFee)
                .with("pickupFee", o.pickupFee)
                .with("discount", o.discount)
                .with("couponCode", o.couponCode)
                .with("coinsRedeemed", o.coinsRedeemed)
                .with("startDate", o.startDate)
                .with("endDate", o.endDate)
                .with("days", o.days())
                .with("rentalAmount", o.rentalAmount())
                .with("checkoutTotal", o.checkoutTotal())
                .with("totalAmount", total)
                .with("deliveryAddress", o.deliveryAddress)
                .with("deliveryLat", o.deliveryLat)
                .with("deliveryLng", o.deliveryLng)
                .with("deliveryDate", o.deliveryDate)
                .with("deliverySlot", o.deliverySlot)
                .with("actualDeliveredTime", o.actualDeliveredTime)
                .with("returnPickupDate", o.returnPickupDate)
                .with("returnPickupSlot", o.returnPickupSlot)
                .with("purchaseRequested", o.purchaseRequested)
                .with("isAvailableForPurchase", o.availableForPurchase)
                .with("purchasePrice", o.purchasePrice)
                .with("rejectedByVendor", o.rejectedByVendor)
                .with("vendorAccepted", o.vendorAccepted)
                .with("cancelReason", o.cancelReason)
                .with("paymentMethod", o.paymentMethod)
                .with("paymentStatus", o.paymentStatus)
                .with("transactionId", o.transactionId)
                .with("paidAmount", o.paidAmount)
                .with("paidAt", o.paidAt)
                .with("dueAmount", Math.max(0, total - o.paidAmount))
                .with("refundedAmount", o.refundedAmount)
                .with("activity", o.activity);
        if (a == Audience.CUSTOMER || a == Audience.ADMIN) v.with("deliveryOtp", o.deliveryOtp);
        if (a == Audience.LENDER || a == Audience.ADMIN) v.with("pickupOtp", o.pickupOtp);
        return v;
    }
}
