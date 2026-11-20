// // import '../widgets/bottom_nav_bar.dart';
// // import '../widgets/nav_helper.dart';
// // import 'package:flutter/material.dart';

// // class MyHouseScreen extends StatelessWidget {
// //   const MyHouseScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final options = [
// //       {'title': 'My Properties', 'icon': Icons.home_work_outlined},
// //       {'title': 'Pay Rent', 'icon': Icons.account_balance_wallet_outlined},
// //       {'title': 'Maintenance Requests', 'icon': Icons.build_outlined},
// //       {'title': 'Lease Documents', 'icon': Icons.description_outlined},
// //     ];
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('My House'),
// //         // FIX: this is a main bottom-nav tab, not a pushed sub-page —
// //         // it shouldn't show a back arrow.
// //         automaticallyImplyLeading: false,
// //       ),
// //       body: ListView.separated(
// //         padding: const EdgeInsets.all(16),
// //         itemCount: options.length,
// //         separatorBuilder: (_, __) => const SizedBox(height: 10),
// //         itemBuilder: (context, i) => Container(
// //           decoration: BoxDecoration(
// //             color: Colors.white,
// //             borderRadius: BorderRadius.circular(12),
// //             border: Border.all(color: const Color(0xFFF0F0F0)),
// //           ),
// //           child: ListTile(
// //             leading: Icon(options[i]['icon'] as IconData),
// //             title: Text(options[i]['title'] as String),
// //             trailing: const Icon(Icons.chevron_right),
// //             onTap: () {},
// //           ),
// //         ),
// //       ),
// //       bottomNavigationBar: RentoBottomNavBar(
// //         currentIndex: 1,
// //         onTap: (i) => navigateToTab(context, i),
// //       ),
// //     );
// //   }
// // }

// import '../widgets/bottom_nav_bar.dart';
// import '../widgets/nav_helper.dart';
// import 'package:flutter/material.dart';

// class MyHouseScreen extends StatelessWidget {
//   const MyHouseScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final options = [
//       {'title': 'My Properties', 'icon': Icons.home_work_outlined},
//       {'title': 'Pay Rent', 'icon': Icons.account_balance_wallet_outlined},
//       {'title': 'Maintenance Requests', 'icon': Icons.build_outlined},
//       {'title': 'Lease Documents', 'icon': Icons.description_outlined},
//     ];
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My House'),
//         // FIX: this is a main bottom-nav tab, not a pushed sub-page —
//         // it shouldn't show a back arrow.
//         automaticallyImplyLeading: false,
//       ),
//       body: ListView.separated(
//         padding: const EdgeInsets.all(16),
//         itemCount: options.length,
//         separatorBuilder: (_, __) => const SizedBox(height: 10),
//         itemBuilder: (context, i) => Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: const Color(0xFFF0F0F0)),
//           ),
//           child: ListTile(
//             leading: Icon(options[i]['icon'] as IconData),
//             title: Text(options[i]['title'] as String),
//             trailing: const Icon(Icons.chevron_right),
//             onTap: () {},
//           ),
//         ),
//       ),
//       bottomNavigationBar: RentoBottomNavBar(
//         currentIndex: 1,
//         onTap: (i) => navigateToTab(context, i),
//       ),
//     );
//   }
// }