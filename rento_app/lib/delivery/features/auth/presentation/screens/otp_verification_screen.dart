// // import 'dart:async';
// // import 'package:flutter/material.dart';
// // import '../../../../core/constants/app_colors.dart';
// // import '../../../../core/routes/route_names.dart';
// // import '../../../../core/widgets/primary_button.dart';

// // class OtpVerificationScreen extends StatefulWidget {
// //   const OtpVerificationScreen({super.key});

// //   @override
// //   State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
// // }

// // class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
// //   final List<TextEditingController> _controllers = List.generate(
// //     6,
// //     (_) => TextEditingController(),
// //   );
// //   final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

// //   Timer? _timer;
// //   int _secondsLeft = 30;
// //   bool _isVerifying = false;
// //   bool _isOtpExpired = false;
// //   String? _mobileNumber;

// //   @override
// //   void didChangeDependencies() {
// //     super.didChangeDependencies();
// //     _mobileNumber ??= ModalRoute.of(context)?.settings.arguments as String?;
// //   }

// //   @override
// //   void initState() {
// //     super.initState();
// //     _startResendTimer();
// //   }

// //   void _startResendTimer() {
// //     _secondsLeft = 30;
// //     _isOtpExpired = false;
// //     _timer?.cancel();
// //     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
// //       if (_secondsLeft == 0) {
// //         timer.cancel();
// //         setState(() => _isOtpExpired = true);
// //       } else {
// //         setState(() => _secondsLeft--);
// //       }
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     _timer?.cancel();
// //     for (final c in _controllers) {
// //       c.dispose();
// //     }
// //     for (final f in _focusNodes) {
// //       f.dispose();
// //     }
// //     super.dispose();
// //   }

// //   String get _enteredOtp => _controllers.map((c) => c.text).join();

// //   void _onDigitChanged(int index, String value) {
// //     if (value.isNotEmpty && index < 5) {
// //       _focusNodes[index + 1].requestFocus();
// //     }
// //     if (value.isEmpty && index > 0) {
// //       _focusNodes[index - 1].requestFocus();
// //     }
// //     if (_enteredOtp.length == 6) {
// //       FocusScope.of(context).unfocus();
// //     }
// //     setState(() {});
// //   }

// //   void _clearOtpFields() {
// //     for (final c in _controllers) {
// //       c.clear();
// //     }
// //     _focusNodes[0].requestFocus();
// //     setState(() {});
// //   }

// //   void _showErrorSnackbar(String message) {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: Text(message),
// //         backgroundColor: Colors.red,
// //         behavior: SnackBarBehavior.floating,
// //         margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// //       ),
// //     );
// //   }

// //   void _onVerify() async {
// //     if (_enteredOtp.length != 6) return;

// //     // OTP window has closed — reject immediately.
// //     if (_isOtpExpired) {
// //       _showErrorSnackbar('OTP expired. Please request a new one.');
// //       _clearOtpFields();
// //       return;
// //     }

// //     setState(() => _isVerifying = true);

// //     // TODO: Replace with AuthRepository.verifyOtp(_mobileNumber, _enteredOtp).
// //     // Simulate network call for now.
// //     await Future.delayed(const Duration(milliseconds: 900));

// //     if (!mounted) return;
// //     setState(() => _isVerifying = false);

// //     // TODO: Handle server-side invalid/expired OTP errors here, e.g.:
// //     // if (result.isError) { _showErrorSnackbar(result.message); _clearOtpFields(); return; }

// //     // Role selection removed from the flow — this app is rider-only, so
// //     // OTP verification goes straight to the rider home shell.
// //     Navigator.of(context).pushReplacementNamed(RouteNames.riderHome);
// //   }

