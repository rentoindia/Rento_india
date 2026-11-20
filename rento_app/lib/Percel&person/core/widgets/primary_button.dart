import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Black pill button with a gentle press-scale animation and optional
/// leading amount/trailing icon slot — used for every primary CTA in
/// the parcel delivery flow ("Continue", "Pay", "Confirm Bike"...).
class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.trailing,
    this.leadingText,
    this.loading = false,
    this.enabled = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? trailing;
  final String? leadingText;
  final bool loading;
  final bool enabled;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 120),
    lowerBound: 0.0,
    upperBound: 0.04,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _active =>
      widget.enabled && widget.onPressed != null && !widget.loading;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final scale = 1 - _controller.value;
        return Transform.scale(scale: scale, child: child);
      },
      child: GestureDetector(
        onTapDown: _active ? (_) => _controller.forward() : null,
        onTapUp: _active ? (_) => _controller.reverse() : null,
        onTapCancel: _active ? () => _controller.reverse() : null,
        onTap: _active ? widget.onPressed : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 56,
          width: double.infinity,
          decoration: BoxDecoration(
            color: _active ? AppColors.black : AppColors.grey300,
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: widget.loading
              ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.4,
                    valueColor: AlwaysStoppedAnimation(AppColors.white),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.label, style: AppTextStyles.button),
                    if (widget.leadingText != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        widget.leadingText!,
                        style: AppTextStyles.button.copyWith(
                          color: AppColors.white.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                    if (widget.trailing != null) ...[
                      const SizedBox(width: 8),
                      widget.trailing!,
                    ],
                  ],
                ),
        ),
      ),
    );
  }
}
