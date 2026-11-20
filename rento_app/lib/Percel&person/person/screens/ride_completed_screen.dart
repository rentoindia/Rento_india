import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/primary_button.dart';
import '../../parcel/widgets/tracking_status_panel.dart';
import '../models/captain_model.dart';
import '../providers/ride_booking_provider.dart';
import '../widgets/ride_trip_summary.dart';
import 'ride_payment_screen.dart';

/// "Ride Completed" — reuses the shared `AnimatedSuccessCheck` from the
/// parcel module (same draw-itself checkmark used on "Parcel Delivered")
/// so the two modules feel like one design language.
class RideCompletedScreen extends ConsumerWidget {
  const RideCompletedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booking = ref.watch(rideBookingProvider);

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: _BackButton(
                        onTap: () => Navigator.of(context).maybePop(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const AnimatedSuccessCheck(),
                    const SizedBox(height: 24),
                    Text('Ride Completed', style: AppTextStyles.display),
                    const SizedBox(height: 6),
                    Text(
                      'Hope you had a smooth trip with ${kAssignedCaptain.name}.',
                      style: AppTextStyles.subtitle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 28),
                    RideTripSummaryCard(
                      pickup: booking.pickup,
                      destination: booking.destination,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.black,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Fare',
                            style: AppTextStyles.bodyStrong.copyWith(
                              color: AppColors.grey300,
                            ),
                          ),
                          Text(
                            '\u20B9${booking.totalFare.toStringAsFixed(0)}',
                            style: AppTextStyles.display.copyWith(
                              color: AppColors.white,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: PrimaryButton(
                label: 'Continue to Payment',
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const RidePaymentScreen()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      shape: const CircleBorder(),
      elevation: 3,
      shadowColor: Colors.black.withValues(alpha: 0.2),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: const Padding(
          padding: EdgeInsets.all(10),
          child: Icon(Icons.arrow_back, size: 18, color: AppColors.black),
        ),
      ),
    );
  }
}
