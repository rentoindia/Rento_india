import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../models/ride_booking_model.dart';

/// "Fare Breakdown" card on the Ride Confirmation screen — Base Fare,
/// Distance, Time, an optional promo discount line, and the Total.
class RideFareBreakdownCard extends StatelessWidget {
  const RideFareBreakdownCard({super.key, required this.booking});

  final RideBooking booking;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Fare Breakdown', style: AppTextStyles.bodyStrong),
          const SizedBox(height: 12),
          _Row('Base Fare', booking.baseFare),
          const SizedBox(height: 8),
          _Row('Distance (${booking.distanceLabel})', booking.distanceCharge),
          const SizedBox(height: 8),
          _Row('Time (${booking.durationLabel})', booking.timeCharge),
          if (booking.promoApplied) ...[
            const SizedBox(height: 8),
            _Row('Promo (${booking.promoCode ?? "SAVE20"})',
                -booking.promoDiscount, accent: true),
          ],
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: AppTextStyles.bodyStrong.copyWith(fontSize: 16)),
              Text(
                '\u20B9${booking.totalFare.toStringAsFixed(0)}',
                style: AppTextStyles.h2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(this.label, this.amount, {this.accent = false});
  final String label;
  final double amount;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    final sign = amount < 0 ? '-' : '';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.body.copyWith(color: AppColors.grey500),
        ),
        Text(
          '$sign\u20B9${amount.abs().toStringAsFixed(2)}',
          style: AppTextStyles.bodyStrong.copyWith(
            color: accent ? AppColors.accentGreen : AppColors.black,
          ),
        ),
      ],
    );
  }
}
