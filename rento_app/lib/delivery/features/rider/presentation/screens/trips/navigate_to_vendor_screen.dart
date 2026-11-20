// lib/features/rider/presentation/screens/trips/navigate_to_vendor_screen.dart
//
// Step 1 of the trip flow after a rider accepts a request:
//   Accept  →  NavigateToVendorScreen (this file)  →  PickupOtpScreen
//
// Matches the "Navigate to Customer" design mock, mirrored for the
// pickup leg (vendor instead of customer). The map is a lightweight,
// dependency-free animated CustomPainter "stylised map" — no Google
// Maps key required — so the route draws itself in, a live pulse
// travels along it, and the rider marker breathes gently. Swap
// `_MapCanvas` for a real map widget later without touching the rest
// of the screen; every place that would need live GPS/routing data is
// marked TODO.

import 'dart:math' as math;
import 'dart:ui' show PathMetric;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:rento_india/delivery/core/constants/app_colors.dart'; //import '../../../../../core/constants/app_colors.dart';
import '../../../data/models/trip_request_model.dart';
import 'pickup_otp_screen.dart';

class NavigateToVendorScreen extends StatefulWidget {
  final TripRequestModel request;

  const NavigateToVendorScreen({super.key, required this.request});

  @override
  State<NavigateToVendorScreen> createState() => _NavigateToVendorScreenState();
}

class _NavigateToVendorScreenState extends State<NavigateToVendorScreen>
    with TickerProviderStateMixin {
  // Entrance choreography (top card + bottom sheet slide/fade in).
  late final AnimationController _entrance;
  late final Animation<double> _topCardAnim;
  late final Animation<double> _sheetAnim;

  // Route draws itself in once, then a light "pulse" keeps flowing
  // along it and the two markers breathe — all purely cosmetic.
  late final AnimationController _routeDraw;
  late final AnimationController _flow;
  late final AnimationController _pulse;

  bool _arriving = false;

  // Fractional waypoints (0..1 of the map canvas) tracing rider → vendor.
  // TODO: replace with a real polyline from the directions/routing service.
  static const List<Offset> _route = [
    Offset(0.14, 0.88),
    Offset(0.14, 0.66),
    Offset(0.44, 0.66),
    Offset(0.44, 0.40),
    Offset(0.50, 0.34),
    Offset(0.78, 0.34),
    Offset(0.78, 0.16),
  ];

  @override
  void initState() {
    super.initState();

    _entrance = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    )..forward();
    _topCardAnim = CurvedAnimation(
      parent: _entrance,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
    );
    _sheetAnim = CurvedAnimation(
      parent: _entrance,
      curve: const Interval(0.25, 1.0, curve: Curves.easeOutCubic),
    );

    _routeDraw = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    )..forward();

    _flow = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();

    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _entrance.dispose();
    _routeDraw.dispose();
    _flow.dispose();
    _pulse.dispose();
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
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Report an issue',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              ),
              const SizedBox(height: 4),
              const Text(
                'Let us know what went wrong on the way to the vendor.',
                style: TextStyle(color: Colors.black54, fontSize: 13),
              ),
              const SizedBox(height: 16),
              // TODO: wire to trip_repository.reportIssue(tripId, reason)
              ..._issueReasons.map(
                (r) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.error_outline, size: 20),
                  title: Text(r, style: const TextStyle(fontSize: 14)),
                  onTap: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static const _issueReasons = [
    'Vendor location is incorrect',
    'Vendor is not reachable',
    'Vehicle breakdown',
    'Traffic / road blockage',
  ];

  void _onArrived() {
    if (_arriving) return;
    setState(() => _arriving = true);
    Future.delayed(const Duration(milliseconds: 620), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 420),
          pageBuilder: (_, __, ___) => PickupOtpScreen(request: widget.request),
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(trip),
            FadeTransition(
              opacity: _topCardAnim,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -0.15),
                  end: Offset.zero,
                ).animate(_topCardAnim),
                child: _buildInstructionCard(),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: _MapCanvas(
                      route: _route,
                      routeDraw: _routeDraw,
                      flow: _flow,
                      pulse: _pulse,
                    ),
                  ),
                  Positioned(right: 14, bottom: 14, child: _buildMapControls()),
                ],
              ),
            ),
            FadeTransition(
              opacity: _sheetAnim,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.25),
                  end: Offset.zero,
                ).animate(_sheetAnim),
                child: _buildBottomSheet(trip),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(TripRequestModel trip) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 16, 4),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  'Navigate to Vendor',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
                Text(
                  'TRIP ID: #${trip.id}',
                  style: const TextStyle(
                    color: Colors.black45,
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
    return _Pressable(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionCard() {
    // TODO: replace with live turn-by-turn data from location_service.dart
    // once real routing/geolocation is wired.
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F6FB),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_upward_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '450 m',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Continue straight on Anna Salai',
                    style: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _statChip('12.4 km', 'DISTANCE'),
                const SizedBox(height: 8),
                _statChip('32 min', 'ETA'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statChip(String value, String label) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutCubic,
      builder: (context, t, _) => Opacity(
        opacity: t,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black45,
                fontSize: 10,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapControls() {
    return Column(
      children: [
        _circleControl(
          Icons.my_location,
          onTap: () {
            // TODO: recenter camera on rider's live location.
          },
        ),
        const SizedBox(height: 10),
        _circleControl(
          Icons.layers_outlined,
          onTap: () {
            // TODO: toggle map layer (satellite/traffic).
          },
        ),
      ],
    );
  }

  Widget _circleControl(IconData icon, {required VoidCallback onTap}) {
    return _Pressable(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: Colors.black87),
      ),
    );
  }

  Widget _buildBottomSheet(TripRequestModel trip) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 24,
            offset: Offset(0, -6),
          ),
        ],
      ),
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
                // TODO: use trip.vendorPhone once the model carries it.
                onTap: () => _call('+91 98765 43210'),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1),
          const SizedBox(height: 14),
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'VENDOR CONTACT',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 11,
                        letterSpacing: 0.4,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '+91 98765 43210',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              _pillButton(
                icon: Icons.chat_bubble_outline,
                label: 'Message',
                onTap: () {
                  // TODO: open SMS via url_launcher (sms: scheme), same
                  // pattern as trips_list_screen._launchSms.
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
                _tripStat(Icons.laptop_mac, 'ITEM', trip.itemName),
                _vDivider(),
                _tripStat(Icons.calendar_today_outlined, 'QTY', '${trip.qty}'),
                _vDivider(),
                _tripStat(
                  Icons.currency_rupee,
                  'EARNINGS',
                  '₹${trip.earnings.toStringAsFixed(0)}',
                ),
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
                child: _ArrivedButton(loading: _arriving, onTap: _onArrived),
              ),
            ],
          ),
        ],
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

