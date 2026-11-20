// // import 'package:flutter/material.dart';
// // import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// // import 'otp_screen.dart';

// // class LoginScreen extends StatefulWidget {
// //   const LoginScreen({super.key});

// //   @override
// //   State<LoginScreen> createState() => _LoginScreenState();
// // }

// // class _LoginScreenState extends State<LoginScreen> {
// //   final _phoneController = TextEditingController();
// //   String? _errorText;

// //   // Measured directly from the source image (853 x 1844 px).
// //   static const double imageAspectRatio = 853 / 1844;
// //   static const bool debugShowZones = false;

// //   void _handleSendOtp() {
// //     final phone = _phoneController.text.trim();
// //     if (phone.length != 10) {
// //       setState(() => _errorText = 'Enter a valid 10-digit mobile number');
// //       return;
// //     }
// //     setState(() => _errorText = null);
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(builder: (_) => OtpScreen(phoneNumber: phone)),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return LayoutBuilder(
// //       builder: (context, constraints) {
// //         final width = constraints.maxWidth;
// //         final height = width / imageAspectRatio;

// //         // All fractions below are pixel-measured / 853 (image width),
// //         // for BOTH x and y — this works because the image is displayed
// //         // at a fixed aspect ratio, so one consistent scale applies to
// //         // every axis. Do not mix in height-based fractions here.

// //         return Scaffold(
// //           backgroundColor: Colors.white,
// //           body: SafeArea(
// //             child: SingleChildScrollView(
// //               child: SizedBox(
// //                 width: width,
// //                 height: height,
// //                 child: Stack(
// //                   children: [
// //                     Positioned.fill(
// //                       child: Image.asset(
// //                         'assets/images/login_screen1.png',
// //                         fit: BoxFit.fill,
// //                       ),
// //                     ),

// //                     // Phone number field — sized to exactly match the
// //                     // measured placeholder box.
// //                     Positioned(
// //                       left: width * 0.08206,
// //                       right: width * 0.08558,
// //                       top: width * 1.39390,
// //                       height: width * 0.13012,
// //                       child: Container(
// //                         decoration: BoxDecoration(
// //                           color: debugShowZones ? Colors.red.withOpacity(0.3) : Colors.white,
// //                           borderRadius: BorderRadius.circular(28),
// //                           border: Border.all(color: const Color(0xFFE5E7EB)),
// //                         ),
// //                         child: Row(
// //                           children: [
// //                             const SizedBox(width: 18),
// //                             const Text('+91', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
// //                             const SizedBox(width: 10),
// //                             Container(width: 1, height: 18, color: Colors.grey.shade300),
// //                             const SizedBox(width: 10),
// //                             Expanded(
// //                               child: TextField(
// //                                 controller: _phoneController,
// //                                 keyboardType: TextInputType.phone,
// //                                 maxLength: 10,
// //                                 style: const TextStyle(fontSize: 14),
// //                                 decoration: const InputDecoration(
// //                                   counterText: '',
// //                                   hintText: 'Enter mobile number',
// //                                   border: InputBorder.none,
// //                                   isDense: true,
// //                                 ),
// //                               ),
// //                             ),
// //                             const SizedBox(width: 14),
// //                           ],
// //                         ),
// //                       ),
// //                     ),

// //                     if (_errorText != null)
// //                       Positioned(
// //                         left: width * 0.08206,
// //                         top: width * 1.39390 + width * 0.13012 + 4,
// //                         child: Text(
// //                           _errorText!,
// //                           style: const TextStyle(color: Colors.red, fontSize: 11),
// //                         ),
// //                       ),

// //                     // Send OTP button — sized to exactly match the
// //                     // measured placeholder box.
// //                     Positioned(
// //                       left: width * 0.08206,
// //                       right: width * 0.08676,
// //                       top: width * 1.55568,
// //                       height: width * 0.13364,
// //                       child: Material(
// //                         color: debugShowZones ? Colors.red.withOpacity(0.3) : Colors.black,
// //                         borderRadius: BorderRadius.circular(28),
// //                         child: InkWell(
// //                           borderRadius: BorderRadius.circular(28),
// //                           onTap: _handleSendOtp,
// //                           child: Center(
// //                             child: Row(
// //                               mainAxisSize: MainAxisSize.min,
// //                               children: const [
// //                                 Text(
// //                                   'Send OTP',
// //                                   style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
// //                                 ),
// //                                 SizedBox(width: 8),
// //                                 Icon(Icons.send, color: Colors.white, size: 14),
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ),

