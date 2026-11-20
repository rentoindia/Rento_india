import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// A stylised, dependency-free "map" — a subtle grid + a curved route
/// between two pins, with an optional animated rider marker travelling
/// along the path. Stands in for `google_maps_flutter` (already used
/// in the main Rento India rider module) until this module is wired
/// into the live map/GPS stack.
class MapPreview extends StatefulWidget {
  const MapPreview({
    super.key,
    this.height = 220,
    this.showRoute = true,
    this.animateRider = false,
    this.riderProgress,
  });

  final double height;
  final bool showRoute;
  final bool animateRider;

  /// 0.0 (at pickup) → 1.0 (at destination). If null and [animateRider]
  /// is true, the marker loops automatically for a "live" feel.
  final double? riderProgress;

  @override
  State<MapPreview> createState() => _MapPreviewState();
}

class _MapPreviewState extends State<MapPreview>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: widget.height,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(color: AppColors.grey100),
            CustomPaint(
              painter: _GridPainter(),
              child: const SizedBox.expand(),
            ),
            if (widget.showRoute)
              AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  final progress = widget.riderProgress ?? _controller.value;
                  return CustomPaint(
                    painter: _RoutePainter(
                      progress: widget.animateRider ? progress : 1,
                      showMarker: widget.animateRider,
                    ),
                    child: const SizedBox.expand(),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.grey200
      ..strokeWidth = 1;
    const step = 28.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RoutePainter extends CustomPainter {
  _RoutePainter({required this.progress, required this.showMarker});

  final double progress;
  final bool showMarker;

  @override
  void paint(Canvas canvas, Size size) {
    final start = Offset(size.width * 0.18, size.height * 0.78);
    final end = Offset(size.width * 0.8, size.height * 0.22);
    final control = Offset(size.width * 0.75, size.height * 0.75);

    final path = Path()
      ..moveTo(start.dx, start.dy)
      ..quadraticBezierTo(control.dx, control.dy, end.dx, end.dy);

    final routePaint = Paint()
      ..color = AppColors.black
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, routePaint);

    _drawPin(canvas, start, filled: true);
    _drawPin(canvas, end, filled: false);

    if (showMarker) {
      final pos = _pointOnQuadratic(start, control, end, progress);
      canvas.drawCircle(pos, 9, Paint()..color = AppColors.white);
      canvas.drawCircle(
        pos,
        9,
        Paint()
          ..color = AppColors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
      canvas.drawCircle(pos, 4, Paint()..color = AppColors.black);
    }
  }

  Offset _pointOnQuadratic(Offset p0, Offset p1, Offset p2, double t) {
    final x =
        math.pow(1 - t, 2) * p0.dx +
        2 * (1 - t) * t * p1.dx +
        math.pow(t, 2) * p2.dx;
    final y =
        math.pow(1 - t, 2) * p0.dy +
        2 * (1 - t) * t * p1.dy +
        math.pow(t, 2) * p2.dy;
    return Offset(x.toDouble(), y.toDouble());
  }

  void _drawPin(Canvas canvas, Offset center, {required bool filled}) {
    canvas.drawCircle(
      center,
      7,
      Paint()..color = filled ? AppColors.black : AppColors.white,
    );
    canvas.drawCircle(
      center,
      7,
      Paint()
        ..color = AppColors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(covariant _RoutePainter oldDelegate) =>
      oldDelegate.progress != progress;
}
