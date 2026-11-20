import 'dart:async';

import 'package:flutter/foundation.dart';

import '../core/api_client.dart';
import '../core/json_utils.dart';
import '../core/realtime_client.dart';
import '../core/session.dart';
import '../screens/rental_order.dart';
import 'wallet_service.dart';

/// The customer's rental orders.
///
/// The SERVER decides the order status (vendor accepted, rider assigned, delivered ...).
/// This class:
///   * loads the orders at login and keeps them live through the realtime connection
///   * sends the few things a customer is allowed to do (create, pay, schedule return,
///     extend, cancel, change details) when old screens call [upsert]
///   * ignores status changes that only the vendor / rider / admin may make
class OrdersService extends ChangeNotifier {
  OrdersService._internal() {
    Realtime.instance.on('order.updated').listen(_onServerOrder);
  }
  static final OrdersService instance = OrdersService._internal();

  static final RegExp _uuid = RegExp(
    r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
  );

  final List<RentalOrder> _orders = []; // oldest first
  final Map<String, String> _serverIds = {}; // local screen id -> server id

  /// Last error message from the server (null when everything is fine).
  String? lastError;

  List<RentalOrder> get orders => List.unmodifiable(_orders.reversed);
  List<RentalOrder> get activeOrders =>
      orders.where((o) => o.status.isActive).toList();
  List<RentalOrder> get pastOrders =>
      orders.where((o) => !o.status.isActive).toList();

  RentalOrder? findById(String id) {
    final real = _serverIds[id] ?? id;
    for (final o in _orders) {
      if (o.id == real) return o;
    }
    return null;
  }

  int countFor(OrderStatus status) =>
      _orders.where((o) => o.status == status).length;

  // ------------------------------------------------------------------ loading

  Future<void> load() async {
    if (!Session.instance.isLoggedIn) return;
    try {
      final list = asMaps(await Api.instance.get('/api/v1/orders'));
      _orders
        ..clear()
        ..addAll(list.reversed.map(RentalOrder.fromApi));
      lastError = null;
      notifyListeners();
    } catch (e) {
      debugPrint('orders load failed: $e');
    }
  }

  void clear() {
    _orders.clear();
    _serverIds.clear();
    notifyListeners();
  }

  void _onServerOrder(Map<String, dynamic> j) {
    // events are also sent to lenders about orders of OTHER customers: ignore those
    if (str(j['customerId']) != Session.instance.userId) return;
    _apply(RentalOrder.fromApi(j));
  }

  void _apply(RentalOrder o) {
    final i = _orders.indexWhere((x) => x.id == o.id);
    if (i >= 0) {
      _orders[i] = o;
    } else {
      _orders.add(o);
    }
    notifyListeners();
  }

  // ------------------------------------------------------------ explicit actions

  /// Creates the order on the server. Returns the real order (with its server id and OTP).
  Future<RentalOrder> createOrder(
    RentalOrder draft, {
    String? couponCode,
  }) async {
    final d = asMap(
      await Api.instance.post(
        '/api/v1/orders',
        body: {
          'productName': draft.name,
          'categoryLabel': draft.categoryLabel,
          'imageUrl': draft.imageUrl,
          'ratePerDay': draft.ratePerDay,
          'securityDeposit': draft.securityDepositValue,
          'startDate': isoUtc(draft.startDate),
          'endDate': isoUtc(draft.endDate),
          'deliveryFee': draft.deliveryFee,
          'platformFee': draft.platformFee,
          'pickupFee': draft.pickupFee,
          'deliveryAddress': draft.deliveryAddress,
          'deliveryDate': isoUtc(draft.deliveryDate),
          'deliverySlot': draft.deliverySlot,
          'purchaseRequested': draft.purchaseRequested,
          'isAvailableForPurchase': draft.isAvailableForPurchase,
          'purchasePrice': draft.purchasePrice,
          if (couponCode != null && couponCode.isNotEmpty)
            'couponCode': couponCode,
        },
      ),
    );
    final created = RentalOrder.fromApi(d);
    _serverIds[draft.id] = created.id;
    _orders.removeWhere((o) => o.id == draft.id);
    _apply(created);
    return created;
  }

  /// Pays for an order. [coins] are redeemed on the server. [amount] is what the customer paid.
  Future<RentalOrder> payOrder(
    RentalOrder order, {
    required String method,
    double? amount,
    double coins = 0,
    String? transactionId,
    String? razorpayOrderId,
    String? razorpayPaymentId,
    String? razorpaySignature,
  }) async {
    final id = _serverIds[order.id] ?? order.id;
    final d = asMap(
      await Api.instance.post(
        '/api/v1/orders/$id/pay',
        body: {
          'paymentMethod': method,
          if (amount != null) 'amount': amount,
          if (coins > 0) 'coinsToRedeem': coins,
          if (transactionId != null) 'transactionId': transactionId,
          if (razorpayOrderId != null) 'razorpayOrderId': razorpayOrderId,
          if (razorpayPaymentId != null) 'razorpayPaymentId': razorpayPaymentId,
          if (razorpaySignature != null) 'razorpaySignature': razorpaySignature,
        },
      ),
    );
    final paid = RentalOrder.fromApi(d);
    _apply(paid);
    unawaited(WalletService.instance.load());
    return paid;
  }

