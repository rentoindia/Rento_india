import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Single source of truth for "liked" / wishlisted properties.
///
/// Any screen that shows a heart icon reads and writes through this
/// manager, so liking a property on the Home screen instantly reflects
/// on the "All Properties" screen, the Wishlist screen, etc. Likes are
/// saved to disk with shared_preferences, so they survive app restarts —
/// same idea as saving a liked video in a video app.
class FavoritesManager extends ChangeNotifier {
  FavoritesManager._internal();
  static final FavoritesManager instance = FavoritesManager._internal();

  static const String _prefsKey = 'liked_property_keys';

  final Set<String> _likedKeys = {};
  bool _loaded = false;

  Set<String> get likedKeys => _likedKeys;
  int get count => _likedKeys.length;

  bool isLiked(String key) => _likedKeys.contains(key);

  /// Loads saved likes from disk. Safe to call multiple times — it only
  /// hits disk once.
  Future<void> load() async {
    if (_loaded) return;
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(_prefsKey) ?? [];
    _likedKeys
      ..clear()
      ..addAll(saved);
    _loaded = true;
    notifyListeners();
  }

  Future<void> toggle(String key) async {
    if (_likedKeys.contains(key)) {
      _likedKeys.remove(key);
    } else {
      _likedKeys.add(key);
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_prefsKey, _likedKeys.toList());
  }
}