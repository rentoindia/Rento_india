import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// The 5-dot "Pickup Address → Receiver Address → Parcel Details →
/// Fare Estimate → Payment" tracker seen at the top of the booking flow.
/// Completed steps animate a filled circle + check, the active step
/// pulses gently, future steps stay hollow.
class StepProgressIndicator extends StatelessWidget {
  const StepProgressIndicator({
    super.key,
    required this.steps,
    required this.currentIndex,
    this.shortLabels,
  });

  final List<String> steps;
  final int currentIndex;

  /// Optional short label shown under each dot (e.g. "Pickup" instead of
  /// "Pickup Address"). Must be the same length as [steps]. When null
  /// (the default), no label is rendered — matches the original compact
  /// look used on screens that don't have room for captions.
  final List<String>? shortLabels;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(steps.length * 2 - 1, (i) {
        if (i.isOdd) {
          final leftDone = (i - 1) ~/ 2 < currentIndex;
          return Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 2,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                color: leftDone ? AppColors.black : AppColors.grey200,
              ),
            ),
          );
        }
        final stepIndex = i ~/ 2;
        return Expanded(
          flex: 5,
          child: _StepDot(
            index: stepIndex,
            label: shortLabels != null ? shortLabels![stepIndex] : null,
            state: stepIndex < currentIndex
                ? _DotState.done
                : stepIndex == currentIndex
                ? _DotState.active
                : _DotState.upcoming,
          ),
        );
      }),
    );
  }
}

enum _DotState { done, active, upcoming }

class _StepDot extends StatelessWidget {
  const _StepDot({required this.index, this.label, required this.state});

  final int index;
  final String? label;
  final _DotState state;

  @override
  Widget build(BuildContext context) {
    final bool filled = state != _DotState.upcoming;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          height: 22,
          width: 22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: filled ? AppColors.black : AppColors.white,
            border: Border.all(
              color: filled ? AppColors.black : AppColors.grey300,
              width: 1.4,
            ),
          ),
          child: state == _DotState.done
              ? const Icon(Icons.check, size: 13, color: AppColors.white)
              : Center(
                  child: Text(
                    '${index + 1}',
                    style: AppTextStyles.captionStrong.copyWith(
                      color: filled ? AppColors.white : AppColors.grey400,
                      fontSize: 11,
                    ),
                  ),
                ),
        ),
        if (label != null) ...[
          const SizedBox(height: 5),
          Text(
            label!,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption.copyWith(
              fontSize: 10.5,
              color: state == _DotState.upcoming
                  ? AppColors.grey400
                  : AppColors.grey700,
              fontWeight: state == _DotState.active
                  ? FontWeight.w700
                  : FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}
