// import 'package:flutter/material.dart';
// import 'category_data.dart';
// import 'product_details_screen.dart';
// import 'offers_screen.dart';
// import '../services/notification_service.dart';
// //import '../constants/app_colors.dart';
// import '../delivery/core/constants/app_colors.dart';
// import 'cart_screen.dart';
// import '../services/cart_service.dart';
// import 'notification_screen.dart';
// // import 'constants/app_colors.dart';
// //import '../lib/constants/app_text_styles.dart';
// import 'package:rento/constants/app_text_styles.dart';

// class CategoryDetailScreen extends StatefulWidget {
//   const CategoryDetailScreen({super.key, required this.categoryName});

//   final String categoryName;

//   @override
//   State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
// }

// class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
//   late CategoryData _data;
//   late String _selectedSub;
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';

//   @override
//   void initState() {
//     super.initState();
//     _data = getCategoryData(widget.categoryName);
//     _selectedSub = _data.subcategories.first;
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   List<CategoryProduct> get _filteredProducts {
//     var products = _selectedSub == _data.subcategories.first
//         ? _data.products
//         : _data.products.where((p) => p.sub == _selectedSub).toList();

//     final q = _searchQuery.trim().toLowerCase();
//     if (q.isNotEmpty) {
//       products = products
//           .where((p) => p.name.toLowerCase().contains(q))
//           .toList();
//     }
//     return products;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.inputFill,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildHeader(context),
//                   const SizedBox(height: 18),
//                   Text(
//                     '${widget.categoryName} Rentals',
//                     style: AppText.displayMd,
//                   ),
//                   const SizedBox(height: 3),
//                   Text(
//                     '${_data.resultsCount} results found',
//                     style: AppText.bodySm.copyWith(fontSize: 12.5),
//                   ),
//                   const SizedBox(height: 14),
//                   _buildSearchBar(),
//                   const SizedBox(height: 12),
//                 ],
//               ),
//             ),
//             const Divider(height: 1, color: AppColors.divider),
//             Expanded(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildSidebar(),
//                   Container(width: 1, color: AppColors.divider),
//                   Expanded(child: _buildProductList()),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ---------- HEADER ----------
//   Widget _buildHeader(BuildContext context) {
//     return Row(
//       children: [
//         GestureDetector(
//           onTap: () => Navigator.pop(context),
//           child: const Icon(
//             Icons.arrow_back_ios_new,
//             size: 18,
//             color: AppColors.primaryBlack,
//           ),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Row(
//             children: [
//               const Icon(
//                 Icons.location_on,
//                 size: 16,
//                 color: AppColors.primaryBlack,
//               ),
//               const SizedBox(width: 4),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         'Mumbai, 400001',
//                         style: AppText.titleSm.copyWith(fontSize: 13.5),
//                       ),
//                       const Icon(
//                         Icons.keyboard_arrow_down,
//                         size: 15,
//                         color: AppColors.primaryBlack,
//                       ),
//                     ],
//                   ),
//                   Text(
//                     'Deliver to your location',
//                     style: AppText.caption.copyWith(fontSize: 9.5),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         AnimatedBuilder(
//           animation: CartService.instance,
//           builder: (context, _) => GestureDetector(
//             onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const CartScreen()),
//             ),
//             child: _iconWithBadge(
//               Icons.shopping_cart_outlined,
//               CartService.instance.unseenCount,
//             ),
//           ),
//         ),
//         const SizedBox(width: 14),
//         AnimatedBuilder(
//           animation: NotificationService.instance,
//           builder: (context, _) => GestureDetector(
//             onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const NotificationScreen()),
//             ),
//             child: _iconWithBadge(
//               Icons.notifications_none_rounded,
//               NotificationService.instance.unreadCount,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _iconWithBadge(IconData icon, int count) {
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         Icon(icon, size: 22, color: AppColors.primaryBlack),
//         if (count > 0)
//           Positioned(
//             top: -4,
//             right: -6,
//             child: Container(
//               padding: const EdgeInsets.all(3),
//               decoration: const BoxDecoration(
//                 color: AppColors.accentLime,
//                 shape: BoxShape.circle,
//               ),
//               constraints: const BoxConstraints(minWidth: 15, minHeight: 15),
//               child: Text(
//                 '$count',
//                 textAlign: TextAlign.center,
//                 style: AppText.caption.copyWith(
//                   color: AppColors.primaryBlack,
//                   fontSize: 8,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }

//   // ---------- SEARCH BAR ----------
//   Widget _buildSearchBar() {
//     return Container(
//       height: 46,
//       padding: const EdgeInsets.symmetric(horizontal: 14),
//       decoration: BoxDecoration(
//         color: AppColors.pureWhite,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: AppColors.border),
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.search, color: AppColors.textHint, size: 19),
//           const SizedBox(width: 8),
//           Expanded(
//             child: TextField(
//               controller: _searchController,
//               onChanged: (value) => setState(() => _searchQuery = value),
//               style: AppText.bodyMd,
//               decoration: InputDecoration(
//                 hintText: _data.searchHint,
//                 hintStyle: AppText.bodySm.copyWith(fontSize: 12.5),
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
//               child: const Icon(
//                 Icons.close,
//                 size: 18,
//                 color: AppColors.textSecondary,
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   // ---------- SIDEBAR ----------
//   // Note: selected-subcategory highlight (light purple bg + purple
//   // bar/text) kept as-is — distinct accent, no equivalent in AppColors.
//   Widget _buildSidebar() {
//     return SizedBox(
//       width: 108,
//       child: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               itemCount: _data.subcategories.length,
//               itemBuilder: (context, i) {
//                 final sub = _data.subcategories[i];
//                 final isSelected = _selectedSub == sub;
//                 return GestureDetector(
//                   onTap: () => setState(() => _selectedSub = sub),
//                   child: Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 12,
//                       horizontal: 10,
//                     ),
//                     color: isSelected
//                         ? const Color(0xFFF0F0FF)
//                         : Colors.transparent,
//                     child: Row(
//                       children: [
//                         if (isSelected)
//                           Container(
//                             width: 3,
//                             height: 14,
//                             margin: const EdgeInsets.only(right: 6),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFF6C5CE7),
//                               borderRadius: BorderRadius.circular(2),
//                             ),
//                           ),
//                         Expanded(
//                           child: Text(
//                             sub,
//                             maxLines: 2,
//                             style: AppText.labelSm.copyWith(
//                               fontSize: 11,
//                               fontWeight: isSelected
//                                   ? FontWeight.w700
//                                   : FontWeight.w500,
//                               color: isSelected
//                                   ? const Color(0xFF6C5CE7)
//                                   : AppColors.textSecondary,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8),
//             child: GestureDetector(
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const OffersScreen()),
//               ),
//               child: Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryBlack,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Up to ${_data.promoPercent}% OFF',
//                       style: AppText.caption.copyWith(
//                         color: AppColors.pureWhite,
//                         fontSize: 10.5,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                     const SizedBox(height: 3),
//                     Text(
//                       'on ${widget.categoryName} Rentals',
//                       style: AppText.caption.copyWith(
//                         color: AppColors.pureWhite.withOpacity(0.7),
//                         fontSize: 8.5,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ---------- PRODUCT LIST ----------
//   Widget _buildProductList() {
//     final products = _filteredProducts;
//     if (products.isEmpty) {
//       return Center(
//         child: Text(
//           'No items found',
//           style: AppText.bodySm.copyWith(
//             fontSize: 12.5,
//             color: AppColors.textHint,
//           ),
//         ),
//       );
//     }
//     return ListView.separated(
//       padding: const EdgeInsets.all(12),
//       itemCount: products.length,
//       separatorBuilder: (_, __) => const SizedBox(height: 14),
//       itemBuilder: (context, i) {
//         final p = products[i];
//         return GestureDetector(
//           onTap: () => Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) =>
//                   ProductDetailsScreen(name: p.name, price: p.price),
//             ),
//           ),
//           child: Row(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Image.network(
//                   p.image,
//                   width: 56,
//                   height: 56,
//                   fit: BoxFit.cover,
//                   errorBuilder: (_, __, ___) => Container(
//                     width: 56,
//                     height: 56,
//                     color: AppColors.inputFill,
//                     child: const Icon(
//                       Icons.image_outlined,
//                       color: AppColors.textHint,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       p.name,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: AppText.titleSm,
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       p.price,
//                       style: AppText.priceMd.copyWith(fontSize: 12.5),
//                     ),
//                   ],
//                 ),
//               ),
//               const Icon(
//                 Icons.chevron_right,
//                 size: 18,
//                 color: AppColors.textHint,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'category_data.dart';
import 'product_details_screen.dart';
import 'offers_screen.dart';
import '../services/notification_service.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import 'cart_screen.dart';
import '../services/location_service.dart';
import '../services/cart_service.dart';
import 'notification_screen.dart';

