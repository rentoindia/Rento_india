// import 'dart:async';
// import 'package:flutter/material.dart';
// import '../../../../../core/constants/app_colors.dart';
// import '../../../../../core/routes/route_names.dart';

// /// Rider registration step 10 — Under Review.
// /// Waiting state while the backend/admin verifies the submitted
// /// documents. No action for the rider to take here.
// class UnderReviewScreen extends StatefulWidget {
//   const UnderReviewScreen({super.key});

//   @override
//   State<UnderReviewScreen> createState() => _UnderReviewScreenState();
// }

// class _UnderReviewScreenState extends State<UnderReviewScreen> {
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     // TODO: replace with real backend polling or a push notification
//     // listener that fires when an admin approves the account. This
//     // timer just simulates that for now so the flow is testable
//     // end-to-end without a backend.
//     _timer = Timer(const Duration(seconds: 4), () {
//       if (mounted) {
//         Navigator.of(context).pushReplacementNamed(RouteNames.riderApproved);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.scaffoldLight,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 32),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: 90,
//                 height: 90,
//                 decoration: const BoxDecoration(
//                   color: AppColors.pureBlack,
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(
//                   Icons.access_time,
//                   color: AppColors.pureWhite,
//                   size: 42,
//                 ),
//               ),
//               const SizedBox(height: 28),
//               const Text(
//                 'Your account is under review',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimary,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 'We will notify you once your account is verified.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
//import '../../../../../core/constants/app_colors.dart';
import 'package:rento_india/delivery/core/constants/app_colors.dart';
import '../../../../../core/routes/route_names.dart';
import '../../../../../core/widgets/step_progress_indicator.dart';

/// Rider registration step 10 — Under Review.
/// Waiting state while the backend/admin verifies the submitted
/// documents. No action for the rider to take here.
class UnderReviewScreen extends StatefulWidget {
  const UnderReviewScreen({super.key});

  @override
  State<UnderReviewScreen> createState() => _UnderReviewScreenState();
}

class _UnderReviewScreenState extends State<UnderReviewScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // TODO: replace with real backend polling or a push notification
    // listener that fires when an admin approves the account. This
    // timer just simulates that for now so the flow is testable
    // end-to-end without a backend.
    _timer = Timer(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(RouteNames.riderApproved);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldLight,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: StepProgressIndicator(totalSteps: 10, currentStep: 10),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: const BoxDecoration(
                        color: AppColors.pureBlack,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.access_time,
                        color: AppColors.pureWhite,
                        size: 42,
                      ),
                    ),
                    const SizedBox(height: 28),
                    const Text(
                      'Your account is under review',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'We will notify you once your account is verified.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
