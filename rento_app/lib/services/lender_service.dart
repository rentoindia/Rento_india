import 'dart:async';

import 'package:flutter/material.dart';

import '../core/api_client.dart';
import '../core/api_config.dart';
import '../core/json_utils.dart';
import '../core/realtime_client.dart';
import '../core/session.dart';

class ProductSpecEntry {
  final String label;
  final String value;
  const ProductSpecEntry({required this.label, required this.value});

  Map<String, dynamic> toJson() => {'label': label, 'value': value};

  factory ProductSpecEntry.fromJson(Map<String, dynamic> json) =>
      ProductSpecEntry(label: json['label'] ?? '', value: json['value'] ?? '');
}

class LenderProduct {
  final String id;
  final String name;
  final String category;
  final String subcategory;
  final String mrp;
  final String pricePerDay;
  final String pricePerWeek;
  final String pricePerMonth;
  final String securityDeposit;
  final String description;
  final List<String?> imagePaths; // 3 photo slots
  final String? videoPath; // one optional product video
  final List<ProductSpecEntry> specs;
  final DateTime addedOn;
  final bool isPaused;

  LenderProduct({
    required this.id,
    required this.name,
    required this.category,
    this.subcategory = '',
    this.mrp = '',
    required this.pricePerDay,
    this.pricePerWeek = '',
    this.pricePerMonth = '',
    this.securityDeposit = '',
    required this.description,
    List<String?>? imagePaths,
    this.videoPath,
    List<ProductSpecEntry>? specs,
    required this.addedOn,
    this.isPaused = false,
  }) : imagePaths = imagePaths ?? [null, null, null],
       specs = specs ?? const [];

  String? get firstImage {
    for (final p in imagePaths) {
      if (p != null) return p;
    }
    return null;
  }

  LenderProduct copyWith({
    String? name,
    String? category,
    String? subcategory,
    String? mrp,
    String? pricePerDay,
    String? pricePerWeek,
    String? pricePerMonth,
    String? securityDeposit,
    String? description,
    List<String?>? imagePaths,
    String? videoPath,
    bool clearVideo = false,
    List<ProductSpecEntry>? specs,
    bool? isPaused,
  }) {
    return LenderProduct(
      id: id,
      name: name ?? this.name,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      mrp: mrp ?? this.mrp,
      pricePerDay: pricePerDay ?? this.pricePerDay,
      pricePerWeek: pricePerWeek ?? this.pricePerWeek,
      pricePerMonth: pricePerMonth ?? this.pricePerMonth,
      securityDeposit: securityDeposit ?? this.securityDeposit,
      description: description ?? this.description,
      imagePaths: imagePaths ?? this.imagePaths,
      videoPath: clearVideo ? null : (videoPath ?? this.videoPath),
      specs: specs ?? this.specs,
      addedOn: addedOn,
      isPaused: isPaused ?? this.isPaused,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'category': category,
    'subcategory': subcategory,
    'mrp': mrp,
    'pricePerDay': pricePerDay,
    'pricePerWeek': pricePerWeek,
    'pricePerMonth': pricePerMonth,
    'securityDeposit': securityDeposit,
    'description': description,
    'imagePaths': imagePaths,
    'videoPath': videoPath,
    'specs': specs.map((s) => s.toJson()).toList(),
    'addedOn': addedOn.toIso8601String(),
    'isPaused': isPaused,
  };

  factory LenderProduct.fromJson(Map<String, dynamic> json) {
    List<String?> paths;
    if (json['imagePaths'] != null) {
      paths = (json['imagePaths'] as List<dynamic>)
          .map((e) => e as String?)
          .toList();
    } else if (json['imagePath'] != null) {
      paths = [json['imagePath'] as String?, null, null];
    } else {
      paths = [null, null, null];
    }

    final specsJson = json['specs'] as List<dynamic>?;

    return LenderProduct(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      subcategory: json['subcategory'] ?? '',
      mrp: json['mrp'] ?? '',
      pricePerDay: json['pricePerDay'] ?? '',
      pricePerWeek: json['pricePerWeek'] ?? '',
      pricePerMonth: json['pricePerMonth'] ?? '',
      securityDeposit: json['securityDeposit'] ?? '',
      description: json['description'] ?? '',
      imagePaths: paths,
      videoPath: json['videoPath'],
      specs:
          specsJson?.map((e) => ProductSpecEntry.fromJson(e)).toList() ??
          const [],
      addedOn: DateTime.parse(json['addedOn']),
      isPaused: json['isPaused'] ?? false,
    );
  }
}

enum RentalRequestStatus { pending, accepted, rejected }

class RentalRequest {
  final String id;
  final String productId;
  final String productName;
  final String customerName;
  final String duration; // display string, e.g. "3 days"
  final String deliveryAddress;
  final double amount;
  final DateTime requestedOn;
  RentalRequestStatus status;

