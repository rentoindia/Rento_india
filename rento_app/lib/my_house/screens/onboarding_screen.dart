// import 'package:flutter/material.dart';
// import 'my_house_home_screen.dart';

// /// Onboarding / intro screen shown before the Home screen.
// /// Dark canvas with scattered "rentable item" photos orbiting the
// /// RENTO INDIA logo, and a white wave sheet at the bottom with the
// /// "Get Started" CTA that takes the user into the app (Home screen).
// class OnboardingScreen extends StatelessWidget {
//   const OnboardingScreen({super.key});

//   static const Color bgDark = Color(0xFF0A0A12);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: bgDark,
//       body: Stack(
//         children: [
//           // Base dark canvas
//           Container(color: bgDark),

//           // Faint concentric orbit rings behind the scattered items
//           const _OrbitRings(),

//           // Scattered product photos + small icon badges, positioned
//           // fractionally so they scale with screen size.
//           LayoutBuilder(
//             builder: (context, constraints) {
//               final w = constraints.maxWidth;
//               final h = constraints.maxHeight;
//               return Stack(
//                 children: [
//                   _item(w, h, 0.05, 0.07, 40, const _IconBadge(Icons.calendar_today_rounded)),
//                   _item(w, h, 0.72, 0.09, 40, const _IconBadge(Icons.vpn_key_rounded)),

//                   _item(w, h, 0.02, 0.10, 165, const _PhotoCard(
//                     url: 'https://images.unsplash.com/photo-1567538096630-e0c55bd6374c',
//                     fallback: Icons.chair_rounded,
//                   )),
//                   _item(w, h, 0.40, 0.10, 130, const _PhotoCard(
//                     url: 'https://images.unsplash.com/photo-1502920917128-1aa500764cbd',
//                     fallback: Icons.camera_alt_rounded,
//                   )),
//                   _item(w, h, 0.62, 0.17, 150, const _PhotoCard(
//                     url: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853',
//                     fallback: Icons.laptop_mac_rounded,
//                   )),

//                   _item(w, h, 0.03, 0.25, 40, const _IconBadge(Icons.directions_car_filled_rounded)),
//                   _item(w, h, 0.87, 0.23, 40, const _IconBadge(Icons.home_rounded)),

//                   _item(w, h, -0.02, 0.36, 165, const _PhotoCard(
//                     url: 'https://images.unsplash.com/photo-1591637333472-1a3c8b1a6dc3',
//                     fallback: Icons.two_wheeler_rounded,
//                   )),
//                   _item(w, h, 0.78, 0.32, 130, const _PhotoCard(
//                     url: 'https://images.unsplash.com/photo-1546435770-a3e426bf472b',
//                     fallback: Icons.headphones_rounded,
//                   )),

//                   _item(w, h, 0.68, 0.49, 170, const _PhotoCard(
//                     url: 'https://images.unsplash.com/photo-1485965120184-e220f721d03e',
//                     fallback: Icons.pedal_bike_rounded,
//                   )),
//                   _item(w, h, 0.02, 0.58, 150, const _PhotoCard(
//                     url: 'https://images.unsplash.com/photo-1626806787461-102c1bfaaea1',
//                     fallback: Icons.local_laundry_service_rounded,
//                   )),
//                   _item(w, h, 0.34, 0.63, 130, const _PhotoCard(
//                     url: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62',
//                     fallback: Icons.luggage_rounded,
//                   )),
//                   _item(w, h, 0.65, 0.62, 130, const _PhotoCard(
//                     url: 'https://images.unsplash.com/photo-1592840331293-c8399c11d419',
//                     fallback: Icons.sports_esports_rounded,
//                   )),

//                   _item(w, h, 0.06, 0.72, 40, const _IconBadge(Icons.moped_rounded)),
//                   _item(w, h, 0.68, 0.76, 40, const _IconBadge(Icons.sell_rounded)),
//                 ],
//               );
//             },
//           ),

//           // Center logo block
//           const Align(
//             alignment: Alignment(0, -0.22),
//             child: _LogoBlock(),
//           ),

