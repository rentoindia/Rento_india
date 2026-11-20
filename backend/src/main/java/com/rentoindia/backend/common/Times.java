package com.rentoindia.backend.common;

import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;

public final class Times {

    private Times() {}

    /** Accepts "2026-09-08T10:00:00Z", "...+05:30", "2026-09-08T10:00:00" or "2026-09-08". Returns null if blank/invalid. */
    public static Instant parse(String s) {
        if (s == null || s.isBlank()) return null;
        String v = s.trim();
        try {
            return Instant.parse(v);
        } catch (Exception ignored) { }
        try {
            return OffsetDateTime.parse(v).toInstant();
        } catch (Exception ignored) { }
        try {
            return LocalDateTime.parse(v).toInstant(ZoneOffset.UTC);
        } catch (Exception ignored) { }
        try {
            return LocalDate.parse(v).atStartOfDay().toInstant(ZoneOffset.UTC);
        } catch (Exception ignored) { }
        return null;
    }
}
