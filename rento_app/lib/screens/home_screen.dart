// import 'package:flutter/material.dart';
// import 'package:rento_india/delivery/features/rider/presentation/screens/dashboard/rider_home_screen.dart';
// import '../services/cart_service.dart';
// import '../widgets/bottom_nav_bar.dart';
// import '../widgets/nav_helper.dart';
// import 'category_screen.dart';
// import '../services/notification_service.dart';
// import '../theme/app_theme.dart'; // existing — powers borders, greys, success green, etc.
// //import '../constants/app_colors.dart';
// import 'package:rento_india/delivery/core/constants/app_colors.dart'; // richer black-shade + lime accent styling
// import 'category_detail_screen.dart';
// import 'wallet_screen.dart';
// import 'product_details_screen.dart';
// import 'notification_screen.dart';
// import 'package:rento_india/my_house/screens/my_house_home_screen.dart';
// import 'parcel_delivery_screen.dart';
// import '../services/orders_service.dart';
// import 'rental_order.dart';
// import 'package:rento_india/my_house/screens/maintenance_request_screen.dart';
// //import 'my_house_screen.dart';
// import 'package:rento_india/my_house/screens/utility_payments_screen.dart';
// import 'home_services_screen.dart';
// import 'orders_screen.dart';
// import 'featured_products_screen.dart';
// import 'offers_screen.dart';
// import 'package:rento_india/delivery/features/rider/presentation/screens/dashboard/rider_home_screen.dart';
// import 'cart_screen.dart';
// import '../services/location_service.dart';
// import 'package:rento_india/Percel&person/parcel/screens/pickup_address_screen.dart';
// import 'package:rento_india/Percel&person/person/screens/ride_pickup_location_screen.dart';
// import 'package:rento_india/Percel&person/person/screens/ride_history_screen.dart';
// import 'package:rento_india/delivery/features/rider/presentation/screens/registration/aadhaar_verification_screen.dart';
// import 'package:rento_india/delivery/core/routes/route_names.dart';
// import 'category_data.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   List<Map<String, dynamic>> _searchResults = [];

//   bool get _isSearching => _searchController.text.trim().isNotEmpty;

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     LocationService.instance.fetchCurrentLocation();
//   }

//   void _onSearchChanged(String query) {
//     final trimmed = query.trim().toLowerCase();
//     setState(() {
//       if (trimmed.isEmpty) {
//         _searchResults = [];
//       } else {
//         _searchResults = allProducts
//             .where((p) => (p['name'] as String).toLowerCase().contains(trimmed))
//             .toList();
//       }
//     });
//   }

//   // FIX: these 6 cards now use your real local images from
//   // assets/images/rental/ instead of random picsum.photos placeholders.
//   // NOTE: extensions assumed as .png per your filenames — if any of
//   // these are actually .jpg/.jpeg/.webp on disk, update both the path
//   // here AND the matching pubspec.yaml line to match exactly.
//   final List<Map<String, dynamic>> quickActions = [
//     {
//       'title': 'Rent Products',
//       'subtitle': 'Browse and rent quality products',
//       'image': 'assets/images/rental/my_rent.png',
//     },
//     {
//       'title': 'My House',
//       'subtitle': 'Manage your property & tenants',
//       'image': 'assets/images/rental/my_house.png',
//     },
//     {
//       'title': 'Book a ride',
//       'subtitle': 'Book a rider for fast pick-up & delivery',
//       'image': 'assets/images/rental/my_ride.png',
//     },
//     {
//       'title': 'Utility Payments',
//       'subtitle': 'Pay bills for utilities seamlessly',
//       'image': 'assets/images/rental/my_utilitypayment.png',
//     },
//     {
//       'title': 'Maintenance Requests',
//       'subtitle': 'Raise requests for repairs & services',
//       'image': 'assets/images/rental/my_maintancerequest.png',
//     },
//     {
//       'title': 'Track Orders',
//       'subtitle': 'Track your orders in real-time',
//       'image': 'assets/images/rental/my_trackorder.png',
//     },
//     {
//       'title': 'Parcel Delivery',
//       'subtitle': 'Send a parcel with a nearby rider',
//       'image': 'assets/images/rental/my_order.png',
//     },
//   ];

//   // Categories represent product types -> real colorful placeholder photos
//   static const Map<String, String> _categoryImageAssets = {
//     'Furniture': 'assets/images/rental/categories/Furniture.png',
//     'Vehicles': 'assets/images/rental/categories/vehicle.png',
//     'Electronics & Devices':
//         'assets/images/rental/categories/Electronics & Devices.png',
//     'Books & Stationery':
//         'assets/images/rental/categories/Books & Stationery.png',
//     'Clothing & Accessories':
//         'assets/images/rental/categories/clothing and accessories.png',
//     'Machinery & Tools':
//         'assets/images/rental/categories/machinery & tools.png',
//     'Sports Equipment and Gaming':
//         'assets/images/rental/categories/sports & gaming.png',
//     'Toys & Baby Gear':
//         'assets/images/rental/categories/toys and baby gear.png',
//     'Cosmetics & Beauty Equipment':
//         'assets/images/rental/categories/cosmetics & beauty product.png',
//     'Private Rental Jets': 'assets/images/rental/categories/private jet.png',
//     'Boats & Yachts': 'assets/images/rental/categories/boats & yachts.png',
//     'Musical Instruments':
//         'assets/images/rental/categories/Musical Instruments.png',
//     'Home Appliances': 'assets/images/rental/categories/Home appliances.png',
//     'Party & Event Supplies':
//         'assets/images/rental/categories/Party & Event supply.png',
//     'Party Halls': 'assets/images/rental/categories/party Halls.png',
//     // 'Rental House & Apartments' — no asset yet, falls back to network image below.
//     'Medical Equipment':
//         'assets/images/rental/categories/Medical Equipments.png',
//     'Camping & Outdoor Gear':
//         'assets/images/rental/categories/camping & outdoor gear.png',
//     'Construction Equipment':
//         'assets/images/rental/categories/construction equipment.png',
//     'Wedding & Formal Wear':
//         'assets/images/rental/categories/wedding & formal wear.png',
//     'Gardening Tools & Equipment':
//         'assets/images/rental/categories/gardening tools & equipment.png',
//     'Office Equipment (Printers, Projectors, Desks)':
//         'assets/images/rental/categories/office equipments.png',
//     'Photography & Videography Equipment':
//         'assets/images/rental/categories/photo & video equipment.png',
//     'Luxury Cars & Supercars':
//         'assets/images/rental/categories/Luxury cars.png',
//     'Pet Accessories & Supplies':
//         'assets/images/rental/categories/pet accessories & supplies.png',
//     'Hotels and Resorts':
//         'assets/images/rental/categories/Hotels and Resorts.png',
//   };

//   // Built from _categoryImageAssets so there's one source of truth for
//   // category images. Adds one network fallback (no local asset yet) and
//   // a trailing "More" tile.
//   List<Map<String, dynamic>> get categories {
//     final list = _categoryImageAssets.entries
//         .map<Map<String, dynamic>>((e) => {'name': e.key, 'image': e.value})
//         .toList();

//     return list;
//   }

//   final List<Map<String, dynamic>> featuredRentals = [
//     {
//       'name': 'Canon DSLR 1200D',
//       'price': '₹599',
//       'rating': '4.8',
//       'reviews': '120',
//       'badge': 'Popular',
//       'image': 'assets/images/rental/canon_EOS_1200D.jpg',
//       'category': 'DSLR CAMERA',
//       'imageQuery': 'canon dslr camera',
//       'specs': const [
//         SpecItem(
//           icon: Icons.camera_alt_outlined,
//           label: 'Sensor',
//           value: 'APS-C 18MP',
//         ),
//         SpecItem(
//           icon: Icons.videocam_outlined,
//           label: 'Video',
//           value: 'Full HD 1080p',
//         ),
//         SpecItem(
//           icon: Icons.center_focus_strong_outlined,
//           label: 'AF Points',
//           value: '9-Point AF',
//         ),
//         SpecItem(
//           icon: Icons.crop_free_outlined,
//           label: 'Display',
//           value: '3.0" LCD',
//         ),
//       ],
//       'description':
//           'Reliable entry-level DSLR, great for beginners and everyday photography.',
//     },
//     {
//       'name': 'Nordic 3-Seater Sofa',
//       'price': '₹299',
//       'rating': '4.7',
//       'reviews': '86',
//       'badge': 'Trending',
//       'image': 'assets/images/rental/nordic_3seater_sofa.jpg',
//       'category': 'SOFA',
//       'imageQuery': 'nordic sofa furniture',
//       'specs': const [
//         SpecItem(
//           icon: Icons.chair_outlined,
//           label: 'Seating',
//           value: '3 Seater',
//         ),
//         SpecItem(
//           icon: Icons.straighten_outlined,
//           label: 'Dimensions',
//           value: '190 x 85 cm',
//         ),
//         SpecItem(
//           icon: Icons.texture_outlined,
//           label: 'Material',
//           value: 'Fabric',
//         ),
//         SpecItem(
//           icon: Icons.monitor_weight_outlined,
//           label: 'Weight',
//           value: '38kg',
//         ),
//       ],
//       'description':
//           'Comfortable Nordic-style 3-seater sofa, perfect for living rooms.',
//     },
//     {
//       'name': 'Honda Activa 6G',
//       'price': '₹449',
//       'rating': '4.6',
//       'reviews': '98',
//       'badge': 'Hot Deal',
//       'image': 'assets/images/rental/honda_activa_6g.avif',
//       'category': 'SCOOTER',
//       'imageQuery': 'honda activa scooter',
//       'specs': const [
//         SpecItem(
//           icon: Icons.speed_outlined,
//           label: 'Engine',
//           value: '109.51cc',
//         ),
//         SpecItem(
//           icon: Icons.local_gas_station_outlined,
//           label: 'Mileage',
//           value: '~50 km/l',
//         ),
//         SpecItem(
//           icon: Icons.people_outline,
//           label: 'Seating',
//           value: '2 Riders',
//         ),
//         SpecItem(
//           icon: Icons.electric_bolt_outlined,
//           label: 'Start',
//           value: 'Electric/Kick',
//         ),
//       ],
//       'description':
//           'India\'s most trusted scooter — smooth ride, great mileage.',
//     },
//   ];

