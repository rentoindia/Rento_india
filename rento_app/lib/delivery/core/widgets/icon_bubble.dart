import 'package:flutter/material.dart';

/// Small circular icon bubble — used for the calendar/key/sofa/house/
/// scooter/tag icons that float around the logo in the design.
/// These sit ON TOP of / alongside the bigger product glyphs.
class IconBubble extends StatelessWidget {
  final IconData icon;
  final double diameter;
  final Color background;
  final Color iconColor;

  const IconBubble({
    super.key,
    required this.icon,
    this.diameter = 44,
    this.background = const Color(0xFF2A2A2A),
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(shape: BoxShape.circle, color: background),
      child: Icon(icon, color: iconColor, size: diameter * 0.45),
    );
  }
}
