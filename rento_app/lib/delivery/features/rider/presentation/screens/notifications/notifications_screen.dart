// import 'package:flutter/material.dart';
// import '../../../../../core/constants/app_colors.dart';

// /// Notifications list — reached from the bell icon on Home, Trips, and
// /// the bottom nav. Currently mock data.
// /// TODO: replace with NotificationService / a real notifications
// /// provider once push notifications (FCM) are wired.
// ///
// /// Uses the same curved black-header + white rounded sheet design as
// /// the other trip screens (Delivery, Return Pickup, Vendor Return,
// /// Navigate to Vendor) instead of the old flat white AppBar.
// class NotificationsScreen extends StatelessWidget {
//   const NotificationsScreen({super.key});

//   static const _mockNotifications = [
//     (
//       icon: Icons.local_shipping_outlined,
//       title: 'New delivery request nearby',
//       body: 'A Laptop delivery request is available 2.4 km away.',
//       time: '2 min ago',
//       unread: true,
//     ),
//     (
//       icon: Icons.check_circle_outline,
//       title: 'Trip completed',
//       body: 'You delivered to Priya Sharma. ₹180.00 credited.',
//       time: '1 hr ago',
//       unread: true,
//     ),
//     (
//       icon: Icons.account_balance_wallet_outlined,
//       title: 'Weekly payout processed',
//       body: '₹2,100.00 has been sent to your bank account.',
//       time: 'Yesterday',
//       unread: false,
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.pureBlack,
//       body: Column(
//         children: [
//           SafeArea(bottom: false, child: _buildTopBar(context)),
//           Expanded(
//             child: Container(
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 color: Color(0xFFF4F4F4),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(28),
//                   topRight: Radius.circular(28),
//                 ),
//               ),
//               child: SafeArea(
//                 top: false,
//                 child: ListView.separated(
//                   padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
//                   itemCount: _mockNotifications.length,
//                   separatorBuilder: (_, _) => const SizedBox(height: 10),
//                   itemBuilder: (context, index) {
//                     final n = _mockNotifications[index];
//                     return Container(
//                       padding: const EdgeInsets.all(14),
//                       decoration: BoxDecoration(
//                         color: AppColors.pureWhite,
//                         border: Border.all(
//                           color: n.unread
//                               ? AppColors.pureBlack
//                               : AppColors.divider,
//                           width: n.unread ? 1.2 : 1,
//                         ),
//                         borderRadius: BorderRadius.circular(14),
//                       ),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             width: 40,
//                             height: 40,
//                             decoration: BoxDecoration(
//                               color: AppColors.inputFill,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Icon(
//                               n.icon,
//                               size: 18,
//                               color: AppColors.textPrimary,
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   n.title,
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.w700,
//                                     fontSize: 13.5,
//                                     color: AppColors.textPrimary,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 2),
//                                 Text(
//                                   n.body,
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                     color: AppColors.textSecondary,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 6),
//                                 Text(
//                                   n.time,
//                                   style: const TextStyle(
//                                     fontSize: 11,
//                                     color: AppColors.textHint,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           if (n.unread)
//                             Container(
//                               width: 8,
//                               height: 8,
//                               margin: const EdgeInsets.only(top: 4),
//                               decoration: const BoxDecoration(
//                                 color: Colors.red,
//                                 shape: BoxShape.circle,
//                               ),
//                             ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Black top bar with back button + title — matches the curved-header
//   // design used across the other trip screens instead of the old flat
//   // white AppBar.
//   Widget _buildTopBar(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(8, 4, 16, 20),
//       child: Row(
//         children: [
//           IconButton(
//             icon: const Icon(Icons.arrow_back, color: AppColors.pureWhite),
//             onPressed: () => Navigator.of(context).maybePop(),
//           ),
//           const Expanded(
//             child: Text(
//               'Notifications',
//               style: TextStyle(
//                 color: AppColors.pureWhite,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
//import '../../../../../core/constants/app_colors.dart';
import 'package:rento_india/delivery/core/constants/app_colors.dart';
/// Notifications list — reached from the bell icon on Home, Trips, and
/// the bottom nav. Currently mock data.
/// TODO: replace with NotificationService / a real notifications
/// provider once push notifications (FCM) are wired.
///
/// Uses the same curved black-header + white rounded sheet design as
/// the other trip screens (Delivery, Return Pickup, Vendor Return,
/// Navigate to Vendor) instead of the old flat white AppBar.
class NotificationsScreen extends StatelessWidget {
  final VoidCallback? onBack; // ⭐ NEW — lets the shell switch tabs on back

  const NotificationsScreen({super.key, this.onBack});

  static const _mockNotifications = [
    (
      icon: Icons.local_shipping_outlined,
      title: 'New delivery request nearby',
      body: 'A Laptop delivery request is available 2.4 km away.',
      time: '2 min ago',
      unread: true,
    ),
    (
      icon: Icons.check_circle_outline,
      title: 'Trip completed',
      body: 'You delivered to Priya Sharma. ₹180.00 credited.',
      time: '1 hr ago',
      unread: true,
    ),
    (
      icon: Icons.account_balance_wallet_outlined,
      title: 'Weekly payout processed',
      body: '₹2,100.00 has been sent to your bank account.',
      time: 'Yesterday',
      unread: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureBlack,
      body: Column(
        children: [
          SafeArea(bottom: false, child: _buildTopBar(context)),
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
              child: SafeArea(
                top: false,
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  itemCount: _mockNotifications.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final n = _mockNotifications[index];
                    return Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.pureWhite,
                        border: Border.all(
                          color: n.unread
                              ? AppColors.pureBlack
                              : AppColors.divider,
                          width: n.unread ? 1.2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.inputFill,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              n.icon,
                              size: 18,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  n.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13.5,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  n.body,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  n.time,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textHint,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (n.unread)
                            Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.only(top: 4),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Black top bar with back button + title — matches the curved-header
  // design used across the other trip screens instead of the old flat
  // white AppBar.
  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 16, 20),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.pureWhite),
            onPressed: onBack ?? () => Navigator.of(context).maybePop(),
          ),
          const Expanded(
            child: Text(
              'Notifications',
              style: TextStyle(
                color: AppColors.pureWhite,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
