package com.rentoindia.backend.realtime;

import com.rentoindia.backend.config.JwtService;
import io.jsonwebtoken.Claims;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.HandshakeInterceptor;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.List;
import java.util.Map;

/** Exposes ws://HOST:8080/ws?token=<JWT access token> */
@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

    private final WsHandler handler;
    private final JwtService jwt;

    public WebSocketConfig(WsHandler handler, JwtService jwt) {
        this.handler = handler;
        this.jwt = jwt;
    }

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(handler, "/ws")
                .addInterceptors(new HandshakeInterceptor() {
                    @Override
                    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response,
                                                   WebSocketHandler wsHandler, Map<String, Object> attributes) {
                        String token = UriComponentsBuilder.fromUri(request.getURI()).build()
                                .getQueryParams().getFirst("token");
                        if (token == null) return false;
                        Claims c = jwt.tryParse(token);
                        if (c == null || !"access".equals(c.get("typ"))) return false;
                        List<String> roles = JwtService.roles(c);
                        attributes.put("userId", c.getSubject());
                        attributes.put("roles", roles);
                        return true;
                    }

                    @Override
                    public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response,
                                               WebSocketHandler wsHandler, Exception exception) { }
                })
                .setAllowedOriginPatterns("*");
    }
}
