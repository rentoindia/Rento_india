// // import '../delivery/core/constants/app_colors.dart';
// // import 'package:flutter/material.dart';
// // import 'category_detail_screen.dart';
// // import 'category_data.dart';
// // import '../services/notification_service.dart';
// // //import '../constants/app_colors.dart';
// // import '../constants/app_text_styles.dart';
// // import '../widgets/promo_banner.dart';
// // import 'offers_screen.dart';
// // import 'cart_screen.dart';
// // import 'notification_screen.dart';
// // import '../services/cart_service.dart';

// // class CategoryScreen extends StatefulWidget {
// //   const CategoryScreen({super.key, this.categoryName});

// //   final String? categoryName;

// //   @override
// //   State<CategoryScreen> createState() => _CategoryScreenState();
// // }

// // class _CategoryScreenState extends State<CategoryScreen> {
// //   final TextEditingController _searchController = TextEditingController();
// //   String _searchQuery = '';

// //   final List<Map<String, dynamic>> _categories = allCategoriesList;

// //   List<Map<String, dynamic>> get _filteredCategories {
// //     if (_searchQuery.trim().isEmpty) return _categories;
// //     final q = _searchQuery.trim().toLowerCase();
// //     return _categories.where((c) => (c['name'] as String).toLowerCase().contains(q)).toList();
// //   }

// //   @override
// //   void dispose() {
// //     _searchController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: AppColors.inputFill,
// //       body: SafeArea(
// //         child: ListView(
// //           padding: const EdgeInsets.all(16),
// //           children: [
// //             _buildHeader(context),
// //             const SizedBox(height: 22),
// //             Text('Browse Categories', style: AppText.displayLg),
// //             const SizedBox(height: 4),
// //             Text('Find what you need', style: AppText.bodySm),
// //             const SizedBox(height: 18),
// //             _buildSearchBar(),
// //             const SizedBox(height: 18),

// //             // ---- PROMO BANNER: top of category listing page ----
// //             PromoBanner(
// //               style: PromoBannerStyle.card,
// //               icon: Icons.local_fire_department_outlined,
// //               title: 'Seasonal Sale Live',
// //               subtitle: 'Up to 30% off across select categories this week.',
// //               ctaLabel: 'VIEW OFFERS',
// //               onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OffersScreen())),
// //             ),
// //             const SizedBox(height: 18),

// //             if (_filteredCategories.isEmpty)
// //               Padding(
// //                 padding: const EdgeInsets.symmetric(vertical: 30),
// //                 child: Center(
// //                   child: Text('No categories found.', style: AppText.bodySm.copyWith(color: AppColors.textHint)),
// //                 ),
// //               )
// //             else
// //               _buildCategoriesGrid(),
// //             const SizedBox(height: 18),
// //             GestureDetector(
// //               onTap: () => Navigator.push(
// //                 context,
// //                 MaterialPageRoute(builder: (_) => const OffersScreen()),
// //               ),
// //               child: _buildPromoBanner(),
// //             ),
// //             const SizedBox(height: 12),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildHeader(BuildContext context) {
// //     return Row(
// //       children: [
// //         GestureDetector(
// //           onTap: () => Navigator.pop(context),
// //           child: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.primaryBlack),
// //         ),
// //         const SizedBox(width: 12),
// //         Expanded(
// //           child: Row(
// //             children: [
// //               const Icon(Icons.location_on_outlined, size: 20, color: AppColors.primaryBlack),
// //               const SizedBox(width: 6),
// //               Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Row(
// //                     children: [
// //                       Text('Mumbai, 400001', style: AppText.titleMd),
// //                       const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.primaryBlack),
// //                     ],
// //                   ),
// //                   Text('Deliver to your location', style: AppText.caption.copyWith(fontSize: 10.5)),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ),
// //         AnimatedBuilder(
// //           animation: CartService.instance,
// //           builder: (context, _) => GestureDetector(
// //             onTap: () => Navigator.push(
// //               context,
// //               MaterialPageRoute(builder: (_) => const CartScreen()),
// //             ),
// //             child: _iconWithBadge(Icons.shopping_cart_outlined, CartService.instance.unseenCount),
// //           ),
// //         ),
// //         const SizedBox(width: 16),
// //         AnimatedBuilder(
// //           animation: NotificationService.instance,
// //           builder: (context, _) => GestureDetector(
// //             onTap: () => Navigator.push(
// //               context,
// //               MaterialPageRoute(builder: (_) => const NotificationScreen()),
// //             ),
// //             child: _iconWithBadge(Icons.notifications_none_rounded, NotificationService.instance.unreadCount),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _iconWithBadge(IconData icon, int count) {
// //     return Stack(
// //       clipBehavior: Clip.none,
// //       children: [
// //         Icon(icon, size: 24, color: AppColors.primaryBlack),
// //         if (count > 0)
// //           Positioned(
// //             top: -4,
// //             right: -6,
// //             child: Container(
// //               padding: const EdgeInsets.all(3),
// //               decoration: const BoxDecoration(color: AppColors.accentLime, shape: BoxShape.circle),
// //               constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
// //               child: Text('$count',
// //                   textAlign: TextAlign.center,
// //                   style: AppText.caption.copyWith(color: AppColors.primaryBlack, fontSize: 9, fontWeight: FontWeight.bold)),
// //             ),
// //           ),
// //       ],
// //     );
// //   }

