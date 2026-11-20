import '../../core/api_client.dart';
import '../../core/json_utils.dart';
import '../features/rider/data/models/trip_request_model.dart';

/// Calls the rider endpoints of the backend (/api/v1/rider/...).
class RiderApi {
  RiderApi._();
  static final RiderApi instance = RiderApi._();

  /// Rider profile + status (PENDING until an admin approves the documents).
  Future<Map<String, dynamic>> me() async =>
      asMap(await Api.instance.get('/api/v1/rider/me'));

  /// Sends the finished registration form. [body] keys: name, email, dob, address, aadhaar,
  /// emergencyContact, vehicleType, vehicleNumber, brandModel, rcNumber, insuranceValidTill,
  /// bankAccountNumber, bankIfsc, deliveryZone, documents: [{type, documentNumber, fileUrl}]
  Future<Map<String, dynamic>> register(Map<String, dynamic> body) async =>
      asMap(await Api.instance.post('/api/v1/rider/register', body: body));

  Future<Map<String, dynamic>> setOnline(
    bool online, {
    double? lat,
    double? lng,
  }) async => asMap(
    await Api.instance.post(
      '/api/v1/rider/online',
      body: {
        'online': online,
        if (lat != null) 'lat': lat,
        if (lng != null) 'lng': lng,
      },
    ),
  );

  /// Jobs waiting for a rider (rental deliveries, returns, parcels, rides).
  Future<List<Map<String, dynamic>>> available() async =>
      asMaps(await Api.instance.get('/api/v1/rider/jobs/available'));

  Future<Map<String, dynamic>> accept(String kind, String id) async =>
      asMap(await Api.instance.post('/api/v1/rider/jobs/$kind/$id/accept'));

  /// Throws ApiException("Incorrect OTP...") when the code is wrong.
  Future<Map<String, dynamic>> verifyPickup(
    String kind,
    String id,
    String otp, {
    Map<String, dynamic>? extra,
  }) async => asMap(
    await Api.instance.post(
      '/api/v1/rider/jobs/$kind/$id/verify-pickup',
      body: {'otp': otp, ...?extra},
    ),
  );

  Future<Map<String, dynamic>> verifyDrop(
    String kind,
    String id,
    String otp, {
    Map<String, dynamic>? extra,
  }) async => asMap(
    await Api.instance.post(
      '/api/v1/rider/jobs/$kind/$id/verify-drop',
      body: {'otp': otp, ...?extra},
    ),
  );

  Future<void> release(String kind, String id, {String? reason}) async {
    await Api.instance.post(
      '/api/v1/rider/jobs/$kind/$id/release',
      body: {'reason': reason},
    );
  }

  /// Live position. Pass [kind]/[jobId] while a job is active so the customer sees the rider move.
  Future<void> sendLocation(
    double lat,
    double lng, {
    String? kind,
    String? jobId,
  }) async {
    await Api.instance.post(
      '/api/v1/rider/location',
      body: {
        'lat': lat,
        'lng': lng,
        if (kind != null) 'jobKind': kind,
        if (jobId != null) 'jobId': jobId,
      },
    );
  }

  Future<Map<String, dynamic>> earnings() async =>
      asMap(await Api.instance.get('/api/v1/rider/earnings'));

  Future<List<Map<String, dynamic>>> history() async =>
      asMaps(await Api.instance.get('/api/v1/rider/jobs/history'));
}

/// Backend job (kind TRIP) -> the model the rider screens already use.
TripRequestModel tripFromApi(Map<String, dynamic> j) {
  final img = strOrNull(j['imageUrl']);
  return TripRequestModel(
    id: str(j['id']),
    itemName: str(j['itemName'], 'Item'),
    category: str(j['category']),
    distanceKm: dbl(j['distanceKm']),
    pickupLabel: str(j['pickupLabel']),
    pickupAddress: str(j['pickupAddress']),
    dropLabel: str(j['dropLabel']),
    dropAddress: str(j['dropAddress']),
    estimatedMinutes: intv(j['estimatedMinutes'], 20),
    earnings: dbl(j['earnings']),
    qty: intv(j['qty'], 1),
    status: str(j['priority'], 'ACTIVE NOW'),
    rating: dbl(j['rating'], 4.8),
    imageAsset: (img != null && img.startsWith('assets/')) ? img : null,
    showTripMap: false,
    requestType: str(j['requestType']) == 'returnPickup'
        ? TripRequestType.returnPickup
        : TripRequestType.delivery,
  );
}
