// import 'package:flutter/material.dart';
// import '../theme/app_theme.dart';
// import '../widgets/primary_button.dart';
// import '../services/orders_service.dart';
// import 'rental_order.dart';

// class RequestPurchaseScreen extends StatelessWidget {
//   final RentalOrder order;
//   const RequestPurchaseScreen({super.key, required this.order});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         foregroundColor: Colors.black,
//         leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
//         title: const Text('Request to Buy', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16)),
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
//             const SizedBox(height: 20),
//             Container(
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(color: const Color(0xFFF7F5FF), borderRadius: BorderRadius.circular(12)),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Icon(Icons.info_outline, size: 16, color: Color(0xFF6D5EF8)),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: Text(
//                       "Loved this product and want to keep it? Send a request to the owner. They'll review it and set a purchase price — you'll be notified once they respond.",
//                       style: TextStyle(fontSize: 12, color: Colors.grey.shade700, height: 1.4),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text('What happens next?', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
//             const SizedBox(height: 10),
//             _stepRow('1', 'Your request is sent to the product owner.'),
//             _stepRow('2', 'The owner reviews it and sets a purchase price.'),
//             _stepRow('3', 'You\'ll see a "Buy Now" option here once approved.'),
//           ],
//         ),
//       ),
//       bottomNavigationBar: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
//           child: PrimaryButton(
//             label: 'SEND PURCHASE REQUEST',
//             icon: Icons.send_outlined,
//             onPressed: () {
//               final updatedOrder = order.copyWith(purchaseRequested: true);
//               OrdersService.instance.upsert(updatedOrder);
//               Navigator.of(context).pop();
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Purchase request sent to the owner')),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _stepRow(String number, String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 22, height: 22,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(color: AppTheme.lightGrey, shape: BoxShape.circle),
//             child: Text(number, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
//           ),
//           const SizedBox(width: 10),
//           Expanded(child: Text(text, style: const TextStyle(fontSize: 12.5, height: 1.4))),
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

class RequestPurchaseScreen extends StatelessWidget {
  final RentalOrder order;
  const RequestPurchaseScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: const Text('Request to Buy', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16)),
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
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: const Color(0xFFF7F5FF), borderRadius: BorderRadius.circular(12)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline, size: 16, color: Color(0xFF6D5EF8)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Loved this product and want to keep it? Send a request to the owner. They'll review it and set a purchase price — you'll be notified once they respond.",
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade700, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('What happens next?', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            const SizedBox(height: 10),
            _stepRow('1', 'Your request is sent to the product owner.'),
            _stepRow('2', 'The owner reviews it and sets a purchase price.'),
            _stepRow('3', 'You\'ll see a "Buy Now" option here once approved.'),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: PrimaryButton(
            label: 'SEND PURCHASE REQUEST',
            icon: Icons.send_outlined,
            onPressed: () {
              final updatedOrder = order.copyWith(purchaseRequested: true);
              OrdersService.instance.upsert(updatedOrder);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Purchase request sent to the owner')),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _stepRow(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22, height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: AppTheme.lightGrey, shape: BoxShape.circle),
            child: Text(number, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 12.5, height: 1.4))),
        ],
      ),
    );
  }
}