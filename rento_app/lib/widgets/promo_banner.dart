// import 'package:flutter/material.dart';
// import 'package:rento/delivery/core/constants/app_colors.dart';// import '../constants/app_colors.dart';
// import '../constants/app_text_styles.dart';

// /// Reusable promo/ad banner — drop this into any screen (home,
// /// category, product listings, etc.) instead of hand-building a new
// /// banner Container each time. Keeps every promo visually consistent
// /// (same corner radius, padding, CTA pill style) while letting each
// /// placement customize copy, image, and action.
// ///
// /// Two layouts:
// /// - PromoBannerStyle.card — icon + text + CTA pill (compact, fits
// ///   between list sections). Good for "Refer & Earn" / "First Rental
// ///   Free" style spots.
// /// - PromoBannerStyle.image — full-width image background with text
// ///   overlay + CTA (bigger, more visual). Good for seasonal campaigns
// ///   / featured-listing takeovers.
// enum PromoBannerStyle { card, image }

// class PromoBanner extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final String ctaLabel;
//   final VoidCallback onTap;
//   final PromoBannerStyle style;
//   final IconData icon;
//   final String? imageUrl;
//   final Color backgroundColor;

//   const PromoBanner({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     required this.ctaLabel,
//     required this.onTap,
//     this.style = PromoBannerStyle.card,
//     this.icon = Icons.local_offer_outlined,
//     this.imageUrl,
//     this.backgroundColor = AppColors.inputFill,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: style == PromoBannerStyle.image ? _buildImageStyle() : _buildCardStyle(),
//     );
//   }

//   Widget _buildCardStyle() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(14)),
//       child: Row(
//         children: [
//           Icon(icon, color: AppColors.accentLime, size: 28),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title, style: AppText.titleSm),
//                 const SizedBox(height: 2),
//                 Text(subtitle, style: AppText.labelSm),
//               ],
//             ),
//           ),
//           const SizedBox(width: 10),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             decoration: BoxDecoration(color: AppColors.primaryBlack, borderRadius: BorderRadius.circular(18)),
//             child: Text(ctaLabel, style: AppText.buttonSm),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildImageStyle() {
//     return Container(
//       width: double.infinity,
//       height: 140,
//       clipBehavior: Clip.antiAlias,
//       decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(16)),
//       child: Stack(
//         children: [
//           if (imageUrl != null)
//             Positioned.fill(
//               child: Image.network(
//                 imageUrl!,
//                 fit: BoxFit.cover,
//                 errorBuilder: (_, __, ___) => const SizedBox.shrink(),
//               ),
//             ),
//           Positioned.fill(
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.centerLeft,
//                   end: Alignment.centerRight,
//                   colors: [AppColors.primaryBlack.withOpacity(0.75), AppColors.primaryBlack.withOpacity(0.15)],
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(18),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(title, style: AppText.displaySm.copyWith(color: AppColors.pureWhite)),
//                     const SizedBox(height: 4),
//                     Text(subtitle, style: AppText.bodySm.copyWith(color: AppColors.pureWhite.withOpacity(0.85))),
//                   ],
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                   decoration: BoxDecoration(color: AppColors.accentLime, borderRadius: BorderRadius.circular(20)),
//                   child: Text(ctaLabel, style: AppText.buttonSm.copyWith(color: AppColors.primaryBlack)),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

/// Reusable promo/ad banner — drop this into any screen (home,
/// category, product listings, etc.) instead of hand-building a new
/// banner Container each time. Keeps every promo visually consistent
/// (same corner radius, padding, CTA pill style) while letting each
/// placement customize copy, image, and action.
///
/// Two layouts:
/// - PromoBannerStyle.card — icon + text + CTA pill (compact, fits
///   between list sections). Good for "Refer & Earn" / "First Rental
///   Free" style spots.
/// - PromoBannerStyle.image — full-width image background with text
///   overlay + CTA (bigger, more visual). Good for seasonal campaigns
///   / featured-listing takeovers.
enum PromoBannerStyle { card, image }

class PromoBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final String ctaLabel;
  final VoidCallback onTap;
  final PromoBannerStyle style;
  final IconData icon;
  final String? imageUrl;
  final Color backgroundColor;

  const PromoBanner({
    super.key,
    required this.title,
    required this.subtitle,
    required this.ctaLabel,
    required this.onTap,
    this.style = PromoBannerStyle.card,
    this.icon = Icons.local_offer_outlined,
    this.imageUrl,
    this.backgroundColor = AppColors.inputFill,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: style == PromoBannerStyle.image ? _buildImageStyle() : _buildCardStyle(),
    );
  }

  Widget _buildCardStyle() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Icon(icon, color: AppColors.accentLime, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppText.titleSm),
                const SizedBox(height: 2),
                Text(subtitle, style: AppText.labelSm),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(color: AppColors.primaryBlack, borderRadius: BorderRadius.circular(18)),
            child: Text(ctaLabel, style: AppText.buttonSm),
          ),
        ],
      ),
    );
  }

  Widget _buildImageStyle() {
    return Container(
      width: double.infinity,
      height: 140,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(16)),
      child: Stack(
        children: [
          if (imageUrl != null)
            Positioned.fill(
              child: Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [AppColors.primaryBlack.withOpacity(0.75), AppColors.primaryBlack.withOpacity(0.15)],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppText.displaySm.copyWith(color: AppColors.pureWhite)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: AppText.bodySm.copyWith(color: AppColors.pureWhite.withOpacity(0.85))),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(color: AppColors.accentLime, borderRadius: BorderRadius.circular(20)),
                  child: Text(ctaLabel, style: AppText.buttonSm.copyWith(color: AppColors.primaryBlack)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}