// //   void _onResend() {
// //     if (_secondsLeft > 0) return;
// //     // TODO: call AuthRepository.sendOtp(_mobileNumber) again.
// //     _clearOtpFields();
// //     _startResendTimer();
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: const Text('OTP resent successfully'),
// //         behavior: SnackBarBehavior.floating,
// //         margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// //       ),
// //     );
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
// //               const SizedBox(height: 12),
// //               const Text(
// //                 'OTP Verification',
// //                 style: TextStyle(
// //                   fontSize: 22,
// //                   fontWeight: FontWeight.bold,
// //                   color: AppColors.textPrimary,
// //                 ),
// //               ),
// //               const SizedBox(height: 8),
// //               Text(
// //                 _mobileNumber != null
// //                     ? 'Enter the 6-digit code sent to +91 $_mobileNumber'
// //                     : 'Enter the 6-digit code sent to your mobile number',
// //                 style: const TextStyle(
// //                   fontSize: 14,
// //                   color: AppColors.textSecondary,
// //                 ),
// //               ),
// //               const SizedBox(height: 24),
// //               Center(
// //                 child: Image.asset(
// //                   'assets/images/verification/otp_illustration.png',
// //                   width: 260,
// //                 ),
// //               ),
// //               const SizedBox(height: 24),

// //               // OTP expired warning banner
// //               if (_isOtpExpired)
// //                 Container(
// //                   margin: const EdgeInsets.only(bottom: 12),
// //                   padding: const EdgeInsets.symmetric(
// //                     horizontal: 12,
// //                     vertical: 8,
// //                   ),
// //                   decoration: BoxDecoration(
// //                     color: Colors.red.shade50,
// //                     border: Border.all(color: Colors.red.shade200),
// //                     borderRadius: BorderRadius.circular(10),
// //                   ),
// //                   child: Row(
// //                     children: [
// //                       Icon(
// //                         Icons.error_outline,
// //                         color: Colors.red.shade600,
// //                         size: 18,
// //                       ),
// //                       const SizedBox(width: 8),
// //                       Expanded(
// //                         child: Text(
// //                           'OTP has expired. Please resend to get a new code.',
// //                           style: TextStyle(
// //                             fontSize: 13,
// //                             color: Colors.red.shade700,
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),

// //               LayoutBuilder(
// //                 builder: (context, constraints) {
// //                   const gap = 8.0;
// //                   final boxWidth = ((constraints.maxWidth - gap * 5) / 6).clamp(
// //                     38.0,
// //                     52.0,
// //                   );

// //                   return Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: List.generate(6, (index) {
// //                       return SizedBox(
// //                         width: boxWidth,
// //                         height: 56,
// //                         child: TextField(
// //                           controller: _controllers[index],
// //                           focusNode: _focusNodes[index],
// //                           textAlign: TextAlign.center,
// //                           textAlignVertical: TextAlignVertical.center,
// //                           keyboardType: TextInputType.number,
// //                           maxLength: 1,
// //                           style: const TextStyle(
// //                             fontSize: 20,
// //                             fontWeight: FontWeight.w600,
// //                           ),
// //                           decoration: InputDecoration(
// //                             counterText: '',
// //                             contentPadding: EdgeInsets.zero,
// //                             isDense: true,
// //                             border: OutlineInputBorder(
// //                               borderRadius: const BorderRadius.all(
// //                                 Radius.circular(12),
// //                               ),
// //                               // Highlight boxes red when expired
// //                               borderSide: _isOtpExpired
// //                                   ? BorderSide(color: Colors.red.shade300)
// //                                   : const BorderSide(),
// //                             ),
// //                             enabledBorder: OutlineInputBorder(
// //                               borderRadius: const BorderRadius.all(
// //                                 Radius.circular(12),
// //                               ),
// //                               borderSide: _isOtpExpired
// //                                   ? BorderSide(color: Colors.red.shade300)
// //                                   : const BorderSide(color: Colors.grey),
// //                             ),
// //                           ),
// //                           onChanged: (value) => _onDigitChanged(index, value),
// //                         ),
// //                       );
// //                     }),
// //                   );
// //                 },
// //               ),