/// Confirm button that morphs into a spinner then a check-mark while the
/// "arrival" is being confirmed, instead of just disabling instantly.
class _ArrivedButton extends StatelessWidget {
  final bool loading;
  final VoidCallback onTap;

  const _ArrivedButton({required this.loading, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return _Pressable(
      onTap: loading ? () {} : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black,
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
                    children: const [
                      Text(
                        'Arrived at Pickup',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

/// Small helper that gives any child a tactile press-down scale, used for
/// the pill/circle buttons scattered across this screen.
class _Pressable extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _Pressable({required this.child, required this.onTap});

  @override
  State<_Pressable> createState() => _PressableState();
}

class _PressableState extends State<_Pressable> {
  double _scale = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.92),
      onTapUp: (_) => setState(() => _scale = 1),
      onTapCancel: () => setState(() => _scale = 1),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        child: widget.child,
      ),
    );
  }
}

/// The animated "map". Fully self-contained CustomPainter — no external
/// map SDK/API key required. Draws a light schematic road network, the
/// route from rider → vendor (animates in once), a soft ping travelling
/// repeatedly along the route, a pulsing destination pin, and a gently
/// breathing "you are here" marker for the rider.
class _MapCanvas extends StatelessWidget {
  final List<Offset> route;
  final Animation<double> routeDraw;
  final Animation<double> flow;
  final Animation<double> pulse;

