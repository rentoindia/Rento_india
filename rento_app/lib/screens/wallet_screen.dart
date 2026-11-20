// // import 'package:flutter/material.dart';
// // import '../widgets/bottom_nav_bar.dart';
// // import '../widgets/nav_helper.dart';
// // import '../services/wallet_service.dart';

// // class WalletScreen extends StatelessWidget {
// //   const WalletScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     // Wrapped in AnimatedBuilder so it rebuilds live from WalletService —
// //     // the balance and history here are the same ones payment_screen.dart
// //     // credits/debits.
// //     return AnimatedBuilder(
// //       animation: WalletService.instance,
// //       builder: (context, _) {
// //         final coins = WalletService.instance.coins;
// //         final transactions = WalletService.instance.transactions;

// //         return Scaffold(
// //           appBar: AppBar(
// //             title: const Text('Wallet'),
// //             // This is a main bottom-nav tab, not a pushed sub-page —
// //             // it shouldn't show a back arrow.
// //             automaticallyImplyLeading: false,
// //           ),
// //           body: ListView(
// //             padding: const EdgeInsets.all(16),
// //             children: [
// //               Container(
// //                 width: double.infinity,
// //                 padding: const EdgeInsets.all(20),
// //                 decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(16)),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text('Wallet Balance', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
// //                     const SizedBox(height: 6),
// //                     Text('₹${coins.toStringAsFixed(0)}',
// //                         style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
// //                   ],
// //                 ),
// //               ),
// //               const SizedBox(height: 20),
// //               const Text('Recent Transactions', style: TextStyle(fontWeight: FontWeight.w700)),
// //               const SizedBox(height: 12),
// //               if (transactions.isEmpty)
// //                 Padding(
// //                   padding: const EdgeInsets.symmetric(vertical: 40),
// //                   child: Center(
// //                     child: Column(
// //                       children: [
// //                         Icon(Icons.receipt_long_outlined, size: 40, color: Colors.grey.shade300),
// //                         const SizedBox(height: 10),
// //                         Text('No transactions yet', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
// //                         const SizedBox(height: 4),
// //                         Text('Rent a product to start earning coins',
// //                             style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
// //                       ],
// //                     ),
// //                   ),
// //                 )
// //               else
// //                 ...transactions.map((t) {
// //                   final isCredit = t.type != WalletTransactionType.redeemed;
// //                   return Container(
// //                     margin: const EdgeInsets.only(bottom: 10),
// //                     padding: const EdgeInsets.all(14),
// //                     decoration: BoxDecoration(
// //                       color: Colors.white,
// //                       borderRadius: BorderRadius.circular(12),
// //                       border: Border.all(color: const Color(0xFFF0F0F0)),
// //                     ),
// //                     child: Row(
// //                       children: [
// //                         Expanded(
// //                           child: Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               Text(t.description,
// //                                   maxLines: 1,
// //                                   overflow: TextOverflow.ellipsis,
// //                                   style: const TextStyle(fontWeight: FontWeight.w600)),
// //                               Text(_formatDate(t.date), style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
// //                             ],
// //                           ),
// //                         ),
// //                         Text(
// //                           '${isCredit ? '+' : '-'}₹${t.amount.toStringAsFixed(0)}',
// //                           style: TextStyle(
// //                             fontWeight: FontWeight.w700,
// //                             color: isCredit ? Colors.green : Colors.red,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   );
// //                 }),
// //             ],
// //           ),
// //           bottomNavigationBar: RentoBottomNavBar(
// //             currentIndex: 3,
// //             onTap: (i) => navigateToTab(context, i),
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   String _formatDate(DateTime d) {
// //     const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
// //     return '${d.day} ${months[d.month - 1]} ${d.year}';
// //   }
// // }











// import 'package:flutter/material.dart';
// import '../widgets/bottom_nav_bar.dart';
// import '../widgets/nav_helper.dart';
// import '../services/wallet_service.dart';
// import 'package:rento/delivery/core/constants/app_colors.dart';//import '../constants/app_colors.dart';
// import '../constants/app_text_styles.dart';

// class WalletScreen extends StatelessWidget {
//   const WalletScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Wrapped in AnimatedBuilder so it rebuilds live from WalletService —
//     // the balance and history here are the same ones payment_screen.dart
//     // credits/debits.
//     return AnimatedBuilder(
//       animation: WalletService.instance,
//       builder: (context, _) {
//         final coins = WalletService.instance.coins;
//         final transactions = WalletService.instance.transactions;

//         return Scaffold(
//           appBar: AppBar(
//             title: Text('Wallet', style: AppText.titleLg),
//             // This is a main bottom-nav tab, not a pushed sub-page —
//             // it shouldn't show a back arrow.
//             automaticallyImplyLeading: false,
//           ),
//           body: ListView(
//             padding: const EdgeInsets.all(16),
//             children: [
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(color: AppColors.primaryBlack, borderRadius: BorderRadius.circular(16)),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Wallet Balance', style: AppText.bodySm.copyWith(color: AppColors.textHint, fontSize: 12)),
//                     const SizedBox(height: 6),
//                     Text('₹${coins.toStringAsFixed(0)}',
//                         style: AppText.displayLg.copyWith(color: AppColors.pureWhite, fontSize: 28)),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Text('Recent Transactions', style: AppText.titleLg.copyWith(fontSize: 14)),
//               const SizedBox(height: 12),
//               if (transactions.isEmpty)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 40),
//                   child: Center(
//                     child: Column(
//                       children: [
//                         Icon(Icons.receipt_long_outlined, size: 40, color: AppColors.border),
//                         const SizedBox(height: 10),
//                         Text('No transactions yet', style: AppText.bodySm.copyWith(color: AppColors.textHint, fontSize: 13)),
//                         const SizedBox(height: 4),
//                         Text('Rent a product to start earning coins',
//                             style: AppText.caption.copyWith(fontSize: 11)),
//                       ],
//                     ),
//                   ),
//                 )
//               else
//                 ...transactions.map((t) {
//                   final isCredit = t.type != WalletTransactionType.redeemed;
//                   return Container(
//                     margin: const EdgeInsets.only(bottom: 10),
//                     padding: const EdgeInsets.all(14),
//                     decoration: BoxDecoration(
//                       color: AppColors.pureWhite,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: AppColors.border),
//                     ),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(t.description,
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: AppText.titleSm.copyWith(fontWeight: FontWeight.w600)),
//                               Text(_formatDate(t.date), style: AppText.caption.copyWith(fontSize: 11)),
//                             ],
//                           ),
//                         ),
//                         Text(
//                           '${isCredit ? '+' : '-'}₹${t.amount.toStringAsFixed(0)}',
//                           style: AppText.titleSm.copyWith(
//                             color: isCredit ? AppColors.success : AppColors.error,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }),
//             ],
//           ),
//           bottomNavigationBar: RentoBottomNavBar(
//             currentIndex: 3,
//             onTap: (i) => navigateToTab(context, i),
//           ),
//         );
//       },
//     );
//   }