  RentalRequest({
    required this.id,
    required this.productId,
    required this.productName,
    required this.customerName,
    required this.duration,
    required this.deliveryAddress,
    required this.amount,
    required this.requestedOn,
    this.status = RentalRequestStatus.pending,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'productId': productId,
    'productName': productName,
    'customerName': customerName,
    'duration': duration,
    'deliveryAddress': deliveryAddress,
    'amount': amount,
    'requestedOn': requestedOn.toIso8601String(),
    'status': status.name,
  };

  factory RentalRequest.fromJson(Map<String, dynamic> json) => RentalRequest(
    id: json['id'],
    productId: json['productId'] ?? '',
    productName: json['productName'] ?? '',
    customerName: json['customerName'] ?? '',
    duration: json['duration'] ?? '',
    deliveryAddress: json['deliveryAddress'] ?? '',
    amount: (json['amount'] as num?)?.toDouble() ?? 0,
    requestedOn: json['requestedOn'] != null
        ? DateTime.parse(json['requestedOn'])
        : DateTime.now(),
    status: RentalRequestStatus.values.firstWhere(
      (s) => s.name == json['status'],
      orElse: () => RentalRequestStatus.pending,
    ),
  );
}

String _numStr(dynamic v) {
  final d = dbl(v);
  if (d == 0) return '';
  return d == d.roundToDouble() ? d.round().toString() : d.toString();
}

LenderProduct _productFromApi(Map<String, dynamic> j) {
  final images = asStrings(j['imageUrls'])
      .map((u) => ApiConfig.resolveUrl(u))
      .toList();
  final slots = <String?>[null, null, null];
  for (var i = 0; i < images.length && i < 3; i++) {
    slots[i] = images[i];
  }
  return LenderProduct(
    id: str(j['id']),
    name: str(j['name']),
    category: str(j['category']),
    subcategory: str(j['subcategory']),
    mrp: _numStr(j['mrp']),
    pricePerDay: _numStr(j['pricePerDay']),
    pricePerWeek: _numStr(j['pricePerWeek']),
    pricePerMonth: _numStr(j['pricePerMonth']),
    securityDeposit: _numStr(j['securityDeposit']),
    description: str(j['description']),
    imagePaths: slots,
    videoPath: ApiConfig.resolveUrl(strOrNull(j['videoUrl'])),
    specs: asMaps(j['specs'])
        .map(
          (s) =>
              ProductSpecEntry(label: str(s['label']), value: str(s['value'])),
        )
        .toList(),
    addedOn: date(j['createdAt']) ?? DateTime.now(),
    isPaused: str(j['status']).toUpperCase() == 'INACTIVE',
  );
}

RentalRequest _requestFromApi(Map<String, dynamic> j) {
  final status =
      (boolv(j['rejectedByVendor']) ||
          str(j['status']).toUpperCase() == 'CANCELLED')
      ? RentalRequestStatus.rejected
      : boolv(j['vendorAccepted'])
      ? RentalRequestStatus.accepted
      : RentalRequestStatus.pending;
  final days = intv(j['days'], 1);
  return RentalRequest(
    id: str(j['id']),
    productId: str(j['productId']),
    productName: str(j['productName']),
    customerName: str(j['customerName'], 'Customer'),
    duration: days == 1 ? '1 day' : '$days days',
    deliveryAddress: str(j['deliveryAddress']),
    amount: dbl(j['rentalAmount']),
    requestedOn: date(j['createdAt']) ?? DateTime.now(),
    status: status,
  );
}

/// Lender side of the marketplace. Everything is stored on the server; rental requests from
/// customers arrive live through the realtime connection.
class LenderService extends ChangeNotifier {
  LenderService._() {
    Realtime.instance.on('order.updated').listen(_onOrder);
  }
  static final LenderService instance = LenderService._();

