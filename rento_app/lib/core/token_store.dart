import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Keeps the login tokens on the phone so the user stays logged in.
class TokenStore {
  static const _kAccess = 'api_access_token';
  static const _kRefresh = 'api_refresh_token';
  static const _kUser = 'api_user_json';

  static String? accessToken;
  static String? refreshToken;
  static Map<String, dynamic>? user;

  static bool get isLoggedIn => accessToken != null && accessToken!.isNotEmpty;

  static Future<void> load() async {
    final p = await SharedPreferences.getInstance();
    accessToken = p.getString(_kAccess);
    refreshToken = p.getString(_kRefresh);
    final u = p.getString(_kUser);
    if (u != null) {
      try {
        user = Map<String, dynamic>.from(jsonDecode(u) as Map);
      } catch (_) {
        user = null;
      }
    }
  }

  static Future<void> save({
    required String access,
    required String refresh,
    Map<String, dynamic>? userJson,
  }) async {
    accessToken = access;
    refreshToken = refresh;
    if (userJson != null) user = userJson;
    final p = await SharedPreferences.getInstance();
    await p.setString(_kAccess, access);
    await p.setString(_kRefresh, refresh);
    if (user != null) await p.setString(_kUser, jsonEncode(user));
  }

  static Future<void> saveUser(Map<String, dynamic> userJson) async {
    user = userJson;
    final p = await SharedPreferences.getInstance();
    await p.setString(_kUser, jsonEncode(userJson));
  }

  static Future<void> clear() async {
    accessToken = null;
    refreshToken = null;
    user = null;
    final p = await SharedPreferences.getInstance();
    await p.remove(_kAccess);
    await p.remove(_kRefresh);
    await p.remove(_kUser);
  }
}
