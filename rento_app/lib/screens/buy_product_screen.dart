// import 'package:flutter/material.dart';
// import '../theme/app_theme.dart';
// import '../widgets/primary_button.dart';
// import '../services/orders_service.dart';
// import 'rental_order.dart';

// class BuyProductScreen extends StatelessWidget {
//   final RentalOrder order;
//   const BuyProductScreen({super.key, required this.order});

//   @override
//   Widget build(BuildContext context) {
//     final price = order.purchasePrice ?? 0;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         foregroundColor: Colors.black,
//         leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
//         title: const Text('Buy This Product', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16)),
//       ),
//       body: SafeArea(
//         child: ListView(
//           padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
//           children: [
//             Container(
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
//               child: Row(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.network(
//                       'https://loremflickr.com/110/110/${order.imageQuery.replaceAll(' ', ',')}?lock=${order.name.hashCode.abs() % 5000}',
//                       width: 64, height: 64, fit: BoxFit.cover,
//                       errorBuilder: (_, __, ___) => Container(width: 64, height: 64, color: AppTheme.lightGrey, child: const Icon(Icons.image_outlined)),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(order.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5)),
//                         Text(order.categoryLabel, style: TextStyle(color: Colors.grey.shade600, fontSize: 11.5)),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//               decoration: BoxDecoration(color: const Color(0xFFEAFBF0), borderRadius: BorderRadius.circular(12)),
//               child: const Row(
//                 children: [
//                   Icon(Icons.verified_outlined, color: Color(0xFF22C55E), size: 18),
//                   SizedBox(width: 8),
//                   Expanded(
//                     child: Text('The owner has approved this item for purchase.',
//                         style: TextStyle(color: Color(0xFF15803D), fontWeight: FontWeight.w600, fontSize: 12.5)),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text('Purchase Summary', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
//             const SizedBox(height: 12),
//             _row('Purchase Price', '₹${price.toStringAsFixed(0)}'),
//             _row('Security Deposit (Adjusted)', '- ${order.securityDeposit}'),
//             const Divider(height: 26),
//             _row('Amount Payable', '₹${(price - order.securityDepositValue).clamp(0, price).toStringAsFixed(0)}', bold: true),
//             const SizedBox(height: 20),
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(color: AppTheme.lightGrey, borderRadius: BorderRadius.circular(10)),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Icon(Icons.info_outline, size: 15, color: Colors.black54),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: Text(
//                       "Your existing security deposit will be adjusted against the purchase price. Once purchased, this item is yours to keep — no further rental charges apply.",
//                       style: TextStyle(fontSize: 11, color: Colors.grey.shade700, height: 1.4),
//                     ),
//                   ),
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
//             label: 'PROCEED TO PAYMENT',
//             icon: Icons.shopping_bag_outlined,
//             onPressed: () => _confirmPurchase(context),
//           ),
//         ),
//       ),
//     );
//   }

//   void _confirmPurchase(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (dialogContext) => AlertDialog(
//         title: const Text('Confirm Purchase'),
//         content: Text('Buy ${order.name} for ₹${(order.purchasePrice ?? 0).toStringAsFixed(0)}? This action cannot be undone.'),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(dialogContext).pop(),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               // TODO: hook up real payment flow here. For now this just
//               // marks the order completed (as "purchased") and pops back.
//               final purchasedOrder = order.copyWith(status: OrderStatus.completed);
//               OrdersService.instance.upsert(purchasedOrder);
//               Navigator.of(dialogContext).pop();
//               Navigator.of(context).pop();
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('${order.name} purchased successfully!')),
//               );
//             },
//             child: const Text('Confirm', style: TextStyle(fontWeight: FontWeight.w700)),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _row(String label, String value, {bool bold = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: TextStyle(fontSize: 12.5, color: bold ? Colors.black : Colors.grey.shade600, fontWeight: bold ? FontWeight.w700 : FontWeight.w500)),
//           Text(value, style: TextStyle(fontSize: bold ? 15 : 12.5, fontWeight: bold ? FontWeight.w800 : FontWeight.w700)),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';
import '../services/orders_service.dart';
import 'rental_order.dart';

class BuyProductScreen extends StatelessWidget {
  final RentalOrder order;
  const BuyProductScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final price = order.purchasePrice ?? 0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: const Text('Buy This Product', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16)),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://loremflickr.com/110/110/${order.imageQuery.replaceAll(' ', ',')}?lock=${order.name.hashCode.abs() % 5000}',
                      width: 64, height: 64, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(width: 64, height: 64, color: AppTheme.lightGrey, child: const Icon(Icons.image_outlined)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(order.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5)),
                        Text(order.categoryLabel, style: TextStyle(color: Colors.grey.shade600, fontSize: 11.5)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(color: const Color(0xFFEAFBF0), borderRadius: BorderRadius.circular(12)),
              child: const Row(
                children: [
                  Icon(Icons.verified_outlined, color: Color(0xFF22C55E), size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text('The owner has approved this item for purchase.',
                        style: TextStyle(color: Color(0xFF15803D), fontWeight: FontWeight.w600, fontSize: 12.5)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Purchase Summary', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            const SizedBox(height: 12),
            _row('Purchase Price', '₹${price.toStringAsFixed(0)}'),
            _row('Security Deposit (Adjusted)', '- ${order.securityDeposit}'),
            const Divider(height: 26),
            _row('Amount Payable', '₹${(price - order.securityDepositValue).clamp(0, price).toStringAsFixed(0)}', bold: true),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: AppTheme.lightGrey, borderRadius: BorderRadius.circular(10)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline, size: 15, color: Colors.black54),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Your existing security deposit will be adjusted against the purchase price. Once purchased, this item is yours to keep — no further rental charges apply.",
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade700, height: 1.4),
                    ),
                  ),
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
            label: 'PROCEED TO PAYMENT',
            icon: Icons.shopping_bag_outlined,
            onPressed: () => _confirmPurchase(context),
          ),
        ),
      ),
    );
  }

  void _confirmPurchase(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirm Purchase'),
        content: Text('Buy ${order.name} for ₹${(order.purchasePrice ?? 0).toStringAsFixed(0)}? This action cannot be undone.'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: hook up real payment flow here. For now this just
              // marks the order completed (as "purchased") and pops back.
              final purchasedOrder = order.copyWith(status: OrderStatus.completed);
              OrdersService.instance.upsert(purchasedOrder);
              Navigator.of(dialogContext).pop();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${order.name} purchased successfully!')),
              );
            },
            child: const Text('Confirm', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 12.5, color: bold ? Colors.black : Colors.grey.shade600, fontWeight: bold ? FontWeight.w700 : FontWeight.w500)),
          Text(value, style: TextStyle(fontSize: bold ? 15 : 12.5, fontWeight: bold ? FontWeight.w800 : FontWeight.w700)),
        ],
      ),
    );
  }
}