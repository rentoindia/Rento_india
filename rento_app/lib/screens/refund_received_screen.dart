// // import 'package:flutter/material.dart';
// // import '../theme/app_theme.dart';
// // import '../widgets/primary_button.dart';
// // import 'rental_order.dart';

// // class RefundReceivedScreen extends StatelessWidget {
// //   final RentalOrder order;
// //   final double refundAmount;

// //   const RefundReceivedScreen({super.key, required this.order, required this.refundAmount});

// //   @override
// //   Widget build(BuildContext context) {
// //     final refundDate = DateTime.now().add(const Duration(days: 2));

// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         foregroundColor: Colors.black,
// //         leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
// //         title: const Text('Refund Received', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16)),
// //       ),
// //       body: SafeArea(
// //         child: ListView(
// //           padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
// //           children: [
// //             Center(
// //               child: Column(
// //                 children: [
// //                   Container(
// //                     width: 84,
// //                     height: 84,
// //                     decoration: const BoxDecoration(color: Color(0xFFEAFBF0), shape: BoxShape.circle),
// //                     child: const Icon(Icons.account_balance_wallet, size: 38, color: Color(0xFF22C55E)),
// //                   ),
// //                   const SizedBox(height: 16),
// //                   const Text('Refund Successful!', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
// //                   const SizedBox(height: 6),
// //                   Text(
// //                     'Your security deposit has been\nrefunded to your Rento Wallet.',
// //                     textAlign: TextAlign.center,
// //                     style: TextStyle(color: Colors.grey.shade600, fontSize: 12.5, height: 1.4),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             const SizedBox(height: 26),
// //             Container(
// //               padding: const EdgeInsets.all(14),
// //               decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
// //               child: Column(
// //                 children: [
// //                   _row('Refund Amount', '₹${refundAmount.toStringAsFixed(0)}', bold: true),
// //                   const Divider(height: 22),
// //                   _row('Refund Date', RentalOrder.formatDate(refundDate)),
// //                   const Divider(height: 22),
// //                   _row('Refund To', 'Rento Wallet'),
// //                   const Divider(height: 22),
// //                   _row('Refund In', '2–3 business days'),
// //                 ],
// //               ),
// //             ),
// //             const SizedBox(height: 16),
// //             Container(
// //               padding: const EdgeInsets.all(14),
// //               decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
// //               child: Row(
// //                 children: [
// //                   ClipRRect(
// //                     borderRadius: BorderRadius.circular(10),
// //                     child: Image.network(
// //                       'https://loremflickr.com/90/90/${order.imageQuery.replaceAll(' ', ',')}?lock=${order.name.hashCode.abs() % 5000}',
// //                       width: 44, height: 44, fit: BoxFit.cover,
// //                       errorBuilder: (_, __, ___) => Container(width: 44, height: 44, color: AppTheme.lightGrey, child: const Icon(Icons.image_outlined)),
// //                     ),
// //                   ),
// //                   const SizedBox(width: 10),
// //                   Expanded(
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text(order.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
// //                         Text('Rental completed', style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
// //                       ],
// //                     ),
// //                   ),
// //                   const Icon(Icons.check_circle, color: Color(0xFF22C55E), size: 20),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //       bottomNavigationBar: SafeArea(
// //         child: Padding(
// //           padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
// //           child: PrimaryButton(
// //             label: 'BACK TO HOME',
// //             onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _row(String label, String value, {bool bold = false}) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //       children: [
// //         Text(label, style: TextStyle(fontSize: bold ? 14 : 12.5, color: bold ? Colors.black : Colors.grey.shade600, fontWeight: bold ? FontWeight.w800 : FontWeight.w400)),
// //         Text(value, style: TextStyle(fontSize: bold ? 16 : 12.5, fontWeight: bold ? FontWeight.w800 : FontWeight.w700)),
// //       ],
// //     );
// //   }
// // }
























// import 'package:flutter/material.dart';
// import '../theme/app_theme.dart';
// import '../widgets/primary_button.dart';
// import 'rental_order.dart';
// import 'orders_screen.dart';

// class RefundReceivedScreen extends StatelessWidget {
//   final RentalOrder order;
//   final double refundAmount;

//   const RefundReceivedScreen({super.key, required this.order, required this.refundAmount});

//   @override
//   Widget build(BuildContext context) {
//     final refundDate = DateTime.now().add(const Duration(days: 2));

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         foregroundColor: Colors.black,
//         leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
//         title: const Text('Refund Received', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16)),
//       ),
//       body: SafeArea(
//         child: ListView(
//           padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
//           children: [
//             Center(
//               child: Column(
//                 children: [
//                   Container(
//                     width: 84,
//                     height: 84,
//                     decoration: const BoxDecoration(color: Color(0xFFEAFBF0), shape: BoxShape.circle),
//                     child: const Icon(Icons.account_balance_wallet, size: 38, color: Color(0xFF22C55E)),
//                   ),
//                   const SizedBox(height: 16),
//                   const Text('Refund Successful!', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
//                   const SizedBox(height: 6),
//                   Text(
//                     'Your security deposit has been\nrefunded to your Wallet.',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.grey.shade600, fontSize: 12.5, height: 1.4),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 26),
//             Container(
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
//               child: Column(
//                 children: [
//                   _row('Refund Amount', '₹${refundAmount.toStringAsFixed(0)}', bold: true),
//                   const Divider(height: 22),
//                   _row('Refund Date', RentalOrder.formatDate(refundDate)),
//                   const Divider(height: 22),
//                   _row('Refund To', 'Wallet'),
//                   const Divider(height: 22),
//                   _row('Refund In', '2–3 business days'),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//             Container(
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
//               child: Row(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.network(
//                       'https://loremflickr.com/90/90/${order.imageQuery.replaceAll(' ', ',')}?lock=${order.name.hashCode.abs() % 5000}',
//                       width: 44, height: 44, fit: BoxFit.cover,
//                       errorBuilder: (_, __, ___) => Container(width: 44, height: 44, color: AppTheme.lightGrey, child: const Icon(Icons.image_outlined)),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(order.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
//                         Text('Rental completed', style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
//                       ],
//                     ),
//                   ),
//                   const Icon(Icons.check_circle, color: Color(0xFF22C55E), size: 20),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
//           child: PrimaryButton(
//             label: 'BACK TO HOME',
//             onPressed: () => Navigator.of(context).pushAndRemoveUntil(
//               MaterialPageRoute(builder: (_) => const OrdersScreen()),
//               (route) => route.isFirst,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _row(String label, String value, {bool bold = false}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(label, style: TextStyle(fontSize: bold ? 14 : 12.5, color: bold ? Colors.black : Colors.grey.shade600, fontWeight: bold ? FontWeight.w800 : FontWeight.w400)),
//         Text(value, style: TextStyle(fontSize: bold ? 16 : 12.5, fontWeight: bold ? FontWeight.w800 : FontWeight.w700)),
//       ],
//     );
//   }
// }




import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';
import 'rental_order.dart';
import 'orders_screen.dart';

class RefundReceivedScreen extends StatelessWidget {
  final RentalOrder order;
  final double refundAmount;

  const RefundReceivedScreen({super.key, required this.order, required this.refundAmount});

  @override
  Widget build(BuildContext context) {
    final refundDate = DateTime.now().add(const Duration(days: 2));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: const Text('Refund Received', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16)),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 84,
                    height: 84,
                    decoration: const BoxDecoration(color: Color(0xFFEAFBF0), shape: BoxShape.circle),
                    child: const Icon(Icons.account_balance_wallet, size: 38, color: Color(0xFF22C55E)),
                  ),
                  const SizedBox(height: 16),
                  const Text('Refund Successful!', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                  const SizedBox(height: 6),
                  Text(
                    'Your security deposit has been\nrefunded to your Wallet.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12.5, height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
              child: Column(
                children: [
                  _row('Refund Amount', '₹${refundAmount.toStringAsFixed(0)}', bold: true),
                  const Divider(height: 22),
                  _row('Refund Date', RentalOrder.formatDate(refundDate)),
                  const Divider(height: 22),
                  _row('Refund To', 'Wallet'),
                  const Divider(height: 22),
                  _row('Refund In', '2–3 business days'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://loremflickr.com/90/90/${order.imageQuery.replaceAll(' ', ',')}?lock=${order.name.hashCode.abs() % 5000}',
                      width: 44, height: 44, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(width: 44, height: 44, color: AppTheme.lightGrey, child: const Icon(Icons.image_outlined)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(order.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                        Text('Rental completed', style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
                      ],
                    ),
                  ),
                  const Icon(Icons.check_circle, color: Color(0xFF22C55E), size: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: PrimaryButton(
            label: 'BACK TO HOME',
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const OrdersScreen()),
              (route) => route.isFirst,
            ),
          ),
        ),
      ),
    );
  }

  Widget _row(String label, String value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: bold ? 14 : 12.5, color: bold ? Colors.black : Colors.grey.shade600, fontWeight: bold ? FontWeight.w800 : FontWeight.w400)),
        Text(value, style: TextStyle(fontSize: bold ? 16 : 12.5, fontWeight: bold ? FontWeight.w800 : FontWeight.w700)),
      ],
    );
  }
}