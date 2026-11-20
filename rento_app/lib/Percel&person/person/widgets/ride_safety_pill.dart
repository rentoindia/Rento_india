import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// The small rounded "100% Safe Ride / Verified Captains" or "Safety
/// First" badge shown top-right on every ride screen. Two lines when
/// [subtitle] is given, a single accented line ([danger]) for the SOS
/// screen's "Safety First" pill.
class RideSafetyPill extends StatelessWidget {
  const RideSafetyPill({
    super.key,
    required this.title,
    this.subtitle,
    this.danger = false,
  });

  final String title;
  final String? subtitle;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final fg = danger ? AppColors.accentRed : AppColors.black;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: danger ? AppColors.accentRedBg : AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            danger ? Icons.warning_amber_rounded : Icons.shield_outlined,
            size: 14,
            color: fg,
          ),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: AppTextStyles.captionStrong.copyWith(
                  color: fg,
                  fontSize: 11.5,
                ),
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: AppTextStyles.caption.copyWith(fontSize: 9.5),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