//   final List<Map<String, dynamic>> trendingRentals = [
//     {
//       'name': 'GoPro Hero 11',
//       'price': '₹399',
//       'rating': '4.9',
//       'reviews': '210',
//       'badge': 'Trending',
//       'image': 'assets/images/rental/gopro_hero_11.jpg',
//       'category': 'ACTION CAMERA',
//       'imageQuery': 'gopro action camera',
//       'specs': const [
//         SpecItem(
//           icon: Icons.camera_alt_outlined,
//           label: 'Resolution',
//           value: '5.3K Video',
//         ),
//         SpecItem(
//           icon: Icons.water_drop_outlined,
//           label: 'Waterproof',
//           value: 'Up to 10m',
//         ),
//         SpecItem(
//           icon: Icons.battery_charging_full_outlined,
//           label: 'Battery',
//           value: '1720mAh',
//         ),
//         SpecItem(
//           icon: Icons.monitor_weight_outlined,
//           label: 'Weight',
//           value: '154g',
//         ),
//       ],
//       'description':
//           'Rugged action camera for adventure, sports, and travel vlogging.',
//     },
//     {
//       'name': 'Recliner Chair',
//       'price': '₹249',
//       'rating': '4.5',
//       'reviews': '64',
//       'badge': 'New',
//       'image': 'assets/images/rental/recliner_chair.jpg',
//       'category': 'RECLINER',
//       'imageQuery': 'recliner chair furniture',
//       'specs': const [
//         SpecItem(
//           icon: Icons.chair_alt_outlined,
//           label: 'Seating',
//           value: '1 Seater',
//         ),
//         SpecItem(
//           icon: Icons.texture_outlined,
//           label: 'Material',
//           value: 'Leatherette',
//         ),
//         SpecItem(
//           icon: Icons.accessibility_new_outlined,
//           label: 'Recline',
//           value: 'Manual',
//         ),
//         SpecItem(
//           icon: Icons.monitor_weight_outlined,
//           label: 'Weight',
//           value: '32kg',
//         ),
//       ],
//       'description':
//           'Plush recliner chair for maximum comfort after a long day.',
//     },
//     {
//       'name': 'Royal Enfield Classic',
//       'price': '₹699',
//       'rating': '4.8',
//       'reviews': '142',
//       'badge': 'Trending',
//       'image': 'assets/images/rental/royal_enfield_classic.jpg',
//       'category': 'MOTORCYCLE',
//       'imageQuery': 'royal enfield motorcycle',
//       'specs': const [
//         SpecItem(icon: Icons.speed_outlined, label: 'Engine', value: '349cc'),
//         SpecItem(
//           icon: Icons.local_gas_station_outlined,
//           label: 'Mileage',
//           value: '~35 km/l',
//         ),
//         SpecItem(
//           icon: Icons.people_outline,
//           label: 'Seating',
//           value: '2 Riders',
//         ),
//         SpecItem(
//           icon: Icons.electric_bolt_outlined,
//           label: 'Start',
//           value: 'Electric',
//         ),
//       ],
//       'description':
//           'Iconic Royal Enfield Classic — timeless design, thumping engine.',
//     },
//   ];

//   // Top Rated Products
//   final List<Map<String, dynamic>> topRatedProducts = [
//     {
//       'name': 'MacBook Pro 14"',
//       'price': '₹1,299',
//       'rating': '4.9',
//       'reviews': '245',
//       'badge': 'Top Rated',
//       'image': 'assets/images/rental/macbook_pro_14.png',
//       'category': 'LAPTOP',
//       'imageQuery': 'macbook pro laptop',
//       'specs': const [
//         SpecItem(icon: Icons.memory_outlined, label: 'Chip', value: 'M3 Pro'),
//         SpecItem(
//           icon: Icons.storage_outlined,
//           label: 'Storage',
//           value: '512GB SSD',
//         ),
//         SpecItem(
//           icon: Icons.monitor_outlined,
//           label: 'Display',
//           value: '14" Liquid Retina',
//         ),
//         SpecItem(
//           icon: Icons.battery_full_outlined,
//           label: 'Battery',
//           value: 'Up to 18 hrs',
//         ),
//       ],
//       'description':
//           'Powerful, portable laptop perfect for work and creative projects.',
//     },
//     {
//       'name': 'King Size Bed Frame',
//       'price': '₹399',
//       'rating': '4.8',
//       'reviews': '132',
//       'badge': 'Top Rated',
//       'image': 'assets/images/rental/king_size_bed_frame.webp',
//       'category': 'BED FRAME',
//       'imageQuery': 'king bed frame',
//       'specs': const [
//         SpecItem(icon: Icons.bed_outlined, label: 'Size', value: 'King'),
//         SpecItem(
//           icon: Icons.texture_outlined,
//           label: 'Material',
//           value: 'Solid Wood',
//         ),
//         SpecItem(
//           icon: Icons.straighten_outlined,
//           label: 'Dimensions',
//           value: '200 x 180 cm',
//         ),
//         SpecItem(
//           icon: Icons.monitor_weight_outlined,
//           label: 'Weight',
//           value: '45kg',
//         ),
//       ],
//       'description': 'Sturdy king-size bed frame with a clean, modern finish.',
//     },
//     {
//       'name': 'DJI Osmo Gimbal',
//       'price': '₹349',
//       'rating': '4.9',
//       'reviews': '178',
//       'badge': 'Top Rated',
//       'image': 'assets/images/rental/dj_osmo_gimbal.webp',
//       'category': 'GIMBAL',
//       'imageQuery': 'camera gimbal stabilizer',
//       'specs': const [
//         SpecItem(
//           icon: Icons.videocam_outlined,
//           label: 'Type',
//           value: '3-Axis Gimbal',
//         ),
//         SpecItem(
//           icon: Icons.battery_charging_full_outlined,
//           label: 'Battery',
//           value: '12 hrs',
//         ),
//         SpecItem(
//           icon: Icons.monitor_weight_outlined,
//           label: 'Payload',
//           value: 'Up to 3kg',
//         ),
//         SpecItem(
//           icon: Icons.bluetooth_outlined,
//           label: 'Connectivity',
//           value: 'Bluetooth',
//         ),
//       ],
//       'description':
//           'Smooth, professional-grade footage stabilization for any camera.',
//     },
//   ];

//   // Combined list used only for the live search feature below.
//   List<Map<String, dynamic>> get allProducts => [
//     ...featuredRentals,
//     ...trendingRentals,
//     ...topRatedProducts,
//   ];

//   // How It Works steps
//   final List<Map<String, dynamic>> howItWorksSteps = [
//     {
//       'step': '1',
//       'title': 'Choose Item',
//       'subtitle': 'Select the product or service',
//       'icon': Icons.touch_app_outlined,
//     },
//     {
//       'step': '2',
//       'title': 'Book or Rent',
//       'subtitle': 'Pick a date and place your order',
//       'icon': Icons.calendar_month_outlined,
//     },
//     {
//       'step': '3',
//       'title': 'We Deliver',
//       'subtitle': 'We deliver it to your location',
//       'icon': Icons.local_shipping_outlined,
//     },
//     {
//       'step': '4',
//       'title': 'Enjoy',
//       'subtitle': 'Use it and return when done',
//       'icon': Icons.sentiment_satisfied_alt_outlined,
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.inputFill,
//       // extendBody lets the ListView scroll underneath the nav bar instead
//       // of Scaffold reserving a solid backgroundColor strip above it — that
//       // reserved strip was the grey rectangle showing behind the bar.
//       extendBody: true,
//       drawer: _buildDrawer(),
//       body: SafeArea(
//         child: Builder(
//           builder: (context) => ListView(
//             padding: const EdgeInsets.all(16),
//             children: [
//               _buildHeader(context),
//               const SizedBox(height: 16),
//               _buildSearchBar(),

