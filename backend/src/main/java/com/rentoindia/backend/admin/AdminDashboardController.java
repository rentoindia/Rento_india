package com.rentoindia.backend.admin;

import com.rentoindia.backend.auth.Role;
import com.rentoindia.backend.auth.UserRepository;
import com.rentoindia.backend.catalog.Product;
import com.rentoindia.backend.catalog.ProductRepository;
import com.rentoindia.backend.common.ApiResponse;
import com.rentoindia.backend.common.Obj;
import com.rentoindia.backend.delivery.Rider;
import com.rentoindia.backend.delivery.RiderRepository;
import com.rentoindia.backend.myhouse.MaintenanceRequestRepository;
import com.rentoindia.backend.myhouse.Property;
import com.rentoindia.backend.myhouse.PropertyRepository;
import com.rentoindia.backend.myhouse.RentPayment;
import com.rentoindia.backend.myhouse.RentPaymentRepository;
import com.rentoindia.backend.myhouse.TenancyApplication;
import com.rentoindia.backend.myhouse.TenancyApplicationRepository;
import com.rentoindia.backend.rental.OrderService;
import com.rentoindia.backend.rental.RentalOrder;
import com.rentoindia.backend.rental.RentalOrderRepository;
import com.rentoindia.backend.ride.ParcelBooking;
import com.rentoindia.backend.ride.ParcelBookingRepository;
import com.rentoindia.backend.ride.RideBooking;
import com.rentoindia.backend.ride.RideBookingRepository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneOffset;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/** One call that feeds every admin dashboard (rental, delivery, my house). */
@RestController
@RequestMapping("/api/v1/admin/dashboard")
public class AdminDashboardController {

    private final UserRepository users;
    private final ProductRepository products;
    private final RentalOrderRepository orders;
    private final RiderRepository riders;
    private final RideBookingRepository rides;
    private final ParcelBookingRepository parcels;
    private final PropertyRepository properties;
    private final TenancyApplicationRepository applications;
    private final MaintenanceRequestRepository maintenance;
    private final RentPaymentRepository rent;

    public AdminDashboardController(UserRepository users, ProductRepository products, RentalOrderRepository orders,
                                    RiderRepository riders, RideBookingRepository rides,
                                    ParcelBookingRepository parcels, PropertyRepository properties,
                                    TenancyApplicationRepository applications,
                                    MaintenanceRequestRepository maintenance, RentPaymentRepository rent) {
        this.users = users;
        this.products = products;
        this.orders = orders;
        this.riders = riders;
        this.rides = rides;
        this.parcels = parcels;
        this.properties = properties;
        this.applications = applications;
        this.maintenance = maintenance;
        this.rent = rent;
    }

    @GetMapping
    public ApiResponse<Obj> dashboard() {
        List<RentalOrder> all = orders.findAllByOrderByCreatedAtDesc();
        double revenue = 0;
        Map<String, Integer> byStatus = new LinkedHashMap<>();
        Map<LocalDate, Double> perDay = new LinkedHashMap<>();
        LocalDate today = LocalDate.now(ZoneOffset.UTC);
        for (int i = 6; i >= 0; i--) perDay.put(today.minusDays(i), 0.0);
        for (RentalOrder o : all) {
            byStatus.merge(o.status.name(), 1, Integer::sum);
            if ("PAID".equals(o.paymentStatus)) {
                revenue += o.paidAmount;
                if (o.paidAt != null) {
                    LocalDate d = o.paidAt.atZone(ZoneOffset.UTC).toLocalDate();
                    if (perDay.containsKey(d)) perDay.merge(d, o.paidAmount, Double::sum);
                }
            }
        }
        List<Obj> series = new ArrayList<>();
        perDay.forEach((d, v) -> series.add(Obj.of().with("date", d.toString()).with("revenue", v)));

        Obj rental = Obj.of()
                .with("totalOrders", all.size())
                .with("revenue", revenue)
                .with("byStatus", byStatus)
                .with("revenueLast7Days", series)
                .with("products", products.count())
                .with("activeProducts", products.countByStatus(Product.Status.ACTIVE))
                .with("outOfStock", products.countByStatus(Product.Status.OUT_OF_STOCK))
                .with("recentOrders", all.stream().limit(8).map(o -> OrderService.view(o, OrderService.Audience.ADMIN)).toList());

        Instant startOfDay = Instant.now().truncatedTo(java.time.temporal.ChronoUnit.DAYS);
        long ridesToday = rides.findAllByOrderByCreatedAtDesc().stream().filter(r -> r.createdAt.isAfter(startOfDay)).count();
        Obj logistics = Obj.of()
                .with("ridersTotal", riders.count())
                .with("ridersActive", riders.countByStatus(Rider.Status.ACTIVE))
                .with("ridersPending", riders.countByStatus(Rider.Status.PENDING))
                .with("ridersSuspended", riders.countByStatus(Rider.Status.SUSPENDED))
                .with("ridersOnline", riders.countByOnlineTrue())
                .with("ridesTotal", rides.count())
                .with("ridesToday", ridesToday)
                .with("ridesActive", rides.countByStatus(RideBooking.Status.IN_PROGRESS) + rides.countByStatus(RideBooking.Status.ASSIGNED))
                .with("ridesRequested", rides.countByStatus(RideBooking.Status.REQUESTED))
                .with("parcelsTotal", parcels.count())
                .with("parcelsPending", parcels.countByStatus(ParcelBooking.Status.PENDING))
                .with("parcelsInTransit", parcels.countByStatus(ParcelBooking.Status.IN_TRANSIT))
                .with("parcelsDelivered", parcels.countByStatus(ParcelBooking.Status.DELIVERED))
                .with("sosActive", rides.countBySosStatus("ACTIVE"));

        double rentCollected = 0;
        for (RentPayment r : rent.findAllByOrderByCreatedAtDesc()) rentCollected += r.amount;
        Obj myhouse = Obj.of()
                .with("propertiesTotal", properties.count())
                .with("propertiesPending", properties.countByStatus(Property.Status.PENDING))
                .with("propertiesApproved", properties.countByStatus(Property.Status.APPROVED))
                .with("propertiesRejected", properties.countByStatus(Property.Status.REJECTED))
                .with("applicationsPending", applications.countByStatus(TenancyApplication.Status.PENDING))
                .with("maintenanceOpen", maintenance.countByStatus("OPEN"))
                .with("maintenanceInProgress", maintenance.countByStatus("IN_PROGRESS"))
                .with("rentCollected", rentCollected);

        Obj people = Obj.of()
                .with("customers", users.countByRole(Role.CUSTOMER))
                .with("lenders", users.countByRole(Role.LENDER))
                .with("riders", users.countByRole(Role.RIDER))
                .with("owners", users.countByRole(Role.PROPERTY_OWNER))
                .with("tenants", users.countByRole(Role.PROPERTY_TENANT))
                .with("total", users.count());

        return ApiResponse.ok(Obj.of().with("rental", rental).with("logistics", logistics)
                .with("myhouse", myhouse).with("users", people));
    }
}
