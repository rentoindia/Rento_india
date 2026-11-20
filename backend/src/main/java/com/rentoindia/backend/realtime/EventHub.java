package com.rentoindia.backend.realtime;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.transaction.support.TransactionSynchronization;
import org.springframework.transaction.support.TransactionSynchronizationManager;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.ConcurrentWebSocketSessionDecorator;

import java.time.Instant;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

/**
 * The realtime backbone. Every WebSocket client is subscribed to "topics":
 *   user:{userId}  - private events for one user (order updates, notifications...)
 *   admin          - every admin screen listens here (new order, SOS, KYC...)
 *   riders         - all online riders (new delivery / parcel / ride request)
 *   order:{id}, trip:{id}, ride:{id}, parcel:{id} - live updates for one item
 *
 * Services call publish()/toUser()/toAdmins(); events are sent only AFTER the
 * database transaction commits, so clients never see data that was rolled back.
 */
@Component
public class EventHub {

    private static final Logger log = LoggerFactory.getLogger(EventHub.class);

    private final ObjectMapper mapper;
    private final Map<String, Set<WebSocketSession>> topics = new ConcurrentHashMap<>();
    private final Map<String, Set<String>> sessionTopics = new ConcurrentHashMap<>();

    public EventHub(ObjectMapper mapper) {
        this.mapper = mapper;
    }

    // ---------- session management ----------

    public WebSocketSession wrap(WebSocketSession raw) {
        return new ConcurrentWebSocketSessionDecorator(raw, 10_000, 512 * 1024);
    }

    public void subscribe(WebSocketSession s, String topic) {
        topics.computeIfAbsent(topic, k -> ConcurrentHashMap.newKeySet()).add(s);
        sessionTopics.computeIfAbsent(s.getId(), k -> ConcurrentHashMap.newKeySet()).add(topic);
    }

    public void unsubscribe(WebSocketSession s, String topic) {
        Set<WebSocketSession> set = topics.get(topic);
        if (set != null) set.remove(s);
        Set<String> mine = sessionTopics.get(s.getId());
        if (mine != null) mine.remove(topic);
    }

    public void remove(WebSocketSession s) {
        Set<String> mine = sessionTopics.remove(s.getId());
        if (mine == null) return;
        for (String t : mine) {
            Set<WebSocketSession> set = topics.get(t);
            if (set != null) set.remove(s);
        }
    }

    // ---------- publishing ----------

    public void toUser(UUID userId, String type, Object payload) {
        if (userId != null) publish("user:" + userId, type, payload);
    }

    public void toAdmins(String type, Object payload) {
        publish("admin", type, payload);
    }

    public void toRiders(String type, Object payload) {
        publish("riders", type, payload);
    }

    public void publish(String topic, String type, Object payload) {
        if (TransactionSynchronizationManager.isSynchronizationActive()) {
            TransactionSynchronizationManager.registerSynchronization(new TransactionSynchronization() {
                @Override
                public void afterCommit() {
                    send(topic, type, payload);
                }
            });
        } else {
            send(topic, type, payload);
        }
    }

    private void send(String topic, String type, Object payload) {
        Set<WebSocketSession> set = topics.getOrDefault(topic, Collections.emptySet());
        if (set.isEmpty()) return;
        String json;
        try {
            Map<String, Object> msg = new LinkedHashMap<>();
            msg.put("type", type);
            msg.put("topic", topic);
            msg.put("payload", payload);
            msg.put("ts", Instant.now().toString());
            json = mapper.writeValueAsString(msg);
        } catch (Exception e) {
            log.warn("Could not serialize realtime event {}: {}", type, e.getMessage());
            return;
        }
        TextMessage text = new TextMessage(json);
        for (WebSocketSession s : set) {
            try {
                if (s.isOpen()) s.sendMessage(text);
            } catch (Exception e) {
                log.debug("Dropping dead websocket session {}", s.getId());
                remove(s);
            }
        }
    }
}
