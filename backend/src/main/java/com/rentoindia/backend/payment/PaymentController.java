package com.rentoindia.backend.payment;

import com.rentoindia.backend.common.ApiResponse;
import com.rentoindia.backend.common.Body;
import com.rentoindia.backend.common.Obj;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api/v1/payments")
public class PaymentController {

    private final PaymentService payments;

    public PaymentController(PaymentService payments) {
        this.payments = payments;
    }

    /** App calls this before opening the Razorpay checkout. Body: {amount (rupees), receipt}. */
    @PostMapping("/razorpay/order")
    public ApiResponse<Obj> createOrder(@RequestBody Map<String, Object> b) {
        return ApiResponse.ok(payments.createOrder(Body.dbl(b, "amount", 0), Body.str(b, "receipt", "rcpt")));
    }
}
