

// import 'package:flutter/material.dart';
// import '../theme/app_theme.dart';
// import '../widgets/primary_button.dart';
// import '../services/cart_service.dart';
// import '../services/favorites_service.dart';
// import 'select_duration_screen.dart';
// import '../services/review_service.dart';
// import '../services/orders_service.dart';
// import 'rental_order.dart';


// class SpecItem {
//   final IconData icon;
//   final String label;
//   final String value;
//   const SpecItem({required this.icon, required this.label, required this.value});
// }

// class SimilarProduct {
//   final String name;
//   final String price;
//   final double rating;
//   final int reviewCount;
//   final String imageQuery;
//   // Original/MRP price. If not provided, a professional-looking one is
//   // auto-derived (~20% above the rental price) so every card still gets
//   // a strikethrough MRP + discount badge without every caller needing
//   // to supply real MRP data manually.
//   final String? mrp;

//   const SimilarProduct({
//     required this.name,
//     required this.price,
//     required this.rating,
//     required this.reviewCount,
//     required this.imageQuery,
//     this.mrp,
//   });

//   String get imageUrl => buildImageUrl(imageQuery, name, variant: 0);
// }

// String buildImageUrl(String query, String seedName, {int variant = 0, int size = 700}) {
//   final tags = query.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ',');
//   final lock = (seedName.hashCode.abs() % 5000) + variant;
//   return 'https://loremflickr.com/$size/$size/$tags?lock=$lock';
// }

// Widget smartImage(
//   String path, {
//   required double width,
//   required double height,
//   BoxFit fit = BoxFit.cover,
//   Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,
// }) {
//   final isNetwork = path.startsWith('http');
//   final fallback = (context, error, stackTrace) => Container(
//         width: width,
//         height: height,
//         color: const Color(0xFFF3F4F6),
//         child: const Icon(Icons.image_outlined, color: Colors.black38),
//       );

//   if (isNetwork) {
//     return Image.network(
//       path,
//       width: width,
//       height: height,
//       fit: fit,
//       loadingBuilder: (context, child, progress) {
//         if (progress == null) return child;
//         return Container(
//           width: width,
//           height: height,
//           color: const Color(0xFFF3F4F6),
//           child: const Center(
//             child: SizedBox(
//               width: 18,
//               height: 18,
//               child: CircularProgressIndicator(strokeWidth: 2),
//             ),
//           ),
//         );
//       },
//       errorBuilder: errorBuilder ?? fallback,
//     );
//   }
//   return Image.asset(
//     path,
//     width: width,
//     height: height,
//     fit: fit,
//     errorBuilder: errorBuilder ?? fallback,
//   );
// }

// // ---------- PRICE HELPERS (shared by the main card + Similar Products) ----------
// // Strips currency symbols/commas and parses a price string like "₹599"
// // down to a plain double. Returns 0 if it can't be parsed.
// double parsePriceValue(String price) {
//   final cleaned = price.replaceAll(RegExp(r'[^0-9.]'), '');
//   return double.tryParse(cleaned) ?? 0;
// }

// // Auto-derives a plausible MRP (~20% above the rental price) when one
// // isn't explicitly supplied, formatted the same way as the rental price
// // (currency symbol + no decimals).
// String autoMrpFor(String rentalPrice) {
//   final value = parsePriceValue(rentalPrice);
//   final mrpValue = (value * 1.2).round();
//   final symbolMatch = RegExp(r'^[^\d]*').stringMatch(rentalPrice) ?? '₹';
//   return '$symbolMatch$mrpValue';
// }

// class ProductDetailsScreen extends StatefulWidget {
//   final String name;
//   final String price;
//   final String? imageUrl;

//   final String categoryLabel;
//   final String imageQuery;
//   final double rating;
//   final int reviewCount;
//   final String securityDeposit;
//   final List<SpecItem> specs;
//   final String description;
//   final List<SimilarProduct> similarProducts;
//   // Original/MRP price, shown struck-through next to the rental price
//   // with a discount badge. Auto-derived if not explicitly passed in —
//   // see autoMrpFor() above.
//   final String? mrp;

//   const ProductDetailsScreen({
//     super.key,
//     required this.name,
//     required this.price,
//     this.imageUrl,
//     this.categoryLabel = 'DSLR CAMERA',
//     this.imageQuery = 'dslr camera',
//     this.rating = 4.5,
//     this.reviewCount = 120,
//     this.securityDeposit = '₹5,000',
//     this.mrp,
//     this.specs = const [
//       SpecItem(icon: Icons.camera_alt_outlined, label: 'Sensor', value: 'APS-C 24.1MP'),
//       SpecItem(icon: Icons.videocam_outlined, label: 'Video', value: 'Full HD 1080p'),
//       SpecItem(icon: Icons.center_focus_strong_outlined, label: 'AF Points', value: '9-Point AF'),
//       SpecItem(icon: Icons.crop_free_outlined, label: 'Display', value: '3.0" LCD'),
//       SpecItem(icon: Icons.wifi_outlined, label: 'WiFi', value: 'Built-in'),
//       SpecItem(icon: Icons.monitor_weight_outlined, label: 'Weight', value: '432g'),
//     ],
//     this.description =
//         'High-quality DSLR camera perfect for photography enthusiasts. Capture stunning images with excellent detail and clarity. Comes with standard lens kit, carrying case, and a charged battery so you can start shooting right away.',
//     this.similarProducts = const [
//       SimilarProduct(name: 'Nikon D3500 DSLR Camera', price: '₹499', rating: 4.3, reviewCount: 98, imageQuery: 'nikon dslr camera'),
//       SimilarProduct(name: 'Canon EOS 200D II DSLR Camera', price: '₹649', rating: 4.6, reviewCount: 110, imageQuery: 'canon dslr camera'),
//       SimilarProduct(name: 'Sony Alpha a68 DSLR Camera', price: '₹699', rating: 4.4, reviewCount: 87, imageQuery: 'sony dslr camera'),
//       SimilarProduct(name: 'Canon EOS 3000D DSLR Camera', price: '₹449', rating: 4.2, reviewCount: 76, imageQuery: 'canon camera'),
//     ],
//   });

