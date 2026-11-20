package com.rentoindia.backend.common;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.UUID;

/** Reads the logged-in user from the JWT that JwtAuthFilter put in the SecurityContext. */
public final class CurrentUser {

    private CurrentUser() {}

    public static UUID id() {
        Authentication a = SecurityContextHolder.getContext().getAuthentication();
        if (a == null || !(a.getPrincipal() instanceof String s)) {
            throw ApiException.unauthorized("Login required");
        }
        try {
            return UUID.fromString(s);
        } catch (IllegalArgumentException e) {
            throw ApiException.unauthorized("Login required");
        }
    }

    public static boolean hasRole(String role) {
        Authentication a = SecurityContextHolder.getContext().getAuthentication();
        if (a == null) return false;
        return a.getAuthorities().stream().anyMatch(g -> g.getAuthority().equals("ROLE_" + role));
    }
}