  bool isVerified = false;
  String fullName = '';
  String mobileNumber = '';
  String email = '';
  String aadharNumber = '';
  String homeAddress = '';

  final List<LenderProduct> _products = [];
  List<LenderProduct> get products => List.unmodifiable(_products);

  final List<RentalRequest> _requests = [];
  List<RentalRequest> get requests => List.unmodifiable(_requests);

  int get pendingRequestCount =>
      _requests.where((r) => r.status == RentalRequestStatus.pending).length;

  double get totalEarnings => _requests
      .where((r) => r.status == RentalRequestStatus.accepted)
      .fold(0.0, (sum, r) => sum + r.amount);
  double get pendingEarnings => _requests
      .where((r) => r.status == RentalRequestStatus.pending)
      .fold(0.0, (sum, r) => sum + r.amount);
  int get completedRentalsCount =>
      _requests.where((r) => r.status == RentalRequestStatus.accepted).length;

  bool _loaded = false;

  /// Screens call this in initState. Loads once; use [refresh] to force a reload.
  Future<void> load() async {
    if (_loaded) return;
    await refresh();
  }

  Future<void> refresh() async {
    if (!Session.instance.isLoggedIn) return;
    try {
      final p = asMap(await Api.instance.get('/api/v1/lender/profile'));
      isVerified = boolv(p['verified']);
      fullName = str(p['name']);
      mobileNumber = str(p['mobile']);
      email = str(p['email']);
      aadharNumber = str(p['aadhaar']);
      homeAddress = str(p['address']);

      final prods = asMaps(await Api.instance.get('/api/v1/lender/products'));
      _products
        ..clear()
        ..addAll(prods.map(_productFromApi));

      final reqs = asMaps(await Api.instance.get('/api/v1/lender/requests'));
      _requests
        ..clear()
        ..addAll(reqs.map(_requestFromApi));
      _loaded = true;
      notifyListeners();
    } catch (e) {
      debugPrint('lender load failed: $e');
    }
  }

  void clear() {
    _loaded = false;
    isVerified = false;
    fullName = mobileNumber = email = aadharNumber = homeAddress = '';
    _products.clear();
    _requests.clear();
    notifyListeners();
  }

  void _onOrder(Map<String, dynamic> j) {
    if (str(j['lenderId']) != Session.instance.userId) return;
    final r = _requestFromApi(j);
    final i = _requests.indexWhere((x) => x.id == r.id);
    if (i >= 0) {
      _requests[i] = r;
    } else {
      _requests.insert(0, r);
    }
    notifyListeners();
  }

  Future<void> submitVerification({
    required String name,
    required String mobile,
    required String emailAddress,
    required String aadhar,
    required String homeAddress,
  }) async {
    await Api.instance.post(
      '/api/v1/lender/verification',
      body: {
        'name': name,
        'email': emailAddress,
        'aadhaar': aadhar,
        'address': homeAddress,
      },
    );
    fullName = name;
    mobileNumber = mobile;
    email = emailAddress;
    aadharNumber = aadhar;
    this.homeAddress = homeAddress;
    isVerified = true;
    await Session.instance.refreshProfile();
    notifyListeners();
  }