//   String get _mainImageUrl => buildImageUrl(imageQuery, name, variant: 0);

//   List<String> get _galleryImageUrls => imageUrl != null
//       ? [imageUrl!, imageUrl!, imageUrl!, imageUrl!]
//       : [
//           buildImageUrl(imageQuery, name, variant: 0),
//           buildImageUrl(imageQuery, name, variant: 1),
//           buildImageUrl(imageQuery, name, variant: 2),
//           buildImageUrl(imageQuery, name, variant: 3),
//         ];

//   @override
//   State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
// }

// class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
//   int _selectedImage = 0;
//   bool _descriptionExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     final gallery = widget._galleryImageUrls;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         foregroundColor: Colors.black,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: const Text('Product Details',
//             style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: Colors.black)),
//         actions: [
//           // This is the actual fix: reads/writes FavoritesService
//           // directly instead of a local bool, so the heart state is
//           // real and shared with the Saved Items screen.
//           AnimatedBuilder(
//             animation: FavoritesService.instance,
//             builder: (context, _) {
//               final isSaved = FavoritesService.instance.isSaved(widget.name);
//               return IconButton(
//                 icon: Icon(isSaved ? Icons.favorite : Icons.favorite_border,
//                     color: isSaved ? Colors.redAccent : Colors.black),
//                 onPressed: () {
//                   FavoritesService.instance.toggle(SavedProduct(
//                     name: widget.name,
//                     price: widget.price,
//                     categoryLabel: widget.categoryLabel,
//                     imageQuery: widget.imageQuery,
//                     rating: widget.rating,
//                     reviewCount: widget.reviewCount,
//                   ));
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text(isSaved
//                           ? '${widget.name} removed from Saved Items'
//                           : '${widget.name} added to Saved Items'),
//                       duration: const Duration(seconds: 2),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//       body: SafeArea(
//         top: false,
//         child: ListView(
//           padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
//           children: [
//             _buildGallery(gallery),
//             const SizedBox(height: 16),
//             _buildTitleBlock(),
//             const SizedBox(height: 14),
//             _buildPriceTag(),
//             const SizedBox(height: 14),
//             _buildDepositInfoBanner(),
//             const SizedBox(height: 22),
//             const Text('Specifications',
//                 style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
//             const SizedBox(height: 10),
//             _buildSpecsGrid(),
//             const SizedBox(height: 22),
//             const Text('Description',
//                 style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
//             const SizedBox(height: 8),
//             _buildDescription(),
//             const SizedBox(height: 24),
//             _buildReviewsSection(),       // <-- ADD THIS LINE
//             const SizedBox(height: 24),  
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text('Similar Products',
//                     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
//                 GestureDetector(
//                   onTap: () {},
//                   child: const Text('View all',
//                       style: TextStyle(
//                           color: Color(0xFF6D5EF8),
//                           fontWeight: FontWeight.w600,
//                           fontSize: 13)),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             _buildSimilarProducts(),
//           ],
//         ),
//       ),
//       bottomNavigationBar: _buildBottomBar(),
//     );
//   }

// // TODO: replace 'You' with the real logged-in user's name/ID once
// // authentication exists, so reviews are tied to actual accounts.
// static const String _currentUserName = 'You';

// bool get _hasRentedThisProduct {
//   // Eligible to review once the item has actually reached the
//   // customer (rentalActive) or any later stage in the flow —
//   // relies on OrderStatus's declared enum order matching flow order.
//   return OrdersService.instance.orders.any((order) =>
//       order.name == widget.name &&
//       order.status.index >= OrderStatus.rentalActive.index);
// }


// Widget _buildReviewsSection() {
//   return AnimatedBuilder(
//     animation: ReviewsService.instance,
//     builder: (context, _) {
//       final reviews = ReviewsService.instance.forProduct(widget.name);
//       final avg = ReviewsService.instance.averageRating(widget.name);
//       final alreadyReviewed = ReviewsService.instance.hasReviewed(widget.name, _currentUserName);

//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   const Text('Reviews', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
//                   if (reviews.isNotEmpty) ...[
//                     const SizedBox(width: 8),
//                     const Icon(Icons.star, size: 14, color: Colors.amber),
//                     const SizedBox(width: 2),
//                     Text('${avg.toStringAsFixed(1)} (${reviews.length})',
//                         style: TextStyle(color: Colors.grey.shade600, fontSize: 12.5)),
//                   ],
//                 ],
//               ),
//               if (_hasRentedThisProduct && !alreadyReviewed)
//                 GestureDetector(
//                   onTap: () => _showWriteReviewSheet(context),
//                   child: const Text('Write a Review',
//                       style: TextStyle(color: Color(0xFF6D5EF8), fontWeight: FontWeight.w600, fontSize: 13)),
//                 ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           if (reviews.isEmpty)
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 border: Border.all(color: AppTheme.border),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Text(
//                 _hasRentedThisProduct
//                     ? 'No reviews yet. Be the first to review this product!'
//                     : 'No reviews yet. Rent this product to be the first to review it.',
//                 style: TextStyle(color: Colors.grey.shade600, fontSize: 12.5),
//               ),
//             )
//           else
//             Column(
//               children: reviews.map((r) => _reviewCard(r)).toList(),
//             ),
//           if (!_hasRentedThisProduct)
//             Padding(
//               padding: const EdgeInsets.only(top: 10),
//               child: Row(
//                 children: [
//                   Icon(Icons.info_outline, size: 14, color: Colors.grey.shade500),
//                   const SizedBox(width: 6),
//                   Expanded(
//                     child: Text(
//                       'Only customers who have rented this product can leave a review.',
//                       style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       );
//     },
//   );
// }

// Widget _reviewCard(Review review) {
//   return Container(
//     margin: const EdgeInsets.only(bottom: 10),
//     padding: const EdgeInsets.all(14),
//     decoration: BoxDecoration(
//       border: Border.all(color: AppTheme.border),
//       borderRadius: BorderRadius.circular(12),
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             CircleAvatar(
//               radius: 15,
//               backgroundColor: const Color(0xFFEFEBFF),
//               child: Text(
//                 review.userName.isNotEmpty ? review.userName[0].toUpperCase() : '?',
//                 style: const TextStyle(color: Color(0xFF6D5EF8), fontWeight: FontWeight.w700, fontSize: 12),
//               ),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(review.userName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5)),
//                   Row(
//                     children: List.generate(5, (i) => Icon(
//                           i < review.rating.round() ? Icons.star : Icons.star_border,
//                           size: 12,
//                           color: Colors.amber,
//                         )),
//                   ),
//                 ],
//               ),
//             ),
//             Text(_relativeDate(review.date), style: TextStyle(fontSize: 10.5, color: Colors.grey.shade500)),
//           ],
//         ),
//         if (review.comment.trim().isNotEmpty) ...[
//           const SizedBox(height: 8),
//           Text(review.comment, style: const TextStyle(fontSize: 12.5, height: 1.4)),
//         ],
//       ],
//     ),
//   );
// }

// String _relativeDate(DateTime date) {
//   final diff = DateTime.now().difference(date);
//   if (diff.inDays > 0) return '${diff.inDays}d ago';
//   if (diff.inHours > 0) return '${diff.inHours}h ago';
//   if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
//   return 'just now';
// }

// void _showWriteReviewSheet(BuildContext context) {
//   double rating = 5;
//   final commentController = TextEditingController();

//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
//     builder: (sheetContext) {
//       return Padding(
//         padding: EdgeInsets.only(
//           left: 20, right: 20, top: 20,
//           bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 20,
//         ),
//         child: StatefulBuilder(
//           builder: (context, setSheetState) {
//             return Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text('Write a Review', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
//                 const SizedBox(height: 4),
//                 Text(widget.name, style: TextStyle(color: Colors.grey.shade600, fontSize: 12.5)),
//                 const SizedBox(height: 16),
//                 Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: List.generate(5, (i) {
//                       final starValue = i + 1;
//                       return GestureDetector(
//                         onTap: () => setSheetState(() => rating = starValue.toDouble()),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 4),
//                           child: Icon(
//                             starValue <= rating ? Icons.star : Icons.star_border,
//                             color: Colors.amber,
//                             size: 32,
//                           ),
//                         ),
//                       );
//                     }),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 TextField(
//                   controller: commentController,
//                   maxLines: 4,
//                   decoration: InputDecoration(
//                     hintText: 'Share your experience with this product...',
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                     contentPadding: const EdgeInsets.all(12),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       ReviewsService.instance.addReview(
//                         productName: widget.name,
//                         userName: _currentUserName,
//                         rating: rating,
//                         comment: commentController.text.trim(),
//                       );
//                       Navigator.pop(sheetContext);
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Review submitted. Thank you!')),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.black,
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//                     ),
//                     child: const Text('Submit Review', style: TextStyle(fontWeight: FontWeight.w700)),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       );
//     },
//   );
// }




//   Widget _buildGallery(List<String> gallery) {
//     return Column(
//       children: [
//         ClipRRect(
//           borderRadius: BorderRadius.circular(16),
//           child: smartImage(
//             gallery[_selectedImage],
//             width: double.infinity,
//             height: 240,
//           ),
//         ),
//         const SizedBox(height: 10),
//         SizedBox(
//           height: 64,
//           child: ListView.separated(
//             scrollDirection: Axis.horizontal,
//             itemCount: gallery.length,
//             separatorBuilder: (_, __) => const SizedBox(width: 8),
//             itemBuilder: (context, i) {
//               final selected = i == _selectedImage;
//               final isLast = i == gallery.length - 1;
//               return GestureDetector(
//                 onTap: () => setState(() => _selectedImage = i),
//                 child: Container(
//                   width: 64,
//                   height: 64,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(
//                       color: selected ? Colors.black : AppTheme.border,
//                       width: selected ? 2 : 1,
//                     ),
//                   ),
//                   child: Stack(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(9),
//                         child: smartImage(gallery[i], width: 64, height: 64),
//                       ),
//                       if (isLast)
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.black.withOpacity(0.35),
//                             borderRadius: BorderRadius.circular(9),
//                           ),
//                           child: const Center(
//                             child: Icon(Icons.play_circle_fill, color: Colors.white, size: 22),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildTitleBlock() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//           decoration: BoxDecoration(
//             color: const Color(0xFFEFEBFF),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Text(widget.categoryLabel,
//               style: const TextStyle(
//                   color: Color(0xFF6D5EF8), fontWeight: FontWeight.w700, fontSize: 11)),
//         ),
//         const SizedBox(height: 10),
//         Text(widget.name,
//             style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, height: 1.2)),
//         const SizedBox(height: 6),
//         Row(
//           children: [
//             const Icon(Icons.star, size: 16, color: Colors.amber),
//             const SizedBox(width: 4),
//             Text('${widget.rating} (${widget.reviewCount} reviews)',
//                 style: const TextStyle(color: AppTheme.grey, fontSize: 13)),
//           ],
//         ),
//       ],
//     );
//   }

//   // ---------- PRICE TAG (MRP + Rental Price + discount) ----------
//   // "Professional price tag" block: rental price large and bold, MRP
//   // struck through beside it, and a discount % badge when there's a
//   // real gap between the two. Security Deposit stays in its own banner
//   // right below (see _buildDepositInfoBanner) so all three — MRP,
//   // Rental Price, Deposit — are clearly visible as a group.
//   Widget _buildPriceTag() {
//     final mrpText = widget.mrp ?? autoMrpFor(widget.price);
//     final rentalValue = parsePriceValue(widget.price);
//     final mrpValue = parsePriceValue(mrpText);
//     final hasDiscount = mrpValue > rentalValue;
//     final discountPercent =
//         hasDiscount ? (((mrpValue - rentalValue) / mrpValue) * 100).round() : 0;

//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: const Color(0xFFFAFAFA),
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: AppTheme.border),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(widget.price,
//                   style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
//               const SizedBox(width: 4),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 4),
//                 child: Text('/ day', style: TextStyle(color: AppTheme.grey, fontSize: 13)),
//               ),
//               if (hasDiscount) ...[
//                 const SizedBox(width: 10),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 5),
//                   child: Text(
//                     mrpText,
//                     style: TextStyle(
//                       color: Colors.grey.shade500,
//                       fontSize: 15,
//                       decoration: TextDecoration.lineThrough,
//                       decorationColor: Colors.grey.shade500,
//                     ),
//                   ),
//                 ),
//               ],
//             ],
//           ),
//           if (hasDiscount) ...[
//             const SizedBox(height: 8),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFEAFBF0),
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               child: Text('$discountPercent% cheaper than buying new (MRP $mrpText)',
//                   style: const TextStyle(
//                       color: Color(0xFF15803D), fontWeight: FontWeight.w700, fontSize: 11)),
//             ),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _buildDepositInfoBanner() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//       decoration: BoxDecoration(
//         color: const Color(0xFFEAFBF0),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.verified_user_outlined, color: Color(0xFF22C55E), size: 18),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Text('Security Deposit ${widget.securityDeposit} (Refundable)',
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                     color: Color(0xFF15803D), fontWeight: FontWeight.w600, fontSize: 13)),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSpecsGrid() {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: widget.specs.length,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         mainAxisSpacing: 10,
//         crossAxisSpacing: 10,
//         childAspectRatio: 2.6,
//       ),
//       itemBuilder: (context, i) {
//         final spec = widget.specs[i];
//         return Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//           decoration: BoxDecoration(
//             border: Border.all(color: AppTheme.border),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFEFEBFF),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Icon(spec.icon, size: 16, color: const Color(0xFF6D5EF8)),
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(spec.label,
//                         style: const TextStyle(color: AppTheme.grey, fontSize: 11)),
//                     Text(spec.value,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildDescription() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           widget.description,
//           maxLines: _descriptionExpanded ? null : 2,
//           overflow: _descriptionExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
//           style: const TextStyle(color: AppTheme.grey, height: 1.4, fontSize: 13.5),
//         ),
//         GestureDetector(
//           onTap: () => setState(() => _descriptionExpanded = !_descriptionExpanded),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(_descriptionExpanded ? 'Show less' : 'Show more',
//                   style: const TextStyle(
//                       color: Color(0xFF6D5EF8), fontWeight: FontWeight.w700, fontSize: 13)),
//               Icon(
//                 _descriptionExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
//                 color: const Color(0xFF6D5EF8),
//                 size: 18,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSimilarProducts() {
//     return SizedBox(
//       height: 205,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         itemCount: widget.similarProducts.length,
//         separatorBuilder: (_, __) => const SizedBox(width: 12),
//         itemBuilder: (context, i) {
//           final p = widget.similarProducts[i];
//           final mrpText = p.mrp ?? autoMrpFor(p.price);
//           final hasDiscount = parsePriceValue(mrpText) > parsePriceValue(p.price);
//           return GestureDetector(
//             onTap: () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => ProductDetailsScreen(
//                     name: p.name,
//                     price: p.price,
//                     mrp: p.mrp,
//                     categoryLabel: widget.categoryLabel,
//                     imageQuery: p.imageQuery,
//                     rating: p.rating,
//                     reviewCount: p.reviewCount,
//                     securityDeposit: widget.securityDeposit,
//                     specs: widget.specs,
//                     description: widget.description,
//                     similarProducts: widget.similarProducts,
//                   ),
//                 ),
//               );
//             },
//             child: Container(
//               width: 130,
//               decoration: BoxDecoration(
//                 border: Border.all(color: AppTheme.border),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ClipRRect(
//                     borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
//                     child: Image.network(
//                       p.imageUrl,
//                       height: 90,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                       loadingBuilder: (context, child, progress) {
//                         if (progress == null) return child;
//                         return Container(
//                           height: 90,
//                           color: AppTheme.lightGrey,
//                           child: const Center(
//                             child: SizedBox(
//                               width: 16,
//                               height: 16,
//                               child: CircularProgressIndicator(strokeWidth: 1.5),
//                             ),
//                           ),
//                         );
//                       },
//                       errorBuilder: (_, __, ___) => Container(
//                         height: 90,
//                         color: AppTheme.lightGrey,
//                         child: const Icon(Icons.camera_alt_outlined, color: Colors.black38),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(p.name,
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 11.5)),
//                         const SizedBox(height: 4),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Text('${p.price} / day',
//                                 style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
//                           ],
//                         ),
//                         if (hasDiscount)
//                           Text(mrpText,
//                               style: TextStyle(
//                                 color: Colors.grey.shade500,
//                                 fontSize: 10.5,
//                                 decoration: TextDecoration.lineThrough,
//                                 decorationColor: Colors.grey.shade500,
//                               )),
//                         const SizedBox(height: 2),
//                         Row(
//                           children: [
//                             const Icon(Icons.star, size: 12, color: Colors.amber),
//                             const SizedBox(width: 2),
//                             Text('${p.rating} (${p.reviewCount})',
//                                 style: const TextStyle(color: AppTheme.grey, fontSize: 10)),
//                           ],
//                         ),
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

//   Widget _buildBottomBar() {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//               decoration: BoxDecoration(
//                 border: Border.all(color: AppTheme.border),
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const Text('Security Deposit',
//                             style: TextStyle(color: AppTheme.grey, fontSize: 11)),
//                         Text(widget.securityDeposit,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
//                         const SizedBox(height: 4),
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                           decoration: BoxDecoration(
//                             color: const Color(0xFFEAFBF0),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: const Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(Icons.verified_outlined, size: 13, color: Color(0xFF22C55E)),
//                               SizedBox(width: 4),
//                               Text('Refundable',
//                                   style: TextStyle(
//                                       color: Color(0xFF15803D), fontWeight: FontWeight.w600, fontSize: 11)),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   // GestureDetector(
//                   //   onTap: () {
//                   //     Navigator.push(
//                   //       context,
//                   //       MaterialPageRoute(
//                   //         builder: (_) => SelectDurationScreen(
//                   //           name: widget.name,
//                   //           price: widget.price,
//                   //           categoryLabel: widget.categoryLabel,
//                   //           imageQuery: widget.imageQuery,
//                   //           rating: widget.rating,
//                   //           reviewCount: widget.reviewCount,
//                   //           securityDeposit: widget.securityDeposit,
//                   //         ),
//                   //       ),
//                   //     );
//                   //   },
//                   //   child: Container(
//                   //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                   //     decoration: BoxDecoration(
//                   //       color: Colors.black,
//                   //       borderRadius: BorderRadius.circular(24),
//                   //     ),
//                   //     child: const Row(
//                   //       mainAxisSize: MainAxisSize.min,
//                   //       children: [
//                   //         Text('Continue',

//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => SelectDurationScreen(
//                             name: widget.name,
//                             price: widget.price,
//                             imageUrl: widget.imageUrl,
//                             categoryLabel: widget.categoryLabel,
//                             imageQuery: widget.imageQuery,
//                             rating: widget.rating,
//                             reviewCount: widget.reviewCount,
//                             securityDeposit: widget.securityDeposit,
//                           ),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                       decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(24),
//                       ),
//                       child: const Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text('Continue',
//                               style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
//                           SizedBox(width: 6),
//                           Icon(Icons.arrow_forward, color: Colors.white, size: 14),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 Expanded(
//                   child: _AddToCartButton(
//                     onTap: () {
//                       CartService.instance.add(
//                         name: widget.name,
//                         price: widget.price,
//                         imageQuery: widget.imageQuery,
//                         imageUrl: widget.imageUrl,
//                         categoryLabel: widget.categoryLabel,
//                         securityDeposit: widget.securityDeposit,
//                       );
//                       _showAddedToCartToast();
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: PrimaryButton(
//                     label: 'RENT NOW',
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => SelectDurationScreen(
//                             name: widget.name,
//                             price: widget.price,
//                             imageUrl: widget.imageUrl,
//                             categoryLabel: widget.categoryLabel,
//                             imageQuery: widget.imageQuery,
//                             rating: widget.rating,
//                             reviewCount: widget.reviewCount,
//                             securityDeposit: widget.securityDeposit,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showAddedToCartToast() {
//     final overlay = Overlay.of(context);
//     late OverlayEntry entry;
//     entry = OverlayEntry(
//       builder: (context) => _AddedToCartToast(onDone: () => entry.remove()),
//     );
//     overlay.insert(entry);
//   }
// }

// class _AddToCartButton extends StatelessWidget {
//   final VoidCallback onTap;
//   const _AddToCartButton({required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(24),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(24),
//         onTap: onTap,
//         child: Container(
//           height: 46,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.black),
//             borderRadius: BorderRadius.circular(24),
//           ),
//           child: const Text(
//             'ADD TO CART',
//             textAlign: TextAlign.center,
//             maxLines: 1,
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.w700,
//               fontSize: 12,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _AddedToCartToast extends StatefulWidget {
//   final VoidCallback onDone;
//   const _AddedToCartToast({required this.onDone});

//   @override
//   State<_AddedToCartToast> createState() => _AddedToCartToastState();
// }

// class _AddedToCartToastState extends State<_AddedToCartToast> {
//   double _opacity = 0;

//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(milliseconds: 20), () {
//       if (mounted) setState(() => _opacity = 1);
//     });
//     Future.delayed(const Duration(milliseconds: 2000), () {
//       if (mounted) setState(() => _opacity = 0);
//     });
//     Future.delayed(const Duration(milliseconds: 2300), widget.onDone);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       left: 24,
//       right: 24,
//       bottom: 190,
//       child: IgnorePointer(
//         child: AnimatedOpacity(
//           opacity: _opacity,
//           duration: const Duration(milliseconds: 250),
//           child: Material(
//             color: Colors.transparent,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(14),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.12),
//                     blurRadius: 16,
//                     offset: const Offset(0, 6),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Container(
//                     width: 26,
//                     height: 26,
//                     decoration: const BoxDecoration(
//                       color: Color(0xFF22C55E),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(Icons.check, color: Colors.white, size: 16),
//                   ),
//                   const SizedBox(width: 10),
//                   const Text(
//                     'Added to Cart',
//                     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.black),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }






import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';
import '../services/cart_service.dart';
import '../services/favorites_service.dart';
import 'select_duration_screen.dart';
import '../services/review_service.dart';
import '../services/orders_service.dart';
import 'rental_order.dart';


class SpecItem {
  final IconData icon;
  final String label;
  final String value;
  const SpecItem({required this.icon, required this.label, required this.value});
}

class SimilarProduct {
  final String name;
  final String price;
  final double rating;
  final int reviewCount;
  final String imageQuery;
  // Original/MRP price. If not provided, a professional-looking one is
  // auto-derived (~20% above the rental price) so every card still gets
  // a strikethrough MRP + discount badge without every caller needing
  // to supply real MRP data manually.
  final String? mrp;

  const SimilarProduct({
    required this.name,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.imageQuery,
    this.mrp,
  });

  String get imageUrl => buildImageUrl(imageQuery, name, variant: 0);
}

String buildImageUrl(String query, String seedName, {int variant = 0, int size = 700}) {
  final tags = query.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ',');
  final lock = (seedName.hashCode.abs() % 5000) + variant;
  return 'https://loremflickr.com/$size/$size/$tags?lock=$lock';
}

Widget smartImage(
  String path, {
  required double width,
  required double height,
  BoxFit fit = BoxFit.cover,
  Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,
}) {
  final isNetwork = path.startsWith('http');
  final fallback = (context, error, stackTrace) => Container(
        width: width,
        height: height,
        color: const Color(0xFFF3F4F6),
        child: const Icon(Icons.image_outlined, color: Colors.black38),
      );

  if (isNetwork) {
    return Image.network(
      path,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          width: width,
          height: height,
          color: const Color(0xFFF3F4F6),
          child: const Center(
            child: SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        );
      },
      errorBuilder: errorBuilder ?? fallback,
    );
  }
  return Image.asset(
    path,
    width: width,
    height: height,
    fit: fit,
    errorBuilder: errorBuilder ?? fallback,
  );
}

// ---------- PRICE HELPERS (shared by the main card + Similar Products) ----------
// Strips currency symbols/commas and parses a price string like "₹599"
// down to a plain double. Returns 0 if it can't be parsed.
double parsePriceValue(String price) {
  final cleaned = price.replaceAll(RegExp(r'[^0-9.]'), '');
  return double.tryParse(cleaned) ?? 0;
}

// Auto-derives a plausible MRP (~20% above the rental price) when one
// isn't explicitly supplied, formatted the same way as the rental price
// (currency symbol + no decimals).
String autoMrpFor(String rentalPrice) {
  final value = parsePriceValue(rentalPrice);
  final mrpValue = (value * 1.2).round();
  final symbolMatch = RegExp(r'^[^\d]*').stringMatch(rentalPrice) ?? '₹';
  return '$symbolMatch$mrpValue';
}

class ProductDetailsScreen extends StatefulWidget {
  final String name;
  final String price;
  final String? imageUrl;

  final String categoryLabel;
  final String imageQuery;
  final double rating;
  final int reviewCount;
  final String securityDeposit;
  final List<SpecItem> specs;
  final String description;
  final List<SimilarProduct> similarProducts;
  // Original/MRP price, shown struck-through next to the rental price
  // with a discount badge. Auto-derived if not explicitly passed in —
  // see autoMrpFor() above.
  final String? mrp;

  // FIX (new): true for products in booking-style categories (Private
  // Rental Jets, Boats & Yachts, Party Halls, Hotels and Resorts —
  // see category_data.dart's isBookingCategory). Only changes the
  // RENT NOW button's label to BOOK NOW; Add to Cart, deposit banner,
  // and everything else stay exactly as they were. The actual booking
  // flow itself is a separate step to be wired in later.
  final bool isBookingType;

  const ProductDetailsScreen({
    super.key,
    required this.name,
    required this.price,
    this.imageUrl,
    this.categoryLabel = 'DSLR CAMERA',
    this.imageQuery = 'dslr camera',
    this.rating = 4.5,
    this.reviewCount = 120,
    this.securityDeposit = '₹5,000',
    this.mrp,
    this.isBookingType = false,
    this.specs = const [
      SpecItem(icon: Icons.camera_alt_outlined, label: 'Sensor', value: 'APS-C 24.1MP'),
      SpecItem(icon: Icons.videocam_outlined, label: 'Video', value: 'Full HD 1080p'),
      SpecItem(icon: Icons.center_focus_strong_outlined, label: 'AF Points', value: '9-Point AF'),
      SpecItem(icon: Icons.crop_free_outlined, label: 'Display', value: '3.0" LCD'),
      SpecItem(icon: Icons.wifi_outlined, label: 'WiFi', value: 'Built-in'),
      SpecItem(icon: Icons.monitor_weight_outlined, label: 'Weight', value: '432g'),
    ],
    this.description =
        'High-quality DSLR camera perfect for photography enthusiasts. Capture stunning images with excellent detail and clarity. Comes with standard lens kit, carrying case, and a charged battery so you can start shooting right away.',
    this.similarProducts = const [
      SimilarProduct(name: 'Nikon D3500 DSLR Camera', price: '₹499', rating: 4.3, reviewCount: 98, imageQuery: 'nikon dslr camera'),
      SimilarProduct(name: 'Canon EOS 200D II DSLR Camera', price: '₹649', rating: 4.6, reviewCount: 110, imageQuery: 'canon dslr camera'),
      SimilarProduct(name: 'Sony Alpha a68 DSLR Camera', price: '₹699', rating: 4.4, reviewCount: 87, imageQuery: 'sony dslr camera'),
      SimilarProduct(name: 'Canon EOS 3000D DSLR Camera', price: '₹449', rating: 4.2, reviewCount: 76, imageQuery: 'canon camera'),
    ],
  });

  String get _mainImageUrl => buildImageUrl(imageQuery, name, variant: 0);

  List<String> get _galleryImageUrls => imageUrl != null
      ? [imageUrl!, imageUrl!, imageUrl!, imageUrl!]
      : [
          buildImageUrl(imageQuery, name, variant: 0),
          buildImageUrl(imageQuery, name, variant: 1),
          buildImageUrl(imageQuery, name, variant: 2),
          buildImageUrl(imageQuery, name, variant: 3),
        ];

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _selectedImage = 0;
  bool _descriptionExpanded = false;

  @override
  Widget build(BuildContext context) {
    final gallery = widget._galleryImageUrls;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Product Details',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: Colors.black)),
        actions: [
          // This is the actual fix: reads/writes FavoritesService
          // directly instead of a local bool, so the heart state is
          // real and shared with the Saved Items screen.
          AnimatedBuilder(
            animation: FavoritesService.instance,
            builder: (context, _) {
              final isSaved = FavoritesService.instance.isSaved(widget.name);
              return IconButton(
                icon: Icon(isSaved ? Icons.favorite : Icons.favorite_border,
                    color: isSaved ? Colors.redAccent : Colors.black),
                onPressed: () {
                  FavoritesService.instance.toggle(SavedProduct(
                    name: widget.name,
                    price: widget.price,
                    categoryLabel: widget.categoryLabel,
                    imageQuery: widget.imageQuery,
                    rating: widget.rating,
                    reviewCount: widget.reviewCount,
                  ));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isSaved
                          ? '${widget.name} removed from Saved Items'
                          : '${widget.name} added to Saved Items'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          children: [
            _buildGallery(gallery),
            const SizedBox(height: 16),
            _buildTitleBlock(),
            const SizedBox(height: 14),
            _buildPriceTag(),
            const SizedBox(height: 14),
            _buildDepositInfoBanner(),
            const SizedBox(height: 22),
            const Text('Specifications',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 10),
            _buildSpecsGrid(),
            const SizedBox(height: 22),
            const Text('Description',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 8),
            _buildDescription(),
            const SizedBox(height: 24),
            _buildReviewsSection(),       // <-- ADD THIS LINE
            const SizedBox(height: 24),  
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Similar Products',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                GestureDetector(
                  onTap: () {},
                  child: const Text('View all',
                      style: TextStyle(
                          color: Color(0xFF6D5EF8),
                          fontWeight: FontWeight.w600,
                          fontSize: 13)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildSimilarProducts(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

// TODO: replace 'You' with the real logged-in user's name/ID once
// authentication exists, so reviews are tied to actual accounts.
static const String _currentUserName = 'You';

bool get _hasRentedThisProduct {
  // Eligible to review once the item has actually reached the
  // customer (rentalActive) or any later stage in the flow —
  // relies on OrderStatus's declared enum order matching flow order.
  return OrdersService.instance.orders.any((order) =>
      order.name == widget.name &&
      order.status.index >= OrderStatus.rentalActive.index);
}


Widget _buildReviewsSection() {
  return AnimatedBuilder(
    animation: ReviewsService.instance,
    builder: (context, _) {
      final reviews = ReviewsService.instance.forProduct(widget.name);
      final avg = ReviewsService.instance.averageRating(widget.name);
      final alreadyReviewed = ReviewsService.instance.hasReviewed(widget.name, _currentUserName);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('Reviews', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  if (reviews.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 2),
                    Text('${avg.toStringAsFixed(1)} (${reviews.length})',
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 12.5)),
                  ],
                ],
              ),
              if (_hasRentedThisProduct && !alreadyReviewed)
                GestureDetector(
                  onTap: () => _showWriteReviewSheet(context),
                  child: const Text('Write a Review',
                      style: TextStyle(color: Color(0xFF6D5EF8), fontWeight: FontWeight.w600, fontSize: 13)),
                ),
            ],
          ),
          const SizedBox(height: 12),
          if (reviews.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.border),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _hasRentedThisProduct
                    ? 'No reviews yet. Be the first to review this product!'
                    : 'No reviews yet. Rent this product to be the first to review it.',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12.5),
              ),
            )
          else
            Column(
              children: reviews.map((r) => _reviewCard(r)).toList(),
            ),
          if (!_hasRentedThisProduct)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 14, color: Colors.grey.shade500),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Only customers who have rented this product can leave a review.',
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
    },
  );
}

Widget _reviewCard(Review review) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      border: Border.all(color: AppTheme.border),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: const Color(0xFFEFEBFF),
              child: Text(
                review.userName.isNotEmpty ? review.userName[0].toUpperCase() : '?',
                style: const TextStyle(color: Color(0xFF6D5EF8), fontWeight: FontWeight.w700, fontSize: 12),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(review.userName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5)),
                  Row(
                    children: List.generate(5, (i) => Icon(
                          i < review.rating.round() ? Icons.star : Icons.star_border,
                          size: 12,
                          color: Colors.amber,
                        )),
                  ),
                ],
              ),
            ),
            Text(_relativeDate(review.date), style: TextStyle(fontSize: 10.5, color: Colors.grey.shade500)),
          ],
        ),
        if (review.comment.trim().isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(review.comment, style: const TextStyle(fontSize: 12.5, height: 1.4)),
        ],
      ],
    ),
  );
}

