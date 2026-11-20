import '../../../../core/api_client.dart';
import 'package:rento_india/delivery/core/rider_api.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/rider_status_provider.dart';
import '../providers/rider_tab_provider.dart';
import '../providers/available_requests_provider.dart';
import 'screens/dashboard/rider_home_screen.dart';
import 'screens/dashboard/available_requests_screen.dart';
import 'screens/dashboard/new_request_popup.dart';
import 'screens/trips/trips_list_screen.dart';
import 'screens/earnings/earnings_screen.dart';
import 'screens/profile/rider_profile_screen.dart';
import 'screens/trips/trip_navigation_screen.dart';
import 'screens/notifications/notifications_screen.dart';
import 'widgets/rider_bottom_nav.dart';
import '../data/models/trip_request_model.dart';

class RiderShell extends ConsumerStatefulWidget {
  const RiderShell({super.key});

  @override
  ConsumerState<RiderShell> createState() => _RiderShellState();
}

class _RiderShellState extends ConsumerState<RiderShell> {
  bool _popupOpen = false;

  List<Widget> get _tabs => [
    const RiderHomeScreen(),
    const AvailableRequestsScreen(),
    TripsListScreen(
      onBack: () => ref.read(riderTabIndexProvider.notifier).state = 0,
      onNotifications: () => ref.read(riderTabIndexProvider.notifier).state = 5,
    ),
    EarningsScreen(
      onBack: () => ref.read(riderTabIndexProvider.notifier).state = 0,
    ),
    const RiderProfileScreen(),
    NotificationsScreen(
      onBack: () => ref.read(riderTabIndexProvider.notifier).state = 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final tabIndex = ref.watch(riderTabIndexProvider);
    final isOnline = ref.watch(riderStatusProvider).isOnline;
    final requestCount = ref.watch(availableRequestsProvider).length;

    ref.listen(riderStatusProvider, (previous, next) {
      final request = next.incomingRequest;
      if (request != null && !_popupOpen) {
        _showRequestPopup(request);
      }
    });

    return Scaffold(
      body: IndexedStack(index: tabIndex, children: _tabs),
      bottomNavigationBar: RiderBottomNav(
        currentIndex: _navIndexForTab(tabIndex),
        onTap: (i) =>
            ref.read(riderTabIndexProvider.notifier).state = _tabForNavIndex(i),
        requestBadgeCount: isOnline ? requestCount : 0,
      ),
    );
  }

  int _navIndexForTab(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return 0; // Home
      case 2:
        return 1; // Trips
      case 3:
        return 2; // Earnings
      case 4:
        return 3; // Profile
      default:
        return 0; // Requests/Notifications have no nav icon; default to Home
    }
  }

  int _tabForNavIndex(int navIndex) {
    switch (navIndex) {
      case 0:
        return 0; // Home
      case 1:
        return 2; // Trips
      case 2:
        return 3; // Earnings
      case 3:
        return 4; // Profile
      default:
        return 0;
    }
  }

  void _showRequestPopup(TripRequestModel request) {
    _popupOpen = true;
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      builder: (_) => NewRequestPopup(
        itemName: request.itemName,
        category: request.category,
        distanceKm: request.distanceKm,
        pickupLabel: request.pickupLabel,
        pickupAddress: request.pickupAddress,
        dropLabel: request.dropLabel,
        dropAddress: request.dropAddress,
        estimatedMinutes: request.estimatedMinutes,
        earnings: request.earnings,
        imageAsset: request.imageAsset,
        isReturnRequest: request.isReturnPickup,
        onAccept: () async {
          Navigator.pop(context);
          _popupOpen = false;
          ref.read(riderStatusProvider.notifier).clearIncomingRequest();
          try {
            // tells the server this rider takes the job (another rider may have been faster)
            await RiderApi.instance.accept('TRIP', request.id);
          } on ApiException catch (e) {
            if (!mounted) return;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.message)));
            return;
          }
          if (!mounted) return;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => request.isReturnPickup
                  ? TripNavigationScreen(
                      request: request,
                      stage: NavigationStage.returnToCustomer,
                    )
                  : NavigateToVendorScreen(request: request),
            ),
          );
        },
        onDecline: () {
          Navigator.pop(context);
          _popupOpen = false;
          ref.read(riderStatusProvider.notifier).clearIncomingRequest();
          ref.read(riderStatusProvider.notifier).requestDeclined();
        },
      ),
    ).whenComplete(() => _popupOpen = false);
  }
}
