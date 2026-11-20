package com.rentoindia.backend.admin;

import com.rentoindia.backend.auth.Role;
import com.rentoindia.backend.auth.User;
import com.rentoindia.backend.auth.UserRepository;
import com.rentoindia.backend.auth.UserView;
import com.rentoindia.backend.common.ApiException;
import com.rentoindia.backend.common.ApiResponse;
import com.rentoindia.backend.common.Body;
import com.rentoindia.backend.common.Obj;
import com.rentoindia.backend.notification.NotificationService;
import com.rentoindia.backend.rental.RentalOrderRepository;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

/** Platform users across all apps (customers, lenders, riders, owners, tenants). */
@RestController
@RequestMapping("/api/v1/admin/users")
public class AdminUserController {

    private final UserRepository users;
    private final RentalOrderRepository orders;
    private final NotificationService notifications;

    public AdminUserController(UserRepository users, RentalOrderRepository orders, NotificationService notifications) {
        this.users = users;
        this.orders = orders;
        this.notifications = notifications;
    }

    private User load(String id) {
        return users.findById(Body.parseUuid(id)).orElseThrow(() -> ApiException.notFound("User not found"));
    }

    private Obj view(User u) {
        return UserView.of(u).with("totalOrders", orders.countByCustomerId(u.id));
    }

    /** Optional filter: ?role=CUSTOMER|LENDER|RIDER|PROPERTY_OWNER|PROPERTY_TENANT ; ?q=name/phone */
    @GetMapping
    public ApiResponse<List<Obj>> list(@RequestParam(defaultValue = "") String role,
                                       @RequestParam(defaultValue = "") String q) {
        List<User> all;
        if (role.isBlank()) {
            all = users.findAll();
        } else {
            Role r = Body.enumOf(Role.class, role, null);
            if (r == null) throw ApiException.badRequest("Unknown role");
            all = users.findByRole(r);
        }
        String needle = q.trim().toLowerCase();
        return ApiResponse.ok(all.stream()
                .filter(u -> !u.roles.contains(Role.ADMIN) && !u.roles.contains(Role.SUPER_ADMIN))
                .filter(u -> needle.isEmpty()
                        || (u.fullName != null && u.fullName.toLowerCase().contains(needle))
                        || (u.phone != null && u.phone.contains(needle)))
                .sorted((a, b) -> b.createdAt.compareTo(a.createdAt))
                .map(this::view).toList());
    }

    @GetMapping("/{id}")
    public ApiResponse<Obj> one(@PathVariable String id) {
        return ApiResponse.ok(view(load(id)));
    }

    @PostMapping("/{id}/block")
    public ApiResponse<Obj> block(@PathVariable String id, @RequestBody(required = false) Map<String, Object> b) {
        User u = load(id);
        u.blocked = Body.bool(b, "blocked", !u.blocked);
        users.save(u);
        return ApiResponse.ok(view(u));
    }

    @PostMapping("/{id}/verify")
    public ApiResponse<Obj> verify(@PathVariable String id, @RequestBody(required = false) Map<String, Object> b) {
        User u = load(id);
        u.verified = Body.bool(b, "verified", !u.verified);
        users.save(u);
        if (u.verified) notifications.notify(u.id, "Account verified", "Your account has been verified.", "Alerts", "verified", null, null);
        return ApiResponse.ok(view(u));
    }

    @DeleteMapping("/{id}")
    public ApiResponse<Void> delete(@PathVariable String id) {
        User u = load(id);
        if (u.roles.contains(Role.ADMIN) || u.roles.contains(Role.SUPER_ADMIN)) throw ApiException.forbidden("Cannot delete an admin");
        // soft delete: block + anonymise so history (orders etc.) stays consistent
        u.blocked = true;
        u.fullName = "Deleted user";
        u.email = null;
        users.save(u);
        return ApiResponse.ok(null);
    }

    /** Admin "send notification" screen: {title, message, audience: ALL|CUSTOMER|LENDER|RIDER|...} */
    @PostMapping("/broadcast")
    public ApiResponse<Obj> broadcast(@RequestBody Map<String, Object> b) {
        String title = Body.str(b, "title", "").trim();
        String msg = Body.str(b, "message", "").trim();
        if (title.isEmpty() || msg.isEmpty()) throw ApiException.badRequest("title and message are required");
        String audience = Body.str(b, "audience", "ALL");
        List<User> targets = "ALL".equalsIgnoreCase(audience) ? users.findAll()
                : users.findByRole(Body.enumOf(Role.class, audience, Role.CUSTOMER));
        int n = 0;
        for (User u : targets) {
            if (u.blocked || u.roles.contains(Role.ADMIN)) continue;
            notifications.notify(u.id, title, msg, "Offers", "campaign", null, null);
            n++;
        }
        return ApiResponse.ok(Obj.of().with("sent", n));
    }
}
