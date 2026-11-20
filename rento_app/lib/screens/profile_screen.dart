import '../core/session.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/bottom_nav_bar.dart';
import '../widgets/nav_helper.dart';
import '../services/wallet_service.dart';
import '../services/favorites_service.dart';
import 'placeholder_screen.dart';
import 'rental_order.dart';
import 'orders_screen.dart';
import '../services/orders_service.dart';
import 'wallet_screen.dart';
import 'saved_items_screen.dart';
import 'login_screen.dart';
import 'edit_profile_screen.dart';
import 'about_app_screen.dart';
import 'payments_refunds_screen.dart';
import 'notification_screen.dart';

class _AccentColors {
  static const dark = Colors.black;
  static const darker = Color(0xFF1A1A1A);
  static const light = Color(0xFFF3F4F6);
  static const bg = Color(0xFFF7F8FA);
  static const headerBg = Color(
    0xFFF0F0F0,
  ); // light grey header instead of solid black
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _avatarImage;
  String _name = Session.instance.fullName.isNotEmpty
      ? Session.instance.fullName
      : 'Your name';
  String _phone = Session.instance.phone.isEmpty
      ? ''
      : '+91 ${Session.instance.phone}';

  Future<void> _openEditProfile() async {
    final result = await Navigator.push<EditProfileResult>(
      context,
      MaterialPageRoute(
        builder: (_) => EditProfileScreen(
          initialName: _name,
          initialPhone: _phone,
          initialAvatar: _avatarImage,
        ),
      ),
    );
    if (result != null) {
      setState(() {
        _name = result.name;
        _phone = result.phone;
        _avatarImage = result.avatar;
      });
      // save the name on the server (so lenders / riders see it on orders)
      Session.instance
          .updateProfile(fullName: result.name)
          .catchError((Object e) => null);
    }
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Log out?'),
        content: const Text(
          'You\'ll need to sign in again to access your account.',
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              // clears the tokens + cached data; main.dart then returns to the first screen
              Session.instance.logout();
            },
            child: const Text(
              'Log Out',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {
        'title': 'My Rentals',
        'icon': Icons.inventory_2_outlined,
        'description': 'Items you\'re currently renting or have rented before.',
        'onTap': (BuildContext ctx) => Navigator.push(
          ctx,
          MaterialPageRoute(builder: (_) => const OrdersScreen()),
        ),
      },
      {
        'title': 'Payments & Refunds',
        'icon': Icons.receipt_long_outlined,
        'description': 'Payment methods, history, invoices, and refund status.',
        'onTap': (BuildContext ctx) => Navigator.push(
          ctx,
          MaterialPageRoute(builder: (_) => const PaymentsRefundsScreen()),
        ),
      },
      {
        'title': 'Refer & Earn',
        'icon': Icons.card_giftcard_outlined,
        'badge': 'Earn Rewards',
        'description': 'Invite friends to Rento and earn wallet credit when they rent their first item.',
        'actionLabel': 'Invite Friends',
      },
      {
        'title': 'Saved Items',
        'icon': Icons.favorite_border,
        'description':
            'Tap the heart icon on any product to save it here for later.',
        'isSavedItems': true,
      },
      {
        'title': 'Address Book',
        'icon': Icons.location_on_outlined,
        'description':
            'Add a delivery address to make checkout faster next time.',
        'actionLabel': 'Add Address',
      },
      {
        'title': 'Documents',
        'icon': Icons.description_outlined,
        'description':
            'Upload your ID or address proof here to speed up future rentals.',
        'actionLabel': 'Upload Document',
      },
      {
        'title': 'Notifications',
        'icon': Icons.notifications_none_rounded,
        'onTap': (BuildContext ctx) => Navigator.push(
          ctx,
          MaterialPageRoute(builder: (_) => const NotificationScreen()),
        ),
      },
      {
        'title': 'Help & Support',
        'icon': Icons.support_agent_outlined,
        'description': 'Have a question or an issue with an order? Our team is here to help.',
        'actionLabel': 'Contact Support',
      },
      {
        'title': 'About App',
        'icon': Icons.info_outline,
        'onTap': (BuildContext ctx) => Navigator.push(
          ctx,
          MaterialPageRoute(builder: (_) => const AboutAppScreen()),
        ),
      },
      {
        'title': 'Settings',
        'icon': Icons.settings_outlined,
        'description':
            'Manage your account preferences, privacy, and app settings.',
      },
    ];

    return Scaffold(
      backgroundColor: _AccentColors.bg,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildHeader(context),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedBuilder(
                  animation: OrdersService.instance,
                  builder: (context, _) => _buildOrdersRow(context),
                ),
                const SizedBox(height: 20),
                const Text(
                  'My Account',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                const SizedBox(height: 10),
                ...menuItems.map(
                  (o) => _menuTile(
                    context,
                    title: o['title'] as String,
                    icon: o['icon'] as IconData,
                    badge: o['badge'] as String?,
                    description: o['description'] as String?,
                    actionLabel: o['actionLabel'] as String?,
                    isSavedItems: o['isSavedItems'] as bool? ?? false,
                    onTapOverride: o['onTap'] as void Function(BuildContext)?,
                  ),
                ),
                const SizedBox(height: 8),
                _logoutTile(context),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: RentoBottomNavBar(
        currentIndex: 4,
        onTap: (i) => navigateToTab(context, i),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 26),
      decoration: const BoxDecoration(
        color: _AccentColors.dark,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const Text(
              'Profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 18),
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: CircleAvatar(
                backgroundColor: _AccentColors.light,
                backgroundImage: _avatarImage != null
                    ? FileImage(_avatarImage!)
                    : null,
                child: _avatarImage == null
                    ? const Icon(
                        Icons.person,
                        size: 36,
                        color: _AccentColors.dark,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: _openEditProfile,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              _phone,
              style: TextStyle(
                color: Colors.white.withOpacity(0.85),
                fontSize: 12.5,
              ),
            ),
            const SizedBox(height: 18),
            _buildWalletCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletCard(BuildContext context) {
    return AnimatedBuilder(
      animation: WalletService.instance,
      builder: (context, _) {
        final coins = WalletService.instance.coins;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: _AccentColors.light,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.account_balance_wallet_outlined,
                  color: _AccentColors.dark,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Wallet Balance',
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                    Text(
                      '₹${coins.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const WalletScreen()),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Add Money',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
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

  Widget _buildOrdersRow(BuildContext context) {
    return AnimatedBuilder(
      animation: OrdersService.instance,
      builder: (context, _) {
        final statuses = [
          {
            'label': 'Upcoming',
            'count': OrdersService.instance.orders
                .where((o) => o.status.index < OrderStatus.rentalActive.index)
                .length,
            'icon': Icons.schedule_outlined,
          },
          {
            'label': 'Active',
            'count': OrdersService.instance.countFor(OrderStatus.rentalActive),
            'icon': Icons.autorenew,
          },
          {
            'label': 'Completed',
            'count': OrdersService.instance.countFor(OrderStatus.completed),
            'icon': Icons.check_circle_outline,
          },
        ];
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFF0F0F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Orders',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const OrdersScreen()),
                    ),
                    child: const Text(
                      'View all',
                      style: TextStyle(
                        color: _AccentColors.dark,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: statuses
                    .map(
                      (s) => Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const OrdersScreen(),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: _AccentColors.light,
                                  shape: BoxShape.circle,
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(
                                      s['icon'] as IconData,
                                      color: _AccentColors.dark,
                                      size: 18,
                                    ),
                                    if ((s['count'] as int) > 0)
                                      Positioned(
                                        top: -2,
                                        right: -2,
                                        child: Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: const BoxDecoration(
                                            color: _AccentColors.dark,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Text(
                                            '${s['count']}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                s['label'] as String,
                                style: const TextStyle(fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _menuTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    String? badge,
    String? description,
    String? actionLabel,
    bool isSavedItems = false,
    void Function(BuildContext)? onTapOverride,
  }) {
    final trailing = isSavedItems
        ? AnimatedBuilder(
            animation: FavoritesService.instance,
            builder: (context, _) {
              final count = FavoritesService.instance.items.length;
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (count > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: _AccentColors.light,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '$count',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  const SizedBox(width: 6),
                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              );
            },
          )
        : (badge != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: _AccentColors.light,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Earn Rewards',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                )
              : const Icon(Icons.chevron_right, color: Colors.grey));

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _AccentColors.light,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: _AccentColors.dark, size: 18),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5),
        ),
        trailing: trailing,
        onTap: () {
          if (isSavedItems) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SavedItemsScreen()),
            );
            return;
          }
          if (onTapOverride != null) {
            onTapOverride(context);
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PlaceholderScreen(
                title: title,
                icon: icon,
                description: description ?? "There's nothing here yet.",
                actionLabel: actionLabel ?? 'Explore Rentals',
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _logoutTile(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFFEECEC),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.logout, color: Colors.redAccent, size: 18),
        ),
        title: const Text(
          'Log Out',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.redAccent,
            fontSize: 13.5,
          ),
        ),
        onTap: () => _confirmLogout(context),
      ),
    );
  }
}
