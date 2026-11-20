package com.rentoindia.backend.notification;

import com.rentoindia.backend.common.ApiException;
import com.rentoindia.backend.common.ApiResponse;
import com.rentoindia.backend.common.Body;
import com.rentoindia.backend.common.CurrentUser;
import com.rentoindia.backend.common.Obj;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/notifications")
public class NotificationController {

    private final NotificationRepository repo;

    public NotificationController(NotificationRepository repo) {
        this.repo = repo;
    }

    @GetMapping
    public ApiResponse<Obj> mine() {
        UUID me = CurrentUser.id();
        List<Obj> items = repo.findTop100ByUserIdOrderByCreatedAtDesc(me).stream()
                .map(NotificationService::view).toList();
        return ApiResponse.ok(Obj.of().with("items", items).with("unreadCount", repo.countByUserIdAndUnreadTrue(me)));
    }

    @PostMapping("/{id}/read")
    public ApiResponse<Void> read(@PathVariable String id) {
        Notification n = repo.findById(Body.parseUuid(id)).orElseThrow(() -> ApiException.notFound("Not found"));
        if (!n.userId.equals(CurrentUser.id())) throw ApiException.forbidden("Not yours");
        n.unread = false;
        repo.save(n);
        return ApiResponse.ok(null);
    }

    @PostMapping("/read-all")
    public ApiResponse<Void> readAll() {
        List<Notification> list = repo.findByUserIdAndUnreadTrue(CurrentUser.id());
        for (Notification n : list) n.unread = false;
        repo.saveAll(list);
        return ApiResponse.ok(null);
    }

    @DeleteMapping("/{id}")
    public ApiResponse<Void> delete(@PathVariable String id) {
        Notification n = repo.findById(Body.parseUuid(id)).orElseThrow(() -> ApiException.notFound("Not found"));
        if (!n.userId.equals(CurrentUser.id())) throw ApiException.forbidden("Not yours");
        repo.delete(n);
        return ApiResponse.ok(null);
    }
}
