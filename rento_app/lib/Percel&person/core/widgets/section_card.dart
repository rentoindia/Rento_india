import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Consistent elevated-but-flat card used for booking summaries, fare
/// breakdowns, rider info panels, etc. Keeps the elegant, minimal look
/// (hairline border + soft shadow, no color).
class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.divider),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Generic screen app bar: back arrow, centered title/subtitle, optional
/// trailing help icon — matches every reference screen's header.
class FlowAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FlowAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.eyebrow,
    this.onHelp,
    this.onBack,
  });

  final String title;
  final String? subtitle;

  /// Small uppercase label shown above the title (e.g. "DELIVERY").
  final String? eyebrow;
  final VoidCallback? onHelp;
  final VoidCallback? onBack;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + 4 + (eyebrow != null ? 16 : 0));

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, size: 20),
        onPressed: onBack ?? () => Navigator.of(context).maybePop(),
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (eyebrow != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Text(
                eyebrow!,
                style: const TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.4,
                  color: AppColors.grey400,
                ),
              ),
            ),
          Text(title),
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                subtitle!,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.grey500,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
        ],
      ),
      actions: [
        if (onHelp != null)
          IconButton(
            icon: const Icon(Icons.help_outline, size: 20),
            onPressed: onHelp,
          )
        else
          const SizedBox(width: 48),
      ],
    );
  }
}
