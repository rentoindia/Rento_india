import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/primary_button.dart';
import '../models/rider_model.dart';
import '../providers/booking_provider.dart';
import '../providers/tracking_provider.dart';
import '../widgets/map_preview.dart';
import '../widgets/otp_bottom_sheet.dart';
import '../widgets/rider_info_card.dart';
import '../widgets/tracking_status_panel.dart';
import 'trip_completed_screen.dart';

class LiveTrackingScreen extends ConsumerStatefulWidget {
  const LiveTrackingScreen({super.key});

  @override
  ConsumerState<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends ConsumerState<LiveTrackingScreen> {
  bool _pickupSheetShown = false;
  bool _deliverySheetShown = false;

  @override
  Widget build(BuildContext context) {
    final tracking = ref.watch(trackingProvider);
    final stage = tracking.stage;

    if (stage == TrackingStage.riderArrivedAtPickup && !_pickupSheetShown) {
      _pickupSheetShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _presentPickupOtp());
    }
    if (stage == TrackingStage.riderNearReceiver && !_deliverySheetShown) {
      _deliverySheetShown = true;
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _presentDeliveryOtp(),
      );
    }
    if (stage == TrackingStage.parcelDelivered) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _goToCompleted());
    }

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          child: stage == TrackingStage.searchingRider
              ? _SearchingBody(key: const ValueKey('searching'))
              : _TrackingBody(key: const ValueKey('tracking'), stage: stage),
        ),
      ),
    );
  }

  Future<void> _presentPickupOtp() => presentPickupOtpSheet(context, ref);

  Future<void> _presentDeliveryOtp() => presentDeliveryOtpSheet(context, ref);

  void _goToCompleted() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const TripCompletedScreen()),
    );
  }
}

Future<void> presentPickupOtpSheet(BuildContext context, WidgetRef ref) async {
  final tracking = ref.read(trackingProvider);
  await showOtpBottomSheet(
    context,
    otp: tracking.pickupOtp,
    title: 'Share this OTP with the rider',
    description: 'for pickup verification.',
    confirmLabel: 'I Understand',
    onConfirm: () => ref.read(trackingProvider.notifier).confirmPickupOtp(),
  );
}

Future<void> presentDeliveryOtpSheet(
  BuildContext context,
  WidgetRef ref,
) async {
  final tracking = ref.read(trackingProvider);
  await showOtpBottomSheet(
    context,
    otp: tracking.deliveryOtp,
    title: 'Share this OTP with the receiver',
    description: 'for delivery verification.',
    confirmLabel: 'Got It',
    onConfirm: () => ref.read(trackingProvider.notifier).confirmDeliveryOtp(),
  );
}

