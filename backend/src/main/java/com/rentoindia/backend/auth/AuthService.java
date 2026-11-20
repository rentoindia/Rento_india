package com.rentoindia.backend.auth;

import com.rentoindia.backend.common.ApiException;
import com.rentoindia.backend.common.Obj;
import com.rentoindia.backend.config.JwtService;
import io.jsonwebtoken.Claims;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class AuthService {

    private final UserRepository users;
    private final OtpService otp;
    private final JwtService jwt;
    private final PasswordEncoder encoder;

    public AuthService(UserRepository users, OtpService otp, JwtService jwt, PasswordEncoder encoder) {
        this.users = users;
        this.otp = otp;
        this.jwt = jwt;
        this.encoder = encoder;
    }

    public String requestOtp(String phone) {
        return otp.request(phone);
    }

    /** Roles a mobile client may ask for. ADMIN roles can never be self-assigned. */
    public static Role clientRole(String name) {
        if (name == null || name.isBlank()) return null;
        Role r;
        try {
            r = Role.valueOf(name.trim().toUpperCase());
        } catch (IllegalArgumentException e) {
            throw ApiException.badRequest("Unknown role: " + name);
        }
        if (r == Role.ADMIN || r == Role.SUPER_ADMIN) {
            throw ApiException.forbidden("This role cannot be selected");
        }
        return r;
    }

    public Obj verifyOtp(String phone, String code, String roleOnFirstLogin) {
        otp.verify(phone, code);
        User user = users.findByPhone(phone).orElseGet(() -> {
            User n = new User();
            n.phone = phone;
            return n;
        });
        if (user.blocked) throw ApiException.forbidden("This account has been blocked. Contact support.");
        user.phoneVerified = true;
        user.lastLoginAt = Instant.now();
        Role r = clientRole(roleOnFirstLogin);
        if (r != null) user.roles.add(r);
        if (user.roles.isEmpty()) user.roles.add(Role.CUSTOMER);
        user = users.save(user);
        return session(user);
    }

    public Obj adminLogin(String identifier, String password) {
        Optional<User> found = identifier.contains("@")
                ? users.findByEmailIgnoreCase(identifier.trim())
                : users.findByPhone(identifier.trim());
        User u = found.orElseThrow(() -> ApiException.unauthorized("Invalid credentials"));
        boolean isAdmin = u.roles.contains(Role.ADMIN) || u.roles.contains(Role.SUPER_ADMIN);
        if (!isAdmin || u.passwordHash == null || !encoder.matches(password, u.passwordHash)) {
            throw ApiException.unauthorized("Invalid credentials");
        }
        if (u.blocked) throw ApiException.forbidden("This account has been blocked");
        u.lastLoginAt = Instant.now();
        users.save(u);
        return session(u);
    }

    public Obj refresh(String refreshToken) {
        Claims c = jwt.tryParse(refreshToken);
        if (c == null || !"refresh".equals(c.get("typ"))) {
            throw ApiException.unauthorized("Session expired. Please log in again.");
        }
        User u = users.findById(UUID.fromString(c.getSubject()))
                .orElseThrow(() -> ApiException.unauthorized("Session expired. Please log in again."));
        if (u.blocked) throw ApiException.forbidden("This account has been blocked");
        return session(u);
    }

    private Obj session(User u) {
        List<String> roles = u.roles.stream().map(Enum::name).toList();
        return Obj.of()
                .with("userId", u.id)
                .with("accessToken", jwt.accessToken(u.id.toString(), u.phone, roles))
                .with("refreshToken", jwt.refreshToken(u.id.toString()))
                .with("user", UserView.of(u));
    }
}
