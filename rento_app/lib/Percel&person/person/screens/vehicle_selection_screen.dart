import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/primary_button.dart';
import '../models/ride_vehicle_option_model.dart';
import '../providers/ride_booking_provider.dart';
import '../widgets/ride_map_header.dart';
import '../widgets/ride_trip_summary.dart';
import '../widgets/ride_vehicle_card.dart';
import 'ride_confirmation_screen.dart';

/// NEW screen — "Vehicle Selection" (page 1 of the design doc).
/// Implemented pixel-for-pixel against the reference: hero map header,
/// floating pickup/drop trip card, "Choose Your Ride" list of animated
/// vehicle cards, a promo-code row, and a bottom button whose label
/// tracks the current selection ("Confirm Bike" / "Confirm Auto" / ...).
class VehicleSelectionScreen extends ConsumerStatefulWidget {
  const VehicleSelectionScreen({super.key});

  @override
  ConsumerState<VehicleSelectionScreen> createState() =>
      _VehicleSelectionScreenState();
}

class _VehicleSelectionScreenState
    extends ConsumerState<VehicleSelectionScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entrance = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 460),
  )..forward();
  late final Animation<double> _fade = CurvedAnimation(
    parent: _entrance,
    curve: Curves.easeOut,
  );

  @override
  void dispose() {
    _entrance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final booking = ref.watch(rideBookingProvider);
    final notifier = ref.read(rideBookingProvider.notifier);
    final selected = booking.selectedVehicle;

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Stack(
        children: [
          Column(
            children: [
              RideMapHeader(
                destinationLabel: booking.destination?.label ?? 'White Town',
                height: 200,
              ),
              Expanded(
                child: FadeTransition(
                  opacity: _fade,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.offWhite,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    transform: Matrix4.translationValues(0, -18, 0),
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 140),
                      children: [
                        RideTripSummaryCard(
                          pickup: booking.pickup,
                          destination: booking.destination,
                          distanceLabel: booking.distanceLabel,
                          durationLabel: booking.durationLabel,
                          fareRangeLabel:
                              '${booking.lowestFareLabel}\u2013${booking.highestFareLabel}',
                        ),
                        const SizedBox(height: 26),
                        Text('RIDE', style: AppTextStyles.overline),
                        const SizedBox(height: 4),
                        Text('Choose Your Ride', style: AppTextStyles.display),
                        const SizedBox(height: 4),
                        Text(
                          'Select the fastest and most comfortable option.',
                          style: AppTextStyles.subtitle,
                        ),
                        const SizedBox(height: 18),
                        for (var i = 0; i < kRideVehicleOptions.length; i++)
                          RideVehicleCard(
                            option: kRideVehicleOptions[i],
                            selected:
                                kRideVehicleOptions[i].id ==
                                booking.selectedVehicleId,
                            floatPhase: i * 0.22,
                            onTap: () =>
                                notifier.selectVehicle(kRideVehicleOptions[i].id),
                          ),
                        const SizedBox(height: 6),
                        _PromoRow(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 4,
            top: MediaQuery.of(context).padding.top + 6,
            child: _BackButton(onTap: () => Navigator.of(context).maybePop()),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                20,
                16,
                20,
                MediaQuery.of(context).padding.bottom + 16,
              ),
              decoration: BoxDecoration(
                color: AppColors.offWhite,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 20,
                    offset: const Offset(0, -6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 260),
                    transitionBuilder: (child, anim) => FadeTransition(
                      opacity: anim,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.15),
                          end: Offset.zero,
                        ).animate(anim),
                        child: child,
                      ),
                    ),
                    child: PrimaryButton(
                      key: ValueKey(selected.id),
                      label: 'Confirm ${selected.name}',
                      leadingText: selected.fareLabel,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const RideConfirmationScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Your safety is our priority',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
          ),
        ],
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

class _PromoRow extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booking = ref.watch(rideBookingProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          const Icon(Icons.sell_outlined, size: 18, color: AppColors.black),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.promoApplied ? 'Promo applied' : 'Have a promo code?',
                  style: AppTextStyles.bodyStrong,
                ),
                Text(
                  booking.promoApplied
                      ? '\u20B920 saved with SAVE20'
                      : "You'll save \u20B920 with this option",
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: booking.promoApplied
                ? null
                : () => ref
                      .read(rideBookingProvider.notifier)
                      .applyPromoCode('SAVE20'),
            child: Text(booking.promoApplied ? 'Applied' : 'Apply \u2192'),
          ),
        ],
      ),
    );
  }
}
