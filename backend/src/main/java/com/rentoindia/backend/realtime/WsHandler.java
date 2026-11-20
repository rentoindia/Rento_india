package com.rentoindia.backend.realtime;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rentoindia.backend.delivery.RiderRepository;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Protocol (JSON text frames):
 *   server -> client : {"type":"order.updated","topic":"user:..","payload":{..},"ts":".."}
 *   client -> server : {"action":"subscribe","topic":"ride:<id>"}
 *                      {"action":"unsubscribe","topic":"ride:<id>"}
 *                      {"action":"ping"}
 */
@Component
public class WsHandler extends TextWebSocketHandler {

    private static final List<String> OPEN_PREFIXES = List.of("order:", "trip:", "ride:", "parcel:", "property:");

    private final EventHub hub;
    private final ObjectMapper mapper;
    // raw session id -> decorated (thread-safe) session
    private final Map<String, WebSocketSession> decorated = new HashMap<>();

    private final RiderRepository riders;

    public WsHandler(EventHub hub, ObjectMapper mapper, RiderRepository riders) {
        this.hub = hub;
        this.mapper = mapper;
        this.riders = riders;
    }

    private boolean isRider(String userId) {
        try {
            return riders.findByUserId(java.util.UUID.fromString(userId)).isPresent();
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession raw) throws Exception {
        WebSocketSession s = hub.wrap(raw);
        synchronized (decorated) {
            decorated.put(raw.getId(), s);
        }
        String userId = (String) raw.getAttributes().get("userId");
        @SuppressWarnings("unchecked")
        List<String> roles = (List<String>) raw.getAttributes().get("roles");
        hub.subscribe(s, "user:" + userId);
        hub.subscribe(s, "public");
        if (roles != null && (roles.contains("ADMIN") || roles.contains("SUPER_ADMIN"))) hub.subscribe(s, "admin");
        if ((roles != null && roles.contains("RIDER")) || isRider(userId)) hub.subscribe(s, "riders");
        s.sendMessage(new TextMessage("{\"type\":\"connected\",\"payload\":{\"userId\":\"" + userId + "\"}}"));
    }

    @Override
    protected void handleTextMessage(WebSocketSession raw, TextMessage message) throws Exception {
        WebSocketSession s;
        synchronized (decorated) {
            s = decorated.get(raw.getId());
        }
        if (s == null) return;
        JsonNode n = mapper.readTree(message.getPayload());
        String action = n.path("action").asText("");
        String topic = n.path("topic").asText("");
        switch (action) {
            case "ping" -> s.sendMessage(new TextMessage("{\"type\":\"pong\"}"));
            case "subscribe" -> {
                if (allowed(raw, topic)) hub.subscribe(s, topic);
            }
            case "unsubscribe" -> hub.unsubscribe(s, topic);
            default -> { }
        }
    }

    private boolean allowed(WebSocketSession raw, String topic) {
        for (String p : OPEN_PREFIXES) {
            if (topic.startsWith(p)) return true;
        }
        @SuppressWarnings("unchecked")
        List<String> roles = (List<String>) raw.getAttributes().get("roles");
        if (topic.equals("admin")) return roles != null && (roles.contains("ADMIN") || roles.contains("SUPER_ADMIN"));
        if (topic.equals("riders")) {
            return (roles != null && roles.contains("RIDER")) || isRider((String) raw.getAttributes().get("userId"));
        }
        return false;
    }

    @Override
    public void afterConnectionClosed(WebSocketSession raw, CloseStatus status) {
        WebSocketSession s;
        synchronized (decorated) {
            s = decorated.remove(raw.getId());
        }
        if (s != null) hub.remove(s);
    }

    @Override
    public void handleTransportError(WebSocketSession raw, Throwable exception) {
        afterConnectionClosed(raw, CloseStatus.SERVER_ERROR);
    }
}
