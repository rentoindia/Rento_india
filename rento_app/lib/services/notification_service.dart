import 'dart:async';

import 'package:flutter/material.dart';

import '../core/api_client.dart';
import '../core/json_utils.dart';
import '../core/realtime_client.dart';
import '../core/session.dart';

class NotificationItem {
  final String? id;
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  final String group; // Today / Yesterday / Earlier
  final String category; // Orders / Requests / Offers / Alerts
  final String? actionType;
  final String? refId;
  bool unread;

  NotificationItem({
    this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    required this.group,
    required this.category,
    this.actionType,
    this.refId,
    this.unread = false,
  });
}

/// In-app notification feed. Real notifications come from the server and arrive live.
class NotificationService extends ChangeNotifier {
  NotificationService._internal() {
    Realtime.instance.on('notification.new').listen((p) {
      _items.insert(0, _fromJson(p));
      notifyListeners();
    });
  }
  static final NotificationService instance = NotificationService._internal();

  final List<NotificationItem> _items = [];

  List<NotificationItem> get items => List.unmodifiable(_items);

  int get unreadCount => _items.where((n) => n.unread).length;

  Future<void> load() async {
    if (!Session.instance.isLoggedIn) return;
    try {
      final d = asMap(await Api.instance.get('/api/v1/notifications'));
      _items
        ..clear()
        ..addAll(asMaps(d['items']).map(_fromJson));
      notifyListeners();
    } catch (e) {
      debugPrint('notifications load failed: $e');
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  void markRead(NotificationItem item) {
    if (!item.unread) return;
    item.unread = false;
    notifyListeners();
    if (item.id != null && Session.instance.isLoggedIn) {
      Api.instance
          .post('/api/v1/notifications/${item.id}/read')
          .catchError((Object e) => null);
    }
  }

  void markAllRead() {
    var changed = false;
    for (final n in _items) {
      if (n.unread) {
        n.unread = false;
        changed = true;
      }
    }
    if (changed) {
      notifyListeners();
      if (Session.instance.isLoggedIn) {
        Api.instance
            .post('/api/v1/notifications/read-all')
            .catchError((Object e) => null);
      }
    }
  }

  /// The server now creates the lender's "New Rental Request" notification itself.
  /// Kept so existing call sites keep compiling.
  void notifyNewRentalRequest({
    required String productName,
    required String customerName,
  }) {}

  // ---------------------------------------------------------------- mapping

  NotificationItem _fromJson(Map<String, dynamic> j) {
    final created = date(j['createdAt']) ?? DateTime.now();
    return NotificationItem(
      id: strOrNull(j['id']),
      title: str(j['title']),
      subtitle: str(j['subtitle']),
      time: _timeAgo(created),
      icon: _icon(strOrNull(j['icon'])),
      group: _group(created),
      category: str(j['category'], 'Alerts'),
      actionType: strOrNull(j['actionType']),
      refId: strOrNull(j['refId']),
      unread: boolv(j['unread'], true),
    );
  }

  static String _group(DateTime d) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final day = DateTime(d.year, d.month, d.day);
    final diff = today.difference(day).inDays;
    if (diff <= 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    return 'Earlier';
  }

  static String _timeAgo(DateTime d) {
    final diff = DateTime.now().difference(d);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hours ago';
    if (diff.inDays == 1) return 'Yesterday';
    return '${diff.inDays} days ago';
  }

  static IconData _icon(String? key) {
    switch (key) {
      case 'check':
        return Icons.check_circle_outline;
      case 'local_shipping':
        return Icons.local_shipping_outlined;
      case 'payments':
        return Icons.payments_outlined;
      case 'inbox':
        return Icons.inbox_outlined;
      case 'cancel':
        return Icons.cancel_outlined;
      case 'event':
        return Icons.event_repeat_outlined;
      case 'build':
        return Icons.build_outlined;
      case 'home':
        return Icons.home_outlined;
      case 'verified':
        return Icons.verified_outlined;
      case 'campaign':
        return Icons.local_offer_outlined;
      case 'two_wheeler':
        return Icons.two_wheeler_outlined;
      case 'directions_car':
        return Icons.directions_car_outlined;
      case 'inventory':
        return Icons.inventory_2_outlined;
      case 'description':
        return Icons.description_outlined;
      default:
        return Icons.notifications_active_outlined;
    }
  }
}
