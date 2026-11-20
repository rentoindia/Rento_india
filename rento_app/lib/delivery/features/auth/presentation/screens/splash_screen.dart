// // import 'package:flutter/material.dart';
// // import '../../../../core/constants/app_colors.dart';
// // import '../../../../core/routes/route_names.dart';
// // import '../../../../core/widgets/wave_clipper.dart';
// // import '../../../../core/widgets/icon_bubble.dart';
// // import '../../../../core/widgets/product_glyph.dart';

// // /// Splash / Onboarding screen — dark background, product icons
// // /// orbiting the RENTO INDIA logo, page indicator dots, "Get Started".
// // ///
// // /// NOTE ON FIDELITY: the design uses real 3D-rendered product photos
// // /// (chair, camera, laptop, scooter, bike, washing machine, suitcase,
// // /// controller) and a custom RENTO "R" logo mark. Those are image
// // /// assets I don't have access to, so this screen uses Material icons
// // /// as stand-ins in the exact same positions/sizes. Once you export
// // /// the real PNGs from the design file, drop them into
// // /// assets/images/onboarding/ and swap ProductGlyph -> Image.asset
// // /// (the positioning code below does not need to change).
// // class SplashScreen extends StatefulWidget {
// //   const SplashScreen({super.key});

// //   @override
// //   State<SplashScreen> createState() => _SplashScreenState();
// // }

// // class _SplashScreenState extends State<SplashScreen> {
// //   int _activeDot = 0;

// //   void _onGetStarted() {
// //     Navigator.of(context).pushReplacementNamed(RouteNames.mobileEntry);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final size = MediaQuery.of(context).size;
// //     final panelHeight = size.height * 0.86;

// //     return Scaffold(
// //       backgroundColor: AppColors.pureWhite,
// //       body: Stack(
// //         children: [
// //           // Dark orbit panel with wavy bottom edge
// //           ClipPath(
// //             clipper: BottomWaveClipper(),
// //             child: Container(
// //               width: size.width,
// //               height: panelHeight,
// //               color: AppColors.pureBlack,
// //               child: _OrbitContent(size: size, panelHeight: panelHeight),
// //             ),
// //           ),