// //                     // Google — sized to exactly match the measured circle
// //                     Positioned(
// //                       left: width * 0.22098,
// //                       top: width * 1.81325,
// //                       width: width * 0.12661,
// //                       height: width * 0.12661,
// //                       child: _socialTapZone(
// //                         icon: FontAwesomeIcons.google,
// //                         color: const Color(0xFFEA4335),
// //                         debug: debugShowZones,
// //                         onTap: () => _showComingSoon(context, 'Google'),
// //                       ),
// //                     ),

// //                     // Apple — sized to exactly match the measured circle
// //                     Positioned(
// //                       left: width * 0.42438,
// //                       top: width * 1.81325,
// //                       width: width * 0.12661,
// //                       height: width * 0.12661,
// //                       child: _socialTapZone(
// //                         icon: FontAwesomeIcons.apple,
// //                         color: Colors.black,
// //                         debug: debugShowZones,
// //                         onTap: () => _showComingSoon(context, 'Apple'),
// //                       ),
// //                     ),

// //                     // WhatsApp — sized to exactly match the measured circle
// //                     Positioned(
// //                       left: width * 0.62544,
// //                       top: width * 1.81325,
// //                       width: width * 0.12661,
// //                       height: width * 0.12661,
// //                       child: _socialTapZone(
// //                         icon: FontAwesomeIcons.whatsapp,
// //                         color: const Color(0xFF25D366),
// //                         debug: debugShowZones,
// //                         onTap: () => _showComingSoon(context, 'WhatsApp'),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   Widget _socialTapZone({
// //     required IconData icon,
// //     required Color color,
// //     required bool debug,
// //     required VoidCallback onTap,
// //   }) {
// //     return Material(
// //       color: debug ? Colors.red.withOpacity(0.3) : Colors.white,
// //       shape: CircleBorder(
// //         side: BorderSide(color: debug ? Colors.transparent : const Color(0xFFE5E7EB)),
// //       ),
// //       child: InkWell(
// //         customBorder: const CircleBorder(),
// //         onTap: onTap,
// //         child: Center(child: Icon(icon, color: color, size: 18)),
// //       ),
// //     );
// //   }

// //   void _showComingSoon(BuildContext context, String provider) {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(content: Text('$provider login coming soon')),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'otp_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _phoneController = TextEditingController();
//   String? _errorText;

//   // Measured directly from the source image (853 x 1844 px).
//   static const double imageAspectRatio = 853 / 1844;
//   static const bool debugShowZones = false;

//   void _handleSendOtp() {
//     final phone = _phoneController.text.trim();
//     if (phone.length != 10) {
//       setState(() => _errorText = 'Enter a valid 10-digit mobile number');
//       return;
//     }
//     setState(() => _errorText = null);
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => OtpScreen(phoneNumber: phone)),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final width = constraints.maxWidth;
//         final height = width / imageAspectRatio;

//         // All fractions below are pixel-measured / 853 (image width),
//         // for BOTH x and y — this works because the image is displayed
//         // at a fixed aspect ratio, so one consistent scale applies to
//         // every axis. Do not mix in height-based fractions here.

//         return Scaffold(
//           backgroundColor: Colors.white,
//           body: SafeArea(
//             child: SingleChildScrollView(
//               child: SizedBox(
//                 width: width,
//                 height: height,
//                 child: Stack(
//                   children: [
//                     Positioned.fill(
//                       child: Image.asset(
//                         'assets/images/rental/login_screen1.png',
//                         fit: BoxFit.fill,
//                       ),
//                     ),

//                     // Phone number field — sized to exactly match the
//                     // measured placeholder box.
//                     Positioned(
//                       left: width * 0.08206,
//                       right: width * 0.08558,
//                       top: width * 1.39390,
//                       height: width * 0.13012,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: debugShowZones
//                               ? Colors.red.withOpacity(0.3)
//                               : Colors.white,
//                           borderRadius: BorderRadius.circular(28),
//                           border: Border.all(color: const Color(0xFFE5E7EB)),
//                         ),
//                         child: Row(
//                           children: [
//                             const SizedBox(width: 18),
//                             const Text(
//                               '+91',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 14,
//                               ),
//                             ),
//                             const SizedBox(width: 10),
//                             Container(
//                               width: 1,
//                               height: 18,
//                               color: Colors.grey.shade300,
//                             ),
//                             const SizedBox(width: 10),
//                             Expanded(
//                               child: TextField(
//                                 controller: _phoneController,
//                                 keyboardType: TextInputType.phone,
//                                 maxLength: 10,
//                                 style: const TextStyle(fontSize: 14),
//                                 decoration: const InputDecoration(
//                                   counterText: '',
//                                   hintText: 'Enter mobile number',
//                                   border: InputBorder.none,
//                                   isDense: true,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 14),
//                           ],
//                         ),
//                       ),
//                     ),

