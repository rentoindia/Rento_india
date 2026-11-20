// // import 'dart:async';
// // import 'package:flutter/material.dart';
// // import '../theme/app_theme.dart';
// // import '../widgets/primary_button.dart';
// // import '../services/cart_service.dart';
// // import 'product_details_screen.dart' show buildImageUrl;
// // import 'select_duration_screen.dart';

// // // class CartScreen extends StatelessWidget {
// // //   const CartScreen({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return AnimatedBuilder(
// // //       animation: CartService.instance,
// // //       builder: (context, _) {

// // class CartScreen extends StatefulWidget {
// //   const CartScreen({super.key});

// //   @override
// //   State<CartScreen> createState() => _CartScreenState();
// // }

// // class _CartScreenState extends State<CartScreen> {
// //   static const _purple = Colors.black87;

// //   @override
// //   void initState() {
// //     super.initState();
// //     // Clears the home-screen cart badge the moment this screen opens,
// //     // without touching the actual items in the cart.
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       CartService.instance.markCartSeen();
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return AnimatedBuilder(
// //       animation: CartService.instance,
// //       builder: (context, _) {
// //         final items = CartService.instance.items;
// //         return Scaffold(
// //           backgroundColor: const Color(0xFFF7F8FA),
// //           appBar: AppBar(
// //             backgroundColor: Colors.white,
// //             elevation: 0,
// //             foregroundColor: Colors.black,
// //             leading: IconButton(
// //               icon: const Icon(Icons.arrow_back),
// //               onPressed: () => Navigator.of(context).pop(),
// //             ),
// //             title: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 const Text('Cart',
// //                     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: Colors.black)),
// //                 if (items.isNotEmpty)
// //                   Text('${items.length} item${items.length == 1 ? '' : 's'}',
// //                       style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600)),
// //               ],
// //             ),
// //             actions: [
// //               if (items.isNotEmpty) ...[
// //                 IconButton(
// //                   icon: const Icon(Icons.favorite_border, size: 20),
// //                   onPressed: () {
// //                     ScaffoldMessenger.of(context).showSnackBar(
// //                       const SnackBar(content: Text('Saved for later')),
// //                     );
// //                   },
// //                 ),
// //                 IconButton(
// //                   icon: const Icon(Icons.delete_outline, size: 20),
// //                   onPressed: () => _confirmClearCart(context),
// //                 ),
// //               ],
// //             ],
// //           ),
// //           body: items.isEmpty ? _buildEmptyState(context) : _buildCartBody(context, items),
// //         );
// //       },
// //     );
// //   }

// //   // ---------- EMPTY STATE ----------
// //   Widget _buildEmptyState(BuildContext context) {
// //     return Center(
// //       child: Padding(
// //         padding: const EdgeInsets.all(32),
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             Container(
// //               width: 96,
// //               height: 96,
// //               decoration: BoxDecoration(color: AppTheme.lightGrey, shape: BoxShape.circle),
// //               child: const Icon(Icons.shopping_cart_outlined, size: 42, color: Colors.black38),
// //             ),
// //             const SizedBox(height: 20),
// //             const Text('Your cart is empty',
// //                 style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
// //             const SizedBox(height: 8),
// //             Text(
// //               'Browse rentals and tap "Add to Cart" on\nany product to see it here.',
// //               textAlign: TextAlign.center,
// //               style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 1.4),
// //             ),
// //             const SizedBox(height: 24),
// //             SizedBox(
// //               width: double.infinity,
// //               child: PrimaryButton(
// //                 label: 'BROWSE RENTALS',
// //                 onPressed: () => Navigator.of(context).pop(),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // ---------- CART BODY (scrollable content + fixed checkout bar) ----------
// //   Widget _buildCartBody(BuildContext context, List<CartItem> items) {
// //     final cart = CartService.instance;
// //     const deliveryFee = 149.0;
// //     final gst = cart.subtotal * 0.18;
// //     final totalAmount = cart.subtotal + cart.totalDeposit + deliveryFee + gst;
// //     String rupees(double v) => '₹${v.toStringAsFixed(0)}';

// //     return Column(
// //       children: [
// //         Expanded(
// //           child: ListView(
// //             padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
// //             children: [
// //               // const _ReservationTimer(),
// //               // const SizedBox(height: 14),
// //               ...items.map((item) => Padding(
// //                     padding: const EdgeInsets.only(bottom: 12),
// //                     child: _CartItemCard(item: item),
// //                   )),
// //               // _promoCodeRow(context),
// //               // const SizedBox(height: 14),
// //               _priceDetailsCard(cart, deliveryFee, gst, totalAmount, rupees),
// //               const SizedBox(height: 14),
// //               _securePaymentsBanner(),
// //             ],
// //           ),
// //         ),
// //         _checkoutBar(context, items, totalAmount),
// //       ],
// //     );
// //   }

// //   Widget _promoCodeRow(BuildContext context) {
// //     return GestureDetector(
// //       onTap: () {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text('Promo codes coming soon')),
// //         );
// //       },
// //       child: Container(
// //         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(14),
// //           border: Border.all(color: AppTheme.border),
// //         ),
// //         child: Row(
// //           children: [
// //             const Icon(Icons.local_offer_outlined, size: 18, color: Colors.black54),
// //             const SizedBox(width: 10),
// //             const Expanded(
// //               child: Text('Apply Promo Code',
// //                   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
// //             ),
// //             const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _priceDetailsCard(
// //       CartService cart, double deliveryFee, double gst, double totalAmount, String Function(double) rupees) {
// //     return Container(
// //       padding: const EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(14),
// //         border: Border.all(color: AppTheme.border),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const Text('Price Details', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
// //           const SizedBox(height: 12),
// //           _summaryRow('Subtotal (${cart.items.length} items)', rupees(cart.subtotal)),
// //           const SizedBox(height: 8),
// //           _summaryRow('Security Deposit (Refundable)', rupees(cart.totalDeposit)),
// //           const SizedBox(height: 8),
// //           _summaryRow('Delivery Fee', rupees(deliveryFee)),
// //           const SizedBox(height: 8),
// //           _summaryRow('GST (18%)', rupees(gst)),
// //           const Padding(
// //             padding: EdgeInsets.symmetric(vertical: 10),
// //             child: Divider(height: 1),
// //           ),
// //           _summaryRow('Total Amount', rupees(totalAmount), bold: true),
// //         ],
// //       ),
// //     );
// //   }

// //   // Widget _securePaymentsBanner() {
// //   //   return Container(
// //   //     padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
// //   //     decoration: BoxDecoration(
// //   //       color: const Color(0xFFEAFBF0),
// //   //       borderRadius: BorderRadius.circular(12),
// //   //     ),
// //   //     child: Row(
// //   //       children: [
// //   //         const Icon(Icons.verified_user_outlined, color: Color(0xFF22C55E), size: 20),
// //   //         const SizedBox(width: 10),
// //   //         const Expanded(
// //   //           child: Column(
// //   //             crossAxisAlignment: CrossAxisAlignment.start,
// //   //             children: [
// //   //               Text('100% Secure Payments',
// //   //                   style: TextStyle(color: Color(0xFF15803D), fontWeight: FontWeight.w700, fontSize: 13)),
// //   //               Text('Your payments are safe with us.',
// //   //                   style: TextStyle(color: Color(0xFF15803D), fontSize: 11)),
// //   //             ],
// //   //           ),
// //   //         ),
// //   //       ],
// //   //     ),
// //   //   );
// //   // }


// //   Widget _securePaymentsBanner() {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
// //       decoration: BoxDecoration(
// //         color: const Color(0xFFF1F1F1),
// //         borderRadius: BorderRadius.circular(12),
// //       ),
// //       child: Row(
// //         children: [
// //           const Icon(Icons.verified_user_outlined, color: Colors.black87, size: 20),
// //           const SizedBox(width: 10),
// //           const Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text('100% Secure Payments',
// //                     style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 13)),
// //                 Text('Your payments are safe with us.',
// //                     style: TextStyle(color: Colors.black54, fontSize: 11)),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
  

// //   Widget _checkoutBar(BuildContext context, List<CartItem> items, double totalAmount) {
// //     return SafeArea(
// //       top: false,
// //       child: Container(
// //         padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           border: Border(top: BorderSide(color: AppTheme.border)),
// //         ),
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             SizedBox(
// //               width: double.infinity,
// //               height: 52,
// //               child: ElevatedButton(
// //                 onPressed: () {
// //                   // Cart can hold multiple items, but SelectDurationScreen is
// //                   // built for one product at a time — so we take the first
// //                   // item in the cart as the one being rented right now.
// //                   final first = items.first;
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                       builder: (_) => SelectDurationScreen(
// //                         name: first.name,
// //                         price: first.price,
// //                       ),
// //                     ),
// //                   );
// //                 },
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Colors.black,
// //                   foregroundColor: Colors.white,
// //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
// //                   elevation: 0,
// //                 ),
// //                 child: const Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     Text('Proceed to Rent',
// //                         style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
// //                     SizedBox(width: 8),
// //                     Icon(Icons.arrow_forward, size: 16),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 10),
// //             GestureDetector(
// //               onTap: () => Navigator.of(context).pop(),
// //               child: const Text('Continue Shopping',
// //                   style: TextStyle(color: _purple, fontWeight: FontWeight.w600, fontSize: 13)),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   void _confirmClearCart(BuildContext context) {
// //     showDialog(
// //       context: context,
// //       builder: (dialogContext) => AlertDialog(
// //         title: const Text('Clear cart?'),
// //         content: const Text('This will remove all items from your cart.'),
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.of(dialogContext).pop(),
// //             child: const Text('Cancel'),
// //           ),
// //           TextButton(
// //             onPressed: () {
// //               CartService.instance.clear();
// //               Navigator.of(dialogContext).pop();
// //             },
// //             child: const Text('Clear', style: TextStyle(color: Colors.redAccent)),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _summaryRow(String label, String value, {bool bold = false}) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //       children: [
// //         Text(label,
// //             style: TextStyle(
// //                 color: bold ? Colors.black : AppTheme.grey,
// //                 fontWeight: bold ? FontWeight.w800 : FontWeight.w500,
// //                 fontSize: bold ? 15 : 13)),
// //         Text(value,
// //             style: TextStyle(
// //                 color: Colors.black,
// //                 fontWeight: bold ? FontWeight.w800 : FontWeight.w700,
// //                 fontSize: bold ? 16 : 13)),
// //       ],
// //     );
// //   }
// // }

// // // ================= RESERVATION COUNTDOWN BANNER =================
// // class _ReservationTimer extends StatefulWidget {
// //   const _ReservationTimer();

// //   @override
// //   State<_ReservationTimer> createState() => _ReservationTimerState();
// // }

// // class _ReservationTimerState extends State<_ReservationTimer> {
// //   Duration _remaining = const Duration(minutes: 20);
// //   Timer? _timer;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _timer = Timer.periodic(const Duration(seconds: 1), (_) {
// //       if (_remaining.inSeconds <= 0) {
// //         _timer?.cancel();
// //         return;
// //       }
// //       setState(() => _remaining -= const Duration(seconds: 1));
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     _timer?.cancel();
// //     super.dispose();
// //   }

// //   String get _formatted {
// //     final m = _remaining.inMinutes.remainder(60).toString().padLeft(2, '0');
// //     final s = _remaining.inSeconds.remainder(60).toString().padLeft(2, '0');
// //     return '$m:$s';
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
// //       decoration: BoxDecoration(
// //         color: const Color(0xFFEFEBFF),
// //         borderRadius: BorderRadius.circular(12),
// //       ),
// //       child: Row(
// //         children: [
// //           const Icon(Icons.shield_outlined, color: Color(0xFF6D5EF8), size: 20),
// //           const SizedBox(width: 10),
// //           const Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text('Your items are reserved for 20:00 mins',
// //                     style: TextStyle(color: Color(0xFF3C3489), fontWeight: FontWeight.w700, fontSize: 12.5)),
// //                 Text('Complete your booking before the time runs out',
// //                     style: TextStyle(color: Color(0xFF534AB7), fontSize: 10.5)),
// //               ],
// //             ),
// //           ),
// //           Container(
// //             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
// //             decoration: BoxDecoration(
// //               color: Colors.white,
// //               borderRadius: BorderRadius.circular(10),
// //             ),
// //             child: Text(_formatted,
// //                 style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF3C3489))),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // // ================= CART ITEM CARD =================
// // class _CartItemCard extends StatelessWidget {
// //   final CartItem item;
// //   const _CartItemCard({required this.item});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Dismissible(
// //       key: ValueKey(item.name),
// //       direction: DismissDirection.endToStart,
// //       onDismissed: (_) => CartService.instance.remove(item.name),
// //       background: Container(
// //         alignment: Alignment.centerRight,
// //         padding: const EdgeInsets.only(right: 20),
// //         decoration: BoxDecoration(
// //           color: Colors.redAccent,
// //           borderRadius: BorderRadius.circular(14),
// //         ),
// //         child: const Icon(Icons.delete_outline, color: Colors.white),
// //       ),
// //       child: Container(
// //         padding: const EdgeInsets.all(12),
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           border: Border.all(color: AppTheme.border),
// //           borderRadius: BorderRadius.circular(14),
// //         ),
// //         child: Row(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             ClipRRect(
// //               borderRadius: BorderRadius.circular(10),
// //               child: Image.network(
// //                 buildImageUrl(item.imageQuery, item.name),
// //                 width: 72,
// //                 height: 72,
// //                 fit: BoxFit.cover,
// //                 loadingBuilder: (context, child, progress) {
// //                   if (progress == null) return child;
// //                   return Container(
// //                     width: 72,
// //                     height: 72,
// //                     color: AppTheme.lightGrey,
// //                     child: const Center(
// //                       child: SizedBox(
// //                         width: 16,
// //                         height: 16,
// //                         child: CircularProgressIndicator(strokeWidth: 1.5),
// //                       ),
// //                     ),
// //                   );
// //                 },
// //                 errorBuilder: (_, __, ___) => Container(
// //                   width: 72,
// //                   height: 72,
// //                   color: AppTheme.lightGrey,
// //                   child: const Icon(Icons.image_not_supported_outlined, color: Colors.black38),
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(width: 12),
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(item.name,
// //                       maxLines: 1,
// //                       overflow: TextOverflow.ellipsis,
// //                       style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
// //                   const SizedBox(height: 2),
// //                   Text(item.categoryLabel,
// //                       style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
// //                   const SizedBox(height: 8),
// //                   Text('${item.price} / day',
// //                       style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
// //                   const SizedBox(height: 2),
// //                   Text('Security Deposit: ${item.securityDeposit}',
// //                       style: TextStyle(color: Colors.grey.shade600, fontSize: 10.5)),
// //                 ],
// //               ),
// //             ),
// //             Column(
// //               crossAxisAlignment: CrossAxisAlignment.end,
// //               children: [
// //                 GestureDetector(
// //                   onTap: () => CartService.instance.remove(item.name),
// //                   child: const Icon(Icons.delete_outline, size: 20, color: Colors.black38),
// //                 ),
// //                 const SizedBox(height: 20),
// //                 _DaysStepper(item: item),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // +/- control for rental duration (days), matches the app's
// // // pill-shaped counter style used elsewhere.
// // class _DaysStepper extends StatelessWidget {
// //   final CartItem item;
// //   const _DaysStepper({required this.item});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       decoration: BoxDecoration(
// //         border: Border.all(color: AppTheme.border),
// //         borderRadius: BorderRadius.circular(20),
// //       ),
// //       child: Row(
// //         mainAxisSize: MainAxisSize.min,
// //         children: [
// //           _stepBtn(Icons.remove, () => CartService.instance.updateDays(item.name, item.days - 1)),
// //           SizedBox(
// //             width: 24,
// //             child: Text('${item.days}',
// //                 textAlign: TextAlign.center,
// //                 style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
// //           ),
// //           _stepBtn(Icons.add, () => CartService.instance.updateDays(item.name, item.days + 1)),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _stepBtn(IconData icon, VoidCallback onTap) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Padding(
// //         padding: const EdgeInsets.all(6),
// //         child: Icon(icon, size: 14),
// //       ),
// //     );
// //   }
// // }
































// import 'dart:async';
// import 'package:flutter/material.dart';
// import '../theme/app_theme.dart';
// import '../widgets/primary_button.dart';
// import '../services/cart_service.dart';
// import '../services/wallet_service.dart';
// import 'product_details_screen.dart' show buildImageUrl;
// import 'select_duration_screen.dart';
// import 'wallet_screen.dart';

// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   static const _purple = Colors.black87;

//   @override
//   void initState() {
//     super.initState();
//     // Clears the home-screen cart badge the moment this screen opens,
//     // without touching the actual items in the cart.
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       CartService.instance.markCartSeen();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: CartService.instance,
//       builder: (context, _) {
//         final items = CartService.instance.items;
//         return Scaffold(
//           backgroundColor: const Color(0xFFF7F8FA),
//           appBar: AppBar(
//             backgroundColor: Colors.white,
//             elevation: 0,
//             foregroundColor: Colors.black,
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//             title: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text('Cart',
//                     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: Colors.black)),
//                 if (items.isNotEmpty)
//                   Text('${items.length} item${items.length == 1 ? '' : 's'}',
//                       style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600)),
//               ],
//             ),
//             actions: [
//               // NEW: live wallet-balance icon, top-right — tap opens the
//               // real Rento wallet page (RentoScreen), same balance source
//               // (WalletService) it already reads from.
//               const _WalletBadge(),
//               const SizedBox(width: 4),
//               if (items.isNotEmpty) ...[
//                 IconButton(
//                   icon: const Icon(Icons.favorite_border, size: 20),
//                   onPressed: () {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Saved for later')),
//                     );
//                   },
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.delete_outline, size: 20),
//                   onPressed: () => _confirmClearCart(context),
//                 ),
//               ],
//               const SizedBox(width: 4),
//             ],
//           ),
//           body: items.isEmpty ? _buildEmptyState(context) : _buildCartBody(context, items),
//         );
//       },
//     );
//   }

//   // ---------- EMPTY STATE ----------
//   Widget _buildEmptyState(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(32),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 96,
//               height: 96,
//               decoration: BoxDecoration(color: AppTheme.lightGrey, shape: BoxShape.circle),
//               child: const Icon(Icons.shopping_cart_outlined, size: 42, color: Colors.black38),
//             ),
//             const SizedBox(height: 20),
//             const Text('Your cart is empty',
//                 style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
//             const SizedBox(height: 8),
//             Text(
//               'Browse rentals and tap "Add to Cart" on\nany product to see it here.',
//               textAlign: TextAlign.center,
//               style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 1.4),
//             ),
//             const SizedBox(height: 24),
//             SizedBox(
//               width: double.infinity,
//               child: PrimaryButton(
//                 label: 'BROWSE RENTALS',
//                 onPressed: () => Navigator.of(context).pop(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ---------- CART BODY (scrollable content + fixed checkout bar) ----------
//   Widget _buildCartBody(BuildContext context, List<CartItem> items) {
//     final cart = CartService.instance;
//     const deliveryFee = 149.0;
//     final gst = cart.subtotal * 0.18;
//     final totalAmount = cart.subtotal + cart.totalDeposit + deliveryFee + gst;
//     String rupees(double v) => '₹${v.toStringAsFixed(0)}';

//     return Column(
//       children: [
//         Expanded(
//           child: ListView(
//             padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
//             children: [
//               ...items.map((item) => Padding(
//                     padding: const EdgeInsets.only(bottom: 12),
//                     child: _CartItemCard(item: item),
//                   )),
//               _priceDetailsCard(cart, deliveryFee, gst, totalAmount, rupees),
//               const SizedBox(height: 14),
//               _securePaymentsBanner(),
//             ],
//           ),
//         ),
//         _checkoutBar(context, items, totalAmount),
//       ],
//     );
//   }

//   Widget _promoCodeRow(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Promo codes coming soon')),
//         );
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(color: AppTheme.border),
//         ),
//         child: Row(
//           children: [
//             const Icon(Icons.local_offer_outlined, size: 18, color: Colors.black54),
//             const SizedBox(width: 10),
//             const Expanded(
//               child: Text('Apply Promo Code',
//                   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
//             ),
//             const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _priceDetailsCard(
//       CartService cart, double deliveryFee, double gst, double totalAmount, String Function(double) rupees) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: AppTheme.border),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text('Price Details', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
//           const SizedBox(height: 12),
//           _summaryRow('Subtotal (${cart.items.length} items)', rupees(cart.subtotal)),
//           const SizedBox(height: 8),
//           _summaryRow('Security Deposit (Refundable)', rupees(cart.totalDeposit)),
//           const SizedBox(height: 8),
//           _summaryRow('Delivery Fee', rupees(deliveryFee)),
//           const SizedBox(height: 8),
//           _summaryRow('GST (18%)', rupees(gst)),
//           const Padding(
//             padding: EdgeInsets.symmetric(vertical: 10),
//             child: Divider(height: 1),
//           ),
//           _summaryRow('Total Amount', rupees(totalAmount), bold: true),
//         ],
//       ),
//     );
//   }

//   Widget _securePaymentsBanner() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF1F1F1),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.verified_user_outlined, color: Colors.black87, size: 20),
//           const SizedBox(width: 10),
//           const Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('100% Secure Payments',
//                     style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 13)),
//                 Text('Your payments are safe with us.',
//                     style: TextStyle(color: Colors.black54, fontSize: 11)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _checkoutBar(BuildContext context, List<CartItem> items, double totalAmount) {
//     return SafeArea(
//       top: false,
//       child: Container(
//         padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border(top: BorderSide(color: AppTheme.border)),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(
//               width: double.infinity,
//               height: 52,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Cart can hold multiple items, but SelectDurationScreen is
//                   // built for one product at a time — so we take the first
//                   // item in the cart as the one being rented right now.
//                   final first = items.first;
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => SelectDurationScreen(
//                         name: first.name,
//                         price: first.price,
//                       ),
//                     ),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.black,
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
//                   elevation: 0,
//                 ),
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text('Proceed to Rent',
//                         style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
//                     SizedBox(width: 8),
//                     Icon(Icons.arrow_forward, size: 16),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             GestureDetector(
//               onTap: () => Navigator.of(context).pop(),
//               child: const Text('Continue Shopping',
//                   style: TextStyle(color: _purple, fontWeight: FontWeight.w600, fontSize: 13)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _confirmClearCart(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (dialogContext) => AlertDialog(
//         title: const Text('Clear cart?'),
//         content: const Text('This will remove all items from your cart.'),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(dialogContext).pop(),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               CartService.instance.clear();
//               Navigator.of(dialogContext).pop();
//             },
//             child: const Text('Clear', style: TextStyle(color: Colors.redAccent)),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _summaryRow(String label, String value, {bool bold = false}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(label,
//             style: TextStyle(
//                 color: bold ? Colors.black : AppTheme.grey,
//                 fontWeight: bold ? FontWeight.w800 : FontWeight.w500,
//                 fontSize: bold ? 15 : 13)),
//         Text(value,
//             style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: bold ? FontWeight.w800 : FontWeight.w700,
//                 fontSize: bold ? 16 : 13)),
//       ],
//     );
//   }
// }

// // ================= WALLET BALANCE BADGE (app bar icon) =================
// // Small pill showing the live wallet balance, from the same
// // WalletService that rento_screen.dart reads from. Tapping it opens
// // the real Rento wallet page.
// class _WalletBadge extends StatelessWidget {
//   const _WalletBadge();

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: WalletService.instance,
//       builder: (context, _) {
//         final coins = WalletService.instance.coins;
//         return GestureDetector(
//           onTap: () => Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) => const WalletScreen()),
//           ),
//           child: Container(
//             margin: const EdgeInsets.symmetric(vertical: 12),
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//             decoration: BoxDecoration(
//               color: const Color(0xFFF3F4F6),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Icon(Icons.account_balance_wallet_outlined, size: 16, color: Colors.black87),
//                 const SizedBox(width: 5),
//                 Text(
//                   '₹${coins.toStringAsFixed(0)}',
//                   style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.black87),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// // ================= CART ITEM CARD =================
// class _CartItemCard extends StatelessWidget {
//   final CartItem item;
//   const _CartItemCard({required this.item});

//   @override
//   Widget build(BuildContext context) {
//     return Dismissible(
//       key: ValueKey(item.name),
//       direction: DismissDirection.endToStart,
//       onDismissed: (_) => CartService.instance.remove(item.name),
//       background: Container(
//         alignment: Alignment.centerRight,
//         padding: const EdgeInsets.only(right: 20),
//         decoration: BoxDecoration(
//           color: Colors.redAccent,
//           borderRadius: BorderRadius.circular(14),
//         ),
//         child: const Icon(Icons.delete_outline, color: Colors.white),
//       ),
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(color: AppTheme.border),
//           borderRadius: BorderRadius.circular(14),
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image.network(
//                 item.imageUrl ?? buildImageUrl(item.imageQuery, item.name),
//                 width: 72,
//                 height: 72,
//                 fit: BoxFit.cover,
//                 loadingBuilder: (context, child, progress) {
//                   if (progress == null) return child;
//                   return Container(
//                     width: 72,
//                     height: 72,
//                     color: AppTheme.lightGrey,
//                     child: const Center(
//                       child: SizedBox(
//                         width: 16,
//                         height: 16,
//                         child: CircularProgressIndicator(strokeWidth: 1.5),
//                       ),
//                     ),
//                   );
//                 },
//                 errorBuilder: (_, __, ___) => Container(
//                   width: 72,
//                   height: 72,
//                   color: AppTheme.lightGrey,
//                   child: const Icon(Icons.image_not_supported_outlined, color: Colors.black38),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(item.name,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
//                   const SizedBox(height: 2),
//                   Text(item.categoryLabel,
//                       style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
//                   const SizedBox(height: 8),
//                   Text('${item.price} / day',
//                       style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
//                   const SizedBox(height: 2),
//                   Text('Security Deposit: ${item.securityDeposit}',
//                       style: TextStyle(color: Colors.grey.shade600, fontSize: 10.5)),
//                 ],
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 GestureDetector(
//                   onTap: () => CartService.instance.remove(item.name),
//                   child: const Icon(Icons.delete_outline, size: 20, color: Colors.black38),
//                 ),
//                 const SizedBox(height: 20),
//                 _DaysStepper(item: item),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // +/- control for rental duration (days), matches the app's
// // pill-shaped counter style used elsewhere.
// class _DaysStepper extends StatelessWidget {
//   final CartItem item;
//   const _DaysStepper({required this.item});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: AppTheme.border),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           _stepBtn(Icons.remove, () => CartService.instance.updateDays(item.name, item.days - 1)),
//           SizedBox(
//             width: 24,
//             child: Text('${item.days}',
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
//           ),
//           _stepBtn(Icons.add, () => CartService.instance.updateDays(item.name, item.days + 1)),
//         ],
//       ),
//     );
//   }

//   Widget _stepBtn(IconData icon, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.all(6),
//         child: Icon(icon, size: 14),
//       ),
//     );
//   }
// }





import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';
import '../services/cart_service.dart';
import '../services/wallet_service.dart';
import 'product_details_screen.dart' show buildImageUrl;
import 'select_duration_screen.dart';
import 'wallet_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  static const _purple = Colors.black87;

  @override
  void initState() {
    super.initState();
    // Clears the home-screen cart badge the moment this screen opens,
    // without touching the actual items in the cart.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CartService.instance.markCartSeen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: CartService.instance,
      builder: (context, _) {
        final items = CartService.instance.items;
        return Scaffold(
          backgroundColor: const Color(0xFFF7F8FA),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            foregroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Cart',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: Colors.black)),
                if (items.isNotEmpty)
                  Text('${items.length} item${items.length == 1 ? '' : 's'}',
                      style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600)),
              ],
            ),
            actions: [
              // NEW: live wallet-balance icon, top-right — tap opens the
              // real Rento wallet page (RentoScreen), same balance source
              // (WalletService) it already reads from.
              const _WalletBadge(),
              const SizedBox(width: 4),
              if (items.isNotEmpty) ...[
                IconButton(
                  icon: const Icon(Icons.favorite_border, size: 20),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Saved for later')),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 20),
                  onPressed: () => _confirmClearCart(context),
                ),
              ],
              const SizedBox(width: 4),
            ],
          ),
          body: items.isEmpty ? _buildEmptyState(context) : _buildCartBody(context, items),
        );
      },
    );
  }

  // ---------- EMPTY STATE ----------
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(color: AppTheme.lightGrey, shape: BoxShape.circle),
              child: const Icon(Icons.shopping_cart_outlined, size: 42, color: Colors.black38),
            ),
            const SizedBox(height: 20),
            const Text('Your cart is empty',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
            const SizedBox(height: 8),
            Text(
              'Browse rentals and tap "Add to Cart" on\nany product to see it here.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                label: 'BROWSE RENTALS',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- CART BODY (scrollable content + fixed checkout bar) ----------
  Widget _buildCartBody(BuildContext context, List<CartItem> items) {
    final cart = CartService.instance;
    const deliveryFee = 149.0;
    final gst = cart.subtotal * 0.18;
    final totalAmount = cart.subtotal + cart.totalDeposit + deliveryFee + gst;
    String rupees(double v) => '₹${v.toStringAsFixed(0)}';

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            children: [
              ...items.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _CartItemCard(item: item),
                  )),
              _priceDetailsCard(cart, deliveryFee, gst, totalAmount, rupees),
              const SizedBox(height: 14),
              _securePaymentsBanner(),
            ],
          ),
        ),
        _checkoutBar(context, items, totalAmount),
      ],
    );
  }

  Widget _promoCodeRow(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Promo codes coming soon')),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppTheme.border),
        ),
        child: Row(
          children: [
            const Icon(Icons.local_offer_outlined, size: 18, color: Colors.black54),
            const SizedBox(width: 10),
            const Expanded(
              child: Text('Apply Promo Code',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _priceDetailsCard(
      CartService cart, double deliveryFee, double gst, double totalAmount, String Function(double) rupees) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Price Details', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
          const SizedBox(height: 12),
          _summaryRow('Subtotal (${cart.items.length} items)', rupees(cart.subtotal)),
          const SizedBox(height: 8),
          _summaryRow('Security Deposit (Refundable)', rupees(cart.totalDeposit)),
          const SizedBox(height: 8),
          _summaryRow('Delivery Fee', rupees(deliveryFee)),
          const SizedBox(height: 8),
          _summaryRow('GST (18%)', rupees(gst)),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(height: 1),
          ),
          _summaryRow('Total Amount', rupees(totalAmount), bold: true),
        ],
      ),
    );
  }

  Widget _securePaymentsBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.verified_user_outlined, color: Colors.black87, size: 20),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('100% Secure Payments',
                    style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 13)),
                Text('Your payments are safe with us.',
                    style: TextStyle(color: Colors.black54, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkoutBar(BuildContext context, List<CartItem> items, double totalAmount) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppTheme.border)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  // Cart can hold multiple items, but SelectDurationScreen is
                  // built for one product at a time — so we take the first
                  // item in the cart as the one being rented right now.
                  final first = items.first;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SelectDurationScreen(
                        name: first.name,
                        price: first.price,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Proceed to Rent',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Text('Continue Shopping',
                  style: TextStyle(color: _purple, fontWeight: FontWeight.w600, fontSize: 13)),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmClearCart(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Clear cart?'),
        content: const Text('This will remove all items from your cart.'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              CartService.instance.clear();
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Clear', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                color: bold ? Colors.black : AppTheme.grey,
                fontWeight: bold ? FontWeight.w800 : FontWeight.w500,
                fontSize: bold ? 15 : 13)),
        Text(value,
            style: TextStyle(
                color: Colors.black,
                fontWeight: bold ? FontWeight.w800 : FontWeight.w700,
                fontSize: bold ? 16 : 13)),
      ],
    );
  }
}

