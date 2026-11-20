import 'dart:async';

import 'package:flutter/foundation.dart';

import '../core/api_client.dart';
import '../core/json_utils.dart';
import '../core/session.dart';

class SavedProduct {
  final String name;
  final String price;
  final String categoryLabel;
  final String imageQuery;
  final double rating;
  final int reviewCount;

  const SavedProduct({
    required this.name,
    required this.price,
    required this.categoryLabel,
    required this.imageQuery,
    required this.rating,
    required this.reviewCount,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
    'categoryLabel': categoryLabel,
    'imageQuery': imageQuery,
    'rating': rating,
    'reviewCount': reviewCount,
  };

  factory SavedProduct.fromJson(Map<String, dynamic> j) => SavedProduct(
    name: str(j['name']),
    price: str(j['price']),
    categoryLabel: str(j['categoryLabel']),
    imageQuery: str(j['imageQuery']),
    rating: dbl(j['rating'], 4.5),
    reviewCount: intv(j['reviewCount']),
  );
}

/// Wishlist, stored on the server so it follows the user to any phone.
class FavoritesService extends ChangeNotifier {
  FavoritesService._internal();
  static final FavoritesService instance = FavoritesService._internal();

  final List<SavedProduct> _items = [];
  List<SavedProduct> get items => List.unmodifiable(_items.reversed);

  bool isSaved(String name) => _items.any((p) => p.name == name);

  Future<void> load() async {
    if (!Session.instance.isLoggedIn) return;
    try {
      final list = asMaps(await Api.instance.get('/api/v1/favorites'));
      _items
        ..clear()
        ..addAll(list.reversed.map(SavedProduct.fromJson));
      notifyListeners();
    } catch (e) {
      debugPrint('favorites load failed: $e');
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  void toggle(SavedProduct product) {
    if (isSaved(product.name)) {
      remove(product.name);
    } else {
      _items.add(product);
      notifyListeners();
      _fire(
        () => Api.instance.post('/api/v1/favorites', body: product.toJson()),
      );
    }
  }

  void remove(String name) {
    _items.removeWhere((p) => p.name == name);
    notifyListeners();
    _fire(
      () => Api.instance.delete('/api/v1/favorites', query: {'name': name}),
    );
  }

  void _fire(Future<dynamic> Function() call) {
    if (!Session.instance.isLoggedIn) return;
    call().catchError((Object e) {
      debugPrint('favorites sync failed: $e');
      return null;
    });
  }
}