  const _MapCanvas({
    required this.route,
    required this.routeDraw,
    required this.flow,
    required this.pulse,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F5F8),
      child: AnimatedBuilder(
        animation: Listenable.merge([routeDraw, flow, pulse]),
        builder: (context, _) {
          return CustomPaint(
            painter: _RoutePainter(
              route: route,
              drawProgress: Curves.easeInOutCubic.transform(routeDraw.value),
              flowT: flow.value,
              pulseT: pulse.value,
            ),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class _RoutePainter extends CustomPainter {
  final List<Offset> route;
  final double drawProgress;
  final double flowT;
  final double pulseT;

  _RoutePainter({
    required this.route,
    required this.drawProgress,
    required this.flowT,
    required this.pulseT,
  });

  Offset _abs(Offset frac, Size size) =>
      Offset(frac.dx * size.width, frac.dy * size.height);

  Path _roundedPolyline(List<Offset> pts) {
    final path = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (var i = 1; i < pts.length - 1; i++) {
      final prev = pts[i - 1];
      final curr = pts[i];
      final next = pts[i + 1];
      final inPoint = Offset.lerp(prev, curr, 0.85)!;
      final outPoint = Offset.lerp(curr, next, 0.15)!;
      path.lineTo(inPoint.dx, inPoint.dy);
      path.quadraticBezierTo(curr.dx, curr.dy, outPoint.dx, outPoint.dy);
    }
    path.lineTo(pts.last.dx, pts.last.dy);
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _paintBackgroundRoads(canvas, size);

    final absPoints = route.map((p) => _abs(p, size)).toList();
    final routePath = _roundedPolyline(absPoints);
    final metrics = routePath.computeMetrics().toList();
    if (metrics.isEmpty) return;
    final metric = metrics.first;
    final totalLength = metric.length;

    // Faint full-length preview of the route (always visible).
    final ghostPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(routePath, ghostPaint);

    // The route "drawing itself in" on entrance.
    final drawnPath = metric.extractPath(0, totalLength * drawProgress);
    final routePaint = Paint()
      ..color = Colors.black87
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(drawnPath, routePaint);

    // A soft "comet" that keeps flowing along the finished route,
    // signalling live movement without implying actual progress.
    if (drawProgress > 0.98) {
      _paintFlowComet(canvas, metric, totalLength);
    }

    // Destination pin (vendor) at the end of the route, pulsing.
    final destination = absPoints.last;
    _paintPulsingPin(canvas, destination, pulseT, isDestination: true);

    // Rider "you are here" marker at the start, breathing gently.
    final origin = absPoints.first;
    _paintRiderMarker(canvas, origin, pulseT);
  }

  void _paintFlowComet(Canvas canvas, PathMetric metric, double totalLength) {
    for (var i = 0; i < 3; i++) {
      final t = (flowT - i * 0.06) % 1.0;
      final tangent = metric.getTangentForOffset(totalLength * t);
      if (tangent == null) continue;
      final opacity = (1 - i * 0.32).clamp(0.0, 1.0) * 0.9;
      final paint = Paint()
        ..color = AppColors.accentLime.withValues(alpha: opacity)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(tangent.position, 5 - i * 1.0, paint);
    }
  }

  void _paintPulsingPin(
    Canvas canvas,
    Offset center,
    double t, {
    required bool isDestination,
  }) {
    final ringRadius = 14 + 16 * t;
    final ringPaint = Paint()
      ..color = Colors.black.withValues(alpha: (1 - t) * 0.25)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, ringRadius, ringPaint);

    final basePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 10, basePaint);

    final dotPaint = Paint()..color = Colors.white;
    canvas.drawCircle(center, 4, dotPaint);
  }

  void _paintRiderMarker(Canvas canvas, Offset center, double t) {
    final breathe = 1 + 0.08 * math.sin(t * 2 * math.pi);
    final haloPaint = Paint()
      ..color = AppColors.accentLime.withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 16 * breathe, haloPaint);

    final ringPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 11, ringPaint);

    final corePaint = Paint()..color = Colors.black87;
    canvas.drawCircle(center, 8, corePaint);

    final iconPaint = Paint()..color = Colors.white;
    canvas.drawCircle(center, 3, iconPaint);
  }

  void _paintBackgroundRoads(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final blockPaint = Paint()..color = Colors.black.withValues(alpha: 0.035);

    // A handful of schematic cross-streets for texture.
    final horizontals = [0.2, 0.42, 0.58, 0.78];
    final verticals = [0.22, 0.5, 0.7, 0.9];
    for (final fy in horizontals) {
      canvas.drawLine(
        Offset(0, size.height * fy),
        Offset(size.width, size.height * fy),
        roadPaint,
      );
    }
    for (final fx in verticals) {
      canvas.drawLine(
        Offset(size.width * fx, 0),
        Offset(size.width * fx, size.height),
        roadPaint,
      );
    }

    // Faint "city block" rectangles for a bit of map texture.
    final blocks = [
      const Offset(0.06, 0.06),
      const Offset(0.30, 0.10),
      const Offset(0.62, 0.06),
      const Offset(0.06, 0.46),
      const Offset(0.58, 0.46),
      const Offset(0.30, 0.72),
      const Offset(0.62, 0.66),
    ];
    for (final b in blocks) {
      final rect = Rect.fromLTWH(
        size.width * b.dx,
        size.height * b.dy,
        size.width * 0.16,
        size.height * 0.10,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(6)),
        blockPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RoutePainter oldDelegate) {
    return oldDelegate.drawProgress != drawProgress ||
        oldDelegate.flowT != flowT ||
        oldDelegate.pulseT != pulseT;
  }
}