String _relativeDate(DateTime date) {
  final diff = DateTime.now().difference(date);
  if (diff.inDays > 0) return '${diff.inDays}d ago';
  if (diff.inHours > 0) return '${diff.inHours}h ago';
  if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
  return 'just now';
}

void _showWriteReviewSheet(BuildContext context) {
  double rating = 5;
  final commentController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (sheetContext) {
      return Padding(
        padding: EdgeInsets.only(
          left: 20, right: 20, top: 20,
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 20,
        ),
        child: StatefulBuilder(
          builder: (context, setSheetState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Write a Review', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                const SizedBox(height: 4),
                Text(widget.name, style: TextStyle(color: Colors.grey.shade600, fontSize: 12.5)),
                const SizedBox(height: 16),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (i) {
                      final starValue = i + 1;
                      return GestureDetector(
                        onTap: () => setSheetState(() => rating = starValue.toDouble()),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(
                            starValue <= rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 32,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: commentController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Share your experience with this product...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ReviewsService.instance.addReview(
                        productName: widget.name,
                        userName: _currentUserName,
                        rating: rating,
                        comment: commentController.text.trim(),
                      );
                      Navigator.pop(sheetContext);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Review submitted. Thank you!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text('Submit Review', style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}




  Widget _buildGallery(List<String> gallery) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: smartImage(
            gallery[_selectedImage],
            width: double.infinity,
            height: 240,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 64,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: gallery.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final selected = i == _selectedImage;
              final isLast = i == gallery.length - 1;
              return GestureDetector(
                onTap: () => setState(() => _selectedImage = i),
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: selected ? Colors.black : AppTheme.border,
                      width: selected ? 2 : 1,
                    ),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(9),
                        child: smartImage(gallery[i], width: 64, height: 64),
                      ),
                      if (isLast)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.35),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: const Center(
                            child: Icon(Icons.play_circle_fill, color: Colors.white, size: 22),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTitleBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFFEFEBFF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(widget.categoryLabel,
              style: const TextStyle(
                  color: Color(0xFF6D5EF8), fontWeight: FontWeight.w700, fontSize: 11)),
        ),
        const SizedBox(height: 10),
        Text(widget.name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, height: 1.2)),
        const SizedBox(height: 6),
        Row(
          children: [
            const Icon(Icons.star, size: 16, color: Colors.amber),
            const SizedBox(width: 4),
            Text('${widget.rating} (${widget.reviewCount} reviews)',
                style: const TextStyle(color: AppTheme.grey, fontSize: 13)),
          ],
        ),
      ],
    );
  }

  // ---------- PRICE TAG (MRP + Rental Price + discount) ----------
  // "Professional price tag" block: rental price large and bold, MRP
  // struck through beside it, and a discount % badge when there's a
  // real gap between the two. Security Deposit stays in its own banner
  // right below (see _buildDepositInfoBanner) so all three — MRP,
  // Rental Price, Deposit — are clearly visible as a group.
  Widget _buildPriceTag() {
    final mrpText = widget.mrp ?? autoMrpFor(widget.price);
    final rentalValue = parsePriceValue(widget.price);
    final mrpValue = parsePriceValue(mrpText);
    final hasDiscount = mrpValue > rentalValue;
    final discountPercent =
        hasDiscount ? (((mrpValue - rentalValue) / mrpValue) * 100).round() : 0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(widget.price,
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text('/ day', style: TextStyle(color: AppTheme.grey, fontSize: 13)),
              ),
              if (hasDiscount) ...[
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    mrpText,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 15,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.grey.shade500,
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (hasDiscount) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFEAFBF0),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text('$discountPercent% cheaper than buying new (MRP $mrpText)',
                  style: const TextStyle(
                      color: Color(0xFF15803D), fontWeight: FontWeight.w700, fontSize: 11)),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDepositInfoBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFEAFBF0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.verified_user_outlined, color: Color(0xFF22C55E), size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text('Security Deposit ${widget.securityDeposit} (Refundable)',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Color(0xFF15803D), fontWeight: FontWeight.w600, fontSize: 13)),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.specs.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2.6,
      ),
      itemBuilder: (context, i) {
        final spec = widget.specs[i];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.border),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFEBFF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(spec.icon, size: 16, color: const Color(0xFF6D5EF8)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(spec.label,
                        style: const TextStyle(color: AppTheme.grey, fontSize: 11)),
                    Text(spec.value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.description,
          maxLines: _descriptionExpanded ? null : 2,
          overflow: _descriptionExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: const TextStyle(color: AppTheme.grey, height: 1.4, fontSize: 13.5),
        ),
        GestureDetector(
          onTap: () => setState(() => _descriptionExpanded = !_descriptionExpanded),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_descriptionExpanded ? 'Show less' : 'Show more',
                  style: const TextStyle(
                      color: Color(0xFF6D5EF8), fontWeight: FontWeight.w700, fontSize: 13)),
              Icon(
                _descriptionExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: const Color(0xFF6D5EF8),
                size: 18,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSimilarProducts() {
    return SizedBox(
      height: 205,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.similarProducts.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) {
          final p = widget.similarProducts[i];
          final mrpText = p.mrp ?? autoMrpFor(p.price);
          final hasDiscount = parsePriceValue(mrpText) > parsePriceValue(p.price);
          return GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailsScreen(
                    name: p.name,
                    price: p.price,
                    mrp: p.mrp,
                    categoryLabel: widget.categoryLabel,
                    imageQuery: p.imageQuery,
                    rating: p.rating,
                    reviewCount: p.reviewCount,
                    securityDeposit: widget.securityDeposit,
                    specs: widget.specs,
                    description: widget.description,
                    similarProducts: widget.similarProducts,
                    isBookingType: widget.isBookingType,
                  ),
                ),
              );
            },
            child: Container(
              width: 130,
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.border),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
                    child: Image.network(
                      p.imageUrl,
                      height: 90,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Container(
                          height: 90,
                          color: AppTheme.lightGrey,
                          child: const Center(
                            child: SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 1.5),
                            ),
                          ),
                        );
                      },
                      errorBuilder: (_, __, ___) => Container(
                        height: 90,
                        color: AppTheme.lightGrey,
                        child: const Icon(Icons.camera_alt_outlined, color: Colors.black38),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 11.5)),
                        const SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('${p.price} / day',
                                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                          ],
                        ),
                        if (hasDiscount)
                          Text(mrpText,
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 10.5,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.grey.shade500,
                              )),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(Icons.star, size: 12, color: Colors.amber),
                            const SizedBox(width: 2),
                            Text('${p.rating} (${p.reviewCount})',
                                style: const TextStyle(color: AppTheme.grey, fontSize: 10)),
                          ],
                        ),
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

  Widget _buildBottomBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.border),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Security Deposit',
                            style: TextStyle(color: AppTheme.grey, fontSize: 11)),
                        Text(widget.securityDeposit,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAFBF0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.verified_outlined, size: 13, color: Color(0xFF22C55E)),
                              SizedBox(width: 4),
                              Text('Refundable',
                                  style: TextStyle(
                                      color: Color(0xFF15803D), fontWeight: FontWeight.w600, fontSize: 11)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SelectDurationScreen(
                            name: widget.name,
                            price: widget.price,
                            imageUrl: widget.imageUrl,
                            categoryLabel: widget.categoryLabel,
                            imageQuery: widget.imageQuery,
                            rating: widget.rating,
                            reviewCount: widget.reviewCount,
                            securityDeposit: widget.securityDeposit,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Continue',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 14),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _AddToCartButton(
                    onTap: () {
                      CartService.instance.add(
                        name: widget.name,
                        price: widget.price,
                        imageQuery: widget.imageQuery,
                        imageUrl: widget.imageUrl,
                        categoryLabel: widget.categoryLabel,
                        securityDeposit: widget.securityDeposit,
                      );
                      _showAddedToCartToast();
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PrimaryButton(
                    // FIX: this is the one actual change requested —
                    // label only, everything else (onPressed target,
                    // Add to Cart beside it) stays identical.
                    label: widget.isBookingType ? 'BOOK NOW' : 'RENT NOW',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SelectDurationScreen(
                            name: widget.name,
                            price: widget.price,
                            imageUrl: widget.imageUrl,
                            categoryLabel: widget.categoryLabel,
                            imageQuery: widget.imageQuery,
                            rating: widget.rating,
                            reviewCount: widget.reviewCount,
                            securityDeposit: widget.securityDeposit,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAddedToCartToast() {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => _AddedToCartToast(onDone: () => entry.remove()),
    );
    overlay.insert(entry);
  }
}

class _AddToCartButton extends StatelessWidget {
  final VoidCallback onTap;
  const _AddToCartButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Container(
          height: 46,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Text(
            'ADD TO CART',
            textAlign: TextAlign.center,
            maxLines: 1,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}

class _AddedToCartToast extends StatefulWidget {
  final VoidCallback onDone;
  const _AddedToCartToast({required this.onDone});

  @override
  State<_AddedToCartToast> createState() => _AddedToCartToastState();
}

class _AddedToCartToastState extends State<_AddedToCartToast> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 20), () {
      if (mounted) setState(() => _opacity = 1);
    });
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) setState(() => _opacity = 0);
    });
    Future.delayed(const Duration(milliseconds: 2300), widget.onDone);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 24,
      right: 24,
      bottom: 190,
      child: IgnorePointer(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(milliseconds: 250),
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    decoration: const BoxDecoration(
                      color: Color(0xFF22C55E),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check, color: Colors.white, size: 16),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Added to Cart',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}