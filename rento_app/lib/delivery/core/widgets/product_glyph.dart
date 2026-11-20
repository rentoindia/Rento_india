import 'package:flutter/material.dart';

/// Plain floating "product" glyph — stands in for the 3D-rendered
/// product photos (chair, camera, laptop, scooter, bike, washing
/// machine, suitcase, controller) that orbit the logo in the design.
///
/// Swap these for real product PNGs later:
///   Image.asset('assets/images/onboarding/chair.png')
/// The layout/positioning in the screen won't need to change —
/// just replace ProductGlyph with Image.asset in place.
class ProductGlyph extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;

  const ProductGlyph({
    super.key,
    required this.icon,
    this.size = 46,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: size, color: color);
  }
}
