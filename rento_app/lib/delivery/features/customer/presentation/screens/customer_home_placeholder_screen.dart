import 'package:flutter/material.dart';
//import '../../../../core/constants/app_colors.dart';
import 'package:rento_india/delivery/core/constants/app_colors.dart';
/// Placeholder for the Customer home screen — this belongs to your
/// teammate's module (Customer app), not the rider part. It exists
/// here only so "Go to Home" at the end of the customer verification
/// flow has somewhere real to land instead of erroring out.
///
/// Replace this with the actual Customer home screen once your
/// teammate builds it.
class CustomerHomePlaceholderScreen extends StatelessWidget {
  const CustomerHomePlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldLight,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.home_outlined,
                  size: 48,
                  color: AppColors.textHint,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Customer Home',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'This screen is built by your teammate for the Customer module.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
