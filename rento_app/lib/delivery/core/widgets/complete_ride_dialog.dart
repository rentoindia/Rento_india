// import 'package:flutter/material.dart';
// import '../constants/app_colors.dart';
// import 'primary_button.dart';

// /// Shown right after a leg of the trip is confirmed (Confirm Delivery,
// /// Confirm Return to Vendor, etc). Rider must tap "Complete Ride" to
// /// dismiss it — that tap is what actually finalizes this leg (navigates
// /// away + tells riderStatusProvider the request is done), so the next
// /// request only ever gets queued once the rider has acknowledged this
// /// popup, instead of that happening silently in the background.
// Future<void> showCompleteRideDialog({
//   required BuildContext context,
//   required String title,
//   required String message,
//   required VoidCallback onCompleteRide,
// }) {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false,
//     builder: (dialogContext) {
//       return WillPopScope(
//         onWillPop: () async => false,
//         child: Dialog(
//           backgroundColor: Colors.transparent,
//           insetPadding: const EdgeInsets.symmetric(horizontal: 28),
//           child: Container(
//             padding: const EdgeInsets.fromLTRB(24, 30, 24, 22),
//             decoration: BoxDecoration(
//               color: AppColors.pureWhite,
//               borderRadius: BorderRadius.circular(24),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   width: 64,
//                   height: 64,
//                   decoration: const BoxDecoration(
//                     color: AppColors.success,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.check_rounded,
//                     color: AppColors.pureWhite,
//                     size: 34,
//                   ),
//                 ),
//                 const SizedBox(height: 18),
//                 Text(
//                   title,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   message,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 13.5,
//                     color: AppColors.textSecondary,
//                     height: 1.4,
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 PrimaryButton(
//                   label: 'Complete Ride',
//                   trailingIcon: Icons.arrow_forward_rounded,
//                   onPressed: () {
//                     Navigator.of(dialogContext).pop();
//                     onCompleteRide();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

import 'package:flutter/material.dart';
// import '../constants/app_colors.dart';
import 'package:rento_india/delivery/core/constants/app_colors.dart';
import 'primary_button.dart';

/// Shown right after a leg of the trip is confirmed (Confirm Delivery,
/// Confirm Return to Vendor, etc). Rider must tap "Complete Ride" to
/// dismiss it — that tap is what actually finalizes this leg (navigates
/// away + tells riderStatusProvider the request is done), so the next
/// request only ever gets queued once the rider has acknowledged this
/// popup, instead of that happening silently in the background.
Future<void> showCompleteRideDialog({
  required BuildContext context,
  required String title,
  required String message,
  required VoidCallback onCompleteRide,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 28),
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 30, 24, 22),
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: AppColors.pureWhite,
                    size: 34,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  label: 'Complete Ride',
                  trailingIcon: Icons.arrow_forward_rounded,
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    onCompleteRide();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
