// import 'package:flutter/material.dart';
// import '../../../../../core/constants/app_colors.dart';
// import '../../../data/models/trip_record_model.dart';

// /// Full detail view for a single trip.
// /// Layout mirrors the Trips list screen: black header → white rounded sheet.
// class TripDetailsScreen extends StatelessWidget {
//   final TripRecord trip;

//   const TripDetailsScreen({super.key, required this.trip});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.pureBlack,
//       body: Column(
//         children: [
//           // ── Black header (mirrors TripsListScreen) ────────────────────────
//           SafeArea(bottom: false, child: _buildHeader(context)),
//           // ── White rounded sheet ───────────────────────────────────────────
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
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(28),
//                   topRight: Radius.circular(28),
//                 ),
//                 child: ListView(
//                   padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
//                   children: [
//                     _buildStatusHeader(),
//                     const SizedBox(height: 14),
//                     _buildRouteCard(),
//                     const SizedBox(height: 14),
//                     _buildStatsRow(),
//                     const SizedBox(height: 14),
//                     _buildPackageCard(),
//                     const SizedBox(height: 14),
//                     _buildEarningsCard(),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Black top header ──────────────────────────────────────────────────────

//   Widget _buildHeader(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(8, 4, 16, 20),
//       child: Row(
//         children: [
//           IconButton(
//             icon: const Icon(Icons.arrow_back, color: AppColors.pureWhite),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//           const SizedBox(width: 4),
//           const Text(
//             'Trip Details',
//             style: TextStyle(
//               color: AppColors.pureWhite,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const Spacer(),
//           IconButton(
//             icon: const Icon(
//               Icons.help_outline_rounded,
//               color: AppColors.pureWhite,
//             ),
//             onPressed: () {
//               // TODO: open help / support
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Status header card ────────────────────────────────────────────────────

//   Widget _buildStatusHeader() {
//     final isDelivered = trip.statusValue == TripStatus.delivered;
//     final isOngoing = trip.statusValue == TripStatus.ongoing;

//     final Color statusFg = isDelivered
//         ? AppColors.success
//         : isOngoing
//         ? const Color(0xFFB8860B)
//         : const Color(0xFFD32F2F);

//     final Color statusBg = isDelivered
//         ? const Color(0xFFE8F8EF)
//         : isOngoing
//         ? const Color(0xFFFFF3D6)
//         : const Color(0xFFFBE1E1);

//     final IconData badgeIcon = isDelivered
//         ? Icons.check_circle_outline_rounded
//         : isOngoing
//         ? Icons.timer_outlined
//         : Icons.cancel_outlined;

//     return _Card(
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Status pill
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 4,
//                   ),
//                   decoration: BoxDecoration(
//                     color: statusBg,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         width: 7,
//                         height: 7,
//                         decoration: BoxDecoration(
//                           color: statusFg,
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       const SizedBox(width: 5),
//                       Text(
//                         trip.status.toUpperCase(),
//                         style: TextStyle(
//                           color: statusFg,
//                           fontSize: 11,
//                           fontWeight: FontWeight.w700,
//                           letterSpacing: 0.3,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   'Order ID: ${trip.orderId}',
//                   style: const TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//                 const SizedBox(height: 3),
//                 Text(
//                   trip.time,
//                   style: const TextStyle(
//                     fontSize: 13,
//                     color: AppColors.textSecondary,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Badge icon
//           Container(
//             width: 44,
//             height: 44,
//             decoration: BoxDecoration(
//               color: const Color(0xFFF0F0F0),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(badgeIcon, color: statusFg, size: 22),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Route card ────────────────────────────────────────────────────────────

//   Widget _buildRouteCard() {
//     return _Card(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'ROUTE DETAILS',
//             style: TextStyle(
//               fontSize: 11,
//               fontWeight: FontWeight.w700,
//               letterSpacing: 0.8,
//               color: AppColors.textSecondary,
//             ),
//           ),
//           const SizedBox(height: 16),
//           _RouteStop(
//             dotColor: AppColors.textPrimary,
//             label: 'PICKUP',
//             name: trip.pickupName,
//             address: trip.pickupAddress,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 3.5),
//             child: _DashedLine(height: 30),
//           ),
//           _RouteStop(
//             dotColor: const Color(0xFFD32F2F),
//             label: 'DELIVERY',
//             name: trip.dropName,
//             address: trip.dropAddress,
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Stats row ─────────────────────────────────────────────────────────────

//   Widget _buildStatsRow() {
//     return _Card(
//       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//       child: Row(
//         children: [
//           Expanded(
//             child: _StatCell(label: 'DISTANCE', value: trip.distance),
//           ),
//           _VDivider(),
//           Expanded(
//             child: _StatCell(label: 'TIME TAKEN', value: trip.duration),
//           ),
//           _VDivider(),
//           Expanded(
//             child: _StatCell(label: 'SERVICE', value: trip.serviceType),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Package contents card ─────────────────────────────────────────────────

//   Widget _buildPackageCard() {
//     return _Card(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'PACKAGE CONTENTS',
//             style: TextStyle(
//               fontSize: 11,
//               fontWeight: FontWeight.w700,
//               letterSpacing: 0.8,
//               color: AppColors.textSecondary,
//             ),
//           ),
//           const SizedBox(height: 14),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // ── Product image ─────────────────────────────────────────────
//               _PackageImage(imageUrl: trip.packageImageUrl),
//               const SizedBox(width: 14),
//               // ── Name + tags ───────────────────────────────────────────────
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       trip.packageName,
//                       style: const TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.textPrimary,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Wrap(
//                       spacing: 6,
//                       runSpacing: 6,
//                       children: trip.packageTags
//                           .map((t) => _TagChip(tag: t))
//                           .toList(),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 8),
//               // ── Qty ───────────────────────────────────────────────────────
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   const Text(
//                     'QTY',
//                     style: TextStyle(
//                       fontSize: 10,
//                       fontWeight: FontWeight.w700,
//                       letterSpacing: 0.5,
//                       color: AppColors.textSecondary,
//                     ),
//                   ),
//                   Text(
//                     '${trip.packageQty}',
//                     style: const TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.textPrimary,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           if (trip.otpVerified) ...[
//             const SizedBox(height: 14),
//             const Divider(height: 1, color: Color(0xFFEEEEEE)),
//             const SizedBox(height: 12),
//             Row(
//               children: const [
//                 Icon(
//                   Icons.security_rounded,
//                   size: 16,
//                   color: AppColors.textSecondary,
//                 ),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: Text(
//                     'Verified with OTP at Dropoff',
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: AppColors.textSecondary,
//                     ),
//                   ),
//                 ),
//                 Icon(
//                   Icons.check_circle_rounded,
//                   size: 20,
//                   color: AppColors.success,
//                 ),
//               ],
//             ),
//           ],
//         ],
//       ),
//     );
//   }

//   // ── Earnings card ─────────────────────────────────────────────────────────

//   Widget _buildEarningsCard() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: const Color(0xFF1A1A1A),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'EARNINGS SUMMARY',
//             style: TextStyle(
//               fontSize: 11,
//               fontWeight: FontWeight.w700,
//               letterSpacing: 0.8,
//               color: Color(0xFF999999),
//             ),
//           ),
//           const SizedBox(height: 16),
//           _EarningsRow(label: 'Base Fare', amount: trip.baseFare),
//           if (trip.peakHourIncentive > 0) ...[
//             const SizedBox(height: 10),
//             _EarningsRow(
//               label: 'Peak Hour Incentive',
//               amount: trip.peakHourIncentive,
//               icon: Icons.bolt,
//               iconColor: const Color(0xFFFFCC00),
//             ),
//           ],
//           if (trip.premiumHandling > 0) ...[
//             const SizedBox(height: 10),
//             _EarningsRow(
//               label: 'Premium Handling',
//               amount: trip.premiumHandling,
//             ),
//           ],
//           const SizedBox(height: 16),
//           const Divider(color: Color(0xFF333333), height: 1),
//           const SizedBox(height: 16),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'TOTAL EARNED',
//                     style: TextStyle(
//                       fontSize: 10,
//                       fontWeight: FontWeight.w700,
//                       letterSpacing: 0.6,
//                       color: Color(0xFF999999),
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     '₹${trip.earningsAmount.toStringAsFixed(2)}',
//                     style: const TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//               const Spacer(),
//               _WithdrawButton(
//                 onTap: () {
//                   // TODO: trigger withdrawal flow
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ── Shared white card ─────────────────────────────────────────────────────────

// class _Card extends StatelessWidget {
//   final Widget child;
//   final EdgeInsetsGeometry padding;

//   const _Card({required this.child, this.padding = const EdgeInsets.all(16)});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: padding,
//       decoration: BoxDecoration(
//         color: AppColors.pureWhite,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             blurRadius: 6,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: child,
//     );
//   }
// }

// // ── Dashed vertical connector ─────────────────────────────────────────────────

// class _DashedLine extends StatelessWidget {
//   final double height;
//   const _DashedLine({required this.height});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: height,
//       child: LayoutBuilder(
//         builder: (_, constraints) {
//           const dashH = 4.0;
//           const gap = 3.0;
//           final count = (constraints.maxHeight / (dashH + gap)).floor();
//           return Column(
//             children: List.generate(count, (_) {
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: gap),
//                 child: Container(
//                   width: 1.5,
//                   height: dashH,
//                   color: const Color(0xFFCCCCCC),
//                 ),
//               );
//             }),
//           );
//         },
//       ),
//     );
//   }
// }

// // ── Route stop row ────────────────────────────────────────────────────────────

// class _RouteStop extends StatelessWidget {
//   final Color dotColor;
//   final String label;
//   final String name;
//   final String address;

//   const _RouteStop({
//     required this.dotColor,
//     required this.label,
//     required this.name,
//     required this.address,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 4),
//           child: Container(
//             width: 9,
//             height: 9,
//             decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
//           ),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 name,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimary,
//                 ),
//               ),
//               const SizedBox(height: 2),
//               Text(
//                 address,
//                 style: const TextStyle(
//                   fontSize: 12,
//                   color: AppColors.textSecondary,
//                   height: 1.4,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(width: 8),
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 10,
//             fontWeight: FontWeight.w700,
//             letterSpacing: 0.5,
//             color: AppColors.textSecondary,
//           ),
//         ),
//       ],
//     );
//   }
// }

// // ── Stats cell ────────────────────────────────────────────────────────────────

// class _StatCell extends StatelessWidget {
//   final String label;
//   final String value;
//   const _StatCell({required this.label, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 10,
//             fontWeight: FontWeight.w700,
//             letterSpacing: 0.5,
//             color: AppColors.textSecondary,
//           ),
//         ),
//         const SizedBox(height: 6),
//         Text(
//           value,
//           style: const TextStyle(
//             fontSize: 15,
//             fontWeight: FontWeight.bold,
//             color: AppColors.textPrimary,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _VDivider extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) =>
//       Container(width: 1, height: 36, color: const Color(0xFFEEEEEE));
// }

// // ── Package image ─────────────────────────────────────────────────────────────

// class _PackageImage extends StatelessWidget {
//   final String? imageUrl;
//   const _PackageImage({this.imageUrl});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 84,
//       height: 84,
//       decoration: BoxDecoration(
//         color: const Color(0xFFF0F0F0),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: const Color(0xFFE0E0E0)),
//       ),
//       clipBehavior: Clip.antiAlias,
//       child: imageUrl != null && imageUrl!.isNotEmpty
//           ? Image.network(
//               imageUrl!,
//               fit: BoxFit.cover,
//               loadingBuilder: (_, child, progress) => progress == null
//                   ? child
//                   : const Center(
//                       child: CircularProgressIndicator(
//                         strokeWidth: 2,
//                         color: AppColors.textSecondary,
//                       ),
//                     ),
//               errorBuilder: (_, e, __) => _placeholder(),
//             )
//           : _placeholder(),
//     );
//   }

//   Widget _placeholder() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: const [
//         Icon(Icons.inventory_2_outlined, size: 28, color: Color(0xFFBBBBBB)),
//         SizedBox(height: 4),
//         Text(
//           'No Image',
//           style: TextStyle(fontSize: 9, color: Color(0xFFBBBBBB)),
//         ),
//       ],
//     );
//   }
// }

// // ── Tag chip ──────────────────────────────────────────────────────────────────

// class _TagChip extends StatelessWidget {
//   final String tag;
//   const _TagChip({required this.tag});

//   static const _fragileColor = Color(0xFFD32F2F);
//   static const _fragileBg = Color(0xFFFDECEC);
//   static const _defaultBg = Color(0xFFF0F0F0);
//   static const _defaultColor = Color(0xFF555555);

//   @override
//   Widget build(BuildContext context) {
//     final isFragile = tag.toLowerCase() == 'fragile';
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         color: isFragile ? _fragileBg : _defaultBg,
//         borderRadius: BorderRadius.circular(20),
//         border: isFragile
//             ? Border.all(color: _fragileColor.withValues(alpha: 0.3))
//             : null,
//       ),
//       child: Text(
//         tag,
//         style: TextStyle(
//           fontSize: 11,
//           fontWeight: FontWeight.w600,
//           color: isFragile ? _fragileColor : _defaultColor,
//         ),
//       ),
//     );
//   }
// }

// // ── Earnings row ──────────────────────────────────────────────────────────────

// class _EarningsRow extends StatelessWidget {
//   final String label;
//   final double amount;
//   final IconData? icon;
//   final Color? iconColor;

//   const _EarningsRow({
//     required this.label,
//     required this.amount,
//     this.icon,
//     this.iconColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         if (icon != null) ...[
//           Icon(icon, size: 14, color: iconColor),
//           const SizedBox(width: 4),
//         ],
//         Text(
//           label,
//           style: const TextStyle(fontSize: 14, color: Color(0xFFCCCCCC)),
//         ),
//         const Spacer(),
//         Text(
//           '₹${amount.toStringAsFixed(2)}',
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//           ),
//         ),
//       ],
//     );
//   }
// }

// // ── Withdraw button ───────────────────────────────────────────────────────────

// class _WithdrawButton extends StatelessWidget {
//   final VoidCallback onTap;
//   const _WithdrawButton({required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: const Text(
//           'WITHDRAW',
//           style: TextStyle(
//             fontSize: 13,
//             fontWeight: FontWeight.w800,
//             color: Color(0xFF1A1A1A),
//             letterSpacing: 0.5,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../data/models/trip_record_model.dart';

/// Full detail view for a single trip.
/// Layout mirrors the Trips list screen: black header → white rounded sheet.
class TripDetailsScreen extends StatelessWidget {
  final TripRecord trip;

  const TripDetailsScreen({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureBlack,
      body: Column(
        children: [
          // ── Black header (mirrors TripsListScreen) ────────────────────────
          SafeArea(bottom: false, child: _buildHeader(context)),
          // ── White rounded sheet ───────────────────────────────────────────
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
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
                  children: [
                    _buildStatusHeader(),
                    const SizedBox(height: 14),
                    _buildRouteCard(),
                    const SizedBox(height: 14),
                    _buildStatsRow(),
                    const SizedBox(height: 14),
                    _buildPackageCard(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Black top header ──────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 16, 20),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.pureWhite),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: 4),
          const Text(
            'Trip Details',
            style: TextStyle(
              color: AppColors.pureWhite,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(
              Icons.help_outline_rounded,
              color: AppColors.pureWhite,
            ),
            onPressed: () => _showHelpSheet(context),
          ),
        ],
      ),
    );
  }

  // ── Help / support sheet ──────────────────────────────────────────────────

