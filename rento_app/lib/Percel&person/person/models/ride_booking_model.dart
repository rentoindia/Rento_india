import '../../parcel/models/address_model.dart';
import '../../parcel/models/booking_model.dart' show PaymentMethod;
import 'ride_vehicle_option_model.dart';

/// Holds the full state of a single in-progress (or completed) ride
/// booking as the customer moves through the flow. Mirrors the shape of
/// the parcel module's `ParcelBooking` but scoped to passenger rides —
/// lives entirely in `lib/ride/`, so the parcel booking model and its
/// provider are never touched.
class RideBooking {
  const RideBooking({
    this.rideId,
    this.pickup,
    this.destination,
    this.selectedVehicleId = 'bike',
    this.paymentMethod = PaymentMethod.phonePe,
    this.distanceKm = 6.4,
    this.durationMinutes = 18,
    this.promoApplied = false,
    this.promoCode,
    this.rideNotes,
  });

  final String? rideId;
  final AddressModel? pickup;
  final AddressModel? destination;
  final String selectedVehicleId;
  final PaymentMethod paymentMethod;
  final double distanceKm;
  final int durationMinutes;
  final bool promoApplied;
  final String? promoCode;
  final String? rideNotes;

  RideVehicleOptionModel get selectedVehicle =>
      rideVehicleById(selectedVehicleId);

  double get baseFare => 40;
  double get distanceCharge => distanceKm * 6.875; // ~₹44 at 6.4km
  double get timeCharge => durationMinutes * 0.44; // ~₹8 at 18min
  double get promoDiscount => promoApplied ? 20 : 0;

  double get totalFare =>
      (selectedVehicle.fare - promoDiscount).clamp(0, double.infinity);

  String get lowestFareLabel =>
      '\u20B9${kRideVehicleOptions.first.fare.toStringAsFixed(0)}';
  String get highestFareLabel =>
      '\u20B9${kRideVehicleOptions.last.fare.toStringAsFixed(0)}';
  String get distanceLabel => '${distanceKm.toStringAsFixed(1)} km';
  String get durationLabel => '$durationMinutes min';

  RideBooking copyWith({
    String? rideId,
    AddressModel? pickup,
    AddressModel? destination,
    String? selectedVehicleId,
    PaymentMethod? paymentMethod,
    double? distanceKm,
    int? durationMinutes,
    bool? promoApplied,
    String? promoCode,
    String? rideNotes,
  }) {
    return RideBooking(
      rideId: rideId ?? this.rideId,
      pickup: pickup ?? this.pickup,
      destination: destination ?? this.destination,
      selectedVehicleId: selectedVehicleId ?? this.selectedVehicleId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      distanceKm: distanceKm ?? this.distanceKm,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      promoApplied: promoApplied ?? this.promoApplied,
      promoCode: promoCode ?? this.promoCode,
      rideNotes: rideNotes ?? this.rideNotes,
    );
  }
}