// ================= WALLET BALANCE BADGE (app bar icon) =================
// Small pill showing the live wallet balance, from the same
// WalletService that rento_screen.dart reads from. Tapping it opens
// the real Rento wallet page.
class _WalletBadge extends StatelessWidget {
  const _WalletBadge();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: WalletService.instance,
      builder: (context, _) {
        final coins = WalletService.instance.coins;
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const WalletScreen()),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.account_balance_wallet_outlined, size: 16, color: Colors.black87),
                const SizedBox(width: 5),
                Text(
                  '₹${coins.toStringAsFixed(0)}',
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.black87),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ================= CART ITEM CARD =================
class _CartItemCard extends StatelessWidget {
  final CartItem item;
  const _CartItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(item.name),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => CartService.instance.remove(item.name),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppTheme.border),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                item.imageUrl ?? buildImageUrl(item.imageQuery, item.name),
                width: 72,
                height: 72,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    width: 72,
                    height: 72,
                    color: AppTheme.lightGrey,
                    child: const Center(
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 1.5),
                      ),
                    ),
                  );
                },
                errorBuilder: (_, __, ___) => Container(
                  width: 72,
                  height: 72,
                  color: AppTheme.lightGrey,
                  child: const Icon(Icons.image_not_supported_outlined, color: Colors.black38),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
                  const SizedBox(height: 2),
                  Text(item.categoryLabel,
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
                  const SizedBox(height: 8),
                  Text('${item.price} / day',
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                  const SizedBox(height: 2),
                  Text('Security Deposit: ${item.securityDeposit}',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 10.5)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => CartService.instance.remove(item.name),
                  child: const Icon(Icons.delete_outline, size: 20, color: Colors.black38),
                ),
                const SizedBox(height: 20),
                _DaysStepper(item: item),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// +/- control for rental duration (days), matches the app's
// pill-shaped counter style used elsewhere.
class _DaysStepper extends StatelessWidget {
  final CartItem item;
  const _DaysStepper({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.border),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _stepBtn(Icons.remove, () => CartService.instance.updateDays(item.name, item.days - 1)),
          SizedBox(
            width: 24,
            child: Text('${item.days}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
          ),
          _stepBtn(Icons.add, () => CartService.instance.updateDays(item.name, item.days + 1)),
        ],
      ),
    );
  }

  Widget _stepBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 14),
      ),
    );
  }
}