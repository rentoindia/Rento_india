import 'package:flutter/material.dart';
import 'parcel_details_model.dart';

/// A small feature chip shown on a vehicle card, e.g. "Fast", "Eco",
/// "Secure" — icon + short label, rendered as a pill.
class VehicleTag {
  const VehicleTag(this.icon, this.label);
  final IconData icon;
  final String label;
}

class VehicleOptionModel {
  const VehicleOptionModel({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.capacity,
    required this.fare,
    required this.etaMinutesMin,
    required this.etaMinutesMax,
    required this.maxWeightKg,
    required this.allowedSizes,
    required this.tags,
    this.recommended = false,
  });

  final String id; // bike, bikeXl, auto, van
  final String name;

  /// Short qualifier shown next to the vehicle name, e.g. "Balanced choice".
  final String tagline;

  /// One-line description of what the vehicle suits, e.g. "Medium packages".
  final String description;
  final String capacity;
  final double fare;
  final int etaMinutesMin;
  final int etaMinutesMax;

  /// Heaviest parcel (in kg) this vehicle can carry.
  final double maxWeightKg;

  /// Parcel sizes this vehicle is able to carry.
  final Set<ParcelSize> allowedSizes;

  /// Feature chips shown on the vehicle card (exactly two per vehicle).
  final List<VehicleTag> tags;
  final bool recommended;

  String get etaLabel => '$etaMinutesMin-$etaMinutesMax min';
  String get fareLabel => '\u20B9${fare.toStringAsFixed(0)}';
  String get weightLabel =>
      '${maxWeightKg % 1 == 0 ? maxWeightKg.toStringAsFixed(0) : maxWeightKg.toStringAsFixed(1)} kg';

  /// Whether this vehicle can carry the given parcel.
  bool canCarry(ParcelDetailsModel parcel) {
    return allowedSizes.contains(parcel.size) && parcel.weightKg <= maxWeightKg;
  }

  VehicleOptionModel copyWith({bool? recommended}) {
    return VehicleOptionModel(
      id: id,
      name: name,
      tagline: tagline,
      description: description,
      capacity: capacity,
      fare: fare,
      etaMinutesMin: etaMinutesMin,
      etaMinutesMax: etaMinutesMax,
      maxWeightKg: maxWeightKg,
      allowedSizes: allowedSizes,
      tags: tags,
      recommended: recommended ?? this.recommended,
    );
  }

  /// Returns the vehicles able to carry [parcel], cheapest first, with the
  /// cheapest suitable option flagged as recommended. Falls back to the
  /// full list (largest vehicle recommended) if nothing technically fits,
  /// so the customer always sees at least one option.
  static List<VehicleOptionModel> availableFor(ParcelDetailsModel? parcel) {
    List<VehicleOptionModel> suitable;
    if (parcel == null) {
      suitable = List.of(kVehicleOptions);
    } else {
      suitable = kVehicleOptions.where((v) => v.canCarry(parcel)).toList();
      if (suitable.isEmpty) {
        // Nothing technically fits (e.g. an oversized/overweight parcel) —
        // fall back to the largest vehicle rather than showing nothing.
        suitable = [kVehicleOptions.last];
      }
    }
    suitable.sort((a, b) => a.fare.compareTo(b.fare));
    return [
      for (var i = 0; i < suitable.length; i++)
        suitable[i].copyWith(recommended: i == 0),
    ];
  }
}

const List<VehicleOptionModel> kVehicleOptions = [
  VehicleOptionModel(
    id: 'bike',
    name: 'Bike',
    tagline: 'Express delivery',
    description: 'Documents & small parcels',
    capacity: 'Up to 5 kg',
    fare: 68,
    etaMinutesMin: 25,
    etaMinutesMax: 35,
    maxWeightKg: 5,
    allowedSizes: {ParcelSize.small},
    tags: [
      VehicleTag(Icons.bolt_outlined, 'Fast'),
      VehicleTag(Icons.savings_outlined, 'Affordable'),
    ],
  ),
  VehicleOptionModel(
    id: 'bikeXl',
    name: 'Scooter XL',
    tagline: 'Balanced choice',
    description: 'Medium packages',
    capacity: 'Up to 15 kg',
    fare: 106,
    etaMinutesMin: 35,
    etaMinutesMax: 50,
    maxWeightKg: 15,
    allowedSizes: {ParcelSize.small, ParcelSize.medium},
    tags: [
      VehicleTag(Icons.eco_outlined, 'Eco'),
      VehicleTag(Icons.verified_outlined, 'Reliable'),
    ],
  ),
  VehicleOptionModel(
    id: 'auto',
    name: 'Auto',
    tagline: 'Comfortable cargo',
    description: 'Bulky & fragile items',
    capacity: 'Up to 30 kg',
    fare: 159,
    etaMinutesMin: 40,
    etaMinutesMax: 55,
    maxWeightKg: 30,
    allowedSizes: {ParcelSize.small, ParcelSize.medium, ParcelSize.large},
    tags: [
      VehicleTag(Icons.inventory_2_outlined, 'Spacious'),
      VehicleTag(Icons.shield_outlined, 'Safe'),
    ],
  ),
  VehicleOptionModel(
    id: 'van',
    name: 'Mini Truck',
    tagline: 'Heavy duty',
    description: 'Large & heavy freight',
    capacity: 'Up to 100 kg',
    fare: 263,
    etaMinutesMin: 55,
    etaMinutesMax: 75,
    maxWeightKg: 100,
    allowedSizes: {ParcelSize.small, ParcelSize.medium, ParcelSize.large},
    tags: [
      VehicleTag(Icons.balance_outlined, 'Heavy Load'),
      VehicleTag(Icons.lock_outline, 'Secure'),
    ],
  ),
];