//               // ---- If searching, show results INSTEAD of the rest of the home page ----
//               if (_isSearching) ...[
//                 const SizedBox(height: 16),
//                 Text(
//                   '${_searchResults.length} result(s) for "${_searchController.text}"',
//                   style: TextStyle(
//                     color: AppColors.textSecondary,
//                     fontSize: 12,
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 _buildSearchResultsList(),
//               ] else ...[
//                 const SizedBox(height: 22),
//                 const Text(
//                   'What do you want to do?',
//                   style: TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.w700,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//                 const SizedBox(height: 14),
//                 _buildQuickActionsGrid(),
//                 const SizedBox(height: 22),
//                 _buildRecentActivity(),
//                 const SizedBox(height: 22),
//                 _buildReferBanner(),
//                 const SizedBox(height: 24),
//                 _sectionHeader(
//                   'Categories',
//                   () => Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => const CategoryScreen()),
//                   ),
//                 ),
//                 const SizedBox(height: 14),
//                 _buildCategoriesRow(),
//                 const SizedBox(height: 24),
//                 _sectionHeader(
//                   'Featured Products',
//                   () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => const FeaturedProductsScreen(),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 14),
//                 _buildProductCardsRow(featuredRentals),
//                 const SizedBox(height: 24),
//                 _sectionHeader(
//                   'Trending Rentals',
//                   () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => const FeaturedProductsScreen(),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 14),
//                 _buildProductCardsRow(trendingRentals),
//                 const SizedBox(height: 24),
//                 _sectionHeader(
//                   'Offers',
//                   () => Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => const OffersScreen()),
//                   ),
//                 ),
//                 const SizedBox(height: 14),
//                 GestureDetector(
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => const OffersScreen()),
//                   ),
//                   child: _buildFirstRentalBanner(),
//                 ),
//                 const SizedBox(height: 24),
//                 _sectionHeader(
//                   'Top Rated Products',
//                   () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => const FeaturedProductsScreen(),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 14),
//                 _buildProductCardsRow(topRatedProducts),
//                 const SizedBox(height: 24),
//                 const Text(
//                   'How It Works',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w700,
//                     fontSize: 16,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//                 const SizedBox(height: 14),
//                 _buildHowItWorks(),
//                 const SizedBox(height: 28),
//                 _buildLoveFooter(),
//                 const SizedBox(height: 12),
//               ],
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: RentoBottomNavBar(
//         currentIndex: 0,
//         onTap: (i) => navigateToTab(context, i),
//       ),
//     );
//   }

//   // ---------- DRAWER (compact, professional) ----------
//   Widget _buildDrawer() {
//     return Drawer(
//       width: 260,
//       backgroundColor: AppColors.pureWhite,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
//       ),
//       child: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Compact header — logo mark + name, not a full-height banner.
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       color: AppColors.primaryBlack,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: Image.asset(
//                         'assets/images/rental/rento_india_Logo.png',
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   const Text(
//                     'Rento India',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w800,
//                       fontSize: 16,
//                       color: AppColors.textPrimary,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Divider(height: 1, color: AppColors.divider),
//             const SizedBox(height: 2),
//             _drawerTile(
//               Icons.home_outlined,
//               'Home',
//               () => Navigator.pop(context),
//             ),
//             _drawerTile(Icons.house_outlined, 'My House', () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const myhousehomescreen()),
//               );
//             }),
//             _drawerTile(Icons.receipt_long_outlined, 'Orders', () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const OrdersScreen()),
//               );
//             }),
//             // "Rider" here refers to the driver-onboarding flow
//             // (become a rider), so this one intentionally stays on
//             // AadhaarVerificationScreen — separate from "Book a Ride"
//             // below, which is the customer-facing ride-booking flow.
//             _drawerTile(Icons.badge_outlined, 'Become a Rider', () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => const AadhaarVerificationScreen(),
//                 ),
//               );
//             }),
//             _drawerTile(Icons.account_balance_wallet_outlined, 'Wallet', () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const WalletScreen()),
//               );
//             }),
//             // FIX: Parcel Delivery now shows a red "NEW" ribbon tag next to its
//             // label, and the label text itself is rendered with a rainbow
//             // gradient (via ShaderMask) to call extra attention to it.
//             _drawerTile(
//               Icons.inventory_2_outlined,
//               'Parcel Delivery',
//               () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const PickupAddressScreen(),
//                   ),
//                 );
//               },
//               showNewBadge: true,
//               rainbowText: true,
//             ),
//             // FIX: Book a Ride gets the same "NEW" ribbon tag + rainbow text
//             // treatment as Parcel Delivery above.
//             _drawerTile(
//               Icons.directions_car_outlined,
//               'Book a Ride',
//               () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const RidePickupLocationScreen(),
//                   ),
//                 );
//               },
//               showNewBadge: true,
//               rainbowText: true,
//             ),

//             _drawerTile(Icons.history_outlined, ' Ride history', () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const RideHistoryScreen()),
//               );
//             }),
//             _drawerTile(Icons.person_outline, 'Profile', () {
//               Navigator.pop(context);
//               navigateToTab(context, 4);
//             }),
//           ],
//         ),
//       ),
//     );
//   }

//   // FIX: added optional `showNewBadge` and `rainbowText` params (both
//   // default false, so every other call site above is unaffected).
//   // - showNewBadge: renders a small red "NEW" ribbon-style tag after the label.
//   // - rainbowText: renders the label with a rainbow gradient using ShaderMask
//   //   instead of the normal solid text color.
//   Widget _drawerTile(
//     IconData icon,
//     String label,
//     VoidCallback onTap, {
//     bool showNewBadge = false,
//     bool rainbowText = false,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//         child: Row(
//           children: [
//             Icon(icon, size: 20, color: AppColors.textPrimary),
//             const SizedBox(width: 14),
//             rainbowText
//                 ? ShaderMask(
//                     shaderCallback: (bounds) => const LinearGradient(
//                       colors: [
//                         Colors.red,
//                         Colors.orange,
//                         Colors.yellow,
//                         Colors.green,
//                         Colors.blue,
//                         Colors.indigo,
//                         Colors.purple,
//                       ],
//                     ).createShader(bounds),
//                     child: Text(
//                       label,
//                       style: const TextStyle(
//                         fontSize: 13.5,
//                         fontWeight: FontWeight.w600,
//                         // ShaderMask paints over this color, so it must be
//                         // opaque (white) for the gradient to render fully.
//                         color: Colors.white,
//                       ),
//                     ),
//                   )
//                 : Text(
//                     label,
//                     style: const TextStyle(
//                       fontSize: 13.5,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textPrimary,
//                     ),
//                   ),
//             if (showNewBadge) ...[
//               const SizedBox(width: 8),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                 decoration: BoxDecoration(
//                   color: Colors.red,
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: const Text(
//                   'NEW',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 8,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 0.3,
//                   ),
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // ---- TOP ROW: Logo + Location only ----
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(24),
//               child: Image.asset(
//                 'assets/images/rental/rento_india_Logo.png',
//                 width: 42,
//                 height: 42,
//                 fit: BoxFit.cover,
//                 errorBuilder: (_, __, ___) => Container(
//                   width: 42,
//                   height: 42,
//                   decoration: const BoxDecoration(
//                     color: AppColors.primaryBlack,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.location_pin,
//                     color: AppColors.pureWhite,
//                     size: 22,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: AnimatedBuilder(
//                 animation: LocationService.instance,
//                 builder: (context, _) {
//                   final loc = LocationService.instance;
//                   return GestureDetector(
//                     onTap: () =>
//                         LocationService.instance.fetchCurrentLocation(),
//                     child: Row(
//                       children: [
//                         const Icon(
//                           Icons.location_on,
//                           size: 15,
//                           color: AppColors.primaryBlack,
//                         ),
//                         const SizedBox(width: 4),
//                         Expanded(
//                           child: loc.isLoading
//                               ? Text(
//                                   'Fetching your location...',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 11,
//                                     color: AppColors.textSecondary,
//                                   ),
//                                 )
//                               : Text(
//                                   loc.address,
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 11,
//                                     color: AppColors.textPrimary,
//                                   ),
//                                 ),
//                         ),
//                         const Icon(
//                           Icons.my_location,
//                           size: 13,
//                           color: AppColors.primaryBlack,
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),

//         const SizedBox(height: 12),

//         // ---- SECOND ROW: Menu (left) + Cart + Bell (right) ----
//         Row(
//           children: [
//             Builder(
//               builder: (context) => GestureDetector(
//                 onTap: () => Scaffold.of(context).openDrawer(),
//                 child: const Padding(
//                   padding: EdgeInsets.only(right: 8),
//                   child: Icon(
//                     Icons.menu,
//                     size: 22,
//                     color: AppColors.primaryBlack,
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: SizedBox(
//                 height: 32,
//                 child: _RunningNewsBanner(
//                   messages: const [
//                     '🔥 Canon DSLR Camera — Rent from ₹499/day',
//                     '🎮 PlayStation 5 — Rent from ₹299/day',
//                     '📱 iPhone 15 Pro — Rent from ₹799/day',
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8),
//             AnimatedBuilder(
//               animation: CartService.instance,
//               builder: (context, _) => GestureDetector(
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const CartScreen()),
//                 ),
//                 child: _iconWithBadge(
//                   Icons.shopping_cart_outlined,
//                   CartService.instance.unseenCount,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 12),
//             AnimatedBuilder(
//               animation: NotificationService.instance,
//               builder: (context, _) => GestureDetector(
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const NotificationScreen()),
//                 ),
//                 child: _iconWithBadge(
//                   Icons.notifications_none_rounded,
//                   NotificationService.instance.unreadCount,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   void _showLocationPicker(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         final addresses = [
//           '12, Nagoji Rao Street, Narayana Kishnar, Hyderabad',
//           'Mumbai, 400001',
//           'Delhi, 110001',
//           'Bangalore, 560001',
//         ];
//         return SafeArea(
//           child: ListView(
//             shrinkWrap: true,
//             padding: const EdgeInsets.all(16),
//             children: [
//               const Text(
//                 'Select Address',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w700,
//                   fontSize: 16,
//                   color: AppColors.textPrimary,
//                 ),
//               ),
//               const SizedBox(height: 12),
//               ...addresses.map(
//                 (a) => ListTile(
//                   leading: const Icon(Icons.location_on_outlined),
//                   title: Text(a),
//                   onTap: () => Navigator.pop(context),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // Cart/notification badge uses the lime accent — icon-only color per house style.
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
//               decoration: const BoxDecoration(
//                 color: AppColors.accentLime,
//                 shape: BoxShape.circle,
//               ),
//               constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
//               child: Text(
//                 '$count',
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   color: AppColors.primaryBlack,
//                   fontSize: 9,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _sectionHeader(String title, VoidCallback onSeeAll) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             fontWeight: FontWeight.w700,
//             fontSize: 16,
//             color: AppColors.textPrimary,
//           ),
//         ),
//         GestureDetector(
//           onTap: onSeeAll,
//           child: const Text(
//             'See all',
//             style: TextStyle(
//               color: AppColors.textPrimary,
//               fontWeight: FontWeight.w600,
//               fontSize: 13,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // ---------- SEARCH BAR ----------
//   Widget _buildSearchBar() {
//     return Container(
//       height: 50,
//       padding: const EdgeInsets.symmetric(horizontal: 14),
//       decoration: BoxDecoration(
//         color: AppColors.pureWhite,
//         borderRadius: BorderRadius.circular(30),
//         border: Border.all(color: AppColors.border),
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.search, color: AppColors.textSecondary, size: 20),
//           const SizedBox(width: 8),
//           Expanded(
//             child: TextField(
//               controller: _searchController,
//               onChanged: _onSearchChanged,
//               style: const TextStyle(
//                 fontSize: 13.5,
//                 color: AppColors.textPrimary,
//               ),
//               cursorColor: AppColors.primaryBlack,
//               decoration: InputDecoration(
//                 isCollapsed: true,
//                 filled: true,
//                 fillColor: Colors.transparent,
//                 hintText: 'Search for items, properties, tenants...',
//                 hintStyle: TextStyle(color: AppColors.textHint, fontSize: 13),
//                 border: InputBorder.none,
//                 enabledBorder: InputBorder.none,
//                 focusedBorder: InputBorder.none,
//                 disabledBorder: InputBorder.none,
//                 contentPadding: EdgeInsets.zero,
//               ),
//             ),
//           ),
//           if (_isSearching)
//             GestureDetector(
//               onTap: () {
//                 _searchController.clear();
//                 _onSearchChanged('');
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

//   // ---------- LIVE SEARCH RESULTS ----------
//   Widget _buildSearchResultsList() {
//     if (_searchResults.isEmpty) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 30),
//         child: Center(
//           child: Text(
//             'No products found.',
//             style: TextStyle(color: AppColors.textHint),
//           ),
//         ),
//       );
//     }
//     return Column(
//       children: _searchResults.map((r) {
//         return GestureDetector(
//           onTap: () => Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => ProductDetailsScreen(
//                 name: r['name'],
//                 price: r['price'],
//                 categoryLabel: r['category'],
//                 imageQuery: r['imageQuery'],
//                 rating: double.parse(r['rating']),
//                 reviewCount: int.parse(r['reviews']),
//                 specs: r['specs'],
//                 description: r['description'],
//               ),
//             ),
//           ),
//           child: Container(
//             margin: const EdgeInsets.only(bottom: 10),
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: AppColors.pureWhite,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: AppColors.border),
//             ),
//             child: Row(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Image.network(
//                     r['image'],
//                     width: 60,
//                     height: 60,
//                     fit: BoxFit.cover,
//                     errorBuilder: (_, __, ___) => Container(
//                       width: 60,
//                       height: 60,
//                       color: AppColors.inputFill,
//                       child: const Icon(
//                         Icons.image_outlined,
//                         color: AppColors.textHint,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         r['name'],
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w700,
//                           fontSize: 13,
//                           color: AppColors.textPrimary,
//                         ),
//                       ),
//                       Text(
//                         '${r['price']} /day',
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w700,
//                           fontSize: 12,
//                           color: AppColors.textPrimary,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           const Icon(Icons.star, size: 12, color: Colors.amber),
//                           const SizedBox(width: 3),
//                           Text(
//                             '${r['rating']} (${r['reviews']})',
//                             style: TextStyle(
//                               fontSize: 10.5,
//                               color: AppColors.textSecondary,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Icon(Icons.chevron_right, color: AppColors.textHint),
//               ],
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   // ---------- QUICK ACTIONS GRID ----------
//   // UPDATED DESIGN: full-bleed photo card, dark gradient overlay from the
//   // bottom for legibility, and the title + subtitle sit directly on top
//   // of the image (bottom-left) instead of in a separate white footer
//   // strip with an arrow icon. Matches the reference design.
//   Widget _buildQuickActionsGrid() {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: quickActions.length,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         mainAxisSpacing: 10,
//         crossAxisSpacing: 8,
//         childAspectRatio: 0.80,
//       ),
//       itemBuilder: (context, i) {
//         final a = quickActions[i];
//         return GestureDetector(
//           onTap: () => _handleQuickAction(i),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(16),
//             child: Stack(
//               fit: StackFit.expand,
//               children: [
//                 // Background photo
//                 Image.asset(
//                   a['image'],
//                   fit: BoxFit.cover,
//                   errorBuilder: (_, __, ___) => Container(
//                     color: AppColors.inputFill,
//                     child: const Icon(
//                       Icons.image_outlined,
//                       color: AppColors.textHint,
//                       size: 24,
//                     ),
//                   ),
//                 ),
//                 // Bottom-up dark gradient so white text stays legible
//                 // over any photo, bright or dark.
//                 DecoratedBox(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       stops: const [0.35, 1.0],
//                       colors: [
//                         Colors.black.withOpacity(0.0),
//                         Colors.black.withOpacity(0.78),
//                       ],
//                     ),
//                   ),
//                 ),
//                 // Title + subtitle overlaid at the bottom of the card
//                 Positioned(
//                   left: 10,
//                   right: 10,
//                   bottom: 10,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         a['title'],
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w800,
//                           fontSize: 12.5,
//                           height: 1.15,
//                           color: Colors.white,
//                         ),
//                       ),
//                       const SizedBox(height: 2),
//                       Text(
//                         a['subtitle'],
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 9,
//                           height: 1.2,
//                           color: Colors.white.withOpacity(0.88),
//                         ),
//                       ),
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

