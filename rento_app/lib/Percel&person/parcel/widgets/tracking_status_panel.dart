import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// The small rounded panel at the bottom of each tracking card,
/// e.g. "On the way to pickup / ETA 4 min · 1.2 km away".
class StatusInfoPanel extends StatelessWidget {
  const StatusInfoPanel({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.filled = false,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Container(
        key: ValueKey('$icon-$title'),
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: filled ? AppColors.black : AppColors.grey50,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: filled ? AppColors.white : AppColors.black,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyStrong.copyWith(
                      color: filled ? AppColors.white : AppColors.black,
                    ),
                  ),
                  if (subtitle != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        subtitle!,
                        style: AppTextStyles.caption.copyWith(
                          color: filled
                              ? AppColors.white.withValues(alpha: 0.7)
                              : AppColors.grey500,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pulsing concentric-circle "searching for riders" animation.
class SearchingRadar extends StatefulWidget {
  const SearchingRadar({super.key});

  @override
  State<SearchingRadar> createState() => _SearchingRadarState();
}

class _SearchingRadarState extends State<SearchingRadar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: 180,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              for (final offset in [0.0, 0.33, 0.66])
                _Ring(progress: (_controller.value + offset) % 1.0),
              child!,
            ],
          );
        },
        child: Container(
          height: 64,
          width: 64,
          decoration: const BoxDecoration(
            color: AppColors.black,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.moped, color: AppColors.white, size: 28),
        ),
      ),
    );
  }
}

class _Ring extends StatelessWidget {
  const _Ring({required this.progress});
  final double progress;

  @override
  Widget build(BuildContext context) {
    final size = 64.0 + progress * 116.0;
    final opacity = (1 - progress).clamp(0.0, 1.0);
    return Opacity(
      opacity: opacity * 0.6,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.grey400, width: 1.4),
        ),
      ),
    );
  }
}

/// Draws-itself checkmark used on the "Parcel Delivered" screen.
class AnimatedSuccessCheck extends StatefulWidget {
  const AnimatedSuccessCheck({super.key, this.size = 96});
  final double size;

  @override
  State<AnimatedSuccessCheck> createState() => _AnimatedSuccessCheckState();
}

class _AnimatedSuccessCheckState extends State<AnimatedSuccessCheck>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  )..forward();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final scale = Curves.elasticOut.transform(
          _controller.value.clamp(0.0, 1.0),
        );
        return Transform.scale(scale: scale, child: child);
      },
      child: Container(
        height: widget.size,
        width: widget.size,
        decoration: const BoxDecoration(
          color: AppColors.black,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.check,
          color: AppColors.white,
          size: widget.size * 0.5,
        ),
      ),
    );
  }
}
