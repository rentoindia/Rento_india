// lib/features/rider/presentation/screens/person/person_during_ride_screen.dart
//
// Step 4 of the Person Delivery flow — "During Ride": passenger card,
// drop destination with a Navigate action, a lightweight animated route
// map (dependency-free CustomPainter, no Maps key required — swap for
// a real map once GPS/routing is wired), a remaining-distance/time/fare
// row, and a progress bar. Tapping "Arrived at Destination" pushes
// PersonArrivedDestinationScreen.

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../data/models/person_ride_request_model.dart';
import 'person_arrived_destination_screen.dart';

class PersonDuringRideScreen extends StatefulWidget {
  final PersonRideRequestModel request;

  const PersonDuringRideScreen({super.key, required this.request});

  @override
  State<PersonDuringRideScreen> createState() => _PersonDuringRideScreenState();
}

class _PersonDuringRideScreenState extends State<PersonDuringRideScreen> {
  // Fixed demo progress along the route — TODO: drive this from live
  // GPS distance-remaining once routing is wired.
  static const double _progress = 0.65;
  bool _completing = false;

  Future<void> _call(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone.replaceAll(' ', ''));
    await launchUrl(uri);
  }

  void _onArrivedAtDestination() {
    if (_completing) return;
    setState(() => _completing = true);
    Future.delayed(const Duration(milliseconds: 450), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) =>
              PersonArrivedDestinationScreen(request: widget.request),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final trip = widget.request;
    final remainingKm = trip.distanceKm * (1 - _progress);
    final remainingMin = (trip.estimatedMinutes * (1 - _progress)).round();

    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(trip),
            _buildPassengerCard(trip),
            Expanded(
              child: ClipRRect(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(painter: _RoutePainter()),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: _circleControl(Icons.my_location, onTap: () {}),
                    ),
                  ],
                ),
              ),
            ),
            _buildBottomSheet(trip, remainingKm, remainingMin),
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
                  'During Ride',
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.pureWhite.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.headset_mic_outlined,
                  size: 15,
                  color: AppColors.pureWhite,
                ),
                SizedBox(width: 6),
                Text(
                  'Support',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.pureWhite,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPassengerCard(PersonRideRequestModel trip) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: const Color(0xFFF7F6FB),
            child: Text(
              trip.passengerName.isNotEmpty
                  ? trip.passengerName[0].toUpperCase()
                  : '?',
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip.passengerName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '${trip.passengerCount} Passenger',
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.call_outlined, size: 20),
            onPressed: () => _call(trip.passengerPhone),
          ),
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline, size: 20),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _circleControl(IconData icon, {required VoidCallback onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(icon, size: 18, color: Colors.black87),
      ),
    );
  }

  Widget _buildBottomSheet(
    PersonRideRequestModel trip,
    double remainingKm,
    int remainingMin,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
      decoration: const BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(right: 8),
                decoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dropping to',
                      style: TextStyle(color: Colors.black45, fontSize: 11),
                    ),
                    Text(
                      '${trip.dropLabel}, Chennai',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.navigation_outlined, size: 16),
                label: const Text('Navigate'),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F6FB),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                _stat('${remainingKm.toStringAsFixed(1)} km', 'Remaining'),
                _vDivider(),
                _stat('$remainingMin min', 'Remaining'),
                _vDivider(),
                _stat(trip.fareLabel, 'Fare'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'En route to destination',
                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
              ),
              Text(
                '${(_progress * 100).round()}%',
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: _progress,
              minHeight: 6,
              backgroundColor: const Color(0xFFEDEDED),
              valueColor: const AlwaysStoppedAnimation(AppColors.primaryBlack),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, size: 14, color: Colors.black54),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Please ensure a safe and comfortable ride.',
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _completing ? null : _onArrivedAtDestination,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlack,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                elevation: 0,
              ),
              child: _completing
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.4,
                        color: Colors.white,
                      ),
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Arrived at Destination',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: Colors.white,
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
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
      Container(width: 1, height: 30, color: Colors.grey.shade300);
}

/// Lightweight stand-in for a live route map — a light-grey backdrop
/// with a drawn polyline from pickup (top-left) to drop (bottom-right)
/// and two pin markers. TODO: replace with google_maps_flutter once
/// GPS/routing is wired, same as the parcel flow's navigate screen.
class _RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFFEFEFF3);
    canvas.drawRect(Offset.zero & size, bg);

    final path = Path()
      ..moveTo(size.width * 0.16, size.height * 0.18)
      ..lineTo(size.width * 0.16, size.height * 0.42)
      ..lineTo(size.width * 0.5, size.height * 0.42)
      ..lineTo(size.width * 0.5, size.height * 0.7)
      ..lineTo(size.width * 0.82, size.height * 0.7)
      ..lineTo(size.width * 0.82, size.height * 0.86);

    final routePaint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path, routePaint);

    final startPaint = Paint()..color = Colors.black;
    canvas.drawCircle(
      Offset(size.width * 0.16, size.height * 0.18),
      6,
      startPaint,
    );

    final endPaint = Paint()..color = Colors.redAccent;
    canvas.drawCircle(
      Offset(size.width * 0.82, size.height * 0.86),
      7,
      endPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
