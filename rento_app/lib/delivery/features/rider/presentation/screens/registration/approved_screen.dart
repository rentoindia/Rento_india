import 'package:flutter/material.dart';
//import '../../../../../core/constants/app_colors.dart';
import 'package:rento_india/delivery/core/constants/app_colors.dart';
import '../../../../../core/routes/route_names.dart';
import '../../../../../core/widgets/primary_button.dart';

/// Rider registration step 11 — Approved.
/// Final screen of the verification flow. "Go to Home" clears the
/// entire registration stack so the back button can't return to it.
class ApprovedScreen extends StatelessWidget {
  const ApprovedScreen({super.key});

  void _goToHome(BuildContext context) {
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(RouteNames.riderHome, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Center(
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: const BoxDecoration(
                    color: AppColors.pureBlack,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: AppColors.pureWhite,
                    size: 44,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Your account is verified!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Welcome to Rento India. You can now start accepting delivery requests and earning.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Go to Home',
                onPressed: () => _goToHome(context),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
