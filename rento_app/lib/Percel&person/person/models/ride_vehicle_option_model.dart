import 'package:flutter/material.dart';

/// A single ride vehicle option (Bike, Auto, Cab, XL) shown on the
/// Vehicle Selection screen. Mirrors the shape of the parcel module's
/// `VehicleOptionModel` but scoped to passenger rides — capacity is a
/// passenger count rather than a weight limit, and there's a short
/// availability blurb ("2 min away") instead of a size/weight rule.
class RideVehicleOptionModel {
  const RideVehicleOptionModel({
    required this.id,
    required this.name,
    required this.badge,
    required this.description,
    required this.capacityLabel,
    required this.fare,
    required this.etaMinutes,
    required this.icon,
    this.discountedFare,
  });

  final String id; // bike, auto, cab, xl
  final String name;

  /// Small pill next to the vehicle name, e.g. "Fastest", "Budget-friendly".
  final String badge;

  /// One-line qualifier, e.g. "Fast · Affordable · 1 Passenger".
  final String description;
  final String capacityLabel;
  final double fare;
  final int etaMinutes;
  final IconData icon;

  /// Fare after an applied promo code, if any.
  final double? discountedFare;

  String get etaLabel => '$etaMinutes min';
  String get fareLabel => '\u20B9${fare.toStringAsFixed(0)}';
  String get discountedFareLabel =>
      '\u20B9${(discountedFare ?? fare).toStringAsFixed(0)}';

  RideVehicleOptionModel copyWith({double? discountedFare}) {
    return RideVehicleOptionModel(
      id: id,
      name: name,
      badge: badge,
      description: description,
      capacityLabel: capacityLabel,
      fare: fare,
      etaMinutes: etaMinutes,
      icon: icon,
      discountedFare: discountedFare ?? this.discountedFare,
    );
  }
}

const List<RideVehicleOptionModel> kRideVehicleOptions = [
  RideVehicleOptionModel(
    id: 'bike',
    name: 'Bike',
    badge: 'Fastest',
    description: 'Fast · Affordable · 1 Passenger',
    capacityLabel: '1 Passenger',
    fare: 92,
    etaMinutes: 12,
    icon: Icons.pedal_bike_outlined,
  ),
  RideVehicleOptionModel(
    id: 'auto',
    name: 'Auto',
    badge: 'Budget-friendly',
    description: 'Comfortable · 2 min away',
    capacityLabel: 'Up to 3', // shortened from 'Up to 3 Passengers'
    fare: 128,
    etaMinutes: 14,
    icon: Icons.electric_rickshaw_outlined,
  ),
  RideVehicleOptionModel(
    id: 'cab',
    name: 'Cab',
    badge: 'Comfort',
    description: 'Comfortable · Safe',
    capacityLabel: 'Up to 4', // shortened from 'Up to 4 Passengers'
    fare: 214,
    etaMinutes: 18,
    icon: Icons.local_taxi_outlined,
  ),
  RideVehicleOptionModel(
    id: 'xl',
    name: 'XL',
    badge: 'Extra Space',
    description: 'Spacious · Premium',
    capacityLabel: 'Up to 6', // shortened from 'Up to 6 Passengers'
    fare: 298,
    etaMinutes: 22,
    icon: Icons.airport_shuttle_outlined,
  ),
];

RideVehicleOptionModel rideVehicleById(String id) =>
    kRideVehicleOptions.firstWhere((v) => v.id == id);
