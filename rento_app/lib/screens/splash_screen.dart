// // // // import 'package:flutter/material.dart';
// // // // import '../widgets/primary_button.dart';
// // // // import 'portal_selection_screen.dart';

// // // // class SplashScreen extends StatelessWidget {
// // // //   const SplashScreen({super.key});

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       backgroundColor: Colors.black,
// // // //       body: SafeArea(
// // // //         child: Padding(
// // // //           padding: const EdgeInsets.all(24),
// // // //           child: Column(
// // // //             children: [
// // // //               const Spacer(),
// // // //               Column(
// // // //                 children: [
// // // //                   const Icon(Icons.change_history,
// // // //                       color: Colors.white, size: 56),
// // // //                   const SizedBox(height: 8),
// // // //                   const Text(
// // // //                     'RENTO',
// // // //                     style: TextStyle(
// // // //                       color: Colors.white,
// // // //                       fontSize: 34,
// // // //                       fontWeight: FontWeight.bold,
// // // //                       letterSpacing: 4,
// // // //                     ),
// // // //                   ),
// // // //                   Text(
// // // //                     'I N D I A',
// // // //                     style: TextStyle(
// // // //                       color: Colors.white.withOpacity(0.7),
// // // //                       fontSize: 12,
// // // //                       letterSpacing: 6,
// // // //                     ),
// // // //                   ),
// // // //                   const SizedBox(height: 16),
// // // //                   const Text(
// // // //                     'Rent Anything.\nManage Everything.',
// // // //                     textAlign: TextAlign.center,
// // // //                     style: TextStyle(
// // // //                       color: Colors.white,
// // // //                       fontSize: 20,
// // // //                       fontWeight: FontWeight.w600,
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //               const Spacer(),
// // // //               PrimaryButton(
// // // //                 label: 'GET STARTED',
// // // //                 icon: Icons.arrow_forward,
// // // //                 onPressed: () {
// // // //                   Navigator.of(context).push(
// // // //                     MaterialPageRoute(
// // // //                       builder: (_) => const PortalSelectionScreen(),
// // // //                     ),
// // // //                   );
// // // //                 },
// // // //               ),
// // // //               const SizedBox(height: 8),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // import 'package:flutter/material.dart';
// // // import 'portal_selection_screen.dart';

// // // class SplashScreen extends StatelessWidget {
// // //   const SplashScreen({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: Stack(
// // //         children: [

// // //           SizedBox.expand(
// // //             child: Image.asset(
// // //               'assets/images/splash.png',
// // //               fit: BoxFit.cover,
// // //             ),
// // //           ),

// // //           Align(
// // //             alignment: Alignment.bottomCenter,
// // //             child: Padding(
// // //               padding: const EdgeInsets.only(bottom: 35),
// // //               child: SizedBox(
// // //                 width: 300,
// // //                 height: 70,
// // //                 child: Material(
// // //                   color: Colors.transparent,
// // //                   child: InkWell(
// // //                     borderRadius: BorderRadius.circular(40),
// // //                     onTap: () {
// // //                       Navigator.push(
// // //                         context,
// // //                         MaterialPageRoute(
// // //                           builder: (_) => const PortalSelectionScreen(),
// // //                         ),
// // //                       );
// // //                     },
// // //                   ),
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // // import 'package:flutter/material.dart';
// // // import 'portal_selection_screen.dart';

// // // class SplashScreen extends StatelessWidget {
// // //   const SplashScreen({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.black,
// // //       // body: Stack(
// // //       //   children: [
// // //       //     // Splash Image
// // //       //     Positioned.fill(
// // //       //       child: Image.asset(
// // //       //         'assets/images/splash.png',
// // //       //         fit: BoxFit.cover,
// // //       //         alignment: Alignment.topCenter, // Shows more of the top
// // //       //       ),
// // //       //     ),

// // //       //     // Invisible clickable area over the Get Started button
// // //       //     Positioned(
// // //       //       left: 30,
// // //       //       right: 30,
// // //       //       bottom: 30,
// // //       //       height: 65,
// // //       //       child: GestureDetector(
// // //       //         onTap: () {
// // //       //           Navigator.push(
// // //       //             context,
// // //       //             MaterialPageRoute(
// // //       //               builder: (context) => const PortalSelectionScreen(),
// // //       //             ),
// // //       //           );
// // //       //         },
// // //       //         child: Container(
// // //       //           color: Colors.transparent,
// // //       //         ),
// // //       //       ),
// // //       //     ),
// // //       //   ],
// // //       // ),

// // //       body: Stack(
// // //   children: [

// // //     // Full image without cropping
// // //     Center(
// // //       child: Image.asset(
// // //         'assets/images/splash.png',
// // //         width: MediaQuery.of(context).size.height,
// // //         fit: BoxFit.fitWidth,
// // //       ),
// // //     ),

// // //     // Click area over Get Started
// // //     Positioned(
// // //       left: 30,
// // //       right: 30,
// // //       bottom: 25,
// // //       height: 60,
// // //       child: GestureDetector(
// // //         behavior: HitTestBehavior.translucent,
// // //         onTap: () {
// // //           Navigator.push(
// // //             context,
// // //             MaterialPageRoute(
// // //               builder: (_) => const PortalSelectionScreen(),
// // //             ),
// // //           );
// // //         },
// // //         child: Container(color: Colors.transparent),
// // //       ),
// // //     ),
// // //   ],
// // // ),
// // //     );
// // //   }
// // // }

