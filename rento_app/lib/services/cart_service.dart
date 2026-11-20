







// import 'package:flutter/foundation.dart';

// /// A single line in the cart. `days` is the rental duration the user
// /// has chosen — the whole point of this cart is renting, not buying,
// /// so quantity here means "how many days", not "how many units".
// class CartItem {
//   final String name;
//   final String price; // per-day price, e.g. '₹599'
//   final String imageQuery;
//   final String? imageUrl; // the real photo shown on Product Details, if any
//   final String categoryLabel;
//   final String securityDeposit; // e.g. '₹5,000'
//   int days;

//   CartItem({
//     required this.name,
//     required this.price,
//     required this.imageQuery,
//     this.imageUrl,
//     required this.categoryLabel,
//     required this.securityDeposit,
//     this.days = 1,
//   });

//   static double _numeric(String s) =>
//       double.tryParse(s.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;

//   double get pricePerDay => _numeric(price);
//   double get depositValue => _numeric(securityDeposit);
//   double get subtotal => pricePerDay * days;
// }

// /// Single shared instance so any screen (Home, Product Details, Cart)
// /// can read/mutate the same cart and rebuild automatically via
// /// AnimatedBuilder(animation: CartService.instance, ...).
// class CartService extends ChangeNotifier {
//   CartService._internal();
//   static final CartService instance = CartService._internal();

//   final List<CartItem> _items = [];
//   List<CartItem> get items => List.unmodifiable(_items);

//   int get itemCount => _items.length;

//   double get subtotal => _items.fold(0, (sum, i) => sum + i.subtotal);
//   double get totalDeposit => _items.fold(0, (sum, i) => sum + i.depositValue);
//   double get total => subtotal + totalDeposit;

//   // Tracks how many "add" actions have happened since the cart was
//   // last opened. This is what the home-screen badge shows — separate
//   // from itemCount, so the badge can reset to 0 after the user opens
//   // the cart while the cart itself keeps every item.
//   // IMPORTANT: these three members live directly inside the
//   // CartService class (same level as `items`, `add`, etc.) — NOT
//   // nested inside another method.
//   int _unseenCount = 0;
//   int get unseenCount => _unseenCount;

//   void markCartSeen() {
//     if (_unseenCount != 0) {
//       _unseenCount = 0;
//       notifyListeners();
//     }
//   }

//   /// Adds a product to the cart. If it's already in there, bump the
//   /// rental duration by a day instead of creating a duplicate row —
//   /// matches how most rental apps treat "add again".
//   void add({
//     required String name,
//     required String price,
//     required String imageQuery,
//     String? imageUrl,
//     required String categoryLabel,
//     required String securityDeposit,
//   }) {
//     final existingIndex = _items.indexWhere((i) => i.name == name);
//     if (existingIndex >= 0) {
//       _items[existingIndex].days += 1;
//     } else {
//       _items.add(CartItem(
//         name: name,
//         price: price,
//         imageQuery: imageQuery,
//         imageUrl: imageUrl,
//         categoryLabel: categoryLabel,
//         securityDeposit: securityDeposit,
//       ));
//     }   
//     _unseenCount += 1;
//     notifyListeners();
//   }

//   void updateDays(String name, int days) {
//     final item = _items.firstWhere((i) => i.name == name);
//     item.days = days.clamp(1, 30);
//     notifyListeners();
//   }

//   void remove(String name) {
//     _items.removeWhere((i) => i.name == name);
//     notifyListeners();
//   }

//   void clear() {
//     _items.clear();
//     notifyListeners();
//   }
// }










import 'package:flutter/foundation.dart';

/// A single line in the cart. `days` is the rental duration the user
/// has chosen — the whole point of this cart is renting, not buying,
/// so quantity here means "how many days", not "how many units".
class CartItem {
  final String name;
  final String price; // per-day price, e.g. '₹599'
  final String imageQuery;
  final String? imageUrl; // the real photo shown on Product Details, if any
  final String categoryLabel;
  final String securityDeposit; // e.g. '₹5,000'
  int days;

  CartItem({
    required this.name,
    required this.price,
    required this.imageQuery,
    this.imageUrl,
    required this.categoryLabel,
    required this.securityDeposit,
    this.days = 1,
  });

  static double _numeric(String s) =>
      double.tryParse(s.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;

  double get pricePerDay => _numeric(price);
  double get depositValue => _numeric(securityDeposit);
  double get subtotal => pricePerDay * days;
}

/// Single shared instance so any screen (Home, Product Details, Cart)
/// can read/mutate the same cart and rebuild automatically via
/// AnimatedBuilder(animation: CartService.instance, ...).
class CartService extends ChangeNotifier {
  CartService._internal();
  static final CartService instance = CartService._internal();

  final List<CartItem> _items = [];
  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.length;

  double get subtotal => _items.fold(0, (sum, i) => sum + i.subtotal);
  double get totalDeposit => _items.fold(0, (sum, i) => sum + i.depositValue);
  double get total => subtotal + totalDeposit;

  // Tracks how many "add" actions have happened since the cart was
  // last opened. This is what the home-screen badge shows — separate
  // from itemCount, so the badge can reset to 0 after the user opens
  // the cart while the cart itself keeps every item.
  // IMPORTANT: these three members live directly inside the
  // CartService class (same level as `items`, `add`, etc.) — NOT
  // nested inside another method.
  int _unseenCount = 0;
  int get unseenCount => _unseenCount;

  void markCartSeen() {
    if (_unseenCount != 0) {
      _unseenCount = 0;
      notifyListeners();
    }
  }

  /// Adds a product to the cart. If it's already in there, bump the
  /// rental duration by a day instead of creating a duplicate row —
  /// matches how most rental apps treat "add again".
  void add({
    required String name,
    required String price,
    required String imageQuery,
    String? imageUrl,
    required String categoryLabel,
    required String securityDeposit,
  }) {
    final existingIndex = _items.indexWhere((i) => i.name == name);
    if (existingIndex >= 0) {
      _items[existingIndex].days += 1;
    } else {
      _items.add(CartItem(
        name: name,
        price: price,
        imageQuery: imageQuery,
        imageUrl: imageUrl,
        categoryLabel: categoryLabel,
        securityDeposit: securityDeposit,
      ));
    }   
    _unseenCount += 1;
    notifyListeners();
  }

  void updateDays(String name, int days) {
    final item = _items.firstWhere((i) => i.name == name);
    item.days = days.clamp(1, 30);
    notifyListeners();
  }

  void remove(String name) {
    _items.removeWhere((i) => i.name == name);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}