//   // Indices match the current 6-item quickActions list (Home Services
//   // was already removed).
//   // FIX: index 2 ("Rider Booking" / Book a Ride) now opens
//   // RidePickupLocationScreen (customer ride booking) instead of
//   // AadhaarVerificationScreen (driver onboarding) — that was the
//   // wrong screen being wired to this card.
//   void _handleQuickAction(int index) {
//     switch (index) {
//       case 0: // Rent Products
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => const CategoryScreen()),
//         );
//         break;
//       case 1: // My House
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => const myhousehomescreen()),
//         );
//         break;
//       case 2: // Book a Ride
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => const RidePickupLocationScreen()),
//         );
//         break;
//       case 3: // Utility Payments
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => const UtilityPaymentsScreen()),
//         );
//         break;
//       case 4: // Maintenance Requests
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => const MaintenanceRequestScreen()),
//         );
//         break;
//       case 5: // Track Orders
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => const OrdersScreen()),
//         );
//         break;
//       case 6: // Parcel Delivery
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => const PickupAddressScreen()),
//         );
//         break;
//       case 7: // book a ride
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => const RidePickupLocationScreen()),
//         );
//         break;
//       case 8: //  ride of history
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => const RideHistoryScreen()),
//         );
//         break;
//     }
//   }

//   // ---------- RECENT ACTIVITY ----------
//   Widget _buildRecentActivity() {
//     return AnimatedBuilder(
//       animation: OrdersService.instance,
//       builder: (context, _) {
//         final recent = OrdersService.instance.orders.take(2).toList();

//         return Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: AppColors.pureWhite,
//             borderRadius: BorderRadius.circular(14),
//             border: Border.all(color: AppColors.border),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _sectionHeader(
//                 'Recent Activity',
//                 () => Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const OrdersScreen()),
//                 ),
//               ),
//               const SizedBox(height: 14),
//               if (recent.isEmpty)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 6),
//                   child: Text(
//                     'No orders yet. Rent something to see it here.',
//                     style: TextStyle(color: AppColors.textHint, fontSize: 12),
//                   ),
//                 )
//               else if (recent.length == 1)
//                 _activityItem(recent[0])
//               else
//                 Row(
//                   children: [
//                     Expanded(child: _activityItem(recent[0])),
//                     Container(width: 1, height: 44, color: AppColors.divider),
//                     const SizedBox(width: 12),
//                     Expanded(child: _activityItem(recent[1])),
//                   ],
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _activityItem(RentalOrder order) {
//     return Row(
//       children: [
//         ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: Image.network(
//             'https://loremflickr.com/100/100/${order.imageQuery.replaceAll(' ', ',')}?lock=${order.name.hashCode.abs() % 5000}',
//             width: 44,
//             height: 44,
//             fit: BoxFit.cover,
//             errorBuilder: (_, __, ___) => Container(
//               width: 44,
//               height: 44,
//               color: AppColors.inputFill,
//               child: const Icon(
//                 Icons.image_outlined,
//                 color: AppColors.textHint,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 order.name,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w700,
//                   fontSize: 13,
//                   color: AppColors.textPrimary,
//                 ),
//               ),
//               // Completed orders use the app's established success green;
//               // every other in-flight status uses plain dark text instead
//               // of an arbitrary color.
//               Text(
//                 order.status.label,
//                 style: TextStyle(
//                   color: order.status == OrderStatus.completed
//                       ? AppTheme.success
//                       : AppColors.textPrimary,
//                   fontSize: 11,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               Text(
//                 _timeAgo(order.id),
//                 style: TextStyle(color: AppColors.textHint, fontSize: 10),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // RentalOrder's id is set from DateTime.now().microsecondsSinceEpoch
//   // when the order was placed, so it doubles as a creation timestamp
//   // until a dedicated `createdAt` field exists on the model.
//   String _timeAgo(String orderId) {
//     final micros = int.tryParse(orderId);
//     if (micros == null) return '';
//     final placedAt = DateTime.fromMicrosecondsSinceEpoch(micros);
//     final diff = DateTime.now().difference(placedAt);
//     if (diff.inDays > 0) return '${diff.inDays}d ago';
//     if (diff.inHours > 0) return '${diff.inHours}h ago';
//     if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
//     return 'just now';
//   }

//   // ---------- REFER & EARN ----------
//   Widget _buildReferBanner() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: AppColors.inputFill,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Stack(
//         children: [
//           Positioned(
//             right: 0,
//             top: 0,
//             bottom: 0,
//             child: Icon(
//               Icons.card_giftcard,
//               color: AppColors.primaryBlack.withOpacity(0.08),
//               size: 90,
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Refer & Earn',
//                 style: TextStyle(
//                   fontSize: 17,
//                   fontWeight: FontWeight.w700,
//                   color: AppColors.textPrimary,
//                 ),
//               ),
//               const SizedBox(height: 6),
//               SizedBox(
//                 width: 220,
//                 child: Text(
//                   'Invite friends and earn exciting rewards on every referral!',
//                   style: TextStyle(
//                     color: AppColors.textSecondary,
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 14),
//               GestureDetector(
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const OffersScreen()),
//                 ),
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 10,
//                   ),
//                   decoration: BoxDecoration(
//                     color: AppColors.primaryBlack,
//                     borderRadius: BorderRadius.circular(24),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: const [
//                       Text(
//                         'REFER & EARN',
//                         style: TextStyle(
//                           color: AppColors.pureWhite,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 12,
//                         ),
//                       ),
//                       SizedBox(width: 6),
//                       Icon(
//                         Icons.arrow_forward,
//                         color: AppColors.pureWhite,
//                         size: 14,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // ---------- CATEGORIES ----------
//   Widget _buildCategoriesRow() {
//     return SizedBox(
//       height: 86,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         itemCount: categories.length,
//         separatorBuilder: (_, __) => const SizedBox(width: 4),
//         itemBuilder: (context, i) {
//           final c = categories[i];
//           final imagePath = c['image'] as String?;
//           final isAsset = imagePath != null && imagePath.startsWith('assets/');
//           final isNetwork = imagePath != null && imagePath.startsWith('http');

//           return GestureDetector(
//             onTap: () {
//               if (c['name'] == 'More') {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const CategoryScreen()),
//                 );
//               } else {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) =>
//                         CategoryDetailScreen(categoryName: c['name']),
//                   ),
//                 );
//               }
//             },
//             child: SizedBox(
//               width: 56,
//               child: Column(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(28),
//                     child: isAsset
//                         ? Image.asset(
//                             imagePath,
//                             width: 56,
//                             height: 56,
//                             fit: BoxFit.cover,
//                             errorBuilder: (_, __, ___) => _categoryFallback(),
//                           )
//                         : isNetwork
//                         ? Image.network(
//                             imagePath,
//                             width: 56,
//                             height: 56,
//                             fit: BoxFit.cover,
//                             errorBuilder: (_, __, ___) => _categoryFallback(),
//                           )
//                         : Container(
//                             width: 56,
//                             height: 56,
//                             color: AppColors.inputFill,
//                             child: Icon(
//                               c['icon'] as IconData? ?? Icons.category_outlined,
//                               size: 24,
//                               color: AppColors.textPrimary,
//                             ),
//                           ),
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     c['name'],
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       fontSize: 11,
//                       color: AppColors.textPrimary,
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

//   Widget _categoryFallback() => Container(
//     width: 56,
//     height: 56,
//     color: AppColors.inputFill,
//     child: const Icon(Icons.image_outlined, color: AppColors.textHint),
//   );
//   // ---------- PRODUCT CARDS ROW ----------
//   Widget _buildProductCardsRow(List<Map<String, dynamic>> items) {
//     return SizedBox(
//       height: 210,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         itemCount: items.length,
//         separatorBuilder: (_, __) => const SizedBox(width: 14),
//         itemBuilder: (context, i) {
//           final r = items[i];
//           return GestureDetector(
//             onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => ProductDetailsScreen(
//                   name: r['name'],
//                   price: r['price'],
//                   imageUrl: r['image'],
//                   categoryLabel: r['category'],
//                   imageQuery: r['imageQuery'],
//                   rating: double.parse(r['rating']),
//                   reviewCount: int.parse(r['reviews']),
//                   specs: r['specs'],
//                   description: r['description'],
//                 ),
//               ),
//             ),
//             child: Container(
//               width: 165,
//               decoration: BoxDecoration(
//                 color: AppColors.pureWhite,
//                 borderRadius: BorderRadius.circular(14),
//                 border: Border.all(color: AppColors.border),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Stack(
//                     children: [
//                       ClipRRect(
//                         borderRadius: const BorderRadius.vertical(
//                           top: Radius.circular(14),
//                         ),
//                         child: Image.network(
//                           r['image'],
//                           height: 100,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                           errorBuilder: (_, __, ___) => Container(
//                             height: 100,
//                             color: AppColors.inputFill,
//                             child: const Icon(
//                               Icons.image_outlined,
//                               color: AppColors.textHint,
//                               size: 32,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         top: 8,
//                         left: 8,
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 8,
//                             vertical: 3,
//                           ),
//                           decoration: BoxDecoration(
//                             color: AppColors.primaryBlack,
//                             borderRadius: BorderRadius.circular(6),
//                           ),
//                           child: Text(
//                             r['badge'],
//                             style: const TextStyle(
//                               color: AppColors.pureWhite,
//                               fontSize: 9,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           r['name'],
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w700,
//                             fontSize: 12.5,
//                             color: AppColors.textPrimary,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           '${r['price']} /day',
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w700,
//                             fontSize: 13,
//                             color: AppColors.textPrimary,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Row(
//                           children: [
//                             const Icon(
//                               Icons.star,
//                               size: 13,
//                               color: Colors.amber,
//                             ),
//                             const SizedBox(width: 3),
//                             Text(
//                               '${r['rating']} (${r['reviews']})',
//                               style: TextStyle(
//                                 fontSize: 10.5,
//                                 color: AppColors.textSecondary,
//                               ),
//                             ),
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

//   // ---------- HOW IT WORKS ----------
//   Widget _buildHowItWorks() {
//     return Row(
//       children: howItWorksSteps
//           .map(
//             (s) => Expanded(
//               child: Column(
//                 children: [
//                   Container(
//                     width: 44,
//                     height: 44,
//                     decoration: BoxDecoration(
//                       color: AppColors.inputFill,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Stack(
//                       children: [
//                         Center(
//                           child: Icon(
//                             s['icon'],
//                             size: 18,
//                             color: AppColors.textPrimary,
//                           ),
//                         ),
//                         Positioned(
//                           right: 0,
//                           bottom: 0,
//                           child: Container(
//                             width: 16,
//                             height: 16,
//                             decoration: const BoxDecoration(
//                               color: AppColors.primaryBlack,
//                               shape: BoxShape.circle,
//                             ),
//                             child: Center(
//                               child: Text(
//                                 s['step'],
//                                 style: const TextStyle(
//                                   color: AppColors.pureWhite,
//                                   fontSize: 9,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     s['title'],
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: 10.5,
//                       color: AppColors.textPrimary,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     s['subtitle'],
//                     textAlign: TextAlign.center,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(fontSize: 8.5, color: AppColors.textHint),
//                   ),
//                 ],
//               ),
//             ),
//           )
//           .toList(),
//     );
//   }

