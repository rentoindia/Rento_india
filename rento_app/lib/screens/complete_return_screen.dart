// import 'package:flutter/material.dart';
// import '../theme/app_theme.dart';
// import '../widgets/primary_button.dart';
// import '../services/orders_service.dart';
// import 'rental_order.dart';
// import 'return_pickup_screen.dart';

// class CompleteReturnScreen extends StatefulWidget {
//   final RentalOrder order;
//   const CompleteReturnScreen({super.key, required this.order});

//   @override
//   State<CompleteReturnScreen> createState() => _CompleteReturnScreenState();
// }

// class _CompleteReturnScreenState extends State<CompleteReturnScreen> {
//   late DateTime _pickupDate;
//   int _selectedSlot = 0;

//   final List<String> _slots = [
//     '10:00 AM - 12:00 PM',
//     '12:00 PM - 02:00 PM',
//     '02:00 PM - 04:00 PM',
//     '04:00 PM - 06:00 PM',
//     '06:00 PM - 08:00 PM',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _pickupDate = DateTime.now().add(const Duration(days: 1));
//   }

//   Future<void> _pickDate() async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: _pickupDate,
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(const Duration(days: 30)),
//     );
//     if (picked != null) setState(() => _pickupDate = picked);
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
//         title: const Text('Complete & Return', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 15)),
//       ),
//       body: SafeArea(
//         child: ListView(
//           padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
//               child: Row(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Builder(builder: (_) {
//                       final imgPath = order.imageUrl ??
//                           'https://loremflickr.com/100/100/${order.imageQuery.replaceAll(' ', ',')}?lock=${order.name.hashCode.abs() % 5000}';
//                       final isAsset = !imgPath.startsWith('http');
//                       return isAsset
//                           ? Image.asset(imgPath, width: 52, height: 52, fit: BoxFit.cover,
//                               errorBuilder: (_, __, ___) => Container(width: 52, height: 52, color: AppTheme.lightGrey, child: const Icon(Icons.image_outlined)))
//                           : Image.network(imgPath, width: 52, height: 52, fit: BoxFit.cover,
//                               errorBuilder: (_, __, ___) => Container(width: 52, height: 52, color: AppTheme.lightGrey, child: const Icon(Icons.image_outlined)));
//                     }),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(order.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
//                         Text(order.categoryLabel, style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
//                     decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
//                     child: Text('${order.days} DAYS', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),
//             const Text('Schedule Return Pickup', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
//             const SizedBox(height: 16),
//             const Text('Select Pickup Date', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.5)),
//             const SizedBox(height: 8),
//             GestureDetector(
//               onTap: _pickDate,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//                 decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(10)),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(RentalOrder.formatDate(_pickupDate), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
//                     const Icon(Icons.calendar_today_outlined, size: 16, color: Colors.black54),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text('Select Time Slot', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.5)),
//             const SizedBox(height: 8),
//             ..._slots.asMap().entries.map((entry) {
//               final selected = _selectedSlot == entry.key;
//               return GestureDetector(
//                 onTap: () => setState(() => _selectedSlot = entry.key),
//                 child: Container(
//                   margin: const EdgeInsets.only(bottom: 8),
//                   padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: selected ? Colors.black : AppTheme.border, width: selected ? 1.5 : 1),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off, size: 18, color: selected ? Colors.black : Colors.grey.shade400),
//                       const SizedBox(width: 10),
//                       Text(entry.value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
//                     ],
//                   ),
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//       bottomNavigationBar: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
//           child: PrimaryButton(
//             label: 'SCHEDULE PICKUP',
//             onPressed: () {
//               final updatedOrder = order.copyWith(
//                 status: OrderStatus.returnScheduled,
//                 returnPickupDate: _pickupDate,
//                 returnPickupSlot: _slots[_selectedSlot],
//               );
//               OrdersService.instance.upsert(updatedOrder);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => ReturnPickupScreen(
//                     order: updatedOrder,
//                     pickupDate: _pickupDate,
//                     pickupSlot: _slots[_selectedSlot],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';
import '../services/orders_service.dart';
import 'rental_order.dart';
import 'inspection_refund_screen.dart';
//import 'return_pickup_screen.dart';
import 'return_otp_screen.dart';

class CompleteReturnScreen extends StatefulWidget {
  final RentalOrder order;
  const CompleteReturnScreen({super.key, required this.order});

  @override
  State<CompleteReturnScreen> createState() => _CompleteReturnScreenState();
}

class _CompleteReturnScreenState extends State<CompleteReturnScreen> {
  late DateTime _pickupDate;
  int _selectedSlot = 0;

  final List<String> _slots = [
    '10:00 AM - 12:00 PM',
    '12:00 PM - 02:00 PM',
    '02:00 PM - 04:00 PM',
    '04:00 PM - 06:00 PM',
    '06:00 PM - 08:00 PM',
  ];

  @override
  void initState() {
    super.initState();
    _pickupDate = DateTime.now().add(const Duration(days: 1));
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _pickupDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) setState(() => _pickupDate = picked);
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
        title: const Text('Complete & Return', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 15)),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Builder(builder: (_) {
                      final imgPath = order.imageUrl ??
                          'https://loremflickr.com/100/100/${order.imageQuery.replaceAll(' ', ',')}?lock=${order.name.hashCode.abs() % 5000}';
                      final isAsset = !imgPath.startsWith('http');
                      return isAsset
                          ? Image.asset(imgPath, width: 52, height: 52, fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(width: 52, height: 52, color: AppTheme.lightGrey, child: const Icon(Icons.image_outlined)))
                          : Image.network(imgPath, width: 52, height: 52, fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(width: 52, height: 52, color: AppTheme.lightGrey, child: const Icon(Icons.image_outlined)));
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
                    child: Text('${order.days} DAYS', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Schedule Return Pickup', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            const SizedBox(height: 16),
            const Text('Select Pickup Date', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.5)),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(RentalOrder.formatDate(_pickupDate), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    const Icon(Icons.calendar_today_outlined, size: 16, color: Colors.black54),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Select Time Slot', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.5)),
            const SizedBox(height: 8),
            ..._slots.asMap().entries.map((entry) {
              final selected = _selectedSlot == entry.key;
              return GestureDetector(
                onTap: () => setState(() => _selectedSlot = entry.key),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: selected ? Colors.black : AppTheme.border, width: selected ? 1.5 : 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off, size: 18, color: selected ? Colors.black : Colors.grey.shade400),
                      const SizedBox(width: 10),
                      Text(entry.value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: PrimaryButton(
            label: 'SCHEDULE PICKUP',
            // onPressed: () {
            //   final updatedOrder = order.copyWith(
            //     status: OrderStatus.returnScheduled,
            //     returnPickupDate: _pickupDate,
            //     returnPickupSlot: _slots[_selectedSlot],
            //   );
            //   OrdersService.instance.upsert(updatedOrder);
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (_) => InspectionRefundScreen(order: updatedOrder),
            //     ),
            //   );
            // },
            onPressed: () {
  final updatedOrder = order.copyWith(
    status: OrderStatus.returnScheduled,
    returnPickupDate: _pickupDate,
    returnPickupSlot: _slots[_selectedSlot],
  );
  OrdersService.instance.upsert(updatedOrder);
  Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => ReturnOtpScreen(
      order: updatedOrder,
      pickupDate: _pickupDate,
      pickupSlot: _slots[_selectedSlot],
    ),
  ),
);
},
          ),
        ),
      ),
    );
  }
}