import 'package:flutter/material.dart';
//import '../constants/app_colors.dart';
import 'package:rento_india/delivery/core/constants/app_colors.dart';
/// Labeled step tracker shown at the top of the Return Pickup and
/// Vendor Return screens (Accepted -> Delivered -> Return Requested ->
/// Return Picked Up, or Accepted -> Picked Up -> In Transit -> Returned).
///
/// Unlike [StepProgressIndicator] (plain dots, used in the registration
/// flow), this variant shows a check icon for completed steps, a
/// filled circle with the step number for the current step, and a
/// hollow gray circle for steps still ahead — plus a label under each
/// dot, matching the trip-flow designs.
class TripStageStepper extends StatelessWidget {
  final List<String> labels;
  final int currentStep; // 1-indexed — the step the rider is on right now

  const TripStageStepper({
    super.key,
    required this.labels,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    final total = labels.length;
    final dotsAndLines = <Widget>[];

    for (var i = 1; i <= total; i++) {
      final isDone = i < currentStep;
      final isCurrent = i == currentStep;
      dotsAndLines.add(
        _StepDot(index: i, isDone: isDone, isCurrent: isCurrent),
      );

      if (i != total) {
        final isSegmentDone = i < currentStep;
        dotsAndLines.add(
          Expanded(
            child: Container(
              height: 2,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              color: isSegmentDone ? AppColors.pureBlack : AppColors.border,
            ),
          ),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 14),
      child: Column(
        children: [
          Row(children: dotsAndLines),
          const SizedBox(height: 6),
          Row(
            children: labels.asMap().entries.map((entry) {
              final i = entry.key + 1;
              final isCurrent = i == currentStep;
              final isDone = i < currentStep;
              return Expanded(
                child: Text(
                  entry.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: (isCurrent || isDone)
                        ? FontWeight.w700
                        : FontWeight.w500,
                    color: (isCurrent || isDone)
                        ? AppColors.textPrimary
                        : AppColors.textHint,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _StepDot extends StatelessWidget {
  final int index;
  final bool isDone;
  final bool isCurrent;

  const _StepDot({
    required this.index,
    required this.isDone,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    final filled = isDone || isCurrent;
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? AppColors.pureBlack : AppColors.pureWhite,
        border: Border.all(
          color: filled ? AppColors.pureBlack : AppColors.border,
          width: 1.6,
        ),
      ),
      child: Center(
        child: isDone
            ? const Icon(Icons.check, size: 14, color: AppColors.pureWhite)
            : Text(
                '$index',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: isCurrent ? AppColors.pureWhite : AppColors.textHint,
                ),
              ),
      ),
    );
  }
}
