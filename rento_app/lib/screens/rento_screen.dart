
// import 'package:flutter/material.dart';
// import '../widgets/bottom_nav_bar.dart';
// import '../widgets/nav_helper.dart';
// import '../services/lender_service.dart';
// import 'add_product_screen.dart';
// import 'lender_verification_screen.dart';
// import 'lender_dashboard_screen.dart';
 
// class RentoScreen extends StatelessWidget {
//   const RentoScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: LenderService.instance,
//       builder: (context, _) {
//         final verified = LenderService.instance.isVerified;

//         return Scaffold(
//           backgroundColor: const Color(0xFFF7F8FA),
//           appBar: AppBar(
//             title: const Text('Rento'),
//             automaticallyImplyLeading: false,
//           ),
//           body: verified ? const LenderDashboardScreen() : const LenderVerificationScreen(),
//           floatingActionButton: verified
//               ? FloatingActionButton.extended(
//                   backgroundColor: Colors.black,
//                   onPressed: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => const AddProductScreen()),
//                   ),
//                   icon: const Icon(Icons.add, color: Colors.white),
//                   label: const Text('Add Product', style: TextStyle(color: Colors.white)),
//                 )
//               : null,
//           bottomNavigationBar: RentoBottomNavBar(
//             currentIndex: 2,
//             onTap: (i) => navigateToTab(context, i),
//           ),
//         );
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/nav_helper.dart';
import '../services/lender_service.dart';
import 'add_product_screen.dart';
import 'lender_verification_screen.dart';
import 'lender_dashboard_screen.dart';

/// Top-level "Rento" tab. Owns the shared Scaffold (AppBar, FAB,
/// BottomNav) and swaps its body between the verification flow and
/// the lender dashboard based on LenderService.instance.isVerified.
///
/// The actual form UI lives in LenderVerificationScreen, and the
/// stats/product-listing UI lives in LenderDashboardScreen — this
/// file just decides which one to show and hosts the FAB, since the
/// FAB only makes sense once verified.
class RentoScreen extends StatelessWidget {
  const RentoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: LenderService.instance,
      builder: (context, _) {
        final verified = LenderService.instance.isVerified;

        return Scaffold(
          backgroundColor: const Color(0xFFF7F8FA),
          appBar: AppBar(
            title: const Text('Rento'),
            automaticallyImplyLeading: false,
          ),
          body: verified ? const LenderDashboardScreen() : const LenderVerificationScreen(),
          floatingActionButton: verified
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.black,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddProductScreen()),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text('Add Product', style: TextStyle(color: Colors.white)),
                )
              : null,
          bottomNavigationBar: RentoBottomNavBar(
            currentIndex: 2,
            onTap: (i) => navigateToTab(context, i),
          ),
        );
      },
    );
  }
}