// //   Widget _buildSearchBar() {
// //     return Container(
// //       height: 52,
// //       padding: const EdgeInsets.symmetric(horizontal: 14),
// //       decoration: BoxDecoration(
// //         color: AppColors.pureWhite,
// //         borderRadius: BorderRadius.circular(14),
// //         border: Border.all(color: AppColors.border),
// //       ),
// //       child: Row(
// //         children: [
// //           Icon(Icons.search, color: AppColors.textHint, size: 20),
// //           const SizedBox(width: 8),
// //           Expanded(
// //             child: TextField(
// //               controller: _searchController,
// //               onChanged: (value) => setState(() => _searchQuery = value),
// //               style: AppText.bodyMd,
// //               decoration: InputDecoration(
// //                 hintText: 'Search for products or services',
// //                 hintStyle: AppText.bodyMd.copyWith(color: AppColors.textHint),
// //                 border: InputBorder.none,
// //                 isDense: true,
// //               ),
// //             ),
// //           ),
// //           if (_searchQuery.isNotEmpty)
// //             GestureDetector(
// //               onTap: () {
// //                 _searchController.clear();
// //                 setState(() => _searchQuery = '');
// //               },
// //               child: const Icon(Icons.close, size: 18, color: AppColors.textSecondary),
// //             ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildCategoriesGrid() {
// //     final categories = _filteredCategories;
// //     return GridView.builder(
// //       shrinkWrap: true,
// //       physics: const NeverScrollableScrollPhysics(),
// //       itemCount: categories.length,
// //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //         crossAxisCount: 2,
// //         mainAxisSpacing: 14,
// //         crossAxisSpacing: 14,
// //         childAspectRatio: 0.92,
// //       ),
// //       itemBuilder: (context, i) {
// //         final c = categories[i];
// //         return GestureDetector(
// //           onTap: () => Navigator.push(
// //             context,
// //             MaterialPageRoute(builder: (_) => CategoryDetailScreen(categoryName: c['name'])),
// //           ),
// //           child: Container(
// //             decoration: BoxDecoration(
// //               color: AppColors.pureWhite,
// //               borderRadius: BorderRadius.circular(16),
// //               border: Border.all(color: AppColors.border),
// //             ),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Expanded(
// //                   child: ClipRRect(
// //                     borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
// //                     child: Image.network(
// //                       c['image'],
// //                       width: double.infinity,
// //                       fit: BoxFit.cover,
// //                       errorBuilder: (_, __, ___) => Container(
// //                         color: AppColors.inputFill,
// //                         child: const Icon(Icons.image_outlined, color: AppColors.textHint, size: 32),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //                 Padding(
// //                   padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(c['name'], maxLines: 2, overflow: TextOverflow.ellipsis, style: AppText.titleSm),
// //                       const SizedBox(height: 2),
// //                       Text('${getCategoryData(c['name']).resultsCount} items', style: AppText.caption.copyWith(fontSize: 11)),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   Widget _buildPromoBanner() {
// //     return Container(
// //       width: double.infinity,
// //       height: 150,
// //       clipBehavior: Clip.antiAlias,
// //       decoration: BoxDecoration(
// //         color: AppColors.divider,
// //         borderRadius: BorderRadius.circular(16),
// //       ),
// //       child: Stack(
// //         children: [
// //           Positioned(
// //             right: -10,
// //             bottom: -10,
// //             child: Image.network(
// //               'https://picsum.photos/seed/furniturepromo/260/200',
// //               width: 260,
// //               height: 150,
// //               fit: BoxFit.cover,
// //               errorBuilder: (_, __, ___) => const SizedBox.shrink(),
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.all(18),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 RichText(
// //                   text: TextSpan(
// //                     style: AppText.bodyLg.copyWith(fontSize: 15),
// //                     children: [
// //                       const TextSpan(text: 'Up to '),
// //                       TextSpan(text: '30% OFF', style: AppText.titleLg.copyWith(fontSize: 15)),
// //                       const TextSpan(text: ' on\n'),
// //                       TextSpan(text: 'Furniture Rentals', style: AppText.titleLg),
// //                     ],
// //                   ),
// //                 ),
// //                 Container(
// //                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
// //                   decoration: BoxDecoration(color: AppColors.primaryBlack, borderRadius: BorderRadius.circular(20)),
// //                   child: Text('EXPLORE NOW', style: AppText.buttonSm),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Positioned(
// //             bottom: 10,
// //             left: 0,
// //             right: 0,
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: List.generate(3, (i) {
// //                 return Container(
// //                   margin: const EdgeInsets.symmetric(horizontal: 3),
// //                   width: 6,
// //                   height: 6,
// //                   decoration: BoxDecoration(
// //                     shape: BoxShape.circle,
// //                     color: i == 0 ? AppColors.primaryBlack : AppColors.primaryBlack.withOpacity(0.2),
// //                   ),
// //                 );
// //               }),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'category_detail_screen.dart';
// import 'category_data.dart';
// import '../services/notification_service.dart';
// import '../constants/app_colors.dart';
// import '../constants/app_text_styles.dart';
// import '../widgets/promo_banner.dart';
// import 'offers_screen.dart';
// import 'package:flutter/material.dart';
// import 'cart_screen.dart';
// import 'notification_screen.dart';
// import '../services/cart_service.dart';
// import '../services/location_service.dart';

// class CategoryScreen extends StatefulWidget {
//   const CategoryScreen({super.key, this.categoryName});

//   final String? categoryName;

//   @override
//   State<CategoryScreen> createState() => _CategoryScreenState();
// }

// class _CategoryScreenState extends State<CategoryScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';

//   final List<Map<String, dynamic>> _categories = allCategoriesList;

//   List<Map<String, dynamic>> get _filteredCategories {
//     if (_searchQuery.trim().isEmpty) return _categories;
//     final q = _searchQuery.trim().toLowerCase();
//     return _categories.where((c) => (c['name'] as String).toLowerCase().contains(q)).toList();
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.inputFill,
//       body: SafeArea(
//         child: ListView(
//           padding: const EdgeInsets.all(16),
//           children: [
//             _buildHeader(context),
//             const SizedBox(height: 22),
//             Text('Browse Categories', style: AppText.displayLg),
//             const SizedBox(height: 4),
//             Text('Find what you need', style: AppText.bodySm),
//             const SizedBox(height: 18),
//             _buildSearchBar(),
//             const SizedBox(height: 18),

//             // ---- PROMO BANNER: top of category listing page ----
//             PromoBanner(
//               style: PromoBannerStyle.card,
//               icon: Icons.local_fire_department_outlined,
//               title: 'Seasonal Sale Live',
//               subtitle: 'Up to 30% off across select categories this week.',
//               ctaLabel: 'VIEW OFFERS',
//               onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OffersScreen())),
//             ),
//             const SizedBox(height: 18),

//             if (_filteredCategories.isEmpty)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 30),
//                 child: Center(
//                   child: Text('No categories found.', style: AppText.bodySm.copyWith(color: AppColors.textHint)),
//                 ),
//               )
//             else
//               _buildCategoriesGrid(),
//             const SizedBox(height: 18),
//             GestureDetector(
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const OffersScreen()),
//               ),
//               child: _buildPromoBanner(),
//             ),
//             const SizedBox(height: 12),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     return Row(
//       children: [
//         GestureDetector(
//           onTap: () => Navigator.pop(context),
//           child: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.primaryBlack),
//         ),
//         const SizedBox(width: 12),
//         // Expanded(
//         //   child: Row(
//         //     children: [
//         //       const Icon(Icons.location_on_outlined, size: 20, color: AppColors.primaryBlack),
//         //       const SizedBox(width: 6),
//         //       Column(
//         //         crossAxisAlignment: CrossAxisAlignment.start,
//         //         children: [
//         //           Row(
//         //             children: [
//         //               Text('Mumbai, 400001', style: AppText.titleMd),
//         //               const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.primaryBlack),
//         //             ],
//         //           ),
//         //           Text('Deliver to your location', style: AppText.caption.copyWith(fontSize: 10.5)),
//         //         ],
//         //       ),
//         //     ],
//         //   ),
//         // ),

//         Expanded(
//   child: AnimatedBuilder(
//     animation: LocationService.instance,
//     builder: (context, _) {
//       final loc = LocationService.instance;
//       return GestureDetector(
//         onTap: () => LocationService.instance.fetchCurrentLocation(),
//         child: Row(
//           children: [
//             const Icon(Icons.location_on_outlined, size: 20, color: AppColors.primaryBlack),
//             const SizedBox(width: 6),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           loc.isLoading ? 'Fetching your location...' : loc.address,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: AppText.titleMd,
//                         ),
//                       ),
//                       const Icon(Icons.my_location, size: 15, color: AppColors.primaryBlack),
//                     ],
//                   ),
//                   Text('Deliver to your location', style: AppText.caption.copyWith(fontSize: 10.5)),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   ),
// ),
//         AnimatedBuilder(
//           animation: CartService.instance,
//           builder: (context, _) => GestureDetector(
//             onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const CartScreen()),
//             ),
//             child: _iconWithBadge(Icons.shopping_cart_outlined, CartService.instance.unseenCount),
//           ),
//         ),
//         const SizedBox(width: 16),
//         AnimatedBuilder(
//           animation: NotificationService.instance,
//           builder: (context, _) => GestureDetector(
//             onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const NotificationScreen()),
//             ),
//             child: _iconWithBadge(Icons.notifications_none_rounded, NotificationService.instance.unreadCount),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _iconWithBadge(IconData icon, int count) {
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         Icon(icon, size: 24, color: AppColors.primaryBlack),
//         if (count > 0)
//           Positioned(
//             top: -4,
//             right: -6,
//             child: Container(
//               padding: const EdgeInsets.all(3),
//               decoration: const BoxDecoration(color: AppColors.accentLime, shape: BoxShape.circle),
//               constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
//               child: Text('$count',
//                   textAlign: TextAlign.center,
//                   style: AppText.caption.copyWith(color: AppColors.primaryBlack, fontSize: 9, fontWeight: FontWeight.bold)),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildSearchBar() {
//     return Container(
//       height: 52,
//       padding: const EdgeInsets.symmetric(horizontal: 14),
//       decoration: BoxDecoration(
//         color: AppColors.pureWhite,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: AppColors.border),
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.search, color: AppColors.textHint, size: 20),
//           const SizedBox(width: 8),
//           Expanded(
//             child: TextField(
//               controller: _searchController,
//               onChanged: (value) => setState(() => _searchQuery = value),
//               style: AppText.bodyMd,
//               decoration: InputDecoration(
//                 hintText: 'Search for products or services',
//                 hintStyle: AppText.bodyMd.copyWith(color: AppColors.textHint),
//                 border: InputBorder.none,
//                 isDense: true,
//               ),
//             ),
//           ),
//           if (_searchQuery.isNotEmpty)
//             GestureDetector(
//               onTap: () {
//                 _searchController.clear();
//                 setState(() => _searchQuery = '');
//               },
//               child: const Icon(Icons.close, size: 18, color: AppColors.textSecondary),
//             ),
//         ],
//       ),
//     );
//   }

//   // Widget _buildCategoriesGrid() {
//   //   final categories = _filteredCategories;
//   //   return GridView.builder(
//   //     shrinkWrap: true,
//   //     physics: const NeverScrollableScrollPhysics(),
//   //     itemCount: categories.length,
//   //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//   //       crossAxisCount: 2,
//   //       mainAxisSpacing: 14,
//   //       crossAxisSpacing: 14,
//   //       childAspectRatio: 0.92,
//   //     ),
//   //     itemBuilder: (context, i) {
//   //       final c = categories[i];
//   //       return GestureDetector(
//   //         onTap: () => Navigator.push(
//   //           context,
//   //           MaterialPageRoute(builder: (_) => CategoryDetailScreen(categoryName: c['name'])),
//   //         ),
//   //         child: Container(
//   //           decoration: BoxDecoration(
//   //             color: AppColors.pureWhite,
//   //             borderRadius: BorderRadius.circular(16),
//   //             border: Border.all(color: AppColors.border),
//   //           ),
//   //           child: Column(
//   //             crossAxisAlignment: CrossAxisAlignment.start,
//   //             children: [
//   //               Expanded(
//   //                 child: ClipRRect(
//   //                   borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
//   //                   child: Image.network(
//   //                     c['image'],
//   //                     width: double.infinity,
//   //                     fit: BoxFit.cover,
//   //                     errorBuilder: (_, __, ___) => Container(
//   //                       color: AppColors.inputFill,
//   //                       child: const Icon(Icons.image_outlined, color: AppColors.textHint, size: 32),
//   //                     ),
//   //                   ),
//   //                 ),
//   //               ),
//   //               Padding(
//   //                 padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
//   //                 child: Column(
//   //                   crossAxisAlignment: CrossAxisAlignment.start,
//   //                   children: [
//   //                     Text(c['name'], maxLines: 2, overflow: TextOverflow.ellipsis, style: AppText.titleSm),
//   //                     const SizedBox(height: 2),
//   //                     Text('${getCategoryData(c['name']).resultsCount} items', style: AppText.caption.copyWith(fontSize: 11)),
//   //                   ],
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }

// Widget _buildCategoriesGrid() {
//     final categories = _filteredCategories;
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: categories.length,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         mainAxisSpacing: 12,
//         crossAxisSpacing: 12,
//         childAspectRatio: 0.82,   // taller card — enough room for 2-line titles
//       ),
//       itemBuilder: (context, i) {
//         final c = categories[i];
//         return GestureDetector(
//           onTap: () => Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) => CategoryDetailScreen(categoryName: c['name'])),
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//               color: AppColors.pureWhite,
//               borderRadius: BorderRadius.circular(14),
//               border: Border.all(color: AppColors.border),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Fixed height instead of Expanded — smaller, predictable
//                 // image area instead of stretching to fill the card.
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
//                   child: categoryImage(
//                     c['image'],
//                     height: 90,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(10, 7, 10, 9),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(c['name'],
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: AppText.titleSm.copyWith(fontSize: 11.5)),
//                       const SizedBox(height: 1),
//                       Text('${getCategoryData(c['name']).resultsCount} items',
//                           style: AppText.caption.copyWith(fontSize: 9.5)),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }



//   // Widget _buildCategoriesGrid() {
//   //   final categories = _filteredCategories;
//   //   return GridView.builder(
//   //     shrinkWrap: true,
//   //     physics: const NeverScrollableScrollPhysics(),
//   //     itemCount: categories.length,
//   //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//   //       crossAxisCount: 2,
//   //       mainAxisSpacing: 12,
//   //       crossAxisSpacing: 12,
//   //       childAspectRatio: 1.15,   // was 0.92 — higher value = shorter card
//   //     ),
//   //     itemBuilder: (context, i) {
//   //       final c = categories[i];
//   //       return GestureDetector(
//   //         onTap: () => Navigator.push(
//   //           context,
//   //           MaterialPageRoute(builder: (_) => CategoryDetailScreen(categoryName: c['name'])),
//   //         ),
//   //         child: Container(
//   //           decoration: BoxDecoration(
//   //             color: AppColors.pureWhite,
//   //             borderRadius: BorderRadius.circular(14),
//   //             border: Border.all(color: AppColors.border),
//   //           ),
//   //           child: Column(
//   //             crossAxisAlignment: CrossAxisAlignment.start,
//   //             children: [
//   //               // Fixed height instead of Expanded — smaller, predictable
//   //               // image area instead of stretching to fill the card.
//   //               ClipRRect(
//   //                 borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
//   //                 child: categoryImage(
//   //                   c['image'],
//   //                   height: 70,
//   //                   width: double.infinity,
//   //                   fit: BoxFit.cover,
//   //                 ),
//   //               ),
//   //               Padding(
//   //                 padding: const EdgeInsets.fromLTRB(10, 7, 10, 9),
//   //                 child: Column(
//   //                   crossAxisAlignment: CrossAxisAlignment.start,
//   //                   children: [
//   //                     Text(c['name'],
//   //                         maxLines: 2,
//   //                         overflow: TextOverflow.ellipsis,
//   //                         style: AppText.titleSm.copyWith(fontSize: 11.5)),
//   //                     const SizedBox(height: 1),
//   //                     Text('${getCategoryData(c['name']).resultsCount} items',
//   //                         style: AppText.caption.copyWith(fontSize: 9.5)),
//   //                   ],
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }

//   Widget _buildPromoBanner() {
//     return Container(
//       width: double.infinity,
//       height: 150,
//       clipBehavior: Clip.antiAlias,
//       decoration: BoxDecoration(
//         color: AppColors.divider,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Stack(
//         children: [
//           Positioned(
//             right: -10,
//             bottom: -10,
//             child: Image.network(
//               'https://picsum.photos/seed/furniturepromo/260/200',
//               width: 260,
//               height: 150,
//               fit: BoxFit.cover,
//               errorBuilder: (_, __, ___) => const SizedBox.shrink(),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(18),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 RichText(
//                   text: TextSpan(
//                     style: AppText.bodyLg.copyWith(fontSize: 15),
//                     children: [
//                       const TextSpan(text: 'Up to '),
//                       TextSpan(text: '30% OFF', style: AppText.titleLg.copyWith(fontSize: 15)),
//                       const TextSpan(text: ' on\n'),
//                       TextSpan(text: 'Furniture Rentals', style: AppText.titleLg),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                   decoration: BoxDecoration(color: AppColors.primaryBlack, borderRadius: BorderRadius.circular(20)),
//                   child: Text('EXPLORE NOW', style: AppText.buttonSm),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 10,
//             left: 0,
//             right: 0,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(3, (i) {
//                 return Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 3),
//                   width: 6,
//                   height: 6,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: i == 0 ? AppColors.primaryBlack : AppColors.primaryBlack.withOpacity(0.2),
//                   ),
//                 );
//               }),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

















