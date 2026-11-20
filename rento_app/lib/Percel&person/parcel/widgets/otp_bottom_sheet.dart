import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/primary_button.dart';

/// Bottom sheet showing a 4-digit OTP the customer reads out to the rider,
/// matching the "Show Pickup OTP" / "Show Delivery OTP" reference screens.
/// Digits pop in one-by-one for a small moment of delight.
Future<void> showOtpBottomSheet(
  BuildContext context, {
  required String otp,
  required String title,
  required String description,
  required VoidCallback onConfirm,
  required String confirmLabel,
}) {
  return showModalBottomSheet(
    context: context,
    isDismissible: false,
    enableDrag: false,
    backgroundColor: Colors.transparent,
    builder: (context) => _OtpSheet(
      otp: otp,
      title: title,
      description: description,
      onConfirm: onConfirm,
      confirmLabel: confirmLabel,
    ),
  );
}

class _OtpSheet extends StatefulWidget {
  const _OtpSheet({
    required this.otp,
    required this.title,
    required this.description,
    required this.onConfirm,
    required this.confirmLabel,
  });

  final String otp;
  final String title;
  final String description;
  final VoidCallback onConfirm;
  final String confirmLabel;

  @override
  State<_OtpSheet> createState() => _OtpSheetState();
}

class _OtpSheetState extends State<_OtpSheet> with TickerProviderStateMixin {
  late final AnimationController _entrance = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  )..forward();

  @override
  void dispose() {
    _entrance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final digits = widget.otp.split('');
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            20,
            24,
            20,
            MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColors.grey200,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 54,
                width: 54,
                decoration: const BoxDecoration(
                  color: AppColors.black,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.inventory_2_outlined,
                  color: AppColors.white,
                  size: 24,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.title,
                style: AppTextStyles.h2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                widget.description,
                style: AppTextStyles.caption,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(digits.length, (i) {
                  return AnimatedBuilder(
                    animation: _entrance,
                    builder: (context, child) {
                      final start = i * 0.12;
                      final t = Curves.easeOutBack.transform(
                        ((_entrance.value - start) / 0.4).clamp(0.0, 1.0),
                      );
                      return Transform.scale(scale: t, child: child);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      height: 52,
                      width: 46,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.grey50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.divider),
                      ),
                      child: Text(
                        digits[i],
                        style: AppTextStyles.h1.copyWith(fontSize: 22),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.lock_outline,
                    size: 13,
                    color: AppColors.grey400,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Never share this OTP over a phone call',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                label: widget.confirmLabel,
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.onConfirm();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
