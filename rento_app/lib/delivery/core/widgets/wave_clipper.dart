import 'package:flutter/material.dart';

/// Wavy edge used to separate the dark "orbit" panel from the white
/// bottom section on the splash / onboarding screen.
class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 70);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height,
      size.width * 0.5,
      size.height - 35,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height - 70,
      size.width,
      size.height - 15,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// Second, lighter wave layered slightly behind/above the main one,
/// to reproduce the subtle two-tone wave seen in the design.
class SoftWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height - 90,
      size.width * 0.6,
      size.height - 45,
    );
    path.quadraticBezierTo(
      size.width * 0.85,
      size.height - 10,
      size.width,
      size.height - 55,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
