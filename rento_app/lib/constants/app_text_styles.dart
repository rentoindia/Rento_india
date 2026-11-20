import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../delivery/core/constants/app_colors.dart';

/// Single source of truth for typography across the whole app.
///
/// Rule: every screen should reach for one of these named styles
/// instead of writing its own `TextStyle(fontSize: ..., ...)`. That's
/// what actually guarantees "consistent font sizes / weights" instead
/// of each screen picking its own close-but-not-quite values (13 vs
/// 12.5 vs 13.5, w600 vs w700, etc.) — the inconsistency the spec is
/// asking to eliminate.
///
/// Font family: Inter, everywhere, via GoogleFonts — matches the
/// family already used in AppTheme.theme, so this doesn't introduce
/// a second family, just gives it names.
///
/// Usage:
///   Text('Canon EOS 1500D', style: AppText.titleMd)
///   Text('₹599 / day', style: AppText.priceLg.copyWith(color: AppColors.success))
class AppText {
  AppText._();

  // ---- Display / Headlines ----
  // Screen titles, hero headings.
  static TextStyle get displayLg => _s(24, FontWeight.w800);
  static TextStyle get displayMd => _s(20, FontWeight.w800);
  static TextStyle get displaySm => _s(17, FontWeight.w700);

  // ---- Titles ----
  // Section headers, card titles, product names.
  static TextStyle get titleLg => _s(16, FontWeight.w700);
  static TextStyle get titleMd => _s(14, FontWeight.w700);
  static TextStyle get titleSm => _s(13, FontWeight.w700);

  // ---- Body ----
  // Standard readable text, descriptions.
  static TextStyle get bodyLg => _s(14, FontWeight.w400);
  static TextStyle get bodyMd => _s(13, FontWeight.w400);
  static TextStyle get bodySm =>
      _s(12, FontWeight.w400, AppColors.textSecondary);

  // ---- Labels / Captions ----
  // Meta text, timestamps, helper text, badges.
  static TextStyle get labelMd => _s(11.5, FontWeight.w600);
  static TextStyle get labelSm =>
      _s(11, FontWeight.w500, AppColors.textSecondary);
  static TextStyle get caption => _s(10, FontWeight.w400, AppColors.textHint);

  // ---- Buttons ----
  static TextStyle get buttonLg => _s(15, FontWeight.w700, AppColors.pureWhite);
  static TextStyle get buttonMd => _s(13, FontWeight.w700, AppColors.pureWhite);
  static TextStyle get buttonSm => _s(11, FontWeight.w700, AppColors.pureWhite);

  // ---- Price ----
  // Kept distinct from titles even at the same size, so a price never
  // gets mistaken for a heading in the widget tree.
  static TextStyle get priceLg => _s(18, FontWeight.w800);
  static TextStyle get priceMd => _s(14, FontWeight.w700);

  static TextStyle _s(
    double size,
    FontWeight weight, [
    Color color = AppColors.textPrimary,
  ]) {
    return GoogleFonts.inter(fontSize: size, fontWeight: weight, color: color);
  }
}
