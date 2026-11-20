import 'dart:async';

import 'package:flutter/foundation.dart';

import '../core/api_client.dart';
import '../core/json_utils.dart';
import '../core/realtime_client.dart';
import '../core/session.dart';

enum WalletTransactionType { earned, redeemed, refund }

class WalletTransaction {
  final String description;
  final double amount; // always positive; `type` implies the sign
  final WalletTransactionType type;
  final DateTime date;

  const WalletTransaction({
    required this.description,
    required this.amount,
    required this.type,
    required this.date,
  });
}

/// Coins wallet. The SERVER owns the balance (coins are earned when an order is paid,
/// spent when `coinsToRedeem` is sent with a payment, refunded when an order completes or
/// is cancelled). This class only shows what the server says, and updates live.
class WalletService extends ChangeNotifier {
  WalletService._internal() {
    Realtime.instance.on('wallet.updated').listen(_apply);
  }
  static final WalletService instance = WalletService._internal();

  double _coins = 0;
  double get coins => _coins;

  final List<WalletTransaction> _transactions = [];
  List<WalletTransaction> get transactions =>
      List.unmodifiable(_transactions.reversed);

  Future<void> load() async {
    if (!Session.instance.isLoggedIn) return;
    try {
      _apply(asMap(await Api.instance.get('/api/v1/wallet')));
    } catch (e) {
      debugPrint('wallet load failed: $e');
    }
  }

  void clear() {
    _coins = 0;
    _transactions.clear();
    notifyListeners();
  }

  void _apply(Map<String, dynamic> j) {
    _coins = dbl(j['coins']);
    _transactions
      ..clear()
      ..addAll(asMaps(j['transactions']).reversed.map(_tx));
    notifyListeners();
  }

  WalletTransaction _tx(Map<String, dynamic> t) {
    final type = switch (str(t['type']).toUpperCase()) {
      'REDEEMED' => WalletTransactionType.redeemed,
      'REFUND' => WalletTransactionType.refund,
      _ => WalletTransactionType.earned,
    };
    return WalletTransaction(
      description: str(t['description']),
      amount: dbl(t['amount']),
      type: type,
      date: date(t['date']) ?? DateTime.now(),
    );
  }

  /// Coins are credited by the server when an order is paid. Kept so old call sites still compile.
  void earn(double amount, String description) {}

  /// Returns how many coins can be used. The real deduction happens on the server
  /// when the payment is made with `coinsToRedeem`.
  double redeem(double requestedAmount, String description) {
    return requestedAmount.clamp(0, _coins).toDouble();
  }

  /// Refunds are created by the server (cancelled order / completed rental).
  void refund(double amount, String description) {}
}
