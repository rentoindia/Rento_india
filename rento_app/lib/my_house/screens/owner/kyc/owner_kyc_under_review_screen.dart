// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'owner_kyc_theme.dart';
// import 'owner_kyc_verified_screen.dart';

// /// MYHOUSE OWNER — KYC Screen 8: Account Under Review
// /// After a short simulated review delay, automatically moves the
// /// owner forward to the Verified screen. No manual action needed
// /// and the back button is disabled during review.
// class OwnerKycUnderReviewScreen extends StatefulWidget {
//   const OwnerKycUnderReviewScreen({super.key});

//   @override
//   State<OwnerKycUnderReviewScreen> createState() => _OwnerKycUnderReviewScreenState();
// }

// class _OwnerKycUnderReviewScreenState extends State<OwnerKycUnderReviewScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Simulated backend review delay — in a real app this would be
//     // replaced by a server push / status-poll instead of a fixed timer.
//     Timer(const Duration(seconds: 3), () {
//       if (!mounted) return;
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const OwnerKycVerifiedScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return KycTheme.blockBack(
//       child: Scaffold(
//         backgroundColor: KycTheme.bg,
//         body: SafeArea(
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Container(
//                     width: 120,
//                     height: 120,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: KycTheme.white,
//                       shape: BoxShape.circle,
//                       boxShadow: KycTheme.cardShadow,
//                     ),
//                     child: const SizedBox(
//                       width: 48,
//                       height: 48,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 4,
//                         color: KycTheme.black,
//                         backgroundColor: KycTheme.fillGrey,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   const Text(
//                     'Your account is\nunder review',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         fontSize: 21,
//                         fontWeight: FontWeight.w700,
//                         color: KycTheme.black,
//                         height: 1.3),
//                   ),
//                   const SizedBox(height: 10),
//                   const Text(
//                     'This usually takes a few seconds. Please wait,\nyou will be redirected automatically.',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 13, color: KycTheme.textGrey, height: 1.5),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:async';
import 'package:flutter/material.dart';
import 'owner_kyc_theme.dart';
import 'owner_kyc_verified_screen.dart';

/// MYHOUSE OWNER — KYC Screen 8: Account Under Review
/// After a short simulated review delay, automatically moves the
/// owner forward to the Verified screen. No manual action needed
/// and the back button is disabled during review.
class OwnerKycUnderReviewScreen extends StatefulWidget {
  const OwnerKycUnderReviewScreen({super.key});

  @override
  State<OwnerKycUnderReviewScreen> createState() => _OwnerKycUnderReviewScreenState();
}

class _OwnerKycUnderReviewScreenState extends State<OwnerKycUnderReviewScreen> {
  @override
  void initState() {
    super.initState();
    // Simulated backend review delay — in a real app this would be
    // replaced by a server push / status-poll instead of a fixed timer.
    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OwnerKycVerifiedScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return KycTheme.blockBack(
      child: Scaffold(
        backgroundColor: KycTheme.bg,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: KycTheme.white,
                      shape: BoxShape.circle,
                      boxShadow: KycTheme.cardShadow,
                    ),
                    child: const SizedBox(
                      width: 48,
                      height: 48,
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        color: KycTheme.black,
                        backgroundColor: KycTheme.fillGrey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Your account is\nunder review',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                        color: KycTheme.black,
                        height: 1.3),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'This usually takes a few seconds. Please wait,\nyou will be redirected automatically.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: KycTheme.textGrey, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}




