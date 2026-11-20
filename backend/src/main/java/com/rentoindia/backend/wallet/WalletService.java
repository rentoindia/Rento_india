package com.rentoindia.backend.wallet;

import com.rentoindia.backend.common.Obj;
import com.rentoindia.backend.realtime.EventHub;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class WalletService {

    private final WalletTxRepository repo;
    private final EventHub hub;

    public WalletService(WalletTxRepository repo, EventHub hub) {
        this.repo = repo;
        this.hub = hub;
    }

    public double balance(UUID userId) {
        double sum = 0;
        for (WalletTx t : repo.findByUserIdOrderByCreatedAtDesc(userId)) {
            sum += t.type == WalletTx.Type.REDEEMED ? -t.amount : t.amount;
        }
        return Math.max(0, sum);
    }

    public WalletTx earn(UUID userId, double amount, String description, String orderId) {
        return add(userId, amount, WalletTx.Type.EARNED, description, orderId);
    }

    public WalletTx refund(UUID userId, double amount, String description, String orderId) {
        return add(userId, amount, WalletTx.Type.REFUND, description, orderId);
    }

    /** Redeems at most the available balance; returns what was actually redeemed (0 if nothing). */
    public double redeem(UUID userId, double requested, String description, String orderId) {
        double actual = Math.min(Math.max(0, requested), balance(userId));
        if (actual <= 0) return 0;
        add(userId, actual, WalletTx.Type.REDEEMED, description, orderId);
        return actual;
    }

    private WalletTx add(UUID userId, double amount, WalletTx.Type type, String description, String orderId) {
        if (amount <= 0) return null;
        WalletTx t = new WalletTx();
        t.userId = userId;
        t.amount = amount;
        t.type = type;
        t.description = description;
        t.orderId = orderId;
        WalletTx saved = repo.save(t);
        hub.toUser(userId, "wallet.updated", summary(userId));
        return saved;
    }

    public Obj summary(UUID userId) {
        List<Obj> txs = repo.findByUserIdOrderByCreatedAtDesc(userId).stream().map(WalletService::view).toList();
        return Obj.of().with("coins", balance(userId)).with("transactions", txs);
    }

    public static Obj view(WalletTx t) {
        return Obj.of().with("id", t.id).with("description", t.description).with("amount", t.amount)
                .with("type", t.type.name()).with("orderId", t.orderId).with("date", t.createdAt);
    }
}
