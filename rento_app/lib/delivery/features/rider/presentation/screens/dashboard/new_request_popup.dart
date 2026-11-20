import 'dart:async';
import 'package:flutter/material.dart';
//import '../../../../../core/constants/app_colors.dart';
import 'package:rento_india/delivery/core/constants/app_colors.dart';
/// Incoming delivery request popup — shown as a non-dismissible
/// bottom sheet from GoOnlineScreen. Auto-declines if the rider
/// doesn't respond within [totalSeconds].
class NewRequestPopup extends StatefulWidget {
  final String itemName;
  final String category;
  final double distanceKm;
  final String pickupLabel;
  final String pickupAddress;
  final String dropLabel;
  final String dropAddress;
  final int estimatedMinutes;
  final double earnings;
  final VoidCallback onAccept;
  final VoidCallback onDecline;
  final int totalSeconds;

  /// Product thumbnail — path under assets/images/products/... Falls
  /// back to a placeholder icon when null/empty, same as the Requests
  /// tab cards and the trip screens.
  final String? imageAsset;

  /// When true, this renders as a "Return Pickup Request" instead of a
  /// normal delivery request: the rider goes to the CUSTOMER first to
  /// collect the rented item back, then to the VENDOR to hand it in.
  final bool isReturnRequest;

  const NewRequestPopup({
    super.key,
    required this.itemName,
    required this.category,
    required this.distanceKm,
    required this.pickupLabel,
    required this.pickupAddress,
    required this.dropLabel,
    required this.dropAddress,
    required this.estimatedMinutes,
    required this.earnings,
    required this.onAccept,
    required this.onDecline,
    this.totalSeconds = 60,
    this.imageAsset,
    this.isReturnRequest = false,
  });

  @override
  State<NewRequestPopup> createState() => _NewRequestPopupState();
}

