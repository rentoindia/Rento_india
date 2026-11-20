import '../../../core/api_client.dart';
import '../../../core/json_utils.dart';
import '../../core/booking_session.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../parcel/models/address_model.dart';
import '../../parcel/models/booking_model.dart' show PaymentMethod;
import '../models/ride_booking_model.dart';

class RideBookingNotifier extends StateNotifier<RideBooking> {
  RideBookingNotifier() : super(const RideBooking());

  void setPickup(AddressModel address) {
    state = state.copyWith(pickup: address);
  }

  void setDestination(AddressModel address) {
    state = state.copyWith(destination: address);
  }

  void selectVehicle(String vehicleId) {
    state = state.copyWith(selectedVehicleId: vehicleId);
  }

  void selectPaymentMethod(PaymentMethod method) {
    state = state.copyWith(paymentMethod: method);
  }

  void applyPromoCode(String code) {
    state = state.copyWith(promoApplied: true, promoCode: code);
  }

  void setRideNotes(String notes) {
    state = state.copyWith(rideNotes: notes);
  }

  /// Sends the ride request to the server. Returns the ride code (for example TRP10245).
  Future<String> submit() async {
    final b = state;
    final p = b.pickup;
    final d = b.destination;
    if (p == null || d == null)
      throw ApiException('Pickup and destination are required');
    final method = b.paymentMethod == PaymentMethod.cashOnDelivery
        ? 'CASH'
        : 'ONLINE';
    final res = asMap(
      await Api.instance.post(
        '/api/v1/rides',
        body: {
          'pickupLabel': p.label,
          'pickupAddress': p.fullAddress,
          'pickupLat': p.latitude,
          'pickupLng': p.longitude,
          'dropLabel': d.label,
          'dropAddress': d.fullAddress,
          'dropLat': d.latitude,
          'dropLng': d.longitude,
          'vehicleType': b.selectedVehicleId,
          'distanceKm': b.distanceKm,
          'durationMinutes': b.durationMinutes,
          'fare': b.totalFare,
          'promoCode': b.promoCode,
          'notes': b.rideNotes,
          'paymentMethod': method,
        },
      ),
    );
    BookingSession.instance.ride = res;
    final code = str(res['code'], str(res['id']));
    state = state.copyWith(rideId: code);
    return code;
  }

  void reset() {
    state = const RideBooking();
  }

  /// Cancels the ride on the server (best effort) and resets the local booking.
  Future<void> cancelRideOnServer({String? reason}) async {
    final id = BookingSession.instance.rideId;
    if (id == null) return;
    try {
      await Api.instance.post(
        '/api/v1/rides/$id/cancel',
        body: {'reason': reason},
      );
    } on ApiException {
      // already started / finished: nothing to cancel
    }
    BookingSession.instance.clearRide();
  }

  void cancelRide() {
    state = RideBooking(
      pickup: state.pickup,
      destination: state.destination,
      selectedVehicleId: state.selectedVehicleId,
      paymentMethod: state.paymentMethod,
      distanceKm: state.distanceKm,
      durationMinutes: state.durationMinutes,
      promoApplied: state.promoApplied,
      promoCode: state.promoCode,
      rideNotes: state.rideNotes,
    );
  }
}

final rideBookingProvider =
    StateNotifierProvider<RideBookingNotifier, RideBooking>((ref) {
      return RideBookingNotifier();
    });
