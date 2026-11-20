package com.rentoindia.backend.notification;

import com.rentoindia.backend.common.Obj;
import com.rentoindia.backend.realtime.EventHub;
import org.springframework.stereotype.Service;

import java.util.UUID;

/** Creates an in-app notification and pushes it live over the WebSocket. */
@Service
public class NotificationService {

    private final NotificationRepository repo;
    private final EventHub hub;

    public NotificationService(NotificationRepository repo, EventHub hub) {
        this.repo = repo;
        this.hub = hub;
    }

    public Notification notify(UUID userId, String title, String message, String category,
                               String icon, String actionType, String refId) {
        if (userId == null) return null;
        Notification n = new Notification();
        n.userId = userId;
        n.title = title;
        n.subtitle = message;
        n.category = category == null ? "Alerts" : category;
        n.icon = icon;
        n.actionType = actionType;
        n.refId = refId;
        Notification saved = repo.save(n);
        hub.toUser(userId, "notification.new", view(saved));
        return saved;
    }

    public Notification notify(UUID userId, String title, String message, String category) {
        return notify(userId, title, message, category, null, null, null);
    }

    public static Obj view(Notification n) {
        return Obj.of().with("id", n.id).with("title", n.title).with("subtitle", n.subtitle)
                .with("category", n.category).with("icon", n.icon).with("actionType", n.actionType)
                .with("refId", n.refId).with("unread", n.unread).with("createdAt", n.createdAt);
    }
}