class CategoryDetailScreen extends StatefulWidget {
  const CategoryDetailScreen({super.key, required this.categoryName});

  final String categoryName;

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  late CategoryData _data;
  late String _selectedSub;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _data = getCategoryData(widget.categoryName);
    _selectedSub = _data.subcategories.first;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<CategoryProduct> get _filteredProducts {
    var products = _selectedSub == _data.subcategories.first
        ? _data.products
        : _data.products.where((p) => p.sub == _selectedSub).toList();

    final q = _searchQuery.trim().toLowerCase();
    if (q.isNotEmpty) {
      products = products.where((p) => p.name.toLowerCase().contains(q)).toList();
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.inputFill,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 18),
                  Text('${widget.categoryName} Rentals', style: AppText.displayMd),
                  const SizedBox(height: 3),
                  Text('${_data.resultsCount} results found', style: AppText.bodySm.copyWith(fontSize: 12.5)),
                  const SizedBox(height: 14),
                  _buildSearchBar(),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.divider),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSidebar(),
                  Container(width: 1, color: AppColors.divider),
                  Expanded(child: _buildProductList()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- HEADER ----------
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
        //       const Icon(Icons.location_on, size: 16, color: AppColors.primaryBlack),
        //       const SizedBox(width: 4),
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Row(
        //             children: [
        //               Text('Mumbai, 400001', style: AppText.titleSm.copyWith(fontSize: 13.5)),
        //               const Icon(Icons.keyboard_arrow_down, size: 15, color: AppColors.primaryBlack),
        //             ],
        //           ),
        //           Text('Deliver to your location', style: AppText.caption.copyWith(fontSize: 9.5)),
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
            const Icon(Icons.location_on, size: 16, color: AppColors.primaryBlack),
            const SizedBox(width: 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          loc.isLoading ? 'Fetching...' : loc.address,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppText.titleSm.copyWith(fontSize: 13.5),
                        ),
                      ),
                      const Icon(Icons.my_location, size: 13, color: AppColors.primaryBlack),
                    ],
                  ),
                  Text('Deliver to your location', style: AppText.caption.copyWith(fontSize: 9.5)),
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
        const SizedBox(width: 14),
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
        Icon(icon, size: 22, color: AppColors.primaryBlack),
        if (count > 0)
          Positioned(
            top: -4,
            right: -6,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(color: AppColors.accentLime, shape: BoxShape.circle),
              constraints: const BoxConstraints(minWidth: 15, minHeight: 15),
              child: Text('$count',
                  textAlign: TextAlign.center,
                  style: AppText.caption.copyWith(color: AppColors.primaryBlack, fontSize: 8, fontWeight: FontWeight.bold)),
            ),
          ),
      ],
    );
  }

  // ---------- SEARCH BAR ----------
  Widget _buildSearchBar() {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: AppColors.textHint, size: 19),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _searchQuery = value),
              style: AppText.bodyMd,
              decoration: InputDecoration(
                hintText: _data.searchHint,
                hintStyle: AppText.bodySm.copyWith(fontSize: 12.5),
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

  // ---------- SIDEBAR ----------
  // Note: selected-subcategory highlight (light purple bg + purple
  // bar/text) kept as-is — distinct accent, no equivalent in AppColors.
  Widget _buildSidebar() {
    return SizedBox(
      width: 108,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _data.subcategories.length,
              itemBuilder: (context, i) {
                final sub = _data.subcategories[i];
                final isSelected = _selectedSub == sub;
                return GestureDetector(
                  onTap: () => setState(() => _selectedSub = sub),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    color: isSelected ? const Color(0xFFF0F0FF) : Colors.transparent,
                    child: Row(
                      children: [
                        if (isSelected)
                          Container(
                            width: 3,
                            height: 14,
                            margin: const EdgeInsets.only(right: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6C5CE7),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        Expanded(
                          child: Text(
                            sub,
                            maxLines: 2,
                            style: AppText.labelSm.copyWith(
                              fontSize: 11,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              color: isSelected ? const Color(0xFF6C5CE7) : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OffersScreen()),
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlack,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Up to ${_data.promoPercent}% OFF',
                        style: AppText.caption.copyWith(color: AppColors.pureWhite, fontSize: 10.5, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 3),
                    Text('on ${widget.categoryName} Rentals',
                        style: AppText.caption.copyWith(color: AppColors.pureWhite.withOpacity(0.7), fontSize: 8.5)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- PRODUCT LIST ----------
  Widget _buildProductList() {
    final products = _filteredProducts;
    if (products.isEmpty) {
      return Center(
        child: Text('No items found', style: AppText.bodySm.copyWith(fontSize: 12.5, color: AppColors.textHint)),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: products.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, i) {
        final p = products[i];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailsScreen(
                name: p.name,
                price: p.price,
                imageUrl: p.image,
                categoryLabel: widget.categoryName,
                isBookingType: _data.isBookingCategory,
              ),
            ),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  p.image,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 56,
                    height: 56,
                    color: AppColors.inputFill,
                    child: const Icon(Icons.image_outlined, color: AppColors.textHint),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppText.titleSm),
                    const SizedBox(height: 4),
                    Text(p.price, style: AppText.priceMd.copyWith(fontSize: 12.5)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, size: 18, color: AppColors.textHint),
            ],
          ),
        );
      },
    );
  }
}