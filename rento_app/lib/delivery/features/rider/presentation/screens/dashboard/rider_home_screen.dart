import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:rento_india/delivery/core/constants/app_colors.dart';

import '../../../data/models/trip_request_model.dart';
import '../../../data/models/trip_record_model.dart';
import '../../../providers/rider_status_provider.dart';
import '../../../providers/rider_tab_provider.dart';
import '../../../providers/available_requests_provider.dart';
import '../trips/trip_navigation_screen.dart';
import '../trips/trip_details_screen.dart';
import '../../../../../core/routes/route_names.dart';

import 'package:rento_india/delivery/core/routes/app_router.dart';

class RiderHomeScreen extends ConsumerStatefulWidget {
  const RiderHomeScreen({super.key});

  @override
  ConsumerState<RiderHomeScreen> createState() => _RiderHomeScreenState();
}

class _RiderHomeScreenState extends ConsumerState<RiderHomeScreen>
    with TickerProviderStateMixin {
  late final AnimationController _entrance;
  late final AnimationController _pulse;

  bool _hasActiveDelivery = true;

  static const String _riderName = 'Rahul Kumar';
  static const String _riderFirstName = 'Rahul';

  static const double _todaysEarnings = 1850;
  static const double _walletBalance = 3420;

  static const int _pendingCount = 5;
  static const int _completedToday = 18;
  static const String _hoursOnlineLabel = '6.5h';
  static const String _hoursOnlineSince = 'Since 8:30 AM';
  static const int _activeOrders = 1;

  static const double _distanceTraveledKm = 42;
  static const String _onlineTimeLabel = '6h 32m';
  static const double _totalEarningsInclBonus = 1850;
  static const int _returnTripsToday = 4;

  static const double _completionRate = 0.98;
  static const double _rating = 4.9;
  static const int _totalDeliveries = 248;
  static const double _successRate = 0.96;

  static const int _dailyGoal = 20;
  static const int _goalCompleted = 14;

  static const double _deliveryProgress = 0.45;

  static const TripRequestModel _activeRequest = TripRequestModel(
    id: 'active-1',
    itemName: 'Laptop Rental',
    category: 'Order #RNT-2847',
    distanceKm: 8.2,
    pickupLabel: 'Anna Nagar',
    pickupAddress: 'Anna Nagar, Chennai',
    dropLabel: 'Velachery',
    dropAddress: 'Velachery, Chennai',
    estimatedMinutes: 18,
    earnings: 220,
    status: 'ACTIVE NOW',
    rating: 4.9,
    imageAsset: 'assets/images/rental/products/laptop.png',
  );

  @override
  void initState() {
    super.initState();
    _entrance = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    )..forward();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _entrance.dispose();
    _pulse.dispose();
    super.dispose();
  }

  void _goToTab(int index) =>
      ref.read(riderTabIndexProvider.notifier).state = index;

  Future<void> _launchCall(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone.replaceAll(' ', ''));
    final ok = await launchUrl(uri);
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the dialer')),
      );
    }
  }

  void _navigateActiveDelivery() {
    if (!_hasActiveDelivery) {
      _showNoActiveTripSnack();
      return;
    }
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (_, anim, __) => _activeRequest.isReturnPickup
            ? TripNavigationScreen(
                request: _activeRequest,
                stage: NavigationStage.returnToCustomer,
              )
            : NavigateToVendorScreen(request: _activeRequest),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  void _callActiveDelivery() {
    if (!_hasActiveDelivery) {
      _showNoActiveTripSnack();
      return;
    }
    _launchCall('+91 98765 43210');
  }

  void _openActiveDeliveryDetails() {
    if (!_hasActiveDelivery) {
      _showNoActiveTripSnack();
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TripDetailsScreen(
          trip: const TripRecord(
            orderId: '#RNT-2847',
            statusValue: TripStatus.ongoing,
            time: 'Now',
            sortKey: 0,
            pickupName: 'ABC Electronics',
            pickupAddress: 'Anna Nagar, Chennai',
            pickupPhone: '+91 98765 43210',
            dropName: 'Customer',
            dropAddress: 'Velachery, Chennai',
            dropPhone: '+91 91234 56789',
            distanceKm: 8.2,
            estimatedMinutes: 18,
            serviceType: 'Standard',
            packageName: 'Laptop Rental',
            packageTags: ['Electronics'],
            packageQty: 1,
            otpVerified: false,
            baseFare: 220,
          ),
        ),
      ),
    );
  }

  void _scanQr() {
    if (!_hasActiveDelivery) {
      _showNoActiveTripSnack();
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('QR scanning — coming soon')));
  }

  void _showNoActiveTripSnack() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No active delivery right now')),
    );
  }

  void _showEmergencySheet() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        icon: const Icon(
          Icons.emergency_outlined,
          color: AppColors.error,
          size: 32,
        ),
        title: const Text('Emergency SOS'),
        content: const Text(
          'This will alert Rento India support and share your live location. '
          'Use only in a genuine emergency.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: AppColors.pureWhite,
            ),
            onPressed: () {
              Navigator.pop(context);
              _launchCall('112');
            },
            child: const Text('Call Emergency'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(riderStatusProvider);
    final isOnline = status.isOnline;
    final nearbyCount = ref.watch(availableRequestsProvider).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      drawer: _buildDrawer(context),
      appBar: _buildAppBar(context),
      floatingActionButton: _EmergencyFab(onTap: _showEmergencySheet),
      body: SafeArea(
        top: false,
        child: RefreshIndicator(
          color: AppColors.pureBlack,
          onRefresh: () => Future.delayed(const Duration(milliseconds: 700)),
          child: FadeTransition(
            opacity: _entrance,
            child: SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(0, 0.03),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _entrance,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildGreeting(),
                    const SizedBox(height: 16),
                    _buildOnlineStatusCard(isOnline, nearbyCount),
                    const SizedBox(height: 18),
                    _buildEarningsCard(),
                    const SizedBox(height: 22),
                    const _SectionLabel('DELIVERY STATISTICS'),
                    const SizedBox(height: 10),
                    _buildDeliveryStatsGrid(),
                    const SizedBox(height: 22),
                    const _SectionLabel("TODAY'S OVERVIEW"),
                    const SizedBox(height: 10),
                    _buildTodaysOverviewGrid(),
                    const SizedBox(height: 22),
                    const _SectionLabel('ACTIVE DELIVERY'),
                    const SizedBox(height: 10),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: _hasActiveDelivery
                          ? KeyedSubtree(
                              key: const ValueKey('active-card'),
                              child: _buildActiveDeliveryCard(),
                            )
                          : KeyedSubtree(
                              key: const ValueKey('no-active-card'),
                              child: _buildNoActiveDeliveryCard(),
                            ),
                    ),
                    const SizedBox(height: 22),
                    const _SectionLabel("TODAY'S PERFORMANCE"),
                    const SizedBox(height: 10),
                    _buildPerformanceCard(),
                    const SizedBox(height: 22),
                    const _SectionLabel('QUICK ACTIONS'),
                    const SizedBox(height: 10),
                    _buildQuickActions(),
                    const SizedBox(height: 22),
                    const _SectionLabel('DAILY GOAL'),
                    const SizedBox(height: 10),
                    _buildDailyGoalCard(),
                    const SizedBox(height: 22),
                    _buildRecentActivity(),
                    const SizedBox(height: 22),
                    const _SectionLabel('ACHIEVEMENTS'),
                    const SizedBox(height: 10),
                    _buildAchievements(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF4F4F4),
      elevation: 0,
      leading: Builder(
        builder: (ctx) => IconButton(
          icon: const Icon(Icons.menu, color: AppColors.textPrimary),
          onPressed: () => Scaffold.of(ctx).openDrawer(),
        ),
      ),
      title: _buildBrandBadge(),
      centerTitle: true,
      actions: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              icon: const Icon(
                Icons.notifications_none,
                color: AppColors.textPrimary,
              ),
              onPressed: () => _goToTab(5),
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
                constraints: const BoxConstraints(minWidth: 15, minHeight: 15),
                child: const Text(
                  '3',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 9),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 14, left: 4),
          child: _HoverPress(
            onTap: () => Scaffold.of(context).openDrawer(),
            borderRadius: 20,
            child: const CircleAvatar(
              radius: 17,
              backgroundColor: AppColors.pureBlack,
              child: Text(
                'RK',
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBrandBadge() {
    return const _BrandCapsule();
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.pureWhite,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 26,
                    backgroundColor: AppColors.pureBlack,
                    child: Text(
                      'RK',
                      style: TextStyle(
                        color: AppColors.pureWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          _riderName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          'Rento India Rider',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textHint,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.divider),
            const SizedBox(height: 6),
            _drawerTile(
              context,
              icon: Icons.home_outlined,
              label: 'Home',
              onTap: () => Navigator.pop(context),
            ),
            _drawerTile(
              context,
              icon: Icons.directions_bike_outlined,
              label: 'Trips',
              onTap: () {
                Navigator.pop(context);
                _goToTab(2);
              },
            ),
            _drawerTile(
              context,
              icon: Icons.account_balance_wallet_outlined,
              label: 'Earnings',
              onTap: () {
                Navigator.pop(context);
                _goToTab(3);
              },
            ),
            _drawerTile(
              context,
              icon: Icons.notifications_none,
              label: 'Notifications',
              onTap: () {
                Navigator.pop(context);
                _goToTab(5);
              },
            ),
            _drawerTile(
              context,
              icon: Icons.person_outline,
              label: 'Profile',
              onTap: () {
                Navigator.pop(context);
                _goToTab(4);
              },
            ),
            const Spacer(),
            const Divider(height: 1, color: AppColors.divider),
            _drawerTile(
              context,
              icon: Icons.logout,
              label: 'Log Out',
              iconColor: AppColors.error,
              textColor: AppColors.error,
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteNames.mobileEntry,
                  (route) => false,
                );
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _drawerTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? AppColors.textSecondary),
      title: Text(
        label,
        style: TextStyle(
          color: textColor ?? AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildGreeting() {
    final now = DateTime.now();
    final hour = now.hour;
    final greeting = hour < 12
        ? 'Good Morning'
        : hour < 17
        ? 'Good Afternoon'
        : 'Good Evening';
    final emoji = hour < 12
        ? '👋'
        : hour < 17
        ? '☀️'
        : '🌙';

    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    final dateStr =
        '${weekdays[now.weekday - 1]}, ${now.day} ${months[now.month - 1]} ${now.year}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$greeting, $_riderFirstName $emoji',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Text(
          dateStr,
          style: const TextStyle(fontSize: 12, color: AppColors.textHint),
        ),
      ],
    );
  }

  Widget _buildOnlineStatusCard(bool isOnline, int nearbyCount) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isOnline
              ? [const Color(0xFF0D2818), const Color(0xFF102B1B)]
              : [AppColors.pureBlack, const Color(0xFF1C1C1C)],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AnimatedBuilder(
                animation: _pulse,
                builder: (_, child) {
                  final double scale = isOnline
                      ? 1.0 + (_pulse.value * 0.5)
                      : 1.0;
                  return Container(
                    width: 26,
                    height: 26,
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (isOnline)
                          Transform.scale(
                            scale: scale,
                            child: Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.success.withValues(
                                  alpha: (1.0 - _pulse.value) * 0.5,
                                ),
                              ),
                            ),
                          ),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isOnline
                                ? AppColors.success
                                : AppColors.pureWhite,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isOnline ? 'Online' : 'Offline',
                      style: const TextStyle(
                        color: AppColors.pureWhite,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isOnline
                          ? 'Ready to accept delivery requests'
                          : 'Go online to receive delivery requests',
                      style: const TextStyle(
                        color: AppColors.textHint,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _HoverPress(
                onTap: () async {
                  final err = await ref
                      .read(riderStatusProvider.notifier)
                      .toggle();
                  if (err != null && mounted) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(err)));
                  }
                },
                borderRadius: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.pureWhite,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isOnline ? 'Go Offline' : 'Go Online',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.5,
                      color: AppColors.pureBlack,
                    ),
                  ),
                ),
              ),
            ],
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: isOnline
                ? Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.bolt,
                          size: 15,
                          color: AppColors.accentLime,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            '$nearbyCount requests nearby',
                            style: const TextStyle(
                              color: AppColors.accentLime,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryStatsGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _StatTile(
                icon: Icons.inventory_2_outlined,
                iconBg: const Color(0xFFFFF7E6),
                iconColor: const Color(0xFFE0A100),
                value: '$_pendingCount',
                label: 'Pending',
                sublabel: 'Awaiting pickup',
                onTap: () => _goToTab(1),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _StatTile(
                icon: Icons.check_circle_outline,
                iconBg: AppColors.pureBlack,
                iconColor: AppColors.pureWhite,
                value: '$_completedToday',
                label: 'Completed',
                sublabel: 'Today',
                onTap: () => _goToTab(1),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _StatTile(
                icon: Icons.access_time,
                iconBg: const Color(0xFFEFF3FF),
                iconColor: const Color(0xFF3D6DF2),
                value: _hoursOnlineLabel,
                label: 'Hours Online',
                sublabel: _hoursOnlineSince,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _StatTile(
                icon: Icons.local_shipping_outlined,
                iconBg: const Color(0xFFEFFBF2),
                iconColor: const Color(0xFF1F9D55),
                value: '$_activeOrders',
                label: 'Active',
                sublabel: 'In progress now',
                onTap: () => _goToTab(1),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTodaysOverviewGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _StatTile(
                icon: Icons.route_outlined,
                iconBg: const Color(0xFFEFF3FF),
                iconColor: const Color(0xFF3D6DF2),
                value: '${_distanceTraveledKm.round()} km',
                label: 'Distance',
                sublabel: 'Traveled today',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _StatTile(
                icon: Icons.timer_outlined,
                iconBg: const Color(0xFFF3F0FF),
                iconColor: const Color(0xFF7C4DFF),
                value: _onlineTimeLabel,
                label: 'Online Time',
                sublabel: 'Active hours',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _StatTile(
                icon: Icons.account_balance_wallet_outlined,
                iconBg: const Color(0xFFEFFBF2),
                iconColor: const Color(0xFF1F9D55),
                value: _formatInr(_totalEarningsInclBonus),
                label: 'Total Earnings',
                sublabel: 'Including bonuses',
                onTap: () => _goToTab(3),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _StatTile(
                icon: Icons.swap_horiz,
                iconBg: const Color(0xFFFFF7E6),
                iconColor: const Color(0xFFE0A100),
                value: '$_returnTripsToday',
                label: 'Return Trips',
                sublabel: 'Completed',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNoActiveDeliveryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        border: Border.all(color: AppColors.divider),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.local_shipping_outlined,
            color: AppColors.textHint,
            size: 30,
          ),
          const SizedBox(height: 10),
          const Text(
            'No active delivery',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Go online to start receiving delivery requests.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveDeliveryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppColors.inputFill,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _activeRequest.imageAsset != null
                    ? Image.asset(
                        _activeRequest.imageAsset!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.laptop_mac,
                          color: AppColors.textSecondary,
                        ),
                      )
                    : const Icon(
                        Icons.laptop_mac,
                        color: AppColors.textSecondary,
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Laptop Rental',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Order #RNT-2847',
                      style: TextStyle(fontSize: 12, color: AppColors.textHint),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3D6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'IN PROGRESS',
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFB8860B),
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.storefront_outlined,
                size: 14,
                color: AppColors.textHint,
              ),
              const SizedBox(width: 4),
              const Text(
                'PICKUP',
                style: TextStyle(
                  fontSize: 9.5,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textHint,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(width: 4),
              const Flexible(
                child: Text(
                  'Anna Nagar',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Icon(
                  Icons.arrow_forward,
                  size: 12,
                  color: AppColors.textHint,
                ),
              ),
              const Icon(
                Icons.location_on_outlined,
                size: 14,
                color: AppColors.textHint,
              ),
              const SizedBox(width: 4),
              const Text(
                'DELIVERY',
                style: TextStyle(
                  fontSize: 9.5,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textHint,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(width: 4),
              const Flexible(
                child: Text(
                  'Velachery',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _MiniStat(value: '8.2 km', label: 'Distance'),
              ),
              Expanded(
                child: _MiniStat(value: '18 min', label: 'ETA'),
              ),
              Expanded(
                child: _MiniStat(value: '₹220', label: 'Earnings'),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Text(
                'Travelling to pickup',
                style: TextStyle(
                  fontSize: 11.5,
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              Text(
                '${(_deliveryProgress * 100).round()}%',
                style: const TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: _deliveryProgress),
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOutCubic,
              builder: (_, value, __) => LinearProgressIndicator(
                value: value,
                minHeight: 7,
                backgroundColor: AppColors.divider,
                valueColor: const AlwaysStoppedAnimation(AppColors.pureBlack),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _ActionPill(
                  icon: Icons.navigation_outlined,
                  label: 'Navigate',
                  filled: true,
                  onTap: _navigateActiveDelivery,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _ActionPill(
                  icon: Icons.call_outlined,
                  label: 'Call',
                  onTap: _callActiveDelivery,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _ActionPill(
                  icon: Icons.info_outline,
                  label: 'Details',
                  onTap: _openActiveDeliveryDetails,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        border: Border.all(color: AppColors.divider),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _DonutGauge(
                  value: _completionRate,
                  label: 'Completion',
                  centerText: '${(_completionRate * 100).round()}%',
                  color: const Color(0xFF1F9D55),
                ),
              ),
              Expanded(
                child: _DonutGauge(
                  value: _rating / 5,
                  label: 'Rating',
                  centerText: _rating.toStringAsFixed(1),
                  suffix: const Icon(
                    Icons.star,
                    size: 12,
                    color: Color(0xFFE0A100),
                  ),
                  color: const Color(0xFFE0A100),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Divider(height: 1, color: AppColors.divider),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _MiniStat(
                  value: '$_totalDeliveries',
                  label: 'Deliveries',
                  big: true,
                ),
              ),
              Expanded(
                child: _MiniStat(
                  value: '${(_successRate * 100).round()}%',
                  label: 'Success Rate',
                  big: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    final actions = <_QuickAction>[
      _QuickAction(
        Icons.qr_code_scanner,
        'Scan QR',
        const Color(0xFF7C4DFF),
        _scanQr,
      ),
      _QuickAction(
        Icons.call_outlined,
        'Call',
        const Color(0xFF1F9D55),
        _callActiveDelivery,
      ),
      _QuickAction(
        Icons.account_balance_wallet_outlined,
        'Wallet',
        const Color(0xFF00A6A6),
        () => _goToTab(3),
      ),
      _QuickAction(
        Icons.emergency_outlined,
        'Emergency',
        AppColors.error,
        _showEmergencySheet,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        const columns = 4;
        const spacing = 10.0;
        final itemWidth =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final action in actions)
              SizedBox(
                width: itemWidth,
                child: _QuickActionButton(action: action),
              ),
          ],
        );
      },
    );
  }

  Widget _buildEarningsCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.pureBlack,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "TODAY'S EARNINGS",
                      style: TextStyle(
                        color: AppColors.textHint,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: _todaysEarnings),
                      duration: const Duration(milliseconds: 900),
                      curve: Curves.easeOutCubic,
                      builder: (_, value, __) => Text(
                        _formatInr(value),
                        style: const TextStyle(
                          color: AppColors.pureWhite,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'WALLET BALANCE',
                    style: TextStyle(
                      color: AppColors.textHint,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatInr(_walletBalance),
                    style: const TextStyle(
                      color: AppColors.pureWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _EarningsBreakdownItem(
                  color: Color(0xFF4CD07A),
                  label: 'Trip Earnings',
                  value: '₹1,350',
                ),
              ),
              Expanded(
                child: _EarningsBreakdownItem(
                  color: Color(0xFFE0A100),
                  label: 'Bonuses',
                  value: '₹300',
                ),
              ),
              Expanded(
                child: _EarningsBreakdownItem(
                  color: Color(0xFF3D6DF2),
                  label: 'Returns',
                  value: '₹200',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: _HoverPress(
              onTap: () => _goToTab(3),
              borderRadius: 24,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 13),
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(24),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'View Full Earnings',
                      style: TextStyle(
                        color: AppColors.pureBlack,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.5,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(
                      Icons.arrow_forward,
                      size: 15,
                      color: AppColors.pureBlack,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    final items = <_ActivityPreview>[
      _ActivityPreview(
        Icons.inventory_2_outlined,
        const Color(0xFFB8860B),
        'Pickup Completed',
        'Dell Laptop · Anna Nagar',
        '10:10 AM',
      ),
      _ActivityPreview(
        Icons.check_circle_outline,
        const Color(0xFF1F9D55),
        'Delivery Completed',
        'Canon Camera · Adyar',
        '11:45 AM',
      ),
      _ActivityPreview(
        Icons.currency_rupee,
        const Color(0xFFE0A100),
        'Earnings Credited',
        '₹220 added to wallet',
        '1:05 PM',
      ),
      _ActivityPreview(
        Icons.account_balance_wallet_outlined,
        const Color(0xFF3D6DF2),
        'Wallet Updated',
        'Balance ₹3,420',
        '1:06 PM',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Activity',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            _HoverPress(
              onTap: () {},
              borderRadius: 8,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'See all',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        for (final item in items) ...[
          _ActivityTile(item: item, onTap: () {}),
          const SizedBox(height: 8),
        ],
      ],
    );
  }

  Widget _buildDailyGoalCard() {
    final progress = _goalCompleted / _dailyGoal;
    final remaining = _dailyGoal - _goalCompleted;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        border: Border.all(color: AppColors.divider),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '$_dailyGoal Deliveries Today',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFFBF2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${(progress * 100).round()}%',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F9D55),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            remaining > 0
                ? '$remaining more to reach your goal'
                : 'Goal reached! 🎉',
            style: const TextStyle(fontSize: 11.5, color: AppColors.textHint),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Completed',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: AppColors.textHint,
                      ),
                    ),
                    Text(
                      '$_goalCompleted',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Target',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: AppColors.textHint,
                      ),
                    ),
                    Text(
                      '$_dailyGoal',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: progress),
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOutCubic,
              builder: (_, value, __) => LinearProgressIndicator(
                value: value,
                minHeight: 8,
                backgroundColor: AppColors.divider,
                valueColor: const AlwaysStoppedAnimation(Color(0xFF1F9D55)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievements() {
    final badges = <(_IconOrEmoji, String, Color)>[
      (
        const _IconOrEmoji.icon(Icons.emoji_events),
        'Top Performer',
        const Color(0xFFE0A100),
      ),
      (
        const _IconOrEmoji.icon(Icons.star),
        '5-Star Rider',
        const Color(0xFFB8860B),
      ),
      (
        const _IconOrEmoji.icon(Icons.bolt),
        'Fast Rider',
        const Color(0xFF7C4DFF),
      ),
      (
        const _IconOrEmoji.icon(Icons.local_shipping),
        '500 Trips',
        const Color(0xFF3D6DF2),
      ),
    ];

    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: badges.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) {
          final (icon, label, color) = badges[i];
          return _AchievementBadge(icon: icon, label: label, color: color);
        },
      ),
    );
  }

  static String _formatInr(double value) {
    final s = value.round().toString();
    if (s.length <= 3) return '₹$s';

    final last3 = s.substring(s.length - 3);
    final rest = s.substring(0, s.length - 3);

    final groups = <String>[];
    var i = rest.length;
    while (i > 2) {
      groups.insert(0, rest.substring(i - 2, i));
      i -= 2;
    }
    if (i > 0) groups.insert(0, rest.substring(0, i));

    return '₹${groups.join(',')},$last3';
  }
}

class _BrandCapsule extends StatefulWidget {
  const _BrandCapsule();

  @override
  State<_BrandCapsule> createState() => _BrandCapsuleState();
}

class _BrandCapsuleState extends State<_BrandCapsule>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  static const double _radius = 28;
  static const double _height = 46;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _scale = Tween<double>(
      begin: 0.96,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: ScaleTransition(
        scale: _scale,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_radius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
            child: Container(
              height: _height,
              padding: const EdgeInsets.only(left: 16, right: 18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFCFFFFFF), // rgba(255,255,255,0.98)
                    Color(0xEBF6F6F6), // rgba(246,246,246,0.92)
                  ],
                ),
                borderRadius: BorderRadius.circular(_radius),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.8),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: _height * 0.42,
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(_radius),
                      ),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withValues(alpha: 0.85),
                              Colors.white.withValues(alpha: 0.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.white, Color(0xFFEDEDED)],
                          ),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.9),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.07),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/rental/rento_logo.png',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.local_shipping,
                            size: 18,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rento India',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16.5,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.2,
                                color: Color(0xFF111111),
                                height: 1.15,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Rider Dashboard',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF7A7A7A),
                                height: 1.1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.6,
        color: AppColors.textHint,
      ),
    );
  }
}

class _HoverPress extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double borderRadius;

  const _HoverPress({required this.child, this.onTap, this.borderRadius = 14});

  @override
  State<_HoverPress> createState() => _HoverPressState();
}

class _HoverPressState extends State<_HoverPress> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final scale = _pressed ? 0.96 : (_hovered ? 1.02 : 1.0);
    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 140),
          curve: Curves.easeOut,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String value;
  final String label;
  final String? sublabel;
  final VoidCallback? onTap;

  const _StatTile({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.value,
    required this.label,
    this.sublabel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _HoverPress(
      onTap: onTap,
      borderRadius: 16,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          border: Border.all(color: AppColors.divider),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
              child: Icon(icon, size: 16, color: iconColor),
            ),
            const SizedBox(height: 10),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                value,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11.5,
                color: AppColors.textSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (sublabel != null) ...[
              const SizedBox(height: 1),
              Text(
                sublabel!,
                style: const TextStyle(fontSize: 10, color: AppColors.textHint),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String value;
  final String label;
  final bool big;

  const _MiniStat({required this.value, required this.label, this.big = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            value,
            maxLines: 1,
            style: TextStyle(
              fontSize: big ? 20 : 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _ActionPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool filled;
  final VoidCallback onTap;

  const _ActionPill({
    required this.icon,
    required this.label,
    required this.onTap,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return _HoverPress(
      onTap: onTap,
      borderRadius: 12,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 11),
        decoration: BoxDecoration(
          color: filled ? AppColors.pureBlack : AppColors.inputFill,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 17,
              color: filled ? AppColors.pureWhite : AppColors.textPrimary,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: filled ? AppColors.pureWhite : AppColors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _DonutGauge extends StatelessWidget {
  final double value; // 0..1
  final String label;
  final String centerText;
  final Color color;
  final Widget? suffix;

  const _DonutGauge({
    required this.value,
    required this.label,
    required this.centerText,
    required this.color,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 74,
          height: 74,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: value.clamp(0.0, 1.0).toDouble()),
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeOutCubic,
            builder: (_, v, __) => Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 74,
                  height: 74,
                  child: CircularProgressIndicator(
                    value: 1,
                    strokeWidth: 7,
                    color: AppColors.divider,
                  ),
                ),
                SizedBox(
                  width: 74,
                  height: 74,
                  child: CircularProgressIndicator(
                    value: v,
                    strokeWidth: 7,
                    strokeCap: StrokeCap.round,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation(color),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      centerText,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (suffix != null) ...[const SizedBox(width: 2), suffix!],
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.5,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _QuickAction {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  _QuickAction(this.icon, this.label, this.color, this.onTap);
}

class _QuickActionButton extends StatelessWidget {
  final _QuickAction action;
  const _QuickActionButton({required this.action});

  @override
  Widget build(BuildContext context) {
    return _HoverPress(
      onTap: action.onTap,
      borderRadius: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          border: Border.all(color: AppColors.divider),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: action.color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(action.icon, size: 18, color: action.color),
            ),
            const SizedBox(height: 6),
            Text(
              action.label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _EarningsBreakdownItem extends StatelessWidget {
  final Color color;
  final String label;
  final String value;

  const _EarningsBreakdownItem({
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                label,
                style: const TextStyle(
                  color: AppColors.textHint,
                  fontSize: 10.5,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.pureWhite,
            fontWeight: FontWeight.bold,
            fontSize: 13.5,
          ),
        ),
      ],
    );
  }
}

class _ActivityPreview {
  final IconData icon;
  final Color color;
  final String title;
  final String body;
  final String time;
  _ActivityPreview(this.icon, this.color, this.title, this.body, this.time);
}

class _ActivityTile extends StatelessWidget {
  final _ActivityPreview item;
  final VoidCallback onTap;
  const _ActivityTile({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return _HoverPress(
      onTap: onTap,
      borderRadius: 14,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          border: Border.all(color: AppColors.divider),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: item.color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(item.icon, size: 17, color: item.color),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    item.body,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            Text(
              item.time,
              style: const TextStyle(fontSize: 10, color: AppColors.textHint),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconOrEmoji {
  final IconData icon;
  const _IconOrEmoji.icon(this.icon);
}

class _AchievementBadge extends StatelessWidget {
  final _IconOrEmoji icon;
  final String label;
  final Color color;

  const _AchievementBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.pureBlack,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(icon.icon, color: color, size: 22),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _EmergencyFab extends StatefulWidget {
  final VoidCallback onTap;
  const _EmergencyFab({required this.onTap});

  @override
  State<_EmergencyFab> createState() => _EmergencyFabState();
}

class _EmergencyFabState extends State<_EmergencyFab> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.pureBlack,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            Icons.sos_outlined,
            color: AppColors.pureWhite,
            size: 24,
          ),
        ),
      ),
    );
  }
}
