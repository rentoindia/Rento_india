// import 'package:flutter/material.dart';
// import 'home_screen.dart'; 

// class PortalSelectionScreen extends StatelessWidget {
//   const PortalSelectionScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           Positioned(
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: Image.asset(
//               'assets/images/skyline.png',
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//           SafeArea(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 8),
//                   _PortalCard(
//                     imagePath: 'assets/images/chair_camera.png',
//                     badgeIcon: Icons.person_outline,
//                     title: 'Customer Portal',
//                     subtitle: 'Rent Products &\nBook Services',
//                     onTap: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => const HomeScreen()),
//                     ),
//                   ),
//                   const SizedBox(height: 18),
//                   _PortalCard(
//                     imagePath: 'assets/images/house.png',
//                     badgeIcon: Icons.home_outlined,
//                     title: 'Tenant Portal',
//                     subtitle: 'Manage Property,\nPay Rent & Maintenance',
//                     onTap: () {},
//                   ),
//                   const SizedBox(height: 18),
//                   _PortalCard(
//                     imagePath: 'assets/images/scooty.png',
//                     badgeIcon: Icons.delivery_dining_outlined,
//                     title: 'Delivery Portal',
//                     subtitle: 'Deliver Orders &\nEarn with Rento',
//                     onTap: () {},
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _PortalCard extends StatelessWidget {
//   final String imagePath;
//   final IconData badgeIcon;
//   final String title;
//   final String subtitle;
//   final VoidCallback onTap;

//   const _PortalCard({
//     required this.imagePath,
//     required this.badgeIcon,
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
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: const Color(0xFFEDEDED)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 12,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: IntrinsicHeight(
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               ClipRRect(
//   borderRadius: const BorderRadius.horizontal(
//     left: Radius.circular(16),
//   ),
//   child: Container(
//     width: 135,
//     height: 135,
//     color: const Color(0xFFF7F7F7),
//     padding: const EdgeInsets.all(8),
//     child: Image.asset(
//       imagePath,
//       fit: BoxFit.contain,
//       errorBuilder: (context, error, stackTrace) => Container(
//         color: const Color(0xFFF7F7F7),
//         alignment: Alignment.center,
//         child: const Icon(Icons.broken_image_outlined,
//             color: Colors.redAccent, size: 28),
//       ),
//     ),
//   ),
// ),
//               Expanded(
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Icon(badgeIcon, size: 18, color: Colors.black87),
//                             const SizedBox(height: 6),
//                             Text(
//                               title,
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 15,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               subtitle,
//                               style: const TextStyle(
//                                 color: Color(0xFF8A8A8A),
//                                 fontSize: 12,
//                                 height: 1.3,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const Icon(Icons.chevron_right,
//                           color: Color(0xFFB0B0B0), size: 20),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }