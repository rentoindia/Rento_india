import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'map_preview.dart';

/// Wraps [MapPreview] with the zoom controls / address pill / Locate
/// button chrome from the reference screen. Marker position responds to
/// [onLocate] with a short bounce so it reads as "moved to your
/// location" without a real maps SDK wired in yet.
class ReceiverMapCard extends StatefulWidget {
  const ReceiverMapCard({
    super.key,
    required this.addressLabel,
    this.height = 230,
    this.onLocate,
  });

  final String addressLabel;
  final double height;
  final VoidCallback? onLocate;

  @override
  State<ReceiverMapCard> createState() => _ReceiverMapCardState();
}

class _ReceiverMapCardState extends State<ReceiverMapCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bounce = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 240),
  );
  double _zoom = 1.0;

  @override
  void dispose() {
    _bounce.dispose();
    super.dispose();
  }

  void _locate() {
    _bounce.forward(from: 0).then((_) => _bounce.reverse());
    widget.onLocate?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Transform.scale(
            scale: _zoom,
            child: MapPreview(height: widget.height, showRoute: false),
          ),
        ),
        Positioned(
          top: 14,
          right: 14,
          child: _ZoomControl(
            onZoomIn: () =>
                setState(() => _zoom = (_zoom + 0.1).clamp(1.0, 1.6)),
            onZoomOut: () =>
                setState(() => _zoom = (_zoom - 0.1).clamp(1.0, 1.6)),
          ),
        ),
        Center(
          child: AnimatedBuilder(
            animation: _bounce,
            builder: (context, child) {
              final lift =
                  -6 * (1 - (_bounce.value - 0.5).abs() * 2).clamp(0.0, 1.0);
              return Transform.translate(offset: Offset(0, lift), child: child);
            },
            child: const Icon(
              Icons.location_on,
              size: 34,
              color: AppColors.black,
            ),
          ),
        ),
        Positioned(
          left: 12,
          right: 12,
          bottom: 12,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 14,
                        color: AppColors.accentGreen,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          widget.addressLabel,
                          style: AppTextStyles.captionStrong,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _LocateButton(onTap: _locate),
            ],
          ),
        ),
      ],
    );
  }
}

class _ZoomControl extends StatelessWidget {
  const _ZoomControl({required this.onZoomIn, required this.onZoomOut});
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _ZoomButton(icon: Icons.add, onTap: onZoomIn),
          Container(height: 1, width: 28, color: AppColors.divider),
          _ZoomButton(icon: Icons.remove, onTap: onZoomOut),
        ],
      ),
    );
  }
}

class _ZoomButton extends StatelessWidget {
  const _ZoomButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 32,
        width: 32,
        child: Icon(icon, size: 16, color: AppColors.black),
      ),
    );
  }
}

class _LocateButton extends StatefulWidget {
  const _LocateButton({required this.onTap});
  final VoidCallback onTap;

  @override
  State<_LocateButton> createState() => _LocateButtonState();
}

class _LocateButtonState extends State<_LocateButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          decoration: BoxDecoration(
            color: AppColors.accentGreen,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppColors.accentGreen.withValues(
                  alpha: _hovered ? 0.45 : 0.25,
                ),
                blurRadius: _hovered ? 14 : 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.my_location, size: 14, color: AppColors.white),
              SizedBox(width: 6),
              Text(
                'Locate',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