// // import 'package:flutter/material.dart';
// // import 'category_detail_screen.dart';
// // import 'category_data.dart';
// // import '../services/notification_service.dart';
// // import '../constants/app_colors.dart';
// // import '../constants/app_text_styles.dart';
// // import '../widgets/promo_banner.dart';
// // import 'offers_screen.dart';
// // import 'cart_screen.dart';
// // import 'notification_screen.dart';
// // import '../services/cart_service.dart';
// //import '../services/location_service.dart';

// // class CategoryScreen extends StatefulWidget {
// //   const CategoryScreen({super.key, this.categoryName});

// //   final String? categoryName;

// //   @override
// //   State<CategoryScreen> createState() => _CategoryScreenState();
// // }

// // class _CategoryScreenState extends State<CategoryScreen> {
// //   final TextEditingController _searchController = TextEditingController();
// //   String _searchQuery = '';

// //   final List<Map<String, dynamic>> _categories = allCategoriesList;

// //   List<Map<String, dynamic>> get _filteredCategories {
// //     if (_searchQuery.trim().isEmpty) return _categories;
// //     final q = _searchQuery.trim().toLowerCase();
// //     return _categories.where((c) => (c['name'] as String).toLowerCase().contains(q)).toList();
// //   }

// //   @override
// //   void dispose() {
// //     _searchController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: AppColors.inputFill,
// //       body: SafeArea(
// //         child: ListView(
// //           padding: const EdgeInsets.all(16),
// //           children: [
// //             _buildHeader(context),
// //             const SizedBox(height: 22),
// //             Text('Browse Categories', style: AppText.displayLg),
// //             const SizedBox(height: 4),
// //             Text('Find what you need', style: AppText.bodySm),
// //             const SizedBox(height: 18),
// //             _buildSearchBar(),
// //             const SizedBox(height: 18),

// //             // ---- PROMO BANNER: top of category listing page ----
// //             PromoBanner(
// //               style: PromoBannerStyle.card,
// //               icon: Icons.local_fire_department_outlined,
// //               title: 'Seasonal Sale Live',
// //               subtitle: 'Up to 30% off across select categories this week.',
// //               ctaLabel: 'VIEW OFFERS',
// //               onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OffersScreen())),
// //             ),
// //             const SizedBox(height: 18),

