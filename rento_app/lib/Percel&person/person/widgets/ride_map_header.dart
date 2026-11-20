import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../parcel/widgets/map_preview.dart';
import 'ride_safety_pill.dart';

/// The map strip at the top of the Vehicle Selection / Ride Confirmation
/// screens — a route preview with a safety pill and destination chip
/// floating over it, matching the reference design's hero header. Built
/// entirely on the project's existing dependency-free [MapPreview], so
/// it renders with zero setup (no Google Maps key) just like the parcel
/// module's map screens.
class RideMapHeader extends StatelessWidget {
  const RideMapHeader({
    super.key,
    required this.destinationLabel,
    this.height = 210,
    this.safetyTitle = '100% Safe Ride',
    this.safetySubtitle = 'Verified Captains',
    this.animateCaptain = false,
  });

  final String destinationLabel;
  final double height;
  final String safetyTitle;
  final String? safetySubtitle;
  final bool animateCaptain;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          MapPreview(
            height: height,
            showRoute: true,
            animateRider: animateCaptain,
          ),
          Positioned(
            top: 14,
            right: 14,
            child: RideSafetyPill(title: safetyTitle, subtitle: safetySubtitle),
          ),
          Positioned(
            top: safetySubtitle != null ? 58 : 50,
            right: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.place, size: 12, color: AppColors.white),
                  const SizedBox(width: 4),
                  Text(
                    destinationLabel,
                    style: AppTextStyles.captionStrong.copyWith(
                      color: AppColors.white,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
