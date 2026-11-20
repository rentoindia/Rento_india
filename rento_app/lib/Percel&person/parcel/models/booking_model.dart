import 'address_model.dart';
import 'parcel_details_model.dart';
import 'vehicle_option_model.dart';

enum PaymentMethod {
  cashOnDelivery,
  googlePay,
  phonePe,
  paytmUpi,
  bhimUpi,
  card,
  paytmWallet,
  netBanking,
}

extension PaymentMethodX on PaymentMethod {
  String get label {
    switch (this) {
      case PaymentMethod.cashOnDelivery:
        return 'Cash on Delivery';
      case PaymentMethod.googlePay:
        return 'Google Pay';
      case PaymentMethod.phonePe:
        return 'PhonePe';
      case PaymentMethod.paytmUpi:
        return 'Paytm';
      case PaymentMethod.bhimUpi:
        return 'BHIM UPI';
      case PaymentMethod.card:
        return 'Debit / Credit Card';
      case PaymentMethod.paytmWallet:
        return 'Paytm Wallet';
      case PaymentMethod.netBanking:
        return 'Net Banking';
    }
  }
}

/// Holds the full state of a single in-progress (or completed) parcel
/// booking as the user moves through the flow.
class ParcelBooking {
  const ParcelBooking({
    this.bookingId,
    this.pickup,
    this.receiver,
    this.parcelDetails,
    this.selectedVehicleId,
    this.paymentMethod,
    this.distanceKm = 5.2,
  });

  final String? bookingId;
  final AddressModel? pickup;
  final AddressModel? receiver;
  final ParcelDetailsModel? parcelDetails;
  final String? selectedVehicleId;
  final PaymentMethod? paymentMethod;
  final double distanceKm;

  VehicleOptionModel? get selectedVehicle {
    if (selectedVehicleId == null) return null;
    for (final v in kVehicleOptions) {
      if (v.id == selectedVehicleId) return v;
    }
    return null;
  }

  double get baseFare => 50;
  double get distanceCharge => distanceKm * 2.3;
  double get handlingFee => 6;
  double get totalFare => selectedVehicle?.fare ?? 0;

  ParcelBooking copyWith({
    String? bookingId,
    AddressModel? pickup,
    AddressModel? receiver,
    ParcelDetailsModel? parcelDetails,
    String? selectedVehicleId,
    PaymentMethod? paymentMethod,
    double? distanceKm,
  }) {
    return ParcelBooking(
      bookingId: bookingId ?? this.bookingId,
      pickup: pickup ?? this.pickup,
      receiver: receiver ?? this.receiver,
      parcelDetails: parcelDetails ?? this.parcelDetails,
      selectedVehicleId: selectedVehicleId ?? this.selectedVehicleId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      distanceKm: distanceKm ?? this.distanceKm,
    );
  }
}