// //             if (_filteredCategories.isEmpty)
// //               Padding(
// //                 padding: const EdgeInsets.symmetric(vertical: 30),
// //                 child: Center(
// //                   child: Text('No categories found.', style: AppText.bodySm.copyWith(color: AppColors.textHint)),
// //                 ),
// //               )
// //             else
// //               _buildCategoriesGrid(),
// //             const SizedBox(height: 18),
// //             GestureDetector(
// //               onTap: () => Navigator.push(
// //                 context,
// //                 MaterialPageRoute(builder: (_) => const OffersScreen()),
// //               ),
// //               child: _buildPromoBanner(),
// //             ),
// //             const SizedBox(height: 12),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildHeader(BuildContext context) {
// //     return Row(
// //       children: [
// //         GestureDetector(
// //           onTap: () => Navigator.pop(context),
// //           child: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.primaryBlack),
// //         ),
// //         const SizedBox(width: 12),
//         // Expanded(
//         //   child: Row(
//         //     children: [
//         //       const Icon(Icons.location_on_outlined, size: 20, color: AppColors.primaryBlack),
//         //       const SizedBox(width: 6),
//         //       Column(
//         //         crossAxisAlignment: CrossAxisAlignment.start,
//         //         children: [
//         //           Row(
//         //             children: [
//         //               Text('Mumbai, 400001', style: AppText.titleMd),
//         //               const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.primaryBlack),
//         //             ],
//         //           ),
//         //           Text('Deliver to your location', style: AppText.caption.copyWith(fontSize: 10.5)),
//         //         ],
//         //       ),
//         //     ],
//         //   ),
//         // ),


// //         Expanded(
// //   child: AnimatedBuilder(
// //     animation: LocationService.instance,
// //     builder: (context, _) {
// //       final loc = LocationService.instance;
// //       return GestureDetector(
// //         onTap: () => LocationService.instance.fetchCurrentLocation(),
// //         child: Row(
// //           children: [
// //             const Icon(Icons.location_on_outlined, size: 20, color: AppColors.primaryBlack),
// //             const SizedBox(width: 6),
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Row(
// //                     children: [
// //                       Expanded(
// //                         child: Text(
// //                           loc.isLoading ? 'Fetching your location...' : loc.address,
// //                           maxLines: 1,
// //                           overflow: TextOverflow.ellipsis,
// //                           style: AppText.titleMd,
// //                         ),
// //                       ),
// //                       const Icon(Icons.my_location, size: 15, color: AppColors.primaryBlack),
// //                     ],
// //                   ),
// //                   Text('Deliver to your location', style: AppText.caption.copyWith(fontSize: 10.5)),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       );
// //     },
// //   ),
// // ),
// //         AnimatedBuilder(
// //           animation: CartService.instance,
// //           builder: (context, _) => GestureDetector(
// //             onTap: () => Navigator.push(
// //               context,
// //               MaterialPageRoute(builder: (_) => const CartScreen()),
// //             ),
// //             child: _iconWithBadge(Icons.shopping_cart_outlined, CartService.instance.unseenCount),
// //           ),
// //         ),
// //         const SizedBox(width: 16),
// //         AnimatedBuilder(
// //           animation: NotificationService.instance,
// //           builder: (context, _) => GestureDetector(
// //             onTap: () => Navigator.push(
// //               context,
// //               MaterialPageRoute(builder: (_) => const NotificationScreen()),
// //             ),
// //             child: _iconWithBadge(Icons.notifications_none_rounded, NotificationService.instance.unreadCount),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _iconWithBadge(IconData icon, int count) {
// //     return Stack(
// //       clipBehavior: Clip.none,
// //       children: [
// //         Icon(icon, size: 24, color: AppColors.primaryBlack),
// //         if (count > 0)
// //           Positioned(
// //             top: -4,
// //             right: -6,
// //             child: Container(
// //               padding: const EdgeInsets.all(3),
// //               decoration: const BoxDecoration(color: AppColors.accentLime, shape: BoxShape.circle),
// //               constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
// //               child: Text('$count',
// //                   textAlign: TextAlign.center,
// //                   style: AppText.caption.copyWith(color: AppColors.primaryBlack, fontSize: 9, fontWeight: FontWeight.bold)),
// //             ),
// //           ),
// //       ],
// //     );
// //   }

// //   Widget _buildSearchBar() {
// //     return Container(
// //       height: 52,
// //       padding: const EdgeInsets.symmetric(horizontal: 14),
// //       decoration: BoxDecoration(
// //         color: AppColors.pureWhite,
// //         borderRadius: BorderRadius.circular(14),
// //         border: Border.all(color: AppColors.border),
// //       ),
// //       child: Row(
// //         children: [
// //           Icon(Icons.search, color: AppColors.textHint, size: 20),
// //           const SizedBox(width: 8),
// //           Expanded(
// //             child: TextField(
// //               controller: _searchController,
// //               onChanged: (value) => setState(() => _searchQuery = value),
// //               style: AppText.bodyMd,
// //               decoration: InputDecoration(
// //                 hintText: 'Search for products or services',
// //                 hintStyle: AppText.bodyMd.copyWith(color: AppColors.textHint),
// //                 border: InputBorder.none,
// //                 isDense: true,
// //               ),
// //             ),
// //           ),
// //           if (_searchQuery.isNotEmpty)
// //             GestureDetector(
// //               onTap: () {
// //                 _searchController.clear();
// //                 setState(() => _searchQuery = '');
// //               },
// //               child: const Icon(Icons.close, size: 18, color: AppColors.textSecondary),
// //             ),
// //         ],
// //       ),
// //     );
// //   }

// //   // ---------- CATEGORIES GRID ----------
// //   // FIX: was a squarish bordered card with a rounded-top-corner image
// //   // filling the whole cell. Changed to a circular image (ClipOval) with
// //   // the label centered underneath — a real photo in a circle, not an
// //   // icon — per request.
// //   Widget _buildCategoriesGrid() {
// //     final categories = _filteredCategories;
// //     return GridView.builder(
// //       shrinkWrap: true,
// //       physics: const NeverScrollableScrollPhysics(),
// //       itemCount: categories.length,
// //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //         crossAxisCount: 2,
// //         mainAxisSpacing: 18,
// //         crossAxisSpacing: 14,
// //         childAspectRatio: 0.95,
// //       ),
// //       itemBuilder: (context, i) {
// //         final c = categories[i];
// //         return GestureDetector(
// //           onTap: () => Navigator.push(
// //             context,
// //             MaterialPageRoute(builder: (_) => CategoryDetailScreen(categoryName: c['name'])),
// //           ),
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               ClipOval(
// //                 child: Image.network(
// //                   c['image'],
// //                   width: 96,
// //                   height: 96,
// //                   fit: BoxFit.cover,
// //                   errorBuilder: (_, __, ___) => Container(
// //                     width: 96,
// //                     height: 96,
// //                     color: AppColors.inputFill,
// //                     child: const Icon(Icons.image_outlined, color: AppColors.textHint, size: 28),
// //                   ),
// //                   loadingBuilder: (context, child, progress) {
// //                     if (progress == null) return child;
// //                     return Container(
// //                       width: 96,
// //                       height: 96,
// //                       color: AppColors.inputFill,
// //                       child: const Center(
// //                         child: SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)),
// //                       ),
// //                     );
// //                   },
// //                 ),
// //               ),
// //               const SizedBox(height: 10),
// //               Text(
// //                 c['name'],
// //                 textAlign: TextAlign.center,
// //                 maxLines: 2,
// //                 overflow: TextOverflow.ellipsis,
// //                 style: AppText.titleSm,
// //               ),
// //               const SizedBox(height: 2),
// //               Text('${getCategoryData(c['name']).resultsCount} items', style: AppText.caption.copyWith(fontSize: 11)),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   Widget _buildPromoBanner() {
// //     return Container(
// //       width: double.infinity,
// //       height: 150,
// //       clipBehavior: Clip.antiAlias,
// //       decoration: BoxDecoration(
// //         color: AppColors.divider,
// //         borderRadius: BorderRadius.circular(16),
// //       ),
// //       child: Stack(
// //         children: [
// //           Positioned(
// //             right: -10,
// //             bottom: -10,
// //             child: Image.network(
// //               'https://picsum.photos/seed/furniturepromo/260/200',
// //               width: 260,
// //               height: 150,
// //               fit: BoxFit.cover,
// //               errorBuilder: (_, __, ___) => const SizedBox.shrink(),
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.all(18),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 RichText(
// //                   text: TextSpan(
// //                     style: AppText.bodyLg.copyWith(fontSize: 15),
// //                     children: [
// //                       const TextSpan(text: 'Up to '),
// //                       TextSpan(text: '30% OFF', style: AppText.titleLg.copyWith(fontSize: 15)),
// //                       const TextSpan(text: ' on\n'),
// //                       TextSpan(text: 'Furniture Rentals', style: AppText.titleLg),
// //                     ],
// //                   ),
// //                 ),
// //                 Container(
// //                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
// //                   decoration: BoxDecoration(color: AppColors.primaryBlack, borderRadius: BorderRadius.circular(20)),
// //                   child: Text('EXPLORE NOW', style: AppText.buttonSm),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Positioned(
// //             bottom: 10,
// //             left: 0,
// //             right: 0,
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: List.generate(3, (i) {
// //                 return Container(
// //                   margin: const EdgeInsets.symmetric(horizontal: 3),
// //                   width: 6,
// //                   height: 6,
// //                   decoration: BoxDecoration(
// //                     shape: BoxShape.circle,
// //                     color: i == 0 ? AppColors.primaryBlack : AppColors.primaryBlack.withOpacity(0.2),
// //                   ),
// //                 );
// //               }),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

import 'package:flutter/material.dart';
import 'category_detail_screen.dart';
import 'category_data.dart';
import '../services/notification_service.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/promo_banner.dart';
import 'offers_screen.dart';
import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'notification_screen.dart';
import '../services/cart_service.dart';
import '../services/location_service.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, this.categoryName});

  final String? categoryName;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _categories = allCategoriesList;

  List<Map<String, dynamic>> get _filteredCategories {
    if (_searchQuery.trim().isEmpty) return _categories;
    final q = _searchQuery.trim().toLowerCase();
    return _categories.where((c) => (c['name'] as String).toLowerCase().contains(q)).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.inputFill,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildHeader(context),
            const SizedBox(height: 22),
            Text('Browse Categories', style: AppText.displayLg),
            const SizedBox(height: 4),
            Text('Find what you need', style: AppText.bodySm),
            const SizedBox(height: 18),
            _buildSearchBar(),
            const SizedBox(height: 18),

            // ---- PROMO BANNER: top of category listing page ----
            PromoBanner(
              style: PromoBannerStyle.card,
              icon: Icons.local_fire_department_outlined,
              title: 'Seasonal Sale Live',
              subtitle: 'Up to 30% off across select categories this week.',
              ctaLabel: 'VIEW OFFERS',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OffersScreen())),
            ),
            const SizedBox(height: 18),

            if (_filteredCategories.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Center(
                  child: Text('No categories found.', style: AppText.bodySm.copyWith(color: AppColors.textHint)),
                ),
              )
            else
              _buildCategoriesGrid(),
            const SizedBox(height: 18),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OffersScreen()),
              ),
              child: _buildPromoBanner(),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.primaryBlack),
        ),
        const SizedBox(width: 12),
        // Expanded(
        //   child: Row(
        //     children: [
        //       const Icon(Icons.location_on_outlined, size: 20, color: AppColors.primaryBlack),
        //       const SizedBox(width: 6),
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Row(
        //             children: [
        //               Text('Mumbai, 400001', style: AppText.titleMd),
        //               const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.primaryBlack),
        //             ],
        //           ),
        //           Text('Deliver to your location', style: AppText.caption.copyWith(fontSize: 10.5)),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),

        Expanded(
  child: AnimatedBuilder(
    animation: LocationService.instance,
    builder: (context, _) {
      final loc = LocationService.instance;
      return GestureDetector(
        onTap: () => LocationService.instance.fetchCurrentLocation(),
        child: Row(
          children: [
            const Icon(Icons.location_on_outlined, size: 20, color: AppColors.primaryBlack),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          loc.isLoading ? 'Fetching your location...' : loc.address,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppText.titleMd,
                        ),
                      ),
                      const Icon(Icons.my_location, size: 15, color: AppColors.primaryBlack),
                    ],
                  ),
                  Text('Deliver to your location', style: AppText.caption.copyWith(fontSize: 10.5)),
                ],
              ),
            ),
          ],
        ),
      );
    },
  ),
),
        AnimatedBuilder(
          animation: CartService.instance,
          builder: (context, _) => GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartScreen()),
            ),
            child: _iconWithBadge(Icons.shopping_cart_outlined, CartService.instance.unseenCount),
          ),
        ),
        const SizedBox(width: 16),
        AnimatedBuilder(
          animation: NotificationService.instance,
          builder: (context, _) => GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationScreen()),
            ),
            child: _iconWithBadge(Icons.notifications_none_rounded, NotificationService.instance.unreadCount),
          ),
        ),
      ],
    );
  }

  Widget _iconWithBadge(IconData icon, int count) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon, size: 24, color: AppColors.primaryBlack),
        if (count > 0)
          Positioned(
            top: -4,
            right: -6,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(color: AppColors.accentLime, shape: BoxShape.circle),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: Text('$count',
                  textAlign: TextAlign.center,
                  style: AppText.caption.copyWith(color: AppColors.primaryBlack, fontSize: 9, fontWeight: FontWeight.bold)),
            ),
          ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: AppColors.textHint, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _searchQuery = value),
              style: AppText.bodyMd,
              decoration: InputDecoration(
                hintText: 'Search for products or services',
                hintStyle: AppText.bodyMd.copyWith(color: AppColors.textHint),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          if (_searchQuery.isNotEmpty)
            GestureDetector(
              onTap: () {
                _searchController.clear();
                setState(() => _searchQuery = '');
              },
              child: const Icon(Icons.close, size: 18, color: AppColors.textSecondary),
            ),
        ],
      ),
    );
  }
 

