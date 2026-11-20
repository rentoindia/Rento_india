// import 'package:flutter/material.dart';
// import 'owner_kyc_theme.dart';
// import '../owner_property_list_screen.dart';
// import '../owner_verification_status.dart';

// /// MYHOUSE OWNER — KYC Screen 9: Account Verified
// class OwnerKycVerifiedScreen extends StatelessWidget {
//   const OwnerKycVerifiedScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return KycTheme.blockBack(
//       child: Scaffold(
//         backgroundColor: KycTheme.bg,
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 const Spacer(),
//                 Container(
//                   width: 120,
//                   height: 120,
//                   decoration: BoxDecoration(
//                     color: KycTheme.black,
//                     shape: BoxShape.circle,
//                     boxShadow: KycTheme.cardShadow,
//                   ),
//                   child: const Icon(Icons.check_rounded,
//                       size: 56, color: KycTheme.white),
//                 ),
//                 const SizedBox(height: 30),
//                 const Text(
//                   'Your account is\nverified',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.w700,
//                       color: KycTheme.black,
//                       height: 1.3),
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   'You can now list and manage your properties.',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 13.5, color: KycTheme.textGrey),
//                 ),
//                 const Spacer(),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: KycTheme.primaryButton,
//                     onPressed: () async {
//                       await OwnerVerificationStatus.markVerified();
//                       if (!context.mounted) return;
//                       Navigator.pushAndRemoveUntil(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const OwnerDashboardScreen(),
//                         ),
//                         (route) => false,
//                       );
//                     },
//                     child: const Text('Go to Home',
//                         style: TextStyle(color: KycTheme.white)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'owner_kyc_theme.dart';
import '../owner_property_list_screen.dart';
import '../owner_verification_status.dart';

/// MYHOUSE OWNER — KYC Screen 9: Account Verified
class OwnerKycVerifiedScreen extends StatelessWidget {
  const OwnerKycVerifiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KycTheme.blockBack(
      child: Scaffold(
        backgroundColor: KycTheme.bg,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Spacer(),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: KycTheme.black,
                    shape: BoxShape.circle,
                    boxShadow: KycTheme.cardShadow,
                  ),
                  child: const Icon(Icons.check_rounded,
                      size: 56, color: KycTheme.white),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Your account is\nverified',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: KycTheme.black,
                      height: 1.3),
                ),
                const SizedBox(height: 10),
                const Text(
                  'You can now list and manage your properties.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13.5, color: KycTheme.textGrey),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: KycTheme.primaryButton,
                    onPressed: () async {
                      await OwnerVerificationStatus.markVerified();
                      if (!context.mounted) return;
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OwnerDashboardScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text('Go to Home',
                        style: TextStyle(color: KycTheme.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



