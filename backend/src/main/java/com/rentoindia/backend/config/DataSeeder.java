package com.rentoindia.backend.config;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rentoindia.backend.auth.Role;
import com.rentoindia.backend.auth.User;
import com.rentoindia.backend.auth.UserRepository;
import com.rentoindia.backend.catalog.Brand;
import com.rentoindia.backend.catalog.BrandRepository;
import com.rentoindia.backend.catalog.Category;
import com.rentoindia.backend.catalog.CategoryRepository;
import com.rentoindia.backend.catalog.Product;
import com.rentoindia.backend.catalog.ProductRepository;
import com.rentoindia.backend.catalog.SubCategory;
import com.rentoindia.backend.catalog.SubCategoryRepository;
import com.rentoindia.backend.promo.Campaign;
import com.rentoindia.backend.promo.CampaignRepository;
import com.rentoindia.backend.promo.Coupon;
import com.rentoindia.backend.promo.CouponRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.io.ClassPathResource;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.io.InputStream;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Runs once at startup:
 *  1. creates the first admin account (ADMIN_PHONE / ADMIN_EMAIL / ADMIN_PASSWORD) if missing
 *  2. on an EMPTY catalogue, loads the demo catalogue (seed/catalog.json), brands and coupons
 */
@Component
public class DataSeeder implements CommandLineRunner {

    private static final Logger log = LoggerFactory.getLogger(DataSeeder.class);

    private final UserRepository users;
    private final PasswordEncoder encoder;
    private final CategoryRepository categories;
    private final SubCategoryRepository subs;
    private final BrandRepository brands;
    private final ProductRepository products;
    private final CampaignRepository campaigns;
    private final CouponRepository coupons;
    private final ObjectMapper mapper;

    @Value("${app.admin.phone}")
    private String adminPhone;
    @Value("${app.admin.email}")
    private String adminEmail;
    @Value("${app.admin.password}")
    private String adminPassword;
    @Value("${app.seed-demo-data:true}")
    private boolean seedDemo;

    public DataSeeder(UserRepository users, PasswordEncoder encoder, CategoryRepository categories,
                      SubCategoryRepository subs, BrandRepository brands, ProductRepository products,
                      CampaignRepository campaigns, CouponRepository coupons, ObjectMapper mapper) {
        this.users = users;
        this.encoder = encoder;
        this.categories = categories;
        this.subs = subs;
        this.brands = brands;
        this.products = products;
        this.campaigns = campaigns;
        this.coupons = coupons;
        this.mapper = mapper;
    }

    @Override
    public void run(String... args) {
        try {
            seedAdmin();
            if (seedDemo && categories.count() == 0) seedCatalog();
        } catch (Exception e) {
            log.error("Seeding failed (the server keeps running): {}", e.getMessage(), e);
        }
    }

    private void seedAdmin() {
        User admin = users.findByPhone(adminPhone).orElse(null);
        if (admin == null) {
            admin = new User();
            admin.phone = adminPhone;
            log.info("Creating the first admin account: phone {} / email {}", adminPhone, adminEmail);
        }
        if (admin.passwordHash == null) admin.passwordHash = encoder.encode(adminPassword);
        admin.fullName = admin.fullName == null ? "Rento Admin" : admin.fullName;
        if (admin.email == null) admin.email = adminEmail;
        admin.phoneVerified = true;
        admin.verified = true;
        admin.roles.add(Role.SUPER_ADMIN);
        admin.roles.add(Role.ADMIN);
        users.save(admin);
    }

    private void seedCatalog() throws Exception {
        log.info("Empty catalogue - loading demo categories and products");
        JsonNode root;
        try (InputStream in = new ClassPathResource("seed/catalog.json").getInputStream()) {
            root = mapper.readTree(in);
        }
        int sort = 0;
        int featuredCount = 0;
        for (JsonNode c : root) {
            Category cat = new Category();
            cat.name = c.path("name").asText();
            cat.icon = c.path("icon").asText("generic");
            cat.sortOrder = sort++;
            cat = categories.save(cat);
            for (JsonNode s : c.path("subcategories")) {
                SubCategory sc = new SubCategory();
                sc.categoryId = cat.id;
                sc.name = s.asText();
                subs.save(sc);
            }
            boolean first = true;
            for (JsonNode p : c.path("products")) {
                Product pr = new Product();
                pr.name = p.path("name").asText();
                pr.category = cat.name;
                pr.subcategory = p.path("sub").asText();
                pr.vendorName = "RENTO India";
                pr.sku = "SKU-" + String.format("%04d", products.count() + 1);
                double day = p.path("pricePerDay").asDouble(0);
                pr.pricePerDay = day;
                pr.pricePerWeek = Math.round(day * 6);
                pr.pricePerMonth = Math.round(day * 22);
                pr.mrp = Math.round(day * 1.3);
                pr.securityDeposit = Math.max(500, Math.round(day * 3));
                pr.mainImage = p.path("image").asText();
                pr.imageUrls = new ArrayList<>(List.of(pr.mainImage));
                pr.description = "Rent the " + pr.name + " by the day, week or month. Delivered to your door and picked up when you are done.";
                pr.totalStock = 5;
                pr.availableStock = 5;
                pr.averageRating = 4.5;
                pr.featured = first && featuredCount < 8;
                if (first && pr.featured) featuredCount++;
                first = false;
                Map<String, Object> h = new LinkedHashMap<>();
                h.put("type", "ADDED");
                h.put("timestamp", Instant.now().toString());
                h.put("description", "Product listed");
                pr.statusHistory = new ArrayList<>(List.of(h));
                products.save(pr);
            }
        }
        for (String b : List.of("Sony", "Canon", "Apple", "Samsung", "Bosch", "Godrej", "Yamaha", "JBL", "Philips", "Generic")) {
            Brand br = new Brand();
            br.name = b;
            brands.save(br);
        }
        Campaign camp = new Campaign();
        camp.name = "Welcome Offers";
        camp.startAt = Instant.now().minus(1, ChronoUnit.DAYS);
        camp.endAt = Instant.now().plus(365, ChronoUnit.DAYS);
        camp.channels = new ArrayList<>(List.of("App", "Push"));
        camp.totalBudget = 100000;
        camp = campaigns.save(camp);
        coupon(camp, "WELCOME20", "PERCENT", 20, 500, 500, "20% off your first rental");
        coupon(camp, "FLAT100", "FLAT", 100, 0, 1000, "\u20B9100 off on orders above \u20B91000");
        log.info("Demo catalogue ready: {} categories, {} products", categories.count(), products.count());
    }

    private void coupon(Campaign camp, String code, String type, double value, double max, double min, String desc) {
        Coupon c = new Coupon();
        c.code = code;
        c.campaignId = camp.id;
        c.discountType = type;
        c.discountValue = value;
        c.maxDiscount = max;
        c.minOrder = min;
        c.startAt = camp.startAt;
        c.endAt = camp.endAt;
        c.description = desc;
        coupons.save(c);
    }
}
