// // import 'package:flutter/material.dart';
// // import '../services/notification_service.dart';

// // /// ============================================================
// // /// NOTIFICATION SCREEN — tabs (All/Orders/Offers/Alerts) with
// // /// notifications grouped by day (Today / Yesterday / Earlier).
// // ///
// // /// Reads from the shared NotificationService, so the unread count
// // /// shown as a badge elsewhere in the app (Home, Category, Category
// // /// Detail) always matches what's actually unread here.
// // /// ============================================================

// // class NotificationScreen extends StatefulWidget {
// //   const NotificationScreen({super.key});

// //   @override
// //   State<NotificationScreen> createState() => _NotificationScreenState();
// // }

// // class _NotificationScreenState extends State<NotificationScreen> {
// //   String _selectedTab = 'All';
// //   final List<String> _tabs = const ['All', 'Orders', 'Offers', 'Alerts'];

// //   @override
// //   Widget build(BuildContext context) {
// //     return AnimatedBuilder(
// //       animation: NotificationService.instance,
// //       builder: (context, _) {
// //         final all = NotificationService.instance.items;
// //         final filtered = _selectedTab == 'All'
// //             ? all
// //             : all.where((n) => n.category == _selectedTab).toList();

// //         final groups = ['Today', 'Yesterday', 'Earlier'];

// //         return Scaffold(
// //           backgroundColor: const Color(0xFFF7F8FA),
// //           body: SafeArea(
// //             child: Column(
// //               children: [
// //                 _buildHeader(context),
// //                 const SizedBox(height: 12),
// //                 _buildTabs(),
// //                 const SizedBox(height: 8),
// //                 Expanded(
// //                   child: ListView(
// //                     padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
// //                     children: [
// //                       for (final group in groups) ...[
// //                         if (filtered.any((n) => n.group == group)) ...[
// //                           Padding(
// //                             padding: const EdgeInsets.symmetric(vertical: 10),
// //                             child: Text(group,
// //                                 style: const TextStyle(
// //                                     fontWeight: FontWeight.w700, fontSize: 13, color: Colors.grey)),
// //                           ),
// //                           ...filtered
// //                               .where((n) => n.group == group)
// //                               .map((n) => _notificationTile(n)),
// //                         ],
// //                       ],
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   // ---------- HEADER ----------
// //   Widget _buildHeader(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
// //       child: Row(
// //         children: [
// //           GestureDetector(
// //             onTap: () => Navigator.maybePop(context),
// //             child: Container(
// //               padding: const EdgeInsets.all(6),
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 shape: BoxShape.circle,
// //                 border: Border.all(color: const Color(0xFFF0F0F0)),
// //               ),
// //               child: const Icon(Icons.arrow_back, size: 20, color: Colors.black),
// //             ),
// //           ),
// //           const Expanded(
// //             child: Text('Notifications',
// //                 textAlign: TextAlign.center,
// //                 style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
// //           ),
// //           const SizedBox(width: 32),
// //         ],
// //       ),
// //     );
// //   }

