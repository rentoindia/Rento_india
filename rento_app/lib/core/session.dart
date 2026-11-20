import 'package:flutter/foundation.dart';

import 'api_client.dart';
import 'json_utils.dart';
import 'realtime_client.dart';
import 'token_store.dart';

/// Who is logged in. Also starts / stops the realtime connection.
class Session extends ChangeNotifier {
  Session._();
  static final Session instance = Session._();

  /// Filled by the app (see bootstrap.dart): loads every service after login.
  Future<void> Function()? onLoggedIn;

  /// Called after logout (clear caches, go to the login screen).
  void Function()? onLoggedOut;

  bool get isLoggedIn => TokenStore.isLoggedIn;
  Map<String, dynamic>? get user => TokenStore.user;
  String? get userId => user == null ? null : strOrNull(user!['id']);
  String get fullName => str(user?['fullName']);
  String get phone => str(user?['phone']);
  List<String> get roles => asStrings(user?['roles']);

  /// Call once from main() before runApp().
  Future<void> init() async {
    await TokenStore.load();
    Api.instance.onSessionExpired = () {
      logout();
    };
    if (isLoggedIn) {
      Realtime.instance.connect();
      onLoggedIn?.call();
    }
  }

  /// Step 1 of login. Returns the OTP only while the backend is in dev-mode (no SMS key yet).
  Future<String?> requestOtp(String phone) async {
    final d = await Api.instance.post(
      '/api/v1/auth/request-otp',
      body: {'phone': phone},
      auth: false,
    );
    return strOrNull(asMap(d)['devOtp']);
  }

  /// Step 2 of login. [role] example: CUSTOMER, LENDER, RIDER, PROPERTY_OWNER, PROPERTY_TENANT
  Future<void> verifyOtp(String phone, String code, {String? role}) async {
    final d = asMap(
      await Api.instance.post(
        '/api/v1/auth/verify-otp',
        body: {'phone': phone, 'code': code, if (role != null) 'role': role},
        auth: false,
      ),
    );
    await _store(d);
  }

  /// Admin app login (phone or email + password).
  Future<void> adminLogin(String identifier, String password) async {
    final d = asMap(
      await Api.instance.post(
        '/api/v1/auth/admin/login',
        body: {'identifier': identifier, 'password': password},
        auth: false,
      ),
    );
    await _store(d);
  }

  Future<void> _store(Map<String, dynamic> d) async {
    await TokenStore.save(
      access: str(d['accessToken']),
      refresh: str(d['refreshToken']),
      userJson: asMap(d['user']),
    );
    Realtime.instance.connect();
    notifyListeners();
    await onLoggedIn?.call();
  }

  /// Re-reads the profile (e.g. after becoming a lender or rider).
  Future<void> refreshProfile() async {
    final d = asMap(await Api.instance.get('/api/v1/me'));
    await TokenStore.saveUser(d);
    notifyListeners();
  }

  Future<void> updateProfile({
    String? fullName,
    String? email,
    String? location,
    String? profileImageUrl,
  }) async {
    final d = asMap(
      await Api.instance.put(
        '/api/v1/me',
        body: {
          if (fullName != null) 'fullName': fullName,
          if (email != null) 'email': email,
          if (location != null) 'location': location,
          if (profileImageUrl != null) 'profileImageUrl': profileImageUrl,
        },
      ),
    );
    await TokenStore.saveUser(d);
    notifyListeners();
  }

  /// Adds a role (portal) to this account, e.g. when the user opens the Rider or Owner portal.
  Future<void> addRole(String role) async {
    try {
      final d = asMap(
        await Api.instance.post('/api/v1/me/roles', body: {'role': role}),
      );
      await TokenStore.saveUser(d);
      notifyListeners();
    } catch (_) {}
  }

  Future<void> logout() async {
    Realtime.instance.disconnect();
    await TokenStore.clear();
    notifyListeners();
    onLoggedOut?.call();
  }
}
