package com.rentoindia.backend.payment;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rentoindia.backend.common.ApiException;
import com.rentoindia.backend.common.Obj;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.time.Duration;
import java.util.Base64;

/**
 * Razorpay helper. If RAZORPAY_KEY_ID / RAZORPAY_KEY_SECRET are NOT set the app runs in
 * "test mode": payments are accepted without a gateway so you can test everything end to end.
 * When the keys are set, the server creates real Razorpay orders and verifies the signature.
 */
@Service
public class PaymentService {

    @Value("${app.razorpay.key-id:}")
    private String keyId;
    @Value("${app.razorpay.key-secret:}")
    private String keySecret;

    private final ObjectMapper mapper;
    private final HttpClient http = HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(6)).build();

    public PaymentService(ObjectMapper mapper) {
        this.mapper = mapper;
    }

    public boolean configured() {
        return keyId != null && !keyId.isBlank() && keySecret != null && !keySecret.isBlank();
    }

    public String keyId() {
        return keyId;
    }

    /** Creates a Razorpay order for the given rupee amount. In test mode returns a fake order. */
    public Obj createOrder(double amountRupees, String receipt) {
        long paise = Math.round(amountRupees * 100);
        if (!configured()) {
            return Obj.of().with("mock", true).with("orderId", "order_test_" + System.currentTimeMillis())
                    .with("amount", paise).with("currency", "INR").with("keyId", "");
        }
        try {
            String body = "{\"amount\":" + paise + ",\"currency\":\"INR\",\"receipt\":\""
                    + (receipt == null ? "rcpt" : receipt.replace("\"", "")) + "\"}";
            String basic = Base64.getEncoder().encodeToString((keyId + ":" + keySecret).getBytes(StandardCharsets.UTF_8));
            HttpRequest req = HttpRequest.newBuilder(URI.create("https://api.razorpay.com/v1/orders"))
                    .timeout(Duration.ofSeconds(10))
                    .header("Authorization", "Basic " + basic)
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(body))
                    .build();
            HttpResponse<String> res = http.send(req, HttpResponse.BodyHandlers.ofString());
            if (res.statusCode() >= 300) throw ApiException.badRequest("Payment gateway error: " + res.body());
            JsonNode n = mapper.readTree(res.body());
            return Obj.of().with("mock", false).with("orderId", n.path("id").asText())
                    .with("amount", paise).with("currency", "INR").with("keyId", keyId);
        } catch (ApiException e) {
            throw e;
        } catch (Exception e) {
            throw ApiException.badRequest("Could not reach the payment gateway");
        }
    }

    /** HMAC-SHA256(orderId + "|" + paymentId, secret) must equal the signature sent by the app. */
    public boolean verifySignature(String orderId, String paymentId, String signature) {
        if (!configured()) return true;     // test mode
        if (orderId == null || paymentId == null || signature == null) return false;
        try {
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(new SecretKeySpec(keySecret.getBytes(StandardCharsets.UTF_8), "HmacSHA256"));
            byte[] raw = mac.doFinal((orderId + "|" + paymentId).getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder();
            for (byte b : raw) sb.append(String.format("%02x", b));
            return MessageDigest.isEqual(sb.toString().getBytes(StandardCharsets.UTF_8),
                    signature.getBytes(StandardCharsets.UTF_8));
        } catch (Exception e) {
            return false;
        }
    }
}
