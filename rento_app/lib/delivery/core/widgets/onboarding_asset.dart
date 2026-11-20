import 'package:flutter/material.dart';

/// Loads one of the cropped product/character images from
/// assets/images/onboarding/. Used by both the splash screen (dark
/// crops) and the login screen (light crops) orbit layouts.
class OnboardingAsset extends StatelessWidget {
  final String fileName;
  final double width;

  const OnboardingAsset(this.fileName, {super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/rental/onboarding/$fileName',
      width: width,
      fit: BoxFit.contain,
    );
  }
}
