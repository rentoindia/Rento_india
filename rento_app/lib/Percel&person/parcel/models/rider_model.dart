import '../../core/booking_session.dart';

class RiderModel {
  const RiderModel({
    required this.name,
    required this.rating,
    required this.vehicleName,
    required this.vehicleNumber,
    this.photoAsset,
    this.verified = false,
    this.completedDeliveries = 0,
  });

  final String name;
  final double rating;
  final String vehicleName;
  final String vehicleNumber;
  final String? photoAsset;
  final bool verified;
  final int completedDeliveries;
}

const RiderModel _kDemoRider = RiderModel(
  name: 'Marcus Chen',
  rating: 4.8,
  vehicleName: 'Black Splendor Plus',
  vehicleNumber: 'TN 09 AB 1234',
  verified: true,
  completedDeliveries: 1247,
);

/// The rider assigned to the parcel being tracked (real data from the server).
RiderModel get kAssignedRider =>
    BookingSession.instance.parcelRider ?? _kDemoRider;

enum TrackingStage {
  searchingRider,
  riderAssigned,
  onTheWayToPickup,
  riderArrivedAtPickup,
  pickupOtp,
  parcelPickedUp,
  onTheWayToReceiver,
  riderNearReceiver,
  deliveryOtp,
  parcelDelivered,
}

extension TrackingStageX on TrackingStage {
  bool get isTrackingToPickup =>
      this == TrackingStage.onTheWayToPickup ||
      this == TrackingStage.riderArrivedAtPickup;

  bool get isTrackingToReceiver =>
      this == TrackingStage.parcelPickedUp ||
      this == TrackingStage.onTheWayToReceiver ||
      this == TrackingStage.riderNearReceiver;

  bool get showsRiderCard => index >= TrackingStage.riderAssigned.index;
}