Widget _buildCategoriesGrid() {
    final categories = _filteredCategories;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.88,   // taller card — enough room for 2-line titles
      ),
      itemBuilder: (context, i) {
        final c = categories[i];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CategoryDetailScreen(categoryName: c['name'])),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Fixed height instead of Expanded — smaller, predictable
                // image area instead of stretching to fill the card.
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                  child: categoryImage(
                    c['image'],
                    height: 90,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
  padding: const EdgeInsets.fromLTRB(10, 7, 10, 9),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: 30, // reserves space for 2 lines so all cards align
        child: Text(c['name'],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppText.titleSm.copyWith(fontSize: 11.5)),
      ),
      const SizedBox(height: 1),
      Text('${getCategoryData(c['name']).resultsCount} items',
          style: AppText.caption.copyWith(fontSize: 9.5)),
    ],
  ),
),
              ],
            ),
          ),
        );
      },
    );
  }

 

  Widget _buildPromoBanner() {
    return Container(
      width: double.infinity,
      height: 150,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.divider,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            bottom: -10,
            child: Image.network(
              'https://picsum.photos/seed/furniturepromo/260/200',
              width: 260,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: AppText.bodyLg.copyWith(fontSize: 15),
                    children: [
                      const TextSpan(text: 'Up to '),
                      TextSpan(text: '30% OFF', style: AppText.titleLg.copyWith(fontSize: 15)),
                      const TextSpan(text: ' on\n'),
                      TextSpan(text: 'Furniture Rentals', style: AppText.titleLg),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(color: AppColors.primaryBlack, borderRadius: BorderRadius.circular(20)),
                  child: Text('EXPLORE NOW', style: AppText.buttonSm),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (i) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i == 0 ? AppColors.primaryBlack : AppColors.primaryBlack.withOpacity(0.2),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}