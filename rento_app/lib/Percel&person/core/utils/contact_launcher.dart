import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Small shared helper so every "Call" / "Message" button in the app
/// (contact cards, app bar actions, support sheets) launches the phone's
/// dialer / SMS app the same way, with the same failure handling.
class ContactLauncher {
  ContactLauncher._();

  static Future<void> call(BuildContext context, String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: _sanitize(phoneNumber));
    await _launch(context, uri, "Couldn't open the dialer");
  }

  static Future<void> sms(BuildContext context, String phoneNumber) async {
    final uri = Uri(scheme: 'sms', path: _sanitize(phoneNumber));
    await _launch(context, uri, "Couldn't open messages");
  }

  static Future<void> _launch(
    BuildContext context,
    Uri uri,
    String failureMessage,
  ) async {
    try {
      final launched = await launchUrl(uri);
      if (!launched && context.mounted) {
        _showSnack(context, failureMessage);
      }
    } catch (_) {
      if (context.mounted) {
        _showSnack(context, failureMessage);
      }
    }
  }

  static void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  static String _sanitize(String phoneNumber) =>
      phoneNumber.replaceAll(RegExp(r'\s+'), '');
}
