package com.rentoindia.backend.catalog;

import com.rentoindia.backend.common.ApiException;
import com.rentoindia.backend.common.Body;
import com.rentoindia.backend.common.Obj;
import com.rentoindia.backend.realtime.EventHub;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class ProductService {

    private final ProductRepository products;
    private final EventHub hub;

    public ProductService(ProductRepository products, EventHub hub) {
        this.products = products;
        this.hub = hub;
    }

    public Product get(UUID id) {
        return products.findById(id).orElseThrow(() -> ApiException.notFound("Product not found"));
    }

    /** Copies the fields present in the JSON body onto the product. Works for admin and lender forms. */
    public void apply(Product p, Map<String, Object> b) {
        if (Body.has(b, "name")) p.name = Body.str(b, "name", p.name);
        if (Body.has(b, "sku")) p.sku = Body.str(b, "sku");
        if (Body.has(b, "category")) p.category = Body.str(b, "category");
        if (Body.has(b, "subcategory")) p.subcategory = Body.str(b, "subcategory");
        if (Body.has(b, "brand")) p.brand = Body.str(b, "brand");
        if (Body.has(b, "description")) p.description = Body.str(b, "description");
        if (Body.has(b, "vendorName")) p.vendorName = Body.str(b, "vendorName");
        if (Body.has(b, "mrp")) p.mrp = Body.dbl(b, "mrp", p.mrp);
        if (Body.has(b, "pricePerDay")) p.pricePerDay = Body.dbl(b, "pricePerDay", p.pricePerDay);
        if (Body.has(b, "pricePerWeek")) p.pricePerWeek = Body.dbl(b, "pricePerWeek", p.pricePerWeek);
        if (Body.has(b, "pricePerMonth")) p.pricePerMonth = Body.dbl(b, "pricePerMonth", p.pricePerMonth);
        if (Body.has(b, "securityDeposit")) p.securityDeposit = Body.dbl(b, "securityDeposit", p.securityDeposit);
        if (Body.has(b, "featured")) p.featured = Body.bool(b, "featured", p.featured);
        if (Body.has(b, "videoUrl")) p.videoUrl = Body.str(b, "videoUrl");
        if (Body.has(b, "totalStock")) p.totalStock = Math.max(0, Body.intv(b, "totalStock", p.totalStock));
        if (Body.has(b, "availableStock")) p.availableStock = Math.max(0, Body.intv(b, "availableStock", p.availableStock));
        if (Body.has(b, "maintenanceStock")) p.maintenanceStock = Math.max(0, Body.intv(b, "maintenanceStock", p.maintenanceStock));

        if (Body.has(b, "imageUrls") || Body.has(b, "images")) {
            List<String> imgs = new ArrayList<>();
            for (String s : Body.strings(b, Body.has(b, "imageUrls") ? "imageUrls" : "images")) {
                if (s != null && !s.isBlank() && !"null".equals(s)) imgs.add(s);
            }
            p.imageUrls = imgs;
        }
        if (Body.has(b, "mainImage")) p.mainImage = Body.str(b, "mainImage");
        if ((p.mainImage == null || p.mainImage.isBlank()) && p.imageUrls != null && !p.imageUrls.isEmpty()) {
            p.mainImage = p.imageUrls.get(0);
        }

        if (Body.has(b, "specs") || Body.has(b, "specifications")) {
            List<Map<String, Object>> out = new ArrayList<>();
            for (Map<String, Object> s : Body.maps(b, Body.has(b, "specs") ? "specs" : "specifications")) {
                Map<String, Object> e = new LinkedHashMap<>();
                String label = Body.str(s, "label", Body.str(s, "key", ""));
                String value = Body.str(s, "value", "");
                if (label.isBlank() && value.isBlank()) continue;
                e.put("label", label);
                e.put("value", value);
                out.add(e);
            }
            p.specs = out;
        }
        if (Body.has(b, "variants")) {
            p.variants = new ArrayList<>(Body.maps(b, "variants"));
        }
        if (Body.has(b, "status")) {
            p.status = Body.enumOf(Product.Status.class, Body.str(b, "status"), p.status);
        }
    }

    public Product create(Map<String, Object> b, UUID lenderId, String vendorName) {
        Product p = new Product();
        p.lenderId = lenderId;
        p.vendorName = vendorName;
        apply(p, b);
        if (p.name == null || p.name.isBlank()) throw ApiException.badRequest("Product name is required");
        if (p.pricePerDay <= 0) throw ApiException.badRequest("Price per day is required");
        if (p.sku == null || p.sku.isBlank()) {
            p.sku = "SKU-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        }
        if (!Body.has(b, "totalStock")) {
            p.totalStock = 1;
            p.availableStock = 1;
        } else if (!Body.has(b, "availableStock")) {
            p.availableStock = p.totalStock;
        }
        history(p, "ADDED", "Product listed");
        Product saved = products.save(p);
        changed(saved, "created");
        return saved;
    }

    public Product update(Product p, Map<String, Object> b) {
        Product.Status before = p.status;
        apply(p, b);
        if (p.status != before) history(p, p.status.name(), "Status changed to " + p.status.name());
        Product saved = products.save(p);
        changed(saved, "updated");
        return saved;
    }

    public Product setStatus(Product p, Product.Status status, String note) {
        if (p.status != status) {
            p.status = status;
            history(p, status.name(), note == null || note.isBlank() ? "Status changed to " + status.name() : note);
        }
        Product saved = products.save(p);
        changed(saved, "status");
        return saved;
    }

    public Product adjustInventory(Product p, int change, String reason) {
        p.totalStock = Math.max(0, p.totalStock + change);
        p.availableStock = Math.max(0, p.availableStock + change);
        Map<String, Object> log = new LinkedHashMap<>();
        log.put("date", Instant.now().toString());
        log.put("change", change);
        log.put("reason", reason == null ? "" : reason);
        List<Map<String, Object>> logs = new ArrayList<>(p.inventoryLogs);
        logs.add(0, log);
        p.inventoryLogs = logs;
        if (p.availableStock == 0 && p.status == Product.Status.ACTIVE) {
            p.status = Product.Status.OUT_OF_STOCK;
            history(p, "OUT_OF_STOCK", "No stock available");
        } else if (p.availableStock > 0 && p.status == Product.Status.OUT_OF_STOCK) {
            p.status = Product.Status.ACTIVE;
            history(p, "ACTIVE", "Back in stock");
        }
        Product saved = products.save(p);
        changed(saved, "inventory");
        return saved;
    }

    public void delete(Product p, String reason) {
        products.delete(p);
        hub.toAdmins("product.deleted", Obj.of().with("id", p.id).with("reason", reason));
        hub.publish("public", "catalog.changed", Obj.of().with("productId", p.id).with("action", "deleted"));
    }

    public void history(Product p, String type, String description) {
        Map<String, Object> h = new LinkedHashMap<>();
        h.put("type", type);
        h.put("timestamp", Instant.now().toString());
        h.put("description", description);
        List<Map<String, Object>> list = new ArrayList<>(p.statusHistory);
        list.add(0, h);
        p.statusHistory = list;
    }

    private void changed(Product p, String action) {
        Obj ev = Obj.of().with("productId", p.id).with("name", p.name).with("action", action);
        hub.toAdmins("product.updated", ev);
        hub.publish("public", "catalog.changed", ev);
    }
}
