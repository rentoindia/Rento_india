package com.rentoindia.backend.wallet;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface WalletTxRepository extends JpaRepository<WalletTx, UUID> {
    List<WalletTx> findByUserIdOrderByCreatedAtDesc(UUID userId);
}
