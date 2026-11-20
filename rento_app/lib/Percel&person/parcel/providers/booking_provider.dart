import '../../../core/api_client.dart';
import '../../../core/json_utils.dart';
import '../../core/booking_session.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/address_model.dart';
import '../models/booking_model.dart';
import '../models/parcel_details_model.dart';

class BookingNotifier extends StateNotifier<ParcelBooking> {
  BookingNotifier() : super(const ParcelBooking());

  void setPickup(AddressModel address) {
    state = state.copyWith(pickup: address);
  }

  void setReceiver(AddressModel address) {
    state = state.copyWith(receiver: address);
  }

  void setParcelDetails(ParcelDetailsModel details) {
    state = state.copyWith(parcelDetails: details);
  }

  void selectVehicle(String vehicleId) {
    state = state.copyWith(selectedVehicleId: vehicleId);
  }

  void selectPaymentMethod(PaymentMethod method) {
    state = state.copyWith(paymentMethod: method);
  }

  /// Sends the booking to the server. Returns the booking code (for example PD10245).
  Future<String> submit() async {
    final b = state;
    final p = b.pickup;
    final r = b.receiver;
    if (p == null || r == null)
      throw ApiException('Pickup and receiver address are required');
    final d = b.parcelDetails;
    final method =
        b.paymentMethod == PaymentMethod.cashOnDelivery ||
            b.paymentMethod == null
        ? 'CASH'
        : 'ONLINE';
    final res = asMap(
      await Api.instance.post(
        '/api/v1/parcels',
        body: {
          'pickupLabel': p.label,
          'pickupAddress': p.fullAddress,
          'pickupLat': p.latitude,
          'pickupLng': p.longitude,
          'receiverName': r.contactName ?? '',
          'receiverPhone': r.contactPhone ?? '',
          'dropLabel': r.label,
          'dropAddress': r.fullAddress,
          'dropLat': r.latitude,
          'dropLng': r.longitude,
          'parcelType': d?.type.name ?? 'other',
          'parcelSize': d?.size.name ?? 'small',
          'weightKg': d?.weightKg ?? 1,
          'needsSpecialHandling': d?.needsSpecialHandling ?? false,
          'instructions': d?.instructions,
          'vehicleId': b.selectedVehicleId,
          'distanceKm': b.distanceKm,
          'fare': b.totalFare,
          'paymentMethod': method,
        },
      ),
    );
    BookingSession.instance.parcel = res;
    final code = str(res['code'], str(res['id']));
    state = state.copyWith(bookingId: code);
    return code;
  }

  Future<void> cancelBooking({String? reason}) async {
    final id = BookingSession.instance.parcelId;
    if (id == null) return;
    await Api.instance.post(
      '/api/v1/parcels/$id/cancel',
      body: {'reason': reason},
    );
    BookingSession.instance.clearParcel();
  }

  void reset() {
    state = const ParcelBooking();
  }
}

final bookingProvider = StateNotifierProvider<BookingNotifier, ParcelBooking>((
  ref,
) {
  return BookingNotifier();
});
