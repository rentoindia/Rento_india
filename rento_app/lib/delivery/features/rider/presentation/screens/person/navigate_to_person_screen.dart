
// lib/features/rider/presentation/screens/person/navigate_to_person_screen.dart
//
// Step 1 of the Person Delivery (passenger ride) flow:
//   Accept → NavigateToPersonScreen (this file) → PersonPickupOtpScreen
//          → PersonVerificationScreen → PersonDuringRideScreen
//          → PersonArrivedDestinationScreen
//
// Matches the "Navigate to Pickup" reference mock — dark top bar with
// TRIP ID + Support pill, a "Locating..." instruction card, a
// destination-not-found placeholder in place of a live map (swap
// `_MapPlaceholder` for a real map widget once GPS/routing is wired —
// every spot that needs it is marked TODO), then a white bottom sheet
// with Pickup From, Passenger Contact, stats row, and the primary
// action.

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../data/models/person_ride_request_model.dart';
import 'person_pickup_otp_screen.dart';

class NavigateToPersonScreen extends StatefulWidget {
  final PersonRideRequestModel request;

  const NavigateToPersonScreen({super.key, required this.request});

  @override
  State<NavigateToPersonScreen> createState() => _NavigateToPersonScreenState();
}

class _NavigateToPersonScreenState extends State<NavigateToPersonScreen>
    with SingleTickerProviderStateMixin {
  bool _arriving = false;

  late final AnimationController _entrance;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _entrance = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
    _fade = CurvedAnimation(parent: _entrance, curve: Curves.easeOutCubic);
  }

  @override
  void dispose() {
    _entrance.dispose();
    super.dispose();
  }

  Future<void> _call(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone.replaceAll(' ', ''));
    final ok = await launchUrl(uri);
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the dialer')),
      );
    }
  }

  void _reportIssue() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Report an Issue',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const SizedBox(height: 14),
              for (final reason in const [
                'Passenger location is incorrect',
                'Passenger is not reachable',
                'Vehicle breakdown',
                'Traffic / road blockage',
              ])
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.report_gmailerrorred_outlined),
                  title: Text(reason),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Reported: $reason')),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _onArrived() {
    if (_arriving) return;
    setState(() => _arriving = true);
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 380),
          pageBuilder: (_, __, ___) =>
              PersonPickupOtpScreen(request: widget.request),
          transitionsBuilder: (_, anim, __, child) {
            final curved = CurvedAnimation(
              parent: anim,
              curve: Curves.easeOutCubic,
            );
            return FadeTransition(
              opacity: curved,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.06),
                  end: Offset.zero,
                ).animate(curved),
                child: child,
              ),
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final trip = widget.request;

    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(trip),
            Expanded(
              child: FadeTransition(
                opacity: _fade,
                child: Column(
                  children: [
                    _buildInstructionCard(),
                    Expanded(
                      child: _MapPlaceholder(
                        destinationLabel: trip.pickupLabel,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildBottomSheet(trip),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(PersonRideRequestModel trip) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 16, 12),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 18,
              color: AppColors.pureWhite,
            ),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  'Navigate to Pickup',
                  style: TextStyle(
                    color: AppColors.pureWhite,
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
                ),
                Text(
                  'TRIP ID: ${trip.tripId}',
                  style: const TextStyle(
                    color: AppColors.textHint,
                    fontSize: 11,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
          _pillButton(
            icon: Icons.headset_mic_outlined,
            label: 'Support',
            onTap: () {
              // TODO: wire to core/services support/help-center flow.
            },
          ),
        ],
      ),
    );
  }

  Widget _pillButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.pureWhite.withOpacity(0.12),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: AppColors.pureWhite),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: AppColors.pureWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: AppColors.pureWhite,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.navigation_rounded,
              color: AppColors.primaryBlack,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Locating...',
                  style: TextStyle(
                    color: AppColors.pureWhite,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Heading to Pickup Location',
                  style: TextStyle(color: AppColors.textHint, fontSize: 12.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheet(PersonRideRequestModel trip) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.62,
      ),
      decoration: const BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'PICKUP FROM',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 11,
                          letterSpacing: 0.4,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        trip.pickupLabel,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        trip.pickupAddress,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                _circleControl(
                  Icons.call_outlined,
                  onTap: () => _call(trip.passengerPhone),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Divider(height: 1),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'PASSENGER CONTACT',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 11,
                          letterSpacing: 0.4,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        trip.passengerName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        trip.passengerPhone,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                _pillButtonDark(
                  icon: Icons.chat_bubble_outline,
                  label: 'Message',
                  onTap: () {
                    // TODO: open SMS via url_launcher (sms: scheme).
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F6FB),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  _tripStat(
                    Icons.person_outline,
                    'DETAILS',
                    '${trip.passengerCount} Passenger',
                  ),
                  _vDivider(),
                  _tripStat(
                    Icons.social_distance_outlined,
                    'DISTANCE',
                    trip.distanceLabel,
                  ),
                  _vDivider(),
                  _tripStat(Icons.currency_rupee, 'EST. FARE', trip.fareLabel),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _reportIssue,
                    icon: const Icon(Icons.warning_amber_rounded, size: 18),
                    label: const Text('Report Issue'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      side: BorderSide(color: Colors.grey.shade300),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: _ArrivedButton(
                    loading: _arriving,
                    label: 'Arrived at Pickup',
                    onTap: _onArrived,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _pillButtonDark({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primaryBlack,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: AppColors.pureWhite),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: AppColors.pureWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleControl(IconData icon, {required VoidCallback onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: Colors.black87),
      ),
    );
  }

  Widget _tripStat(IconData icon, String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 18, color: Colors.black54),
          const SizedBox(height: 6),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              color: Colors.black45,
              fontSize: 10,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _vDivider() =>
      Container(width: 1, height: 34, color: Colors.grey.shade300);
}

/// Stand-in for a live map while GPS/routing isn't wired yet — mirrors
/// the reference mock's "could not locate the address" placeholder
/// state so the layout matches exactly. TODO: replace with a real map
/// widget (google_maps_flutter, same as navigate_to_parcel_screen.dart)
/// once live location is available.
class _MapPlaceholder extends StatelessWidget {
  final String destinationLabel;
  const _MapPlaceholder({required this.destinationLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryBlack,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.location_off_outlined,
            color: Colors.redAccent.withOpacity(0.85),
            size: 34,
          ),
          const SizedBox(height: 10),
          Text(
            'Could not locate "$destinationLabel".\nCheck the address.',
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.textHint, fontSize: 12.5),
          ),
        ],
      ),
    );
  }
}

class _ArrivedButton extends StatelessWidget {
  final bool loading;
  final String label;
  final VoidCallback onTap;

  const _ArrivedButton({
    required this.loading,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(28),
      onTap: loading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.primaryBlack,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            child: loading
                ? const SizedBox(
                    key: ValueKey('loading'),
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      color: Colors.white,
                    ),
                  )
                : Row(
                    key: const ValueKey('label'),
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}