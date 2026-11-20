import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api_client.dart';
import '../../../../core/json_utils.dart';
import '../../../../core/realtime_client.dart';
import '../../../../core/session.dart';
import 'package:rento_india/delivery/core/rider_api.dart';
import '../data/models/trip_request_model.dart';

final riderStatusProvider =
    StateNotifierProvider<RiderStatusNotifier, RiderStatusState>(
      (ref) => RiderStatusNotifier(),
    );

class RiderStatusState {
  final bool isOnline;
  final TripRequestModel? incomingRequest;

  const RiderStatusState({this.isOnline = false, this.incomingRequest});

  RiderStatusState copyWith({
    bool? isOnline,
    TripRequestModel? incomingRequest,
    bool clearIncoming = false,
  }) {
    return RiderStatusState(
      isOnline: isOnline ?? this.isOnline,
      incomingRequest: clearIncoming
          ? null
          : (incomingRequest ?? this.incomingRequest),
    );
  }
}

/// Online / offline switch of the rider + the "new request" popup.
/// Real requests arrive from the server through the realtime connection (event dispatch.new).
class RiderStatusNotifier extends StateNotifier<RiderStatusState> {
  RiderStatusNotifier() : super(const RiderStatusState()) {
    _subs.add(
      Realtime.instance.on('dispatch.new').listen((j) {
        if (str(j['kind']) == 'TRIP') showIncomingRequest(tripFromApi(j));
      }),
    );
    void gone(Map<String, dynamic> j) {
      if (state.incomingRequest?.id == str(j['id'])) clearIncomingRequest();
    }

    _subs.add(Realtime.instance.on('dispatch.taken').listen(gone));
    _subs.add(Realtime.instance.on('dispatch.cancelled').listen(gone));
    // the admin approved / suspended this rider
    _subs.add(
      Realtime.instance.on('rider.status').listen((j) {
        if (str(j['status']) != 'ACTIVE' && state.isOnline) {
          state = state.copyWith(isOnline: false, clearIncoming: true);
        }
      }),
    );
    _restore();
  }

  final List<StreamSubscription<Map<String, dynamic>>> _subs = [];

  /// Last error text (for example "documents still under review"), shown by the screen.
  String? lastError;

  Future<void> _restore() async {
    if (!Session.instance.isLoggedIn) return;
    try {
      final me = await RiderApi.instance.me();
      if (boolv(me['online']) && str(me['status']) == 'ACTIVE') {
        Realtime.instance.subscribe('riders');
        state = state.copyWith(isOnline: true);
      }
    } catch (_) {
      // not registered as a rider yet
    }
  }

  Future<String?> goOnline() async {
    try {
      await RiderApi.instance.setOnline(true);
      Realtime.instance.subscribe('riders');
      state = state.copyWith(isOnline: true);
      lastError = null;
      // show a request that was already waiting
      final jobs = await RiderApi.instance.available();
      final trips = jobs.where((j) => str(j['kind']) == 'TRIP').toList();
      if (trips.isNotEmpty && state.incomingRequest == null) {
        showIncomingRequest(tripFromApi(trips.first));
      }
      return null;
    } on ApiException catch (e) {
      lastError = e.message;
      return e.message;
    }
  }

  Future<String?> goOffline() async {
    state = state.copyWith(isOnline: false, clearIncoming: true);
    try {
      await RiderApi.instance.setOnline(false);
    } catch (e) {
      debugPrint('go offline failed: $e');
    }
    return null;
  }

  /// Returns an error message when the rider cannot go online, otherwise null.
  Future<String?> toggle() => state.isOnline ? goOffline() : goOnline();

  void showIncomingRequest(TripRequestModel request) {
    if (!state.isOnline) return;
    if (state.incomingRequest != null) return; // one request at a time
    state = state.copyWith(incomingRequest: request);
  }

  void clearIncomingRequest() {
    state = state.copyWith(clearIncoming: true);
  }

  /// A job was finished. The server creates the next job by itself (for example the return pickup).
  void requestCompleted(TripRequestModel completed) {}

  void requestDeclined() {}

  @override
  void dispose() {
    for (final s in _subs) {
      s.cancel();
    }
    super.dispose();
  }
}