  void _showHelpSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => Container(
        decoration: const BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const Text(
                'Need help with this trip?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Order ID: ${trip.orderId}',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFF4F4F4),
                  child: Icon(
                    Icons.report_gmailerrorred_outlined,
                    color: AppColors.textPrimary,
                  ),
                ),
                title: const Text('Report an issue with this trip'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pop(sheetContext);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Report an issue — coming soon'),
                    ),
                  );
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFF4F4F4),
                  child: Icon(
                    Icons.headset_mic_outlined,
                    color: AppColors.textPrimary,
                  ),
                ),
                title: const Text('Contact support'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pop(sheetContext);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Contact support — coming soon'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Status header card ────────────────────────────────────────────────────

  Widget _buildStatusHeader() {
    final isDelivered = trip.statusValue == TripStatus.delivered;
    final isOngoing = trip.statusValue == TripStatus.ongoing;

    final Color statusFg = isDelivered
        ? AppColors.success
        : isOngoing
        ? const Color(0xFFB8860B)
        : const Color(0xFFD32F2F);

    final Color statusBg = isDelivered
        ? const Color(0xFFE8F8EF)
        : isOngoing
        ? const Color(0xFFFFF3D6)
        : const Color(0xFFFBE1E1);

    final IconData badgeIcon = isDelivered
        ? Icons.check_circle_outline_rounded
        : isOngoing
        ? Icons.timer_outlined
        : Icons.cancel_outlined;

    return _Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status pill
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: statusFg,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        trip.status.toUpperCase(),
                        style: TextStyle(
                          color: statusFg,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Order ID: ${trip.orderId}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  trip.time,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // Badge icon
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(badgeIcon, color: statusFg, size: 22),
          ),
        ],
      ),
    );
  }

  // ── Route card ────────────────────────────────────────────────────────────

  Widget _buildRouteCard() {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ROUTE DETAILS',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          _RouteStop(
            dotColor: AppColors.textPrimary,
            label: 'PICKUP',
            name: trip.pickupName,
            address: trip.pickupAddress,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 3.5),
            child: _DashedLine(height: 30),
          ),
          _RouteStop(
            dotColor: const Color(0xFFD32F2F),
            label: 'DELIVERY',
            name: trip.dropName,
            address: trip.dropAddress,
          ),
        ],
      ),
    );
  }

  // ── Stats row ─────────────────────────────────────────────────────────────

  Widget _buildStatsRow() {
    return _Card(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: _StatCell(label: 'DISTANCE', value: trip.distance),
          ),
          _VDivider(),
          Expanded(
            child: _StatCell(label: 'TIME TAKEN', value: trip.duration),
          ),
          _VDivider(),
          Expanded(
            child: _StatCell(label: 'SERVICE', value: trip.serviceType),
          ),
        ],
      ),
    );
  }

  // ── Package contents card ─────────────────────────────────────────────────

  Widget _buildPackageCard() {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PACKAGE CONTENTS',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Product image ─────────────────────────────────────────────
              _PackageImage(imageUrl: trip.packageImageUrl),
              const SizedBox(width: 14),
              // ── Name + tags ───────────────────────────────────────────────
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.packageName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: trip.packageTags
                          .map((t) => _TagChip(tag: t))
                          .toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // ── Qty ───────────────────────────────────────────────────────
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'QTY',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    '${trip.packageQty}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (trip.otpVerified) ...[
            const SizedBox(height: 14),
            const Divider(height: 1, color: Color(0xFFEEEEEE)),
            const SizedBox(height: 12),
            Row(
              children: const [
                Icon(
                  Icons.security_rounded,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Verified with OTP at Dropoff',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                Icon(
                  Icons.check_circle_rounded,
                  size: 20,
                  color: AppColors.success,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// ── Shared white card ─────────────────────────────────────────────────────────

class _Card extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const _Card({required this.child, this.padding = const EdgeInsets.all(16)});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ── Dashed vertical connector ─────────────────────────────────────────────────

class _DashedLine extends StatelessWidget {
  final double height;
  const _DashedLine({required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (_, constraints) {
          const dashH = 4.0;
          const gap = 3.0;
          final count = (constraints.maxHeight / (dashH + gap)).floor();
          return Column(
            children: List.generate(count, (_) {
              return Padding(
                padding: const EdgeInsets.only(bottom: gap),
                child: Container(
                  width: 1.5,
                  height: dashH,
                  color: const Color(0xFFCCCCCC),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

// ── Route stop row ────────────────────────────────────────────────────────────

class _RouteStop extends StatelessWidget {
  final Color dotColor;
  final String label;
  final String name;
  final String address;

  const _RouteStop({
    required this.dotColor,
    required this.label,
    required this.name,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                address,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

// ── Stats cell ────────────────────────────────────────────────────────────────

class _StatCell extends StatelessWidget {
  final String label;
  final String value;
  const _StatCell({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _VDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 36, color: const Color(0xFFEEEEEE));
}

// ── Package image ─────────────────────────────────────────────────────────────

class _PackageImage extends StatelessWidget {
  final String? imageUrl;
  const _PackageImage({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84,
      height: 84,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      clipBehavior: Clip.antiAlias,
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? Image.network(
              imageUrl!,
              fit: BoxFit.cover,
              loadingBuilder: (_, child, progress) => progress == null
                  ? child
                  : const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.textSecondary,
                      ),
                    ),
              errorBuilder: (_, e, __) => _placeholder(),
            )
          : _placeholder(),
    );
  }

  Widget _placeholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.inventory_2_outlined, size: 28, color: Color(0xFFBBBBBB)),
        SizedBox(height: 4),
        Text(
          'No Image',
          style: TextStyle(fontSize: 9, color: Color(0xFFBBBBBB)),
        ),
      ],
    );
  }
}

// ── Tag chip ──────────────────────────────────────────────────────────────────

class _TagChip extends StatelessWidget {
  final String tag;
  const _TagChip({required this.tag});

  static const _fragileColor = Color(0xFFD32F2F);
  static const _fragileBg = Color(0xFFFDECEC);
  static const _defaultBg = Color(0xFFF0F0F0);
  static const _defaultColor = Color(0xFF555555);

  @override
  Widget build(BuildContext context) {
    final isFragile = tag.toLowerCase() == 'fragile';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isFragile ? _fragileBg : _defaultBg,
        borderRadius: BorderRadius.circular(20),
        border: isFragile
            ? Border.all(color: _fragileColor.withValues(alpha: 0.3))
            : null,
      ),
      child: Text(
        tag,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: isFragile ? _fragileColor : _defaultColor,
        ),
      ),
    );
  }
}
