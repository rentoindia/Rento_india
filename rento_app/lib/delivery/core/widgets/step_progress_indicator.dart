import 'package:flutter/material.dart';
//import '../constants/app_colors.dart';
import 'package:rento_india/delivery/core/constants/app_colors.dart';
/// Dot-and-line step progress indicator shown at the top of every
/// verification screen (Aadhaar -> ... -> Approved for Rider,
/// Common Info -> ... -> Approved for Customer, etc).
///
/// Completed and current steps are filled solid black; remaining
/// steps are hollow gray circles. The connecting line between two
/// dots is colored solid once the earlier step is actually complete,
/// so the whole bar reads left-to-right as real progress.
class StepProgressIndicator extends StatelessWidget {
  final int currentStep; // 1-indexed — the step the user is on right now
  final int totalSteps;

  const StepProgressIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    for (var i = 1; i <= totalSteps; i++) {
      final isReached = i <= currentStep;
      children.add(_Dot(filled: isReached));

      if (i != totalSteps) {
        final isSegmentComplete = i < currentStep;
        children.add(
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 2,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              color: isSegmentComplete ? AppColors.pureBlack : AppColors.border,
            ),
          ),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(children: children),
    );
  }
}

class _Dot extends StatelessWidget {
  final bool filled;

  const _Dot({required this.filled});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? AppColors.pureBlack : AppColors.pureWhite,
        border: Border.all(
          color: filled ? AppColors.pureBlack : AppColors.border,
          width: 1.6,
        ),
      ),
    );
  }
}
