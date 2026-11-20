import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../models/captain_model.dart';
import '../providers/ride_booking_provider.dart';
import '../providers/ride_tracking_provider.dart';
import '../widgets/captain_card.dart';
import '../widgets/ride_otp_card.dart';
import '../widgets/ride_safety_pill.dart';
import 'sos_screen.dart';

class RideOtpVerificationScreen extends ConsumerStatefulWidget {
  const RideOtpVerificationScreen({super.key});

  @override
  ConsumerState<RideOtpVerificationScreen> createState() =>
      _RideOtpVerificationScreenState();
}

class _RideOtpVerificationScreenState
    extends ConsumerState<RideOtpVerificationScreen> {
  bool _autoStarted = false;
  Timer? _poll;

  @override
  void initState() {
    super.initState();
    // the captain enters this OTP in the rider app; when the server starts the ride we close this screen
    _poll = Timer.periodic(const Duration(milliseconds: 700), (_) {
      if (!mounted || _autoStarted) return;
      final stage = ref.read(rideTrackingProvider).stage;
      if (stage.index >= RideTrackingStage.rideInProgress.index) {
        _autoStarted = true;
        _poll?.cancel();
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _poll?.cancel();
    super.dispose();
  }

  void _cancelRide(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Cancel this ride?'),
        content: const Text(
          "Your captain is already close by. You won't be charged a "
          'cancellation fee at this stage.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Keep Ride'),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(rideBookingProvider.notifier)
                  .cancelRideOnServer(reason: 'Cancelled by passenger');
              Navigator.of(context).pop();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text('Cancel Ride'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tracking = ref.watch(rideTrackingProvider);

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _BackButton(
                        onTap: () => Navigator.of(context).maybePop(),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const SosScreen()),
                        ),
                        child: const RideSafetyPill(title: 'Safety First'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text('SECURITY', style: AppTextStyles.overline),
                  const SizedBox(height: 4),
                  Text('OTP Verification', style: AppTextStyles.display),
                  const SizedBox(height: 4),
                  Text(
                    'Share this OTP with your rider to start the ride.',
                    style: AppTextStyles.subtitle,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                children: [
                  CaptainDetailCard(
                    captain: kAssignedCaptain,
                    onCancel: () => _cancelRide(context),
                  ),
                  const SizedBox(height: 16),
                  RideOtpCard(
                    otp: tracking.rideOtp,
                    secondsRemaining: tracking.otpSecondsRemaining,
                  ),
                  const SizedBox(height: 16),
                  _InfoRow(
                    icon: Icons.shield_outlined,
                    title: 'Share this OTP with your rider',
                    body:
                        'After the rider enters the OTP in their app, your '
                        'ride will start automatically.',
                  ),
                  const SizedBox(height: 10),
                  _InfoRow(
                    icon: Icons.shield_outlined,
                    title: null,
                    body:
                        'Your safety is our priority. Never share the OTP '
                        'before the rider arrives. Rento India never asks '
                        'for OTP via call or message.',
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

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.title, required this.body});

  final IconData icon;
  final String? title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: AppColors.grey500),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(title!, style: AppTextStyles.bodyStrong),
                  const SizedBox(height: 2),
                ],
                Text(body, style: AppTextStyles.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
