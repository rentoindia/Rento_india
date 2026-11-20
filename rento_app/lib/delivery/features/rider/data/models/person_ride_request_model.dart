// lib/features/rider/data/models/person_ride_request_model.dart
//
// Data model for the Person Delivery (passenger ride) flow — a third
// sibling alongside TripRequestModel (rental vendor/customer) and
// ParcelRequestModel (sender/receiver). Here the rider picks up and
// drops off an actual passenger instead of an item, matching the
// reference "Navigate to Pickup → Arrived at Pickup → Passenger
// Verification → During Ride → Arrived at Destination" screens.

class PersonRideRequestModel {
  final String id; // e.g. 'pers001'
  final String passengerName;
  final String passengerPhone;
  final int passengerCount;

  final String pickupLabel;
  final String pickupAddress;

  final String dropLabel;
  final String dropAddress;

  final double distanceKm;
  final int estimatedMinutes;
  final double fare;
  final String paymentMethod;

  final String pickupOtp;

  const PersonRideRequestModel({
    required this.id,
    required this.passengerName,
    required this.passengerPhone,
    required this.pickupLabel,
    required this.pickupAddress,
    required this.dropLabel,
    required this.dropAddress,
    required this.distanceKm,
    required this.estimatedMinutes,
    required this.fare,
    this.passengerCount = 1,
    this.paymentMethod = 'Cash',
    this.pickupOtp = '4821',
  });

  String get tripId => '#$id';
  String get fareLabel => '\u20B9${fare.toStringAsFixed(0)}';
  String get distanceLabel => '${distanceKm.toStringAsFixed(1)} km';
  String get etaLabel => '$estimatedMinutes min';
}

/// Demo request — stands in for a backend push notification until the
/// person-ride flow is wired to a live socket/API, matching the
/// reference design mock's #pers001 trip exactly.
final kDemoPersonRideRequest = PersonRideRequestModel(
  id: 'pers001',
  passengerName: 'Priya Sharma',
  passengerPhone: '+91 98765 43210',
  passengerCount: 1,
  pickupLabel: 'Anna Nagar West',
  pickupAddress: 'Chennai, Tamil Nadu 600040',
  dropLabel: 'T. Nagar',
  dropAddress: 'Chennai, Tamil Nadu 600017',
  distanceKm: 4.2,
  estimatedMinutes: 12,
  fare: 180,
  paymentMethod: 'Cash',
);
