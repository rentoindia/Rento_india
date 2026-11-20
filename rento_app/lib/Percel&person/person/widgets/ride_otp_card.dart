import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// The black "YOUR RIDE OTP" card with four big digit tiles — matches
/// the OTP Verification screen in the design doc.
class RideOtpCard extends StatefulWidget {
  const RideOtpCard({
    super.key,
    required this.otp,
    required this.secondsRemaining,
    this.totalSeconds = 60,
  });

  final String otp;
  final int secondsRemaining;
  final int totalSeconds;

  @override
  State<RideOtpCard> createState() => _RideOtpCardState();
}

class _RideOtpCardState extends State<RideOtpCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entrance = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
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
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'YOUR RIDE OTP',
            style: AppTextStyles.overline.copyWith(color: AppColors.grey400),
          ),
          const SizedBox(height: 14),
          Row(
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
                  margin: const EdgeInsets.only(right: 10),
                  height: 58,
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    digits[i],
                    style: AppTextStyles.display.copyWith(
                      color: AppColors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
