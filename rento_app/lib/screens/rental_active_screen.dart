// // import 'package:flutter/material.dart';
// // import '../theme/app_theme.dart';
// // import 'rental_order.dart';
// // import 'extend_rental_screen.dart';
// // import 'buy_product_screen.dart';
// // import 'complete_return_screen.dart';
// // import 'request_purchase_screen.dart';

// // class RentalActiveScreen extends StatelessWidget {
// //   final RentalOrder order;
// //   const RentalActiveScreen({super.key, required this.order});

// //   int get _daysRemaining {
// //     final now = DateTime.now();
// //     final today = DateTime(now.year, now.month, now.day);
// //     final remaining = order.endDate.difference(today).inDays;
// //     return remaining < 0 ? 0 : remaining;
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         foregroundColor: Colors.black,
// //         leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
// //         title: const Text('Rental Active', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16)),
// //         actions: const [
// //           Padding(
// //             padding: EdgeInsets.only(right: 16),
// //             child: Center(
// //               child: Row(children: [
// //                 Icon(Icons.verified_user_outlined, size: 15, color: Colors.black54),
// //                 SizedBox(width: 4),
// //                 //Text('Secure Booking', style: TextStyle(fontSize: 11, color: Colors.black54)),
// //               ]),
// //             ),
// //           ),
// //         ],
// //       ),
// //       body: SafeArea(
// //         child: ListView(
// //           padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
// //           children: [
// //             _stepIndicator(),
// //             const SizedBox(height: 18),
// //             Container(
// //               padding: const EdgeInsets.all(14),
// //               decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Row(
// //                     children: [
// //                       ClipRRect(
// //                         borderRadius: BorderRadius.circular(10),
// //                         child: Image.network(
// //                           'https://loremflickr.com/110/110/${order.imageQuery.replaceAll(' ', ',')}?lock=${order.name.hashCode.abs() % 5000}',
// //                           width: 56, height: 56, fit: BoxFit.cover,
// //                           errorBuilder: (_, __, ___) => Container(width: 56, height: 56, color: AppTheme.lightGrey, child: const Icon(Icons.image_outlined)),
// //                         ),
// //                       ),
// //                       const SizedBox(width: 12),
// //                       Expanded(
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Text(order.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5)),
// //                             Text(order.categoryLabel, style: TextStyle(color: Colors.grey.shade600, fontSize: 11.5)),
// //                             const SizedBox(height: 2),
// //                             // TODO: replace order.id with your real order-ID field if named differently.
// //                             Text('Order ID: #${order.id}', style: TextStyle(color: Colors.grey.shade500, fontSize: 10.5)),
// //                           ],
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   const Divider(height: 26),
// //                   _row('Start Date', RentalOrder.formatDate(order.startDate)),
// //                   _row('End Date', RentalOrder.formatDate(order.endDate)),
// //                   _row('Days Remaining', '$_daysRemaining Days', bold: true),
// //                 ],
// //               ),
// //             ),
// //             const SizedBox(height: 14),
// //             Row(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 const Icon(Icons.info_outline, size: 16, color: Colors.black54),
// //                 const SizedBox(width: 10),
// //                 Expanded(
// //                   child: RichText(
// //                     text: TextSpan(
// //                       style: const TextStyle(fontSize: 12.5, height: 1.4, fontFamily: 'Roboto'),
// //                       children: [
// //                         const TextSpan(
// //                           text: 'Need it a few more days? ',
// //                           style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
// //                         ),
// //                         TextSpan(
// //                           text: 'Extend before the end date.',
// //                           style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w500),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 16),
// //             GestureDetector(
// //               onTap: () => _goToExtend(context),
// //               child: Container(
// //                 padding: const EdgeInsets.all(14),
// //                 decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
// //                 child: Row(
// //                   children: [
// //                     Container(
// //                       padding: const EdgeInsets.all(8),
// //                       decoration: BoxDecoration(color: AppTheme.lightGrey, borderRadius: BorderRadius.circular(10)),
// //                       child: const Icon(Icons.event_repeat_outlined, size: 18, color: Colors.black87),
// //                     ),
// //                     const SizedBox(width: 12),
// //                     const Expanded(
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Text('Extend Rental', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
// //                           Text('Select a new end date and pay any additional rental amount.',
// //                               style: TextStyle(fontSize: 11, color: Colors.black54)),
// //                         ],
// //                       ),
// //                     ),
// //                     const Icon(Icons.chevron_right, color: Colors.black38),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 12),
// //             GestureDetector(
// //               onTap: () => _goToCompleteReturn(context),
// //               child: Container(
// //                 padding: const EdgeInsets.all(14),
// //                 decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
// //                 child: Row(
// //                   children: [
// //                     Container(
// //                       padding: const EdgeInsets.all(8),
// //                       decoration: BoxDecoration(color: AppTheme.lightGrey, borderRadius: BorderRadius.circular(10)),
// //                       child: const Icon(Icons.assignment_turned_in_outlined, size: 18, color: Colors.black87),
// //                     ),
// //                     const SizedBox(width: 12),
// //                     const Expanded(
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Text('Complete & Return', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
// //                           Text('Confirm that you\'re done and schedule a return pickup.',
// //                               style: TextStyle(fontSize: 11, color: Colors.black54)),
// //                         ],
// //                       ),
// //                     ),
// //                     const Icon(Icons.chevron_right, color: Colors.black38),
// //                   ],
// //                 ),
// //               ),
// //             ),

// //             if (order.isAvailableForPurchase) ...[
// //   const SizedBox(height: 12),
// //   GestureDetector(
// //     onTap: () => Navigator.push(
// //       context,
// //       MaterialPageRoute(builder: (_) => BuyProductScreen(order: order)),
// //     ),
// //     child: Container(
// //       padding: const EdgeInsets.all(14),
// //       decoration: BoxDecoration(
// //         border: Border.all(color: const Color(0xFF22C55E)),
// //         borderRadius: BorderRadius.circular(14),
// //         color: const Color(0xFFEAFBF0),
// //       ),
// //       child: Row(
// //         children: [
// //           Container(
// //             padding: const EdgeInsets.all(8),
// //             decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
// //             child: const Icon(Icons.shopping_bag_outlined, size: 18, color: Color(0xFF16A34A)),
// //           ),
// //           const SizedBox(width: 12),
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 const Text('Buy This Product',
// //                     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xFF15803D))),
// //                 Text(
// //                   order.purchasePrice != null
// //                       ? 'Available for ₹${order.purchasePrice!.toStringAsFixed(0)} — keep it for good.'
// //                       : 'The owner has approved this item for purchase.',
// //                   style: const TextStyle(fontSize: 11, color: Color(0xFF15803D)),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           const Icon(Icons.chevron_right, color: Color(0xFF16A34A)),
// //         ],
// //       ),
// //     ),
// //   ),
// // ],
// //           ],
// //         ),
// //       ),
// //       bottomNavigationBar: SafeArea(
// //         child: Container(
// //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //           decoration: BoxDecoration(
// //             color: Colors.white,
// //             border: Border(top: BorderSide(color: AppTheme.border)),
// //           ),
// //           child: Row(
// //             children: [
// //               const Icon(Icons.check_circle_outline, size: 15, color: Colors.black54),
// //               const SizedBox(width: 8),
// //               Expanded(
// //                 child: Text(
// //                   'Vendor approval is required for rental extension requests.',
// //                   style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   // ---------- STEP PROGRESS INDICATOR ----------
// //   Widget _stepIndicator() {
// //     return Row(
// //       children: [
// //         _step(number: '1', label: 'Rental Active', active: true),
// //         Expanded(
// //           child: Container(height: 2, margin: const EdgeInsets.symmetric(horizontal: 6), color: AppTheme.border),
// //         ),
// //         _step(number: '2', label: 'Extend Rental', active: false),
// //       ],
// //     );
// //   }

// //   Widget _step({required String number, required String label, required bool active}) {
// //     return Column(
// //       children: [
// //         Container(
// //           width: 26,
// //           height: 26,
// //           alignment: Alignment.center,
// //           decoration: BoxDecoration(
// //             color: active ? Colors.black : AppTheme.lightGrey,
// //             shape: BoxShape.circle,
// //           ),
// //           child: Text(number,
// //               style: TextStyle(
// //                   color: active ? Colors.white : Colors.grey.shade500,
// //                   fontWeight: FontWeight.w700,
// //                   fontSize: 12)),
// //         ),
// //         const SizedBox(height: 6),
// //         Text(label,
// //             style: TextStyle(
// //                 fontSize: 11,
// //                 fontWeight: active ? FontWeight.w700 : FontWeight.w500,
// //                 color: active ? Colors.black : Colors.grey.shade500)),
// //       ],
// //     );
// //   }

// //   Widget _row(String label, String value, {bool bold = false}) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 4),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           Text(label, style: TextStyle(fontSize: 12.5, color: Colors.grey.shade600)),
// //           Text(value, style: TextStyle(fontSize: 12.5, fontWeight: bold ? FontWeight.w800 : FontWeight.w700)),
// //         ],
// //       ),
// //     );
// //   }

// //   void _goToExtend(BuildContext context) {
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(builder: (_) => ExtendRentalScreen(order: order)),
// //     );
// //   }

// //   void _goToCompleteReturn(BuildContext context) {
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(builder: (_) => CompleteReturnScreen(order: order)),
// //     );
// //   }
// // }






























// import 'package:flutter/material.dart';
// import '../theme/app_theme.dart';
// import 'rental_order.dart';
// import 'extend_rental_screen.dart';
// import 'buy_product_screen.dart';
// import 'request_purchase_screen.dart';
// import 'complete_return_screen.dart';

// class RentalActiveScreen extends StatelessWidget {
//   final RentalOrder order;
//   const RentalActiveScreen({super.key, required this.order});

//   int get _daysRemaining {
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);
//     final remaining = order.endDate.difference(today).inDays;
//     return remaining < 0 ? 0 : remaining;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         foregroundColor: Colors.black,
//         leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
//         title: const Text('Rental Active', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16)),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 16),
//             child: Center(
//               child: Row(children: [
//                 Icon(Icons.verified_user_outlined, size: 15, color: Colors.black54),
//                 SizedBox(width: 4),
//               ]),
//             ),
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: ListView(
//           padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
//           children: [
//             _stepIndicator(),
//             const SizedBox(height: 18),
//             Container(
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Builder(builder: (_) {
//                           final imgPath = order.imageUrl ??
//                               'https://loremflickr.com/110/110/${order.imageQuery.replaceAll(' ', ',')}?lock=${order.name.hashCode.abs() % 5000}';
//                           final isAsset = !imgPath.startsWith('http');
//                           return isAsset
//                               ? Image.asset(imgPath, width: 56, height: 56, fit: BoxFit.cover,
//                                   errorBuilder: (_, __, ___) => Container(width: 56, height: 56, color: AppTheme.lightGrey, child: const Icon(Icons.image_outlined)))
//                               : Image.network(imgPath, width: 56, height: 56, fit: BoxFit.cover,
//                                   errorBuilder: (_, __, ___) => Container(width: 56, height: 56, color: AppTheme.lightGrey, child: const Icon(Icons.image_outlined)));
//                         }),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(order.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5)),
//                             Text(order.categoryLabel, style: TextStyle(color: Colors.grey.shade600, fontSize: 11.5)),
//                             const SizedBox(height: 2),
//                             // TODO: replace order.id with your real order-ID field if named differently.
//                             Text('Order ID: #${order.id}', style: TextStyle(color: Colors.grey.shade500, fontSize: 10.5)),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Divider(height: 26),
//                   _row('Start Date', RentalOrder.formatDate(order.startDate)),
//                   _row('End Date', RentalOrder.formatDate(order.endDate)),
//                   _row('Days Remaining', '$_daysRemaining Days', bold: true),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 14),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Icon(Icons.info_outline, size: 16, color: Colors.black54),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: RichText(
//                     text: TextSpan(
//                       style: const TextStyle(fontSize: 12.5, height: 1.4, fontFamily: 'Roboto'),
//                       children: [
//                         const TextSpan(
//                           text: 'Need it a few more days? ',
//                           style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
//                         ),
//                         TextSpan(
//                           text: 'Extend before the end date.',
//                           style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             GestureDetector(
//               onTap: () => _goToExtend(context),
//               child: Container(
//                 padding: const EdgeInsets.all(14),
//                 decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
//                 child: Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(color: AppTheme.lightGrey, borderRadius: BorderRadius.circular(10)),
//                       child: const Icon(Icons.event_repeat_outlined, size: 18, color: Colors.black87),
//                     ),
//                     const SizedBox(width: 12),
//                     const Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Extend Rental', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
//                           Text('Select a new end date and pay any additional rental amount.',
//                               style: TextStyle(fontSize: 11, color: Colors.black54)),
//                         ],
//                       ),
//                     ),
//                     const Icon(Icons.chevron_right, color: Colors.black38),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 12),
//             GestureDetector(
//               onTap: () => _goToCompleteReturn(context),
//               child: Container(
//                 padding: const EdgeInsets.all(14),
//                 decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
//                 child: Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(color: AppTheme.lightGrey, borderRadius: BorderRadius.circular(10)),
//                       child: const Icon(Icons.assignment_turned_in_outlined, size: 18, color: Colors.black87),
//                     ),
//                     const SizedBox(width: 12),
//                     const Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Complete & Return', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
//                           Text('Confirm that you\'re done and schedule a return pickup.',
//                               style: TextStyle(fontSize: 11, color: Colors.black54)),
//                         ],
//                       ),
//                     ),
//                     const Icon(Icons.chevron_right, color: Colors.black38),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 12),
//             _buildBuyTile(context),
//           ],
//         ),
//       ),
//       bottomNavigationBar: SafeArea(
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border(top: BorderSide(color: AppTheme.border)),
//           ),
//           child: Row(
//             children: [
//               const Icon(Icons.check_circle_outline, size: 15, color: Colors.black54),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: Text(
//                   'Vendor approval is required for rental extension requests.',
//                   style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ---------- BUY TILE (3 states) ----------
//   // State 1 (isAvailableForPurchase == true): owner approved — go buy.
//   // State 2 (purchaseRequested == true, not yet approved): waiting.
//   // State 3 (default): invite the customer to request a purchase.
//   Widget _buildBuyTile(BuildContext context) {
//     if (order.isAvailableForPurchase) {
//       return GestureDetector(
//         onTap: () => Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => BuyProductScreen(order: order)),
//         ),
//         child: Container(
//           padding: const EdgeInsets.all(14),
//           decoration: BoxDecoration(
//             border: Border.all(color: const Color(0xFF22C55E)),
//             borderRadius: BorderRadius.circular(14),
//             color: const Color(0xFFEAFBF0),
//           ),
//           child: Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
//                 child: const Icon(Icons.shopping_bag_outlined, size: 18, color: Color(0xFF16A34A)),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text('Buy This Product',
//                         style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xFF15803D))),
//                     Text(
//                       order.purchasePrice != null
//                           ? 'Approved — buy for ₹${order.purchasePrice!.toStringAsFixed(0)}.'
//                           : 'The owner has approved this item for purchase.',
//                       style: const TextStyle(fontSize: 11, color: Color(0xFF15803D)),
//                     ),
//                   ],
//                 ),
//               ),
//               const Icon(Icons.chevron_right, color: Color(0xFF16A34A)),
//             ],
//           ),
//         ),
//       );
//     }

//     if (order.purchaseRequested) {
//       return Container(
//         padding: const EdgeInsets.all(14),
//         decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14), color: AppTheme.lightGrey),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
//               child: const Icon(Icons.hourglass_top_outlined, size: 18, color: Colors.black54),
//             ),
//             const SizedBox(width: 12),
//             const Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Purchase Request Sent', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Colors.black54)),
//                   Text('Waiting for the owner to review your request.',
//                       style: TextStyle(fontSize: 11, color: Colors.black45)),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return GestureDetector(
//       onTap: () => Navigator.push(
//         context,
//         MaterialPageRoute(builder: (_) => RequestPurchaseScreen(order: order)),
//       ),
//       child: Container(
//         padding: const EdgeInsets.all(14),
//         decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(color: AppTheme.lightGrey, borderRadius: BorderRadius.circular(10)),
//               child: const Icon(Icons.shopping_bag_outlined, size: 18, color: Colors.black87),
//             ),
//             const SizedBox(width: 12),
//             const Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Buy This Product', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
//                   Text('Love it? Request to buy this from the owner.',
//                       style: TextStyle(fontSize: 11, color: Colors.black54)),
//                 ],
//               ),
//             ),
//             const Icon(Icons.chevron_right, color: Colors.black38),
//           ],
//         ),
//       ),
//     );
//   }

//   // ---------- STEP PROGRESS INDICATOR ----------
//   Widget _stepIndicator() {
//     return Row(
//       children: [
//         _step(number: '1', label: 'Rental Active', active: true),
//         Expanded(
//           child: Container(height: 2, margin: const EdgeInsets.symmetric(horizontal: 6), color: AppTheme.border),
//         ),
//         _step(number: '2', label: 'Extend Rental', active: false),
//       ],
//     );
//   }

//   Widget _step({required String number, required String label, required bool active}) {
//     return Column(
//       children: [
//         Container(
//           width: 26,
//           height: 26,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: active ? Colors.black : AppTheme.lightGrey,
//             shape: BoxShape.circle,
//           ),
//           child: Text(number,
//               style: TextStyle(
//                   color: active ? Colors.white : Colors.grey.shade500,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 12)),
//         ),
//         const SizedBox(height: 6),
//         Text(label,
//             style: TextStyle(
//                 fontSize: 11,
//                 fontWeight: active ? FontWeight.w700 : FontWeight.w500,
//                 color: active ? Colors.black : Colors.grey.shade500)),
//       ],
//     );
//   }

//   Widget _row(String label, String value, {bool bold = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: TextStyle(fontSize: 12.5, color: Colors.grey.shade600)),
//           Text(value, style: TextStyle(fontSize: 12.5, fontWeight: bold ? FontWeight.w800 : FontWeight.w700)),
//         ],
//       ),
//     );
//   }

//   void _goToExtend(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => ExtendRentalScreen(order: order)),
//     );
//   }

//   void _goToCompleteReturn(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => CompleteReturnScreen(order: order)),
//     );
//   }
// }





import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'rental_order.dart';
import 'extend_rental_screen.dart';
import 'buy_product_screen.dart';
import 'request_purchase_screen.dart';
import 'complete_return_screen.dart';

/// Category-specific button labels for the four "booking" categories
/// (occasion/stay based, not day-to-day rented). Order.categoryLabel
/// is expected to match one of these keys exactly for a booking-type
/// order. Any category NOT in this map falls back to the standard
/// Extend Rental / Complete & Return / Buy layout further below.
const Map<String, List<String>> _bookingCategoryButtonLabels = {
  'Hotels and Resorts': ['Extend Stay', 'Check Out'],
  'Party Halls': ['Extend Booking', 'Complete Event'],
  'Boats & Yachts': ['Extend Booking', 'End Trip'],
  'Private Rental Jets': ['Extend Booking', 'Complete Flight'],
};

class RentalActiveScreen extends StatelessWidget {
  final RentalOrder order;
  const RentalActiveScreen({super.key, required this.order});

  int get _daysRemaining {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final remaining = order.endDate.difference(today).inDays;
    return remaining < 0 ? 0 : remaining;
  }

  List<String>? get _bookingLabels => _bookingCategoryButtonLabels[order.categoryLabel];

  @override
  Widget build(BuildContext context) {
    final bookingLabels = _bookingLabels;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: const Text('Rental Active', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Row(children: [
                Icon(Icons.verified_user_outlined, size: 15, color: Colors.black54),
                SizedBox(width: 4),
              ]),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          children: [
            _stepIndicator(),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Builder(builder: (_) {
                          final imgPath = order.imageUrl ??
                              'https://loremflickr.com/110/110/${order.imageQuery.replaceAll(' ', ',')}?lock=${order.name.hashCode.abs() % 5000}';
                          final isAsset = !imgPath.startsWith('http');
                          return isAsset
                              ? Image.asset(imgPath, width: 56, height: 56, fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(width: 56, height: 56, color: AppTheme.lightGrey, child: const Icon(Icons.image_outlined)))
                              : Image.network(imgPath, width: 56, height: 56, fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(width: 56, height: 56, color: AppTheme.lightGrey, child: const Icon(Icons.image_outlined)));
                        }),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(order.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5)),
                            Text(order.categoryLabel, style: TextStyle(color: Colors.grey.shade600, fontSize: 11.5)),
                            const SizedBox(height: 2),
                            Text('Order ID: #${order.id}', style: TextStyle(color: Colors.grey.shade500, fontSize: 10.5)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 26),
                  _row('Start Date', RentalOrder.formatDate(order.startDate)),
                  _row('End Date', RentalOrder.formatDate(order.endDate)),
                  _row('Days Remaining', '$_daysRemaining Days', bold: true),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ---- BOOKING CATEGORIES: exactly two simple buttons ----
            // if (bookingLabels != null) ...[
            //   Row(
            //     children: [
            //       Expanded(
            //         child: OutlinedButton(
            //           onPressed: () => _goToExtend(context),
            //           style: OutlinedButton.styleFrom(
            //             side: BorderSide(color: AppTheme.border),
            //             padding: const EdgeInsets.symmetric(vertical: 14),
            //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            //           ),
            //           child: Text(bookingLabels[0],
            //               style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 13)),
            //         ),
            //       ),
            //       const SizedBox(width: 12),
            //       Expanded(
            //         child: ElevatedButton(
            //           onPressed: () => _goToCompleteReturn(context),
            //           style: ElevatedButton.styleFrom(
            //             backgroundColor: Colors.black,
            //             padding: const EdgeInsets.symmetric(vertical: 14),
            //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            //             elevation: 0,
            //           ),
            //           child: Text(bookingLabels[1],
            //               style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
            //         ),
            //       ),
            //     ],
            //   ),
            // ] else ...[

            if (bookingLabels != null) ...[
              _tileButton(
                icon: Icons.event_repeat_outlined,
                title: bookingLabels[0],
                subtitle: _extendSubtitleFor(order.categoryLabel),
                onTap: () => _goToExtend(context),
              ),
              const SizedBox(height: 12),
              _tileButton(
                icon: Icons.assignment_turned_in_outlined,
                title: bookingLabels[1],
                subtitle: _finishSubtitleFor(order.categoryLabel),
                onTap: () => _goToCompleteReturn(context),
              ),
            ] else ...[

              // ---- EVERY OTHER CATEGORY: original full layout ----
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline, size: 16, color: Colors.black54),
                  const SizedBox(width: 10),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 12.5, height: 1.4, fontFamily: 'Roboto'),
                        children: [
                          const TextSpan(
                            text: 'Need it a few more days? ',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
                          ),
                          TextSpan(
                            text: 'Extend before the end date.',
                            style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => _goToExtend(context),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: AppTheme.lightGrey, borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.event_repeat_outlined, size: 18, color: Colors.black87),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Extend Rental', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                            Text('Select a new end date and pay any additional rental amount.',
                                style: TextStyle(fontSize: 11, color: Colors.black54)),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: Colors.black38),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => _goToCompleteReturn(context),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: AppTheme.lightGrey, borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.assignment_turned_in_outlined, size: 18, color: Colors.black87),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Complete & Return', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                            Text('Confirm that you\'re done and schedule a return pickup.',
                                style: TextStyle(fontSize: 11, color: Colors.black54)),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: Colors.black38),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _buildBuyTile(context),
            ],
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: AppTheme.border)),
          ),
          child: Row(
            children: [
              const Icon(Icons.check_circle_outline, size: 15, color: Colors.black54),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  bookingLabels != null
                      ? 'Vendor approval is required for booking changes.'
                      : 'Vendor approval is required for rental extension requests.',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- BUY TILE (3 states) — non-booking categories only ----------
  Widget _buildBuyTile(BuildContext context) {
    if (order.isAvailableForPurchase) {
      return GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => BuyProductScreen(order: order)),
        ),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF22C55E)),
            borderRadius: BorderRadius.circular(14),
            color: const Color(0xFFEAFBF0),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.shopping_bag_outlined, size: 18, color: Color(0xFF16A34A)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Buy This Product',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xFF15803D))),
                    Text(
                      order.purchasePrice != null
                          ? 'Approved — buy for ₹${order.purchasePrice!.toStringAsFixed(0)}.'
                          : 'The owner has approved this item for purchase.',
                      style: const TextStyle(fontSize: 11, color: Color(0xFF15803D)),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Color(0xFF16A34A)),
            ],
          ),
        ),
      );
    }

    if (order.purchaseRequested) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14), color: AppTheme.lightGrey),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.hourglass_top_outlined, size: 18, color: Colors.black54),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Purchase Request Sent', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Colors.black54)),
                  Text('Waiting for the owner to review your request.',
                      style: TextStyle(fontSize: 11, color: Colors.black45)),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => RequestPurchaseScreen(order: order)),
      ),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: AppTheme.lightGrey, borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.shopping_bag_outlined, size: 18, color: Colors.black87),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Buy This Product', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                  Text('Love it? Request to buy this from the owner.',
                      style: TextStyle(fontSize: 11, color: Colors.black54)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.black38),
          ],
        ),
      ),
    );
  }




  Widget _tileButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: AppTheme.lightGrey, borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, size: 18, color: Colors.black87),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                  Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.black54)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.black38),
          ],
        ),
      ),
    );
  }

  String _extendSubtitleFor(String category) {
    switch (category) {
      case 'Hotels and Resorts':
        return 'Add more nights to your stay.';
      case 'Party Halls':
        return 'Extend your venue booking hours.';
      case 'Boats & Yachts':
        return 'Extend your time on the water.';
      case 'Private Rental Jets':
        return 'Extend your charter duration.';
      default:
        return 'Select a new end date and pay any additional amount.';
    }
  }

  String _finishSubtitleFor(String category) {
    switch (category) {
      case 'Hotels and Resorts':
        return 'Confirm your stay is complete.';
      case 'Party Halls':
        return 'Confirm the event has ended.';
      case 'Boats & Yachts':
        return 'Confirm the trip has ended.';
      case 'Private Rental Jets':
        return 'Confirm the flight is complete.';
      default:
        return 'Confirm that you\'re done.';
    }
  }

  // ---------- STEP PROGRESS INDICATOR ----------
  Widget _stepIndicator() {
    return Row(
      children: [
        _step(number: '1', label: 'Rental Active', active: true),
        Expanded(
          child: Container(height: 2, margin: const EdgeInsets.symmetric(horizontal: 6), color: AppTheme.border),
        ),
        _step(number: '2', label: 'Extend Rental', active: false),
      ],
    );
  }

  Widget _step({required String number, required String label, required bool active}) {
    return Column(
      children: [
        Container(
          width: 26,
          height: 26,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? Colors.black : AppTheme.lightGrey,
            shape: BoxShape.circle,
          ),
          child: Text(number,
              style: TextStyle(
                  color: active ? Colors.white : Colors.grey.shade500,
                  fontWeight: FontWeight.w700,
                  fontSize: 12)),
        ),
        const SizedBox(height: 6),
        Text(label,
            style: TextStyle(
                fontSize: 11,
                fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                color: active ? Colors.black : Colors.grey.shade500)),
      ],
    );
  }

  Widget _row(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 12.5, color: Colors.grey.shade600)),
          Text(value, style: TextStyle(fontSize: 12.5, fontWeight: bold ? FontWeight.w800 : FontWeight.w700)),
        ],
      ),
    );
  }

  void _goToExtend(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ExtendRentalScreen(order: order)),
    );
  }

  void _goToCompleteReturn(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CompleteReturnScreen(order: order)),
    );
  }
}