//                     if (_errorText != null)
//                       Positioned(
//                         left: width * 0.08206,
//                         top: width * 1.39390 + width * 0.13012 + 4,
//                         child: Text(
//                           _errorText!,
//                           style: const TextStyle(
//                             color: Colors.red,
//                             fontSize: 11,
//                           ),
//                         ),
//                       ),

//                     // Send OTP button — sized to exactly match the
//                     // measured placeholder box.
//                     // FIX: top was 1.55568, leaving only ~0.032*width
//                     // of clearance below the phone field — not enough
//                     // room for the red error message before it
//                     // visually collided with this button. Pushed down
//                     // to 1.60 for real breathing room; nothing else
//                     // (background image, social icons, phone field)
//                     // changed position.
//                     Positioned(
//                       left: width * 0.08206,
//                       right: width * 0.08676,
//                       top: width * 1.60000,
//                       height: width * 0.13364,
//                       child: Material(
//                         color: debugShowZones
//                             ? Colors.red.withOpacity(0.3)
//                             : Colors.black,
//                         borderRadius: BorderRadius.circular(28),
//                         child: InkWell(
//                           borderRadius: BorderRadius.circular(28),
//                           onTap: _handleSendOtp,
//                           child: Center(
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: const [
//                                 Text(
//                                   'Send OTP',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                                 SizedBox(width: 8),
//                                 Icon(Icons.send, color: Colors.white, size: 14),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),

//                     // Google — sized to exactly match the measured circle
//                     Positioned(
//                       left: width * 0.22098,
//                       top: width * 1.81325,
//                       width: width * 0.12661,
//                       height: width * 0.12661,
//                       child: _socialTapZone(
//                         icon: FontAwesomeIcons.google,
//                         color: const Color(0xFFEA4335),
//                         debug: debugShowZones,
//                         onTap: () => _showComingSoon(context, 'Google'),
//                       ),
//                     ),

//                     // Apple — sized to exactly match the measured circle
//                     Positioned(
//                       left: width * 0.42438,
//                       top: width * 1.81325,
//                       width: width * 0.12661,
//                       height: width * 0.12661,
//                       child: _socialTapZone(
//                         icon: FontAwesomeIcons.apple,
//                         color: Colors.black,
//                         debug: debugShowZones,
//                         onTap: () => _showComingSoon(context, 'Apple'),
//                       ),
//                     ),

//                     // WhatsApp — sized to exactly match the measured circle
//                     Positioned(
//                       left: width * 0.62544,
//                       top: width * 1.81325,
//                       width: width * 0.12661,
//                       height: width * 0.12661,
//                       child: _socialTapZone(
//                         icon: FontAwesomeIcons.whatsapp,
//                         color: const Color(0xFF25D366),
//                         debug: debugShowZones,
//                         onTap: () => _showComingSoon(context, 'WhatsApp'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _socialTapZone({
//     required IconData icon,
//     required Color color,
//     required bool debug,
//     required VoidCallback onTap,
//   }) {
//     return Material(
//       color: debug ? Colors.red.withOpacity(0.3) : Colors.white,
//       shape: CircleBorder(
//         side: BorderSide(
//           color: debug ? Colors.transparent : const Color(0xFFE5E7EB),
//         ),
//       ),
//       child: InkWell(
//         customBorder: const CircleBorder(),
//         onTap: onTap,
//         child: Center(child: Icon(icon, color: color, size: 18)),
//       ),
//     );
//   }

//   void _showComingSoon(BuildContext context, String provider) {
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text('$provider login coming soon')));
//   }
// }





