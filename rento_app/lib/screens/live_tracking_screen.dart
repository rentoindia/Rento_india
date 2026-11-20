import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';
import 'rental_order.dart';
import 'delivery_otp_screen.dart';

class LiveTrackingScreen extends StatefulWidget {
  final RentalOrder order;
  const LiveTrackingScreen({super.key, required this.order});

  @override
  State<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
  int _etaMinutes = 25;
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    // This is a live "rider is getting closer" simulation only — not
    // a promise of an exact delivery minute. The actual commitment
    // shown to the customer is the delivery SLOT they picked at
    // checkout (see the ETA card below), which is realistic; a
    // minute-by-minute countdown to an exact clock time is not.
    _ticker = Timer.periodic(const Duration(seconds: 3), (t) {
      if (!mounted) return;
      setState(() {
        if (_etaMinutes > 1) _etaMinutes--;
      });
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Live Tracking', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 15)),
            Text('Out for Delivery', style: TextStyle(color: Colors.black54, fontSize: 10.5)),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(child: CustomPaint(painter: _RoutePainter())),
                  const Positioned(top: 40, left: 40, child: _MapPin(icon: Icons.storefront, color: Colors.black)),
                  const Positioned(bottom: 60, right: 50, child: _MapPin(icon: Icons.location_on, color: Colors.redAccent)),
                  Positioned(
                    top: 100,
                    left: 140,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                      child: const Icon(Icons.two_wheeler, color: Colors.white, size: 18),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 16, offset: const Offset(0, -4))],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(radius: 24, backgroundColor: Color(0xFFF3F4F6), child: Icon(Icons.person, color: Colors.black54)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Rohit Kumar', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                            Row(children: [
                              const Icon(Icons.star, size: 13, color: Colors.amber),
                              const SizedBox(width: 3),
                              Text('4.8', style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600)),
                            ]),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('$_etaMinutes mins', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                          Text(
                            widget.order.deliverySlot != null
                                ? 'Slot: ${widget.order.deliverySlot}'
                                : 'ETA · 3.2 km',
                            style: TextStyle(fontSize: 10.5, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Calling Rohit Kumar...')),
                          ),
                          icon: const Icon(Icons.call_outlined, size: 16),
                          label: const Text('Call Rider'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: BorderSide(color: AppTheme.border),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Opening chat with rider...')),
                          ),
                          icon: const Icon(Icons.chat_bubble_outline, size: 16),
                          label: const Text('Chat'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text("You'll be notified once the rider reaches your location.",
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
                  const SizedBox(height: 12),
                  PrimaryButton(
                    label: 'SIMULATE ARRIVAL',
                    icon: Icons.check_circle_outline,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DeliveryOtpScreen(order: widget.order)),
                    ),
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

class _MapPin extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _MapPin({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(icon, color: Colors.white, size: 16),
    );
  }
}

// A dashed route line + faint grid to imply a map without needing a
// maps SDK/API key.
class _RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFFEFEFEF);
    canvas.drawRect(Offset.zero & size, bg);

    final grid = Paint()
      ..color = Colors.black.withOpacity(0.05)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 28) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += 28) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final path = Path()
      ..moveTo(56, 56)
      ..quadraticBezierTo(size.width * 0.3, size.height * 0.35, size.width * 0.55, size.height * 0.55)
      ..quadraticBezierTo(size.width * 0.7, size.height * 0.7, size.width - 66, size.height - 76);

    final routePaint = Paint()
      ..color = Colors.black87
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    // Manually dash the path.
    const dashWidth = 8.0;
    const dashSpace = 6.0;
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double distance = 0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(metric.extractPath(distance, next.clamp(0, metric.length)), routePaint);
        distance = next + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}