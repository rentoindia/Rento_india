// import 'package:flutter/material.dart';
// import '../theme/app_theme.dart';
// import '../widgets/primary_button.dart';
// import 'rental_order.dart';
// import 'orders_screen.dart';

// class ExtensionApprovedScreen extends StatelessWidget {
//   final RentalOrder order;
//   final int additionalDays;
//   final double additionalAmount;

//   const ExtensionApprovedScreen({
//     super.key,
//     required this.order,
//     required this.additionalDays,
//     required this.additionalAmount,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         foregroundColor: Colors.black,
//         leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
//         title: const Text('Extension Approved', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16)),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 16),
//             child: Center(
//               child: Row(children: [
//                 Icon(Icons.verified_user_outlined, size: 15, color: Colors.black54),
//                 SizedBox(width: 4),
//                 //Text('Secure Booking', style: TextStyle(fontSize: 11, color: Colors.black54)),
//               ]),
//             ),
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: ListView(
//           padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
//           children: [
//             Center(
//               child: Column(
//                 children: [
//                   Container(
//                     width: 80,
//                     height: 80,
//                     decoration: const BoxDecoration(color: Color(0xFFEAFBF0), shape: BoxShape.circle),
//                     child: const Icon(Icons.verified, size: 40, color: Color(0xFF22C55E)),
//                   ),
//                   const SizedBox(height: 16),
//                   const Text('Extension Approved!', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
//                   const SizedBox(height: 6),
//                   Text(
//                     'Your rental extension has been\napproved successfully.',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.grey.shade600, fontSize: 12.5, height: 1.4),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),
//             Container(
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Builder(builder: (_) {
//                           final imgPath = order.imageUrl ??
//                               'https://loremflickr.com/100/100/${order.imageQuery.replaceAll(' ', ',')}?lock=${order.name.hashCode.abs() % 5000}';
//                           final isAsset = !imgPath.startsWith('http');
//                           return isAsset
//                               ? Image.asset(imgPath, width: 48, height: 48, fit: BoxFit.cover,
//                                   errorBuilder: (_, __, ___) => Container(width: 48, height: 48, color: AppTheme.lightGrey, child: const Icon(Icons.image_outlined)))
//                               : Image.network(imgPath, width: 48, height: 48, fit: BoxFit.cover,
//                                   errorBuilder: (_, __, ___) => Container(width: 48, height: 48, color: AppTheme.lightGrey, child: const Icon(Icons.image_outlined)));
//                         }),
//                       ),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(order.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
//                             Text(order.categoryLabel, style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
//                         decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
//                         child: Text('$additionalDays DAYS', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
//                       ),
//                     ],
//                   ),
//                   const Divider(height: 24),
//                   _row('New End Date', RentalOrder.formatDate(order.endDate)),
//                   _row('Total Extended', '$additionalDays Days'),
//                   _row('Total Additional Amount', '₹${additionalAmount.toStringAsFixed(0)}'),
//                   _row('Next Return Due', RentalOrder.formatDate(order.endDate)),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//               decoration: BoxDecoration(color: const Color(0xFFEAFBF0), borderRadius: BorderRadius.circular(12)),
//               child: Row(
//                 children: [
//                   const Icon(Icons.check_circle_outline, size: 18, color: Color(0xFF22C55E)),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: Text(
//                       'Your rental has been extended. The new return date has been updated.',
//                       style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700, height: 1.3),
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
//             label: 'OK, GOT IT',
//             onPressed: () => Navigator.of(context).pushAndRemoveUntil(
//               MaterialPageRoute(builder: (_) => const OrdersScreen()),
//               (route) => route.isFirst,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _row(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(children: [
//             Icon(Icons.calendar_today_outlined, size: 13, color: Colors.grey.shade500),
//             const SizedBox(width: 6),
//             Text(label, style: TextStyle(fontSize: 12.5, color: Colors.grey.shade600)),
//           ]),
//           Text(value, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700)),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';
import 'rental_order.dart';
import 'orders_screen.dart';

class ExtensionApprovedScreen extends StatelessWidget {
  final RentalOrder order;
  final int additionalDays;
  final double additionalAmount;

  const ExtensionApprovedScreen({
    super.key,
    required this.order,
    required this.additionalDays,
    required this.additionalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: const Text('Extension Approved', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Row(children: [
                Icon(Icons.verified_user_outlined, size: 15, color: Colors.black54),
                SizedBox(width: 4),
                //Text('Secure Booking', style: TextStyle(fontSize: 11, color: Colors.black54)),
              ]),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(color: Color(0xFFEAFBF0), shape: BoxShape.circle),
                    child: const Icon(Icons.verified, size: 40, color: Color(0xFF22C55E)),
                  ),
                  const SizedBox(height: 16),
                  const Text('Extension Approved!', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                  const SizedBox(height: 6),
                  Text(
                    'Your rental extension has been\napproved successfully.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12.5, height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Builder(builder: (_) {
                          final imgPath = order.imageUrl ??
                              'https://loremflickr.com/100/100/${order.imageQuery.replaceAll(' ', ',')}?lock=${order.name.hashCode.abs() % 5000}';
                          final isAsset = !imgPath.startsWith('http');
                          return isAsset
                              ? Image.asset(imgPath, width: 48, height: 48, fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(width: 48, height: 48, color: AppTheme.lightGrey, child: const Icon(Icons.image_outlined)))
                              : Image.network(imgPath, width: 48, height: 48, fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(width: 48, height: 48, color: AppTheme.lightGrey, child: const Icon(Icons.image_outlined)));
                        }),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(order.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
                            Text(order.categoryLabel, style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
                        child: Text('$additionalDays DAYS', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  _row('New End Date', RentalOrder.formatDate(order.endDate)),
                  _row('Total Extended', '$additionalDays Days'),
                  _row('Total Additional Amount', '₹${additionalAmount.toStringAsFixed(0)}'),
                  _row('Next Return Due', RentalOrder.formatDate(order.endDate)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(color: const Color(0xFFEAFBF0), borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_outline, size: 18, color: Color(0xFF22C55E)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Your rental has been extended. The new return date has been updated.',
                      style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700, height: 1.3),
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
            label: 'OK, GOT IT',
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const OrdersScreen()),
              (route) => route.isFirst,
            ),
          ),
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Icon(Icons.calendar_today_outlined, size: 13, color: Colors.grey.shade500),
            const SizedBox(width: 6),
            Text(label, style: TextStyle(fontSize: 12.5, color: Colors.grey.shade600)),
          ]),
          Text(value, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}