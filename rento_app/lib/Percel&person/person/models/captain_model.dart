import '../../core/booking_session.dart';

class CaptainModel {
  const CaptainModel({
    required this.name,
    required this.initials,
    required this.rating,
    required this.completedRides,
    required this.vehicleName,
    required this.vehicleNumber,
    this.verified = true,
  });

  final String name;
  final String initials;
  final double rating;
  final int completedRides;
  final String vehicleName;
  final String vehicleNumber;
  final bool verified;
}

const CaptainModel _kDemoCaptain = CaptainModel(
  name: 'Rajesh Kumar',
  initials: 'RK',
  rating: 4.9,
  completedRides: 1134,
  vehicleName: 'Honda Active 6G',
  vehicleNumber: 'TN09 AB 1234',
  verified: true,
);

/// The captain assigned to the ride being tracked (real data from the server).
CaptainModel get kAssignedCaptain =>
    BookingSession.instance.rideCaptain ?? _kDemoCaptain;

enum RideTrackingStage {
  searchingCaptain,
  captainAssigned,
  captainArriving,
  captainArrived,
  rideInProgress,
  rideCompleted,
}

extension RideTrackingStageX on RideTrackingStage {
  bool get showsCaptainCard => index >= RideTrackingStage.captainAssigned.index;

  bool get isEnRouteToPickup =>
      this == RideTrackingStage.captainArriving ||
      this == RideTrackingStage.captainArrived;
}
