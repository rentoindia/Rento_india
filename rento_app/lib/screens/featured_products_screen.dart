// import 'package:flutter/material.dart';
// import 'product_details_screen.dart';

// class FeaturedProductsScreen extends StatelessWidget {
//   const FeaturedProductsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final products = [
//       {'name': 'Canon DSLR 1200D', 'price': '₹599','image': 'assets/images/camera.jpg', 'icon': Icons.camera_alt_outlined},
//       {'name': 'Nordic 3-Seater Sofa', 'price': '₹299', 'icon': Icons.weekend_outlined},
//       {'name': 'Honda Activa 6G', 'price': '₹449', 'icon': Icons.two_wheeler_outlined},
//       {'name': 'MacBook Pro', 'price': '₹1499', 'icon': Icons.laptop_mac},
//     ];
//     return Scaffold(
//       appBar: AppBar(title: const Text('Featured Products')),
//       body: GridView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: products.length,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 12,
//           crossAxisSpacing: 12,
//           childAspectRatio: 0.85,
//         ),
//         itemBuilder: (context, i) {
//           final p = products[i];
//           return GestureDetector(
//             onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => ProductDetailsScreen(name: p['name'] as String, price: p['price'] as String),
//               ),
//             ),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(14),
//                 border: Border.all(color: const Color(0xFFF0F0F0)),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: 110,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFF3F4F6),
//                       borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
//                     ),
//                     child: Icon(p['icon'] as IconData, size: 40, color: Colors.black45),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(p['name'] as String,
//                             maxLines: 1, overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
//                         Text('${p['price']} /day',
//                             style: const TextStyle(fontWeight: FontWeight.w700)),
//                       ],
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
// }

import 'package:flutter/material.dart';
import 'product_details_screen.dart';

class FeaturedProductsScreen extends StatelessWidget {
  const FeaturedProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {'name': 'Canon DSLR 1200D', 'price': '₹599', 'icon': Icons.camera_alt_outlined},
      {'name': 'Nordic 3-Seater Sofa', 'price': '₹299', 'icon': Icons.weekend_outlined},
      {'name': 'Honda Activa 6G', 'price': '₹449', 'icon': Icons.two_wheeler_outlined},
      {'name': 'MacBook Pro', 'price': '₹1499', 'icon': Icons.laptop_mac},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Featured Products')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (context, i) {
          final p = products[i];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailsScreen(name: p['name'] as String, price: p['price'] as String),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFF0F0F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 110,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                    ),
                    child: Icon(p['icon'] as IconData, size: 40, color: Colors.black45),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p['name'] as String,
                            maxLines: 1, overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                        Text('${p['price']} /day',
                            style: const TextStyle(fontWeight: FontWeight.w700)),
                      ],
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
}