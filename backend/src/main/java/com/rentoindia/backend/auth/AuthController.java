package com.rentoindia.backend.auth;

import com.rentoindia.backend.common.ApiException;
import com.rentoindia.backend.common.ApiResponse;
import com.rentoindia.backend.common.Obj;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * Public endpoints (no token needed):
 *   POST /api/v1/auth/request-otp   {phone}
 *   POST /api/v1/auth/verify-otp    {phone, code, role?}
 *   POST /api/v1/auth/admin/login   {identifier, password}
 *   POST /api/v1/auth/refresh       {refreshToken}
 */
@RestController
@RequestMapping("/api/v1/auth")
public class AuthController {

    private final AuthService auth;

    public AuthController(AuthService auth) {
        this.auth = auth;
    }

    private static String str(Map<String, Object> b, String k) {
        Object v = b.get(k);
        return v == null ? null : v.toString().trim();
    }

    @PostMapping("/request-otp")
    public ApiResponse<Obj> requestOtp(@RequestBody Map<String, Object> body) {
        String phone = str(body, "phone");
        if (phone == null || !phone.matches("^[0-9]{10}$")) {
            throw ApiException.badRequest("Enter a valid 10-digit mobile number");
        }
        String devOtp = auth.requestOtp(phone);
        return ApiResponse.ok("OTP sent", Obj.of().with("devOtp", devOtp));
    }

    @PostMapping("/verify-otp")
    public ApiResponse<Obj> verifyOtp(@RequestBody Map<String, Object> body) {
        String phone = str(body, "phone");
        String code = str(body, "code");
        if (phone == null || code == null) throw ApiException.badRequest("phone and code are required");
        String role = str(body, "role");
        if (role == null) role = str(body, "roleOnFirstLogin");
        return ApiResponse.ok(auth.verifyOtp(phone, code, role));
    }

    @PostMapping("/admin/login")
    public ApiResponse<Obj> adminLogin(@RequestBody Map<String, Object> body) {
        String id = str(body, "identifier");
        String pw = str(body, "password");
        if (id == null || pw == null) throw ApiException.badRequest("identifier and password are required");
        return ApiResponse.ok(auth.adminLogin(id, pw));
    }

    @PostMapping("/refresh")
    public ApiResponse<Obj> refresh(@RequestBody Map<String, Object> body) {
        String t = str(body, "refreshToken");
        if (t == null) throw ApiException.badRequest("refreshToken is required");
        return ApiResponse.ok(auth.refresh(t));
    }
}