// // // import 'package:flutter/material.dart';
// // // import 'portal_selection_screen.dart';

// // // class SplashScreen extends StatelessWidget {
// // //   const SplashScreen({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final size = MediaQuery.of(context).size;

// // //     return Scaffold(
// // //       backgroundColor: Colors.black,
// // //       body: Stack(
// // //         children: [
// // //           // Full image without cropping
// // //           Center(
// // //             child: Image.asset(
// // //               'assets/images/splash.png',
// // //               width: size.width,
// // //               fit: BoxFit.fitWidth,
// // //             ),
// // //           ),

// // //           // Visible "Get Started" button
// // //           Positioned(
// // //             left: 24,
// // //             right: 24,
// // //             bottom: 30,
// // //             child: SafeArea(
// // //               top: false,
// // //               child: SizedBox(
// // //                 width: double.infinity,
// // //                 height: 56,
// // //                 child: ElevatedButton(
// // //                   onPressed: () {
// // //                     Navigator.push(
// // //                       context,
// // //                       MaterialPageRoute(
// // //                         builder: (_) => const PortalSelectionScreen(),
// // //                       ),
// // //                     );
// // //                   },
// // //                   style: ElevatedButton.styleFrom(
// // //                     backgroundColor: Colors.white,
// // //                     shape: RoundedRectangleBorder(
// // //                       borderRadius: BorderRadius.circular(30),
// // //                     ),
// // //                     elevation: 4,
// // //                     shadowColor: Colors.black54,
// // //                   ),
// // //                   child: Row(
// // //                     mainAxisAlignment: MainAxisAlignment.center,
// // //                     children: const [
// // //                       Text(
// // //                         'Get Started',
// // //                         style: TextStyle(
// // //                           color: Colors.black,
// // //                           fontSize: 16,
// // //                           fontWeight: FontWeight.w600,
// // //                         ),
// // //                       ),
// // //                       SizedBox(width: 8),
// // //                       Icon(Icons.arrow_forward, color: Colors.black, size: 18),
// // //                     ],
// // //                   ),
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'portal_selection_screen.dart';

// // class SplashScreen extends StatelessWidget {
// //   const SplashScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final size = MediaQuery.of(context).size;

// //     return Scaffold(
// //       backgroundColor: Colors.black,
// //       body: Stack(
// //         children: [
// //           // Background image — fills the screen without distortion
// //           Positioned.fill(
// //             child: Image.asset(
// //               'assets/images/splash.png',
// //               fit: BoxFit.cover,
// //               alignment: Alignment.topCenter,
// //             ),
// //           ),

// //           // Visible "Get Started" button at the bottom
// //           Positioned(
// //             left: 24,
// //             right: 24,
// //             bottom: 30,
// //             child: SafeArea(
// //               top: false,
// //               child: SizedBox(
// //                 width: double.infinity,
// //                 height: 56,
// //                 child: ElevatedButton(
// //                   onPressed: () {
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                         builder: (_) => const PortalSelectionScreen(),
// //                       ),
// //                     );
// //                   },
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.white,
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(30),
// //                     ),
// //                     elevation: 4,
// //                     shadowColor: Colors.black54,
// //                   ),
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: const [
// //                       Text(
// //                         'Get Started',
// //                         style: TextStyle(
// //                           color: Colors.black,
// //                           fontSize: 16,
// //                           fontWeight: FontWeight.w600,
// //                         ),
// //                       ),
// //                       SizedBox(width: 8),
// //                       Icon(Icons.arrow_forward, color: Colors.black, size: 18),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'login_screen.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           // Background image — scales to fill the screen fully,
//           // no cropping on any edge, centered on all device sizes.
//           Positioned.fill(
//             child: Image.asset(
//               'assets/images/rental/splash1.png',
//               fit: BoxFit.cover,
//               alignment: Alignment.center,
//             ),
//           ),

//           // Visible "Get Started" button at the bottom
//           Positioned(
//             left: 24,
//             right: 24,
//             bottom: 30,
//             child: SafeArea(
//               top: false,
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 56,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => const LoginScreen(),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     elevation: 4,
//                     shadowColor: Colors.black54,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       Text(
//                         'Get Started',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       SizedBox(width: 8),
//                       Icon(Icons.arrow_forward, color: Colors.black, size: 18),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background image — scales to fill the screen fully,
          // no cropping on any edge, centered on all device sizes.
          Positioned.fill(
            child: Image.asset(
              'assets/images/rental/splash1.png',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),

          // NEW: centered logo, layered on top of the background —
          // this is the new Rento India logo (location-pin mark +
          // "Rento India" wordmark + tagline), replacing whatever was
          // shown at the center before.
          // Align(
          //   alignment: const Alignment(0, -0.05),
          //   child: Image.asset(
          //     'assets/images/rento_india_Logo.png',
          //     width: 240,
          //     fit: BoxFit.contain,
          //   ),
          // ),

          // Visible "Get Started" button at the bottom
          Positioned(
            left: 24,
            right: 24,
            bottom: 30,
            child: SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const LoginScreen()),   // ✅ no const
  );
},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 4,
                    shadowColor: Colors.black54,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Get Started',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.black, size: 18),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
