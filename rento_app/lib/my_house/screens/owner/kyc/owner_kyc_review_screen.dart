// import 'package:flutter/material.dart';
// import 'owner_kyc_theme.dart';
// import 'owner_kyc_under_review_screen.dart';

// /// MYHOUSE OWNER — KYC Screen 7: Review Details
// class OwnerKycReviewScreen extends StatelessWidget {
//   const OwnerKycReviewScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final items = [
//       {'icon': Icons.person_outline, 'label': 'Name', 'value': 'Ramesh Kumar'},
//       {'icon': Icons.phone_outlined, 'label': 'Mobile', 'value': '+91 98765 43210'},
//       {'icon': Icons.location_on_outlined, 'label': 'Address',
//           'value': '123, Anna Nagar,\nChennai - 600040'},
//       {'icon': Icons.home_outlined, 'label': 'Property Type', 'value': 'House'},
//       {'icon': Icons.description_outlined, 'label': 'Ownership Proof', 'value': 'Sale Deed'},
//       {'icon': Icons.account_balance_outlined, 'label': 'Bank Details',
//           'value': 'State Bank of India,\nAnna Nagar'},
//     ];

//     return Scaffold(
//       backgroundColor: KycTheme.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Back button
//               GestureDetector(
//                 onTap: () => Navigator.pop(context),
//                 child: Container(
//                   width: 36,
//                   height: 36,
//                   decoration: BoxDecoration(
//                     color: KycTheme.fillGrey,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(Icons.arrow_back, size: 18, color: KycTheme.black),
//                 ),
//               ),
//               const SizedBox(height: 14),
//               KycTheme.appHeader('Owner Verification'),
//               const SizedBox(height: 20),
//               KycTheme.stepDots(6, 7),
//               const SizedBox(height: 24),

//               const Text('Review Details', style: TextStyle(
//                   fontSize: 20, fontWeight: FontWeight.w700, color: KycTheme.black)),
//               const SizedBox(height: 4),
//               const Text('Please review your details',
//                   style: TextStyle(fontSize: 13, color: KycTheme.textGrey)),
//               const SizedBox(height: 20),

//               Expanded(
//                 child: ListView.separated(
//                   itemCount: items.length,
//                   separatorBuilder: (_, __) => const Divider(
//                       height: 24, color: KycTheme.borderGrey),
//                   itemBuilder: (context, index) {
//                     final item = items[index];
//                     return Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Icon(item['icon'] as IconData, size: 18, color: KycTheme.black),
//                         const SizedBox(width: 14),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(item['label'] as String, style: const TextStyle(
//                                   fontSize: 11, color: KycTheme.textGrey)),
//                               const SizedBox(height: 2),
//                               Text(item['value'] as String, style: const TextStyle(
//                                   fontSize: 14, color: KycTheme.black, fontWeight: FontWeight.w500)),
//                             ],
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),

//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: KycTheme.primaryButton,
//                   onPressed: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const OwnerKycUnderReviewScreen(),
//                       ),
//                     );
//                   },
//                   child: const Text('Submit',
//                       style: TextStyle(color: KycTheme.white, fontWeight: FontWeight.w600)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'owner_kyc_theme.dart';
import 'owner_kyc_under_review_screen.dart';

/// MYHOUSE OWNER — KYC Screen 7: Review Details
class OwnerKycReviewScreen extends StatelessWidget {
  const OwnerKycReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.person_outline, 'label': 'Name', 'value': 'Ramesh Kumar'},
      {'icon': Icons.phone_outlined, 'label': 'Mobile', 'value': '+91 98765 43210'},
      {'icon': Icons.location_on_outlined, 'label': 'Address',
          'value': '123, Anna Nagar,\nChennai - 600040'},
      {'icon': Icons.home_outlined, 'label': 'Property Type', 'value': 'House'},
      {'icon': Icons.description_outlined, 'label': 'Ownership Proof', 'value': 'Sale Deed'},
      {'icon': Icons.account_balance_outlined, 'label': 'Bank Details',
          'value': 'State Bank of India,\nAnna Nagar'},
    ];

    return Scaffold(
      backgroundColor: KycTheme.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: KycTheme.fillGrey,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back, size: 18, color: KycTheme.black),
                ),
              ),
              const SizedBox(height: 14),
              KycTheme.appHeader('Owner Verification'),
              const SizedBox(height: 20),
              KycTheme.stepDots(6, 7),
              const SizedBox(height: 24),

              const Text('Review Details', style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w700, color: KycTheme.black)),
              const SizedBox(height: 4),
              const Text('Please review your details',
                  style: TextStyle(fontSize: 13, color: KycTheme.textGrey)),
              const SizedBox(height: 20),

              Expanded(
                child: ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const Divider(
                      height: 24, color: KycTheme.borderGrey),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(item['icon'] as IconData, size: 18, color: KycTheme.black),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['label'] as String, style: const TextStyle(
                                  fontSize: 11, color: KycTheme.textGrey)),
                              const SizedBox(height: 2),
                              Text(item['value'] as String, style: const TextStyle(
                                  fontSize: 14, color: KycTheme.black, fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: KycTheme.primaryButton,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OwnerKycUnderReviewScreen(),
                      ),
                    );
                  },
                  child: const Text('Submit',
                      style: TextStyle(color: KycTheme.white, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

