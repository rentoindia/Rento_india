package com.rentoindia.backend.common;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;

@RestController
public class HealthController {

    @GetMapping("/health")
    public Obj health() {
        return Obj.of().with("status", "UP").with("time", Instant.now().toString());
    }
}
