// import 'package:flutter/material.dart';
// import '../theme/app_theme.dart';
// import '../widgets/primary_button.dart';
// import 'rental_order.dart';
// import 'return_otp_screen.dart';

// class ReturnPickupScreen extends StatelessWidget {
//   final RentalOrder order;
//   final DateTime pickupDate;
//   final String pickupSlot;

//   const ReturnPickupScreen({
//     super.key,
//     required this.order,
//     required this.pickupDate,
//     required this.pickupSlot,
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
//         title: const Text('Return Pickup', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16)),
//       ),
//       body: SafeArea(
//         child: ListView(
//           padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
//           children: [
//             Center(
//               child: Column(
//                 children: [
//                   Container(
//                     width: 84,
//                     height: 84,
//                     decoration: const BoxDecoration(color: Color(0xFFF3F4F6), shape: BoxShape.circle),
//                     child: const Icon(Icons.two_wheeler, size: 38, color: Colors.black87),
//                   ),
//                   const SizedBox(height: 16),
//                   const Text('Rider Assigned!', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
//                   const SizedBox(height: 6),
//                   Text('Your return pickup is scheduled.', style: TextStyle(color: Colors.grey.shade600, fontSize: 12.5)),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 26),
//             Container(
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
//               child: Column(
//                 children: [
//                   _infoRow(Icons.calendar_today_outlined, 'Pickup Date', RentalOrder.formatDate(pickupDate)),
//                   const Divider(height: 22),
//                   _infoRow(Icons.access_time, 'Pickup Time', pickupSlot),
//                   const Divider(height: 22),
//                   _infoRow(Icons.person_outline, 'Rider Name', 'Rohit Kumar'),
//                   const Divider(height: 22),
//                   _infoRow(Icons.call_outlined, 'Contact', '+91 98765 43210'),
//                   const Divider(height: 22),
//                   _infoRow(Icons.two_wheeler_outlined, 'Vehicle', 'MH01 AB 1234'),
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
//             // FIX: this used to set status=returnCollected and jump
//             // straight to InspectionRefundScreen — skipping the Return
//             // OTP step the spec explicitly requires ("Customer gets a
//             // Return OTP. Rider verifies and collects."). Now it routes
//             // into ReturnOtpScreen first; the status only becomes
//             // "Return Collected" once that OTP is actually verified.
//             label: 'VIEW DETAILS',
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => ReturnOtpScreen(
//                     order: order,
//                     pickupDate: pickupDate,
//                     pickupSlot: pickupSlot,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _infoRow(IconData icon, String label, String value) {
//     return Row(
//       children: [
//         Icon(icon, size: 16, color: Colors.black54),
//         const SizedBox(width: 10),
//         Expanded(child: Text(label, style: TextStyle(fontSize: 12.5, color: Colors.grey.shade600))),
//         Text(value, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700)),
//       ],
//     );
//   }
// }























import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:rento_india/delivery/core/constants/app_colors.dart'; //import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/primary_button.dart';
import 'rental_order.dart';
import 'return_otp_screen.dart';

class ReturnPickupScreen extends StatelessWidget {
  final RentalOrder order;
  final DateTime pickupDate;
  final String pickupSlot;

  const ReturnPickupScreen({
    super.key,
    required this.order,
    required this.pickupDate,
    required this.pickupSlot,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      appBar: AppBar(
        backgroundColor: AppColors.pureWhite,
        elevation: 0,
        foregroundColor: AppColors.primaryBlack,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: Text('Return Pickup', style: AppText.titleLg.copyWith(fontSize: 16)),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 84,
                    height: 84,
                    decoration: const BoxDecoration(color: Color(0xFFF3F4F6), shape: BoxShape.circle),
                    child: const Icon(Icons.two_wheeler, size: 38, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 16),
                  Text('Rider Assigned!', style: AppText.displaySm.copyWith(fontWeight: FontWeight.w800, fontSize: 18)),
                  const SizedBox(height: 6),
                  Text('Your return pickup is scheduled.', style: AppText.bodySm.copyWith(fontSize: 12.5)),
                ],
              ),
            ),
            const SizedBox(height: 26),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
              child: Column(
                children: [
                  _infoRow(Icons.calendar_today_outlined, 'Pickup Date', RentalOrder.formatDate(pickupDate)),
                  const Divider(height: 22),
                  _infoRow(Icons.access_time, 'Pickup Time', pickupSlot),
                  const Divider(height: 22),
                  _infoRow(Icons.person_outline, 'Rider Name', 'Rohit Kumar'),
                  const Divider(height: 22),
                  _infoRow(Icons.call_outlined, 'Contact', '+91 98765 43210'),
                  const Divider(height: 22),
                  _infoRow(Icons.two_wheeler_outlined, 'Vehicle', 'MH01 AB 1234'),
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
            // FIX: this used to set status=returnCollected and jump
            // straight to InspectionRefundScreen — skipping the Return
            // OTP step the spec explicitly requires ("Customer gets a
            // Return OTP. Rider verifies and collects."). Now it routes
            // into ReturnOtpScreen first; the status only becomes
            // "Return Collected" once that OTP is actually verified.
            label: 'VIEW DETAILS',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ReturnOtpScreen(
                    order: order,
                    pickupDate: pickupDate,
                    pickupSlot: pickupSlot,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 10),
        Expanded(child: Text(label, style: AppText.bodySm.copyWith(fontSize: 12.5))),
        Text(value, style: AppText.titleSm.copyWith(fontSize: 12.5)),
      ],
    );
  }
}