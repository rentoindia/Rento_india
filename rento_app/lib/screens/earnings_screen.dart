// import 'package:flutter/material.dart';
// import '../services/lender_service.dart';

// /// Simple earnings summary for the lender: total earned (from accepted
// /// requests), pending amount (from requests still awaiting a response),
// /// completed rental count, and a breakdown list. Numbers are derived
// /// directly from LenderService's requests — see the notes there about
// /// this being local/demo data until a real backend exists.
// class EarningsScreen extends StatelessWidget {
//   const EarningsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: LenderService.instance,
//       builder: (context, _) {
//         final service = LenderService.instance;
//         final accepted = service.requests
//             .where((r) => r.status == RentalRequestStatus.accepted)
//             .toList();

//         return Scaffold(
//           backgroundColor: const Color(0xFFF7F8FA),
//           appBar: AppBar(
//             backgroundColor: Colors.white,
//             elevation: 0,
//             iconTheme: const IconThemeData(color: Colors.black),
//             title: const Text('Earnings',
//                 style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
//           ),
//           body: ListView(
//             padding: const EdgeInsets.all(16),
//             children: [
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(16)),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Total Earnings', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
//                     const SizedBox(height: 6),
//                     Text('₹${service.totalEarnings.toStringAsFixed(0)}',
//                         style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 14),
//               Row(
//                 children: [
//                   Expanded(
//                     child: _summaryCard(
//                       icon: Icons.hourglass_empty,
//                       label: 'Pending',
//                       value: '₹${service.pendingEarnings.toStringAsFixed(0)}',
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: _summaryCard(
//                       icon: Icons.check_circle_outline,
//                       label: 'Completed Rentals',
//                       value: '${service.completedRentalsCount}',
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 22),
//               const Text('Earnings Breakdown', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
//               const SizedBox(height: 12),
//               if (accepted.isEmpty)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 40),
//                   child: Center(
//                     child: Column(
//                       children: [
//                         Icon(Icons.receipt_long_outlined, size: 40, color: Colors.grey.shade300),
//                         const SizedBox(height: 10),
//                         Text('No completed rentals yet', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
//                         const SizedBox(height: 4),
//                         Text('Accept a rental request to start earning',
//                             style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
//                       ],
//                     ),
//                   ),
//                 )
//               else
//                 ...accepted.map((r) => Container(
//                       margin: const EdgeInsets.only(bottom: 10),
//                       padding: const EdgeInsets.all(14),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(color: const Color(0xFFF0F0F0)),
//                       ),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(r.productName,
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
//                                 Text('${r.customerName} · ${r.duration}',
//                                     style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
//                               ],
//                             ),
//                           ),
//                           Text('+₹${r.amount.toStringAsFixed(0)}',
//                               style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Colors.green)),
//                         ],
//                       ),
//                     )),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _summaryCard({required IconData icon, required String label, required String value}) {
//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: const Color(0xFFF0F0F0)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, size: 18, color: Colors.black87),
//           const SizedBox(height: 8),
//           Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
//           Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../services/lender_service.dart';

/// Simple earnings summary for the lender: total earned (from accepted
/// requests), pending amount (from requests still awaiting a response),
/// completed rental count, and a breakdown list. Numbers are derived
/// directly from LenderService's requests — see the notes there about
/// this being local/demo data until a real backend exists.
class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: LenderService.instance,
      builder: (context, _) {
        final service = LenderService.instance;
        final accepted = service.requests
            .where((r) => r.status == RentalRequestStatus.accepted)
            .toList();

        return Scaffold(
          backgroundColor: const Color(0xFFF7F8FA),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Text('Earnings',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Earnings', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
                    const SizedBox(height: 6),
                    Text('₹${service.totalEarnings.toStringAsFixed(0)}',
                        style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: _summaryCard(
                      icon: Icons.hourglass_empty,
                      label: 'Pending',
                      value: '₹${service.pendingEarnings.toStringAsFixed(0)}',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _summaryCard(
                      icon: Icons.check_circle_outline,
                      label: 'Completed Rentals',
                      value: '${service.completedRentalsCount}',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              const Text('Earnings Breakdown', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
              const SizedBox(height: 12),
              if (accepted.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.receipt_long_outlined, size: 40, color: Colors.grey.shade300),
                        const SizedBox(height: 10),
                        Text('No completed rentals yet', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                        const SizedBox(height: 4),
                        Text('Accept a rental request to start earning',
                            style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                      ],
                    ),
                  ),
                )
              else
                ...accepted.map((r) => Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFF0F0F0)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(r.productName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                                Text('${r.customerName} · ${r.duration}',
                                    style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
                              ],
                            ),
                          ),
                          Text('+₹${r.amount.toStringAsFixed(0)}',
                              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Colors.green)),
                        ],
                      ),
                    )),
            ],
          ),
        );
      },
    );
  }

  Widget _summaryCard({required IconData icon, required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.black87),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
          Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
        ],
      ),
    );
  }
}