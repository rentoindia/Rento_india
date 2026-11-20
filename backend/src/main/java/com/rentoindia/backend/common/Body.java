package com.rentoindia.backend.common;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/** Null-safe readers for JSON request bodies (Map<String,Object>). */
public final class Body {

    private Body() {}

    public static boolean has(Map<String, Object> b, String k) {
        return b != null && b.containsKey(k);
    }

    public static String str(Map<String, Object> b, String k) {
        Object v = b == null ? null : b.get(k);
        return v == null ? null : v.toString();
    }

    public static String str(Map<String, Object> b, String k, String def) {
        String v = str(b, k);
        return v == null ? def : v;
    }

    /** Accepts numbers or strings such as "599" or "₹1,299.50". */
    public static double dbl(Map<String, Object> b, String k, double def) {
        Object v = b == null ? null : b.get(k);
        if (v == null) return def;
        if (v instanceof Number n) return n.doubleValue();
        try {
            String cleaned = v.toString().replaceAll("[^0-9.\\-]", "");
            return cleaned.isEmpty() ? def : Double.parseDouble(cleaned);
        } catch (Exception e) {
            return def;
        }
    }

    public static int intv(Map<String, Object> b, String k, int def) {
        return (int) Math.round(dbl(b, k, def));
    }

    public static boolean bool(Map<String, Object> b, String k, boolean def) {
        Object v = b == null ? null : b.get(k);
        if (v == null) return def;
        if (v instanceof Boolean x) return x;
        return "true".equalsIgnoreCase(v.toString());
    }

    public static UUID uuid(Map<String, Object> b, String k) {
        String s = str(b, k);
        if (s == null || s.isBlank()) return null;
        try {
            return UUID.fromString(s.trim());
        } catch (IllegalArgumentException e) {
            return null;
        }
    }

    @SuppressWarnings("unchecked")
    public static List<Map<String, Object>> maps(Map<String, Object> b, String k) {
        Object v = b == null ? null : b.get(k);
        List<Map<String, Object>> out = new ArrayList<>();
        if (v instanceof List<?> l) {
            for (Object o : l) {
                if (o instanceof Map<?, ?> m) out.add((Map<String, Object>) m);
            }
        }
        return out;
    }

    public static List<String> strings(Map<String, Object> b, String k) {
        Object v = b == null ? null : b.get(k);
        List<String> out = new ArrayList<>();
        if (v instanceof List<?> l) {
            for (Object o : l) {
                if (o != null) out.add(o.toString());
            }
        }
        return out;
    }

    /** Parses enum names in any style: "outForDelivery", "OUT_FOR_DELIVERY", "out-for-delivery". */
    public static <E extends Enum<E>> E enumOf(Class<E> type, String raw, E def) {
        if (raw == null || raw.isBlank()) return def;
        String norm = raw.trim().replaceAll("([a-z0-9])([A-Z])", "$1_$2")
                .replace('-', '_').replace(' ', '_').toUpperCase();
        for (E e : type.getEnumConstants()) {
            if (e.name().equals(norm)) return e;
        }
        return def;
    }

    public static UUID parseUuid(String s) {
        try {
            return UUID.fromString(s);
        } catch (Exception e) {
            throw ApiException.badRequest("Invalid id: " + s);
        }
    }
}
