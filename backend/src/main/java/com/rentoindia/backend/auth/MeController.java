package com.rentoindia.backend.auth;

import com.rentoindia.backend.common.ApiException;
import com.rentoindia.backend.common.ApiResponse;
import com.rentoindia.backend.common.CurrentUser;
import com.rentoindia.backend.common.Obj;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/** The logged-in user's own profile. */
@RestController
@RequestMapping("/api/v1/me")
public class MeController {

    private final UserRepository users;

    public MeController(UserRepository users) {
        this.users = users;
    }

    @GetMapping
    public ApiResponse<Obj> get() {
        return ApiResponse.ok(UserView.of(load()));
    }

    @PutMapping
    public ApiResponse<Obj> update(@RequestBody Map<String, Object> b) {
        User u = load();
        if (b.get("fullName") != null) u.fullName = b.get("fullName").toString().trim();
        if (b.get("email") != null) {
            String e = b.get("email").toString().trim();
            u.email = e.isEmpty() ? null : e;
        }
        if (b.get("location") != null) u.location = b.get("location").toString();
        if (b.get("profileImageUrl") != null) u.profileImageUrl = b.get("profileImageUrl").toString();
        if (b.get("homeAddress") != null) u.homeAddress = b.get("homeAddress").toString();
        return ApiResponse.ok(UserView.of(users.save(u)));
    }

    /** Portal switching: add a role (CUSTOMER, LENDER, RIDER, PROPERTY_OWNER ...) to this account. */
    @PostMapping("/roles")
    public ApiResponse<Obj> addRole(@RequestBody Map<String, Object> b) {
        Role r = AuthService.clientRole(String.valueOf(b.get("role")));
        if (r == null) throw ApiException.badRequest("role is required");
        User u = load();
        u.roles.add(r);
        return ApiResponse.ok(UserView.of(users.save(u)));
    }

    private User load() {
        return users.findById(CurrentUser.id()).orElseThrow(() -> ApiException.unauthorized("Login required"));
    }
}