//   String _formatDate(DateTime d) {
//     const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
//     return '${d.day} ${months[d.month - 1]} ${d.year}';
//   }
// }





import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/nav_helper.dart';
import '../services/wallet_service.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrapped in AnimatedBuilder so it rebuilds live from WalletService —
    // the balance and history here are the same ones payment_screen.dart
    // credits/debits.
    return AnimatedBuilder(
      animation: WalletService.instance,
      builder: (context, _) {
        final coins = WalletService.instance.coins;
        final transactions = WalletService.instance.transactions;

        return Scaffold(
          appBar: AppBar(
            title: Text('Wallet', style: AppText.titleLg),
            // This is a main bottom-nav tab, not a pushed sub-page —
            // it shouldn't show a back arrow.
            automaticallyImplyLeading: false,
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: AppColors.primaryBlack, borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Wallet Balance', style: AppText.bodySm.copyWith(color: AppColors.textHint, fontSize: 12)),
                    const SizedBox(height: 6),
                    Text('₹${coins.toStringAsFixed(0)}',
                        style: AppText.displayLg.copyWith(color: AppColors.pureWhite, fontSize: 28)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text('Recent Transactions', style: AppText.titleLg.copyWith(fontSize: 14)),
              const SizedBox(height: 12),
              if (transactions.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.receipt_long_outlined, size: 40, color: AppColors.border),
                        const SizedBox(height: 10),
                        Text('No transactions yet', style: AppText.bodySm.copyWith(color: AppColors.textHint, fontSize: 13)),
                        const SizedBox(height: 4),
                        Text('Rent a product to start earning coins',
                            style: AppText.caption.copyWith(fontSize: 11)),
                      ],
                    ),
                  ),
                )
              else
                ...transactions.map((t) {
                  final isCredit = t.type != WalletTransactionType.redeemed;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.pureWhite,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(t.description,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppText.titleSm.copyWith(fontWeight: FontWeight.w600)),
                              Text(_formatDate(t.date), style: AppText.caption.copyWith(fontSize: 11)),
                            ],
                          ),
                        ),
                        Text(
                          '${isCredit ? '+' : '-'}₹${t.amount.toStringAsFixed(0)}',
                          style: AppText.titleSm.copyWith(
                            color: isCredit ? AppColors.success : AppColors.error,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            ],
          ),
          bottomNavigationBar: RentoBottomNavBar(
            currentIndex: 3,
            onTap: (i) => navigateToTab(context, i),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime d) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }
}