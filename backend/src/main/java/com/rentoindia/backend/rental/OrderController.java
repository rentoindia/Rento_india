package com.rentoindia.backend.rental;

import com.rentoindia.backend.common.ApiException;
import com.rentoindia.backend.common.ApiResponse;
import com.rentoindia.backend.common.Body;
import com.rentoindia.backend.common.CurrentUser;
import com.rentoindia.backend.common.Obj;
import com.rentoindia.backend.common.Times;
import com.rentoindia.backend.delivery.Rider;
import com.rentoindia.backend.delivery.RiderRepository;
import com.rentoindia.backend.delivery.Trip;
import com.rentoindia.backend.delivery.TripRepository;
import com.rentoindia.backend.rental.OrderService.Audience;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;
import java.util.UUID;

/** Customer side of rentals. Every call is limited to the logged-in customer's own orders. */
@RestController
@RequestMapping("/api/v1/orders")
public class OrderController {

    private final OrderService service;
    private final RentalOrderRepository orders;
    private final TripRepository trips;
    private final RiderRepository riders;

    public OrderController(OrderService service, RentalOrderRepository orders, TripRepository trips,
                           RiderRepository riders) {
        this.service = service;
        this.orders = orders;
        this.trips = trips;
        this.riders = riders;
    }

    private RentalOrder mine(String id) {
        RentalOrder o = service.get(Body.parseUuid(id));
        if (!o.customerId.equals(CurrentUser.id())) throw ApiException.forbidden("This is not your order");
        return o;
    }

    @PostMapping
    public ApiResponse<Obj> create(@RequestBody Map<String, Object> b) {
        RentalOrder o = service.create(CurrentUser.id(), b);
        return ApiResponse.ok(OrderService.view(o, Audience.CUSTOMER));
    }

    @GetMapping
    public ApiResponse<List<Obj>> list() {
        return ApiResponse.ok(orders.findByCustomerIdOrderByCreatedAtDesc(CurrentUser.id()).stream()
                .map(o -> OrderService.view(o, Audience.CUSTOMER)).toList());
    }

    @GetMapping("/{id}")
    public ApiResponse<Obj> one(@PathVariable String id) {
        return ApiResponse.ok(OrderService.view(mine(id), Audience.CUSTOMER));
    }

    @PutMapping("/{id}")
    public ApiResponse<Obj> update(@PathVariable String id, @RequestBody Map<String, Object> b) {
        return ApiResponse.ok(OrderService.view(service.updateDetails(mine(id), b), Audience.CUSTOMER));
    }

    @PostMapping("/{id}/pay")
    public ApiResponse<Obj> pay(@PathVariable String id, @RequestBody Map<String, Object> b) {
        return ApiResponse.ok(OrderService.view(service.pay(mine(id), b), Audience.CUSTOMER));
    }

    @PostMapping("/{id}/rental-active")
    public ApiResponse<Obj> rentalActive(@PathVariable String id) {
        return ApiResponse.ok(OrderService.view(service.markRentalActive(mine(id)), Audience.CUSTOMER));
    }

    @PostMapping("/{id}/schedule-return")
    public ApiResponse<Obj> scheduleReturn(@PathVariable String id, @RequestBody Map<String, Object> b) {
        return ApiResponse.ok(OrderService.view(
                service.scheduleReturn(mine(id), Times.parse(Body.str(b, "date")), Body.str(b, "slot")),
                Audience.CUSTOMER));
    }

    @PostMapping("/{id}/extend")
    public ApiResponse<Obj> extend(@PathVariable String id, @RequestBody Map<String, Object> b) {
        return ApiResponse.ok(OrderService.view(service.extend(mine(id), Times.parse(Body.str(b, "newEndDate"))), Audience.CUSTOMER));
    }

    @PostMapping("/{id}/purchase")
    public ApiResponse<Obj> purchase(@PathVariable String id) {
        return ApiResponse.ok(OrderService.view(service.purchase(mine(id)), Audience.CUSTOMER));
    }

    @PostMapping("/{id}/cancel")
    public ApiResponse<Obj> cancel(@PathVariable String id, @RequestBody(required = false) Map<String, Object> b) {
        return ApiResponse.ok(OrderService.view(service.cancel(mine(id), Body.str(b, "reason"), "customer"),
                Audience.CUSTOMER));
    }

    /** Live tracking card: current delivery job + the rider's details and last known position. */
    @GetMapping("/{id}/tracking")
    public ApiResponse<Obj> tracking(@PathVariable String id) {
        RentalOrder o = mine(id);
        Obj out = Obj.of().with("orderId", o.id).with("status", o.status.name());
        for (Trip t : trips.findByOrderIdOrderByCreatedAtDesc(o.id)) {
            if (t.status == Trip.Status.CANCELLED) continue;
            out.with("tripId", t.id).with("tripType", t.type.name()).with("tripStatus", t.status.name());
            if (t.riderId != null) {
                Rider r = riders.findByUserId(t.riderId).orElse(null);
                if (r != null) {
                    out.with("rider", Obj.of().with("name", r.name).with("phone", r.phone)
                            .with("vehicle", r.brandModel).with("vehicleNumber", r.vehicleNumber)
                            .with("rating", r.rating).with("lat", r.lat).with("lng", r.lng));
                }
            }
            break;
        }
        return ApiResponse.ok(out);
    }
}
