package com.rentoindia.backend.engage;

import com.rentoindia.backend.common.ApiException;
import com.rentoindia.backend.common.ApiResponse;
import com.rentoindia.backend.common.Body;
import com.rentoindia.backend.common.CurrentUser;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/favorites")
public class FavoriteController {

    private final FavoriteRepository repo;

    public FavoriteController(FavoriteRepository repo) {
        this.repo = repo;
    }

    /** Returns the saved cards (the same JSON the app sent when saving). */
    @GetMapping
    public ApiResponse<List<Map<String, Object>>> list() {
        return ApiResponse.ok(repo.findByUserIdOrderByCreatedAtDesc(CurrentUser.id()).stream()
                .map(f -> f.data).toList());
    }

    @PostMapping
    @Transactional
    public ApiResponse<Void> add(@RequestBody Map<String, Object> b) {
        String name = Body.str(b, "name", Body.str(b, "productName", "")).trim();
        if (name.isEmpty()) throw ApiException.badRequest("name is required");
        Favorite f = repo.findFirstByUserIdAndProductNameIgnoreCase(CurrentUser.id(), name).orElseGet(Favorite::new);
        f.userId = CurrentUser.id();
        f.productName = name;
        f.data = new LinkedHashMap<>(b);
        repo.save(f);
        return ApiResponse.ok(null);
    }

    @DeleteMapping
    @Transactional
    public ApiResponse<Void> remove(@RequestParam String name) {
        repo.findFirstByUserIdAndProductNameIgnoreCase(CurrentUser.id(), name.trim()).ifPresent(repo::delete);
        return ApiResponse.ok(null);
    }
}
