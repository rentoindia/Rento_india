import 'package:flutter/material.dart';

/// The three saved-address categories shown on the Pickup Address screen.
enum SavedAddressType { home, work, other }

extension SavedAddressTypeX on SavedAddressType {
  String get label {
    switch (this) {
      case SavedAddressType.home:
        return 'Home';
      case SavedAddressType.work:
        return 'Work';
      case SavedAddressType.other:
        return 'Other';
    }
  }

  IconData get icon {
    switch (this) {
      case SavedAddressType.home:
        return Icons.home_rounded;
      case SavedAddressType.work:
        return Icons.business_rounded;
      case SavedAddressType.other:
        return Icons.star_rounded;
    }
  }
}

/// A saved address the customer can pick from without re-typing everything
/// — shown as a selectable card on the Pickup Address screen.
class SavedAddressModel {
  const SavedAddressModel({
    required this.id,
    required this.type,
    required this.flatHouseBuilding,
    required this.streetAreaLandmark,
    required this.cityStatePin,
    required this.phone,
    this.customLabel,
    this.latitude,
    this.longitude,
  });

  final String id;
  final SavedAddressType type;
  final String flatHouseBuilding;
  final String streetAreaLandmark;
  final String cityStatePin;
  final String phone;

  /// Only used when [type] is [SavedAddressType.other] and the customer
  /// gave the address its own name (e.g. "Mom's place").
  final String? customLabel;
  final double? latitude;
  final double? longitude;

  String get title => customLabel ?? type.label;

  String get fullAddress =>
      '$flatHouseBuilding, $streetAreaLandmark, $cityStatePin';
}