class _SearchingBody extends ConsumerWidget {
  const _SearchingBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booking = ref.watch(bookingProvider);
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.heroGradient),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SearchingRadar(),
            const SizedBox(height: 28),
            Text(
              'Searching\nfor available riders...',
              style: AppTextStyles.h1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Please wait, we are finding the best rider for you.',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Booking Details', style: AppTextStyles.captionStrong),
                  const SizedBox(height: 10),
                  _MiniAddressLine(
                    label: 'Pickup',
                    value: booking.pickup?.combined ?? '—',
                  ),
                  const SizedBox(height: 8),
                  _MiniAddressLine(
                    label: 'Delivery',
                    value: booking.receiver?.combined ?? '—',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniAddressLine extends StatelessWidget {
  const _MiniAddressLine({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          label == 'Pickup' ? Icons.circle : Icons.location_on,
          size: label == 'Pickup' ? 8 : 14,
          color: AppColors.black,
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

class _TrackingBody extends ConsumerWidget {
  const _TrackingBody({super.key, required this.stage});
  final TrackingStage stage;

  ({String title, String? subtitle, IconData icon, bool filled}) _copyFor(
    TrackingStage stage,
  ) {
    switch (stage) {
      case TrackingStage.riderAssigned:
        return (
          title: 'Estimated arrival at pickup',
          subtitle: '6 min (1.2 km)',
          icon: Icons.schedule,
          filled: false,
        );
      case TrackingStage.onTheWayToPickup:
        return (
          title: 'On the way to pickup',
          subtitle: 'ETA 4 min · 1.2 km away',
          icon: Icons.moped_outlined,
          filled: false,
        );
      case TrackingStage.riderArrivedAtPickup:
        return (
          title: 'Rider has arrived at pickup',
          subtitle: 'Please share OTP to hand over your parcel.',
          icon: Icons.place_outlined,
          filled: false,
        );
      case TrackingStage.parcelPickedUp:
        return (
          title: 'Parcel picked up successfully',
          subtitle: 'Heading to the delivery location.',
          icon: Icons.check_circle_outline,
          filled: true,
        );
      case TrackingStage.onTheWayToReceiver:
        return (
          title: 'On the way to delivery',
          subtitle: 'ETA 18 min · 6.3 km away',
          icon: Icons.moped_outlined,
          filled: false,
        );
      case TrackingStage.riderNearReceiver:
        return (
          title: 'Rider is near the delivery location',
          subtitle: 'Please ask receiver to keep OTP ready.',
          icon: Icons.place_outlined,
          filled: false,
        );
      default:
        return (
          title: 'Tracking your rider',
          subtitle: null,
          icon: Icons.moped_outlined,
          filled: false,
        );
    }
  }

  String get _headerTitle {
    switch (stage) {
      case TrackingStage.riderAssigned:
        return 'Rider Assigned';
      case TrackingStage.onTheWayToPickup:
        return 'Live Tracking';
      case TrackingStage.riderArrivedAtPickup:
        return 'Rider Arrived';
      case TrackingStage.pickupOtp:
        return 'Pickup Verification';
      case TrackingStage.parcelPickedUp:
        return 'Parcel Picked Up';
      case TrackingStage.onTheWayToReceiver:
        return 'Live Tracking';
      case TrackingStage.riderNearReceiver:
        return 'Rider Near Receiver';
      case TrackingStage.deliveryOtp:
        return 'Delivery Verification';
      default:
        return 'Tracking';
    }
  }

  ({String label, IconData icon})? _ctaFor(TrackingStage stage) {
    switch (stage) {
      case TrackingStage.riderAssigned:
      case TrackingStage.onTheWayToPickup:
        return (label: 'Track Live', icon: Icons.my_location);
      case TrackingStage.riderArrivedAtPickup:
        return (label: 'Share OTP with Rider', icon: Icons.qr_code_2_outlined);
      case TrackingStage.parcelPickedUp:
        return (label: 'Track Delivery', icon: Icons.local_shipping_outlined);
      case TrackingStage.onTheWayToReceiver:
        return (label: 'Share Tracking', icon: Icons.ios_share);
      case TrackingStage.riderNearReceiver:
        return (label: 'Delivery OTP', icon: Icons.password_outlined);
      default:
        return null;
    }
  }

  void _onCtaTap(BuildContext context, WidgetRef ref, TrackingStage stage) {
    switch (stage) {
      case TrackingStage.riderAssigned:
      case TrackingStage.onTheWayToPickup:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("You're following the rider's live location."),
            duration: Duration(seconds: 2),
          ),
        );
        break;
      case TrackingStage.riderArrivedAtPickup:
        presentPickupOtpSheet(context, ref);
        break;
      case TrackingStage.parcelPickedUp:
        ref
            .read(trackingProvider.notifier)
            .jumpTo(TrackingStage.onTheWayToReceiver);
        break;
      case TrackingStage.onTheWayToReceiver:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tracking link copied — share it with anyone.'),
            duration: Duration(seconds: 2),
          ),
        );
        break;
      case TrackingStage.riderNearReceiver:
        presentDeliveryOtpSheet(context, ref);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final copy = _copyFor(stage);
    final cta = _ctaFor(stage);
    final progress = stage.index / TrackingStage.riderNearReceiver.index;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, size: 20),
                onPressed: () => Navigator.of(context).maybePop(),
              ),
              Expanded(
                child: Text(
                  _headerTitle,
                  style: AppTextStyles.h2,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              children: [
                if (stage.showsRiderCard) RiderInfoCard(rider: kAssignedRider),
                const SizedBox(height: 14),
                MapPreview(
                  height: 260,
                  showRoute: true,
                  animateRider: true,
                  riderProgress: progress.clamp(0.05, 1.0),
                ),
                const SizedBox(height: 14),
                StatusInfoPanel(
                  icon: copy.icon,
                  title: copy.title,
                  subtitle: copy.subtitle,
                  filled: copy.filled,
                ),
                if (cta != null) ...[
                  const SizedBox(height: 14),
                  PrimaryButton(
                    label: cta.label,
                    trailing: Icon(cta.icon, size: 16, color: AppColors.white),
                    onPressed: () => _onCtaTap(context, ref, stage),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
