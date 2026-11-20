import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../models/ride_vehicle_option_model.dart';

/// A single Bike / Auto / Cab / XL card on the Vehicle Selection screen.
/// Pixel-matched to the design doc: the selected card turns solid black
/// with a white check, unselected cards stay white with a hairline
/// border. Layered with a gentle continuous float, a hover lift (for
/// desktop/web), a press-scale, and an ink ripple so the whole list
/// feels alive rather than static.
class RideVehicleCard extends StatefulWidget {
  const RideVehicleCard({
    super.key,
    required this.option,
    required this.selected,
    required this.onTap,
    required this.floatPhase,
  });

  final RideVehicleOptionModel option;
  final bool selected;
  final VoidCallback onTap;

  /// Offsets this card's floating-animation phase from its siblings so
  /// the whole list doesn't bob in lockstep.
  final double floatPhase;

  @override
  State<RideVehicleCard> createState() => _RideVehicleCardState();
}

class _RideVehicleCardState extends State<RideVehicleCard>
    with TickerProviderStateMixin {
  late final AnimationController _float = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 3400),
  )..repeat();

  late final AnimationController _press = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 120),
    lowerBound: 0,
    upperBound: 0.03,
  );

  bool _hovering = false;

  @override
  void dispose() {
    _float.dispose();
    _press.dispose();
    super.dispose();
  }

  ({Color bg, Color fg}) get _badgeColors {
    if (widget.selected) {
      return (bg: Colors.white.withValues(alpha: 0.16), fg: AppColors.white);
    }
    switch (widget.option.id) {
      case 'bike':
        return (bg: AppColors.grey900, fg: AppColors.white);
      case 'auto':
        return (bg: AppColors.accentBlueBg, fg: AppColors.accentBlue);
      default:
        return (bg: AppColors.grey100, fg: AppColors.grey700);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selected = widget.selected;
    final fg = selected ? AppColors.white : AppColors.black;
    final mutedFg = selected ? AppColors.grey300 : AppColors.grey500;
    final badge = _badgeColors;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: Listenable.merge([_float, _press]),
        builder: (context, child) {
          final floatT = math.sin(
            (_float.value + widget.floatPhase) * 2 * math.pi,
          );
          final floatOffset = floatT * 2.2;
          final pressScale = 1 - _press.value;
          final hoverScale = _hovering ? 1.012 : 1.0;
          return Transform.translate(
            offset: Offset(0, floatOffset),
            child: Transform.scale(
              scale: pressScale * hoverScale,
              child: child,
            ),
          );
        },
        child: GestureDetector(
          onTapDown: (_) => _press.forward(),
          onTapUp: (_) => _press.reverse(),
          onTapCancel: () => _press.reverse(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: selected ? AppColors.black : AppColors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: selected ? AppColors.black : AppColors.divider,
                width: selected ? 1.6 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: (selected ? AppColors.black : Colors.black).withValues(
                    alpha: selected ? 0.22 : (_hovering ? 0.1 : 0.05),
                  ),
                  blurRadius: _hovering ? 26 : 18,
                  offset: Offset(0, _hovering ? 10 : 6),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onTap,
                splashColor: (selected ? Colors.white : Colors.black)
                    .withValues(alpha: 0.08),
                highlightColor: (selected ? Colors.white : Colors.black)
                    .withValues(alpha: 0.04),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 52,
                        width: 52,
                        decoration: BoxDecoration(
                          color: selected
                              ? Colors.white.withValues(alpha: 0.12)
                              : AppColors.grey100,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(widget.option.icon, size: 26, color: fg),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                Text(
                                  widget.option.name,
                                  style: AppTextStyles.bodyStrong.copyWith(
                                    color: fg,
                                    fontSize: 16,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 9,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: badge.bg,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    widget.option.badge,
                                    style: AppTextStyles.caption.copyWith(
                                      color: badge.fg,
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.option.description,
                              style: AppTextStyles.caption.copyWith(
                                color: mutedFg,
                              ),
                            ),
                            const SizedBox(height: 6),
                            // FIX (RenderFlex overflow, ~64-65px on the right):
                            // this row previously used a fixed-width Row with
                            // no ability to shrink. The available width here
                            // is constrained to ~123px by the fare column on
                            // the right, which isn't enough room for both the
                            // eta ("14 min") and capacity ("Up to 4
                            // Passengers") icon+label pairs side by side.
                            // Switching to a Wrap lets the second pair flow
                            // onto a new line instead of overflowing.
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 3,
                              runSpacing: 4,
                              children: [
                                Icon(Icons.schedule, size: 12, color: mutedFg),
                                Text(
                                  widget.option.etaLabel,
                                  style: AppTextStyles.caption.copyWith(
                                    fontSize: 11.5,
                                    color: mutedFg,
                                  ),
                                ),
                                const SizedBox(width: 7),
                                Icon(
                                  Icons.people_outline,
                                  size: 12,
                                  color: mutedFg,
                                ),
                                Text(
                                  widget.option.capacityLabel,
                                  style: AppTextStyles.caption.copyWith(
                                    fontSize: 11.5,
                                    color: mutedFg,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.option.fareLabel,
                            style: AppTextStyles.h2.copyWith(color: fg),
                          ),
                          Text(
                            'Total Fare',
                            style: AppTextStyles.caption.copyWith(
                              color: mutedFg,
                              fontSize: 10.5,
                            ),
                          ),
                          const SizedBox(height: 10),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            transitionBuilder: (child, anim) =>
                                ScaleTransition(scale: anim, child: child),
                            child: selected
                                ? Container(
                                    key: const ValueKey('checked'),
                                    height: 22,
                                    width: 22,
                                    decoration: const BoxDecoration(
                                      color: AppColors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      size: 14,
                                      color: AppColors.black,
                                    ),
                                  )
                                : const SizedBox(
                                    key: ValueKey('unchecked'),
                                    height: 22,
                                    width: 22,
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
