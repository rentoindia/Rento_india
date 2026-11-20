import '../../../core/api_client.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/primary_button.dart';
import '../../parcel/models/booking_model.dart'
    show PaymentMethod, PaymentMethodX;
import '../../parcel/widgets/payment_method_tile.dart';
import '../providers/ride_booking_provider.dart';
import '../widgets/ride_fare_breakdown_card.dart';
import '../widgets/ride_map_header.dart';
import '../widgets/ride_trip_summary.dart';
import 'ride_tracking_screen.dart';

class RideConfirmationScreen extends ConsumerStatefulWidget {
  const RideConfirmationScreen({super.key});

  @override
  ConsumerState<RideConfirmationScreen> createState() =>
      _RideConfirmationScreenState();
}

class _RideConfirmationScreenState extends ConsumerState<RideConfirmationScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entrance = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 420),
  )..forward();
  late final Animation<double> _fade = CurvedAnimation(
    parent: _entrance,
    curve: Curves.easeOut,
  );

  void _changePaymentMethod() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _PaymentMethodSheet(
        onSelected: (m) {
          ref.read(rideBookingProvider.notifier).selectPaymentMethod(m);
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Future<void> _confirmRide() async {
    try {
      // creates the ride request on the server; captains nearby get it instantly
      await ref.read(rideBookingProvider.notifier).submit();
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
      return;
    }
    if (!mounted) return;
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const RideTrackingScreen()));
  }

  @override
  void dispose() {
    _entrance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final booking = ref.watch(rideBookingProvider);
    final vehicle = booking.selectedVehicle;

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                RideMapHeader(
                  destinationLabel: booking.destination?.label ?? 'White Town',
                  height: 170,
                  safetyTitle: 'Safety First',
                  safetySubtitle: null,
                ),
                Positioned(
                  left: 4,
                  top: 6,
                  child: _BackButton(
                    onTap: () => Navigator.of(context).maybePop(),
                  ),
                ),
              ],
            ),
            Expanded(
              child: FadeTransition(
                opacity: _fade,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
                  children: [
                    Text('CONFIRM', style: AppTextStyles.overline),
                    const SizedBox(height: 4),
                    Text('Ride Confirmation', style: AppTextStyles.display),
                    const SizedBox(height: 4),
                    Text(
                      'Review your trip details before booking.',
                      style: AppTextStyles.subtitle,
                    ),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.divider),
                      ),
                      child: RideTripTimeline(
                        pickup: booking.pickup,
                        destination: booking.destination,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.divider),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 44,
                            width: 44,
                            decoration: const BoxDecoration(
                              color: AppColors.grey100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(vehicle.icon, size: 22),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 8,
                                  children: [
                                    Text(
                                      vehicle.name,
                                      style: AppTextStyles.bodyStrong,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.accentGreenBg,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        'Best for you',
                                        style: AppTextStyles.caption.copyWith(
                                          color: AppColors.accentGreen,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10.5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  vehicle.description,
                                  style: AppTextStyles.caption,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(vehicle.fareLabel, style: AppTextStyles.h2),
                              Text('Total Fare', style: AppTextStyles.caption),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.divider),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.credit_card_outlined,
                            size: 18,
                            color: AppColors.black,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Payment Method',
                                  style: AppTextStyles.caption,
                                ),
                                Text(
                                  booking.paymentMethod.label,
                                  style: AppTextStyles.bodyStrong,
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: _changePaymentMethod,
                            child: const Text('Change'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.divider),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.sell_outlined, size: 18),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              booking.promoApplied
                                  ? 'SAVE20 applied'
                                  : 'Add promo code',
                              style: AppTextStyles.bodyStrong,
                            ),
                          ),
                          TextButton(
                            onPressed: booking.promoApplied
                                ? null
                                : () => ref
                                      .read(rideBookingProvider.notifier)
                                      .applyPromoCode('SAVE20'),
                            child: Text(
                              booking.promoApplied ? 'Applied' : 'Apply',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    RideFareBreakdownCard(booking: booking),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      label: 'Confirm Ride',
                      leadingText:
                          '\u20B9${booking.totalFare.toStringAsFixed(0)}',
                      onPressed: _confirmRide,
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        "You're able to cancel before the captain accepts.",
                        style: AppTextStyles.caption,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
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

class _PaymentMethodSheet extends StatelessWidget {
  const _PaymentMethodSheet({required this.onSelected});
  final ValueChanged<PaymentMethod> onSelected;

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 0.85;

    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Payment Method', style: AppTextStyles.h2),
              const SizedBox(height: 12),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (final method in PaymentMethod.values)
                        PaymentMethodTile(
                          method: method,
                          selected: false,
                          onTap: () => onSelected(method),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