//   // ---------- MADE WITH LOVE FOOTER ----------
//   Widget _buildLoveFooter() {
//     return Center(
//       child: Column(
//         children: [
//           Text.rich(
//             TextSpan(
//               style: TextStyle(fontSize: 11.5, color: AppColors.textHint),
//               children: const [
//                 TextSpan(text: 'Made with '),
//                 TextSpan(
//                   text: '❤️',
//                   style: TextStyle(color: AppColors.error),
//                 ),
//                 TextSpan(text: ' for Love'),
//               ],
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             'Rent Anything, Anytime, Anywhere.',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 11,
//               fontWeight: FontWeight.w600,
//               color: AppColors.textSecondary,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ---------- FIRST RENTAL FREE BANNER ----------
//   Widget _buildFirstRentalBanner() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.inputFill,
//         borderRadius: BorderRadius.circular(14),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.local_offer, color: AppColors.accentLime, size: 30),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'First Rental FREE!',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w700,
//                     fontSize: 14,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//                 Text.rich(
//                   TextSpan(
//                     text: 'Use code: ',
//                     style: TextStyle(
//                       color: AppColors.textSecondary,
//                       fontSize: 11,
//                     ),
//                     children: const [
//                       TextSpan(
//                         text: 'RENTO1ST',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w700,
//                           color: AppColors.primaryBlack,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Text(
//                   'Valid on your first rental',
//                   style: TextStyle(
//                     color: AppColors.textSecondary,
//                     fontSize: 10,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//             decoration: BoxDecoration(
//               color: AppColors.primaryBlack,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: const Text(
//               'CLAIM NOW',
//               style: TextStyle(
//                 color: AppColors.pureWhite,
//                 fontWeight: FontWeight.w700,
//                 fontSize: 11,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _RunningNewsBanner extends StatefulWidget {
//   final List<String> messages;
//   const _RunningNewsBanner({required this.messages});

//   @override
//   State<_RunningNewsBanner> createState() => _RunningNewsBannerState();
// }

// class _RunningNewsBannerState extends State<_RunningNewsBanner>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _controller;
//   final GlobalKey _textKey = GlobalKey();
//   double _textWidth = 0;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 16),
//     )..repeat();
//     WidgetsBinding.instance.addPostFrameCallback((_) => _measure());
//   }

//   void _measure() {
//     final box = _textKey.currentContext?.findRenderObject() as RenderBox?;
//     if (box != null && mounted) {
//       setState(() => _textWidth = box.size.width);
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final combined = '${widget.messages.join('   •   ')}   •   ';
//     final textStyle = const TextStyle(
//       color: Colors.white,
//       fontSize: 11,
//       fontWeight: FontWeight.w600,
//     );

//     return Container(
//       height: 32,
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       decoration: BoxDecoration(
//         color: AppColors.primaryBlack,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: [
//           const Icon(
//             Icons.campaign_outlined,
//             color: AppColors.accentLime,
//             size: 14,
//           ),
//           const SizedBox(width: 8),
//           Expanded(
//             child: ClipRect(
//               child: SizedBox(
//                 height: 32,
//                 child: Stack(
//                   clipBehavior: Clip.none,
//                   children: [
//                     AnimatedBuilder(
//                       animation: _controller,
//                       builder: (context, child) {
//                         final offset = _textWidth == 0
//                             ? 0.0
//                             : -(_controller.value * _textWidth);
//                         return Stack(
//                           clipBehavior: Clip.none,
//                           children: [
//                             Positioned(
//                               left: offset,
//                               top: 0,
//                               bottom: 0,
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   combined,
//                                   key: _textKey,
//                                   maxLines: 1,
//                                   style: textStyle,
//                                 ),
//                               ),
//                             ),
//                             if (_textWidth > 0)
//                               Positioned(
//                                 left: offset + _textWidth,
//                                 top: 0,
//                                 bottom: 0,
//                                 child: Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     combined,
//                                     maxLines: 1,
//                                     style: textStyle,
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         );
//                       },
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
// }