  Future<Map<String, dynamic>> _body({
    required String name,
    required String category,
    String subcategory = '',
    String mrp = '',
    required String pricePerDay,
    String pricePerWeek = '',
    String pricePerMonth = '',
    String securityDeposit = '',
    required String description,
    List<String?>? imagePaths,
    String? videoPath,
    List<ProductSpecEntry>? specs,
  }) async {
    final localOrRemote = (imagePaths ?? const <String?>[])
        .whereType<String>()
        .toList();
    final urls = await Api.instance.uploadAllIfLocal(localOrRemote);
    String? videoUrl;
    if (videoPath != null && videoPath.isNotEmpty) {
      videoUrl = (await Api.instance.uploadAllIfLocal([videoPath])).first;
    }
    return {
      'name': name,
      'category': category,
      'subcategory': subcategory,
      'mrp': mrp,
      'pricePerDay': pricePerDay,
      'pricePerWeek': pricePerWeek,
      'pricePerMonth': pricePerMonth,
      'securityDeposit': securityDeposit,
      'description': description,
      'imageUrls': urls
          .map(
            (u) => u.startsWith('http')
                ? u.replaceFirst(ApiConfig.baseUrl, '')
                : u,
          )
          .toList(),
      'videoUrl': videoUrl == null
          ? null
          : videoUrl.replaceFirst(ApiConfig.baseUrl, ''),
      'specs': (specs ?? const <ProductSpecEntry>[])
          .map((s) => s.toJson())
          .toList(),
    };
  }

  Future<void> addProduct({
    required String name,
    required String category,
    String subcategory = '',
    String mrp = '',
    required String pricePerDay,
    String pricePerWeek = '',
    String pricePerMonth = '',
    String securityDeposit = '',
    required String description,
    List<String?>? imagePaths,
    String? videoPath,
    List<ProductSpecEntry>? specs,
  }) async {
    final body = await _body(
      name: name,
      category: category,
      subcategory: subcategory,
      mrp: mrp,
      pricePerDay: pricePerDay,
      pricePerWeek: pricePerWeek,
      pricePerMonth: pricePerMonth,
      securityDeposit: securityDeposit,
      description: description,
      imagePaths: imagePaths,
      videoPath: videoPath,
      specs: specs,
    );
    final d = asMap(
      await Api.instance.post('/api/v1/lender/products', body: body),
    );
    _products.insert(0, _productFromApi(d));
    notifyListeners();
  }

  Future<void> updateProduct(LenderProduct updated) async {
    final index = _products.indexWhere((p) => p.id == updated.id);
    if (index == -1) return;
    final body = await _body(
      name: updated.name,
      category: updated.category,
      subcategory: updated.subcategory,
      mrp: updated.mrp,
      pricePerDay: updated.pricePerDay,
      pricePerWeek: updated.pricePerWeek,
      pricePerMonth: updated.pricePerMonth,
      securityDeposit: updated.securityDeposit,
      description: updated.description,
      imagePaths: updated.imagePaths,
      videoPath: updated.videoPath,
      specs: updated.specs,
    );
    final d = asMap(
      await Api.instance.put(
        '/api/v1/lender/products/${updated.id}',
        body: body,
      ),
    );
    _products[index] = _productFromApi(d);
    notifyListeners();
  }

  Future<void> togglePause(String id) async {
    final index = _products.indexWhere((p) => p.id == id);
    if (index == -1) return;
    final d = asMap(
      await Api.instance.post('/api/v1/lender/products/$id/toggle-pause'),
    );
    _products[index] = _productFromApi(d);
    notifyListeners();
  }

  Future<void> removeProduct(String id) async {
    await Api.instance.delete('/api/v1/lender/products/$id');
    _products.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  Future<void> respondToRequest(String id, RentalRequestStatus status) async {
    final index = _requests.indexWhere((r) => r.id == id);
    if (index == -1) return;
    final d = asMap(
      await Api.instance.post(
        '/api/v1/lender/requests/$id/respond',
        body: {
          'accept': status == RentalRequestStatus.accepted,
          'reason': 'Declined by the vendor',
        },
      ),
    );
    _requests[index] = _requestFromApi(d);
    notifyListeners();
  }
}
