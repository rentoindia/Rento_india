// import 'package:flutter/material.dart';
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/widgets/primary_button.dart';

// /// Shared layout for every rider registration step — back button,
// /// title, subtitle, scrollable form content, and a bottom button.
// /// Keeps every step visually consistent without repeating boilerplate.
// class RegistrationScaffold extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final Widget child;
//   final String buttonLabel;
//   final VoidCallback? onButtonPressed;
//   final bool isLoading;
//   final bool showBackButton;

//   const RegistrationScaffold({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     required this.child,
//     required this.buttonLabel,
//     required this.onButtonPressed,
//     this.isLoading = false,
//     this.showBackButton = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.scaffoldLight,
//       appBar: AppBar(
//         backgroundColor: AppColors.scaffoldLight,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         leading: showBackButton
//             ? IconButton(
//                 icon: const Icon(
//                   Icons.arrow_back,
//                   color: AppColors.textPrimary,
//                 ),
//                 onPressed: () => Navigator.of(context).pop(),
//               )
//             : null,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimary,
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Text(
//                 subtitle,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   color: AppColors.textSecondary,
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Expanded(child: SingleChildScrollView(child: child)),
//               const SizedBox(height: 12),
//               PrimaryButton(
//                 label: buttonLabel,
//                 onPressed: onButtonPressed,
//                 isLoading: isLoading,
//               ),
//               const SizedBox(height: 16),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/step_progress_indicator.dart';

/// Shared layout for every rider registration step — back button,
/// step progress bar, title, subtitle, scrollable form content, and a
/// bottom button. Keeps every step visually consistent without
/// repeating boilerplate.
class RegistrationScaffold extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;
  final String buttonLabel;
  final VoidCallback? onButtonPressed;
  final bool isLoading;
  final bool showBackButton;
  final int currentStep;
  final int totalSteps;

  const RegistrationScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    required this.buttonLabel,
    required this.onButtonPressed,
    this.isLoading = false,
    this.showBackButton = true,
    this.currentStep = 1,
    this.totalSteps =
        10, // rider flow: Aadhaar -> ... -> Under Review (Approved has no indicator)
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldLight,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldLight,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: showBackButton
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.textPrimary,
                ),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
      ),
      body: SafeArea(
        child: Column(
          children: [
            StepProgressIndicator(
              totalSteps: totalSteps,
              currentStep: currentStep,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(child: SingleChildScrollView(child: child)),
                    const SizedBox(height: 12),
                    PrimaryButton(
                      label: buttonLabel,
                      onPressed: onButtonPressed,
                      isLoading: isLoading,
                    ),
                    const SizedBox(height: 16),
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