class _NewRequestPopupState extends State<NewRequestPopup> {
  late int _secondsLeft = widget.totalSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_secondsLeft <= 1) {
        _timer?.cancel();
        widget.onDecline(); // auto-decline when time runs out
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _handleAccept() {
    _timer?.cancel();
    widget.onAccept();
  }

  void _handleDecline() {
    _timer?.cancel();
    widget.onDecline();
  }

  @override
  Widget build(BuildContext context) {
    final totalDistance =
        widget.distanceKm + 5.4; // TODO: real total-trip distance from backend
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: Container(
        color: AppColors.pureWhite,
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            const SizedBox(height: 18),
            _buildItemCard(),
            const SizedBox(height: 16),
            if (widget.isReturnRequest) ...[
              _buildLocationBlock(
                icon: Icons.location_on_outlined,
                label: 'COLLECT RETURN FROM',
                title: widget.dropLabel,
                subtitle: widget.dropAddress,
              ),
              const SizedBox(height: 10),
              _buildLocationBlock(
                icon: Icons.storefront_outlined,
                label: 'RETURN TO',
                title: widget.pickupLabel,
                subtitle: widget.pickupAddress,
              ),
            ] else ...[
              _buildLocationBlock(
                icon: Icons.storefront_outlined,
                label: 'PICKUP FROM',
                title: widget.pickupLabel,
                subtitle: widget.pickupAddress,
              ),
              const SizedBox(height: 10),
              _buildLocationBlock(
                icon: Icons.location_on_outlined,
                label: 'DELIVER TO',
                title: widget.dropLabel,
                subtitle: widget.dropAddress,
              ),
            ],
            const SizedBox(height: 16),
            _buildTripStatsRow(totalDistance),
            const SizedBox(height: 12),
            _buildNoteBox(),
            const SizedBox(height: 20),
            _SwipeToActionBar(
              onAccept: _handleAccept,
              onDecline: _handleDecline,
            ),
            const SizedBox(height: 8),
            const Text(
              'Slide right to accept · Slide left to decline',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: AppColors.textHint),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final progress = _secondsLeft / widget.totalSeconds;
    return Row(
      children: [
        SizedBox(
          width: 46,
          height: 46,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 46,
                height: 46,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 3.5,
                  backgroundColor: AppColors.divider,
                  valueColor: const AlwaysStoppedAnimation(
                    AppColors.accentLime,
                  ),
                ),
              ),
              Text(
                '$_secondsLeft',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.isReturnRequest
                    ? 'New Return Pickup Request!'
                    : 'New Delivery Request!',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                'Accept within $_secondsLeft seconds',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildItemCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(10),
            ),
            child: (widget.imageAsset != null && widget.imageAsset!.isNotEmpty)
                ? Image.asset(
                    widget.imageAsset!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.inventory_2_outlined,
                      color: AppColors.textHint,
                    ),
                  )
                : const Icon(
                    Icons.inventory_2_outlined,
                    color: AppColors.textHint,
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: widget.isReturnRequest
                        ? const Color(0xFFB8860B)
                        : AppColors.pureBlack,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.isReturnRequest ? 'RETURN PICKUP' : 'RENTAL PRODUCT',
                    style: const TextStyle(
                      fontSize: 9,
                      color: AppColors.pureWhite,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.itemName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  widget.category,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const Text(
                  'Qty: 1', // TODO: pull real qty from TripRequestModel
                  style: TextStyle(fontSize: 11, color: AppColors.textHint),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationBlock({
    required IconData icon,
    required String label,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.inputFill,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: AppColors.textSecondary),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  letterSpacing: 0.5,
                  color: AppColors.textHint,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTripStatsRow(double totalDistance) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.divider),
          bottom: BorderSide(color: AppColors.divider),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _StatItem(
              label: 'Total Distance',
              value: '${totalDistance.toStringAsFixed(1)} km',
            ),
          ),
          Expanded(
            child: _StatItem(
              label: 'Estimated Time',
              value: '${widget.estimatedMinutes} mins',
            ),
          ),
          Expanded(
            child: _StatItem(
              label: 'Your Earnings',
              value: '₹${widget.earnings.toStringAsFixed(2)}',
              highlight: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteBox() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            size: 14,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              widget.isReturnRequest
                  ? 'Please collect the rented product from the customer and return it safely to the vendor.'
                  : 'Please collect the product from vendor and deliver safely to customer.',
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;

  const _StatItem({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: highlight ? AppColors.success : AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

/// A real horizontal swipe track: drag the thumb right past the
/// threshold to accept, left past the threshold to decline. Releasing
/// before the threshold snaps the thumb back to center.
class _SwipeToActionBar extends StatefulWidget {
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const _SwipeToActionBar({required this.onAccept, required this.onDecline});

  @override
  State<_SwipeToActionBar> createState() => _SwipeToActionBarState();
}

class _SwipeToActionBarState extends State<_SwipeToActionBar> {
  static const double _trackHeight = 64;
  static const double _thumbSize = 52;
  static const double _triggerThreshold = 70; // px of drag needed to fire

  double _dragDx = 0;
  bool _dragging = false;
  bool _resolved = false; // locks the thumb once an action has fired

  void _onDragStart(DragStartDetails details) {
    if (_resolved) return;
    setState(() => _dragging = true);
  }

  void _onDragUpdate(DragUpdateDetails details, double maxDrag) {
    if (_resolved) return;
    setState(() {
      _dragDx = (_dragDx + details.delta.dx).clamp(-maxDrag, maxDrag);
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (_resolved) return;
    setState(() => _dragging = false);

    if (_dragDx <= -_triggerThreshold) {
      setState(() => _resolved = true);
      widget.onDecline();
    } else if (_dragDx >= _triggerThreshold) {
      setState(() => _resolved = true);
      widget.onAccept();
    } else {
      // Didn't drag far enough — snap back to center.
      setState(() => _dragDx = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final trackWidth = constraints.maxWidth;
        final maxDrag = (trackWidth - _thumbSize) / 2;
        final declineProgress = (-_dragDx / _triggerThreshold).clamp(0.0, 1.0);
        final acceptProgress = (_dragDx / _triggerThreshold).clamp(0.0, 1.0);

        return Container(
          height: _trackHeight,
          decoration: BoxDecoration(
            color: AppColors.inputFill,
            borderRadius: BorderRadius.circular(_trackHeight / 2),
          ),
          child: Stack(
            children: [
              // DECLINE label — left side, brightens as you drag left.
              Positioned(
                left: 22,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Opacity(
                    opacity: 0.35 + declineProgress * 0.65,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.close, size: 15, color: AppColors.error),
                        SizedBox(width: 4),
                        Text(
                          'DECLINE',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.error,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // ACCEPT label — right side, brightens as you drag right.
              Positioned(
                right: 22,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Opacity(
                    opacity: 0.35 + acceptProgress * 0.65,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'ACCEPT',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.success,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.check, size: 15, color: AppColors.success),
                      ],
                    ),
                  ),
                ),
              ),
              // Draggable thumb, centered by default.
              AnimatedPositioned(
                duration: _dragging
                    ? Duration.zero
                    : const Duration(milliseconds: 220),
                curve: Curves.easeOut,
                left: (trackWidth - _thumbSize) / 2 + _dragDx,
                top: (_trackHeight - _thumbSize) / 2,
                child: GestureDetector(
                  onHorizontalDragStart: _onDragStart,
                  onHorizontalDragUpdate: (d) => _onDragUpdate(d, maxDrag),
                  onHorizontalDragEnd: _onDragEnd,
                  child: Container(
                    width: _thumbSize,
                    height: _thumbSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _dragDx < 0
                          ? Color.lerp(
                              AppColors.pureBlack,
                              AppColors.error,
                              declineProgress,
                            )
                          : Color.lerp(
                              AppColors.pureBlack,
                              AppColors.success,
                              acceptProgress,
                            ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      _dragDx < 0
                          ? Icons.close
                          : (_dragDx > 0 ? Icons.check : Icons.swap_horiz),
                      color: AppColors.pureWhite,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
