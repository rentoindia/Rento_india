import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/json_utils.dart';
import '../../../../core/realtime_client.dart';
import '../../../../core/session.dart';
import 'package:rento_india/delivery/core/rider_api.dart';
import '../data/models/trip_request_model.dart';

final availableRequestsProvider =
    StateNotifierProvider<AvailableRequestsNotifier, List<TripRequestModel>>(
      (ref) => AvailableRequestsNotifier(),
    );

/// Rental delivery / return jobs waiting for a rider. Filled from the server and kept live.
class AvailableRequestsNotifier extends StateNotifier<List<TripRequestModel>> {
  AvailableRequestsNotifier() : super(const []) {
    _subs.add(
      Realtime.instance.on('dispatch.new').listen((j) {
        if (str(j['kind']) == 'TRIP') add(tripFromApi(j));
      }),
    );
    final gone = (Map<String, dynamic> j) => remove(str(j['id']));
    _subs.add(Realtime.instance.on('dispatch.taken').listen(gone));
    _subs.add(Realtime.instance.on('dispatch.cancelled').listen(gone));
  }

  final List<StreamSubscription<Map<String, dynamic>>> _subs = [];

  /// Re-reads the open jobs (only works while the rider is online and approved).
  Future<void> refresh() async {
    if (!Session.instance.isLoggedIn) return;
    try {
      final jobs = await RiderApi.instance.available();
      state = jobs
          .where((j) => str(j['kind']) == 'TRIP')
          .map(tripFromApi)
          .toList();
    } catch (e) {
      debugPrint('available jobs failed: $e');
    }
  }

  void remove(String requestId) {
    state = state.where((r) => r.id != requestId).toList();
  }

  void add(TripRequestModel request) {
    if (state.any((r) => r.id == request.id)) return;
    state = [...state, request];
  }

  void reset() => refresh();

  @override
  void dispose() {
    for (final s in _subs) {
      s.cancel();
    }
    super.dispose();
  }
}
