package com.rentoindia.backend.rental;

import com.rentoindia.backend.common.ApiException;
import com.rentoindia.backend.common.ApiResponse;
import com.rentoindia.backend.common.Body;
import com.rentoindia.backend.common.Obj;
import com.rentoindia.backend.rental.OrderService.Audience;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/admin/orders")
public class AdminOrderController {

    private final OrderService service;
    private final RentalOrderRepository orders;

    public AdminOrderController(OrderService service, RentalOrderRepository orders) {
        this.service = service;
        this.orders = orders;
    }

    @GetMapping
    public ApiResponse<List<Obj>> list(@RequestParam(defaultValue = "") String q) {
        String needle = q.trim().toLowerCase();
        return ApiResponse.ok(orders.findAllByOrderByCreatedAtDesc().stream()
                .filter(o -> needle.isEmpty()
                        || (o.orderNo != null && o.orderNo.toLowerCase().contains(needle))
                        || (o.customerName != null && o.customerName.toLowerCase().contains(needle))
                        || (o.productName != null && o.productName.toLowerCase().contains(needle)))
                .map(o -> OrderService.view(o, Audience.ADMIN)).toList());
    }

    @GetMapping("/{id}")
    public ApiResponse<Obj> one(@PathVariable String id) {
        return ApiResponse.ok(OrderService.view(service.get(Body.parseUuid(id)), Audience.ADMIN));
    }

    /** Admin override: {status, note}. COMPLETED refunds the deposit, CANCELLED refunds the payment. */
    @PostMapping("/{id}/status")
    public ApiResponse<Obj> status(@PathVariable String id, @RequestBody Map<String, Object> b) {
        RentalOrder o = service.get(Body.parseUuid(id));
        RentalOrder.Status s = Body.enumOf(RentalOrder.Status.class, Body.str(b, "status"), null);
        if (s == null) throw ApiException.badRequest("Unknown status");
        String note = Body.str(b, "note", "Updated by admin");
        RentalOrder res;
        if (s == RentalOrder.Status.COMPLETED) res = service.complete(o);
        else if (s == RentalOrder.Status.CANCELLED) res = service.cancel(o, note, "admin");
        else res = service.system(o, s, "Status: " + s.name().replace('_', ' '), note);
        return ApiResponse.ok(OrderService.view(res, Audience.ADMIN));
    }
}
