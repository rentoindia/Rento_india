package com.rentoindia.backend.rental;

import com.rentoindia.backend.auth.Role;
import com.rentoindia.backend.auth.User;
import com.rentoindia.backend.auth.UserRepository;
import com.rentoindia.backend.auth.UserView;
import com.rentoindia.backend.catalog.Product;
import com.rentoindia.backend.catalog.ProductRepository;
import com.rentoindia.backend.catalog.ProductService;
import com.rentoindia.backend.common.ApiException;
import com.rentoindia.backend.common.ApiResponse;
import com.rentoindia.backend.common.Body;
import com.rentoindia.backend.common.CurrentUser;
import com.rentoindia.backend.common.Obj;
import com.rentoindia.backend.rental.OrderService.Audience;
import org.springframework.web.bind.annotation.DeleteMapping;
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

/** Lender side of the marketplace: verification, own products, incoming rental requests. */
@RestController
@RequestMapping("/api/v1/lender")
public class LenderController {

    private final UserRepository users;
    private final ProductRepository products;
    private final ProductService productService;
    private final RentalOrderRepository orders;
    private final OrderService orderService;

    public LenderController(UserRepository users, ProductRepository products, ProductService productService,
                            RentalOrderRepository orders, OrderService orderService) {
        this.users = users;
        this.products = products;
        this.productService = productService;
        this.orders = orders;
        this.orderService = orderService;
    }

    private User me() {
        return users.findById(CurrentUser.id()).orElseThrow(() -> ApiException.unauthorized("Login required"));
    }

    private Product myProduct(String id) {
        Product p = productService.get(Body.parseUuid(id));
        if (p.lenderId == null || !p.lenderId.equals(CurrentUser.id())) throw ApiException.forbidden("This is not your product");
        return p;
    }

    // ------------------------------------------------------------ verification

    @GetMapping("/profile")
    public ApiResponse<Obj> profile() {
        User u = me();
        return ApiResponse.ok(Obj.of().with("verified", u.lenderVerified).with("name", u.fullName)
                .with("mobile", u.phone).with("email", u.email).with("aadhaar", u.aadhaarNumber)
                .with("address", u.homeAddress));
    }

    @PostMapping("/verification")
    public ApiResponse<Obj> verify(@RequestBody Map<String, Object> b) {
        User u = me();
        String name = Body.str(b, "name", "").trim();
        if (name.isEmpty()) throw ApiException.badRequest("Full name is required");
        u.fullName = name;
        if (Body.has(b, "email")) u.email = Body.str(b, "email", "").isBlank() ? null : Body.str(b, "email").trim();
        u.aadhaarNumber = Body.str(b, "aadhaar", u.aadhaarNumber);
        u.homeAddress = Body.str(b, "address", u.homeAddress);
        u.lenderVerified = true;
        u.roles.add(Role.LENDER);
        users.save(u);
        return ApiResponse.ok(UserView.of(u));
    }

    // ---------------------------------------------------------------- products

    @GetMapping("/products")
    public ApiResponse<List<Product>> myProducts() {
        return ApiResponse.ok(products.findByLenderIdOrderByCreatedAtDesc(CurrentUser.id()));
    }

    @PostMapping("/products")
    public ApiResponse<Product> create(@RequestBody Map<String, Object> b) {
        User u = me();
        if (!u.lenderVerified) throw ApiException.forbidden("Please complete lender verification first");
        return ApiResponse.ok(productService.create(b, u.id, u.fullName == null ? "Lender" : u.fullName));
    }

    @PutMapping("/products/{id}")
    public ApiResponse<Product> update(@PathVariable String id, @RequestBody Map<String, Object> b) {
        // lenders may not change platform-controlled fields
        b.remove("lenderId");
        b.remove("featured");
        return ApiResponse.ok(productService.update(myProduct(id), b));
    }

    @PostMapping("/products/{id}/toggle-pause")
    public ApiResponse<Product> togglePause(@PathVariable String id) {
        Product p = myProduct(id);
        Product.Status next = p.status == Product.Status.INACTIVE ? Product.Status.ACTIVE : Product.Status.INACTIVE;
        return ApiResponse.ok(productService.setStatus(p, next, next == Product.Status.INACTIVE ? "Paused by lender" : "Resumed by lender"));
    }

    @DeleteMapping("/products/{id}")
    public ApiResponse<Void> delete(@PathVariable String id) {
        productService.delete(myProduct(id), "Deleted by lender");
        return ApiResponse.ok(null);
    }

    // ---------------------------------------------------------------- requests

    @GetMapping("/requests")
    public ApiResponse<List<Obj>> requests() {
        return ApiResponse.ok(orders.findByLenderIdOrderByCreatedAtDesc(CurrentUser.id()).stream()
                .map(o -> OrderService.view(o, Audience.LENDER)).toList());
    }

    @PostMapping("/requests/{id}/respond")
    public ApiResponse<Obj> respond(@PathVariable String id, @RequestBody Map<String, Object> b) {
        RentalOrder o = orderService.get(Body.parseUuid(id));
        RentalOrder done = orderService.respond(o, CurrentUser.id(), Body.bool(b, "accept", false), Body.str(b, "reason"));
        return ApiResponse.ok(OrderService.view(done, Audience.LENDER));
    }

    /** Lender confirms the item came back in good condition -> order completes, deposit refunded. */
    @PostMapping("/requests/{id}/complete")
    public ApiResponse<Obj> complete(@PathVariable String id) {
        RentalOrder o = orderService.get(Body.parseUuid(id));
        if (o.lenderId == null || !o.lenderId.equals(CurrentUser.id())) throw ApiException.forbidden("This is not your order");
        return ApiResponse.ok(OrderService.view(orderService.complete(o), Audience.LENDER));
    }

    @GetMapping("/summary")
    public ApiResponse<Obj> summary() {
        UUID me = CurrentUser.id();
        double earnings = 0;
        int pending = 0, active = 0;
        for (RentalOrder o : orders.findByLenderIdOrderByCreatedAtDesc(me)) {
            if (o.status == RentalOrder.Status.COMPLETED) earnings += o.rentalAmount();
            if (!o.vendorAccepted && o.status != RentalOrder.Status.CANCELLED) pending++;
            if (o.status.ordinal() >= RentalOrder.Status.PAYMENT_CONFIRMED.ordinal()
                    && o.status.ordinal() < RentalOrder.Status.COMPLETED.ordinal()) active++;
        }
        return ApiResponse.ok(Obj.of().with("totalEarnings", earnings).with("pendingRequests", pending)
                .with("activeRentals", active).with("products", products.findByLenderIdOrderByCreatedAtDesc(me).size()));
    }
}
