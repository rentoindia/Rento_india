// import 'package:flutter/material.dart';

// class OffersScreen extends StatelessWidget {
//   const OffersScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final offers = [
//       {'title': 'First Rental FREE!', 'desc': 'Use code RENTO1ST', 'code': 'RENTO1ST'},
//       {'title': '20% Off Electronics', 'desc': 'On all electronics rentals', 'code': 'ELEC20'},
//       {'title': 'Weekend Special', 'desc': 'Flat ₹100 off on weekend bookings', 'code': 'WEEKEND100'},
//     ];
//     return Scaffold(
//       appBar: AppBar(title: const Text('Offers')),
//       body: ListView.separated(
//         padding: const EdgeInsets.all(16),
//         itemCount: offers.length,
//         separatorBuilder: (_, __) => const SizedBox(height: 12),
//         itemBuilder: (context, i) {
//           final o = offers[i];
//           return Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.circular(14),
//             ),
//             child: Row(
//               children: [
//                 const Icon(Icons.local_offer, color: Colors.white, size: 30),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(o['title']!,
//                           style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
//                       Text(o['desc']!, style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                   decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
//                   child: Text(o['code']!, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11)),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final offers = [
      {'title': 'First Rental FREE!', 'desc': 'Use code RENTO1ST', 'code': 'RENTO1ST'},
      {'title': '20% Off Electronics', 'desc': 'On all electronics rentals', 'code': 'ELEC20'},
      {'title': 'Weekend Special', 'desc': 'Flat ₹100 off on weekend bookings', 'code': 'WEEKEND100'},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Offers')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: offers.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final o = offers[i];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(Icons.local_offer, color: Colors.white, size: 30),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(o['title']!,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                      Text(o['desc']!, style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: Text(o['code']!, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}