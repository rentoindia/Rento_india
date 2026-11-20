import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api_client.dart';
import '../../core/booking_session.dart';

enum SosStatus { idle, alerting, active }

class SosState {
  const SosState({this.status = SosStatus.idle});
  final SosStatus status;

  SosState copyWith({SosStatus? status}) =>
      SosState(status: status ?? this.status);
}

class SosNotifier extends StateNotifier<SosState> {
  SosNotifier() : super(const SosState());

  Timer? _timer;

  /// Alerts the admin team right away (shown live in the admin app) and starts the SOS countdown.
  void trigger() {
    if (state.status != SosStatus.idle) return;
    state = state.copyWith(status: SosStatus.alerting);
    final rideId = BookingSession.instance.rideId;
    if (rideId != null) {
      Api.instance
          .post('/api/v1/rides/$rideId/sos')
          .catchError((Object e) => null);
    }
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      state = state.copyWith(status: SosStatus.active);
    });
  }

  void cancelAlert() {
    _timer?.cancel();
    state = const SosState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final sosProvider = StateNotifierProvider.autoDispose<SosNotifier, SosState>((
  ref,
) {
  return SosNotifier();
});
