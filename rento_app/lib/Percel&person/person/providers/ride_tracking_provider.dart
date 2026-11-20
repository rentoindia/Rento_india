import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/json_utils.dart';
import '../../../core/realtime_client.dart';
import '../../core/booking_session.dart';
import '../models/captain_model.dart';

class RideTrackingState {
  const RideTrackingState({
    required this.stage,
    this.rideOtp = '----',
    this.otpSecondsRemaining = 47,
  });

  final RideTrackingStage stage;

  /// Code the passenger tells the captain to start the ride.
  final String rideOtp;
  final int otpSecondsRemaining;

  RideTrackingState copyWith({
    RideTrackingStage? stage,
    String? rideOtp,
    int? otpSecondsRemaining,
  }) {
    return RideTrackingState(
      stage: stage ?? this.stage,
      rideOtp: rideOtp ?? this.rideOtp,
      otpSecondsRemaining: otpSecondsRemaining ?? this.otpSecondsRemaining,
    );
  }
}

/// Ride tracking driven by the SERVER: a captain accepting, starting (OTP) and finishing the ride
/// arrive live as `ride.updated` events.
class RideTrackingNotifier extends StateNotifier<RideTrackingState> {
  RideTrackingNotifier()
    : super(
        const RideTrackingState(stage: RideTrackingStage.searchingCaptain),
      ) {
    final r = BookingSession.instance.ride;
    if (r != null) _apply(r);
    _sub = Realtime.instance.on('ride.updated').listen((j) {
      if (str(j['id']) == BookingSession.instance.rideId) {
        BookingSession.instance.ride = j;
        _apply(j);
      }
    });
  }

  StreamSubscription<Map<String, dynamic>>? _sub;
  final List<Timer> _timers = [];
  Timer? _otpTimer;
  bool _assignedSequence = false;

  void _apply(Map<String, dynamic> j) {
    if (!mounted) return;
    final otp = strOrNull(j['startOtp']);
    if (otp != null) state = state.copyWith(rideOtp: otp);
    switch (str(j['status']).toUpperCase()) {
      case 'ASSIGNED':
        _set(RideTrackingStage.captainAssigned);
        if (!_assignedSequence) {
          _assignedSequence = true;
          _later(const Duration(seconds: 3), RideTrackingStage.captainArriving);
          _later(
            const Duration(seconds: 8),
            RideTrackingStage.captainArrived,
            startOtp: true,
          );
        }
        break;
      case 'IN_PROGRESS':
        _otpTimer?.cancel();
        _set(RideTrackingStage.rideInProgress);
        break;
      case 'COMPLETED':
        _otpTimer?.cancel();
        state = state.copyWith(stage: RideTrackingStage.rideCompleted);
        break;
      case 'REQUESTED':
        _assignedSequence = false;
        state = state.copyWith(stage: RideTrackingStage.searchingCaptain);
        break;
      default:
        break;
    }
  }

  void _set(RideTrackingStage stage) {
    if (state.stage.index < stage.index) state = state.copyWith(stage: stage);
  }

  void _later(Duration d, RideTrackingStage stage, {bool startOtp = false}) {
    _timers.add(
      Timer(d, () {
        if (!mounted) return;
        _set(stage);
        if (startOtp) _startOtpCountdown();
      }),
    );
  }

  void _startOtpCountdown() {
    _otpTimer?.cancel();
    _otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted || state.otpSecondsRemaining <= 0) {
        timer.cancel();
        return;
      }
      state = state.copyWith(
        otpSecondsRemaining: state.otpSecondsRemaining - 1,
      );
    });
  }

  /// The captain starts the ride in the rider app (OTP check on the server); nothing to do here.
  void startRide() {}

  /// The captain completes the ride in the rider app; nothing to do here.
  void completeRide() {}

  void jumpTo(RideTrackingStage stage) {
    if (state.stage.index < stage.index) {
      state = state.copyWith(stage: stage);
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    _otpTimer?.cancel();
    for (final t in _timers) {
      t.cancel();
    }
    super.dispose();
  }
}

final rideTrackingProvider =
    StateNotifierProvider.autoDispose<RideTrackingNotifier, RideTrackingState>((
      ref,
    ) {
      return RideTrackingNotifier();
    });

final captainRatingProvider = StateProvider.autoDispose<int>((ref) => 0);
