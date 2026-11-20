





// import 'package:flutter/material.dart';
// import '../services/lender_service.dart';

// /// Owner-side inbox for incoming rental requests. See the notes in
// /// lender_service.dart about demo/seeded data — there's no real backend
// /// yet, so these aren't genuine requests from other customers.
// class RentalRequestsScreen extends StatelessWidget {
//   const RentalRequestsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: LenderService.instance,
//       builder: (context, _) {
//         final requests = LenderService.instance.requests;
//         // Pending first, then accepted, then rejected.
//         final sorted = [...requests]..sort((a, b) => a.status.index.compareTo(b.status.index));

//         return Scaffold(
//           backgroundColor: const Color(0xFFF7F8FA),
//           appBar: AppBar(
//             backgroundColor: Colors.white,
//             elevation: 0,
//             iconTheme: const IconThemeData(color: Colors.black),
//             title: const Text('Rental Requests',
//                 style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
//           ),
//           body: requests.isEmpty
//               ? Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(32),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(Icons.inbox_outlined, size: 44, color: Colors.grey.shade300),
//                         const SizedBox(height: 14),
//                         const Text('No rental requests yet',
//                             style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
//                         const SizedBox(height: 6),
//                         Text('Requests from customers who want to rent your\nproducts will show up here.',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(color: Colors.grey.shade500, fontSize: 12.5, height: 1.4)),
//                       ],
//                     ),
//                   ),
//                 )
//               : ListView.separated(
//                   padding: const EdgeInsets.all(16),
//                   itemCount: sorted.length,
//                   separatorBuilder: (_, __) => const SizedBox(height: 10),
//                   itemBuilder: (context, i) {
//                     final r = sorted[i];
//                     return Container(
//                       padding: const EdgeInsets.all(14),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(color: const Color(0xFFF0F0F0)),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(r.productName,
//                               style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
//                           const SizedBox(height: 4),
//                           Text('Requested by ${r.customerName}',
//                               style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
//                           Text(r.duration,
//                               style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
//                           if (r.deliveryAddress.isNotEmpty)
//                             Padding(
//                               padding: const EdgeInsets.only(top: 2),
//                               child: Text(r.deliveryAddress,
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: TextStyle(color: Colors.grey.shade500, fontSize: 11.5)),
//                             ),
//                           const SizedBox(height: 4),
//                           Text('₹${r.amount.toStringAsFixed(0)} total',
//                               style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5)),
//                           const SizedBox(height: 10),
//                           if (r.status == RentalRequestStatus.pending)
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: OutlinedButton(
//                                     onPressed: () => LenderService.instance
//                                         .respondToRequest(r.id, RentalRequestStatus.rejected),
//                                     style: OutlinedButton.styleFrom(
//                                       side: const BorderSide(color: Colors.redAccent),
//                                     ),
//                                     child: const Text('Reject', style: TextStyle(color: Colors.redAccent)),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 10),
//                                 Expanded(
//                                   child: ElevatedButton(
//                                     onPressed: () => LenderService.instance
//                                         .respondToRequest(r.id, RentalRequestStatus.accepted),
//                                     style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
//                                     child: const Text('Accept', style: TextStyle(color: Colors.white)),
//                                   ),
//                                 ),
//                               ],
//                             )
//                           else
//                             Container(
//                               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                               decoration: BoxDecoration(
//                                 color: r.status == RentalRequestStatus.accepted
//                                     ? const Color(0xFFEAFBF0)
//                                     : const Color(0xFFFEECEC),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Text(
//                                 r.status == RentalRequestStatus.accepted ? 'Accepted' : 'Rejected',
//                                 style: TextStyle(
//                                   color: r.status == RentalRequestStatus.accepted
//                                       ? const Color(0xFF15803D)
//                                       : Colors.redAccent,
//                                   fontWeight: FontWeight.w700,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//         );
//       },
//     );
//   }
// }




import 'package:flutter/material.dart';
import '../services/lender_service.dart';

/// Owner-side inbox for incoming rental requests. See the notes in
/// lender_service.dart about demo/seeded data — there's no real backend
/// yet, so these aren't genuine requests from other customers.
class RentalRequestsScreen extends StatelessWidget {
  const RentalRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: LenderService.instance,
      builder: (context, _) {
        final requests = LenderService.instance.requests;
        // Pending first, then accepted, then rejected.
        final sorted = [...requests]..sort((a, b) => a.status.index.compareTo(b.status.index));

        return Scaffold(
          backgroundColor: const Color(0xFFF7F8FA),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Text('Rental Requests',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
          ),
          body: requests.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.inbox_outlined, size: 44, color: Colors.grey.shade300),
                        const SizedBox(height: 14),
                        const Text('No rental requests yet',
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                        const SizedBox(height: 6),
                        Text('Requests from customers who want to rent your\nproducts will show up here.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey.shade500, fontSize: 12.5, height: 1.4)),
                      ],
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: sorted.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, i) {
                    final r = sorted[i];
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
                          Text(r.productName,
                              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                          const SizedBox(height: 4),
                          Text('Requested by ${r.customerName}',
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                          Text(r.duration,
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                          if (r.deliveryAddress.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(r.deliveryAddress,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.grey.shade500, fontSize: 11.5)),
                            ),
                          const SizedBox(height: 4),
                          Text('₹${r.amount.toStringAsFixed(0)} total',
                              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5)),
                          const SizedBox(height: 10),
                          if (r.status == RentalRequestStatus.pending)
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () => LenderService.instance
                                        .respondToRequest(r.id, RentalRequestStatus.rejected),
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(color: Colors.redAccent),
                                    ),
                                    child: const Text('Reject', style: TextStyle(color: Colors.redAccent)),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () => LenderService.instance
                                        .respondToRequest(r.id, RentalRequestStatus.accepted),
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                                    child: const Text('Accept', style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ],
                            )
                          else
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: r.status == RentalRequestStatus.accepted
                                    ? const Color(0xFFEAFBF0)
                                    : const Color(0xFFFEECEC),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                r.status == RentalRequestStatus.accepted ? 'Accepted' : 'Rejected',
                                style: TextStyle(
                                  color: r.status == RentalRequestStatus.accepted
                                      ? const Color(0xFF15803D)
                                      : Colors.redAccent,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}