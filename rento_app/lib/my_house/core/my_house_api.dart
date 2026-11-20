import '../../core/api_client.dart';
import '../../core/api_config.dart';
import '../../core/json_utils.dart';

/// My House (property rental) calls to the backend (/api/v1/myhouse/...).
class MyHouseApi {
  MyHouseApi._();
  static final MyHouseApi instance = MyHouseApi._();

  static const String _fallbackImage =
      'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688';

  /// Approved properties as the same "card map" the search screens already use.
  Future<List<Map<String, String>>> searchProperties({
    String city = '',
    String q = '',
  }) async {
    final d = asMap(
      await Api.instance.get(
        '/api/v1/myhouse/public/properties',
        query: {
          'size': '200',
          if (city.isNotEmpty) 'city': city,
          if (q.isNotEmpty) 'q': q,
        },
        auth: false,
      ),
    );
    return asMaps(d['items']).map(propertyCard).toList();
  }

  static String _inr(num v) {
    final s = v.round().toString();
    final b = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) b.write(',');
      b.write(s[i]);
    }
    return b.toString();
  }

  static Map<String, String> propertyCard(Map<String, dynamic> j) {
    final images = asStrings(j['images']);
    final units = intv(j['availableUnits']);
    return {
      'id': str(j['id']),
      'bhk': str(j['bhk']),
      'title': str(j['title']),
      'locality': str(j['locality']),
      'city': str(j['city']),
      'price': '₹${_inr(dbl(j['monthlyRent']))} / month',
      'available': '$units Available',
      'image': images.isEmpty
          ? _fallbackImage
          : (ApiConfig.resolveUrl(images.first) ?? _fallbackImage),
      'furnishing': str(j['furnishing']),
      'suitableFor': str(j['suitableFor']),
      'description': str(j['description']),
      'ownerName': str(j['ownerName']),
      'rent': str(j['monthlyRent']),
    };
  }

  Future<void> apply({
    required String? propertyId,
    DateTime? moveIn,
    String? message,
    int occupants = 1,
  }) async {
    await Api.instance.post(
      '/api/v1/myhouse/tenant/applications',
      body: {
        'propertyId': propertyId,
        'moveInDate': isoUtc(moveIn),
        'message': message,
        'occupants': occupants,
      },
    );
  }

  Future<void> requestVisit({
    required String? propertyId,
    DateTime? date,
    String? slot,
  }) async {
    await Api.instance.post(
      '/api/v1/myhouse/tenant/visits',
      body: {'propertyId': propertyId, 'visitDate': isoUtc(date), 'slot': slot},
    );
  }

  Future<void> raiseMaintenance({
    required String issue,
    String? category,
    String? description,
    String? location,
    String? propertyId,
  }) async {
    await Api.instance.post(
      '/api/v1/myhouse/tenant/maintenance',
      body: {
        'issue': issue,
        'category': category,
        'description': description,
        'location': location,
        if (propertyId != null) 'propertyId': propertyId,
      },
    );
  }

  Future<void> payRent({
    required String propertyId,
    required String month,
    required double amount,
    String method = 'UPI',
  }) async {
    await Api.instance.post(
      '/api/v1/myhouse/tenant/rent',
      body: {
        'propertyId': propertyId,
        'month': month,
        'amount': amount,
        'method': method,
      },
    );
  }

  Future<void> payUtility({
    required String category,
    required String provider,
    required String accountNumber,
    required double amount,
    String method = 'UPI',
  }) async {
    await Api.instance.post(
      '/api/v1/myhouse/tenant/utilities',
      body: {
        'category': category,
        'provider': provider,
        'accountNumber': accountNumber,
        'amount': amount,
        'method': method,
      },
    );
  }

  /// Owner: list a property (it goes to the admin for approval).
  Future<Map<String, dynamic>> createProperty(
    Map<String, dynamic> body,
  ) async => asMap(
    await Api.instance.post('/api/v1/myhouse/owner/properties', body: body),
  );

  Future<List<Map<String, dynamic>>> ownerApplications() async =>
      asMaps(await Api.instance.get('/api/v1/myhouse/owner/applications'));

  Future<void> decideApplication(
    String id,
    bool approve, {
    String? note,
  }) async {
    await Api.instance.post(
      '/api/v1/myhouse/owner/applications/$id/decide',
      body: {'approve': approve, 'note': note},
    );
  }
}
