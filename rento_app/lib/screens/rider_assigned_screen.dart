// // // import 'package:flutter/material.dart';
// // // import 'package:url_launcher/url_launcher.dart';
// // // import '../theme/app_theme.dart';
// // // import '../widgets/primary_button.dart';
// // // import '../services/orders_service.dart';
// // // import 'rental_order.dart';
// // // import 'live_tracking_screen.dart';

// // // class RiderAssignedScreen extends StatelessWidget {
// // //   final RentalOrder order;
// // //   const RiderAssignedScreen({super.key, required this.order});

// // //   // TODO: replace with the real rider's number, e.g. order.riderPhone,
// // //   // once that field exists on RentalOrder.
// // //   static const String _riderPhone = '+919876543210';

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.white,
// // //       appBar: AppBar(
// // //         backgroundColor: Colors.white,
// // //         elevation: 0,
// // //         foregroundColor: Colors.black,
// // //         leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
// // //         title: const Text('Rider Assigned', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16)),
// // //         actions: const [
// // //           Padding(
// // //             padding: EdgeInsets.only(right: 16),
// // //             child: Center(
// // //               child: Row(children: [
// // //                 Icon(Icons.verified_user_outlined, size: 15, color: Colors.black54),
// // //                 SizedBox(width: 4),
// // //                 Text('Secure Booking', style: TextStyle(fontSize: 11, color: Colors.black54)),
// // //               ]),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //       body: SafeArea(
// // //         child: ListView(
// // //           padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
// // //           children: [
// // //             Center(
// // //               child: Column(
// // //                 children: [
// // //                   Container(
// // //                     width: 72,
// // //                     height: 72,
// // //                     decoration: const BoxDecoration(color: Color(0xFFEAFBF0), shape: BoxShape.circle),
// // //                     child: const Icon(Icons.two_wheeler, size: 32, color: Color(0xFF16A34A)),
// // //                   ),
// // //                   const SizedBox(height: 14),
// // //                   const Text('Rider Assigned!', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
// // //                   const SizedBox(height: 6),
// // //                   Text(
// // //                     'Your order is confirmed and the rider\nis on the way',
// // //                     textAlign: TextAlign.center,
// // //                     style: TextStyle(color: Colors.grey.shade600, fontSize: 12.5, height: 1.4),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //             const SizedBox(height: 24),
// // //             Container(
// // //               padding: const EdgeInsets.all(14),
// // //               decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
// // //               child: Column(
// // //                 children: [
// // //                   Row(
// // //                     crossAxisAlignment: CrossAxisAlignment.center,
// // //                     children: [
// // //                       const CircleAvatar(radius: 24, backgroundColor: Color(0xFFF3F4F6), child: Icon(Icons.person, color: Colors.black54, size: 24)),
// // //                       const SizedBox(width: 10),
// // //                       Expanded(
// // //                         child: Column(
// // //                           crossAxisAlignment: CrossAxisAlignment.start,
// // //                           children: [
// // //                             const Text('Rohit Kumar',
// // //                                 maxLines: 1,
// // //                                 overflow: TextOverflow.ellipsis,
// // //                                 style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
// // //                             const SizedBox(height: 2),
// // //                             Row(
// // //                               children: [
// // //                                 const Icon(Icons.star, size: 13, color: Colors.amber),
// // //                                 const SizedBox(width: 3),
// // //                                 Text('4.8', style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600)),
// // //                                 const SizedBox(width: 6),
// // //                                 Flexible(
// // //                                   child: Text(
// // //                                     'KA 05 JK 1234',
// // //                                     maxLines: 1,
// // //                                     overflow: TextOverflow.ellipsis,
// // //                                     style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600),
// // //                                   ),
// // //                                 ),
// // //                               ],
// // //                             ),
// // //                           ],
// // //                         ),
// // //                       ),
// // //                       const SizedBox(width: 6),
// // //                       _circleIconButton(Icons.call_outlined, () => _callRider(context)),
// // //                       const SizedBox(width: 8),
// // //                       _circleIconButton(Icons.chat_bubble_outline, () => _messageRider(context)),
// // //                     ],
// // //                   ),
// // //                   const SizedBox(height: 14),
// // //                   Container(
// // //                     padding: const EdgeInsets.all(10),
// // //                     decoration: BoxDecoration(color: AppTheme.lightGrey, borderRadius: BorderRadius.circular(10)),
// // //                     child: Row(
// // //                       children: [
// // //                         const Icon(Icons.notifications_active_outlined, size: 15, color: Colors.black54),
// // //                         const SizedBox(width: 8),
// // //                         Expanded(
// // //                           child: Text(
// // //                             "You'll receive updates when your rider is about to reach your pickup location.",
// // //                             style: TextStyle(fontSize: 11, color: Colors.grey.shade700, height: 1.3),
// // //                           ),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //             const SizedBox(height: 16),
// // //             Container(
// // //               padding: const EdgeInsets.all(14),
// // //               decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   _addressRow(Icons.storefront_outlined, 'Pickup From', 'Camera World, Indiranagar, Bengaluru'),
// // //                   const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider(height: 1)),
// // //                   _addressRow(Icons.location_on_outlined, 'Deliver To',
// // //                       order.deliveryAddress.isEmpty ? '12, 3rd Main Road, Indiranagar, Bengaluru — 560038' : order.deliveryAddress),
// // //                 ],
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //       bottomNavigationBar: SafeArea(
// // //         child: Padding(
// // //           padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
// // //           child: PrimaryButton(
// // //             label: 'TRACK ORDER',
// // //             icon: Icons.my_location,
// // //             onPressed: () {
// // //               final updatedOrder = order.copyWith(status: OrderStatus.outForDelivery);
// // //               OrdersService.instance.upsert(updatedOrder);
// // //               Navigator.push(
// // //                 context,
// // //                 MaterialPageRoute(builder: (_) => LiveTrackingScreen(order: updatedOrder)),
// // //               );
// // //             },
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Future<void> _callRider(BuildContext context) async {
// // //     final uri = Uri(scheme: 'tel', path: _riderPhone);
// // //     final launched = await canLaunchUrl(uri) && await launchUrl(uri);
// // //     if (!launched && context.mounted) {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(content: Text('Could not open the phone dialer')),
// // //       );
// // //     }
// // //   }

// // //   Future<void> _messageRider(BuildContext context) async {
// // //     final uri = Uri(scheme: 'sms', path: _riderPhone);
// // //     final launched = await canLaunchUrl(uri) && await launchUrl(uri);
// // //     if (!launched && context.mounted) {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(content: Text('Could not open the messaging app')),
// // //       );
// // //     }
// // //   }

// // //   Widget _circleIconButton(IconData icon, VoidCallback onTap) {
// // //     return GestureDetector(
// // //       onTap: onTap,
// // //       child: Container(
// // //         width: 38,
// // //         height: 38,
// // //         decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
// // //         child: Icon(icon, color: Colors.white, size: 17),
// // //       ),
// // //     );
// // //   }

// // //   Widget _addressRow(IconData icon, String label, String value) {
// // //     return Row(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         Icon(icon, size: 16, color: Colors.black54),
// // //         const SizedBox(width: 10),
// // //         Expanded(
// // //           child: Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               Text(label, style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
// // //               Text(value, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600)),
// // //             ],
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // // }




















// // import 'package:flutter/material.dart';
// // import '../theme/app_theme.dart';
// // import '../widgets/primary_button.dart';
// // import '../services/orders_service.dart';
// // import 'rental_order.dart';
// // import 'live_tracking_screen.dart';

// // class RiderAssignedScreen extends StatelessWidget {
// //   final RentalOrder order;
// //   const RiderAssignedScreen({super.key, required this.order});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         foregroundColor: Colors.black,
// //         leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
// //         title: const Text('Rider Assigned', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16)),
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
// //           padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
// //           children: [
// //             Center(
// //               child: Column(
// //                 children: [
// //                   Container(
// //                     width: 72,
// //                     height: 72,
// //                     decoration: const BoxDecoration(color: Color(0xFFEAFBF0), shape: BoxShape.circle),
// //                     child: const Icon(Icons.two_wheeler, size: 32, color: Color(0xFF16A34A)),
// //                   ),
// //                   const SizedBox(height: 14),
// //                   const Text('Rider Assigned!', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
// //                   const SizedBox(height: 6),
// //                   Text(
// //                     'Your order is confirmed and the rider\nis on the way',
// //                     textAlign: TextAlign.center,
// //                     style: TextStyle(color: Colors.grey.shade600, fontSize: 12.5, height: 1.4),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             const SizedBox(height: 24),
// //             Container(
// //               padding: const EdgeInsets.all(14),
// //               decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
// //               child: Column(
// //                 children: [
// //                   Row(
// //                     children: [
// //                       const CircleAvatar(radius: 26, backgroundColor: Color(0xFFF3F4F6), child: Icon(Icons.person, color: Colors.black54, size: 26)),
// //                       const SizedBox(width: 12),
// //                       Expanded(
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             const Text('Rohit Kumar', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
// //                             Row(children: [
// //                               const Icon(Icons.star, size: 13, color: Colors.amber),
// //                               const SizedBox(width: 3),
// //                               Text('4.8', style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600)),
// //                               const SizedBox(width: 8),
// //                               Text('KA 05 JK 1234', style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600)),
// //                             ]),
// //                           ],
// //                         ),
// //                       ),
// //                       _circleIconButton(Icons.call_outlined, () => ScaffoldMessenger.of(context).showSnackBar(
// //                             const SnackBar(content: Text('Calling Rohit Kumar...')),
// //                           )),
// //                       const SizedBox(width: 8),
// //                       _circleIconButton(Icons.chat_bubble_outline, () => ScaffoldMessenger.of(context).showSnackBar(
// //                             const SnackBar(content: Text('Opening chat with rider...')),
// //                           )),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 14),
// //                   Container(
// //                     padding: const EdgeInsets.all(10),
// //                     decoration: BoxDecoration(color: AppTheme.lightGrey, borderRadius: BorderRadius.circular(10)),
// //                     child: Row(
// //                       children: [
// //                         const Icon(Icons.notifications_active_outlined, size: 15, color: Colors.black54),
// //                         const SizedBox(width: 8),
// //                         Expanded(
// //                           child: Text(
// //                             "You'll receive updates when your rider is about to reach your pickup location.",
// //                             style: TextStyle(fontSize: 11, color: Colors.grey.shade700, height: 1.3),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             const SizedBox(height: 16),
// //             Container(
// //               padding: const EdgeInsets.all(14),
// //               decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   _addressRow(Icons.storefront_outlined, 'Pickup From', 'Camera World, Indiranagar, Bengaluru'),
// //                   if (order.pickupFromOwnerTime != null) ...[
// //                     const SizedBox(height: 6),
// //                     _addressRow(Icons.schedule_outlined, 'Pickup Time', RentalOrder.formatTime(order.pickupFromOwnerTime!)),
// //                   ],
// //                   const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider(height: 1)),
// //                   _addressRow(Icons.location_on_outlined, 'Deliver To',
// //                       order.deliveryAddress.isEmpty ? '12, 3rd Main Road, Indiranagar, Bengaluru — 560038' : order.deliveryAddress),
// //                   if (order.deliveredToCustomerTime != null) ...[
// //                     const SizedBox(height: 6),
// //                     _addressRow(Icons.schedule_outlined, 'Expected Delivery', RentalOrder.formatTime(order.deliveredToCustomerTime!)),
// //                   ],
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
// //             label: 'TRACK ORDER',
// //             icon: Icons.my_location,
// //             onPressed: () {
// //               final updatedOrder = order.copyWith(status: OrderStatus.outForDelivery);
// //               OrdersService.instance.upsert(updatedOrder);
// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(builder: (_) => LiveTrackingScreen(order: updatedOrder)),
// //               );
// //             },
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _circleIconButton(IconData icon, VoidCallback onTap) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         width: 38,
// //         height: 38,
// //         decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
// //         child: Icon(icon, color: Colors.white, size: 17),
// //       ),
// //     );
// //   }

// //   Widget _addressRow(IconData icon, String label, String value) {
// //     return Row(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Icon(icon, size: 16, color: Colors.black54),
// //         const SizedBox(width: 10),
// //         Expanded(
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(label, style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
// //               Text(value, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600)),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
































// import 'package:flutter/material.dart';
// import '../theme/app_theme.dart';
// import '../widgets/primary_button.dart';
// import '../services/orders_service.dart';
// import 'rental_order.dart';
// import 'live_tracking_screen.dart';

// class RiderAssignedScreen extends StatelessWidget {
//   final RentalOrder order;
//   const RiderAssignedScreen({super.key, required this.order});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         foregroundColor: Colors.black,
//         leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
//         title: const Text('Rider Assigned', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16)),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 16),
//             child: Center(
//               child: Row(children: [
//                 //Icon(Icons.verified_user_outlined, size: 15, color: Colors.black54),
//                 //SizedBox(width: 4),
//                 //Text('Secure Booking', style: TextStyle(fontSize: 11, color: Colors.black54)),
//               ]),
//             ),
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: ListView(
//           padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
//           children: [
//             Center(
//               child: Column(
//                 children: [
//                   Container(
//                     width: 72,
//                     height: 72,
//                     decoration: const BoxDecoration(color: Color(0xFFEAFBF0), shape: BoxShape.circle),
//                     child: const Icon(Icons.two_wheeler, size: 32, color: Color(0xFF16A34A)),
//                   ),
//                   const SizedBox(height: 14),
//                   const Text('Rider Assigned!', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
//                   const SizedBox(height: 6),
//                   Text(
//                     'Your order is confirmed and the rider\nis on the way',
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
//                       const CircleAvatar(radius: 26, backgroundColor: Color(0xFFF3F4F6), child: Icon(Icons.person, color: Colors.black54, size: 26)),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text('Rohit Kumar', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
//                             Row(children: [
//                               const Icon(Icons.star, size: 13, color: Colors.amber),
//                               const SizedBox(width: 3),
//                               Text('4.8', style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600)),
//                               const SizedBox(width: 8),
//                               Flexible(
//                                 child: Text('KA 05 JK 1234',
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600)),
//                               ),
//                             ]),
//                           ],
//                         ),
//                       ),
//                       _circleIconButton(Icons.call_outlined, () => ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text('Calling Rohit Kumar...')),
//                           )),
//                       const SizedBox(width: 8),
//                       _circleIconButton(Icons.chat_bubble_outline, () => ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text('Opening chat with rider...')),
//                           )),
//                     ],
//                   ),
//                   const SizedBox(height: 14),
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(color: AppTheme.lightGrey, borderRadius: BorderRadius.circular(10)),
//                     child: Row(
//                       children: [
//                         const Icon(Icons.notifications_active_outlined, size: 15, color: Colors.black54),
//                         const SizedBox(width: 8),
//                         Expanded(
//                           child: Text(
//                             "You'll receive updates when your rider is about to reach your pickup location.",
//                             style: TextStyle(fontSize: 11, color: Colors.grey.shade700, height: 1.3),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//             Container(
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _addressRow(Icons.storefront_outlined, 'Pickup From', 'Camera World, Indiranagar, Bengaluru'),
//                   const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider(height: 1)),
//                   _addressRow(Icons.location_on_outlined, 'Deliver To',
//                       order.deliveryAddress.isEmpty ? '12, 3rd Main Road, Indiranagar, Bengaluru — 560038' : order.deliveryAddress),
//                   if (order.deliverySlot != null) ...[
//                     const SizedBox(height: 6),
//                     _addressRow(Icons.schedule_outlined, 'Delivery Slot', order.deliverySlot!),
//                   ],
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
//             label: 'TRACK ORDER',
//             icon: Icons.my_location,
//             onPressed: () {
//               final updatedOrder = order.copyWith(status: OrderStatus.outForDelivery);
//               OrdersService.instance.upsert(updatedOrder);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => LiveTrackingScreen(order: updatedOrder)),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _circleIconButton(IconData icon, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 38,
//         height: 38,
//         decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
//         child: Icon(icon, color: Colors.white, size: 17),
//       ),
//     );
//   }

//   Widget _addressRow(IconData icon, String label, String value) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(icon, size: 16, color: Colors.black54),
//         const SizedBox(width: 10),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(label, style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
//               Text(value, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

















// (Older commented-out versions of this screen were removed here for
// brevity — only the active, compiled class is shown below. If you
// need the historical versions back, they're in your previous file.)

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:rento_india/delivery/core/constants/app_colors.dart';//import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/primary_button.dart';
import '../services/orders_service.dart';
import 'rental_order.dart';
import 'live_tracking_screen.dart';

class RiderAssignedScreen extends StatelessWidget {
  final RentalOrder order;
  const RiderAssignedScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      appBar: AppBar(
        backgroundColor: AppColors.pureWhite,
        elevation: 0,
        foregroundColor: AppColors.primaryBlack,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: Text('Rider Assigned', style: AppText.titleLg.copyWith(fontSize: 16)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Row(children: [
                //Icon(Icons.verified_user_outlined, size: 15, color: Colors.black54),
                //SizedBox(width: 4),
                //Text('Secure Booking', style: TextStyle(fontSize: 11, color: Colors.black54)),
              ]),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: const BoxDecoration(color: Color(0xFFEAFBF0), shape: BoxShape.circle),
                    child: const Icon(Icons.two_wheeler, size: 32, color: Color(0xFF16A34A)),
                  ),
                  const SizedBox(height: 14),
                  Text('Rider Assigned!', style: AppText.displaySm.copyWith(fontWeight: FontWeight.w800, fontSize: 18)),
                  const SizedBox(height: 6),
                  Text(
                    'Your order is confirmed and the rider\nis on the way',
                    textAlign: TextAlign.center,
                    style: AppText.bodySm.copyWith(fontSize: 12.5, height: 1.4),
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
                      const CircleAvatar(radius: 26, backgroundColor: Color(0xFFF3F4F6), child: Icon(Icons.person, color: AppColors.textSecondary, size: 26)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rohit Kumar', style: AppText.titleSm.copyWith(fontSize: 14)),
                            Row(children: [
                              const Icon(Icons.star, size: 13, color: Colors.amber),
                              const SizedBox(width: 3),
                              Text('4.8', style: AppText.caption.copyWith(fontSize: 11.5)),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text('KA 05 JK 1234',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppText.caption.copyWith(fontSize: 11.5)),
                              ),
                            ]),
                          ],
                        ),
                      ),
                      _circleIconButton(Icons.call_outlined, () => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Calling Rohit Kumar...')),
                          )),
                      const SizedBox(width: 8),
                      _circleIconButton(Icons.chat_bubble_outline, () => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Opening chat with rider...')),
                          )),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: AppTheme.lightGrey, borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        const Icon(Icons.notifications_active_outlined, size: 15, color: AppColors.textSecondary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "You'll receive updates when your rider is about to reach your pickup location.",
                            style: AppText.bodySm.copyWith(fontSize: 11, height: 1.3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _addressRow(Icons.storefront_outlined, 'Pickup From', 'Camera World, Indiranagar, Bengaluru'),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider(height: 1)),
                  _addressRow(Icons.location_on_outlined, 'Deliver To',
                      order.deliveryAddress.isEmpty ? '12, 3rd Main Road, Indiranagar, Bengaluru — 560038' : order.deliveryAddress),
                  if (order.deliverySlot != null) ...[
                    const SizedBox(height: 6),
                    _addressRow(Icons.schedule_outlined, 'Delivery Slot', order.deliverySlot!),
                  ],
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
            label: 'TRACK ORDER',
            icon: Icons.my_location,
            onPressed: () {
              final updatedOrder = order.copyWith(status: OrderStatus.outForDelivery);
              OrdersService.instance.upsert(updatedOrder);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LiveTrackingScreen(order: updatedOrder)),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _circleIconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(color: AppColors.primaryBlack, shape: BoxShape.circle),
        child: Icon(icon, color: AppColors.pureWhite, size: 17),
      ),
    );
  }

  Widget _addressRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppText.caption.copyWith(fontSize: 11)),
              Text(value, style: AppText.titleSm.copyWith(fontSize: 12.5, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }
}