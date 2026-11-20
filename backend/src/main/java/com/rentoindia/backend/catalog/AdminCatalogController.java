package com.rentoindia.backend.catalog;

import com.rentoindia.backend.common.ApiException;
import com.rentoindia.backend.common.ApiResponse;
import com.rentoindia.backend.common.Body;
import com.rentoindia.backend.common.Obj;
import com.rentoindia.backend.realtime.EventHub;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/** Admin panel: products, categories, sub-categories, brands. Requires ROLE_ADMIN (see SecurityConfig). */
@RestController
@RequestMapping("/api/v1/admin/catalog")
public class AdminCatalogController {

    private final CategoryRepository categories;
    private final SubCategoryRepository subs;
    private final BrandRepository brands;
    private final ProductRepository products;
    private final ProductService productService;
    private final EventHub hub;

    public AdminCatalogController(CategoryRepository categories, SubCategoryRepository subs, BrandRepository brands,
                                  ProductRepository products, ProductService productService, EventHub hub) {
        this.categories = categories;
        this.subs = subs;
        this.brands = brands;
        this.products = products;
        this.productService = productService;
        this.hub = hub;
    }

    // ------------------------------------------------------------------ products

    @GetMapping("/products")
    public ApiResponse<Obj> listProducts(@RequestParam(defaultValue = "") String status,
                                         @RequestParam(defaultValue = "") String category,
                                         @RequestParam(defaultValue = "") String q,
                                         @RequestParam(defaultValue = "0") int page,
                                         @RequestParam(defaultValue = "500") int size) {
        PageRequest pr = PageRequest.of(Math.max(0, page), Math.min(Math.max(1, size), 1000),
                Sort.by("createdAt").descending());
        Page<Product> res;
        if (status.isBlank()) {
            res = products.searchAny(category.trim(), q.trim(), pr);
        } else {
            Product.Status st = Body.enumOf(Product.Status.class, status, null);
            if (st == null) throw ApiException.badRequest("Unknown status: " + status);
            res = products.searchByStatus(st, category.trim(), "", q.trim(), pr);
        }
        Obj counts = Obj.of()
                .with("total", products.count())
                .with("active", products.countByStatus(Product.Status.ACTIVE))
                .with("inactive", products.countByStatus(Product.Status.INACTIVE))
                .with("outOfStock", products.countByStatus(Product.Status.OUT_OF_STOCK));
        return ApiResponse.ok(Obj.of().with("items", res.getContent()).with("total", res.getTotalElements())
                .with("counts", counts));
    }

    @GetMapping("/products/{id}")
    public ApiResponse<Product> getProduct(@PathVariable String id) {
        return ApiResponse.ok(productService.get(Body.parseUuid(id)));
    }

    @PostMapping("/products")
    public ApiResponse<Product> createProduct(@RequestBody Map<String, Object> b) {
        return ApiResponse.ok(productService.create(b, null, Body.str(b, "vendorName", "RENTO India")));
    }

    @PutMapping("/products/{id}")
    public ApiResponse<Product> updateProduct(@PathVariable String id, @RequestBody Map<String, Object> b) {
        return ApiResponse.ok(productService.update(productService.get(Body.parseUuid(id)), b));
    }

    @PostMapping("/products/{id}/status")
    public ApiResponse<Product> setStatus(@PathVariable String id, @RequestBody Map<String, Object> b) {
        Product.Status st = Body.enumOf(Product.Status.class, Body.str(b, "status"), null);
        if (st == null) throw ApiException.badRequest("Unknown status");
        return ApiResponse.ok(productService.setStatus(productService.get(Body.parseUuid(id)), st, Body.str(b, "note")));
    }

    @PostMapping("/products/{id}/inventory")
    public ApiResponse<Product> inventory(@PathVariable String id, @RequestBody Map<String, Object> b) {
        int change = Body.intv(b, "change", 0);
        if (change == 0) throw ApiException.badRequest("change must not be 0");
        return ApiResponse.ok(productService.adjustInventory(productService.get(Body.parseUuid(id)), change,
                Body.str(b, "reason", "")));
    }

    @DeleteMapping("/products/{id}")
    public ApiResponse<Void> deleteProduct(@PathVariable String id, @RequestParam(defaultValue = "") String reason) {
        productService.delete(productService.get(Body.parseUuid(id)), reason);
        return ApiResponse.ok("Deleted", null);
    }

