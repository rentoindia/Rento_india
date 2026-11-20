package com.rentoindia.backend.ride;

import com.rentoindia.backend.common.ApiException;
import com.rentoindia.backend.common.ApiResponse;
import com.rentoindia.backend.common.Body;
import com.rentoindia.backend.common.CurrentUser;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

/** Saved addresses (Home / Work / ...) used by the parcel and ride booking screens. */
@RestController
@RequestMapping("/api/v1/addresses")
public class AddressController {

    private final SavedAddressRepository repo;

    public AddressController(SavedAddressRepository repo) {
        this.repo = repo;
    }

    private SavedAddress mine(String id) {
        SavedAddress a = repo.findById(Body.parseUuid(id)).orElseThrow(() -> ApiException.notFound("Address not found"));
        if (!a.userId.equals(CurrentUser.id())) throw ApiException.forbidden("This is not your address");
        return a;
    }

    private static void apply(SavedAddress a, Map<String, Object> b) {
        if (Body.has(b, "label")) a.label = Body.str(b, "label");
        if (Body.has(b, "title")) a.title = Body.str(b, "title");
        if (Body.has(b, "fullAddress")) a.fullAddress = Body.str(b, "fullAddress");
        if (Body.has(b, "contactName")) a.contactName = Body.str(b, "contactName");
        if (Body.has(b, "contactPhone")) a.contactPhone = Body.str(b, "contactPhone");
        if (Body.has(b, "lat")) a.lat = Body.dbl(b, "lat", a.lat);
        if (Body.has(b, "lng")) a.lng = Body.dbl(b, "lng", a.lng);
        if (Body.has(b, "isDefault")) a.isDefault = Body.bool(b, "isDefault", false);
    }

    @GetMapping
    public ApiResponse<List<SavedAddress>> list() {
        return ApiResponse.ok(repo.findByUserIdOrderByCreatedAtDesc(CurrentUser.id()));
    }

    @PostMapping
    public ApiResponse<SavedAddress> add(@RequestBody Map<String, Object> b) {
        SavedAddress a = new SavedAddress();
        a.userId = CurrentUser.id();
        apply(a, b);
        return ApiResponse.ok(repo.save(a));
    }

    @PutMapping("/{id}")
    public ApiResponse<SavedAddress> update(@PathVariable String id, @RequestBody Map<String, Object> b) {
        SavedAddress a = mine(id);
        apply(a, b);
        return ApiResponse.ok(repo.save(a));
    }

    @DeleteMapping("/{id}")
    public ApiResponse<Void> delete(@PathVariable String id) {
        repo.delete(mine(id));
        return ApiResponse.ok(null);
    }
}
