package com.rentoindia.backend.config;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class JwtService {

    private final SecretKey key;
    private final long accessMinutes;
    private final long refreshDays;

    public JwtService(@Value("${app.jwt.secret}") String secret,
                      @Value("${app.jwt.access-token-expiry-minutes}") long accessMinutes,
                      @Value("${app.jwt.refresh-token-expiry-days}") long refreshDays) {
        this.key = Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8));
        this.accessMinutes = accessMinutes;
        this.refreshDays = refreshDays;
    }

    public String accessToken(String userId, String phone, List<String> roles) {
        Date now = new Date();
        Map<String, Object> claims = new HashMap<>();
        claims.put("phone", phone == null ? "" : phone);
        claims.put("roles", roles);
        claims.put("typ", "access");
        return Jwts.builder()
                .subject(userId)
                .claims(claims)
                .issuedAt(now)
                .expiration(new Date(now.getTime() + accessMinutes * 60_000L))
                .signWith(key)
                .compact();
    }

    public String refreshToken(String userId) {
        Date now = new Date();
        return Jwts.builder()
                .subject(userId)
                .claim("typ", "refresh")
                .issuedAt(now)
                .expiration(new Date(now.getTime() + refreshDays * 24L * 60L * 60_000L))
                .signWith(key)
                .compact();
    }

    /** Parses and verifies signature + expiry. Throws a JwtException if invalid. */
    public Claims parse(String token) {
        return Jwts.parser().verifyWith(key).build().parseSignedClaims(token).getPayload();
    }

    /** Returns claims or null if the token is invalid/expired. */
    public Claims tryParse(String token) {
        try {
            return parse(token);
        } catch (Exception e) {
            return null;
        }
    }

    @SuppressWarnings("unchecked")
    public static List<String> roles(Claims c) {
        Object r = c.get("roles");
        return r instanceof List<?> ? (List<String>) r : List.of();
    }
}
