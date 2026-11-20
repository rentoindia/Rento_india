import 'package:flutter/material.dart';

/// Rento India — Parcel Delivery
/// Strict black / white / grayscale palette. No color accents anywhere —
/// hierarchy is built with weight, opacity, and elevation instead of hue.
class AppColors {
  AppColors._();

  static const Color black = Color(0xFF0A0A0A);
  static const Color ink = Color(0xFF121212);
  static const Color charcoal = Color(0xFF1E1E1E);
  static const Color graphite = Color(0xFF2C2C2C);

  static const Color grey900 = Color(0xFF2A2A2A);
  static const Color grey700 = Color(0xFF4A4A4A);
  static const Color grey500 = Color(0xFF7A7A7A);
  static const Color grey400 = Color(0xFF9C9C9C);
  static const Color grey300 = Color(0xFFC2C2C2);
  static const Color grey200 = Color(0xFFDDDDDD);
  static const Color grey100 = Color(0xFFEFEFEF);
  static const Color grey50 = Color(0xFFF7F7F7);

  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFFAFAFA);

  static const Color success = Color(0xFF1A1A1A); // deliberately monochrome
  static const Color divider = Color(0xFFE6E6E6);
  static const Color borderLight = Color(0xFFE6E6E6);
  static const Color dividerLight = Color(0xFFEFEFEF);
  static const Color shadow = Color(0x14000000);

  /// Scoped accents for the receiver-address flow only (verified badge,
  /// "Use" buttons, current-location marker, selected chip, link text,
  /// validation errors). The rest of the app stays strictly monochrome —
  /// these are deliberately not used anywhere else.
  static const Color accentGreen = Color(0xFF1FAA59);
  static const Color accentGreenBg = Color(0xFFE6F6EC);
  static const Color accentBlue = Color(0xFF2F6FED);
  static const Color accentBlueBg = Color(0xFFEAF1FE);
  static const Color accentRed = Color(0xFFE0473E);
  static const Color accentRedBg = Color(0xFFFCEAE9);

static const Color accentPurple = Color(0xFF7C4DFF);
static const Color accentPurpleBg = Color(0xFFF3EEFF);

static const Color accentOrange = Color(0xFFFF9800);
static const Color accentOrangeBg = Color(0xFFFFF3E0);

static const Color accentPink = Color(0xFFE91E63);
static const Color accentPinkBg = Color(0xFFFCE4EC);
  /// Soft gradient used behind hero/status screens (searching, delivered, etc).
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [offWhite, grey100],
  );

  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [black, charcoal],
  );
}
