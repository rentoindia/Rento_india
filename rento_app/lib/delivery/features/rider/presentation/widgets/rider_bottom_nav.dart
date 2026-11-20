import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
 

/// Shared bottom nav bar for the rider shell — 4 tabs:
/// Home | Trips | Earnings | Profile
///
/// ⭐ "Requests" no longer has a tab here — incoming delivery /
/// return-pickup requests now arrive as a direct popup (one at a time)
/// instead of a browsable list, so [requestBadgeCount] is unused and
/// kept only for backwards compatibility with existing call sites.
class RiderBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final int? requestBadgeCount;

  const RiderBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.requestBadgeCount,
  });

  // ⭐ "Requests" tab removed — incoming delivery/return-pickup requests
  // now arrive as a direct popup (see RiderShell) instead of a
  // browsable list, so it no longer needs a spot in the bottom nav.
  static const _items = [
    _NavItemData(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Home',
    ),
    _NavItemData(
      icon: Icons.directions_bike_outlined,
      activeIcon: Icons.directions_bike,
      label: 'Trips',
    ),
    _NavItemData(
      icon: Icons.account_balance_wallet_outlined,
      activeIcon: Icons.account_balance_wallet,
      label: 'Earnings',
    ),
    _NavItemData(
      icon: Icons.notifications_outlined,
      activeIcon: Icons.notifications,
      label: 'Notifications',
    ),
    _NavItemData(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.pureWhite,
      selectedItemColor: AppColors.pureBlack,
      unselectedItemColor: AppColors.textHint,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: const TextStyle(fontSize: 11),
      items: List.generate(_items.length, (i) {
        final item = _items[i];
        return BottomNavigationBarItem(
          icon: Icon(item.icon),
          activeIcon: Icon(item.activeIcon),
          label: item.label,
        );
      }),
    );
  }
}

class _NavItemData {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const _NavItemData({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
