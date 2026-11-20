import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../providers/sos_provider.dart';

/// The big red circular "SOS / Tap to alert" button. Pulses continuously
/// with a soft glow to draw the eye (per the design's "emergency
/// animation" requirement), and switches its label/animation once
/// tapped and while an alert is in progress.
class SosButton extends StatefulWidget {
  const SosButton({super.key, required this.status, required this.onTap});

  final SosStatus status;
  final VoidCallback onTap;

  @override
  State<SosButton> createState() => _SosButtonState();
}

class _SosButtonState extends State<SosButton>
    with TickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat(reverse: true);

  late final AnimationController _press = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
    lowerBound: 0,
    upperBound: 0.08,
  );

  @override
  void dispose() {
    _pulse.dispose();
    _press.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final active = widget.status != SosStatus.idle;
    final label = switch (widget.status) {
      SosStatus.idle => 'SOS\nTap to alert',
      SosStatus.alerting => 'SOS\nAlerting…',
      SosStatus.active => 'SOS\nActive',
    };

    return GestureDetector(
      onTapDown: (_) => _press.forward(),
      onTapUp: (_) => _press.reverse(),
      onTapCancel: () => _press.reverse(),
      onTap: widget.status == SosStatus.idle ? widget.onTap : null,
      child: AnimatedBuilder(
        animation: Listenable.merge([_pulse, _press]),
        builder: (context, child) {
          final glow = 0.25 + _pulse.value * (active ? 0.35 : 0.2);
          final ringScale = 1 + _pulse.value * (active ? 0.22 : 0.14);
          final scale = 1 - _press.value;
          return Transform.scale(
            scale: scale,
            child: SizedBox(
              height: 108,
              width: 108,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.scale(
                    scale: ringScale,
                    child: Container(
                      height: 108,
                      width: 108,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.accentRed.withValues(alpha: glow * 0.25),
                      ),
                    ),
                  ),
                  child!,
                ],
              ),
            ),
          );
        },
        child: Container(
          height: 84,
          width: 84,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const RadialGradient(
              colors: [Color(0xFFFF5347), AppColors.accentRed],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.accentRed.withValues(alpha: 0.45),
                blurRadius: 22,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.captionStrong.copyWith(
              color: AppColors.white,
              fontSize: widget.status == SosStatus.idle ? 12.5 : 11,
              height: 1.3,
            ),
          ),
        ),
      ),
    );
  }
}
