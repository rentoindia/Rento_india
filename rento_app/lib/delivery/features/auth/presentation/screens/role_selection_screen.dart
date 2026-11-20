// // import 'package:flutter/material.dart';
// // import '../../../../core/constants/app_colors.dart';
// // import '../../../../core/routes/route_names.dart';

// // /// Screen 6 — Choose Your Role.
// // /// Shared entry point after OTP verification for new users. Routes
// // /// into the correct role-specific onboarding flow (Customer /
// // /// MyHouse Owner / Rider), per the verification flow diagram.
// // class RoleSelectionScreen extends StatelessWidget {
// //   const RoleSelectionScreen({super.key});

// //   void _onRoleSelected(BuildContext context, String role) {
// //     switch (role) {
// //       case 'rider':
// //         Navigator.of(context).pushNamed(RouteNames.riderRegistration);
// //         break;
// //       case 'customer':
// //         Navigator.of(context).pushNamed(RouteNames.customerCommonInfo);
// //         break;
// //       case 'myhouse_owner':
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(
// //             content: Text('MyHouse Owner flow — built by your teammate'),
// //           ),
// //         );
// //         break;
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: AppColors.scaffoldLight,
// //       appBar: AppBar(
// //         backgroundColor: AppColors.scaffoldLight,
// //         elevation: 0,
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
// //           onPressed: () => Navigator.of(context).pop(),
// //         ),
// //       ),
// //       body: SafeArea(
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 24),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.stretch,
// //             children: [
// //               const SizedBox(height: 8),
// //               const Text(
// //                 'Choose Your Role',
// //                 style: TextStyle(
// //                   fontSize: 24,
// //                   fontWeight: FontWeight.bold,
// //                   color: AppColors.textPrimary,
// //                 ),
// //               ),
// //               const SizedBox(height: 6),
// //               const Text(
// //                 'Select how you want to use Rento India',
// //                 style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
// //               ),
// //               const SizedBox(height: 28),
// //               _RoleCard(
// //                 icon: Icons.person_outline,
// //                 title: 'Customer',
// //                 subtitle: 'Rent products easily',
// //                 onTap: () => _onRoleSelected(context, 'customer'),
// //               ),
// //               const SizedBox(height: 14),
// //               _RoleCard(
// //                 icon: Icons.home_outlined,
// //                 title: 'MyHouse Owner',
// //                 subtitle: 'List your house and earn more',
// //                 onTap: () => _onRoleSelected(context, 'myhouse_owner'),
// //               ),
// //               const SizedBox(height: 14),
// //               _RoleCard(
// //                 icon: Icons.two_wheeler_outlined,
// //                 title: 'Rider',
// //                 subtitle: 'Deliver products and earn',
// //                 onTap: () => _onRoleSelected(context, 'rider'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class _RoleCard extends StatelessWidget {
// //   final IconData icon;
// //   final String title;
// //   final String subtitle;
// //   final VoidCallback onTap;

// //   const _RoleCard({
// //     required this.icon,
// //     required this.title,
// //     required this.subtitle,
// //     required this.onTap,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return InkWell(
// //       onTap: onTap,
// //       borderRadius: BorderRadius.circular(16),
// //       child: Container(
// //         padding: const EdgeInsets.all(16),
// //         decoration: BoxDecoration(
// //           color: AppColors.pureWhite,
// //           border: Border.all(color: AppColors.divider),
// //           borderRadius: BorderRadius.circular(16),
// //         ),
// //         child: Row(
// //           children: [
// //             Container(
// //               width: 46,
// //               height: 46,
// //               decoration: BoxDecoration(
// //                 color: AppColors.inputFill,
// //                 borderRadius: BorderRadius.circular(12),
// //               ),
// //               child: Icon(icon, color: AppColors.textPrimary, size: 24),
// //             ),
// //             const SizedBox(width: 14),
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     title,
// //                     style: const TextStyle(
// //                       fontSize: 15,
// //                       fontWeight: FontWeight.w600,
// //                       color: AppColors.textPrimary,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 2),
// //                   Text(
// //                     subtitle,
// //                     style: const TextStyle(
// //                       fontSize: 12,
// //                       color: AppColors.textSecondary,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             const Icon(Icons.chevron_right, color: AppColors.textHint),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// //import '../../../../core/constants/app_colors.dart';
// import '../../../../core/routes/route_names.dart';
// import 'package:rento_india/delivery/core/constants/app_colors.dart';

// class RoleSelectionScreen extends StatelessWidget {
//   const RoleSelectionScreen({super.key});

//   void _onRoleSelected(BuildContext context, String role) {
//     switch (role) {
//       case 'rider':
//         Navigator.of(context).pushNamed(RouteNames.riderRegistration);
//         break;
//       case 'customer':
//         Navigator.of(context).pushNamed(RouteNames.customerCommonInfo);
//         break;
//       case 'myhouse_owner':
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('MyHouse Owner flow — built by your teammate'),
//           ),
//         );
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.scaffoldLight,
//       appBar: AppBar(
//         backgroundColor: AppColors.scaffoldLight,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const SizedBox(height: 8),
//               const Text(
//                 'Choose Your Role',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimary,
//                 ),
//               ),
//               const SizedBox(height: 6),
//               const Text(
//                 'Select how you want to use Rento India',
//                 style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
//               ),
//               const SizedBox(height: 16),

//               // Woman illustration
//               Center(
//                 child: Image.asset(
//                   'assets/images/rental/verification/woman_phone.png',
//                   width: 200,
//                 ),
//               ),

//               const SizedBox(height: 20),
//               _RoleCard(
//                 icon: Icons.person_outline,
//                 title: 'Customer',
//                 subtitle: 'Rent products easily',
//                 onTap: () => _onRoleSelected(context, 'customer'),
//               ),
//               const SizedBox(height: 14),
//               _RoleCard(
//                 icon: Icons.home_outlined,
//                 title: 'MyHouse Owner',
//                 subtitle: 'List your house and earn more',
//                 onTap: () => _onRoleSelected(context, 'myhouse_owner'),
//               ),
//               const SizedBox(height: 14),
//               _RoleCard(
//                 icon: Icons.two_wheeler_outlined,
//                 title: 'Rider',
//                 subtitle: 'Deliver products and earn',
//                 onTap: () => _onRoleSelected(context, 'rider'),
//               ),
//               const SizedBox(height: 24),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _RoleCard extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   final VoidCallback onTap;

//   const _RoleCard({
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(16),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: AppColors.pureWhite,
//           border: Border.all(color: AppColors.divider),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Row(
//           children: [
//             Container(
//               width: 46,
//               height: 46,
//               decoration: BoxDecoration(
//                 color: AppColors.inputFill,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(icon, color: AppColors.textPrimary, size: 24),
//             ),
//             const SizedBox(width: 14),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textPrimary,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     subtitle,
//                     style: const TextStyle(
//                       fontSize: 12,
//                       color: AppColors.textSecondary,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Icon(Icons.chevron_right, color: AppColors.textHint),
//           ],
//         ),
//       ),
//     );
//   }
// }
