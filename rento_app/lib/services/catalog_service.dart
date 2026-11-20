import 'dart:async';

import 'package:flutter/foundation.dart';

import '../core/api_client.dart';
import '../core/api_config.dart';
import '../core/json_utils.dart';
import '../core/realtime_client.dart';
import '../screens/category_data.dart';

/// Loads the shopper catalogue (categories, sub-categories, products) from the server and
/// puts it into [categoryDataMap] / [allCategoriesList], which the browse screens already read.
/// When an admin changes the catalogue, the server sends `catalog.changed` and this reloads.
class CatalogService extends ChangeNotifier {
  CatalogService._() {
    Realtime.instance.on('catalog.changed').listen((_) => load());
  }
  static final CatalogService instance = CatalogService._();

  Map<String, CategoryData>? _builtIn;
  bool loaded = false;
  bool _running = false;
  bool _again = false;

  /// Safe to call as often as you like (calls made while a load is running are merged).
  /// Public data: no login needed.
  Future<void> load() async {
    if (_running) {
      _again = true;
      return;
    }
    _running = true;
    try {
      do {
        _again = false;
        await _load();
      } while (_again);
    } finally {
      _running = false;
    }
  }

  Future<void> _load() async {
    try {
      _builtIn ??= Map<String, CategoryData>.of(categoryDataMap);

      final cats = asMaps(
        await Api.instance.get('/api/v1/catalog/categories', auth: false),
      );
      if (cats.isEmpty)
        return; // server has no catalogue yet: keep what the app ships with
      final page = asMap(
        await Api.instance.get(
          '/api/v1/catalog/products',
          query: {'size': '500'},
          auth: false,
        ),
      );
      final prods = asMaps(page['items']);

      final newMap = <String, CategoryData>{};
      final newList = <Map<String, dynamic>>[];
      for (final c in cats) {
        final name = str(c['name']);
        final subs = asMaps(c['subcategories'])
            .map((s) => str(s['name']))
            .toList();
        final built = _builtIn![name];
        final items = prods
            .where((p) => str(p['category']) == name)
            .map(
              (p) => CategoryProduct(
                name: str(p['name']),
                price: '₹${intv(p['pricePerDay'])} / day',
                image: ApiConfig.resolveUrl(strOrNull(p['mainImage'])) ?? '',
                sub: str(p['subcategory']),
              ),
            )
            .toList();
        newMap[name] = CategoryData(
          searchHint: built?.searchHint ?? 'Search ${name.toLowerCase()}...',
          subcategories: ['All $name', ...subs],
          promoPercent: built?.promoPercent ?? '10',
          products: items,
          isBookingCategory: built?.isBookingCategory ?? false,
        );
        newList.add({
          'name': name,
          'image': ApiConfig.resolveUrl(strOrNull(c['icon'])) ?? '',
        });
      }
      categoryDataMap
        ..clear()
        ..addAll(newMap);
      allCategoriesList
        ..clear()
        ..addAll(newList);
      loaded = true;
      notifyListeners();
    } catch (e) {
      debugPrint('catalog load failed (using built-in data): $e');
    }
  }
}
