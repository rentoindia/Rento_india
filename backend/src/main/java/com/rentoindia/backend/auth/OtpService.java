package com.rentoindia.backend.auth;

import com.rentoindia.backend.common.ApiException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.security.SecureRandom;
import java.time.Instant;

@Service
public class OtpService {

    private final OtpCodeRepository repo;
    private final SmsSender sms;
    private final SecureRandom random = new SecureRandom();

    @Value("${app.otp.expiry-seconds:300}")
    private long expirySeconds;
    @Value("${app.otp.length:4}")
    private int length;
    @Value("${app.otp.dev-mode:true}")
    private boolean devMode;

    public OtpService(OtpCodeRepository repo, SmsSender sms) {
        this.repo = repo;
        this.sms = sms;
    }

    /** Creates + sends an OTP. Returns the code ONLY in dev-mode (so the app can display it). */
    public String request(String phone) {
        long recent = repo.countByPhoneAndCreatedAtAfter(phone, Instant.now().minusSeconds(600));
        if (recent >= 10) {
            throw new ApiException("Too many OTP requests. Please try again in a few minutes.",
                    HttpStatus.TOO_MANY_REQUESTS);
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < length; i++) sb.append(random.nextInt(10));
        String code = sb.toString();

        OtpCode otp = new OtpCode();
        otp.phone = phone;
        otp.code = code;
        otp.expiresAt = Instant.now().plusSeconds(expirySeconds);
        repo.save(otp);

        sms.sendOtp(phone, code);
        return devMode ? code : null;
    }

    public void verify(String phone, String code) {
        OtpCode otp = repo.findTopByPhoneAndUsedFalseOrderByCreatedAtDesc(phone)
                .orElseThrow(() -> ApiException.badRequest("Please request an OTP first"));
        if (otp.expiresAt.isBefore(Instant.now())) {
            throw ApiException.badRequest("OTP expired. Please request a new one");
        }
        if (otp.attemptCount >= 5) {
            throw ApiException.badRequest("Too many wrong attempts. Please request a new OTP");
        }
        if (!otp.code.equals(code)) {
            otp.attemptCount++;
            repo.save(otp);               // saved immediately (this method is not transactional)
            throw ApiException.badRequest("Incorrect OTP");
        }
        otp.used = true;
        repo.save(otp);
    }
}
