import 'package:shared_preferences/shared_preferences.dart';

/// RENTO INDIA — Owner verification status helper.
///
/// Saves a flag on the device (using shared_preferences) once an
/// owner completes the KYC flow. This flag survives app restarts
/// and app updates, and is cleared ONLY when the app is uninstalled.
///
/// SETUP REQUIRED:
/// 1. Add to pubspec.yaml under dependencies:
///      shared_preferences: ^2.2.2
/// 2. Run: flutter pub get
class OwnerVerificationStatus {
  static const String _key = 'owner_kyc_verified';

  /// Returns true if this device's owner has already completed KYC.
  static Future<bool> isVerified() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }

  /// Call this on the "Go to Home" button of the Verified screen.
  static Future<void> markVerified() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, true);
  }

  /// Optional: useful for testing — manually resets verification
  /// without uninstalling the app.
  static Future<void> resetForTesting() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}