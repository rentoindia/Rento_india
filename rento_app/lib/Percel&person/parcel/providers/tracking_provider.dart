import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/json_utils.dart';
import '../../../core/realtime_client.dart';
import '../../core/booking_session.dart';
import '../models/rider_model.dart';

class TrackingState {
  const TrackingState({
    required this.stage,
    this.pickupOtp = '----',
    this.deliveryOtp = '----',
  });

  final TrackingStage stage;

  /// Code the sender tells the rider at pickup.
  final String pickupOtp;

  /// Code the receiver tells the rider at delivery.
  final String deliveryOtp;

  TrackingState copyWith({
    TrackingStage? stage,
    String? pickupOtp,
    String? deliveryOtp,
  }) {
    return TrackingState(
      stage: stage ?? this.stage,
      pickupOtp: pickupOtp ?? this.pickupOtp,
      deliveryOtp: deliveryOtp ?? this.deliveryOtp,
    );
  }
}

/// Parcel tracking driven by the SERVER. The rider's actions (accept, OTP pickup, OTP delivery)
/// arrive live as `parcel.updated` events; the short "on the way" steps in between are cosmetic.
class TrackingNotifier extends StateNotifier<TrackingState> {
  TrackingNotifier()
    : super(const TrackingState(stage: TrackingStage.searchingRider)) {
    final p = BookingSession.instance.parcel;
    if (p != null) _apply(p);
    _sub = Realtime.instance.on('parcel.updated').listen((j) {
      if (str(j['id']) == BookingSession.instance.parcelId) {
        BookingSession.instance.parcel = j;
        _apply(j);
      }
    });
  }

  StreamSubscription<Map<String, dynamic>>? _sub;
  final List<Timer> _timers = [];
  bool _assignedSequence = false;
  bool _transitSequence = false;

  void _apply(Map<String, dynamic> j) {
    if (!mounted) return;
    state = state.copyWith(
      pickupOtp: strOrNull(j['pickupOtp']),
      deliveryOtp: strOrNull(j['deliveryOtp']),
    );
    switch (str(j['status']).toUpperCase()) {
      case 'ASSIGNED':
        _transitSequence = false;
        _set(
          TrackingStage.riderAssigned,
          force: state.stage == TrackingStage.searchingRider,
        );
        if (!_assignedSequence) {
          _assignedSequence = true;
          _later(const Duration(seconds: 3), TrackingStage.onTheWayToPickup);
          _later(
            const Duration(seconds: 8),
            TrackingStage.riderArrivedAtPickup,
          );
        }
        break;
      case 'IN_TRANSIT':
        _set(TrackingStage.parcelPickedUp);
        if (!_transitSequence) {
          _transitSequence = true;
          _later(const Duration(seconds: 2), TrackingStage.onTheWayToReceiver);
          _later(const Duration(seconds: 7), TrackingStage.riderNearReceiver);
        }
        break;
      case 'DELIVERED':
        for (final t in _timers) {
          t.cancel();
        }
        _timers.clear();
        state = state.copyWith(stage: TrackingStage.parcelDelivered);
        break;
      case 'PENDING':
        // no rider yet (or the rider backed out): search again
        _assignedSequence = false;
        state = state.copyWith(stage: TrackingStage.searchingRider);
        break;
      default:
        break;
    }
  }

  void _set(TrackingStage stage, {bool force = false}) {
    if (force || state.stage.index < stage.index) {
      state = state.copyWith(stage: stage);
    }
  }

  void _later(Duration d, TrackingStage stage) {
    _timers.add(
      Timer(d, () {
        if (mounted) _set(stage);
      }),
    );
  }

  /// The rider enters the OTP in the rider app; the server then moves the parcel on and
  /// this screen follows. Nothing to do here, kept so the existing sheets keep working.
  void confirmPickupOtp() {}

  void confirmDeliveryOtp() {}

  void showPickupOtpSheet() {
    state = state.copyWith(stage: TrackingStage.pickupOtp);
  }

  void showDeliveryOtpSheet() {
    state = state.copyWith(stage: TrackingStage.deliveryOtp);
  }

  void jumpTo(TrackingStage stage) {
    if (state.stage.index < stage.index) {
      state = state.copyWith(stage: stage);
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    for (final t in _timers) {
      t.cancel();
    }
    super.dispose();
  }
}

final trackingProvider =
    StateNotifierProvider.autoDispose<TrackingNotifier, TrackingState>((ref) {
      return TrackingNotifier();
    });

final riderRatingProvider = StateProvider.autoDispose<int>((ref) => 0);
