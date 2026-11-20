// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'onboarding_screen.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(seconds: 2), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const OnboardingScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF1A1A2E),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: const Icon(
//                 Icons.home_work_rounded,
//                 size: 60,
//                 color: Color(0xFF1A1A2E),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'RENTO',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 2,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Find Your Perfect Home',
//               style: TextStyle(
//                 color: Colors.white.withOpacity(0.8),
//                 fontSize: 14,
//               ),
//             ),
//             const SizedBox(height: 40),
//             const CircularProgressIndicator(
//               color: Colors.white,
//               strokeWidth: 2,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }