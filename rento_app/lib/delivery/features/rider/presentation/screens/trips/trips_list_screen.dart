// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../../../../core/constants/app_colors.dart';
// import '../../../data/models/trip_record_model.dart';
// import 'trip_details_screen.dart';
// import '../earnings/earnings_screen.dart';
// import '../notifications/notifications_screen.dart';

// /// Trips history screen — All / Ongoing / Completed / Cancelled tabs,
// /// with a dark header (matches the rest of the rider app's black
// /// accent cards) and a white sheet underneath holding the list.
// ///
// /// TODO: replace _mockTrips with TripRepository.getTripHistory() once
// /// backend is wired, and wire the "Latest/Oldest" sort + filter tabs
// /// to real query params instead of client-side filtering.
// class TripsListScreen extends StatefulWidget {
//   final VoidCallback? onBack; // ⭐ NEW — lets the shell switch tabs on back

//   const TripsListScreen({super.key, this.onBack});

//   @override
//   State<TripsListScreen> createState() => _TripsListScreenState();
// }

// enum TripFilter { all, ongoing, completed, cancelled }

// enum SortOrder { latest, oldest }

// class _TripsListScreenState extends State<TripsListScreen> {
//   TripFilter _filter = TripFilter.all;
//   SortOrder _sort = SortOrder.latest;

//   static const _mockTrips = [
//     TripRecord(
//       orderId: '#RNT125678',
//       statusValue: TripStatus.delivered,
//       time: '11:30 AM',
//       sortKey: 690,
//       pickupName: 'ABC Electronics',
//       pickupAddress: '12, 3rd Main Rd, Anna Nagar, Chennai - 600040',
//       pickupPhone: '+91 98765 43210',
//       dropName: 'Priya Sharma',
//       dropAddress: '45, North Usman Road, T. Nagar, Chennai - 600017',
//       dropPhone: '+91 91234 56780',
//       distanceKm: 10.2,
//       estimatedMinutes: 32,
//       serviceType: 'Premium',
//       packageName: 'MacBook Pro M3 Max',
//       packageImageUrl:
//           'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=200&q=80',
//       packageTags: ['Electronics', 'High Value', 'Fragile'],
//       packageQty: 1,
//       otpVerified: true,
//       baseFare: 180.00,
//       peakHourIncentive: 0,
//       premiumHandling: 0,
//     ),
//     TripRecord(
//       orderId: '#RNT125601',
//       statusValue: TripStatus.delivered,
//       time: '09:15 AM',
//       sortKey: 555,
//       pickupName: 'City Rental Hub',
//       pickupAddress: '88, Mount Road, Guindy, Chennai - 600032',
//       pickupPhone: '+91 98765 11223',
//       dropName: 'Rahul Verma',
//       dropAddress: '23, 5th Cross Street, Velachery, Chennai - 600042',
//       dropPhone: '+91 90000 12345',
//       distanceKm: 7.5,
//       estimatedMinutes: 26,
//       serviceType: 'Standard',
//       packageName: 'Office Chair',
//       packageImageUrl:
//           'https://images.unsplash.com/photo-1580480055273-228ff5388ef8?w=200&q=80',
//       packageTags: ['Furniture'],
//       packageQty: 1,
//       otpVerified: true,
//       baseFare: 180.00,
//       peakHourIncentive: 0,
//       premiumHandling: 0,
//     ),
//     TripRecord(
//       orderId: '#RNT125690',
//       statusValue: TripStatus.ongoing,
//       time: '12:05 PM',
//       sortKey: 725,
//       pickupName: 'Camera World',
//       pickupAddress: 'Adyar, Chennai - 600020',
//       pickupPhone: '+91 98123 45678',
//       dropName: 'Rohit Verma',
//       dropAddress: 'Velachery, Chennai - 600042',
//       dropPhone: '+91 99887 76655',
//       distanceKm: 4.1,
//       estimatedMinutes: 25,
//       serviceType: 'Premium',
//       packageName: 'Sony A7 IV Camera',
//       packageImageUrl:
//           'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=200&q=80',
//       packageTags: ['Electronics', 'Fragile'],
//       packageQty: 1,
//       otpVerified: false,
//       baseFare: 195.00,
//       peakHourIncentive: 45.00,
//       premiumHandling: 0,
//     ),
//     TripRecord(
//       orderId: '#RNT125550',
//       statusValue: TripStatus.cancelled,
//       time: '08:40 AM',
//       sortKey: 520,
//       pickupName: 'Sound Hub',
//       pickupAddress: 'Porur, Chennai - 600116',
//       pickupPhone: '+91 97654 32109',
//       dropName: 'Arun Kumar',
//       dropAddress: 'Nungambakkam, Chennai - 600034',
//       dropPhone: '+91 96543 21098',
//       distanceKm: 3.2,
//       estimatedMinutes: 20,
//       serviceType: 'Standard',
//       packageName: 'Bluetooth Speaker',
//       packageImageUrl:
//           'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=200&q=80',
//       packageTags: ['Electronics'],
//       packageQty: 2,
//       otpVerified: false,
//       baseFare: 0.00,
//       peakHourIncentive: 0,
//       premiumHandling: 0,
//     ),
//   ];

//   List<TripRecord> get _filtered {
//     Iterable<TripRecord> list = _mockTrips;
//     switch (_filter) {
//       case TripFilter.ongoing:
//         list = list.where((t) => t.statusValue == TripStatus.ongoing);
//         break;
//       case TripFilter.completed:
//         list = list.where((t) => t.statusValue == TripStatus.delivered);
//         break;
//       case TripFilter.cancelled:
//         list = list.where((t) => t.statusValue == TripStatus.cancelled);
//         break;
//       case TripFilter.all:
//         break;
//     }
//     final result = list.toList();
//     result.sort(
//       (a, b) => _sort == SortOrder.latest
//           ? b.sortKey.compareTo(a.sortKey)
//           : a.sortKey.compareTo(b.sortKey),
//     );
//     return result;
//   }

//   double get _todayTotal => _mockTrips
//       .where((t) => t.statusValue == TripStatus.delivered)
//       .fold(0.0, (sum, t) => sum + t.earningsAmount);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.pureBlack,
//       body: Column(
//         children: [
//           SafeArea(bottom: false, child: _buildHeader()),
//           Expanded(
//             child: Container(
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 color: Color(0xFFF4F4F4),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(28),
//                   topRight: Radius.circular(28),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 16),
//                   _buildFilterRow(),
//                   const SizedBox(height: 16),
//                   _buildSectionHeader(),
//                   const SizedBox(height: 4),
//                   Expanded(
//                     child: AnimatedSwitcher(
//                       duration: const Duration(milliseconds: 250),
//                       child: _filtered.isEmpty
//                           ? _buildEmptyState(key: ValueKey(_filter))
//                           : ListView.builder(
//                               key: ValueKey('${_filter}_$_sort'),
//                               padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
//                               itemCount: _filtered.length + 1,
//                               itemBuilder: (context, index) {
//                                 if (index == _filtered.length) {
//                                   return Padding(
//                                     padding: const EdgeInsets.only(top: 4),
//                                     child: _AnimatedEntry(
//                                       index: index,
//                                       child: GestureDetector(
//                                         onTap: () => Navigator.of(context).push(
//                                           MaterialPageRoute(
//                                             builder: (_) =>
//                                                 const EarningsScreen(),
//                                           ),
//                                         ),
//                                         child: _buildDailyEarningsCard(),
//                                       ),
//                                     ),
//                                   );
//                                 }
//                                 final trip = _filtered[index];
//                                 return Padding(
//                                   padding: const EdgeInsets.only(bottom: 14),
//                                   child: _AnimatedEntry(
//                                     index: index,
//                                     child: _TripCard(trip: trip),
//                                   ),
//                                 );
//                               },
//                             ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(8, 4, 16, 20),
//       child: Row(
//         children: [
//           IconButton(
//             icon: const Icon(Icons.arrow_back, color: AppColors.pureWhite),
//             onPressed: () {
//               if (widget.onBack != null) {
//                 widget.onBack!();
//               } else {
//                 Navigator.of(context).maybePop();
//               }
//             },
//           ),
//           const SizedBox(width: 4),
//           const Text(
//             'Trips',
//             style: TextStyle(
//               color: AppColors.pureWhite,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const Spacer(),
//           Stack(
//             clipBehavior: Clip.none,
//             children: [
//               IconButton(
//                 icon: const Icon(
//                   Icons.notifications_none,
//                   color: AppColors.pureWhite,
//                 ),
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (_) => const NotificationsScreen(),
//                     ),
//                   );
//                 },
//               ),
//               Positioned(
//                 right: 8,
//                 top: 8,
//                 child: Container(
//                   padding: const EdgeInsets.all(3),
//                   decoration: const BoxDecoration(
//                     color: Colors.red,
//                     shape: BoxShape.circle,
//                   ),
//                   constraints: const BoxConstraints(
//                     minWidth: 15,
//                     minHeight: 15,
//                   ),
//                   child: const Text(
//                     '3',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.white, fontSize: 9),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFilterRow() {
//     final items = <(TripFilter, String, IconData)>[
//       (TripFilter.all, 'All Trips', Icons.list_alt),
//       (TripFilter.ongoing, 'Ongoing', Icons.timer_outlined),
//       (TripFilter.completed, 'Completed', Icons.check_circle_outline),
//       (TripFilter.cancelled, 'Cancelled', Icons.cancel_outlined),
//     ];
//     return SizedBox(
//       height: 42,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         itemCount: items.length,
//         separatorBuilder: (_, __) => const SizedBox(width: 8),
//         itemBuilder: (context, i) {
//           final (filter, label, icon) = items[i];
//           final selected = _filter == filter;
//           return GestureDetector(
//             onTap: () => setState(() => _filter = filter),
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 220),
//               curve: Curves.easeOut,
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//               decoration: BoxDecoration(
//                 color: selected ? AppColors.pureBlack : AppColors.pureWhite,
//                 borderRadius: BorderRadius.circular(24),
//                 border: Border.all(
//                   color: selected ? AppColors.pureBlack : AppColors.divider,
//                 ),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     icon,
//                     size: 16,
//                     color: selected
//                         ? AppColors.pureWhite
//                         : AppColors.textSecondary,
//                   ),
//                   const SizedBox(width: 6),
//                   Text(
//                     label,
//                     style: TextStyle(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w600,
//                       color: selected
//                           ? AppColors.pureWhite
//                           : AppColors.textSecondary,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildSectionHeader() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text(
//             'Today',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: AppColors.textPrimary,
//             ),
//           ),
//           PopupMenuButton<SortOrder>(
//             initialValue: _sort,
//             onSelected: (v) => setState(() => _sort = v),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             itemBuilder: (context) => const [
//               PopupMenuItem(value: SortOrder.latest, child: Text('Latest')),
//               PopupMenuItem(value: SortOrder.oldest, child: Text('Oldest')),
//             ],
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//               decoration: BoxDecoration(
//                 color: AppColors.pureWhite,
//                 border: Border.all(color: AppColors.divider),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     _sort == SortOrder.latest ? 'Latest' : 'Oldest',
//                     style: const TextStyle(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textPrimary,
//                     ),
//                   ),
//                   const Icon(
//                     Icons.keyboard_arrow_down,
//                     size: 18,
//                     color: AppColors.textPrimary,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmptyState({Key? key}) {
//     return Center(
//       key: key,
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: const [
//             Icon(
//               Icons.receipt_long_outlined,
//               size: 48,
//               color: AppColors.textHint,
//             ),
//             SizedBox(height: 16),
//             Text(
//               'No trips here yet',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textPrimary,
//               ),
//             ),
//             SizedBox(height: 6),
//             Text(
//               'Trips in this category will show up here.',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDailyEarningsCard() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.success.withValues(alpha: 0.12),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 40,
//             height: 40,
//             decoration: const BoxDecoration(
//               color: AppColors.pureWhite,
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(
//               Icons.account_balance_wallet_outlined,
//               color: AppColors.success,
//               size: 18,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Daily Earnings',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 14,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text.rich(
//                   TextSpan(
//                     text: "You've earned ",
//                     style: const TextStyle(
//                       fontSize: 12,
//                       color: AppColors.textSecondary,
//                     ),
//                     children: [
//                       TextSpan(
//                         text: '₹${_todayTotal.toStringAsFixed(0)}',
//                         style: const TextStyle(
//                           color: AppColors.success,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const TextSpan(text: ' today'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const Icon(Icons.chevron_right, color: AppColors.textSecondary),
//         ],
//       ),
//     );
//   }
// }

// class _TripCard extends StatelessWidget {
//   final TripRecord trip;
//   const _TripCard({required this.trip});

//   (String, Color, Color) get _statusStyle {
//     switch (trip.statusValue) {
//       case TripStatus.delivered:
//         return (
//           'Delivered',
//           AppColors.success,
//           AppColors.success.withValues(alpha: 0.12),
//         );
//       case TripStatus.ongoing:
//         return ('Ongoing', const Color(0xFFB8860B), const Color(0xFFFFF3D6));
//       case TripStatus.cancelled:
//         return ('Cancelled', const Color(0xFFD32F2F), const Color(0xFFFBE1E1));
//     }
//   }

//   Future<void> _launchCall(BuildContext context, String phone) async {
//     final uri = Uri(scheme: 'tel', path: phone.replaceAll(' ', ''));
//     final ok = await launchUrl(uri);
//     if (!ok && context.mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Could not open the dialer')),
//       );
//     }
//   }

//   Future<void> _launchSms(BuildContext context, String phone) async {
//     final uri = Uri(scheme: 'sms', path: phone.replaceAll(' ', ''));
//     final ok = await launchUrl(uri);
//     if (!ok && context.mounted) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Could not open messages')));
//     }
//   }

//   void _showContactChooser(BuildContext context, {required bool isCall}) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (sheetContext) => SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   isCall ? 'Call' : 'Message',
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: const CircleAvatar(
//                 backgroundColor: Color(0xFFF4F4F4),
//                 child: Icon(
//                   Icons.storefront_outlined,
//                   color: AppColors.textPrimary,
//                 ),
//               ),
//               title: Text(trip.pickupName),
//               subtitle: const Text('Vendor (Pickup)'),
//               trailing: Icon(isCall ? Icons.call : Icons.chat_bubble_outline),
//               onTap: () {
//                 Navigator.pop(sheetContext);
//                 isCall
//                     ? _launchCall(context, trip.pickupPhone)
//                     : _launchSms(context, trip.pickupPhone);
//               },
//             ),
//             ListTile(
//               leading: const CircleAvatar(
//                 backgroundColor: Color(0xFFF4F4F4),
//                 child: Icon(Icons.person_outline, color: AppColors.textPrimary),
//               ),
//               title: Text(trip.dropName),
//               subtitle: const Text('Customer (Drop-off)'),
//               trailing: Icon(isCall ? Icons.call : Icons.chat_bubble_outline),
//               onTap: () {
//                 Navigator.pop(sheetContext);
//                 isCall
//                     ? _launchCall(context, trip.dropPhone)
//                     : _launchSms(context, trip.dropPhone);
//               },
//             ),
//             const SizedBox(height: 12),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final (label, fg, bg) = _statusStyle;
//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: AppColors.pureWhite,
//         border: Border.all(color: AppColors.divider),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 10,
//                   vertical: 4,
//                 ),
//                 decoration: BoxDecoration(
//                   color: bg,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Container(
//                       width: 6,
//                       height: 6,
//                       decoration: BoxDecoration(
//                         color: fg,
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                     const SizedBox(width: 6),
//                     Text(
//                       label,
//                       style: TextStyle(
//                         fontSize: 11,
//                         fontWeight: FontWeight.w600,
//                         color: fg,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: Text(
//                   'Order ID: ${trip.orderId}',
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: AppColors.textSecondary,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               Text(
//                 trip.time,
//                 style: const TextStyle(
//                   fontSize: 12,
//                   color: AppColors.textSecondary,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 14),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Column(
//                 children: [
//                   Container(
//                     width: 10,
//                     height: 10,
//                     decoration: const BoxDecoration(
//                       color: AppColors.success,
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                   Container(width: 1.4, height: 46, color: AppColors.divider),
//                   const Icon(
//                     Icons.location_on,
//                     size: 16,
//                     color: Colors.redAccent,
//                   ),
//                 ],
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       trip.pickupName,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 13,
//                         color: AppColors.textPrimary,
//                       ),
//                     ),
//                     Text(
//                       trip.pickupAddress,
//                       style: const TextStyle(
//                         fontSize: 11.5,
//                         color: AppColors.textSecondary,
//                       ),
//                     ),
//                     const SizedBox(height: 14),
//                     Text(
//                       trip.dropName,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 13,
//                         color: AppColors.textPrimary,
//                       ),
//                     ),
//                     Text(
//                       trip.dropAddress,
//                       style: const TextStyle(
//                         fontSize: 11.5,
//                         color: AppColors.textSecondary,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.location_on_outlined,
//                         size: 13,
//                         color: AppColors.textSecondary,
//                       ),
//                       const SizedBox(width: 3),
//                       Text(
//                         trip.distance,
//                         style: const TextStyle(
//                           fontSize: 11.5,
//                           color: AppColors.textSecondary,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 28),
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.access_time,
//                         size: 13,
//                         color: AppColors.textSecondary,
//                       ),
//                       const SizedBox(width: 3),
//                       Text(
//                         trip.duration,
//                         style: const TextStyle(
//                           fontSize: 11.5,
//                           color: AppColors.textSecondary,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     trip.earnings,
//                     style: const TextStyle(
//                       fontSize: 13,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.success,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 14),
//           Row(
//             children: [
//               Expanded(
//                 child: OutlinedButton(
//                   onPressed: () => Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (_) => TripDetailsScreen(trip: trip),
//                     ),
//                   ),
//                   style: OutlinedButton.styleFrom(
//                     minimumSize: const Size(0, 0),
//                     foregroundColor: AppColors.textPrimary,
//                     side: const BorderSide(color: AppColors.divider),
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: const Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         'View Details',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 13,
//                         ),
//                       ),
//                       SizedBox(width: 4),
//                       Icon(Icons.chevron_right, size: 16),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               _iconCircleButton(
//                 context,
//                 icon: Icons.call_outlined,
//                 onTap: () => _showContactChooser(context, isCall: true),
//               ),
//               const SizedBox(width: 8),
//               _iconCircleButton(
//                 context,
//                 icon: Icons.chat_bubble_outline,
//                 onTap: () => _showContactChooser(context, isCall: false),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _iconCircleButton(
//     BuildContext context, {
//     required IconData icon,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         width: 44,
//         height: 44,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           border: Border.all(color: AppColors.divider),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Icon(icon, size: 18, color: AppColors.textPrimary),
//       ),
//     );
//   }
// }

// /// Simple staggered fade + slide-up entrance animation for list items.
// class _AnimatedEntry extends StatefulWidget {
//   final int index;
//   final Widget child;
//   const _AnimatedEntry({required this.index, required this.child});

//   @override
//   State<_AnimatedEntry> createState() => _AnimatedEntryState();
// }

// class _AnimatedEntryState extends State<_AnimatedEntry>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _controller;
//   late final Animation<double> _fade;
//   late final Animation<Offset> _slide;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 380),
//     );
//     _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
//     _slide = Tween<Offset>(
//       begin: const Offset(0, 0.08),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

//     final delay = Duration(milliseconds: 60 * widget.index.clamp(0, 8));
//     Future.delayed(delay, () {
//       if (mounted) _controller.forward();
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FadeTransition(
//       opacity: _fade,
//       child: SlideTransition(position: _slide, child: widget.child),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rento_india/delivery/core/constants/app_colors.dart';
//import '../../../../../core/constants/app_colors.dart';
import '../../../data/models/trip_record_model.dart';
import 'trip_details_screen.dart';
import '../earnings/earnings_screen.dart';
import '../notifications/notifications_screen.dart';

/// Trips history screen — All / Ongoing / Completed / Cancelled tabs,
/// with a dark header (matches the rest of the rider app's black
/// accent cards) and a white sheet underneath holding the list.
///
/// TODO: replace _mockTrips with TripRepository.getTripHistory() once
/// backend is wired, and wire the "Latest/Oldest" sort + filter tabs
/// to real query params instead of client-side filtering.
class TripsListScreen extends StatefulWidget {
  final VoidCallback? onBack; // ⭐ NEW — lets the shell switch tabs on back
  final VoidCallback?
  onNotifications; // ⭐ NEW — lets the shell switch to the Notifications tab

  const TripsListScreen({super.key, this.onBack, this.onNotifications});

  @override
  State<TripsListScreen> createState() => _TripsListScreenState();
}

enum TripFilter { all, ongoing, completed, cancelled }

enum SortOrder { latest, oldest }

class _TripsListScreenState extends State<TripsListScreen> {
  TripFilter _filter = TripFilter.all;
  SortOrder _sort = SortOrder.latest;

  static const _mockTrips = [
    TripRecord(
      orderId: '#RNT125678',
      statusValue: TripStatus.delivered,
      time: '11:30 AM',
      sortKey: 690,
      pickupName: 'ABC Electronics',
      pickupAddress: '12, 3rd Main Rd, Anna Nagar, Chennai - 600040',
      pickupPhone: '+91 98765 43210',
      dropName: 'Priya Sharma',
      dropAddress: '45, North Usman Road, T. Nagar, Chennai - 600017',
      dropPhone: '+91 91234 56780',
      distanceKm: 10.2,
      estimatedMinutes: 32,
      serviceType: 'Premium',
      packageName: 'MacBook Pro M3 Max',
      packageImageUrl:
          'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=200&q=80',
      packageTags: ['Electronics', 'High Value', 'Fragile'],
      packageQty: 1,
      otpVerified: true,
      baseFare: 180.00,
      peakHourIncentive: 0,
      premiumHandling: 0,
    ),
    TripRecord(
      orderId: '#RNT125601',
      statusValue: TripStatus.delivered,
      time: '09:15 AM',
      sortKey: 555,
      pickupName: 'City Rental Hub',
      pickupAddress: '88, Mount Road, Guindy, Chennai - 600032',
      pickupPhone: '+91 98765 11223',
      dropName: 'Rahul Verma',
      dropAddress: '23, 5th Cross Street, Velachery, Chennai - 600042',
      dropPhone: '+91 90000 12345',
      distanceKm: 7.5,
      estimatedMinutes: 26,
      serviceType: 'Standard',
      packageName: 'Office Chair',
      packageImageUrl:
          'https://images.unsplash.com/photo-1580480055273-228ff5388ef8?w=200&q=80',
      packageTags: ['Furniture'],
      packageQty: 1,
      otpVerified: true,
      baseFare: 180.00,
      peakHourIncentive: 0,
      premiumHandling: 0,
    ),
    TripRecord(
      orderId: '#RNT125690',
      statusValue: TripStatus.ongoing,
      time: '12:05 PM',
      sortKey: 725,
      pickupName: 'Camera World',
      pickupAddress: 'Adyar, Chennai - 600020',
      pickupPhone: '+91 98123 45678',
      dropName: 'Rohit Verma',
      dropAddress: 'Velachery, Chennai - 600042',
      dropPhone: '+91 99887 76655',
      distanceKm: 4.1,
      estimatedMinutes: 25,
      serviceType: 'Premium',
      packageName: 'Sony A7 IV Camera',
      packageImageUrl:
          'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=200&q=80',
      packageTags: ['Electronics', 'Fragile'],
      packageQty: 1,
      otpVerified: false,
      baseFare: 195.00,
      peakHourIncentive: 45.00,
      premiumHandling: 0,
    ),
    TripRecord(
      orderId: '#RNT125550',
      statusValue: TripStatus.cancelled,
      time: '08:40 AM',
      sortKey: 520,
      pickupName: 'Sound Hub',
      pickupAddress: 'Porur, Chennai - 600116',
      pickupPhone: '+91 97654 32109',
      dropName: 'Arun Kumar',
      dropAddress: 'Nungambakkam, Chennai - 600034',
      dropPhone: '+91 96543 21098',
      distanceKm: 3.2,
      estimatedMinutes: 20,
      serviceType: 'Standard',
      packageName: 'Bluetooth Speaker',
      packageImageUrl:
          'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=200&q=80',
      packageTags: ['Electronics'],
      packageQty: 2,
      otpVerified: false,
      baseFare: 0.00,
      peakHourIncentive: 0,
      premiumHandling: 0,
    ),
  ];

  List<TripRecord> get _filtered {
    Iterable<TripRecord> list = _mockTrips;
    switch (_filter) {
      case TripFilter.ongoing:
        list = list.where((t) => t.statusValue == TripStatus.ongoing);
        break;
      case TripFilter.completed:
        list = list.where((t) => t.statusValue == TripStatus.delivered);
        break;
      case TripFilter.cancelled:
        list = list.where((t) => t.statusValue == TripStatus.cancelled);
        break;
      case TripFilter.all:
        break;
    }
    final result = list.toList();
    result.sort(
      (a, b) => _sort == SortOrder.latest
          ? b.sortKey.compareTo(a.sortKey)
          : a.sortKey.compareTo(b.sortKey),
    );
    return result;
  }

  double get _todayTotal => _mockTrips
      .where((t) => t.statusValue == TripStatus.delivered)
      .fold(0.0, (sum, t) => sum + t.earningsAmount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureBlack,
      body: Column(
        children: [
          SafeArea(bottom: false, child: _buildHeader()),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF4F4F4),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  _buildFilterRow(),
                  const SizedBox(height: 16),
                  _buildSectionHeader(),
                  const SizedBox(height: 4),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: _filtered.isEmpty
                          ? _buildEmptyState(key: ValueKey(_filter))
                          : ListView.builder(
                              key: ValueKey('${_filter}_$_sort'),
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                              itemCount: _filtered.length + 1,
                              itemBuilder: (context, index) {
                                if (index == _filtered.length) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: _AnimatedEntry(
                                      index: index,
                                      child: GestureDetector(
                                        onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                const EarningsScreen(),
                                          ),
                                        ),
                                        child: _buildDailyEarningsCard(),
                                      ),
                                    ),
                                  );
                                }
                                final trip = _filtered[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 14),
                                  child: _AnimatedEntry(
                                    index: index,
                                    child: _TripCard(trip: trip),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 16, 20),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.pureWhite),
            onPressed: () {
              if (widget.onBack != null) {
                widget.onBack!();
              } else {
                Navigator.of(context).maybePop();
              }
            },
          ),
          const SizedBox(width: 4),
          const Text(
            'Trips',
            style: TextStyle(
              color: AppColors.pureWhite,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_none,
                  color: AppColors.pureWhite,
                ),
                onPressed: () {
                  if (widget.onNotifications != null) {
                    widget.onNotifications!();
                    return;
                  }
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const NotificationsScreen(),
                    ),
                  );
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 15,
                    minHeight: 15,
                  ),
                  child: const Text(
                    '3',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 9),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterRow() {
    final items = <(TripFilter, String, IconData)>[
      (TripFilter.all, 'All Trips', Icons.list_alt),
      (TripFilter.ongoing, 'Ongoing', Icons.timer_outlined),
      (TripFilter.completed, 'Completed', Icons.check_circle_outline),
      (TripFilter.cancelled, 'Cancelled', Icons.cancel_outlined),
    ];
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final (filter, label, icon) = items[i];
          final selected = _filter == filter;
          return GestureDetector(
            onTap: () => setState(() => _filter = filter),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: selected ? AppColors.pureBlack : AppColors.pureWhite,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: selected ? AppColors.pureBlack : AppColors.divider,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: 16,
                    color: selected
                        ? AppColors.pureWhite
                        : AppColors.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: selected
                          ? AppColors.pureWhite
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Today',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          PopupMenuButton<SortOrder>(
            initialValue: _sort,
            onSelected: (v) => setState(() => _sort = v),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            itemBuilder: (context) => const [
              PopupMenuItem(value: SortOrder.latest, child: Text('Latest')),
              PopupMenuItem(value: SortOrder.oldest, child: Text('Oldest')),
            ],
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                border: Border.all(color: AppColors.divider),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _sort == SortOrder.latest ? 'Latest' : 'Oldest',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 18,
                    color: AppColors.textPrimary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState({Key? key}) {
    return Center(
      key: key,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.receipt_long_outlined,
              size: 48,
              color: AppColors.textHint,
            ),
            SizedBox(height: 16),
            Text(
              'No trips here yet',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Trips in this category will show up here.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyEarningsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.pureWhite,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.account_balance_wallet_outlined,
              color: AppColors.success,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Daily Earnings',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text.rich(
                  TextSpan(
                    text: "You've earned ",
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                    children: [
                      TextSpan(
                        text: '₹${_todayTotal.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: AppColors.success,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(text: ' today'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}

class _TripCard extends StatelessWidget {
  final TripRecord trip;
  const _TripCard({required this.trip});

  (String, Color, Color) get _statusStyle {
    switch (trip.statusValue) {
      case TripStatus.delivered:
        return (
          'Delivered',
          AppColors.success,
          AppColors.success.withValues(alpha: 0.12),
        );
      case TripStatus.ongoing:
        return ('Ongoing', const Color(0xFFB8860B), const Color(0xFFFFF3D6));
      case TripStatus.cancelled:
        return ('Cancelled', const Color(0xFFD32F2F), const Color(0xFFFBE1E1));
    }
  }

  Future<void> _launchCall(BuildContext context, String phone) async {
    final uri = Uri(scheme: 'tel', path: phone.replaceAll(' ', ''));
    final ok = await launchUrl(uri);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the dialer')),
      );
    }
  }

  Future<void> _launchSms(BuildContext context, String phone) async {
    final uri = Uri(scheme: 'sms', path: phone.replaceAll(' ', ''));
    final ok = await launchUrl(uri);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Could not open messages')));
    }
  }

  void _showContactChooser(BuildContext context, {required bool isCall}) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  isCall ? 'Call' : 'Message',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFF4F4F4),
                child: Icon(
                  Icons.storefront_outlined,
                  color: AppColors.textPrimary,
                ),
              ),
              title: Text(trip.pickupName),
              subtitle: const Text('Vendor (Pickup)'),
              trailing: Icon(isCall ? Icons.call : Icons.chat_bubble_outline),
              onTap: () {
                Navigator.pop(sheetContext);
                isCall
                    ? _launchCall(context, trip.pickupPhone)
                    : _launchSms(context, trip.pickupPhone);
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFF4F4F4),
                child: Icon(Icons.person_outline, color: AppColors.textPrimary),
              ),
              title: Text(trip.dropName),
              subtitle: const Text('Customer (Drop-off)'),
              trailing: Icon(isCall ? Icons.call : Icons.chat_bubble_outline),
              onTap: () {
                Navigator.pop(sheetContext);
                isCall
                    ? _launchCall(context, trip.dropPhone)
                    : _launchSms(context, trip.dropPhone);
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final (label, fg, bg) = _statusStyle;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        border: Border.all(color: AppColors.divider),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: fg,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: fg,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Order ID: ${trip.orderId}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                trip.time,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(width: 1.4, height: 46, color: AppColors.divider),
                  const Icon(
                    Icons.location_on,
                    size: 16,
                    color: Colors.redAccent,
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.pickupName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      trip.pickupAddress,
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      trip.dropName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      trip.dropAddress,
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 13,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        trip.distance,
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 13,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        trip.duration,
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    trip.earnings,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => TripDetailsScreen(trip: trip),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 0),
                    foregroundColor: AppColors.textPrimary,
                    side: const BorderSide(color: AppColors.divider),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View Details',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.chevron_right, size: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _iconCircleButton(
                context,
                icon: Icons.call_outlined,
                onTap: () => _showContactChooser(context, isCall: true),
              ),
              const SizedBox(width: 8),
              _iconCircleButton(
                context,
                icon: Icons.chat_bubble_outline,
                onTap: () => _showContactChooser(context, isCall: false),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconCircleButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.divider),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 18, color: AppColors.textPrimary),
      ),
    );
  }
}

/// Simple staggered fade + slide-up entrance animation for list items.
class _AnimatedEntry extends StatefulWidget {
  final int index;
  final Widget child;
  const _AnimatedEntry({required this.index, required this.child});

  @override
  State<_AnimatedEntry> createState() => _AnimatedEntryState();
}

class _AnimatedEntryState extends State<_AnimatedEntry>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    final delay = Duration(milliseconds: 60 * widget.index.clamp(0, 8));
    Future.delayed(delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}
