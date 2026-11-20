// import 'package:flutter/material.dart';
// import 'my_house_home_screen.dart';
// import 'search_property_screen.dart';
// import 'chat_screen.dart';
// import 'profile_screen.dart';

// class portalselectionscreen extends StatefulWidget {
//   const portalselectionscreen({super.key});

//   @override
//   State<portalselectionscreen> createState() => _PortalSelectionScreenState();
// }

// class _PortalSelectionScreenState extends State<portalselectionscreen> {
//   static const Color primaryDark = Color(0xFF1A1A1A);
//   int currentNavIndex = 0;

//   Widget _portalCard({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 16),
//         padding: const EdgeInsets.all(18),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(18),
//           boxShadow: [
//             BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 14, offset: const Offset(0, 4)),
//           ],
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(color: const Color(0xFFF0F0F0), borderRadius: BorderRadius.circular(14)),
//               child: Icon(icon, color: primaryDark, size: 26),
//             ),
//             const SizedBox(width: 14),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 4),
//                   Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
//                 ],
//               ),
//             ),
//             const Icon(Icons.chevron_right_rounded, color: Colors.grey),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F7F7),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 10),
//               const Text('Choose a Portal', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 20),
//               _portalCard(
//                 icon: Icons.person_outline_rounded,
//                 title: 'Customer Portal',
//                 subtitle: 'Rent Products & Book Services',
//                 onTap: () {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Customer Portal — coming soon')),
//                   );
//                 },
//               ),
//               _portalCard(
//                 icon: Icons.home_outlined,
//                 title: 'Tenant Portal',
//                 subtitle: 'Manage Property, Pay Rent & Maintenance',
//                 onTap: () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) => const myhousehomescreen()),
//                   );
//                 },
//               ),
//               _portalCard(
//                 icon: Icons.two_wheeler_outlined,
//                 title: 'Delivery Portal',
//                 subtitle: 'Deliver Orders & Earn with Rento',
//                 onTap: () {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Delivery Portal — coming soon')),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),

//       // ✅ Bottom nav moved here from Home Screen
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 12, offset: const Offset(0, -2))],
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _navItem(Icons.home, 'Home', 0),
//                 _navItem(Icons.search, 'Search', 1),
//                 _navAddButton(),
//                 _navItem(Icons.chat_bubble_outline, 'Chat', 3),
//                 _navItem(Icons.person_outline, 'Profile', 4),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _navItem(IconData icon, String label, int index) {
//     final bool selected = currentNavIndex == index;
//     return GestureDetector(
//       onTap: () {
//         setState(() => currentNavIndex = index);
//         if (index == 0) {
//           Navigator.push(context, MaterialPageRoute(builder: (context) => const myhousehomescreen()));
//         } else if (index == 1) {
//           Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPropertyScreen()));
//         } else if (index == 3) {
//           Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatScreen()));
//         } else if (index == 4) {
//           Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
//         }
//       },
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 22, color: selected ? primaryDark : Colors.grey),
//           const SizedBox(height: 4),
//           Text(label, style: TextStyle(fontSize: 11, color: selected ? primaryDark : Colors.grey)),
//         ],
//       ),
//     );
//   }

//   Widget _navAddButton() {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(color: primaryDark, borderRadius: BorderRadius.circular(10)),
//           child: const Icon(Icons.add, size: 20, color: Colors.white),
//         ),
//         const SizedBox(height: 4),
//         const Text('Add Property', style: TextStyle(fontSize: 10, color: primaryDark)),
//       ],
//     );
//   }
// }