// //   // ---------- TABS ----------
// //   Widget _buildTabs() {
// //     return SizedBox(
// //       height: 36,
// //       child: ListView.separated(
// //         scrollDirection: Axis.horizontal,
// //         padding: const EdgeInsets.symmetric(horizontal: 16),
// //         itemCount: _tabs.length,
// //         separatorBuilder: (_, __) => const SizedBox(width: 8),
// //         itemBuilder: (context, i) {
// //           final tab = _tabs[i];
// //           final selected = tab == _selectedTab;
// //           return GestureDetector(
// //             onTap: () => setState(() => _selectedTab = tab),
// //             child: Container(
// //               padding: const EdgeInsets.symmetric(horizontal: 18),
// //               alignment: Alignment.center,
// //               decoration: BoxDecoration(
// //                 color: selected ? Colors.black : Colors.white,
// //                 borderRadius: BorderRadius.circular(20),
// //                 border: Border.all(color: selected ? Colors.black : const Color(0xFFEDEDED)),
// //               ),
// //               child: Text(tab,
// //                   style: TextStyle(
// //                     color: selected ? Colors.white : Colors.black87,
// //                     fontWeight: FontWeight.w600,
// //                     fontSize: 12.5,
// //                   )),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   // ---------- NOTIFICATION TILE ----------
// //   Widget _notificationTile(NotificationItem n) {
// //     return GestureDetector(
// //       onTap: () => NotificationService.instance.markRead(n),
// //       child: Container(
// //         margin: const EdgeInsets.only(bottom: 10),
// //         padding: const EdgeInsets.all(12),
// //         decoration: BoxDecoration(
// //           color: n.unread ? const Color(0xFFF3F4F6) : Colors.white,
// //           borderRadius: BorderRadius.circular(12),
// //           border: Border.all(color: const Color(0xFFF0F0F0)),
// //         ),
// //         child: Row(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Container(
// //               padding: const EdgeInsets.all(9),
// //               decoration: BoxDecoration(
// //                 color: const Color(0xFFECECEC),
// //                 borderRadius: BorderRadius.circular(10),
// //               ),
// //               child: Icon(n.icon, color: Colors.black87, size: 18),
// //             ),
// //             const SizedBox(width: 12),
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Row(
// //                     children: [
// //                       Expanded(
// //                         child: Text(n.title,
// //                             style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
// //                       ),
// //                       if (n.unread)
// //                         Container(
// //                           width: 7,
// //                           height: 7,
// //                           decoration: const BoxDecoration(
// //                               color: Colors.black87, shape: BoxShape.circle),
// //                         ),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 3),
// //                   Text(n.subtitle,
// //                       style: TextStyle(color: Colors.grey.shade600, fontSize: 12, height: 1.3)),
// //                   const SizedBox(height: 4),
// //                   Text(n.time, style: TextStyle(color: Colors.grey.shade400, fontSize: 10.5)),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }


















// import 'package:flutter/material.dart';
// import '../services/notification_service.dart';
// import 'rental_requests_screen.dart';

// /// ============================================================
// /// NOTIFICATION SCREEN — tabs (All/Orders/Requests/Offers/Alerts)
// /// with notifications grouped by day (Today / Yesterday / Earlier).
// ///
// /// Reads from the shared NotificationService, so the unread count
// /// shown as a badge elsewhere in the app (Home, Category, Category
// /// Detail) always matches what's actually unread here.
// ///
// /// FIX: "Requests" tab added, and tapping a rental-request
// /// notification now navigates into RentalRequestsScreen (where
// /// Accept/Reject already exist in LenderService) instead of just
// /// marking it read and going nowhere.
// /// ============================================================

// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({super.key});

//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {
//   String _selectedTab = 'All';
//   final List<String> _tabs = const ['All', 'Orders', 'Requests', 'Offers', 'Alerts'];

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: NotificationService.instance,
//       builder: (context, _) {
//         final all = NotificationService.instance.items;
//         final filtered = _selectedTab == 'All'
//             ? all
//             : all.where((n) => n.category == _selectedTab).toList();

//         final groups = ['Today', 'Yesterday', 'Earlier'];

//         return Scaffold(
//           backgroundColor: const Color(0xFFF7F8FA),
//           body: SafeArea(
//             child: Column(
//               children: [
//                 _buildHeader(context),
//                 const SizedBox(height: 12),
//                 _buildTabs(),
//                 const SizedBox(height: 8),
//                 Expanded(
//                   child: ListView(
//                     padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
//                     children: [
//                       for (final group in groups) ...[
//                         if (filtered.any((n) => n.group == group)) ...[
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 10),
//                             child: Text(group,
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.w700, fontSize: 13, color: Colors.grey)),
//                           ),
//                           ...filtered
//                               .where((n) => n.group == group)
//                               .map((n) => _notificationTile(context, n)),
//                         ],
//                       ],
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // ---------- HEADER ----------
//   Widget _buildHeader(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
//       child: Row(
//         children: [
//           GestureDetector(
//             onTap: () => Navigator.maybePop(context),
//             child: Container(
//               padding: const EdgeInsets.all(6),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.circle,
//                 border: Border.all(color: const Color(0xFFF0F0F0)),
//               ),
//               child: const Icon(Icons.arrow_back, size: 20, color: Colors.black),
//             ),
//           ),
//           const Expanded(
//             child: Text('Notifications',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
//           ),
//           const SizedBox(width: 32),
//         ],
//       ),
//     );
//   }

