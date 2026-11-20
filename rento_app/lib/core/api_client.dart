import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_config.dart';
import 'token_store.dart';

/// Error shown to the user. [message] is already friendly.
class ApiException implements Exception {
  final String message;
  final int? status;
  ApiException(this.message, [this.status]);

  bool get isUnauthorized => status == 401;

  @override
  String toString() => message;
}

/// One place that talks to the Spring Boot backend.
///  - adds the Bearer token
///  - unwraps the { success, message, data } envelope
///  - refreshes an expired token once and retries
class Api {
  Api._();
  static final Api instance = Api._();

  final http.Client _client = http.Client();
  Future<bool>? _refreshing;

  /// Called when the refresh token is no longer valid (go back to the login screen).
  void Function()? onSessionExpired;

  Future<dynamic> get(
    String path, {
    Map<String, String>? query,
    bool auth = true,
  }) => _send('GET', path, query: query, auth: auth);

  Future<dynamic> post(String path, {Object? body, bool auth = true}) =>
      _send('POST', path, body: body ?? <String, dynamic>{}, auth: auth);

  Future<dynamic> put(String path, {Object? body}) =>
      _send('PUT', path, body: body ?? <String, dynamic>{});

  Future<dynamic> delete(String path, {Map<String, String>? query}) =>
      _send('DELETE', path, query: query);

  Uri _uri(String path, Map<String, String>? query) {
    final base = Uri.parse('${ApiConfig.baseUrl}$path');
    if (query == null || query.isEmpty) return base;
    return base.replace(queryParameters: query);
  }

  Map<String, String> _headers(bool auth) {
    final h = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (auth && TokenStore.accessToken != null) {
      h['Authorization'] = 'Bearer ${TokenStore.accessToken}';
    }
    return h;
  }

  Future<dynamic> _send(
    String method,
    String path, {
    Map<String, String>? query,
    Object? body,
    bool auth = true,
    bool retry = true,
  }) async {
    final uri = _uri(path, query);
    http.Response res;
    try {
      final headers = _headers(auth);
      const timeout = Duration(seconds: 25);
      switch (method) {
        case 'POST':
          res = await _client
              .post(uri, headers: headers, body: jsonEncode(body ?? {}))
              .timeout(timeout);
          break;
        case 'PUT':
          res = await _client
              .put(uri, headers: headers, body: jsonEncode(body ?? {}))
              .timeout(timeout);
          break;
        case 'DELETE':
          res = await _client.delete(uri, headers: headers).timeout(timeout);
          break;
        default:
          res = await _client.get(uri, headers: headers).timeout(timeout);
      }
    } catch (_) {
      throw ApiException(
        'Cannot reach the server. Please check your internet connection.',
      );
    }

    if (res.statusCode == 401 &&
        auth &&
        retry &&
        TokenStore.refreshToken != null) {
      final ok = await refreshSession();
      if (ok) {
        return _send(
          method,
          path,
          query: query,
          body: body,
          auth: auth,
          retry: false,
        );
      }
      onSessionExpired?.call();
      throw ApiException('Your session expired. Please log in again.', 401);
    }
    return _unwrap(res);
  }

  dynamic _unwrap(http.Response res) {
    Map<String, dynamic>? json;
    try {
      final text = utf8.decode(res.bodyBytes);
      if (text.isNotEmpty) {
        final decoded = jsonDecode(text);
        if (decoded is Map<String, dynamic>) json = decoded;
      }
    } catch (_) {}
    final ok = res.statusCode >= 200 && res.statusCode < 300;
    if (!ok || (json != null && json['success'] == false)) {
      final msg =
          (json?['message'] as String?) ??
          'Something went wrong (${res.statusCode})';
      throw ApiException(msg, res.statusCode);
    }
    if (json == null) return null;
    return json.containsKey('data') ? json['data'] : json;
  }

  /// Gets a new access token using the refresh token. Safe to call from many places at once.
  Future<bool> refreshSession() {
    return _refreshing ??= _doRefresh().whenComplete(() => _refreshing = null);
  }

  Future<bool> _doRefresh() async {
    final rt = TokenStore.refreshToken;
    if (rt == null) return false;
    try {
      final res = await _client
          .post(
            _uri('/api/v1/auth/refresh', null),
            headers: _headers(false),
            body: jsonEncode({'refreshToken': rt}),
          )
          .timeout(const Duration(seconds: 20));
      if (res.statusCode != 200) return false;
      final data = _unwrap(res);
      if (data is! Map) return false;
      await TokenStore.save(
        access: data['accessToken'] as String,
        refresh: data['refreshToken'] as String,
        userJson: data['user'] is Map
            ? Map<String, dynamic>.from(data['user'] as Map)
            : null,
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Uploads a photo / video / pdf from the phone. Returns the server URL ("/files/xxx.jpg").
  Future<String> uploadFile(String filePath) async {
    try {
      final req = http.MultipartRequest('POST', _uri('/api/v1/uploads', null));
      if (TokenStore.accessToken != null) {
        req.headers['Authorization'] = 'Bearer ${TokenStore.accessToken}';
      }
      req.files.add(await http.MultipartFile.fromPath('file', filePath));
      final streamed = await req.send().timeout(const Duration(seconds: 90));
      final res = await http.Response.fromStream(streamed);
      final data = _unwrap(res);
      return (data as Map)['url'] as String;
    } on ApiException {
      rethrow;
    } catch (_) {
      throw ApiException('Could not upload the file. Please try again.');
    }
  }

  /// Uploads a photo that is only in memory (for example a camera picture). Returns "/files/xxx.jpg".
  Future<String> uploadBytes(
    List<int> bytes, {
    String filename = 'photo.jpg',
  }) async {
    try {
      final req = http.MultipartRequest('POST', _uri('/api/v1/uploads', null));
      if (TokenStore.accessToken != null) {
        req.headers['Authorization'] = 'Bearer ${TokenStore.accessToken}';
      }
      req.files.add(
        http.MultipartFile.fromBytes('file', bytes, filename: filename),
      );
      final streamed = await req.send().timeout(const Duration(seconds: 90));
      final res = await http.Response.fromStream(streamed);
      final data = _unwrap(res);
      return (data as Map)['url'] as String;
    } on ApiException {
      rethrow;
    } catch (_) {
      throw ApiException('Could not upload the photo. Please try again.');
    }
  }

  /// Uploads local files and keeps existing URLs / asset paths as they are.
  Future<List<String>> uploadAllIfLocal(List<String> paths) async {
    final out = <String>[];
    for (final p in paths) {
      final isRemote =
          p.startsWith('http') ||
          p.startsWith('/files/') ||
          p.startsWith('assets/');
      out.add(isRemote ? p : await uploadFile(p));
    }
    return out;
  }
}
