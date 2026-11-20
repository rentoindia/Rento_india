// lib/features/rider/data/models/parcel_request_model.dart
//
// Data model for the Parcel Delivery navigation flow. Field set is taken
// from the `rento_parcel_person` reference module (ParcelDetailsModel +
// ParcelRequestModel) but flattened/renamed to match the naming
// conventions already used by TripRequestModel in this app, so the new
// parcel screens can reuse the same card/row widgets and patterns as
// the existing rental Navigate-to-Vendor / Verify-Pickup / Delivery
// screens.

/// Which leg of the parcel trip the rider is currently on. Only the
/// destination + a handful of labels change between legs — the map,
/// GPS, contact row and report-issue sheet are all shared.
enum ParcelNavigationStage { toSender, toReceiver }

/// The kind of parcel being carried. Drives the icon shown on the
/// parcel card and the "Parcel Type" detail row.
enum ParcelType { documents, electronics, food, clothing, fragile, other }

extension ParcelTypeX on ParcelType {
  String get label {
    switch (this) {
      case ParcelType.documents:
        return 'Documents';
      case ParcelType.electronics:
        return 'Electronics';
      case ParcelType.food:
        return 'Food';
      case ParcelType.clothing:
        return 'Clothing';
      case ParcelType.fragile:
        return 'Fragile Item';
      case ParcelType.other:
        return 'Other';
    }
  }

  /// Icon used on the parcel card / dropped-pin, mirroring the
  /// `Icons.laptop_mac` treatment TripRequestModel gets for rentals.
  String get iconAssetHint {
    switch (this) {
      case ParcelType.documents:
        return 'description_outlined';
      case ParcelType.electronics:
        return 'devices_other_outlined';
      case ParcelType.food:
        return 'fastfood_outlined';
      case ParcelType.clothing:
        return 'checkroom_outlined';
      case ParcelType.fragile:
        return 'warning_amber_rounded';
      case ParcelType.other:
        return 'inventory_2_outlined';
    }
  }
}

/// Physical size bucket of the parcel — shown as a small chip next to
/// the parcel name, same spot the rental flow uses for "Qty: 1".
enum ParcelSize { small, medium, large }

extension ParcelSizeX on ParcelSize {
  String get label {
    switch (this) {
      case ParcelSize.small:
        return 'Small';
      case ParcelSize.medium:
        return 'Medium';
      case ParcelSize.large:
        return 'Large';
    }
  }
}

/// A single incoming/accepted parcel-delivery request.
class ParcelRequestModel {
  final String id; // e.g. 'PRCL78965'
  final ParcelType parcelType;
  final ParcelSize parcelSize;
  final double weightKg;
  final bool needsSpecialHandling;
  final String? instructions;

  // Sender (pickup) side.
  final String senderName;
  final String senderPhone;
  final String pickupLabel;
  final String pickupAddress;

  // Receiver (drop) side.
  final String receiverName;
  final String receiverPhone;
  final String dropLabel;
  final String dropAddress;

  final double distanceKm;
  final int estimatedMinutes;
  final double earnings;

  final String pickupOtp;
  final String deliveryOtp;

  const ParcelRequestModel({
    required this.id,
    required this.parcelType,
    required this.parcelSize,
    required this.weightKg,
    required this.senderName,
    required this.senderPhone,
    required this.pickupLabel,
    required this.pickupAddress,
    required this.receiverName,
    required this.receiverPhone,
    required this.dropLabel,
    required this.dropAddress,
    required this.distanceKm,
    required this.estimatedMinutes,
    required this.earnings,
    this.needsSpecialHandling = false,
    this.instructions,
    this.pickupOtp = '4821',
    this.deliveryOtp = '5938',
  });

  String get orderId => '#PRCL$id';
  String get weightLabel =>
      weightKg < 1 ? 'Under 1 kg' : '${weightKg.toStringAsFixed(1)} kg';
  String get earningsLabel => '\u20B9${earnings.toStringAsFixed(0)}';
  String get distanceLabel => '${distanceKm.toStringAsFixed(1)} km';
  String get etaLabel => '$estimatedMinutes min';
}

/// Demo data — stands in for a backend push notification until the
/// parcel rider flow is wired to a live socket/API. Mirrors the shape
/// of `kDemoParcelRequest` from the rento_parcel_person reference.
final kDemoParcelRequest = ParcelRequestModel(
  id: '78965',
  parcelType: ParcelType.documents,
  parcelSize: ParcelSize.small,
  weightKg: 0.8,
  needsSpecialHandling: true,
  instructions: 'Handle with care — contains important documents.',
  senderName: 'Rahul Kumar',
  senderPhone: '+91 98765 43210',
  pickupLabel: 'Anna Nagar, Chennai',
  pickupAddress: 'No. 12, 5th Avenue, Near Anna Nagar Tower, Chennai - 600040',
  receiverName: 'Priya Sharma',
  receiverPhone: '+91 93456 78901',
  dropLabel: 'Velachery, Chennai',
  dropAddress:
      'Phoenix Marketcity, Velachery Main Rd, Chennai - 600042, '
      'Opposite Main Entrance, Near Food Court',
  distanceKm: 8.7,
  estimatedMinutes: 23,
  earnings: 85,
);