//   // ---------- TABS ----------
//   Widget _buildTabs() {
//     return SizedBox(
//       height: 36,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         itemCount: _tabs.length,
//         separatorBuilder: (_, __) => const SizedBox(width: 8),
//         itemBuilder: (context, i) {
//           final tab = _tabs[i];
//           final selected = tab == _selectedTab;
//           return GestureDetector(
//             onTap: () => setState(() => _selectedTab = tab),
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 18),
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: selected ? Colors.black : Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: selected ? Colors.black : const Color(0xFFEDEDED)),
//               ),
//               child: Text(tab,
//                   style: TextStyle(
//                     color: selected ? Colors.white : Colors.black87,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 12.5,
//                   )),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // ---------- NOTIFICATION TILE ----------
//   Widget _notificationTile(BuildContext context, NotificationItem n) {
//     return GestureDetector(
//       onTap: () {
//         NotificationService.instance.markRead(n);
//         // FIX: this is the actual navigation piece that was missing —
//         // a rental-request notification now takes the owner straight
//         // to the screen where Accept/Reject already work, instead of
//         // just clearing the unread dot and doing nothing else.
//         if (n.actionType == 'rentalRequest') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) => const RentalRequestsScreen()),
//           );
//         }
//       },
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 10),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: n.unread ? const Color(0xFFF3F4F6) : Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: const Color(0xFFF0F0F0)),
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(9),
//               decoration: BoxDecoration(
//                 color: n.actionType == 'rentalRequest' ? Colors.black : const Color(0xFFECECEC),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Icon(n.icon,
//                   color: n.actionType == 'rentalRequest' ? Colors.white : Colors.black87, size: 18),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(n.title,
//                             style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
//                       ),
//                       if (n.unread)
//                         Container(
//                           width: 7,
//                           height: 7,
//                           decoration: const BoxDecoration(
//                               color: Colors.black87, shape: BoxShape.circle),
//                         ),
//                     ],
//                   ),
//                   const SizedBox(height: 3),
//                   Text(n.subtitle,
//                       style: TextStyle(color: Colors.grey.shade600, fontSize: 12, height: 1.3)),
//                   const SizedBox(height: 4),
//                   Row(
//                     children: [
//                       Text(n.time, style: TextStyle(color: Colors.grey.shade400, fontSize: 10.5)),
//                       if (n.actionType == 'rentalRequest') ...[
//                         const SizedBox(width: 8),
//                         const Text('Tap to review →',
//                             style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: Colors.black87)),
//                       ],
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import '../services/notification_service.dart';
import 'rental_requests_screen.dart';

/// ============================================================
/// NOTIFICATION SCREEN — tabs (All/Orders/Requests/Offers/Alerts)
/// with notifications grouped by day (Today / Yesterday / Earlier).
///
/// Reads from the shared NotificationService, so the unread count
/// shown as a badge elsewhere in the app (Home, Category, Category
/// Detail) always matches what's actually unread here.
///
/// FIX: "Requests" tab added, and tapping a rental-request
/// notification now navigates into RentalRequestsScreen (where
/// Accept/Reject already exist in LenderService) instead of just
/// marking it read and going nowhere.
/// ============================================================

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _selectedTab = 'All';
  final List<String> _tabs = const ['All', 'Orders', 'Requests', 'Offers', 'Alerts'];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: NotificationService.instance,
      builder: (context, _) {
        final all = NotificationService.instance.items;
        final filtered = _selectedTab == 'All'
            ? all
            : all.where((n) => n.category == _selectedTab).toList();

        final groups = ['Today', 'Yesterday', 'Earlier'];

        return Scaffold(
          backgroundColor: const Color(0xFFF7F8FA),
          body: SafeArea(
            child: Column(
              children: [
                _buildHeader(context),
                const SizedBox(height: 12),
                _buildTabs(),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                    children: [
                      for (final group in groups) ...[
                        if (filtered.any((n) => n.group == group)) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(group,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 13, color: Colors.grey)),
                          ),
                          ...filtered
                              .where((n) => n.group == group)
                              .map((n) => _notificationTile(context, n)),
                        ],
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ---------- HEADER ----------
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFF0F0F0)),
              ),
              child: const Icon(Icons.arrow_back, size: 20, color: Colors.black),
            ),
          ),
          const Expanded(
            child: Text('Notifications',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          ),
          const SizedBox(width: 32),
        ],
      ),
    );
  }

  // ---------- TABS ----------
  Widget _buildTabs() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final tab = _tabs[i];
          final selected = tab == _selectedTab;
          return GestureDetector(
            onTap: () => setState(() => _selectedTab = tab),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: selected ? Colors.black : const Color(0xFFEDEDED)),
              ),
              child: Text(tab,
                  style: TextStyle(
                    color: selected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.5,
                  )),
            ),
          );
        },
      ),
    );
  }

  // ---------- NOTIFICATION TILE ----------
  Widget _notificationTile(BuildContext context, NotificationItem n) {
    return GestureDetector(
      onTap: () {
        NotificationService.instance.markRead(n);
        // FIX: this is the actual navigation piece that was missing —
        // a rental-request notification now takes the owner straight
        // to the screen where Accept/Reject already work, instead of
        // just clearing the unread dot and doing nothing else.
        if (n.actionType == 'rentalRequest') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const RentalRequestsScreen()),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: n.unread ? const Color(0xFFF3F4F6) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFF0F0F0)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: n.actionType == 'rentalRequest' ? Colors.black : const Color(0xFFECECEC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(n.icon,
                  color: n.actionType == 'rentalRequest' ? Colors.white : Colors.black87, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(n.title,
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
                      ),
                      if (n.unread)
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                              color: Colors.black87, shape: BoxShape.circle),
                        ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(n.subtitle,
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 12, height: 1.3)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(n.time, style: TextStyle(color: Colors.grey.shade400, fontSize: 10.5)),
                      if (n.actionType == 'rentalRequest') ...[
                        const SizedBox(width: 8),
                        const Text('Tap to review →',
                            style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: Colors.black87)),
                      ],
                    ],
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