import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  String? _errorText;

  // Measured directly from the source image (853 x 1844 px).
  static const double imageAspectRatio = 853 / 1844;
  static const bool debugShowZones = false;

  void _handleSendOtp() {
    final phone = _phoneController.text.trim();
    if (phone.length != 10) {
      setState(() => _errorText = 'Enter a valid 10-digit mobile number');
      return;
    }
    setState(() => _errorText = null);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => OtpScreen(phoneNumber: phone)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = width / imageAspectRatio;

        // All fractions below are pixel-measured / 853 (image width),
        // for BOTH x and y — this works because the image is displayed
        // at a fixed aspect ratio, so one consistent scale applies to
        // every axis. Do not mix in height-based fractions here.

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                width: width,
                height: height,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/rental/login_screen1.png',
                        fit: BoxFit.fill,
                      ),
                    ),

                    // Phone number field — sized to exactly match the
                    // measured placeholder box.
                    Positioned(
                      left: width * 0.08206,
                      right: width * 0.08558,
                      top: width * 1.39390,
                      height: width * 0.13012,
                      child: Container(
                        decoration: BoxDecoration(
                          color: debugShowZones ? Colors.red.withOpacity(0.3) : Colors.white,
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 18),
                            const Text('+91', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                            const SizedBox(width: 10),
                            Container(width: 1, height: 18, color: Colors.grey.shade300),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                maxLength: 10,
                                style: const TextStyle(fontSize: 14),
                                decoration: const InputDecoration(
                                  counterText: '',
                                  hintText: 'Enter mobile number',
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                          ],
                        ),
                      ),
                    ),

                    if (_errorText != null)
                      Positioned(
                        left: width * 0.08206,
                        top: width * 1.39390 + width * 0.13012 + 4,
                        child: Text(
                          _errorText!,
                          style: const TextStyle(color: Colors.red, fontSize: 11),
                        ),
                      ),

                    // Send OTP button — sized to exactly match the
                    // measured placeholder box.
                    // FIX: top was 1.55568, leaving only ~0.032*width
                    // of clearance below the phone field — not enough
                    // room for the red error message before it
                    // visually collided with this button. Pushed down
                    // to 1.60 for real breathing room; nothing else
                    // (background image, social icons, phone field)
                    // changed position.
                    Positioned(
                      left: width * 0.08206,
                      right: width * 0.08676,
                      top: width * 1.60000,
                      height: width * 0.13364,
                      child: Material(
                        color: debugShowZones ? Colors.red.withOpacity(0.3) : Colors.black,
                        borderRadius: BorderRadius.circular(28),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(28),
                          onTap: _handleSendOtp,
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  'Send OTP',
                                  style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.send, color: Colors.white, size: 14),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Google — sized to exactly match the measured circle
                    Positioned(
                      left: width * 0.22098,
                      top: width * 1.81325,
                      width: width * 0.12661,
                      height: width * 0.12661,
                      child: _socialTapZone(
                        icon: FontAwesomeIcons.google,
                        color: const Color(0xFFEA4335),
                        debug: debugShowZones,
                        onTap: () => _showComingSoon(context, 'Google'),
                      ),
                    ),

                    // Apple — sized to exactly match the measured circle
                    Positioned(
                      left: width * 0.42438,
                      top: width * 1.81325,
                      width: width * 0.12661,
                      height: width * 0.12661,
                      child: _socialTapZone(
                        icon: FontAwesomeIcons.apple,
                        color: Colors.black,
                        debug: debugShowZones,
                        onTap: () => _showComingSoon(context, 'Apple'),
                      ),
                    ),

                    // WhatsApp — sized to exactly match the measured circle
                    Positioned(
                      left: width * 0.62544,
                      top: width * 1.81325,
                      width: width * 0.12661,
                      height: width * 0.12661,
                      child: _socialTapZone(
                        icon: FontAwesomeIcons.whatsapp,
                        color: const Color(0xFF25D366),
                        debug: debugShowZones,
                        onTap: () => _showComingSoon(context, 'WhatsApp'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _socialTapZone({
    required FaIconData icon,
    required Color color,
    required bool debug,
    required VoidCallback onTap,
  }) {
    return Material(
      color: debug ? Colors.red.withOpacity(0.3) : Colors.white,
      shape: CircleBorder(
        side: BorderSide(color: debug ? Colors.transparent : const Color(0xFFE5E7EB)),
      ),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Center(child: FaIcon(icon, color: color, size: 18)),
      ),
    );
  }

  void _showComingSoon(BuildContext context, String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$provider login coming soon')),
    );
  }
}