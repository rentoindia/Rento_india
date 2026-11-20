// enum TripStatus { delivered, ongoing, cancelled }

// /// A single trip history entry — used by TripsListScreen (list/cards)
// /// and TripDetailsScreen (full detail view). Formatted display strings
// /// (status/distance/duration/earnings) are computed getters so both
// /// screens stay in sync automatically.
// ///
// /// TODO: replace mock instances with TripRepository.getTripHistory()
// /// once backend is wired.
// class TripRecord {
//   final String orderId;
//   final TripStatus statusValue;
//   final String time; // display string, e.g. "11:30 AM"
//   final int sortKey; // minutes since midnight, for sorting
//   final String pickupName;
//   final String pickupAddress;
//   final String pickupPhone; // ⭐ NEW — vendor contact
//   final String dropName;
//   final String dropAddress;
//   final String dropPhone; // ⭐ NEW — customer contact
//   final double distanceKm;
//   final int estimatedMinutes;
//   final double earningsAmount;

//   const TripRecord({
//     required this.orderId,
//     required this.statusValue,
//     required this.time,
//     required this.sortKey,
//     required this.pickupName,
//     required this.pickupAddress,
//     required this.pickupPhone,
//     required this.dropName,
//     required this.dropAddress,
//     required this.dropPhone,
//     required this.distanceKm,
//     required this.estimatedMinutes,
//     required this.earningsAmount,
//   });

//   String get status {
//     switch (statusValue) {
//       case TripStatus.delivered:
//         return 'Delivered';
//       case TripStatus.ongoing:
//         return 'Ongoing';
//       case TripStatus.cancelled:
//         return 'Cancelled';
//     }
//   }

//   String get distance => '${distanceKm.toStringAsFixed(1)} km';
//   String get duration => '$estimatedMinutes mins';
//   String get earnings => '₹${earningsAmount.toStringAsFixed(2)}';
// }
enum TripStatus { delivered, ongoing, cancelled }

/// A single trip history entry — used by TripsListScreen (list/cards)
/// and TripDetailsScreen (full detail view). Formatted display strings
/// (status/distance/duration/earnings) are computed getters so both
/// screens stay in sync automatically.
///
/// TODO: replace mock instances with TripRepository.getTripHistory()
/// once backend is wired.
class TripRecord {
  final String orderId;
  final TripStatus statusValue;
  final String time; // display string, e.g. "Yesterday, 11:30 AM"
  final int sortKey; // minutes since midnight, for sorting
  final String pickupName;
  final String pickupAddress;
  final String pickupPhone;
  final String dropName;
  final String dropAddress;
  final String dropPhone;
  final double distanceKm;
  final int estimatedMinutes;
  final String serviceType; // e.g. "Premium", "Standard"

  // Package contents
  final String packageName;
  final String? packageImageUrl; // null → show placeholder icon
  final List<String>
  packageTags; // e.g. ["Electronics", "High Value", "Fragile"]
  final int packageQty;
  final bool otpVerified;

  // Earnings breakdown
  final double baseFare;
  final double peakHourIncentive; // 0 if not applicable
  final double premiumHandling; // 0 if not applicable
  // earningsAmount = baseFare + peakHourIncentive + premiumHandling

  const TripRecord({
    required this.orderId,
    required this.statusValue,
    required this.time,
    required this.sortKey,
    required this.pickupName,
    required this.pickupAddress,
    required this.pickupPhone,
    required this.dropName,
    required this.dropAddress,
    required this.dropPhone,
    required this.distanceKm,
    required this.estimatedMinutes,
    required this.serviceType,
    required this.packageName,
    this.packageImageUrl,
    this.packageTags = const [],
    this.packageQty = 1,
    this.otpVerified = false,
    required this.baseFare,
    this.peakHourIncentive = 0,
    this.premiumHandling = 0,
  });

  // ── Computed display strings ──────────────────────────────────────────────

  String get status {
    switch (statusValue) {
      case TripStatus.delivered:
        return 'Delivered';
      case TripStatus.ongoing:
        return 'Ongoing';
      case TripStatus.cancelled:
        return 'Cancelled';
    }
  }

  double get earningsAmount => baseFare + peakHourIncentive + premiumHandling;

  String get distance => '${distanceKm.toStringAsFixed(1)} km';
  String get duration => '$estimatedMinutes mins';
  String get earnings => '₹${earningsAmount.toStringAsFixed(2)}';

  // ── Mock data ─────────────────────────────────────────────────────────────

  static const TripRecord mockDelivered = TripRecord(
    orderId: 'LX-8829-01',
    statusValue: TripStatus.delivered,
    time: 'Yesterday, 11:30 AM',
    sortKey: 690,
    pickupName: 'ABC Electronics',
    pickupAddress: '12, 3rd Main Rd, Anna Nagar, Chennai - 600040',
    pickupPhone: '+91 98765 43210',
    dropName: 'Priya Sharma',
    dropAddress: '45, North Usman Road, T. Nagar, Chennai - 600017',
    dropPhone: '+91 91234 56789',
    distanceKm: 10.2,
    estimatedMinutes: 32,
    serviceType: 'Premium',
    packageName: 'MacBook Pro M3 Max',
    packageTags: ['Electronics', 'High Value', 'Fragile'],
    packageQty: 1,
    otpVerified: true,
    baseFare: 180.0,
    peakHourIncentive: 45.0,
    premiumHandling: 25.0,
  );
}
