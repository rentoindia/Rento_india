// import 'package:flutter/material.dart';

// class PaymentsRefundsScreen extends StatelessWidget {
//   const PaymentsRefundsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F8FA),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         foregroundColor: Colors.black,
//         title: const Text('Payments & Refunds',
//             style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: Colors.black)),
//       ),
//       body: SafeArea(
//         child: ListView(
//           padding: const EdgeInsets.all(16),
//           children: [
//             const Text('Payment Methods', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
//             const SizedBox(height: 10),
//             _sectionCard(
//               child: Column(
//                 children: [
//                   _paymentMethodRow(Icons.credit_card_outlined, 'No cards added yet'),
//                   const Divider(height: 24, color: Color(0xFFF0F0F0)),
//                   _paymentMethodRow(Icons.account_balance_outlined, 'No UPI ID linked yet'),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             SizedBox(
//               width: double.infinity,
//               child: OutlinedButton.icon(
//                 onPressed: () {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Add payment method coming soon')),
//                   );
//                 },
//                 icon: const Icon(Icons.add, size: 18, color: Colors.black),
//                 label: const Text('Add Payment Method',
//                     style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
//                 style: OutlinedButton.styleFrom(
//                   side: const BorderSide(color: Colors.black),
//                   padding: const EdgeInsets.symmetric(vertical: 13),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 26),
//             const Text('Payment History', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
//             const SizedBox(height: 10),
//             _sectionCard(
//               child: const Padding(
//                 padding: EdgeInsets.symmetric(vertical: 20),
//                 child: Center(
//                   child: Text('Your payment history and invoices will appear here.',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: Colors.grey, fontSize: 12.5)),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 26),
//             const Text('Refunds', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
//             const SizedBox(height: 10),
//             _sectionCard(
//               child: const Padding(
//                 padding: EdgeInsets.symmetric(vertical: 20),
//                 child: Center(
//                   child: Text('Refund status for cancelled or returned rentals will show up here.',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: Colors.grey, fontSize: 12.5)),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _sectionCard({required Widget child}) {
//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: const Color(0xFFF0F0F0)),
//       ),
//       child: child,
//     );
//   }

//   Widget _paymentMethodRow(IconData icon, String label) {
//     return Row(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: const Color(0xFFF3F4F6),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Icon(icon, size: 18, color: Colors.black87),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 12.5)),
//         ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';

class PaymentsRefundsScreen extends StatelessWidget {
  const PaymentsRefundsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text('Payments & Refunds',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: Colors.black)),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('Payment Methods', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            const SizedBox(height: 10),
            _sectionCard(
              child: Column(
                children: [
                  _paymentMethodRow(Icons.credit_card_outlined, 'No cards added yet'),
                  const Divider(height: 24, color: Color(0xFFF0F0F0)),
                  _paymentMethodRow(Icons.account_balance_outlined, 'No UPI ID linked yet'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Add payment method coming soon')),
                  );
                },
                icon: const Icon(Icons.add, size: 18, color: Colors.black),
                label: const Text('Add Payment Method',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black),
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 26),
            const Text('Payment History', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            const SizedBox(height: 10),
            _sectionCard(
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text('Your payment history and invoices will appear here.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 12.5)),
                ),
              ),
            ),
            const SizedBox(height: 26),
            const Text('Refunds', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            const SizedBox(height: 10),
            _sectionCard(
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text('Refund status for cancelled or returned rentals will show up here.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 12.5)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: child,
    );
  }

  Widget _paymentMethodRow(IconData icon, String label) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: Colors.black87),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 12.5)),
        ),
      ],
    );
  }
}