/// Where the Spring Boot backend lives.
///
/// Change it WITHOUT editing code by passing a build-time value:
///   flutter run --dart-define=API_BASE_URL=http://192.168.1.10:8080
///
/// Defaults:
///   - Android emulator  -> http://10.0.2.2:8080   (10.0.2.2 = your computer)
///   - iOS simulator     -> use http://localhost:8080
///   - real phone        -> use your computer's Wi-Fi IP, e.g. http://192.168.1.10:8080
///   - deployed          -> your https:// server address
class ApiConfig {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8080',
  );

  /// ws://host:port/ws  (wss:// when baseUrl is https)
  static String get wsUrl {
    final u = Uri.parse(baseUrl);
    final scheme = u.scheme == 'https' ? 'wss' : 'ws';
    final port = u.hasPort ? ':${u.port}' : '';
    return '$scheme://${u.host}$port/ws';
  }

  /// Turns a server-relative file path ("/files/abc.jpg") into a full URL.
  /// Full http(s) URLs and local asset paths ("assets/...") are returned unchanged.
  static String? resolveUrl(String? path) {
    if (path == null || path.isEmpty) return null;
    if (path.startsWith('http://') || path.startsWith('https://')) return path;
    if (path.startsWith('/')) return '$baseUrl$path';
    return path;
  }
}