//           // Bottom wave sheet with dots + Get Started button
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: _BottomSheetWave(
//               onGetStarted: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => const myhousehomescreen()),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Positions a child using fractional left/top of the available area.
//   static Widget _item(double w, double h, double leftFrac, double topFrac, double size, Widget child) {
//     return Positioned(
//       left: w * leftFrac,
//       top: h * topFrac,
//       child: SizedBox(width: size, height: size, child: child),
//     );
//   }
// }

// class _LogoBlock extends StatelessWidget {
//   const _LogoBlock();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         // Stylised "R" mark
//         Container(
//           width: 62,
//           height: 62,
//           alignment: Alignment.center,
//           child: const Text(
//             'R',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 58,
//               fontWeight: FontWeight.w900,
//               height: 1,
//             ),
//           ),
//         ),
//         const SizedBox(height: 6),
//         const Text(
//           'RENTO',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 34,
//             fontWeight: FontWeight.w800,
//             letterSpacing: 6,
//           ),
//         ),
//         const SizedBox(height: 6),
//         Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(width: 26, height: 1, color: Colors.white38),
//             const SizedBox(width: 8),
//             const Text(
//               'INDIA',
//               style: TextStyle(
//                 color: Colors.white70,
//                 fontSize: 13,
//                 fontWeight: FontWeight.w600,
//                 letterSpacing: 4,
//               ),
//             ),
//             const SizedBox(width: 8),
//             Container(width: 26, height: 1, color: Colors.white38),
//           ],
//         ),
//         const SizedBox(height: 18),
//         const Text(
//           'Rent Anything.\nManage Everything.',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 17,
//             fontWeight: FontWeight.w500,
//             height: 1.4,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _IconBadge extends StatelessWidget {
//   final IconData icon;
//   const _IconBadge(this.icon);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.08),
//         shape: BoxShape.circle,
//         border: Border.all(color: Colors.white.withOpacity(0.15)),
//       ),
//       child: Icon(icon, color: Colors.white, size: 18),
//     );
//   }
// }

// class _PhotoCard extends StatelessWidget {
//   final String url;
//   final IconData fallback;
//   const _PhotoCard({required this.url, required this.fallback});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.5),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(14),
//         child: Image.network(
//           url,
//           fit: BoxFit.cover,
//           errorBuilder: (context, error, stackTrace) => Container(
//             color: const Color(0xFF1C1C28),
//             alignment: Alignment.center,
//             child: Icon(fallback, color: Colors.white54, size: 34),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _OrbitRings extends StatelessWidget {
//   const _OrbitRings();

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: const Alignment(0, -0.22),
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           _ring(340),
//           _ring(260),
//           _ring(180),
//         ],
//       ),
//     );
//   }

//   Widget _ring(double size) {
//     return Container(
//       width: size,
//       height: size,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(color: Colors.white.withOpacity(0.06)),
//       ),
//     );
//   }
// }

// class _BottomSheetWave extends StatelessWidget {
//   final VoidCallback onGetStarted;
//   const _BottomSheetWave({required this.onGetStarted});

//   @override
//   Widget build(BuildContext context) {
//     return ClipPath(
//       clipper: _WaveClipper(),
//       child: Container(
//         width: double.infinity,
//         color: Colors.white,
//         padding: const EdgeInsets.fromLTRB(24, 48, 24, 36),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _dot(true),
//                 const SizedBox(width: 6),
//                 _dot(false),
//                 const SizedBox(width: 6),
//                 _dot(false),
//               ],
//             ),
//             const SizedBox(height: 22),
//             SizedBox(
//               width: double.infinity,
//               height: 56,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: Colors.black,
//                   elevation: 4,
//                   shadowColor: Colors.black26,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     side: const BorderSide(color: Color(0xFFECECEC)),
//                   ),
//                 ),
//                 onPressed: onGetStarted,
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Get Started',
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
//                     ),
//                     SizedBox(width: 10),
//                     Icon(Icons.arrow_forward_rounded, size: 20, color: Colors.black),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _dot(bool active) {
//     return Container(
//       width: active ? 9 : 7,
//       height: active ? 9 : 7,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: active ? Colors.black87 : Colors.black26,
//       ),
//     );
//   }
// }

// /// Draws the soft double-wave curve at the top edge of the bottom sheet.
// class _WaveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     path.lineTo(0, 40);
//     path.cubicTo(
//       size.width * 0.22, 0,
//       size.width * 0.30, 90,
//       size.width * 0.52, 55,
//     );
//     path.cubicTo(
//       size.width * 0.75, 20,
//       size.width * 0.85, 70,
//       size.width, 25,
//     );
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
// }