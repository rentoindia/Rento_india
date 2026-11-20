import '../../../../../../core/api_client.dart';
import 'package:rento_india/delivery/core/rider_api.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rento_india/delivery/core/constants/app_colors.dart';

import '../../../providers/rider_status_provider.dart';
import '../../../providers/rider_tab_provider.dart';
import '../../../providers/available_requests_provider.dart';
import '../../../data/models/trip_request_model.dart';
import 'new_request_popup.dart';
import '../notifications/notifications_screen.dart';
import '../trips/trip_navigation_screen.dart';

class AvailableRequestsScreen extends ConsumerStatefulWidget {
  const AvailableRequestsScreen({super.key});

  @override
  ConsumerState<AvailableRequestsScreen> createState() =>
      _AvailableRequestsScreenState();
}

class _AvailableRequestsScreenState
    extends ConsumerState<AvailableRequestsScreen>
    with TickerProviderStateMixin {
  final _listKey = GlobalKey<AnimatedListState>();
  late final AnimationController _entranceController;
  List<TripRequestModel> _previousRequests = const [];

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isOnline = ref.watch(riderStatusProvider).isOnline;

    ref.listen<List<TripRequestModel>>(availableRequestsProvider, (
      previous,
      next,
    ) {
      if (previous == null || previous.isEmpty) return;
      for (var i = 0; i < next.length; i++) {
        final isNew = previous.every((r) => r.id != next[i].id);
        if (isNew) {
          _listKey.currentState?.insertItem(
            i,
            duration: const Duration(milliseconds: 350),
          );
        }
      }
    });

    final requests = ref.watch(availableRequestsProvider);
    _previousRequests = requests;

    return Scaffold(
      backgroundColor: AppColors.pureBlack,
      body: Column(
        children: [
          SafeArea(bottom: false, child: _buildDarkHeader(context)),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF4F4F4),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: !isOnline
                  ? _buildOfflineState()
                  : requests.isEmpty
                  ? _buildEmptyState()
                  : Column(
                      children: [
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                          child: _buildHeader(requests.length),
                        ),
                        Expanded(
                          child: AnimatedList(
                            key: _listKey,
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                            initialItemCount: requests.length,
                            itemBuilder: (context, index, animation) {
                              final req = requests[index];
                              return _StaggeredEntrance(
                                controller: _entranceController,
                                index: index,
                                total: requests.length,
                                child: _buildAnimatedCard(req, animation),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDarkHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 16, 20),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.pureWhite),
            onPressed: () => ref.read(riderTabIndexProvider.notifier).state = 0,
          ),
          const SizedBox(width: 4),
          const Text(
            'Requests',
            style: TextStyle(
              color: AppColors.pureWhite,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_none,
                  color: AppColors.pureWhite,
                ),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const NotificationsScreen(),
                  ),
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 15,
                    minHeight: 15,
                  ),
                  child: const Text(
                    '3',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 9),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedCard(TripRequestModel req, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(parent: animation, curve: Curves.easeOut),
      child: FadeTransition(
        opacity: animation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _RequestCard(
            request: req,
            onViewRequest: () => _openRequestPopup(req),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(int count) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Today's Pending\nRequests",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            height: 1.15,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '$count',
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
                height: 1,
              ),
            ),
            const SizedBox(width: 8),
            const Padding(
              padding: EdgeInsets.only(bottom: 6),
              child: Text(
                'new requests near you',
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOfflineState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off, size: 48, color: AppColors.textHint),
            const SizedBox(height: 16),
            const Text(
              "You're Offline",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Go online to see and accept nearby delivery requests.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () =>
                  ref.read(riderStatusProvider.notifier).goOnline(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.pureBlack,
                foregroundColor: AppColors.pureWhite,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text('Go Online'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.hourglass_empty, size: 48, color: AppColors.textHint),
            SizedBox(height: 16),
            Text(
              'No requests right now',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "We'll notify you the moment a new delivery request comes in.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  void _openRequestPopup(TripRequestModel req) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      builder: (_) => NewRequestPopup(
        itemName: req.itemName,
        category: req.category,
        distanceKm: req.distanceKm,
        pickupLabel: req.pickupLabel,
        pickupAddress: req.pickupAddress,
        dropLabel: req.dropLabel,
        dropAddress: req.dropAddress,
        estimatedMinutes: req.estimatedMinutes,
        earnings: req.earnings,
        imageAsset: req.imageAsset,
        isReturnRequest: req.isReturnPickup,
        onAccept: () {
          Navigator.pop(context);
          _resolveRequest(req, accepted: true);
        },
        onDecline: () {
          Navigator.pop(context);
          _resolveRequest(req, accepted: false);
        },
      ),
    );
  }

  Future<void> _resolveRequest(
    TripRequestModel req, {
    required bool accepted,
  }) async {
    if (accepted) {
      try {
        await RiderApi.instance.accept('TRIP', req.id);
      } on ApiException catch (e) {
        if (!mounted) return;
        ref.read(availableRequestsProvider.notifier).remove(req.id);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
        return;
      }
      if (!mounted) return;
    }
    final index = _previousRequests.indexOf(req);

    ref.read(availableRequestsProvider.notifier).remove(req.id);

    if (index != -1) {
      _listKey.currentState?.removeItem(
        index,
        (context, animation) => _buildAnimatedCard(req, animation),
        duration: const Duration(milliseconds: 300),
      );
    }

    _showResultDialog(
      accepted: accepted,
      itemName: req.itemName,
      onDismissed: accepted
          ? () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => req.isReturnPickup
                    ? TripNavigationScreen(
                        request: req,
                        stage: NavigationStage.returnToCustomer,
                      )
                    : NavigateToVendorScreen(request: req),
              ),
            )
          : null,
    );
  }

  void _showResultDialog({
    required bool accepted,
    required String itemName,
    VoidCallback? onDismissed,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'result',
      barrierColor: Colors.black.withValues(alpha: 0.35),
      transitionDuration: const Duration(milliseconds: 320),
      pageBuilder: (context, animation, secondaryAnimation) {
        Future.delayed(const Duration(milliseconds: 1400), () {
          if (Navigator.of(context).canPop()) Navigator.of(context).pop();
        });
        return _ResultDialog(accepted: accepted, itemName: itemName);
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        );
        return Opacity(
          opacity: animation.value.clamp(0.0, 1.0),
          child: Transform.scale(scale: curved.value, child: child),
        );
      },
    ).then((_) {
      if (mounted) onDismissed?.call();
    });
  }
}

class _StaggeredEntrance extends StatelessWidget {
  final AnimationController controller;
  final int index;
  final int total;
  final Widget child;

  const _StaggeredEntrance({
    required this.controller,
    required this.index,
    required this.total,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final safeTotal = total == 0 ? 1 : total;
    final start = (index / safeTotal) * 0.6;
    final end = start + 0.4;
    final curved = CurvedAnimation(
      parent: controller,
      curve: Interval(
        start.clamp(0.0, 1.0),
        end.clamp(0.0, 1.0),
        curve: Curves.easeOutCubic,
      ),
    );

    return AnimatedBuilder(
      animation: curved,
      builder: (context, _) {
        return Opacity(
          opacity: curved.value,
          child: Transform.translate(
            offset: Offset(0, (1 - curved.value) * 24),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

class _ResultDialog extends StatelessWidget {
  final bool accepted;
  final String itemName;

  const _ResultDialog({required this.accepted, required this.itemName});

  @override
  Widget build(BuildContext context) {
    final color = accepted ? AppColors.success : const Color(0xFFE0433A);
    final icon = accepted ? Icons.check_rounded : Icons.close_rounded;
    final title = accepted ? 'Request Accepted!' : 'Request Declined';
    final subtitle = accepted
        ? 'Head to pickup for "$itemName" — it\'s now in your Trips.'
        : '"$itemName" has been passed to another rider.';

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
          decoration: BoxDecoration(
            color: AppColors.pureWhite,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 450),
                curve: Curves.elasticOut,
                builder: (context, value, child) =>
                    Transform.scale(scale: value, child: child),
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 34),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12.5,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RequestCard extends StatefulWidget {
  final TripRequestModel request;
  final VoidCallback onViewRequest;

  const _RequestCard({required this.request, required this.onViewRequest});

  @override
  State<_RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<_RequestCard> {
  bool _pressed = false;

  Color get _statusColor {
    switch (widget.request.status) {
      case 'URGENT':
        return const Color(0xFFE0433A);
      case 'SCHEDULED':
        return AppColors.textSecondary;
      case 'ACTIVE NOW':
      default:
        return AppColors.success;
    }
  }

  @override
  Widget build(BuildContext context) {
    final req = widget.request;
    final isActive = req.status == 'ACTIVE NOW';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (isActive)
                    _PulsingDot(color: _statusColor)
                  else
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  const SizedBox(width: 6),
                  Text(
                    req.status,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                      color: _statusColor,
                    ),
                  ),
                ],
              ),
              Text(
                '\u20b9${req.earnings.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 64,
                  height: 64,
                  color: AppColors.inputFill,
                  child: req.imageAsset != null
                      ? Image.asset(req.imageAsset!, fit: BoxFit.cover)
                      : const Icon(
                          Icons.inventory_2_outlined,
                          color: AppColors.textHint,
                        ),
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
                        color: AppColors.inputFill,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        req.category.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            req.itemName,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        if (req.isReturnPickup)
                          Container(
                            margin: const EdgeInsets.only(left: 6),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF3D6),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'RETURN PICKUP',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.3,
                                color: Color(0xFFB8860B),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${req.estimatedMinutes} mins \u2022 ${req.distanceKm.toStringAsFixed(1)} km away',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (req.isReturnPickup) ...[
            _InfoRow(
              icon: Icons.radio_button_unchecked,
              label: 'COLLECT FROM',
              value: req.dropLabel,
            ),
            const SizedBox(height: 10),
            _InfoRow(
              icon: Icons.storefront_outlined,
              label: 'RETURN TO',
              value: req.pickupLabel,
            ),
          ] else ...[
            _InfoRow(
              icon: Icons.radio_button_unchecked,
              label: 'PICKUP',
              value: req.pickupLabel,
            ),
            const SizedBox(height: 10),
            _InfoRow(
              icon: Icons.location_on_outlined,
              label: 'DELIVERY',
              value: req.dropLabel,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, size: 13, color: Color(0xFFF5A623)),
                  const SizedBox(width: 2),
                  Text(
                    req.rating.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (req.showTripMap) ...[
            const SizedBox(height: 14),
            const _TripMapPreview(),
          ],
          const SizedBox(height: 16),
          GestureDetector(
            onTapDown: (_) => setState(() => _pressed = true),
            onTapUp: (_) => setState(() => _pressed = false),
            onTapCancel: () => setState(() => _pressed = false),
            onTap: widget.onViewRequest,
            child: AnimatedScale(
              scale: _pressed ? 0.97 : 1.0,
              duration: const Duration(milliseconds: 100),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.pureBlack,
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'View Request',
                  style: TextStyle(
                    color: AppColors.pureWhite,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Widget? trailing;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.textHint),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                  color: AppColors.textHint,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

class _PulsingDot extends StatefulWidget {
  final Color color;
  const _PulsingDot({required this.color});

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween(
        begin: 1.0,
        end: 0.35,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle),
      ),
    );
  }
}

class _TripMapPreview extends StatelessWidget {
  const _TripMapPreview();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 90,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE9ECEE), Color(0xFFDCE1E4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            CustomPaint(size: Size.infinite, painter: _MapGridPainter()),
            const Positioned(
              left: 10,
              top: 8,
              child: Text(
                'Trip Map',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.5)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 22) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 22) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    final routePaint = Paint()
      ..color = AppColors.pureBlack.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    final path = Path()
      ..moveTo(size.width * 0.1, size.height * 0.75)
      ..quadraticBezierTo(
        size.width * 0.4,
        size.height * 0.2,
        size.width * 0.9,
        size.height * 0.3,
      );
    canvas.drawPath(path, routePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
