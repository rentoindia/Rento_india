// import 'package:flutter/material.dart';
// import '../theme/app_theme.dart';
// import '../services/favorites_service.dart';
// import 'product_details_screen.dart';

// class SavedItemsScreen extends StatelessWidget {
//   const SavedItemsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: FavoritesService.instance,
//       builder: (context, _) {
//         final items = FavoritesService.instance.items;

//         return Scaffold(
//           backgroundColor: const Color(0xFFF7F8FA),
//           appBar: AppBar(
//             backgroundColor: const Color(0xFFF7F8FA),
//             elevation: 0,
//             foregroundColor: Colors.black,
//             title: Text(
//               items.isEmpty ? 'Saved Items' : 'Saved Items (${items.length})',
//               style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 17),
//             ),
//           ),
//           body: items.isEmpty ? _buildEmptyState(context) : _buildGrid(context, items),
//         );
//       },
//     );
//   }

//   Widget _buildEmptyState(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(32),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 88,
//               height: 88,
//               decoration: BoxDecoration(color: AppTheme.lightGrey, shape: BoxShape.circle),
//               child: const Icon(Icons.favorite_border, size: 38, color: Colors.black38),
//             ),
//             const SizedBox(height: 18),
//             const Text('No saved items yet', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
//             const SizedBox(height: 8),
//             Text(
//               'Tap the heart icon on any product to save it here for later.',
//               textAlign: TextAlign.center,
//               style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 1.4),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildGrid(BuildContext context, List<SavedProduct> items) {
//     return GridView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: items.length,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         mainAxisSpacing: 14,
//         crossAxisSpacing: 14,
//         childAspectRatio: 0.68,
//       ),
//       itemBuilder: (context, i) => _SavedItemCard(product: items[i]),
//     );
//   }
// }

// class _SavedItemCard extends StatelessWidget {
//   final SavedProduct product;
//   const _SavedItemCard({required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => ProductDetailsScreen(
//             name: product.name,
//             price: product.price,
//             categoryLabel: product.categoryLabel,
//             imageQuery: product.imageQuery,
//             rating: product.rating,
//             reviewCount: product.reviewCount,
//           ),
//         ),
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(color: AppTheme.border),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
//                   child: Image.network(
//                     'https://loremflickr.com/300/240/${product.imageQuery.replaceAll(' ', ',')}?lock=${product.name.hashCode.abs() % 5000}',
//                     height: 110,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                     errorBuilder: (_, __, ___) => Container(
//                       height: 110,
//                       color: AppTheme.lightGrey,
//                       child: const Icon(Icons.image_outlined, color: Colors.black38),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 8,
//                   right: 8,
//                   child: GestureDetector(
//                     onTap: () => FavoritesService.instance.remove(product.name),
//                     child: Container(
//                       padding: const EdgeInsets.all(6),
//                       decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
//                       child: const Icon(Icons.favorite, size: 16, color: Colors.redAccent),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(product.name,
//                       maxLines: 1, overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5)),
//                   const SizedBox(height: 3),
//                   Text(product.categoryLabel, style: TextStyle(color: Colors.grey.shade600, fontSize: 10.5)),
//                   const SizedBox(height: 6),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('${product.price} /day', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
//                       Row(children: [
//                         const Icon(Icons.star, size: 12, color: Colors.amber),
//                         const SizedBox(width: 2),
//                         Text('${product.rating}', style: TextStyle(fontSize: 10.5, color: Colors.grey.shade600)),
//                       ]),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






















// import 'package:flutter/material.dart';
// import '../theme/app_theme.dart';
// import 'package:rento/delivery/core/constants/app_colors.dart';//import '../constants/app_colors.dart';
// import '../constants/app_text_styles.dart';
// import '../services/favorites_service.dart';
// import 'product_details_screen.dart';

// class SavedItemsScreen extends StatelessWidget {
//   const SavedItemsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: FavoritesService.instance,
//       builder: (context, _) {
//         final items = FavoritesService.instance.items;

//         return Scaffold(
//           backgroundColor: AppColors.inputFill,
//           appBar: AppBar(
//             backgroundColor: AppColors.inputFill,
//             elevation: 0,
//             foregroundColor: AppColors.primaryBlack,
//             title: Text(
//               items.isEmpty ? 'Saved Items' : 'Saved Items (${items.length})',
//               style: AppText.titleLg.copyWith(fontSize: 17),
//             ),
//           ),
//           body: items.isEmpty ? _buildEmptyState(context) : _buildGrid(context, items),
//         );
//       },
//     );
//   }

//   Widget _buildEmptyState(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(32),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 88,
//               height: 88,
//               decoration: BoxDecoration(color: AppTheme.lightGrey, shape: BoxShape.circle),
//               child: const Icon(Icons.favorite_border, size: 38, color: AppColors.textHint),
//             ),
//             const SizedBox(height: 18),
//             Text('No saved items yet', style: AppText.displaySm.copyWith(fontWeight: FontWeight.w800, fontSize: 16)),
//             const SizedBox(height: 8),
//             Text(
//               'Tap the heart icon on any product to save it here for later.',
//               textAlign: TextAlign.center,
//               style: AppText.bodySm.copyWith(fontSize: 13, height: 1.4),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildGrid(BuildContext context, List<SavedProduct> items) {
//     return GridView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: items.length,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         mainAxisSpacing: 14,
//         crossAxisSpacing: 14,
//         childAspectRatio: 0.68,
//       ),
//       itemBuilder: (context, i) => _SavedItemCard(product: items[i]),
//     );
//   }
// }

