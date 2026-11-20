import 'package:flutter/material.dart';

/// RENTO INDIA — Shared style constants for all Owner screens
class OwnerTheme {
  static const Color primaryDark = Color(0xFF14152B);
  static const Color bgGrey = Color(0xFFF6F6F8);
  static const Color borderGrey = Color(0xFFE3E3E8);
  static const Color textGrey = Color(0xFF8A8A93);
  static const Color success = Color(0xFF2E9E5B);
  static const Color warning = Color(0xFFE0A800);
  static const Color danger = Color(0xFFD64545);

  static BoxDecoration card = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(14),
    border: Border.all(color: borderGrey),
  );

  static TextStyle heading = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: primaryDark,
  );

  static TextStyle subText = const TextStyle(
    fontSize: 13,
    color: textGrey,
  );

  static ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: primaryDark,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 0,
    padding: const EdgeInsets.symmetric(vertical: 14),
  );

  static Widget statusBadge(String label, {required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// Shared AppBar used across Owner screens.
  ///
  /// FIX: previously this always showed a back arrow that called
  /// Navigator.pop(context) unconditionally. On screens reached via the
  /// bottom navigation bar (like Maintenance Requests) there is nothing
  /// underneath to pop back to, so pressing it emptied the Navigator
  /// stack and left a blank white screen.
  ///
  /// Now the back arrow only appears when there is actually a previous
  /// route to go back to (Navigator.canPop). On root/tab screens no
  /// back arrow is shown at all, which matches normal bottom-nav
  /// behaviour (tabs don't have a "back").
  static PreferredSizeWidget appBar(BuildContext context, String title) {
    final bool canPop = Navigator.canPop(context);
    return AppBar(
      backgroundColor: bgGrey,
      elevation: 0,
      centerTitle: false,
      automaticallyImplyLeading: false,
      leading: canPop
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: primaryDark),
              onPressed: () => Navigator.maybePop(context),
            )
          : null,
      title: Text(
        title,
        style: const TextStyle(
          color: primaryDark,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
    );
  }
}