import 'package:flutter/material.dart';
import 'package:rento_india/delivery/features/rider/presentation/screens/dashboard/rider_home_screen.dart';
import '../services/cart_service.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/nav_helper.dart';
import 'category_screen.dart';
import '../services/notification_service.dart';
import '../theme/app_theme.dart'; // existing — powers borders, greys, success green, etc.
//import '../constants/app_colors.dart';
import 'package:rento_india/delivery/core/constants/app_colors.dart'; // richer black-shade + lime accent styling
import 'category_detail_screen.dart';
import 'wallet_screen.dart';
import 'product_details_screen.dart';
import 'notification_screen.dart';
import 'package:rento_india/my_house/screens/my_house_home_screen.dart';
import 'parcel_delivery_screen.dart';
import '../services/orders_service.dart';
import 'rental_order.dart';
import 'package:rento_india/my_house/screens/maintenance_request_screen.dart';
//import 'my_house_screen.dart';
import 'package:rento_india/my_house/screens/utility_payments_screen.dart';
import 'home_services_screen.dart';
import 'orders_screen.dart';
import 'featured_products_screen.dart';
import 'offers_screen.dart';
import 'package:rento_india/delivery/features/rider/presentation/screens/dashboard/rider_home_screen.dart';
import 'cart_screen.dart';
import '../services/location_service.dart';
import 'package:rento_india/Percel&person/parcel/screens/pickup_address_screen.dart';
import 'package:rento_india/Percel&person/person/screens/ride_pickup_location_screen.dart';
import 'package:rento_india/Percel&person/person/screens/ride_history_screen.dart';
import 'package:rento_india/delivery/features/rider/presentation/screens/registration/aadhaar_verification_screen.dart';
import 'package:rento_india/delivery/core/routes/route_names.dart';
import 'category_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  bool get _isSearching => _searchController.text.trim().isNotEmpty;

  // TODO: replace with your real wallet balance source, e.g.
  // WalletService.instance.coins (a ChangeNotifier, same pattern as
  // CartService / NotificationService), once that exists. Whatever value
  // ends up here, the badge on the Rento Wallet quick-action tile will
  // automatically count up/down to it instead of snapping to the new number.
  int _walletCoins = 12;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    LocationService.instance.fetchCurrentLocation();
  }

  void _onSearchChanged(String query) {
    final trimmed = query.trim().toLowerCase();
    setState(() {
      if (trimmed.isEmpty) {
        _searchResults = [];
      } else {
        _searchResults = allProducts
            .where((p) => (p['name'] as String).toLowerCase().contains(trimmed))
            .toList();
      }
    });
  }

  // FIX: these 6 cards now use your real local images from
  // assets/images/rental/ instead of random picsum.photos placeholders.
  // NOTE: extensions assumed as .png per your filenames — if any of
  // these are actually .jpg/.jpeg/.webp on disk, update both the path
  // here AND the matching pubspec.yaml line to match exactly.
  //
  // NEW: 'Rento Wallet' tile added at the end (fills the previously empty
  // grid slot). It's just a poster-style photo card like the others —
  // 'isWallet': true marks it so the grid can overlay the small animated
  // coin-count badge on this tile only. No text/number/button overlay is
  // added beyond that badge, per the requested design.
  final List<Map<String, dynamic>> quickActions = [
    {
      'title': 'Rent Products',
      'subtitle': 'Browse and rent quality products',
      'image': 'assets/images/rental/my_rent.png',
    },
    {
      'title': 'My House',
      'subtitle': 'Manage your property & tenants',
      'image': 'assets/images/rental/my_house.png',
    },
    {
      'title': 'Book a ride',
      'subtitle': 'Book a rider for fast pick-up & delivery',
      'image': 'assets/images/rental/my_ride.png',
    },
    {
      'title': 'Utility Payments',
      'subtitle': 'Pay bills for utilities seamlessly',
      'image': 'assets/images/rental/my_utilitypayment.png',
    },
    {
      'title': 'Maintenance Requests',
      'subtitle': 'Raise requests for repairs & services',
      'image': 'assets/images/rental/my_maintancerequest.png',
    },
    {
      'title': 'Track Orders',
      'subtitle': 'Track your orders in real-time',
      'image': 'assets/images/rental/my_trackorder.png',
    },
    {
      'title': 'Parcel Delivery',
      'subtitle': 'Send a parcel with a nearby rider',
      'image': 'assets/images/rental/my_order.png',
    },
  ];

  // Categories represent product types -> real colorful placeholder photos
  static const Map<String, String> _categoryImageAssets = {
    'Furniture': 'assets/images/rental/categories/Furniture.png',
    'Vehicles': 'assets/images/rental/categories/vehicle.png',
    'Electronics & Devices':
        'assets/images/rental/categories/Electronics & Devices.png',
    'Books & Stationery':
        'assets/images/rental/categories/Books & Stationery.png',
    'Clothing & Accessories':
        'assets/images/rental/categories/clothing and accessories.png',
    'Machinery & Tools':
        'assets/images/rental/categories/machinery & tools.png',
    'Sports Equipment and Gaming':
        'assets/images/rental/categories/sports & gaming.png',
    'Toys & Baby Gear':
        'assets/images/rental/categories/toys and baby gear.png',
    'Cosmetics & Beauty Equipment':
        'assets/images/rental/categories/cosmetics & beauty product.png',
    'Private Rental Jets': 'assets/images/rental/categories/private jet.png',
    'Boats & Yachts': 'assets/images/rental/categories/boats & yachts.png',
    'Musical Instruments':
        'assets/images/rental/categories/Musical Instruments.png',
    'Home Appliances': 'assets/images/rental/categories/Home appliances.png',
    'Party & Event Supplies':
        'assets/images/rental/categories/Party & Event supply.png',
    'Party Halls': 'assets/images/rental/categories/party Halls.png',
    // 'Rental House & Apartments' — no asset yet, falls back to network image below.
    'Medical Equipment':
        'assets/images/rental/categories/Medical Equipments.png',
    'Camping & Outdoor Gear':
        'assets/images/rental/categories/camping & outdoor gear.png',
    'Construction Equipment':
        'assets/images/rental/categories/construction equipment.png',
    'Wedding & Formal Wear':
        'assets/images/rental/categories/wedding & formal wear.png',
    'Gardening Tools & Equipment':
        'assets/images/rental/categories/gardening tools & equipment.png',
    'Office Equipment (Printers, Projectors, Desks)':
        'assets/images/rental/categories/office equipments.png',
    'Photography & Videography Equipment':
        'assets/images/rental/categories/photo & video equipment.png',
    'Luxury Cars & Supercars':
        'assets/images/rental/categories/Luxury cars.png',
    'Pet Accessories & Supplies':
        'assets/images/rental/categories/pet accessories & supplies.png',
    'Hotels and Resorts':
        'assets/images/rental/categories/Hotels and Resorts.png',
  };

  // Built from _categoryImageAssets so there's one source of truth for
  // category images. Adds one network fallback (no local asset yet) and
  // a trailing "More" tile.
  List<Map<String, dynamic>> get categories {
    final list = _categoryImageAssets.entries
        .map<Map<String, dynamic>>((e) => {'name': e.key, 'image': e.value})
        .toList();

    return list;
  }

  final List<Map<String, dynamic>> featuredRentals = [
    {
      'name': 'Canon DSLR 1200D',
      'price': '₹599',
      'rating': '4.8',
      'reviews': '120',
      'badge': 'Popular',
      'image': 'assets/images/rental/canon_EOS_1200D.jpg',
      'category': 'DSLR CAMERA',
      'imageQuery': 'canon dslr camera',
      'specs': const [
        SpecItem(
          icon: Icons.camera_alt_outlined,
          label: 'Sensor',
          value: 'APS-C 18MP',
        ),
        SpecItem(
          icon: Icons.videocam_outlined,
          label: 'Video',
          value: 'Full HD 1080p',
        ),
        SpecItem(
          icon: Icons.center_focus_strong_outlined,
          label: 'AF Points',
          value: '9-Point AF',
        ),
        SpecItem(
          icon: Icons.crop_free_outlined,
          label: 'Display',
          value: '3.0" LCD',
        ),
      ],
      'description':
          'Reliable entry-level DSLR, great for beginners and everyday photography.',
    },
    {
      'name': 'Nordic 3-Seater Sofa',
      'price': '₹299',
      'rating': '4.7',
      'reviews': '86',
      'badge': 'Trending',
      'image': 'assets/images/rental/nordic_3seater_sofa.jpg',
      'category': 'SOFA',
      'imageQuery': 'nordic sofa furniture',
      'specs': const [
        SpecItem(
          icon: Icons.chair_outlined,
          label: 'Seating',
          value: '3 Seater',
        ),
        SpecItem(
          icon: Icons.straighten_outlined,
          label: 'Dimensions',
          value: '190 x 85 cm',
        ),
        SpecItem(
          icon: Icons.texture_outlined,
          label: 'Material',
          value: 'Fabric',
        ),
        SpecItem(
          icon: Icons.monitor_weight_outlined,
          label: 'Weight',
          value: '38kg',
        ),
      ],
      'description':
          'Comfortable Nordic-style 3-seater sofa, perfect for living rooms.',
    },
    {
      'name': 'Honda Activa 6G',
      'price': '₹449',
      'rating': '4.6',
      'reviews': '98',
      'badge': 'Hot Deal',
      'image': 'assets/images/rental/honda_activa_6g.avif',
      'category': 'SCOOTER',
      'imageQuery': 'honda activa scooter',
      'specs': const [
        SpecItem(
          icon: Icons.speed_outlined,
          label: 'Engine',
          value: '109.51cc',
        ),
        SpecItem(
          icon: Icons.local_gas_station_outlined,
          label: 'Mileage',
          value: '~50 km/l',
        ),
        SpecItem(
          icon: Icons.people_outline,
          label: 'Seating',
          value: '2 Riders',
        ),
        SpecItem(
          icon: Icons.electric_bolt_outlined,
          label: 'Start',
          value: 'Electric/Kick',
        ),
      ],
      'description':
          'India\'s most trusted scooter — smooth ride, great mileage.',
    },
  ];

  final List<Map<String, dynamic>> trendingRentals = [
    {
      'name': 'GoPro Hero 11',
      'price': '₹399',
      'rating': '4.9',
      'reviews': '210',
      'badge': 'Trending',
      'image': 'assets/images/rental/gopro_hero_11.jpg',
      'category': 'ACTION CAMERA',
      'imageQuery': 'gopro action camera',
      'specs': const [
        SpecItem(
          icon: Icons.camera_alt_outlined,
          label: 'Resolution',
          value: '5.3K Video',
        ),
        SpecItem(
          icon: Icons.water_drop_outlined,
          label: 'Waterproof',
          value: 'Up to 10m',
        ),
        SpecItem(
          icon: Icons.battery_charging_full_outlined,
          label: 'Battery',
          value: '1720mAh',
        ),
        SpecItem(
          icon: Icons.monitor_weight_outlined,
          label: 'Weight',
          value: '154g',
        ),
      ],
      'description':
          'Rugged action camera for adventure, sports, and travel vlogging.',
    },
    {
      'name': 'Recliner Chair',
      'price': '₹249',
      'rating': '4.5',
      'reviews': '64',
      'badge': 'New',
      'image': 'assets/images/rental/recliner_chair.jpg',
      'category': 'RECLINER',
      'imageQuery': 'recliner chair furniture',
      'specs': const [
        SpecItem(
          icon: Icons.chair_alt_outlined,
          label: 'Seating',
          value: '1 Seater',
        ),
        SpecItem(
          icon: Icons.texture_outlined,
          label: 'Material',
          value: 'Leatherette',
        ),
        SpecItem(
          icon: Icons.accessibility_new_outlined,
          label: 'Recline',
          value: 'Manual',
        ),
        SpecItem(
          icon: Icons.monitor_weight_outlined,
          label: 'Weight',
          value: '32kg',
        ),
      ],
      'description':
          'Plush recliner chair for maximum comfort after a long day.',
    },
    {
      'name': 'Royal Enfield Classic',
      'price': '₹699',
      'rating': '4.8',
      'reviews': '142',
      'badge': 'Trending',
      'image': 'assets/images/rental/royal_enfield_classic.jpg',
      'category': 'MOTORCYCLE',
      'imageQuery': 'royal enfield motorcycle',
      'specs': const [
        SpecItem(icon: Icons.speed_outlined, label: 'Engine', value: '349cc'),
        SpecItem(
          icon: Icons.local_gas_station_outlined,
          label: 'Mileage',
          value: '~35 km/l',
        ),
        SpecItem(
          icon: Icons.people_outline,
          label: 'Seating',
          value: '2 Riders',
        ),
        SpecItem(
          icon: Icons.electric_bolt_outlined,
          label: 'Start',
          value: 'Electric',
        ),
      ],
      'description':
          'Iconic Royal Enfield Classic — timeless design, thumping engine.',
    },
  ];

  // Top Rated Products
  final List<Map<String, dynamic>> topRatedProducts = [
    {
      'name': 'MacBook Pro 14"',
      'price': '₹1,299',
      'rating': '4.9',
      'reviews': '245',
      'badge': 'Top Rated',
      'image': 'assets/images/rental/macbook_pro_14.png',
      'category': 'LAPTOP',
      'imageQuery': 'macbook pro laptop',
      'specs': const [
        SpecItem(icon: Icons.memory_outlined, label: 'Chip', value: 'M3 Pro'),
        SpecItem(
          icon: Icons.storage_outlined,
          label: 'Storage',
          value: '512GB SSD',
        ),
        SpecItem(
          icon: Icons.monitor_outlined,
          label: 'Display',
          value: '14" Liquid Retina',
        ),
        SpecItem(
          icon: Icons.battery_full_outlined,
          label: 'Battery',
          value: 'Up to 18 hrs',
        ),
      ],
      'description':
          'Powerful, portable laptop perfect for work and creative projects.',
    },
    {
      'name': 'King Size Bed Frame',
      'price': '₹399',
      'rating': '4.8',
      'reviews': '132',
      'badge': 'Top Rated',
      'image': 'assets/images/rental/king_size_bed_frame.webp',
      'category': 'BED FRAME',
      'imageQuery': 'king bed frame',
      'specs': const [
        SpecItem(icon: Icons.bed_outlined, label: 'Size', value: 'King'),
        SpecItem(
          icon: Icons.texture_outlined,
          label: 'Material',
          value: 'Solid Wood',
        ),
        SpecItem(
          icon: Icons.straighten_outlined,
          label: 'Dimensions',
          value: '200 x 180 cm',
        ),
        SpecItem(
          icon: Icons.monitor_weight_outlined,
          label: 'Weight',
          value: '45kg',
        ),
      ],
      'description': 'Sturdy king-size bed frame with a clean, modern finish.',
    },
    {
      'name': 'DJI Osmo Gimbal',
      'price': '₹349',
      'rating': '4.9',
      'reviews': '178',
      'badge': 'Top Rated',
      'image': 'assets/images/rental/dj_osmo_gimbal.webp',
      'category': 'GIMBAL',
      'imageQuery': 'camera gimbal stabilizer',
      'specs': const [
        SpecItem(
          icon: Icons.videocam_outlined,
          label: 'Type',
          value: '3-Axis Gimbal',
        ),
        SpecItem(
          icon: Icons.battery_charging_full_outlined,
          label: 'Battery',
          value: '12 hrs',
        ),
        SpecItem(
          icon: Icons.monitor_weight_outlined,
          label: 'Payload',
          value: 'Up to 3kg',
        ),
        SpecItem(
          icon: Icons.bluetooth_outlined,
          label: 'Connectivity',
          value: 'Bluetooth',
        ),
      ],
      'description':
          'Smooth, professional-grade footage stabilization for any camera.',
    },
  ];

  // Combined list used only for the live search feature below.
  List<Map<String, dynamic>> get allProducts => [
    ...featuredRentals,
    ...trendingRentals,
    ...topRatedProducts,
  ];

  // How It Works steps
  final List<Map<String, dynamic>> howItWorksSteps = [
    {
      'step': '1',
      'title': 'Choose Item',
      'subtitle': 'Select the product or service',
      'icon': Icons.touch_app_outlined,
    },
    {
      'step': '2',
      'title': 'Book or Rent',
      'subtitle': 'Pick a date and place your order',
      'icon': Icons.calendar_month_outlined,
    },
    {
      'step': '3',
      'title': 'We Deliver',
      'subtitle': 'We deliver it to your location',
      'icon': Icons.local_shipping_outlined,
    },
    {
      'step': '4',
      'title': 'Enjoy',
      'subtitle': 'Use it and return when done',
      'icon': Icons.sentiment_satisfied_alt_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.inputFill,
      // extendBody lets the ListView scroll underneath the nav bar instead
      // of Scaffold reserving a solid backgroundColor strip above it — that
      // reserved strip was the grey rectangle showing behind the bar.
      extendBody: true,
      drawer: _buildDrawer(),
      body: SafeArea(
        child: Builder(
          builder: (context) => ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildHeader(context),
              const SizedBox(height: 16),
              _buildSearchBar(),

              // ---- If searching, show results INSTEAD of the rest of the home page ----
              if (_isSearching) ...[
                const SizedBox(height: 16),
                Text(
                  '${_searchResults.length} result(s) for "${_searchController.text}"',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 12),
                _buildSearchResultsList(),
              ] else ...[
                const SizedBox(height: 22),
                const Text(
                  'What do you want to do?',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 14),
                _buildQuickActionsGrid(),
                const SizedBox(height: 22),
                _buildRecentActivity(),
                const SizedBox(height: 22),
                _buildReferBanner(),
                const SizedBox(height: 24),
                _sectionHeader(
                  'Categories',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CategoryScreen()),
                  ),
                ),
                const SizedBox(height: 14),
                _buildCategoriesRow(),
                const SizedBox(height: 24),
                _sectionHeader(
                  'Featured Products',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const FeaturedProductsScreen(),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                _buildProductCardsRow(featuredRentals),
                const SizedBox(height: 24),
                _sectionHeader(
                  'Trending Rentals',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const FeaturedProductsScreen(),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                _buildProductCardsRow(trendingRentals),
                const SizedBox(height: 24),
                _sectionHeader(
                  'Offers',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const OffersScreen()),
                  ),
                ),
                const SizedBox(height: 14),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const OffersScreen()),
                  ),
                  child: _buildFirstRentalBanner(),
                ),
                const SizedBox(height: 24),
                _sectionHeader(
                  'Top Rated Products',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const FeaturedProductsScreen(),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                _buildProductCardsRow(topRatedProducts),
                const SizedBox(height: 24),
                const Text(
                  'How It Works',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 14),
                _buildHowItWorks(),
                const SizedBox(height: 28),
                _buildLoveFooter(),
                const SizedBox(height: 12),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: RentoBottomNavBar(
        currentIndex: 0,
        onTap: (i) => navigateToTab(context, i),
      ),
    );
  }

  // ---------- DRAWER (compact, professional) ----------
  Widget _buildDrawer() {
    return Drawer(
      width: 260,
      backgroundColor: AppColors.pureWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Compact header — logo mark + name, not a full-height banner.
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlack,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/rental/rento_india_Logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Rento India',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.divider),
            const SizedBox(height: 2),
            _drawerTile(
              Icons.home_outlined,
              'Home',
              () => Navigator.pop(context),
            ),
            _drawerTile(Icons.house_outlined, 'My House', () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const myhousehomescreen()),
              );
            }),
            _drawerTile(Icons.receipt_long_outlined, 'Orders', () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OrdersScreen()),
              );
            }),
            // "Rider" here refers to the driver-onboarding flow
            // (become a rider), so this one intentionally stays on
            // AadhaarVerificationScreen — separate from "Book a Ride"
            // below, which is the customer-facing ride-booking flow.
            _drawerTile(Icons.badge_outlined, 'Become a Rider', () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AadhaarVerificationScreen(),
                ),
              );
            }),
            _drawerTile(Icons.account_balance_wallet_outlined, 'Wallet', () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WalletScreen()),
              );
            }),
            // FIX: Parcel Delivery now shows a red "NEW" ribbon tag next to its
            // label, and the label text itself is rendered with a rainbow
            // gradient (via ShaderMask) to call extra attention to it.
            _drawerTile(
              Icons.inventory_2_outlined,
              'Parcel Delivery',
              () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PickupAddressScreen(),
                  ),
                );
              },
              showNewBadge: true,
              rainbowText: true,
            ),
            // FIX: Book a Ride gets the same "NEW" ribbon tag + rainbow text
            // treatment as Parcel Delivery above.
            _drawerTile(
              Icons.directions_car_outlined,
              'Book a Ride',
              () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RidePickupLocationScreen(),
                  ),
                );
              },
              showNewBadge: true,
              rainbowText: true,
            ),

            _drawerTile(Icons.history_outlined, ' Ride history', () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RideHistoryScreen()),
              );
            }),
            _drawerTile(Icons.person_outline, 'Profile', () {
              Navigator.pop(context);
              navigateToTab(context, 4);
            }),
          ],
        ),
      ),
    );
  }

  // FIX: added optional `showNewBadge` and `rainbowText` params (both
  // default false, so every other call site above is unaffected).
  // - showNewBadge: renders a small red "NEW" ribbon-style tag after the label.
  // - rainbowText: renders the label with a rainbow gradient using ShaderMask
  //   instead of the normal solid text color.
  Widget _drawerTile(
    IconData icon,
    String label,
    VoidCallback onTap, {
    bool showNewBadge = false,
    bool rainbowText = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.textPrimary),
            const SizedBox(width: 14),
            rainbowText
                ? ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        Colors.red,
                        Colors.orange,
                        Colors.yellow,
                        Colors.green,
                        Colors.blue,
                        Colors.indigo,
                        Colors.purple,
                      ],
                    ).createShader(bounds),
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        // ShaderMask paints over this color, so it must be
                        // opaque (white) for the gradient to render fully.
                        color: Colors.white,
                      ),
                    ),
                  )
                : Text(
                    label,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
            if (showNewBadge) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'NEW',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---- TOP ROW: Logo + Location only ----
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                'assets/images/rental/rento_india_Logo.png',
                width: 42,
                height: 42,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryBlack,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.location_pin,
                    color: AppColors.pureWhite,
                    size: 22,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AnimatedBuilder(
                animation: LocationService.instance,
                builder: (context, _) {
                  final loc = LocationService.instance;
                  return GestureDetector(
                    onTap: () =>
                        LocationService.instance.fetchCurrentLocation(),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 15,
                          color: AppColors.primaryBlack,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: loc.isLoading
                              ? Text(
                                  'Fetching your location...',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11,
                                    color: AppColors.textSecondary,
                                  ),
                                )
                              : Text(
                                  loc.address,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                        ),
                        const Icon(
                          Icons.my_location,
                          size: 13,
                          color: AppColors.primaryBlack,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // ---- SECOND ROW: Menu (left) + Cart + Bell (right) ----
        Row(
          children: [
            Builder(
              builder: (context) => GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.menu,
                    size: 22,
                    color: AppColors.primaryBlack,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 32,
                child: _RunningNewsBanner(
                  messages: const [
                    '🔥 Canon DSLR Camera — Rent from ₹499/day',
                    '🎮 PlayStation 5 — Rent from ₹299/day',
                    '📱 iPhone 15 Pro — Rent from ₹799/day',
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            AnimatedBuilder(
              animation: CartService.instance,
              builder: (context, _) => GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartScreen()),
                ),
                child: _iconWithBadge(
                  Icons.shopping_cart_outlined,
                  CartService.instance.unseenCount,
                ),
              ),
            ),
            const SizedBox(width: 12),
            AnimatedBuilder(
              animation: NotificationService.instance,
              builder: (context, _) => GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NotificationScreen()),
                ),
                child: _iconWithBadge(
                  Icons.notifications_none_rounded,
                  NotificationService.instance.unreadCount,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showLocationPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final addresses = [
          '12, Nagoji Rao Street, Narayana Kishnar, Hyderabad',
          'Mumbai, 400001',
          'Delhi, 110001',
          'Bangalore, 560001',
        ];
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Select Address',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              ...addresses.map(
                (a) => ListTile(
                  leading: const Icon(Icons.location_on_outlined),
                  title: Text(a),
                  onTap: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Cart/notification badge uses the lime accent — icon-only color per house style.
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
              decoration: const BoxDecoration(
                color: AppColors.accentLime,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: Text(
                '$count',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.primaryBlack,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _sectionHeader(String title, VoidCallback onSeeAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: const Text(
            'See all',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  // ---------- SEARCH BAR ----------
  Widget _buildSearchBar() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: AppColors.textSecondary, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              style: const TextStyle(
                fontSize: 13.5,
                color: AppColors.textPrimary,
              ),
              cursorColor: AppColors.primaryBlack,
              decoration: InputDecoration(
                isCollapsed: true,
                filled: true,
                fillColor: Colors.transparent,
                hintText: 'Search for items, properties, tenants...',
                hintStyle: TextStyle(color: AppColors.textHint, fontSize: 13),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (_isSearching)
            GestureDetector(
              onTap: () {
                _searchController.clear();
                _onSearchChanged('');
              },
              child: const Icon(
                Icons.close,
                size: 18,
                color: AppColors.textSecondary,
              ),
            ),
        ],
      ),
    );
  }

  // ---------- LIVE SEARCH RESULTS ----------
  Widget _buildSearchResultsList() {
    if (_searchResults.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Center(
          child: Text(
            'No products found.',
            style: TextStyle(color: AppColors.textHint),
          ),
        ),
      );
    }
    return Column(
      children: _searchResults.map((r) {
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailsScreen(
                name: r['name'],
                price: r['price'],
                categoryLabel: r['category'],
                imageQuery: r['imageQuery'],
                rating: double.parse(r['rating']),
                reviewCount: int.parse(r['reviews']),
                specs: r['specs'],
                description: r['description'],
              ),
            ),
          ),
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    r['image'],
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 60,
                      height: 60,
                      color: AppColors.inputFill,
                      child: const Icon(
                        Icons.image_outlined,
                        color: AppColors.textHint,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        r['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        '${r['price']} /day',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 12, color: Colors.amber),
                          const SizedBox(width: 3),
                          Text(
                            '${r['rating']} (${r['reviews']})',
                            style: TextStyle(
                              fontSize: 10.5,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.textHint),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // ---------- QUICK ACTIONS GRID ----------
  // Layout matches the reference: a 3x2 grid of full-bleed photo tiles
  // (Rent Products … Track Orders), then a final row where Parcel
  // Delivery keeps its normal square photo-tile size on the left, and
  // the Rento Wallet banner takes the remaining two columns' width on
  // the right as a wide, light card — not another dark photo square.
  //
  // A LayoutBuilder measures the available width so the wallet banner's
  // height/width line up exactly with the photo tiles next to it (same
  // childAspectRatio math the old GridView used).
  Widget _buildQuickActionsGrid() {
    const int crossAxisCount = 3;
    const double spacing = 8;
    const double rowSpacing = 10;
    const double aspectRatio = 0.80; // width / height of one photo tile

    return LayoutBuilder(
      builder: (context, constraints) {
        final cellWidth =
            (constraints.maxWidth - spacing * (crossAxisCount - 1)) /
                crossAxisCount;
        final cellHeight = cellWidth / aspectRatio;

        Widget tileAt(int index) => SizedBox(
              width: cellWidth,
              height: cellHeight,
              child: _quickActionTile(index),
            );

        Widget row(List<int> indices) => Padding(
              padding: const EdgeInsets.only(bottom: rowSpacing),
              child: Row(
                children: [
                  for (int j = 0; j < indices.length; j++) ...[
                    if (j > 0) const SizedBox(width: spacing),
                    tileAt(indices[j]),
                  ],
                ],
              ),
            );

        return Column(
          children: [
            row(const [0, 1, 2]),
            row(const [3, 4, 5]),
            Row(
              children: [
                tileAt(6), // Parcel Delivery — untouched square tile
                const SizedBox(width: spacing),
                SizedBox(
                  width: cellWidth * 2 + spacing,
                  height: cellHeight,
                  child: _buildWalletBanner(),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // A single photo tile, unchanged from before: full-bleed image, bottom
  // gradient, title + subtitle overlaid at the bottom-left, no arrow icon.
  Widget _quickActionTile(int index) {
    final a = quickActions[index];
    return GestureDetector(
      onTap: () => _handleQuickAction(index),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              a['image'],
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.inputFill,
                child: const Icon(
                  Icons.image_outlined,
                  color: AppColors.textHint,
                  size: 24,
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.35, 1.0],
                  colors: [
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.78),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 10,
              right: 10,
              bottom: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    a['title'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 12.5,
                      height: 1.15,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    a['subtitle'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 9,
                      height: 1.2,
                      color: Colors.white.withOpacity(0.88),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- RENTO WALLET BANNER ----------
  // Wide, light card (matches the reference layout: sits to the right of
  // Parcel Delivery, spans two grid columns). Deliberately minimal per
  // your earlier note — no wallet balance figure, no "Rento Coins" /
  // "Vouchers" text rows, no Add Money / Transactions buttons. Just the
  // title, a one-line subtitle, a small animated coin badge, and the
  // wallet graphic on the right.
  //
  // FIX: content is wrapped in a FittedBox(fit: BoxFit.scaleDown) so it
  // always fits inside the card's fixed height/width on any screen size
  // — this is what was causing the "BOTTOM OVERFLOWED" / "RIGHT
  // OVERFLOWED" yellow-black warning stripes before. The graphic is also
  // capped with a ConstrainedBox so it can never push the text column
  // out of bounds.
  Widget _buildWalletBanner() {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const WalletScreen()),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlack,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const Icon(
                            Icons.account_balance_wallet_outlined,
                            color: AppColors.pureWhite,
                            size: 13,
                          ),
                        ),
                        const SizedBox(width: 7),
                        const Text(
                          'Rento Wallet',
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 128,
                      child: Text(
                        'Your wallet, more benefits',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10.5,
                          height: 1.25,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    _WalletCoinBadge(balance: _walletCoins),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 6),
            // Right-side wallet graphic only, per your reference image —
            // no overlaid numbers or labels on the image itself. Capped
            // with a max size so it can never grow past its share of the
            // row and squeeze the text column into overflow.
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 60, maxHeight: 60),
              child: Image.asset(
                'assets/images/rental/rento_wallet_graphic.png',
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.account_balance_wallet,
                  size: 44,
                  color: AppColors.textHint,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Indices match the 7-item quickActions list:
  // 0 Rent Products, 1 My House, 2 Book a Ride, 3 Utility Payments,
  // 4 Maintenance Requests, 5 Track Orders, 6 Parcel Delivery.
  // (Rento Wallet isn't in quickActions — it's the standalone banner
  // built by _buildWalletBanner, which routes to WalletScreen directly.)
  //
  // FIX: index 2 ("Rider Booking" / Book a Ride) opens
  // RidePickupLocationScreen (customer ride booking) instead of
  // AadhaarVerificationScreen (driver onboarding) — that was the
  // wrong screen being wired to this card.
  void _handleQuickAction(int index) {
    switch (index) {
      case 0: // Rent Products
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CategoryScreen()),
        );
        break;
      case 1: // My House
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const myhousehomescreen()),
        );
        break;
      case 2: // Book a Ride
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const RidePickupLocationScreen()),
        );
        break;
      case 3: // Utility Payments
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const UtilityPaymentsScreen()),
        );
        break;
      case 4: // Maintenance Requests
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MaintenanceRequestScreen()),
        );
        break;
      case 5: // Track Orders
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const OrdersScreen()),
        );
        break;
      case 6: // Parcel Delivery
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PickupAddressScreen()),
        );
        break;
    }
  }

  // ---------- RECENT ACTIVITY ----------
  Widget _buildRecentActivity() {
    return AnimatedBuilder(
      animation: OrdersService.instance,
      builder: (context, _) {
        final recent = OrdersService.instance.orders.take(2).toList();

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.pureWhite,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionHeader(
                'Recent Activity',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const OrdersScreen()),
                ),
              ),
              const SizedBox(height: 14),
              if (recent.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    'No orders yet. Rent something to see it here.',
                    style: TextStyle(color: AppColors.textHint, fontSize: 12),
                  ),
                )
              else if (recent.length == 1)
                _activityItem(recent[0])
              else
                Row(
                  children: [
                    Expanded(child: _activityItem(recent[0])),
                    Container(width: 1, height: 44, color: AppColors.divider),
                    const SizedBox(width: 12),
                    Expanded(child: _activityItem(recent[1])),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _activityItem(RentalOrder order) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            'https://loremflickr.com/100/100/${order.imageQuery.replaceAll(' ', ',')}?lock=${order.name.hashCode.abs() % 5000}',
            width: 44,
            height: 44,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              width: 44,
              height: 44,
              color: AppColors.inputFill,
              child: const Icon(
                Icons.image_outlined,
                color: AppColors.textHint,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: AppColors.textPrimary,
                ),
              ),
              // Completed orders use the app's established success green;
              // every other in-flight status uses plain dark text instead
              // of an arbitrary color.
              Text(
                order.status.label,
                style: TextStyle(
                  color: order.status == OrderStatus.completed
                      ? AppTheme.success
                      : AppColors.textPrimary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                _timeAgo(order.id),
                style: TextStyle(color: AppColors.textHint, fontSize: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // RentalOrder's id is set from DateTime.now().microsecondsSinceEpoch
  // when the order was placed, so it doubles as a creation timestamp
  // until a dedicated `createdAt` field exists on the model.
  String _timeAgo(String orderId) {
    final micros = int.tryParse(orderId);
    if (micros == null) return '';
    final placedAt = DateTime.fromMicrosecondsSinceEpoch(micros);
    final diff = DateTime.now().difference(placedAt);
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'just now';
  }

  // ---------- REFER & EARN ----------
  Widget _buildReferBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Icon(
              Icons.card_giftcard,
              color: AppColors.primaryBlack.withOpacity(0.08),
              size: 90,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Refer & Earn',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: 220,
                child: Text(
                  'Invite friends and earn exciting rewards on every referral!',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const OffersScreen()),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlack,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'REFER & EARN',
                        style: TextStyle(
                          color: AppColors.pureWhite,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(
                        Icons.arrow_forward,
                        color: AppColors.pureWhite,
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------- CATEGORIES ----------
  Widget _buildCategoriesRow() {
    return SizedBox(
      height: 86,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 4),
        itemBuilder: (context, i) {
          final c = categories[i];
          final imagePath = c['image'] as String?;
          final isAsset = imagePath != null && imagePath.startsWith('assets/');
          final isNetwork = imagePath != null && imagePath.startsWith('http');

          return GestureDetector(
            onTap: () {
              if (c['name'] == 'More') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CategoryScreen()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        CategoryDetailScreen(categoryName: c['name']),
                  ),
                );
              }
            },
            child: SizedBox(
              width: 56,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: isAsset
                        ? Image.asset(
                            imagePath,
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _categoryFallback(),
                          )
                        : isNetwork
                        ? Image.network(
                            imagePath,
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _categoryFallback(),
                          )
                        : Container(
                            width: 56,
                            height: 56,
                            color: AppColors.inputFill,
                            child: Icon(
                              c['icon'] as IconData? ?? Icons.category_outlined,
                              size: 24,
                              color: AppColors.textPrimary,
                            ),
                          ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    c['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textPrimary,
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

  Widget _categoryFallback() => Container(
    width: 56,
    height: 56,
    color: AppColors.inputFill,
    child: const Icon(Icons.image_outlined, color: AppColors.textHint),
  );
  // ---------- PRODUCT CARDS ROW ----------
  Widget _buildProductCardsRow(List<Map<String, dynamic>> items) {
    return SizedBox(
      height: 210,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, i) {
          final r = items[i];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailsScreen(
                  name: r['name'],
                  price: r['price'],
                  imageUrl: r['image'],
                  categoryLabel: r['category'],
                  imageQuery: r['imageQuery'],
                  rating: double.parse(r['rating']),
                  reviewCount: int.parse(r['reviews']),
                  specs: r['specs'],
                  description: r['description'],
                ),
              ),
            ),
            child: Container(
              width: 165,
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(14),
                        ),
                        child: Image.network(
                          r['image'],
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            height: 100,
                            color: AppColors.inputFill,
                            child: const Icon(
                              Icons.image_outlined,
                              color: AppColors.textHint,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlack,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            r['badge'],
                            style: const TextStyle(
                              color: AppColors.pureWhite,
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                            ),
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
                        Text(
                          r['name'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12.5,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${r['price']} /day',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 13,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              '${r['rating']} (${r['reviews']})',
                              style: TextStyle(
                                fontSize: 10.5,
                                color: AppColors.textSecondary,
                              ),
                            ),
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

  // ---------- HOW IT WORKS ----------
  Widget _buildHowItWorks() {
    return Row(
      children: howItWorksSteps
          .map(
            (s) => Expanded(
              child: Column(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.inputFill,
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(
                            s['icon'],
                            size: 18,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 16,
                            height: 16,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryBlack,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                s['step'],
                                style: const TextStyle(
                                  color: AppColors.pureWhite,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    s['title'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 10.5,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    s['subtitle'],
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 8.5, color: AppColors.textHint),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  // ---------- MADE WITH LOVE FOOTER ----------
  Widget _buildLoveFooter() {
    return Center(
      child: Column(
        children: [
          Text.rich(
            TextSpan(
              style: TextStyle(fontSize: 11.5, color: AppColors.textHint),
              children: const [
                TextSpan(text: 'Made with '),
                TextSpan(
                  text: '❤️',
                  style: TextStyle(color: AppColors.error),
                ),
                TextSpan(text: ' for Love'),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Rent Anything, Anytime, Anywhere.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // ---------- FIRST RENTAL FREE BANNER ----------
  Widget _buildFirstRentalBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.local_offer, color: AppColors.accentLime, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'First Rental FREE!',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: 'Use code: ',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
                    children: const [
                      TextSpan(
                        text: 'RENTO1ST',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryBlack,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Valid on your first rental',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.primaryBlack,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'CLAIM NOW',
              style: TextStyle(
                color: AppColors.pureWhite,
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RunningNewsBanner extends StatefulWidget {
  final List<String> messages;
  const _RunningNewsBanner({required this.messages});

  @override
  State<_RunningNewsBanner> createState() => _RunningNewsBannerState();
}

class _RunningNewsBannerState extends State<_RunningNewsBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final GlobalKey _textKey = GlobalKey();
  double _textWidth = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 16),
    )..repeat();
    WidgetsBinding.instance.addPostFrameCallback((_) => _measure());
  }

  void _measure() {
    final box = _textKey.currentContext?.findRenderObject() as RenderBox?;
    if (box != null && mounted) {
      setState(() => _textWidth = box.size.width);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final combined = '${widget.messages.join('   •   ')}   •   ';
    final textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 11,
      fontWeight: FontWeight.w600,
    );

    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.primaryBlack,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.campaign_outlined,
            color: AppColors.accentLime,
            size: 14,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRect(
              child: SizedBox(
                height: 32,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        final offset = _textWidth == 0
                            ? 0.0
                            : -(_controller.value * _textWidth);
                        return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              left: offset,
                              top: 0,
                              bottom: 0,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  combined,
                                  key: _textKey,
                                  maxLines: 1,
                                  style: textStyle,
                                ),
                              ),
                            ),
                            if (_textWidth > 0)
                              Positioned(
                                left: offset + _textWidth,
                                top: 0,
                                bottom: 0,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    combined,
                                    maxLines: 1,
                                    style: textStyle,
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- RENTO WALLET COIN BADGE ----------
// Small pill shown on the Rento Wallet banner. Whenever `balance`
// changes, it tweens from the old value to the new one instead of
// snapping straight to the new number — so it visually "counts up" (or
// down) as the real wallet balance changes, matching the "coin should
// increase while it's actually increasing" behaviour requested.
class _WalletCoinBadge extends StatefulWidget {
  final int balance;
  const _WalletCoinBadge({required this.balance});

  @override
  State<_WalletCoinBadge> createState() => _WalletCoinBadgeState();
}

class _WalletCoinBadgeState extends State<_WalletCoinBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _animation = IntTween(begin: widget.balance, end: widget.balance)
        .animate(_controller);
  }

  @override
  void didUpdateWidget(covariant _WalletCoinBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.balance != widget.balance) {
      _animation = IntTween(begin: oldWidget.balance, end: widget.balance)
          .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.accentLime,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.monetization_on,
              size: 12,
              color: AppColors.primaryBlack,
            ),
            const SizedBox(width: 4),
            Text(
              '${_animation.value}',
              style: const TextStyle(
                color: AppColors.primaryBlack,
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}