  Future<RentalOrder> cancelOrder(RentalOrder order, {String? reason}) async {
    final id = _serverIds[order.id] ?? order.id;
    final d = asMap(
      await Api.instance.post(
        '/api/v1/orders/$id/cancel',
        body: {'reason': reason},
      ),
    );
    final o = RentalOrder.fromApi(d);
    _apply(o);
    return o;
  }

  /// Live delivery tracking info for an order: rider name/phone/position.
  Future<Map<String, dynamic>> tracking(RentalOrder order) async {
    final id = _serverIds[order.id] ?? order.id;
    return asMap(await Api.instance.get('/api/v1/orders/$id/tracking'));
  }

  // ----------------------------------------------- compatibility with old screens

  /// Old screens call this after changing an order with copyWith(...). It keeps working,
  /// but only the changes a customer is allowed to make are sent to the server.
  void upsert(RentalOrder order) {
    final real = _serverIds[order.id] ?? order.id;
    final existing = findById(real);

    if (existing == null) {
      if (_uuid.hasMatch(real)) {
        _apply(order); // came from the server already
      } else {
        // an old-style local order: show it, and create it on the server
        _orders.add(order);
        notifyListeners();
        unawaited(
          createOrder(order).catchError((Object e) {
            lastError = e.toString();
            _orders.removeWhere((o) => o.id == order.id);
            notifyListeners();
            return order;
          }),
        );
      }
      return;
    }
    unawaited(_syncChange(existing, order));
  }

  /// Statuses only the vendor / rider / admin can set (the server does it, we just show it).
  static bool _serverDriven(OrderStatus s) {
    return s == OrderStatus.vendorAccepted ||
        s == OrderStatus.riderAssigned ||
        s == OrderStatus.outForDelivery ||
        s == OrderStatus.delivered ||
        s == OrderStatus.returnCollected;
  }

  Future<void> _syncChange(RentalOrder old, RentalOrder neu) async {
    final id = old.id;
    var status = neu.status;
    if (status != old.status && _serverDriven(status)) status = old.status;

    // 1. show the change straight away (the server answer replaces it a moment later)
    _apply(neu.copyWith(status: status));

    try {
      RentalOrder? result;

      // 2. status changes the customer may trigger
      if (status != old.status) {
        switch (status) {
          case OrderStatus.paymentConfirmed:
            result = await payOrder(old, method: 'UPI');
            break;
          case OrderStatus.returnScheduled:
            result = RentalOrder.fromApi(
              asMap(
                await Api.instance.post(
                  '/api/v1/orders/$id/schedule-return',
                  body: {
                    'date': isoUtc(neu.returnPickupDate),
                    'slot': neu.returnPickupSlot,
                  },
                ),
              ),
            );
            break;
          case OrderStatus.rentalActive:
            if (old.status == OrderStatus.delivered) {
              result = RentalOrder.fromApi(
                asMap(
                  await Api.instance.post('/api/v1/orders/$id/rental-active'),
                ),
              );
            }
            break;
          case OrderStatus.cancelled:
            result = await cancelOrder(old);
            break;
          case OrderStatus.completed:
            if (old.isAvailableForPurchase) {
              result = RentalOrder.fromApi(
                asMap(await Api.instance.post('/api/v1/orders/$id/purchase')),
              );
            }
            break;
          default:
            break;
        }
      }

      // 3. rental extended
      if (neu.endDate.isAfter(old.endDate) &&
          (old.status == OrderStatus.delivered ||
              old.status == OrderStatus.rentalActive)) {
        result = RentalOrder.fromApi(
          asMap(
            await Api.instance.post(
              '/api/v1/orders/$id/extend',
              body: {'newEndDate': isoUtc(neu.endDate)},
            ),
          ),
        );
      }

      // 4. small detail changes
      final details = <String, dynamic>{};
      if (neu.deliverySlot != old.deliverySlot)
        details['deliverySlot'] = neu.deliverySlot;
      if (neu.deliveryDate != old.deliveryDate)
        details['deliveryDate'] = isoUtc(neu.deliveryDate);
      if (neu.deliveryAddress != old.deliveryAddress)
        details['deliveryAddress'] = neu.deliveryAddress;
      if (neu.purchaseRequested != old.purchaseRequested)
        details['purchaseRequested'] = neu.purchaseRequested;
      if (neu.purchasePrice != old.purchasePrice)
        details['purchasePrice'] = neu.purchasePrice;
      if (details.isNotEmpty) {
        result = RentalOrder.fromApi(
          asMap(await Api.instance.put('/api/v1/orders/$id', body: details)),
        );
      }

      if (result != null) _apply(result);
      lastError = null;
    } catch (e) {
      lastError = e.toString();
      debugPrint('order sync failed: $e');
      await load(); // go back to what the server says
    }
  }
}
