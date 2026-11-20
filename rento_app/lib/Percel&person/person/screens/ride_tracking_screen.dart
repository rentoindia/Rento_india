import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../parcel/widgets/map_preview.dart';
import '../../parcel/widgets/tracking_status_panel.dart';
import '../models/captain_model.dart';
import '../providers/ride_booking_provider.dart';
import '../providers/ride_tracking_provider.dart';
import '../widgets/captain_card.dart';
import '../widgets/ride_safety_pill.dart';
import 'ride_completed_screen.dart';
import 'ride_otp_verification_screen.dart';
import 'sos_screen.dart';

class RideTrackingScreen extends ConsumerStatefulWidget {
  const RideTrackingScreen({super.key});

  @override
  ConsumerState<RideTrackingScreen> createState() => _RideTrackingScreenState();
}

class _RideTrackingScreenState extends ConsumerState<RideTrackingScreen> {
  bool _otpPushed = false;
  bool _completionScheduled = false;

  @override
  Widget build(BuildContext context) {
    final tracking = ref.watch(rideTrackingProvider);
    final stage = tracking.stage;

    if (stage == RideTrackingStage.captainArrived && !_otpPushed) {
      _otpPushed = true;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!mounted) return;
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const RideOtpVerificationScreen()),
        );
        if (mounted) _otpPushed = false;
      });
    }

    if (stage == RideTrackingStage.rideCompleted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const RideCompletedScreen()),
        );
      });
    }

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          child: stage == RideTrackingStage.searchingCaptain
              ? const _SearchingBody(key: ValueKey('searching'))
              : _EnRouteBody(key: const ValueKey('en-route'), stage: stage),
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

class _SearchingBody extends ConsumerWidget {
  const _SearchingBody({super.key});

  Future<void> _cancelRide(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Cancel this ride?'),
        content: const Text(
          "We're still looking for a captain. You won't be charged a "
          'cancellation fee at this stage.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Keep Searching'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Cancel Ride'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    if (!context.mounted) return;

    ref.read(rideBookingProvider.notifier).cancelRide();

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booking = ref.watch(rideBookingProvider);
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.heroGradient),
      child: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SearchingRadar(),
                      const SizedBox(height: 28),
                      Text(
                        'Searching\nfor a nearby captain...',
                        style: AppTextStyles.h1,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Please wait, we are matching you with the best captain.',
                        style: AppTextStyles.caption,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: AppColors.divider),
                        ),
                        child: Row(
                          children: [
                            Icon(booking.selectedVehicle.icon, size: 22),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    booking.selectedVehicle.name,
                                    style: AppTextStyles.bodyStrong,
                                  ),
                                  Text(
                                    '${booking.pickup?.label ?? "Pickup"} \u2192 '
                                    '${booking.destination?.label ?? "Destination"}',
                                    style: AppTextStyles.caption,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '\u20B9${booking.totalFare.toStringAsFixed(0)}',
                              style: AppTextStyles.h2,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () => _cancelRide(context, ref),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          'Cancel Ride',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            left: 4,
            top: 6,
            child: _BackButton(onTap: () => Navigator.of(context).maybePop()),
          ),
        ],
      ),
    );
  }
}

class _EnRouteBody extends ConsumerWidget {
  const _EnRouteBody({super.key, required this.stage});

  final RideTrackingStage stage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booking = ref.watch(rideBookingProvider);
    final inProgress = stage == RideTrackingStage.rideInProgress;

    final IconData icon;
    final String title;
    final String subtitle;
    switch (stage) {
      case RideTrackingStage.captainAssigned:
        icon = Icons.task_alt;
        title = 'Captain Assigned';
        subtitle = 'Rajesh is getting ready to head your way.';
        break;
      case RideTrackingStage.captainArriving:
        icon = Icons.moped_outlined;
        title = 'Captain Arriving';
        subtitle = 'On the way to your pickup point \u00b7 ETA 2 min';
        break;
      case RideTrackingStage.captainArrived:
        icon = Icons.pin_drop_outlined;
        title = 'Captain Has Arrived';
        subtitle = 'Share your OTP to start the ride.';
        break;
      default:
        icon = Icons.navigation_outlined;
        title = 'Ride in Progress';
        subtitle =
            'Heading to ${booking.destination?.label ?? "your destination"}';
    }

    return Column(
      key: ValueKey(stage),
      children: [
        Stack(
          children: [
            const MapPreview(height: 260, showRoute: true, animateRider: true),
            Positioned(
              left: 14,
              top: 14,
              child: _BackButton(onTap: () => Navigator.of(context).maybePop()),
            ),
            Positioned(
              top: 14,
              right: 14,
              child: GestureDetector(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const SosScreen())),
                child: const RideSafetyPill(title: 'Safety First'),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            children: [
              StatusInfoPanel(
                icon: icon,
                title: title,
                subtitle: subtitle,
                filled: true,
              ),
              const SizedBox(height: 16),
              inProgress
                  ? CaptainCompactBar(captain: kAssignedCaptain)
                  : CaptainDetailCard(captain: kAssignedCaptain),
            ],
          ),
        ),
      ],
    );
  }
}
