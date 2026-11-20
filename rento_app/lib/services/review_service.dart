import 'dart:async';

import 'package:flutter/foundation.dart';

import '../core/api_client.dart';
import '../core/json_utils.dart';
import '../core/session.dart';

class Review {
  final String productName;
  final String userName;
  final double rating; // 1.0 - 5.0
  final String comment;
  final DateTime date;

  Review({
    required this.productName,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
  });
}

/// Product reviews. Reviews of a product are downloaded the first time a screen asks for them.
class ReviewsService extends ChangeNotifier {
  ReviewsService._();
  static final ReviewsService instance = ReviewsService._();

  final List<Review> _reviews = [];
  final Set<String> _loaded = {};
  final Set<String> _loading = {};

  List<Review> forProduct(String productName) {
    _ensureLoaded(productName);
    final list = _reviews.where((r) => r.productName == productName).toList();
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  double averageRating(String productName) {
    final list = forProduct(productName);
    if (list.isEmpty) return 0;
    return list.map((r) => r.rating).reduce((a, b) => a + b) / list.length;
  }

  bool hasReviewed(String productName, String userName) {
    return _reviews.any(
      (r) => r.productName == productName && r.userName == userName,
    );
  }

  void _ensureLoaded(String productName) {
    if (_loaded.contains(productName) || _loading.contains(productName)) return;
    _loading.add(productName);
    refresh(productName).whenComplete(() => _loading.remove(productName));
  }

  Future<void> refresh(String productName) async {
    try {
      final d = asMap(
        await Api.instance.get(
          '/api/v1/reviews',
          query: {'productName': productName},
          auth: false,
        ),
      );
      _reviews.removeWhere((r) => r.productName == productName);
      for (final j in asMaps(d['items'])) {
        _reviews.add(
          Review(
            productName: productName,
            userName: str(j['userName'], 'Customer'),
            rating: dbl(j['rating']),
            comment: str(j['comment']),
            date: date(j['createdAt']) ?? DateTime.now(),
          ),
        );
      }
      _loaded.add(productName);
      notifyListeners();
    } catch (e) {
      debugPrint('reviews load failed: $e');
    }
  }

  void addReview({
    required String productName,
    required String userName,
    required double rating,
    required String comment,
  }) {
    _reviews.add(
      Review(
        productName: productName,
        userName: userName,
        rating: rating,
        comment: comment,
        date: DateTime.now(),
      ),
    );
    notifyListeners();
    if (!Session.instance.isLoggedIn) return;
    Api.instance
        .post(
          '/api/v1/reviews',
          body: {
            'productName': productName,
            'rating': rating,
            'comment': comment,
          },
        )
        .then((_) => refresh(productName))
        .catchError((Object e) {
          debugPrint('review save failed: $e');
          return null;
        });
  }
}
