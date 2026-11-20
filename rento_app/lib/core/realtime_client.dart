import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import 'api_client.dart';
import 'api_config.dart';
import 'token_store.dart';

class RealtimeEvent {
  final String type;
  final String? topic;
  final Map<String, dynamic> payload;
  RealtimeEvent(this.type, this.topic, this.payload);
}

/// Live connection to the backend (ws://HOST/ws). Reconnects by itself.
///
/// Events you can listen for (see backend EventHub):
///   notification.new, wallet.updated, order.updated, order.created, catalog.changed,
///   dispatch.new, dispatch.taken, dispatch.cancelled, job.updated, location,
///   ride.updated, parcel.updated, rider.status, sos.triggered, product.updated, ...
class Realtime {
  Realtime._();
  static final Realtime instance = Realtime._();

  WebSocketChannel? _channel;
  StreamSubscription? _sub;
  Timer? _retryTimer;
  Timer? _pingTimer;
  bool _wanted = false;
  bool _connected = false;
  int _attempt = 0;
  final Set<String> _topics = <String>{};
  final StreamController<RealtimeEvent> _controller =
      StreamController<RealtimeEvent>.broadcast();

  Stream<RealtimeEvent> get events => _controller.stream;
  bool get isConnected => _connected;

  /// Convenience: only the events of one type, payload only.
  Stream<Map<String, dynamic>> on(String type) =>
      events.where((e) => e.type == type).map((e) => e.payload);

  void connect() {
    _wanted = true;
    _open();
  }

  void disconnect() {
    _wanted = false;
    _topics.clear();
    _close();
  }

  void subscribe(String topic) {
    _topics.add(topic);
    _send({'action': 'subscribe', 'topic': topic});
  }

  void unsubscribe(String topic) {
    _topics.remove(topic);
    _send({'action': 'unsubscribe', 'topic': topic});
  }

  void _send(Map<String, dynamic> msg) {
    if (!_connected || _channel == null) return;
    try {
      _channel!.sink.add(jsonEncode(msg));
    } catch (_) {}
  }

  void _open() {
    if (!_wanted || _channel != null) return;
    final token = TokenStore.accessToken;
    if (token == null) return;
    try {
      final uri = Uri.parse(
        '${ApiConfig.wsUrl}?token=${Uri.encodeQueryComponent(token)}',
      );
      _channel = WebSocketChannel.connect(uri);
      _sub = _channel!.stream.listen(
        _onData,
        onDone: _onClosed,
        onError: (_) => _onClosed(),
        cancelOnError: true,
      );
    } catch (_) {
      _onClosed();
    }
  }

  void _onData(dynamic raw) {
    try {
      final m = jsonDecode(raw as String);
      if (m is! Map) return;
      final type = (m['type'] ?? '').toString();
      if (type == 'connected') {
        _connected = true;
        _attempt = 0;
        _pingTimer?.cancel();
        _pingTimer = Timer.periodic(
          const Duration(seconds: 30),
          (_) => _send({'action': 'ping'}),
        );
        for (final t in _topics) {
          _send({'action': 'subscribe', 'topic': t});
        }
      }
      final payload = m['payload'] is Map
          ? Map<String, dynamic>.from(m['payload'] as Map)
          : <String, dynamic>{};
      _controller.add(RealtimeEvent(type, m['topic']?.toString(), payload));
    } catch (_) {}
  }

  void _onClosed() {
    _connected = false;
    _pingTimer?.cancel();
    _close();
    if (!_wanted) return;
    _attempt++;
    final seconds = _attempt > 6 ? 30 : (1 << _attempt).clamp(2, 30).toInt();
    _retryTimer?.cancel();
    _retryTimer = Timer(Duration(seconds: seconds), () async {
      // the access token may have expired while we were offline
      if (_attempt >= 1) await Api.instance.refreshSession();
      _open();
    });
  }

  void _close() {
    _sub?.cancel();
    _sub = null;
    try {
      _channel?.sink.close();
    } catch (_) {}
    _channel = null;
  }
}
