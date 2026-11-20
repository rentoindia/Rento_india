import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/section_card.dart';
import '../models/booking_model.dart';
import '../providers/booking_provider.dart';
import '../widgets/tracking_status_panel.dart';
import 'rate_rider_screen.dart';

/// Shown right after delivery — celebration header, a receipt-style trip
/// summary, and the "Rate Rider" CTA. Everything lives in one scroll
/// view so the buttons sit at the natural end of the content.
class TripCompletedScreen extends ConsumerWidget {
  const TripCompletedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booking = ref.watch(bookingProvider);
    final vehicle = booking.selectedVehicle;
    final durationMin = (booking.distanceKm * 5.4).round();

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
          child: Column(
            children: [
              const AnimatedSuccessCheck(),
              const SizedBox(height: 20),
              Text(
                'Parcel delivered\nsuccessfully!',
                style: AppTextStyles.display,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Thank you for using Rento India.',
                style: AppTextStyles.subtitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('TRIP SUMMARY', style: AppTextStyles.overline),
                        const Icon(
                          Icons.check_circle,
                          size: 18,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Booking ID  ${booking.bookingId ?? '—'}',
                      style: AppTextStyles.caption,
                    ),
                    const SizedBox(height: 16),
                    _TimelineRow(
                      icon: Icons.circle,
                      iconSize: 8,
                      label: 'Pickup',
                      value: booking.pickup?.fullAddress ?? '—',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Container(
                        height: 16,
                        width: 1,
                        color: AppColors.grey300,
                      ),
                    ),
                    _TimelineRow(
                      icon: Icons.location_on,
                      iconSize: 14,
                      label: 'Delivery',
                      value: booking.receiver?.fullAddress ?? '—',
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _StatMini(
                            icon: Icons.route_outlined,
                            label: 'Distance',
                            value: '${booking.distanceKm} km',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _StatMini(
                            icon: Icons.schedule,
                            label: 'Duration',
                            value: '$durationMin min',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Divider(),
                    const SizedBox(height: 10),
                    Text('FARE BREAKDOWN', style: AppTextStyles.overline),
                    const SizedBox(height: 10),
                    _SummaryRow(
                      label: 'Base Fare',
                      value: '\u20B9${booking.baseFare.toStringAsFixed(0)}',
                    ),
                    _SummaryRow(
                      label: 'Distance Charge',
                      value:
                          '\u20B9${booking.distanceCharge.toStringAsFixed(0)}',
                    ),
                    _SummaryRow(
                      label: 'Handling Fee',
                      value: '\u20B9${booking.handlingFee.toStringAsFixed(0)}',
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Divider(height: 1),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total', style: AppTextStyles.bodyStrong),
                        Text(
                          vehicle?.fareLabel ?? '\u20B90',
                          style: AppTextStyles.h2,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Divider(),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Payment Method', style: AppTextStyles.caption),
                        Text(
                          booking.paymentMethod?.label ?? '—',
                          style: AppTextStyles.captionStrong,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.black,
                        side: const BorderSide(color: AppColors.divider),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Invoice download coming soon.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.download_outlined, size: 18),
                      label: const Text('Invoice'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: PrimaryButton(
                      label: 'Rate Rider',
                      trailing: const Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: AppColors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const RateRiderScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({
    required this.icon,
    required this.iconSize,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final double iconSize;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Icon(icon, size: iconSize, color: AppColors.black),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.caption),
              Text(
                value,
                style: AppTextStyles.bodyStrong,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatMini extends StatelessWidget {
  const _StatMini({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: AppColors.grey500),
          const SizedBox(height: 8),
          Text(label, style: AppTextStyles.caption),
          const SizedBox(height: 2),
          Text(value, style: AppTextStyles.bodyStrong),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.caption),
          Text(value, style: AppTextStyles.captionStrong),
        ],
      ),
    );
  }
}
