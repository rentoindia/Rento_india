// import 'package:flutter/material.dart';
// import '../theme/app_theme.dart';
// import '../widgets/primary_button.dart';
// import '../services/orders_service.dart';
// import 'rental_order.dart';
// import 'extension_approved_screen.dart';

// class ExtendRentalScreen extends StatefulWidget {
//   final RentalOrder order;
//   const ExtendRentalScreen({super.key, required this.order});

//   @override
//   State<ExtendRentalScreen> createState() => _ExtendRentalScreenState();
// }

// class _ExtendRentalScreenState extends State<ExtendRentalScreen> {
//   late DateTime _newEndDate;
//   bool _requesting = false;

//   @override
//   void initState() {
//     super.initState();
//     _newEndDate = widget.order.endDate.add(const Duration(days: 7));
//   }

//   int get _additionalDays => _newEndDate.difference(widget.order.endDate).inDays;
//   double get _additionalAmount => _additionalDays * widget.order.ratePerDay;

//   Future<void> _pickNewEndDate() async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: _newEndDate,
//       firstDate: widget.order.endDate.add(const Duration(days: 1)),
//       lastDate: widget.order.endDate.add(const Duration(days: 90)),
//     );
//     if (picked != null) setState(() => _newEndDate = picked);
//   }

//   void _requestExtension() async {
//     if (_additionalDays <= 0) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('New end date must be after the current end date')),
//       );
//       return;
//     }
//     setState(() => _requesting = true);
//     // Payment + vendor-approval request happens here in a real backend.
//     // The vendor approves asynchronously; we simulate that resolving
//     // quickly so the customer sees the confirmation screen next.
//     await Future.delayed(const Duration(seconds: 2));
//     if (!mounted) return;
//     final updatedOrder = widget.order.copyWith(endDate: _newEndDate, status: OrderStatus.rentalActive);
//     OrdersService.instance.upsert(updatedOrder);
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (_) => ExtensionApprovedScreen(
//           order: updatedOrder,
//           additionalDays: _additionalDays,
//           additionalAmount: _additionalAmount,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final order = widget.order;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         foregroundColor: Colors.black,
//         leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
//         title: const Text('Extend Rental', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16)),
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
//           padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
//           children: [
//             _twoStepBar('Rental Active', 'Extend Rental'),
//             const SizedBox(height: 22),
//             const Center(child: Text('Extend Your Rental', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18))),
//             const SizedBox(height: 6),
//             Center(
//               child: Text(
//                 'Select a new end date and request an extension.\nVendor approval is required.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.grey.shade600, fontSize: 12.5, height: 1.4),
//               ),
//             ),
//             const SizedBox(height: 22),
//             Container(
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
//               child: Column(
//                 children: [
//                   _row('Current End Date', RentalOrder.formatDate(order.endDate)),
//                   const Divider(height: 22),
//                   GestureDetector(
//                     onTap: _pickNewEndDate,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('New End Date', style: TextStyle(fontSize: 12.5, color: Colors.grey.shade600)),
//                         Row(children: [
//                           Text(RentalOrder.formatDate(_newEndDate), style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700)),
//                           const SizedBox(width: 6),
//                           const Icon(Icons.calendar_today_outlined, size: 14, color: Colors.black54),
//                         ]),
//                       ],
//                     ),
//                   ),
//                   const Divider(height: 22),
//                   _row('Additional Days', '$_additionalDays Days'),
//                   const Divider(height: 22),
//                   _row('Additional Amount', '₹${_additionalAmount.toStringAsFixed(0)}', bold: true),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//               decoration: BoxDecoration(color: AppTheme.lightGrey, borderRadius: BorderRadius.circular(12)),
//               child: Row(
//                 children: [
//                   const Icon(Icons.info_outline, size: 18, color: Colors.black54),
//                   const SizedBox(width: 8),
//                   const Expanded(
//                     child: Text('Vendor approval is required to extend your rental.', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
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
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               PrimaryButton(
//                 label: _requesting ? 'REQUESTING...' : 'PAY & REQUEST EXTENSION',
//                 icon: Icons.arrow_forward,
//                 onPressed: _requesting ? () {} : _requestExtension,
//               ),
//               const SizedBox(height: 8),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.lock_outline, size: 12, color: Colors.grey.shade500),
//                   const SizedBox(width: 5),
//                   Text('Secure Payment', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
//                 ],
//               ),
//             ],
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
//         Text(value, style: TextStyle(fontSize: bold ? 15 : 12.5, fontWeight: bold ? FontWeight.w800 : FontWeight.w700)),
//       ],
//     );
//   }

//   Widget _twoStepBar(String stepOneLabel, String stepTwoLabel) {
//     return Row(
//       children: [
//         _stepDot(true, '1'),
//         const SizedBox(width: 6),
//         Text(stepOneLabel, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black54)),
//         Expanded(child: Container(height: 2, margin: const EdgeInsets.symmetric(horizontal: 8), color: Colors.black)),
//         _stepDot(true, '2'),
//         const SizedBox(width: 6),
//         const Text('Extend Rental', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.black)),
//       ],
//     );
//   }

//   Widget _stepDot(bool active, String label) {
//     return Container(
//       width: 22,
//       height: 22,
//       alignment: Alignment.center,
//       decoration: BoxDecoration(color: active ? Colors.black : Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.black)),
//       child: Text(label, style: TextStyle(color: active ? Colors.white : Colors.black, fontSize: 11, fontWeight: FontWeight.w700)),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';
import '../services/orders_service.dart';
import 'rental_order.dart';
import 'extension_approved_screen.dart';

class ExtendRentalScreen extends StatefulWidget {
  final RentalOrder order;
  const ExtendRentalScreen({super.key, required this.order});

  @override
  State<ExtendRentalScreen> createState() => _ExtendRentalScreenState();
}

class _ExtendRentalScreenState extends State<ExtendRentalScreen> {
  late DateTime _newEndDate;
  bool _requesting = false;

  @override
  void initState() {
    super.initState();
    _newEndDate = widget.order.endDate.add(const Duration(days: 7));
  }

  int get _additionalDays => _newEndDate.difference(widget.order.endDate).inDays;
  double get _additionalAmount => _additionalDays * widget.order.ratePerDay;

  Future<void> _pickNewEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _newEndDate,
      firstDate: widget.order.endDate.add(const Duration(days: 1)),
      lastDate: widget.order.endDate.add(const Duration(days: 90)),
    );
    if (picked != null) setState(() => _newEndDate = picked);
  }

  void _requestExtension() async {
    if (_additionalDays <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New end date must be after the current end date')),
      );
      return;
    }
    setState(() => _requesting = true);
    // Payment + vendor-approval request happens here in a real backend.
    // The vendor approves asynchronously; we simulate that resolving
    // quickly so the customer sees the confirmation screen next.
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    final updatedOrder = widget.order.copyWith(endDate: _newEndDate, status: OrderStatus.rentalActive);
    OrdersService.instance.upsert(updatedOrder);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ExtensionApprovedScreen(
          order: updatedOrder,
          additionalDays: _additionalDays,
          additionalAmount: _additionalAmount,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: const Text('Extend Rental', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16)),
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
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
          children: [
            _twoStepBar('Rental Active', 'Extend Rental'),
            const SizedBox(height: 22),
            const Center(child: Text('Extend Your Rental', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18))),
            const SizedBox(height: 6),
            Center(
              child: Text(
                'Select a new end date and request an extension.\nVendor approval is required.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12.5, height: 1.4),
              ),
            ),
            const SizedBox(height: 22),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
              child: Column(
                children: [
                  _row('Current End Date', RentalOrder.formatDate(order.endDate)),
                  const Divider(height: 22),
                  GestureDetector(
                    onTap: _pickNewEndDate,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('New End Date', style: TextStyle(fontSize: 12.5, color: Colors.grey.shade600)),
                        Row(children: [
                          Text(RentalOrder.formatDate(_newEndDate), style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700)),
                          const SizedBox(width: 6),
                          const Icon(Icons.calendar_today_outlined, size: 14, color: Colors.black54),
                        ]),
                      ],
                    ),
                  ),
                  const Divider(height: 22),
                  _row('Additional Days', '$_additionalDays Days'),
                  const Divider(height: 22),
                  _row('Additional Amount', '₹${_additionalAmount.toStringAsFixed(0)}', bold: true),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(color: AppTheme.lightGrey, borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, size: 18, color: Colors.black54),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text('Vendor approval is required to extend your rental.', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryButton(
                label: _requesting ? 'REQUESTING...' : 'PAY & REQUEST EXTENSION',
                icon: Icons.arrow_forward,
                onPressed: _requesting ? () {} : _requestExtension,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock_outline, size: 12, color: Colors.grey.shade500),
                  const SizedBox(width: 5),
                  Text('Secure Payment', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
                ],
              ),
            ],
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
        Text(value, style: TextStyle(fontSize: bold ? 15 : 12.5, fontWeight: bold ? FontWeight.w800 : FontWeight.w700)),
      ],
    );
  }

  Widget _twoStepBar(String stepOneLabel, String stepTwoLabel) {
    return Row(
      children: [
        _stepDot(true, '1'),
        const SizedBox(width: 6),
        Text(stepOneLabel, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black54)),
        Expanded(child: Container(height: 2, margin: const EdgeInsets.symmetric(horizontal: 8), color: Colors.black)),
        _stepDot(true, '2'),
        const SizedBox(width: 6),
        const Text('Extend Rental', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.black)),
      ],
    );
  }

  Widget _stepDot(bool active, String label) {
    return Container(
      width: 22,
      height: 22,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: active ? Colors.black : Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.black)),
      child: Text(label, style: TextStyle(color: active ? Colors.white : Colors.black, fontSize: 11, fontWeight: FontWeight.w700)),
    );
  }
}