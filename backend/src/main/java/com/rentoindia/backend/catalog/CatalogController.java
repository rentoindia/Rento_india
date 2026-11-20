package com.rentoindia.backend.catalog;

import com.rentoindia.backend.common.ApiException;
import com.rentoindia.backend.common.ApiResponse;
import com.rentoindia.backend.common.Body;
import com.rentoindia.backend.common.Obj;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

/** Public product catalogue used by the shopper side of the user app (no login needed). */
@RestController
@RequestMapping("/api/v1/catalog")
public class CatalogController {

    private final CategoryRepository categories;
    private final SubCategoryRepository subs;
    private final BrandRepository brands;
    private final ProductRepository products;
    private final ProductService productService;

    public CatalogController(CategoryRepository categories, SubCategoryRepository subs, BrandRepository brands,
                             ProductRepository products, ProductService productService) {
        this.categories = categories;
        this.subs = subs;
        this.brands = brands;
        this.products = products;
        this.productService = productService;
    }

    @GetMapping("/categories")
    public ApiResponse<List<Obj>> categories() {
        List<Obj> out = new ArrayList<>();
        for (Category c : categories.findByActiveTrueOrderBySortOrderAscNameAsc()) {
            List<Obj> subList = new ArrayList<>();
            for (SubCategory s : subs.findByCategoryIdOrderByNameAsc(c.id)) {
                if (s.active) subList.add(Obj.of().with("id", s.id).with("name", s.name));
            }
            out.add(Obj.of().with("id", c.id).with("name", c.name).with("icon", c.icon)
                    .with("productCount", products.countByCategory(c.name))
                    .with("subcategories", subList));
        }
        return ApiResponse.ok(out);
    }

    @GetMapping("/brands")
    public ApiResponse<List<Brand>> brands() {
        return ApiResponse.ok(brands.findByActiveTrueOrderByNameAsc());
    }

    @GetMapping("/products")
    public ApiResponse<Obj> list(@RequestParam(defaultValue = "") String category,
                                 @RequestParam(defaultValue = "") String subcategory,
                                 @RequestParam(defaultValue = "") String q,
                                 @RequestParam(defaultValue = "new") String sort,
                                 @RequestParam(defaultValue = "0") int page,
                                 @RequestParam(defaultValue = "50") int size) {
        Sort s = switch (sort) {
            case "priceAsc" -> Sort.by("pricePerDay").ascending();
            case "priceDesc" -> Sort.by("pricePerDay").descending();
            case "rating" -> Sort.by("averageRating").descending();
            default -> Sort.by("createdAt").descending();
        };
        Page<Product> res = products.searchActive(category.trim(), subcategory.trim(), q.trim(),
                PageRequest.of(Math.max(0, page), Math.min(Math.max(1, size), 200), s));
        return ApiResponse.ok(Obj.of().with("items", res.getContent())
                .with("total", res.getTotalElements()).with("page", page).with("size", size));
    }

    @GetMapping("/products/featured")
    public ApiResponse<List<Product>> featured() {
        return ApiResponse.ok(products.findByFeaturedTrueAndStatusOrderByCreatedAtDesc(Product.Status.ACTIVE));
    }

    @GetMapping("/products/by-name")
    public ApiResponse<Product> byName(@RequestParam String name) {
        return ApiResponse.ok(products.findFirstByNameIgnoreCase(name.trim())
                .orElseThrow(() -> ApiException.notFound("Product not found")));
    }

    @GetMapping("/products/{id}")
    public ApiResponse<Product> one(@PathVariable String id) {
        return ApiResponse.ok(productService.get(Body.parseUuid(id)));
    }
}