// //           // Page indicator dots + Get Started button (white area)
// //           Positioned(
// //             bottom: 40,
// //             left: 24,
// //             right: 24,
// //             child: Column(
// //               children: [
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: List.generate(3, (index) {
// //                     final isActive = index == _activeDot;
// //                     return AnimatedContainer(
// //                       duration: const Duration(milliseconds: 200),
// //                       margin: const EdgeInsets.symmetric(horizontal: 4),
// //                       width: isActive ? 20 : 6,
// //                       height: 6,
// //                       decoration: BoxDecoration(
// //                         color: isActive
// //                             ? AppColors.pureBlack
// //                             : AppColors.border,
// //                         borderRadius: BorderRadius.circular(3),
// //                       ),
// //                     );
// //                   }),
// //                 ),
// //                 const SizedBox(height: 24),
// //                 SizedBox(
// //                   width: double.infinity,
// //                   height: 56,
// //                   child: ElevatedButton(
// //                     onPressed: _onGetStarted,
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: AppColors.pureBlack,
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(30),
// //                       ),
// //                       elevation: 0,
// //                     ),
// //                     child: Row(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: const [
// //                         Text(
// //                           'Get Started',
// //                           style: TextStyle(
// //                             color: AppColors.pureWhite,
// //                             fontSize: 16,
// //                             fontWeight: FontWeight.w600,
// //                           ),
// //                         ),
// //                         SizedBox(width: 8),
// //                         Icon(
// //                           Icons.arrow_forward,
// //                           color: AppColors.pureWhite,
// //                           size: 20,
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // /// All the orbiting product glyphs + icon bubbles + center logo,
// // /// positioned with fractional offsets so it scales across devices.
// // class _OrbitContent extends StatelessWidget {
// //   final Size size;
// //   final double panelHeight;

// //   const _OrbitContent({required this.size, required this.panelHeight});

// //   @override
// //   Widget build(BuildContext context) {
// //     final w = size.width;
// //     final h = panelHeight;

// //     return Stack(
// //       children: [
// //         // Small circular icon bubbles
// //         Positioned(
// //           top: h * 0.10,
// //           left: w * 0.38,
// //           child: const IconBubble(icon: Icons.calendar_today_outlined),
// //         ),
// //         Positioned(
// //           top: h * 0.13,
// //           right: w * 0.14,
// //           child: const IconBubble(icon: Icons.vpn_key_outlined),
// //         ),
// //         Positioned(
// //           top: h * 0.29,
// //           left: w * 0.10,
// //           child: const IconBubble(icon: Icons.weekend_outlined),
// //         ),
// //         Positioned(
// //           top: h * 0.40,
// //           right: w * 0.10,
// //           child: const IconBubble(icon: Icons.home_outlined),
// //         ),
// //         Positioned(
// //           top: h * 0.66,
// //           left: w * 0.10,
// //           child: const IconBubble(icon: Icons.moped_outlined, diameter: 38),
// //         ),
// //         Positioned(
// //           top: h * 0.66,
// //           right: w * 0.16,
// //           child: const IconBubble(icon: Icons.sell_outlined, diameter: 38),
// //         ),

// //         // Larger "product photo" glyphs
// //         Positioned(
// //           top: h * 0.08,
// //           left: w * 0.10,
// //           child: const ProductGlyph(icon: Icons.chair_alt, size: 58),
// //         ),
// //         Positioned(
// //           top: h * 0.11,
// //           left: w * 0.42,
// //           child: const ProductGlyph(icon: Icons.camera_alt, size: 54),
// //         ),
// //         Positioned(
// //           top: h * 0.13,
// //           right: w * 0.04,
// //           child: const ProductGlyph(icon: Icons.laptop_mac, size: 62),
// //         ),
// //         Positioned(
// //           top: h * 0.32,
// //           left: w * 0.02,
// //           child: const ProductGlyph(icon: Icons.two_wheeler, size: 66),
// //         ),
// //         Positioned(
// //           top: h * 0.32,
// //           right: w * 0.02,
// //           child: const ProductGlyph(icon: Icons.headphones, size: 54),
// //         ),
// //         Positioned(
// //           top: h * 0.44,
// //           right: w * 0.06,
// //           child: const ProductGlyph(icon: Icons.pedal_bike, size: 66),
// //         ),
// //         Positioned(
// //           top: h * 0.56,
// //           left: w * 0.06,
// //           child: const ProductGlyph(
// //             icon: Icons.local_laundry_service,
// //             size: 54,
// //           ),
// //         ),
// //         Positioned(
// //           top: h * 0.58,
// //           left: w * 0.38,
// //           child: const ProductGlyph(icon: Icons.work_outline, size: 54),
// //         ),
// //         Positioned(
// //           top: h * 0.56,
// //           right: w * 0.10,
// //           child: const ProductGlyph(icon: Icons.sports_esports, size: 54),
// //         ),

// //         // Center logo + tagline
// //         Positioned(
// //           top: h * 0.30,
// //           left: 0,
// //           right: 0,
// //           child: Column(
// //             children: [
// //               Container(
// //                 width: 70,
// //                 height: 70,
// //                 decoration: BoxDecoration(
// //                   color: AppColors.pureWhite,
// //                   borderRadius: BorderRadius.circular(18),
// //                 ),
// //                 child: const Center(
// //                   child: Text(
// //                     'R',
// //                     style: TextStyle(
// //                       color: AppColors.pureBlack,
// //                       fontSize: 38,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 14),
// //               const Text(
// //                 'RENTO',
// //                 style: TextStyle(
// //                   color: AppColors.pureWhite,
// //                   fontSize: 30,
// //                   fontWeight: FontWeight.bold,
// //                   letterSpacing: 4,
// //                 ),
// //               ),
// //               const SizedBox(height: 2),
// //               const Text(
// //                 'I N D I A',
// //                 style: TextStyle(
// //                   color: AppColors.textHint,
// //                   fontSize: 12,
// //                   letterSpacing: 6,
// //                   fontWeight: FontWeight.w500,
// //                 ),
// //               ),
// //               const SizedBox(height: 14),
// //               const Text(
// //                 'Rent Anything.',
// //                 style: TextStyle(color: AppColors.pureWhite, fontSize: 15),
// //               ),
// //               const Text(
// //                 'Manage Everything.',
// //                 style: TextStyle(color: AppColors.pureWhite, fontSize: 15),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }

// // import 'package:flutter/material.dart';
// // import '../../../../core/constants/app_colors.dart';
// // import '../../../../core/routes/route_names.dart';
// // import '../../../../core/widgets/wave_clipper.dart';

// // /// Splash / Onboarding screen — dark background, real product photos
// // /// orbiting the RENTO INDIA logo, page indicator dots, "Get Started".
// // /// Uses the actual cropped assets from assets/images/onboarding/.
// // class SplashScreen extends StatefulWidget {
// //   const SplashScreen({super.key});

// //   @override
// //   State<SplashScreen> createState() => _SplashScreenState();
// // }

// // class _SplashScreenState extends State<SplashScreen> {
// //   int _activeDot = 0;

// //   void _onGetStarted() {
// //     Navigator.of(context).pushReplacementNamed(RouteNames.mobileEntry);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final size = MediaQuery.of(context).size;
// //     final panelHeight = size.height * 0.86;

// //     return Scaffold(
// //       backgroundColor: AppColors.pureWhite,
// //       body: Stack(
// //         children: [
// //           // Dark orbit panel with wavy bottom edge
// //           ClipPath(
// //             clipper: BottomWaveClipper(),
// //             child: Container(
// //               width: size.width,
// //               height: panelHeight,
// //               color: AppColors.pureBlack,
// //               child: _OrbitContent(size: size, panelHeight: panelHeight),
// //             ),
// //           ),

// //           // Page indicator dots + Get Started button (white area)
// //           Positioned(
// //             bottom: 40,
// //             left: 24,
// //             right: 24,
// //             child: Column(
// //               children: [
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: List.generate(3, (index) {
// //                     final isActive = index == _activeDot;
// //                     return AnimatedContainer(
// //                       duration: const Duration(milliseconds: 200),
// //                       margin: const EdgeInsets.symmetric(horizontal: 4),
// //                       width: isActive ? 20 : 6,
// //                       height: 6,
// //                       decoration: BoxDecoration(
// //                         color: isActive
// //                             ? AppColors.pureBlack
// //                             : AppColors.border,
// //                         borderRadius: BorderRadius.circular(3),
// //                       ),
// //                     );
// //                   }),
// //                 ),
// //                 const SizedBox(height: 24),
// //                 SizedBox(
// //                   width: double.infinity,
// //                   height: 56,
// //                   child: ElevatedButton(
// //                     onPressed: _onGetStarted,
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: AppColors.pureBlack,
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(30),
// //                       ),
// //                       elevation: 0,
// //                     ),
// //                     child: Row(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: const [
// //                         Text(
// //                           'Get Started',
// //                           style: TextStyle(
// //                             color: AppColors.pureWhite,
// //                             fontSize: 16,
// //                             fontWeight: FontWeight.w600,
// //                           ),
// //                         ),
// //                         SizedBox(width: 8),
// //                         Icon(
// //                           Icons.arrow_forward,
// //                           color: AppColors.pureWhite,
// //                           size: 20,
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // /// All the orbiting product glyphs + icon bubbles + center logo,
// // /// positioned with fractional offsets so it scales across devices.
// // class _OrbitContent extends StatelessWidget {
// //   final Size size;
// //   final double panelHeight;

// //   const _OrbitContent({required this.size, required this.panelHeight});

// //   @override
// //   Widget build(BuildContext context) {
// //     final w = size.width;
// //     final h = panelHeight;
// //     // Scale glyphs down on narrow phones so the ring never collides
// //     // with the centered logo column (which sits in the 30%-70% band).
// //     final scale = (w / 390).clamp(0.72, 1.0);

// //     return ClipRect(
// //       child: Stack(
// //         clipBehavior: Clip.hardEdge,
// //         children: [
// //           // Small circular icon bubbles — outer corners only
// //           Positioned(
// //             top: h * 0.07,
// //             left: w * 0.06,
// //             child: _OrbitAsset('calendar_icon.png', size: 46 * scale),
// //           ),
// //           Positioned(
// //             top: h * 0.09,
// //             right: w * 0.06,
// //             child: _OrbitAsset('key_icon.png', size: 46 * scale),
// //           ),
// //           Positioned(
// //             top: h * 0.46,
// //             left: w * 0.03,
// //             child: _OrbitAsset('sofa_icon.png', size: 46 * scale),
// //           ),
// //           Positioned(
// //             top: h * 0.46,
// //             right: w * 0.03,
// //             child: _OrbitAsset('home_icon.png', size: 46 * scale),
// //           ),
// //           Positioned(
// //             top: h * 0.68,
// //             left: w * 0.10,
// //             child: _OrbitAsset('scooter_mini_icon.png', size: 42 * scale),
// //           ),
// //           Positioned(
// //             top: h * 0.68,
// //             right: w * 0.12,
// //             child: _OrbitAsset('tag_icon.png', size: 42 * scale),
// //           ),

// //           // Larger real product photos — kept in the outer ring,
// //           // away from the center 26%-74% width band.
// //           Positioned(
// //             top: h * 0.05,
// //             left: w * 0.20,
// //             child: _OrbitAsset('chair.png', size: 62 * scale),
// //           ),
// //           Positioned(
// //             top: h * 0.05,
// //             right: w * 0.20,
// //             child: _OrbitAsset('laptop.png', size: 68 * scale),
// //           ),
// //           Positioned(
// //             top: h * 0.24,
// //             left: w * 0.02,
// //             child: _OrbitAsset('scooter.png', size: 76 * scale),
// //           ),
// //           Positioned(
// //             top: h * 0.24,
// //             right: w * 0.02,
// //             child: _OrbitAsset('headphones.png', size: 56 * scale),
// //           ),
// //           Positioned(
// //             top: h * 0.58,
// //             left: w * 0.20,
// //             child: _OrbitAsset('washing_machine.png', size: 58 * scale),
// //           ),
// //           Positioned(
// //             top: h * 0.58,
// //             right: w * 0.20,
// //             child: _OrbitAsset('controller.png', size: 58 * scale),
// //           ),
// //           Positioned(
// //             top: h * 0.74,
// //             left: w * 0.02,
// //             child: _OrbitAsset('suitcase.png', size: 54 * scale),
// //           ),
// //           Positioned(
// //             top: h * 0.74,
// //             right: w * 0.02,
// //             child: _OrbitAsset('bike.png', size: 70 * scale),
// //           ),

// //           // Center logo + tagline
// //           Positioned(
// //             top: h * 0.30,
// //             left: w * 0.20,
// //             right: w * 0.20,
// //             child: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 Container(
// //                   width: 70,
// //                   height: 70,
// //                   decoration: BoxDecoration(
// //                     color: AppColors.pureWhite,
// //                     borderRadius: BorderRadius.circular(18),
// //                   ),
// //                   child: const Center(
// //                     child: Text(
// //                       'R',
// //                       style: TextStyle(
// //                         color: AppColors.pureBlack,
// //                         fontSize: 38,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //                 const SizedBox(height: 14),
// //                 const Text(
// //                   'RENTO',
// //                   style: TextStyle(
// //                     color: AppColors.pureWhite,
// //                     fontSize: 30,
// //                     fontWeight: FontWeight.bold,
// //                     letterSpacing: 4,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 2),
// //                 const Text(
// //                   'I N D I A',
// //                   style: TextStyle(
// //                     color: AppColors.textHint,
// //                     fontSize: 12,
// //                     letterSpacing: 6,
// //                     fontWeight: FontWeight.w500,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 14),
// //                 const Text(
// //                   'Rent Anything.',
// //                   style: TextStyle(color: AppColors.pureWhite, fontSize: 15),
// //                 ),
// //                 const Text(
// //                   'Manage Everything.',
// //                   style: TextStyle(color: AppColors.pureWhite, fontSize: 15),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // /// Loads one of the cropped product/icon images from
// // /// assets/images/onboarding/. Backgrounds are already black in the
// // /// source crop, so they blend seamlessly into the dark splash panel.
// // class _OrbitAsset extends StatelessWidget {
// //   final String fileName;
// //   final double size;

// //   const _OrbitAsset(this.fileName, {required this.size});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Image.asset(
// //       'assets/images/onboarding/$fileName',
// //       width: size,
// //       fit: BoxFit.contain,
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// //import '../../../../core/constants/app_colors.dart';
// import '../../../../core/routes/route_names.dart';
// import '../../../../core/widgets/wave_clipper.dart';
// import 'package:rento_india/delivery/core/constants/app_colors.dart';
// /// Splash / Onboarding screen — dark background, real product photos
// /// orbiting the RENTO INDIA logo, page indicator dots, "Get Started".
// /// Uses the actual cropped assets from assets/images/onboarding/.
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   int _activeDot = 0;

//   void _onGetStarted() {
//     Navigator.of(context).pushReplacementNamed(RouteNames.mobileEntry);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final panelHeight = size.height * 0.86;

//     return Scaffold(
//       backgroundColor: AppColors.pureWhite,
//       body: SafeArea(
//         bottom: true,
//         child: Column(
//           children: [
//             // Dark orbit panel with wavy bottom edge
//             Expanded(
//               child: ClipPath(
//                 clipper: BottomWaveClipper(),
//                 child: Container(
//                   width: size.width,
//                   color: AppColors.pureBlack,
//                   child: _OrbitContent(size: size, panelHeight: panelHeight),
//                 ),
//               ),
//             ),

//             // Page indicator dots + Get Started button — pinned to the
//             // bottom of the white area, respecting the safe area so it
//             // never sits under the home indicator / gesture bar.
//             Padding(
//               padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: List.generate(3, (index) {
//                       final isActive = index == _activeDot;
//                       return AnimatedContainer(
//                         duration: const Duration(milliseconds: 200),
//                         margin: const EdgeInsets.symmetric(horizontal: 4),
//                         width: isActive ? 20 : 6,
//                         height: 6,
//                         decoration: BoxDecoration(
//                           color: isActive
//                               ? AppColors.pureBlack
//                               : AppColors.border,
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                       );
//                     }),
//                   ),
//                   const SizedBox(height: 20),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 56,
//                     child: ElevatedButton(
//                       onPressed: _onGetStarted,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.pureBlack,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         elevation: 0,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: const [
//                           Text(
//                             'Get Started',
//                             style: TextStyle(
//                               color: AppColors.pureWhite,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           SizedBox(width: 8),
//                           Icon(
//                             Icons.arrow_forward,
//                             color: AppColors.pureWhite,
//                             size: 20,
//                           ),
//                         ],
//                       ),
//                     ),
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

// /// All the orbiting product glyphs + icon bubbles + center logo,
// /// positioned with fractional offsets so it scales across devices.
// class _OrbitContent extends StatelessWidget {
//   final Size size;
//   final double panelHeight;

//   const _OrbitContent({required this.size, required this.panelHeight});

//   @override
//   Widget build(BuildContext context) {
//     final w = size.width;
//     final h = panelHeight;
//     // Scale glyphs down on narrow phones so the ring never collides
//     // with the centered logo column (which sits in the 30%-70% band).
//     final scale = (w / 390).clamp(0.72, 1.0);

//     return ClipRect(
//       child: Stack(
//         clipBehavior: Clip.hardEdge,
//         children: [
//           // Small circular icon bubbles — outer corners only
//           Positioned(
//             top: h * 0.07,
//             left: w * 0.06,
//             child: _OrbitAsset('calendar_icon.png', size: 46 * scale),
//           ),
//           Positioned(
//             top: h * 0.09,
//             right: w * 0.06,
//             child: _OrbitAsset('key_icon.png', size: 46 * scale),
//           ),
//           Positioned(
//             top: h * 0.46,
//             left: w * 0.03,
//             child: _OrbitAsset('sofa_icon.png', size: 46 * scale),
//           ),
//           Positioned(
//             top: h * 0.46,
//             right: w * 0.03,
//             child: _OrbitAsset('home_icon.png', size: 46 * scale),
//           ),
//           Positioned(
//             top: h * 0.68,
//             left: w * 0.10,
//             child: _OrbitAsset('scooter_mini_icon.png', size: 42 * scale),
//           ),
//           Positioned(
//             top: h * 0.68,
//             right: w * 0.12,
//             child: _OrbitAsset('tag_icon.png', size: 42 * scale),
//           ),

//           // Larger real product photos — kept in the outer ring,
//           // away from the center 26%-74% width band.
//           Positioned(
//             top: h * 0.05,
//             left: w * 0.20,
//             child: _OrbitAsset('chair.png', size: 62 * scale),
//           ),
//           Positioned(
//             top: h * 0.05,
//             right: w * 0.20,
//             child: _OrbitAsset('laptop.png', size: 68 * scale),
//           ),
//           Positioned(
//             top: h * 0.24,
//             left: w * 0.02,
//             child: _OrbitAsset('scooter.png', size: 76 * scale),
//           ),
//           Positioned(
//             top: h * 0.24,
//             right: w * 0.02,
//             child: _OrbitAsset('headphones.png', size: 56 * scale),
//           ),
//           Positioned(
//             top: h * 0.58,
//             left: w * 0.20,
//             child: _OrbitAsset('washing_machine.png', size: 58 * scale),
//           ),
//           Positioned(
//             top: h * 0.58,
//             right: w * 0.20,
//             child: _OrbitAsset('controller.png', size: 58 * scale),
//           ),
//           Positioned(
//             top: h * 0.74,
//             left: w * 0.02,
//             child: _OrbitAsset('suitcase.png', size: 54 * scale),
//           ),
//           Positioned(
//             top: h * 0.74,
//             right: w * 0.02,
//             child: _OrbitAsset('bike.png', size: 70 * scale),
//           ),

//           // Center logo + tagline
//           Positioned(
//             top: h * 0.30,
//             left: w * 0.20,
//             right: w * 0.20,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   width: 70,
//                   height: 70,
//                   decoration: BoxDecoration(
//                     color: AppColors.pureWhite,
//                     borderRadius: BorderRadius.circular(18),
//                   ),
//                   child: const Center(
//                     child: Text(
//                       'R',
//                       style: TextStyle(
//                         color: AppColors.pureBlack,
//                         fontSize: 38,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 14),
//                 const Text(
//                   'RENTO',
//                   style: TextStyle(
//                     color: AppColors.pureWhite,
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 4,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 const Text(
//                   'I N D I A',
//                   style: TextStyle(
//                     color: AppColors.textHint,
//                     fontSize: 12,
//                     letterSpacing: 6,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 14),
//                 const Text(
//                   'Rent Anything.',
//                   style: TextStyle(color: AppColors.pureWhite, fontSize: 15),
//                 ),
//                 const Text(
//                   'Manage Everything.',
//                   style: TextStyle(color: AppColors.pureWhite, fontSize: 15),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// /// Loads one of the cropped product/icon images from
// /// assets/images/onboarding/. Backgrounds are already black in the
// /// source crop, so they blend seamlessly into the dark splash panel.
// class _OrbitAsset extends StatelessWidget {
//   final String fileName;
//   final double size;

//   const _OrbitAsset(this.fileName, {required this.size});

//   @override
//   Widget build(BuildContext context) {
//     return Image.asset(
//       'assets/images/rental/onboarding/$fileName',
//       width: size,
//       fit: BoxFit.contain,
//     );
//   }
// }