    // ---------------------------------------------------------------- categories

    @GetMapping("/categories")
    public ApiResponse<List<Obj>> listCategories() {
        List<Obj> out = new ArrayList<>();
        for (Category c : categories.findAllByOrderBySortOrderAscNameAsc()) {
            List<SubCategory> sc = subs.findByCategoryIdOrderByNameAsc(c.id);
            out.add(Obj.of().with("id", c.id).with("name", c.name).with("icon", c.icon).with("active", c.active)
                    .with("productCount", products.countByCategory(c.name)).with("subcategories", sc));
        }
        return ApiResponse.ok(out);
    }

    @PostMapping("/categories")
    public ApiResponse<Category> addCategory(@RequestBody Map<String, Object> b) {
        String name = Body.str(b, "name", "").trim();
        if (name.isEmpty()) throw ApiException.badRequest("Category name is required");
        if (categories.findByNameIgnoreCase(name).isPresent()) throw ApiException.conflict("Category already exists");
        Category c = new Category();
        c.name = name;
        c.icon = Body.str(b, "icon", "generic");
        c.active = true;
        Category saved = categories.save(c);
        hub.publish("public", "catalog.changed", Obj.of().with("action", "category"));
        return ApiResponse.ok(saved);
    }

    @PostMapping("/categories/{id}/toggle")
    public ApiResponse<Category> toggleCategory(@PathVariable String id) {
        Category c = categories.findById(Body.parseUuid(id)).orElseThrow(() -> ApiException.notFound("Category not found"));
        c.active = !c.active;
        categories.save(c);
        for (SubCategory s : subs.findByCategoryIdOrderByNameAsc(c.id)) {
            s.active = c.active;
            subs.save(s);
        }
        hub.publish("public", "catalog.changed", Obj.of().with("action", "category"));
        return ApiResponse.ok(c);
    }

    @PostMapping("/categories/{id}/subcategories")
    public ApiResponse<SubCategory> addSub(@PathVariable String id, @RequestBody Map<String, Object> b) {
        Category c = categories.findById(Body.parseUuid(id)).orElseThrow(() -> ApiException.notFound("Category not found"));
        String name = Body.str(b, "name", "").trim();
        if (name.isEmpty()) throw ApiException.badRequest("Name is required");
        SubCategory s = new SubCategory();
        s.categoryId = c.id;
        s.name = name;
        SubCategory saved = subs.save(s);
        hub.publish("public", "catalog.changed", Obj.of().with("action", "subcategory"));
        return ApiResponse.ok(saved);
    }

    @PostMapping("/subcategories/{id}/toggle")
    public ApiResponse<SubCategory> toggleSub(@PathVariable String id) {
        SubCategory s = subs.findById(Body.parseUuid(id)).orElseThrow(() -> ApiException.notFound("Sub-category not found"));
        s.active = !s.active;
        hub.publish("public", "catalog.changed", Obj.of().with("action", "subcategory"));
        return ApiResponse.ok(subs.save(s));
    }

    // -------------------------------------------------------------------- brands

    @GetMapping("/brands")
    public ApiResponse<List<Obj>> listBrands() {
        List<Obj> out = new ArrayList<>();
        for (Brand b : brands.findAllByOrderByNameAsc()) {
            out.add(Obj.of().with("id", b.id).with("name", b.name).with("icon", b.icon).with("active", b.active)
                    .with("productCount", products.countByBrand(b.name)));
        }
        return ApiResponse.ok(out);
    }

    @PostMapping("/brands")
    public ApiResponse<Brand> addBrand(@RequestBody Map<String, Object> b) {
        String name = Body.str(b, "name", "").trim();
        if (name.isEmpty()) throw ApiException.badRequest("Brand name is required");
        if (brands.findByNameIgnoreCase(name).isPresent()) throw ApiException.conflict("Brand already exists");
        Brand br = new Brand();
        br.name = name;
        br.icon = Body.str(b, "icon", "generic");
        return ApiResponse.ok(brands.save(br));
    }

    @PostMapping("/brands/{id}/toggle")
    public ApiResponse<Brand> toggleBrand(@PathVariable String id) {
        Brand br = brands.findById(Body.parseUuid(id)).orElseThrow(() -> ApiException.notFound("Brand not found"));
        br.active = !br.active;
        return ApiResponse.ok(brands.save(br));
    }
}
