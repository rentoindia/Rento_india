package com.rentoindia.backend.engage;

import com.rentoindia.backend.auth.User;
import com.rentoindia.backend.auth.UserRepository;
import com.rentoindia.backend.catalog.Product;
import com.rentoindia.backend.catalog.ProductRepository;
import com.rentoindia.backend.common.ApiException;
import com.rentoindia.backend.common.ApiResponse;
import com.rentoindia.backend.common.Body;
import com.rentoindia.backend.common.CurrentUser;
import com.rentoindia.backend.common.Obj;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/reviews")
public class ReviewController {

    private final ReviewRepository reviews;
    private final ProductRepository products;
    private final UserRepository users;

    public ReviewController(ReviewRepository reviews, ProductRepository products, UserRepository users) {
        this.reviews = reviews;
        this.products = products;
        this.users = users;
    }

    /** Public: reviews of one product. */
    @GetMapping
    public ApiResponse<Obj> list(@RequestParam String productName) {
        List<Review> list = reviews.findByProductNameIgnoreCaseOrderByCreatedAtDesc(productName.trim());
        double avg = list.stream().mapToDouble(r -> r.rating).average().orElse(0);
        return ApiResponse.ok(Obj.of().with("items", list.stream().map(ReviewController::view).toList())
                .with("count", list.size()).with("average", Math.round(avg * 10.0) / 10.0));
    }

    @PostMapping
    @Transactional
    public ApiResponse<Obj> add(@RequestBody Map<String, Object> b) {
        UUID me = CurrentUser.id();
        String name = Body.str(b, "productName", "").trim();
        double rating = Body.dbl(b, "rating", 0);
        if (name.isEmpty()) throw ApiException.badRequest("productName is required");
        if (rating < 1 || rating > 5) throw ApiException.badRequest("Rating must be between 1 and 5");
        User u = users.findById(me).orElseThrow(() -> ApiException.unauthorized("Login required"));

        Review r = reviews.findFirstByProductNameIgnoreCaseAndUserId(name, me).orElseGet(Review::new);
        r.productName = name;
        r.userId = me;
        r.userName = u.fullName == null || u.fullName.isBlank() ? "Customer" : u.fullName;
        r.rating = rating;
        r.title = Body.str(b, "title");
        r.comment = Body.str(b, "comment", "");
        Product p = products.findFirstByNameIgnoreCase(name).orElse(null);
        if (p != null) r.productId = p.id;
        r = reviews.save(r);

        if (p != null) {
            List<Review> all = reviews.findByProductNameIgnoreCaseOrderByCreatedAtDesc(name);
            p.reviewCount = all.size();
            p.averageRating = Math.round(all.stream().mapToDouble(x -> x.rating).average().orElse(0) * 10.0) / 10.0;
            products.save(p);
        }
        return ApiResponse.ok(view(r));
    }

    public static Obj view(Review r) {
        return Obj.of().with("id", r.id).with("productName", r.productName).with("userName", r.userName)
                .with("rating", r.rating).with("title", r.title).with("comment", r.comment)
                .with("createdAt", r.createdAt);
    }
}
