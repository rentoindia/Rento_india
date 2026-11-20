import 'dart:async';

import '../services/catalog_service.dart';
import '../services/favorites_service.dart';
import '../services/lender_service.dart';
import '../services/notification_service.dart';
import '../services/orders_service.dart';
import '../services/wallet_service.dart';
import 'session.dart';

/// Wires login/logout to the app's services. Call [AppBootstrap.init] once in main().
class AppBootstrap {
  static Future<void> init() async {
    Session.instance.onLoggedIn = loadEverything;
    Session.instance.onLoggedOut = clearEverything;
    await Session.instance.init();
    unawaited(CatalogService.instance.load());
  }

  /// Downloads this user's data (runs after login and when the app starts logged in).
  static Future<void> loadEverything() async {
    await Future.wait<void>([
      CatalogService.instance.load(),
      OrdersService.instance.load(),
      WalletService.instance.load(),
      NotificationService.instance.load(),
      FavoritesService.instance.load(),
      LenderService.instance.refresh(),
    ]);
  }

  static void clearEverything() {
    OrdersService.instance.clear();
    WalletService.instance.clear();
    NotificationService.instance.clear();
    FavoritesService.instance.clear();
    LenderService.instance.clear();
  }
}
