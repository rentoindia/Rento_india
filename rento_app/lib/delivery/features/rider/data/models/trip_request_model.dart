// /// A single incoming/available delivery request.
// class TripRequestModel {
//   final String id;
//   final String itemName;
//   final String category;
//   final double distanceKm;
//   final String pickupLabel;
//   final String pickupAddress;
//   final String dropLabel;
//   final String dropAddress;
//   final int estimatedMinutes;
//   final double earnings;
//   final int qty;

//   // ⭐ NEW — used by the redesigned Requests screen.
//   final String status; // 'ACTIVE NOW' | 'SCHEDULED' | 'URGENT'
//   final double rating; // customer rating, e.g. 4.9
//   final String? imageAsset; // path under assets/images/products/...
//   final bool showTripMap; // show map preview on the card

//   const TripRequestModel({
//     required this.id,
//     required this.itemName,
//     required this.category,
//     required this.distanceKm,
//     required this.pickupLabel,
//     required this.pickupAddress,
//     required this.dropLabel,
//     required this.dropAddress,
//     required this.estimatedMinutes,
//     required this.earnings,
//     this.qty = 1,
//     this.status = 'ACTIVE NOW',
//     this.rating = 4.8,
//     this.imageAsset,
//     this.showTripMap = false,
//   });

//   factory TripRequestModel.fromJson(Map<String, dynamic> json) {
//     return TripRequestModel(
//       id: json['id'] as String,
//       itemName: json['itemName'] as String,
//       category: json['category'] as String,
//       distanceKm: (json['distanceKm'] as num).toDouble(),
//       pickupLabel: json['pickupLabel'] as String,
//       pickupAddress: json['pickupAddress'] as String,
//       dropLabel: json['dropLabel'] as String,
//       dropAddress: json['dropAddress'] as String,
//       estimatedMinutes: json['estimatedMinutes'] as int,
//       earnings: (json['earnings'] as num).toDouble(),
//       qty: json['qty'] as int? ?? 1,
//       status: json['status'] as String? ?? 'ACTIVE NOW',
//       rating: (json['rating'] as num?)?.toDouble() ?? 4.8,
//       imageAsset: json['imageAsset'] as String?,
//       showTripMap: json['showTripMap'] as bool? ?? false,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'itemName': itemName,
//     'category': category,
//     'distanceKm': distanceKm,
//     'pickupLabel': pickupLabel,
//     'pickupAddress': pickupAddress,
//     'dropLabel': dropLabel,
//     'dropAddress': dropAddress,
//     'estimatedMinutes': estimatedMinutes,
//     'earnings': earnings,
//     'qty': qty,
//     'status': status,
//     'rating': rating,
//     'imageAsset': imageAsset,
//     'showTripMap': showTripMap,
//   };
// }

/// Distinguishes a normal delivery request from a return-pickup request.
///
/// - delivery     → rider goes to the vendor, picks up, delivers to the
///   customer (existing flow: NavigateToVendor → PickupOtp →
///   NavigateToCustomer → DeliveryOtp).
/// - returnPickup → rental has ended; rider goes to the CUSTOMER first
///   to collect the item back, then to the VENDOR to hand it in
///   (ReturnPickupScreen → VendorReturnScreen).
enum TripRequestType { delivery, returnPickup }

/// A single incoming/available delivery request.
class TripRequestModel {
  final String id;
  final String itemName;
  final String category;
  final double distanceKm;
  final String pickupLabel;
  final String pickupAddress;
  final String dropLabel;
  final String dropAddress;
  final int estimatedMinutes;
  final double earnings;
  final int qty;

  // ⭐ NEW — used by the redesigned Requests screen.
  final String status; // 'ACTIVE NOW' | 'SCHEDULED' | 'URGENT'
  final double rating; // customer rating, e.g. 4.9
  final String? imageAsset; // path under assets/images/products/...
  final bool showTripMap; // show map preview on the card

  // ⭐ NEW — delivery request vs. return-pickup request.
  final TripRequestType requestType;

  const TripRequestModel({
    required this.id,
    required this.itemName,
    required this.category,
    required this.distanceKm,
    required this.pickupLabel,
    required this.pickupAddress,
    required this.dropLabel,
    required this.dropAddress,
    required this.estimatedMinutes,
    required this.earnings,
    this.qty = 1,
    this.status = 'ACTIVE NOW',
    this.rating = 4.8,
    this.imageAsset,
    this.showTripMap = false,
    this.requestType = TripRequestType.delivery,
  });

  bool get isReturnPickup => requestType == TripRequestType.returnPickup;

  factory TripRequestModel.fromJson(Map<String, dynamic> json) {
    return TripRequestModel(
      id: json['id'] as String,
      itemName: json['itemName'] as String,
      category: json['category'] as String,
      distanceKm: (json['distanceKm'] as num).toDouble(),
      pickupLabel: json['pickupLabel'] as String,
      pickupAddress: json['pickupAddress'] as String,
      dropLabel: json['dropLabel'] as String,
      dropAddress: json['dropAddress'] as String,
      estimatedMinutes: json['estimatedMinutes'] as int,
      earnings: (json['earnings'] as num).toDouble(),
      qty: json['qty'] as int? ?? 1,
      status: json['status'] as String? ?? 'ACTIVE NOW',
      rating: (json['rating'] as num?)?.toDouble() ?? 4.8,
      imageAsset: json['imageAsset'] as String?,
      showTripMap: json['showTripMap'] as bool? ?? false,
      requestType: (json['requestType'] as String?) == 'returnPickup'
          ? TripRequestType.returnPickup
          : TripRequestType.delivery,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'itemName': itemName,
    'category': category,
    'distanceKm': distanceKm,
    'pickupLabel': pickupLabel,
    'pickupAddress': pickupAddress,
    'dropLabel': dropLabel,
    'dropAddress': dropAddress,
    'estimatedMinutes': estimatedMinutes,
    'earnings': earnings,
    'qty': qty,
    'status': status,
    'rating': rating,
    'imageAsset': imageAsset,
    'showTripMap': showTripMap,
    'requestType': requestType == TripRequestType.returnPickup
        ? 'returnPickup'
        : 'delivery',
  };
}
