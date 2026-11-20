/// Shared form validators — used by every screen with a Name/Mobile/
/// Email/Pincode field (rider registration, customer registration,
/// mobile entry, etc) so validation rules and error messages stay
/// consistent app-wide instead of being copy-pasted per screen.
class Validators {
  Validators._();

  static final RegExp _emailRegex = RegExp(
    r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,}$',
  );
  static final RegExp _digitsOnly = RegExp(r'^[0-9]+$');

  /// Validates a full email address, e.g. "ramesh@gmail.com".
  static String? email(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'Email address is required';
    if (!_emailRegex.hasMatch(trimmed)) return 'Enter a valid email address';
    return null;
  }

  /// Validates an Indian mobile number — exactly 10 digits, numeric only.
  static String? mobile(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'Mobile number is required';
    if (!_digitsOnly.hasMatch(trimmed))
      return 'Mobile number must contain only digits';
    if (trimmed.length != 10) return 'Mobile number must be exactly 10 digits';
    return null;
  }

  /// Validates a generic required text field.
  static String? required(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) return '$fieldName is required';
    return null;
  }

  /// Validates a 6-digit Indian PIN code.
  static String? pincode(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'Pincode is required';
    if (!_digitsOnly.hasMatch(trimmed))
      return 'Pincode must contain only digits';
    if (trimmed.length != 6) return 'Enter a valid 6-digit pincode';
    return null;
  }
}
