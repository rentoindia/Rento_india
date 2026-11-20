package com.rentoindia.backend.delivery;

/** Distance + fare helpers. Rates are simple constants for now; move to an admin-editable settings table later. */
public final class Pricing {

    private Pricing() {}

    public static double round2(double v) {
        return Math.round(v * 100.0) / 100.0;
    }

    /** Great-circle distance in km. Returns 0 if any coordinate is missing (0,0). */
    public static double haversineKm(double lat1, double lng1, double lat2, double lng2) {
        if ((lat1 == 0 && lng1 == 0) || (lat2 == 0 && lng2 == 0)) return 0;
        double r = 6371.0;
        double dLat = Math.toRadians(lat2 - lat1);
        double dLng = Math.toRadians(lng2 - lng1);
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2)
                + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2))
                * Math.sin(dLng / 2) * Math.sin(dLng / 2);
        return r * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    }

    /** Rider earning for a rental delivery / return pickup. */
    public static double tripEarnings(double km) {
        return round2(Math.max(80, 50 + 12 * km));
    }

    public static int minutesFor(double km) {
        return (int) Math.max(8, Math.round(km * 4 + 6));
    }

    /** Fallback fare when the app does not send one. */
    public static double rideFare(double km, int minutes, String vehicle) {
        double perKm = "bike".equalsIgnoreCase(vehicle) ? 7 : "auto".equalsIgnoreCase(vehicle) ? 11 : 15;
        double base = "bike".equalsIgnoreCase(vehicle) ? 25 : "auto".equalsIgnoreCase(vehicle) ? 35 : 50;
        return round2(base + perKm * km + 1.0 * minutes);
    }

    public static double parcelFare(double km, double weightKg) {
        return round2(40 + 9 * km + Math.max(0, weightKg - 5) * 4);
    }
}