// //               const SizedBox(height: 24),
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   const Text(
// //                     "Didn't receive the code? ",
// //                     style: TextStyle(
// //                       fontSize: 13,
// //                       color: AppColors.textSecondary,
// //                     ),
// //                   ),
// //                   GestureDetector(
// //                     onTap: _onResend,
// //                     child: Text(
// //                       _secondsLeft > 0
// //                           ? 'Resend in ${_secondsLeft}s'
// //                           : 'Resend OTP',
// //                       style: TextStyle(
// //                         fontSize: 13,
// //                         fontWeight: FontWeight.w600,
// //                         color: _secondsLeft > 0
// //                             ? AppColors.textHint
// //                             : AppColors.textPrimary,
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               const SizedBox(height: 32),
// //               PrimaryButton(
// //                 label: 'Verify',
// //                 isLoading: _isVerifying,
// //                 onPressed: _enteredOtp.length == 6 ? _onVerify : null,
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:async';
// import 'package:flutter/material.dart';
// //import '../../../../core/constants/app_colors.dart';
// import '../../../../core/routes/route_names.dart';
// import '../../../../core/widgets/primary_button.dart';
// import 'package:rento_india/delivery/core/constants/app_colors.dart';

// class OtpVerificationScreen extends StatefulWidget {
//   const OtpVerificationScreen({super.key});

//   @override
//   State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
// }

// class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
//   final List<TextEditingController> _controllers = List.generate(
//     6,
//     (_) => TextEditingController(),
//   );
//   final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

//   Timer? _timer;
//   int _secondsLeft = 30;
//   bool _isVerifying = false;
//   bool _isOtpExpired = false;
//   String? _mobileNumber;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _mobileNumber ??= ModalRoute.of(context)?.settings.arguments as String?;
//   }

//   @override
//   void initState() {
//     super.initState();
//     _startResendTimer();
//   }

//   void _startResendTimer() {
//     _secondsLeft = 30;
//     _isOtpExpired = false;
//     _timer?.cancel();
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_secondsLeft == 0) {
//         timer.cancel();
//         setState(() => _isOtpExpired = true);
//       } else {
//         setState(() => _secondsLeft--);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     for (final c in _controllers) {
//       c.dispose();
//     }
//     for (final f in _focusNodes) {
//       f.dispose();
//     }
//     super.dispose();
//   }

//   String get _enteredOtp => _controllers.map((c) => c.text).join();

//   void _onDigitChanged(int index, String value) {
//     if (value.isNotEmpty && index < 5) {
//       _focusNodes[index + 1].requestFocus();
//     }
//     if (value.isEmpty && index > 0) {
//       _focusNodes[index - 1].requestFocus();
//     }
//     if (_enteredOtp.length == 6) {
//       FocusScope.of(context).unfocus();
//     }
//     setState(() {});
//   }

//   void _clearOtpFields() {
//     for (final c in _controllers) {
//       c.clear();
//     }
//     _focusNodes[0].requestFocus();
//     setState(() {});
//   }

//   void _showErrorSnackbar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//         behavior: SnackBarBehavior.floating,
//         margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       ),
//     );
//   }

//   void _onVerify() async {
//     if (_enteredOtp.length != 6) return;

//     // OTP window has closed — reject immediately.
//     if (_isOtpExpired) {
//       _showErrorSnackbar('OTP expired. Please request a new one.');
//       _clearOtpFields();
//       return;
//     }

//     setState(() => _isVerifying = true);

//     // TODO: Replace with AuthRepository.verifyOtp(_mobileNumber, _enteredOtp).
//     // Simulate network call for now.
//     await Future.delayed(const Duration(milliseconds: 900));

//     if (!mounted) return;
//     setState(() => _isVerifying = false);

//     // TODO: Handle server-side invalid/expired OTP errors here, e.g.:
//     // if (result.isError) { _showErrorSnackbar(result.message); _clearOtpFields(); return; }

//     // Role selection removed from the flow — this app is rider-only, so
//     // OTP verification goes straight into the rider verification flow
//     // (Aadhaar → Selfie → Common Info → Driving License → Vehicle →
//     // Insurance → Bank → Delivery Zone → Review → Under Review →
//     // Approved), which itself lands on the rider home shell once
//     // approved. pushReplacementNamed so the OTP screen isn't left on
//     // the back stack.
//     Navigator.of(context).pushReplacementNamed(RouteNames.riderRegistration);
//   }

//   void _onResend() {
//     if (_secondsLeft > 0) return;
//     // TODO: call AuthRepository.sendOtp(_mobileNumber) again.
//     _clearOtpFields();
//     _startResendTimer();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: const Text('OTP resent successfully'),
//         behavior: SnackBarBehavior.floating,
//         margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       ),
//     );
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
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const SizedBox(height: 12),
//               const Text(
//                 'OTP Verification',
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimary,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 _mobileNumber != null
//                     ? 'Enter the 6-digit code sent to +91 $_mobileNumber'
//                     : 'Enter the 6-digit code sent to your mobile number',
//                 style: const TextStyle(
//                   fontSize: 14,
//                   color: AppColors.textSecondary,
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Center(
//                 child: Image.asset(
//                   'assets/images/rental/verification/otp_illustration.png',
//                   width: 260,
//                 ),
//               ),
//               const SizedBox(height: 24),

//               // OTP expired warning banner
//               if (_isOtpExpired)
//                 Container(
//                   margin: const EdgeInsets.only(bottom: 12),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 8,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.red.shade50,
//                     border: Border.all(color: Colors.red.shade200),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.error_outline,
//                         color: Colors.red.shade600,
//                         size: 18,
//                       ),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: Text(
//                           'OTP has expired. Please resend to get a new code.',
//                           style: TextStyle(
//                             fontSize: 13,
//                             color: Colors.red.shade700,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//               LayoutBuilder(
//                 builder: (context, constraints) {
//                   const gap = 8.0;
//                   final boxWidth = ((constraints.maxWidth - gap * 5) / 6).clamp(
//                     38.0,
//                     52.0,
//                   );

//                   return Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: List.generate(6, (index) {
//                       return SizedBox(
//                         width: boxWidth,
//                         height: 56,
//                         child: TextField(
//                           controller: _controllers[index],
//                           focusNode: _focusNodes[index],
//                           textAlign: TextAlign.center,
//                           textAlignVertical: TextAlignVertical.center,
//                           keyboardType: TextInputType.number,
//                           maxLength: 1,
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600,
//                           ),
//                           decoration: InputDecoration(
//                             counterText: '',
//                             contentPadding: EdgeInsets.zero,
//                             isDense: true,
//                             border: OutlineInputBorder(
//                               borderRadius: const BorderRadius.all(
//                                 Radius.circular(12),
//                               ),
//                               // Highlight boxes red when expired
//                               borderSide: _isOtpExpired
//                                   ? BorderSide(color: Colors.red.shade300)
//                                   : const BorderSide(),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: const BorderRadius.all(
//                                 Radius.circular(12),
//                               ),
//                               borderSide: _isOtpExpired
//                                   ? BorderSide(color: Colors.red.shade300)
//                                   : const BorderSide(color: Colors.grey),
//                             ),
//                           ),
//                           onChanged: (value) => _onDigitChanged(index, value),
//                         ),
//                       );
//                     }),
//                   );
//                 },
//               ),

//               const SizedBox(height: 24),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "Didn't receive the code? ",
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: AppColors.textSecondary,
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: _onResend,
//                     child: Text(
//                       _secondsLeft > 0
//                           ? 'Resend in ${_secondsLeft}s'
//                           : 'Resend OTP',
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w600,
//                         color: _secondsLeft > 0
//                             ? AppColors.textHint
//                             : AppColors.textPrimary,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 32),
//               PrimaryButton(
//                 label: 'Verify',
//                 isLoading: _isVerifying,
//                 onPressed: _enteredOtp.length == 6 ? _onVerify : null,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
