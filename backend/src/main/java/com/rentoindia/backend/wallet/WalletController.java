package com.rentoindia.backend.wallet;

import com.rentoindia.backend.common.ApiException;
import com.rentoindia.backend.common.ApiResponse;
import com.rentoindia.backend.common.Body;
import com.rentoindia.backend.common.CurrentUser;
import com.rentoindia.backend.common.Obj;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api/v1/wallet")
public class WalletController {

    private final WalletService wallet;

    public WalletController(WalletService wallet) {
        this.wallet = wallet;
    }

    @GetMapping
    public ApiResponse<Obj> get() {
        return ApiResponse.ok(wallet.summary(CurrentUser.id()));
    }

    /** Spend coins (e.g. at checkout). Returns how many coins were actually redeemed. */
    @PostMapping("/redeem")
    public ApiResponse<Obj> redeem(@RequestBody Map<String, Object> b) {
        double req = Body.dbl(b, "amount", 0);
        if (req <= 0) throw ApiException.badRequest("amount must be positive");
        double actual = wallet.redeem(CurrentUser.id(), req, Body.str(b, "description", "Coins redeemed"),
                Body.str(b, "orderId"));
        return ApiResponse.ok(Obj.of().with("redeemed", actual).with("coins", wallet.balance(CurrentUser.id())));
    }
}
