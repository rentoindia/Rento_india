package com.rentoindia.backend.auth;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.Duration;

/**
 * Sends the OTP SMS. With SMS_PROVIDER=none (default) nothing is sent: the OTP is only
 * logged and (in dev-mode) returned by the API. With SMS_PROVIDER=msg91 it calls the
 * MSG91 "Send OTP" API using MSG91_AUTH_KEY + MSG91_TEMPLATE_ID.
 * (Verify the exact URL/params against your MSG91 dashboard docs when you get the key.)
 */
@Component
public class SmsSender {

    private static final Logger log = LoggerFactory.getLogger(SmsSender.class);

    @Value("${app.sms.provider:none}")
    private String provider;
    @Value("${app.sms.msg91-auth-key:}")
    private String msg91Key;
    @Value("${app.sms.msg91-template-id:}")
    private String msg91Template;

    private final HttpClient http = HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(5)).build();

    public void sendOtp(String phone, String code) {
        if (!"msg91".equalsIgnoreCase(provider)) {
            log.info("[OTP] {} -> {} (no SMS provider configured)", phone, code);
            return;
        }
        try {
            String url = "https://control.msg91.com/api/v5/otp?template_id=" + enc(msg91Template)
                    + "&mobile=" + enc("91" + phone) + "&authkey=" + enc(msg91Key) + "&otp=" + enc(code);
            HttpRequest req = HttpRequest.newBuilder(URI.create(url))
                    .timeout(Duration.ofSeconds(8))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.noBody())
                    .build();
            HttpResponse<String> res = http.send(req, HttpResponse.BodyHandlers.ofString());
            if (res.statusCode() >= 300) {
                log.warn("MSG91 returned {} : {}", res.statusCode(), res.body());
            }
        } catch (Exception e) {
            log.warn("Could not send SMS via MSG91: {}", e.getMessage());
        }
    }

    private static String enc(String s) {
        return URLEncoder.encode(s, StandardCharsets.UTF_8);
    }
}
