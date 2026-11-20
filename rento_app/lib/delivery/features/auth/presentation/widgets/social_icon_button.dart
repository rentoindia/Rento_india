import 'package:flutter/material.dart';
//import '../../../../core/constants/app_colors.dart';
import 'package:rento_india/delivery/core/constants/app_colors.dart';
/// Circular social login button (Google / Apple / WhatsApp).
/// Pass an [icon] for now — swap to Image.asset(iconPath) once
/// you drop the real brand icons into assets/icons/.
class SocialIconButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const SocialIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.iconColor = AppColors.textPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.pureWhite,
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(icon, color: iconColor, size: 26),
      ),
    );
  }
}
