import '../../core/json_utils.dart';
import '../parcel/models/rider_model.dart';
import '../person/models/captain_model.dart';

/// The parcel / ride the customer is booking or tracking right now (latest data from the server).
class BookingSession {
  BookingSession._();
  static final BookingSession instance = BookingSession._();

  Map<String, dynamic>? parcel;
  Map<String, dynamic>? ride;

  String? get parcelId => strOrNull(parcel?['id']);
  String? get rideId => strOrNull(ride?['id']);

  void clearParcel() => parcel = null;
  void clearRide() => ride = null;

  /// Rider of the current parcel (shown on the tracking screen).
  RiderModel? get parcelRider {
    final r = parcel?['rider'];
    if (r is! Map) return null;
    final m = asMap(r);
    return RiderModel(
      name: str(m['name'], 'Rider'),
      rating: dbl(m['rating'], 4.8),
      vehicleName: str(m['vehicleModel'], str(m['vehicleType'])),
      vehicleNumber: str(m['vehicleNumber']),
      verified: true,
    );
  }

  /// Captain of the current ride.
  CaptainModel? get rideCaptain {
    final r = ride?['rider'];
    if (r is! Map) return null;
    final m = asMap(r);
    final name = str(m['name'], 'Captain');
    final parts = name.trim().split(RegExp(r'\s+'));
    final initials = parts.length >= 2
        ? '${parts.first[0]}${parts.last[0]}'.toUpperCase()
        : name.substring(0, name.length >= 2 ? 2 : name.length).toUpperCase();
    return CaptainModel(
      name: name,
      initials: initials,
      rating: dbl(m['rating'], 4.8),
      completedRides: 0,
      vehicleName: str(m['vehicleModel'], str(m['vehicleType'])),
      vehicleNumber: str(m['vehicleNumber']),
    );
  }
}