// class _SavedItemCard extends StatelessWidget {
//   final SavedProduct product;
//   const _SavedItemCard({required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => ProductDetailsScreen(
//             name: product.name,
//             price: product.price,
//             categoryLabel: product.categoryLabel,
//             imageQuery: product.imageQuery,
//             rating: product.rating,
//             reviewCount: product.reviewCount,
//           ),
//         ),
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           color: AppColors.pureWhite,
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(color: AppTheme.border),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
//                   child: Image.network(
//                     'https://loremflickr.com/300/240/${product.imageQuery.replaceAll(' ', ',')}?lock=${product.name.hashCode.abs() % 5000}',
//                     height: 110,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                     errorBuilder: (_, __, ___) => Container(
//                       height: 110,
//                       color: AppTheme.lightGrey,
//                       child: const Icon(Icons.image_outlined, color: AppColors.textHint),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 8,
//                   right: 8,
//                   child: GestureDetector(
//                     onTap: () => FavoritesService.instance.remove(product.name),
//                     child: Container(
//                       padding: const EdgeInsets.all(6),
//                       decoration: const BoxDecoration(color: AppColors.pureWhite, shape: BoxShape.circle),
//                       child: const Icon(Icons.favorite, size: 16, color: Colors.redAccent),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(product.name,
//                       maxLines: 1, overflow: TextOverflow.ellipsis,
//                       style: AppText.titleSm.copyWith(fontSize: 12.5)),
//                   const SizedBox(height: 3),
//                   Text(product.categoryLabel, style: AppText.caption.copyWith(fontSize: 10.5)),
//                   const SizedBox(height: 6),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('${product.price} /day', style: AppText.priceMd.copyWith(fontSize: 12)),
//                       Row(children: [
//                         const Icon(Icons.star, size: 12, color: Colors.amber),
//                         const SizedBox(width: 2),
//                         Text('${product.rating}', style: AppText.caption.copyWith(fontSize: 10.5)),
//                       ]),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../services/favorites_service.dart';
import 'product_details_screen.dart';

class SavedItemsScreen extends StatelessWidget {
  const SavedItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: FavoritesService.instance,
      builder: (context, _) {
        final items = FavoritesService.instance.items;

        return Scaffold(
          backgroundColor: AppColors.inputFill,
          appBar: AppBar(
            backgroundColor: AppColors.inputFill,
            elevation: 0,
            foregroundColor: AppColors.primaryBlack,
            title: Text(
              items.isEmpty ? 'Saved Items' : 'Saved Items (${items.length})',
              style: AppText.titleLg.copyWith(fontSize: 17),
            ),
          ),
          body: items.isEmpty ? _buildEmptyState(context) : _buildGrid(context, items),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(color: AppTheme.lightGrey, shape: BoxShape.circle),
              child: const Icon(Icons.favorite_border, size: 38, color: AppColors.textHint),
            ),
            const SizedBox(height: 18),
            Text('No saved items yet', style: AppText.displaySm.copyWith(fontWeight: FontWeight.w800, fontSize: 16)),
            const SizedBox(height: 8),
            Text(
              'Tap the heart icon on any product to save it here for later.',
              textAlign: TextAlign.center,
              style: AppText.bodySm.copyWith(fontSize: 13, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(BuildContext context, List<SavedProduct> items) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.68,
      ),
      itemBuilder: (context, i) => _SavedItemCard(product: items[i]),
    );
  }
}

class _SavedItemCard extends StatelessWidget {
  final SavedProduct product;
  const _SavedItemCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(
            name: product.name,
            price: product.price,
            categoryLabel: product.categoryLabel,
            imageQuery: product.imageQuery,
            rating: product.rating,
            reviewCount: product.reviewCount,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppTheme.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                  child: Image.network(
                    'https://loremflickr.com/300/240/${product.imageQuery.replaceAll(' ', ',')}?lock=${product.name.hashCode.abs() % 5000}',
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 110,
                      color: AppTheme.lightGrey,
                      child: const Icon(Icons.image_outlined, color: AppColors.textHint),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => FavoritesService.instance.remove(product.name),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(color: AppColors.pureWhite, shape: BoxShape.circle),
                      child: const Icon(Icons.favorite, size: 16, color: Colors.redAccent),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: AppText.titleSm.copyWith(fontSize: 12.5)),
                  const SizedBox(height: 3),
                  Text(product.categoryLabel, style: AppText.caption.copyWith(fontSize: 10.5)),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${product.price} /day', style: AppText.priceMd.copyWith(fontSize: 12)),
                      Row(children: [
                        const Icon(Icons.star, size: 12, color: Colors.amber),
                        const SizedBox(width: 2),
                        Text('${product.rating}', style: AppText.caption.copyWith(fontSize: 10.5)),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}