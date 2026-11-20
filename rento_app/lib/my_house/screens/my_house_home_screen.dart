// // import 'package:flutter/material.dart';
// // import 'search_property_screen.dart';
// // import 'all_properties_screen.dart';
// // import 'favorites_manager.dart';
// // import 'wishlist_screen.dart';
// // import 'chat_screen.dart';
// // import 'maintenance_request_screen.dart';
// // import 'utility_payments_screen.dart';
// // import 'visit_history_screen.dart';
// // import 'reschedule_visit_screen.dart';
// // import 'notifications_screen.dart';
// // import 'profile_screen.dart';
// // import 'quick_access_menu_screen.dart';
// // import 'property_details_screen.dart'; // Property Details — opened on card tap
// // import 'owner/owner_property_list_screen.dart'; // Owner Dashboard
// // import 'owner/kyc/owner_kyc_aadhaar_screen.dart'; // Owner KYC entry
// // import 'owner/owner_verification_status.dart';

// // class myhousehomescreen extends StatefulWidget {
// //   const myhousehomescreen({super.key});

// //   @override
// //   State<myhousehomescreen> createState() => _myhousehomescreenState();
// // }

// // class _myhousehomescreenState extends State<myhousehomescreen> {
// //   int currentNavIndex = 0;
// //   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

// //   @override
// //   void initState() {
// //     super.initState();
// //     // Load previously-liked properties from disk so hearts show the
// //     // correct state as soon as the Home screen opens.
// //     FavoritesManager.instance.load();
// //   }

// //   // Pure black — was a navy/violet tone before (0xFF1A1A2E).
// //   static const Color primaryDark = Color(0xFF000000);
// //   static const Color bgLight = Color(0xFFF8F9FC);
// //   static const double cardRadius = 20;

// //   final List<Map<String, String>> properties = [
// //     {
// //       'bhk': '2 BHK',
// //       'title': '2 BHK Apartment',
// //       'location': 'Anna Nagar, Chennai',
// //       'price': '₹12,000 / month',
// //       'beds': '2 Bed',
// //       'baths': '2 Bath',
// //       'sqft': '1000 sqft',
// //       'image': 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c',
// //     },
// //     {
// //       'bhk': '3 BHK',
// //       'title': '3 BHK Apartment',
// //       'location': 'Nungambakkam, Chennai',
// //       'price': '₹18,000 / month',
// //       'beds': '3 Bed',
// //       'baths': '2 Bath',
// //       'sqft': '1200 sqft',
// //       'image': 'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c',
// //     },
// //     {
// //       'bhk': '1 BHK',
// //       'title': '1 BHK Apartment',
// //       'location': 'T. Nagar, Chennai',
// //       'price': '₹10,000 / month',
// //       'beds': '1 Bed',
// //       'baths': '1 Bath',
// //       'sqft': '650 sqft',
// //       'image': 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c',
// //     },
// //     {
// //       'bhk': 'Studio',
// //       'title': 'A-Frame Modern Cabin',
// //       'location': 'Anna Nagar, Chennai',
// //       'price': '₹9,200 / month',
// //       'beds': 'Studio',
// //       'baths': '1 Bath',
// //       'sqft': '420 sqft',
// //       'image': 'assets/images/my_house/prop_extra_01.png',
// //     },
// //     {
// //       'bhk': '3 BHK',
// //       'title': '3 BHK Grand Villa',
// //       'location': 'Adyar, Chennai',
// //       'price': '₹32,000 / month',
// //       'beds': '3 Bed',
// //       'baths': '3 Bath',
// //       'sqft': '2400 sqft',
// //       'image': 'assets/images/my_house/prop_extra_02.png',
// //     },
// //     {
// //       'bhk': '3 BHK',
// //       'title': '3 BHK Contemporary Home',
// //       'location': 'Nungambakkam, Chennai',
// //       'price': '₹29,500 / month',
// //       'beds': '3 Bed',
// //       'baths': '3 Bath',
// //       'sqft': '2100 sqft',
// //       'image': 'assets/images/my_house/prop_extra_03.png',
// //     },
// //     {
// //       'bhk': '3 BHK',
// //       'title': '3 BHK Rooftop Garden Villa',
// //       'location': 'Anna Nagar, Chennai',
// //       'price': '₹35,000 / month',
// //       'beds': '3 Bed',
// //       'baths': '3 Bath',
// //       'sqft': '2600 sqft',
// //       'image': 'assets/images/my_house/prop_extra_04.png',
// //     },
// //     {
// //       'bhk': '1 BHK',
// //       'title': '1 BHK Glassy Loft',
// //       'location': 'Velachery, Chennai',
// //       'price': '₹11,500 / month',
// //       'beds': '1 Bed',
// //       'baths': '1 Bath',
// //       'sqft': '700 sqft',
// //       'image': 'assets/images/my_house/prop_extra_05.png',
// //     },
// //     {
// //       'bhk': '3 BHK',
// //       'title': '3 BHK Luxury Mansion',
// //       'location': 'Velachery, Chennai',
// //       'price': '₹38,000 / month',
// //       'beds': '3 Bed',
// //       'baths': '4 Bath',
// //       'sqft': '3000 sqft',
// //       'image': 'assets/images/my_house/prop_extra_06.png',
// //     },
// //     {
// //       'bhk': '2 BHK',
// //       'title': '2 BHK Beachside Bungalow',
// //       'location': 'Adyar, Chennai',
// //       'price': '₹19,000 / month',
// //       'beds': '2 Bed',
// //       'baths': '2 Bath',
// //       'sqft': '1400 sqft',
// //       'image': 'assets/images/my_house/prop_extra_07.png',
// //     },
// //     {
// //       'bhk': '2 BHK',
// //       'title': '2 BHK Balcony Residence',
// //       'location': 'Anna Nagar, Chennai',
// //       'price': '₹18,200 / month',
// //       'beds': '2 Bed',
// //       'baths': '2 Bath',
// //       'sqft': '1300 sqft',
// //       'image': 'assets/images/my_house/prop_extra_08.png',
// //     },
// //     {
// //       'bhk': '3 BHK',
// //       'title': '3 BHK Balcony View Home',
// //       'location': 'Porur, Chennai',
// //       'price': '₹27,800 / month',
// //       'beds': '3 Bed',
// //       'baths': '2 Bath',
// //       'sqft': '1900 sqft',
// //       'image': 'assets/images/my_house/prop_extra_09.png',
// //     },
// //     {
// //       'bhk': '2 BHK',
// //       'title': '2 BHK Modern Duplex',
// //       'location': 'T Nagar, Chennai',
// //       'price': '₹20,500 / month',
// //       'beds': '2 Bed',
// //       'baths': '2 Bath',
// //       'sqft': '1500 sqft',
// //       'image': 'assets/images/my_house/prop_extra_10.png',
// //     },
// //     {
// //       'bhk': '2 BHK',
// //       'title': '2 BHK Designer Home',
// //       'location': 'Nungambakkam, Chennai',
// //       'price': '₹21,000 / month',
// //       'beds': '2 Bed',
// //       'baths': '2 Bath',
// //       'sqft': '1550 sqft',
// //       'image': 'assets/images/my_house/prop_extra_11.png',
// //     },
// //   ];

// //   Future<void> _goToOwnerFlow(BuildContext context) async {
// //     final bool verified = await OwnerVerificationStatus.isVerified();
// //     if (!context.mounted) return;
// //     if (verified) {
// //       Navigator.push(
// //         context,
// //         MaterialPageRoute(builder: (context) => const OwnerDashboardScreen()),
// //       );
// //     } else {
// //       Navigator.push(
// //         context,
// //         MaterialPageRoute(builder: (context) => const OwnerKycAadhaarScreen()),
// //       );
// //     }
// //   }

// //   // NEW: reusable app logo widget — rectangle (rounded-corner box) shape.
// //   // Used in both the AppBar and the Drawer header, replacing the old
// //   // black icon-box + Icons.home_rounded combo.
// //   // IMPORTANT: uses BoxFit.contain (not cover) so the ENTIRE logo — the
// //   // house outline, the "MYHOUSE.IN" wordmark, and the "RENTAL PROPERTIES"
// //   // subtext — is always fully visible with nothing cropped off.
// //   // `width` defaults to `height` (square) but can be made larger than
// //   // `height` to extend the box further to the right only — the logo
// //   // stays left-aligned inside it and just gets more room to render bigger.
// //   Widget _appLogo({double height = 32, double? width, double radius = 10}) {
// //     final double boxWidth = width ?? height;
// //     return SizedBox(
// //       height: height,
// //       width: boxWidth,
// //       child: Align(
// //         alignment: Alignment.centerLeft,
// //         child: ClipRRect(
// //           borderRadius: BorderRadius.circular(radius),
// //           child: Image.asset(
// //             'assets/images/my_house/app_logo.png',
// //             height: height,
// //             fit: BoxFit.contain,
// //             errorBuilder: (context, error, stackTrace) => Container(
// //               height: height,
// //               width: height,
// //               decoration: BoxDecoration(
// //                 color: primaryDark,
// //                 borderRadius: BorderRadius.circular(radius),
// //               ),
// //               child: const Icon(Icons.home_rounded, color: Colors.white, size: 18),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _featureBadge(IconData icon, String label) {
// //     return Expanded(
// //       child: Container(
// //         margin: const EdgeInsets.symmetric(horizontal: 4),
// //         padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(cardRadius),
// //           border: Border.all(color: const Color(0xFFEDEEF3)),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.grey.withOpacity(0.08),
// //               blurRadius: 12,
// //               offset: const Offset(0, 4),
// //             ),
// //           ],
// //         ),
// //         child: Column(
// //           children: [
// //             Icon(icon, size: 24, color: primaryDark),
// //             const SizedBox(height: 8),
// //             Text(
// //               label,
// //               textAlign: TextAlign.center,
// //               style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _propertyImage(String path, {required double height}) {
// //     if (path.startsWith('assets/')) {
// //       return Image.asset(
// //         path,
// //         height: height,
// //         width: double.infinity,
// //         fit: BoxFit.cover,
// //         errorBuilder: (context, error, stackTrace) => Container(
// //           height: height,
// //           color: const Color(0xFFF0F0F0),
// //           child: const Icon(Icons.home, color: Colors.grey, size: 30),
// //         ),
// //       );
// //     }
// //     return Image.network(
// //       path,
// //       height: height,
// //       width: double.infinity,
// //       fit: BoxFit.cover,
// //       errorBuilder: (context, error, stackTrace) => Container(
// //         height: height,
// //         color: const Color(0xFFF0F0F0),
// //         child: const Icon(Icons.home, color: Colors.grey, size: 30),
// //       ),
// //     );
// //   }

// //   // FIX: wrapped the card in a GestureDetector so tapping anywhere on the
// //   // card (not just "View All") opens PropertyDetailsScreen.
// //   Widget _propertyCard(Map<String, String> data) {
// //     return GestureDetector(
// //       onTap: () {
// //         Navigator.push(
// //           context,
// //           MaterialPageRoute(
// //             builder: (context) => PropertyDetailsScreen(data: data),
// //           ),
// //         );
// //       },
// //       child: Container(
// //         width: 220,
// //         margin: const EdgeInsets.only(right: 14),
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(cardRadius),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.grey.withOpacity(0.10),
// //               blurRadius: 14,
// //               offset: const Offset(0, 4),
// //             ),
// //           ],
// //         ),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Stack(
// //               children: [
// //                 ClipRRect(
// //                   borderRadius: const BorderRadius.vertical(top: Radius.circular(cardRadius)),
// //                   child: _propertyImage(data['image']!, height: 130),
// //                 ),
// //                 Positioned(
// //                   top: 10,
// //                   left: 10,
// //                   child: Container(
// //                     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
// //                     decoration: BoxDecoration(
// //                       color: primaryDark,
// //                       borderRadius: BorderRadius.circular(8),
// //                     ),
// //                     child: Text(
// //                       data['bhk']!,
// //                       style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
// //                     ),
// //                   ),
// //                 ),
// //                 Positioned(
// //                   top: 10,
// //                   right: 10,
// //                   child: _LikeButton(propertyKey: data['title']! + data['image']!),
// //                 ),
// //               ],
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.all(12),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     data['title']!,
// //                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
// //                   ),
// //                   const SizedBox(height: 4),
// //                   Row(
// //                     children: [
// //                       const Icon(Icons.location_on, size: 13, color: Colors.grey),
// //                       const SizedBox(width: 3),
// //                       Expanded(
// //                         child: Text(
// //                           data['location']!,
// //                           style: const TextStyle(fontSize: 12, color: Colors.grey),
// //                           overflow: TextOverflow.ellipsis,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 6),
// //                   Text(
// //                     data['price']!,
// //                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: primaryDark),
// //                   ),
// //                   const SizedBox(height: 8),
// //                   const Divider(height: 1),
// //                   const SizedBox(height: 8),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       _miniInfo(Icons.bed_outlined, data['beds']!),
// //                       _miniInfo(Icons.bathtub_outlined, data['baths']!),
// //                       _miniInfo(Icons.straighten, data['sqft']!),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _miniInfo(IconData icon, String label) {
// //     return Row(
// //       children: [
// //         Icon(icon, size: 13, color: Colors.grey[600]),
// //         const SizedBox(width: 3),
// //         Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
// //       ],
// //     );
// //   }

// //   Widget _stepItem(IconData icon, String title, String subtitle) {
// //     return Expanded(
// //       child: Column(
// //         children: [
// //           Container(
// //             padding: const EdgeInsets.all(14),
// //             decoration: const BoxDecoration(color: Color(0xFFEDEEF3), shape: BoxShape.circle),
// //             child: Icon(icon, size: 20, color: primaryDark),
// //           ),
// //           const SizedBox(height: 8),
// //           Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
// //           const SizedBox(height: 2),
// //           Text(
// //             subtitle,
// //             textAlign: TextAlign.center,
// //             style: TextStyle(fontSize: 10, color: Colors.grey[600]),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _drawerSectionLabel(String label) {
// //     return Padding(
// //       padding: const EdgeInsets.fromLTRB(10, 14, 10, 8),
// //       child: Text(
// //         label.toUpperCase(),
// //         style: TextStyle(
// //           fontSize: 11,
// //           fontWeight: FontWeight.w700,
// //           letterSpacing: 0.8,
// //           color: Colors.grey[500],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _drawerTile({
// //     required IconData icon,
// //     required Color iconBg,
// //     required Color iconColor,
// //     required String title,
// //     required VoidCallback onTap,
// //   }) {
// //     return Material(
// //       color: Colors.transparent,
// //       borderRadius: BorderRadius.circular(14),
// //       child: InkWell(
// //         borderRadius: BorderRadius.circular(14),
// //         onTap: onTap,
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
// //           child: Row(
// //             children: [
// //               Container(
// //                 padding: const EdgeInsets.all(10),
// //                 decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)),
// //                 child: Icon(icon, color: iconColor, size: 20),
// //               ),
// //               const SizedBox(width: 14),
// //               Expanded(
// //                 child: Text(
// //                   title,
// //                   style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: primaryDark),
// //                 ),
// //               ),
// //               Icon(Icons.chevron_right_rounded, color: Colors.grey[400], size: 20),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       key: _scaffoldKey,
// //       backgroundColor: bgLight,
// //       drawer: Drawer(
// //         backgroundColor: Colors.white,
// //         child: SafeArea(
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Container(
// //                 width: double.infinity,
// //                 padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
// //                 decoration: BoxDecoration(
// //                   // Light-grey card look instead of solid black.
// //                   // Darkened slightly and now flush with the top/left/
// //                   // right edges — only the bottom corners are rounded.
// //                   color: const Color(0xFFBFBFBF),
// //                   borderRadius: const BorderRadius.only(
// //                     bottomLeft: Radius.circular(24),
// //                     bottomRight: Radius.circular(24),
// //                   ),
// //                 ),
// //                 child: Row(
// //                   children: [
// //                     // Logo — rectangle shape, replaces old translucent
// //                     // icon box. Slightly narrower now so the text sits
// //                     // further left, closer to the logo.
// //                     _appLogo(height: 68, width: 78, radius: 14),
// //                     const SizedBox(width: 6),
// //                     // FIX: tagline was wrapping/getting cut off with "…".
// //                     // FittedBox (scaleDown) auto-shrinks the font just
// //                     // enough so the FULL text always shows on one line.
// //                     Expanded(
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           const Text(
// //                             'RENTO INDIA',
// //                             style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: primaryDark, letterSpacing: 0.3),
// //                           ),
// //                           const SizedBox(height: 2),
// //                           FittedBox(
// //                             fit: BoxFit.scaleDown,
// //                             alignment: Alignment.centerLeft,
// //                             child: const Text(
// //                               'Rent Anything, Anytime, Anywhere',
// //                               maxLines: 1,
// //                               style: TextStyle(fontSize: 9.5, color: Colors.black54),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),

// //               const SizedBox(height: 8),

// //               Expanded(
// //                 child: ListView(
// //                   padding: const EdgeInsets.symmetric(horizontal: 14),
// //                   children: [
// //                     _drawerSectionLabel('Services'),
// //                     _drawerTile(
// //                       icon: Icons.build_rounded,
// //                       iconBg: const Color(0xFFFFF1E6),
// //                       iconColor: const Color(0xFFE07A1F),
// //                       title: 'Raise Maintenance Request',
// //                       onTap: () {
// //                         Navigator.pop(context);
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(builder: (context) => const MaintenanceRequestScreen()),
// //                         );
// //                       },
// //                     ),
// //                     _drawerTile(
// //                       icon: Icons.receipt_long_rounded,
// //                       iconBg: const Color(0xFFE9F3FF),
// //                       iconColor: const Color(0xFF2C7BE5),
// //                       title: 'Utility & Services',
// //                       onTap: () {
// //                         Navigator.pop(context);
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(builder: (context) => const UtilityPaymentsScreen()),
// //                         );
// //                       },
// //                     ),

// //                     const SizedBox(height: 8),
// //                     const Divider(height: 1),
// //                     const SizedBox(height: 8),

// //                     _drawerSectionLabel('My Activity'),
// //                     // "My Requests" tile removed — it pointed to
// //                     // ApplicationStatusScreen, which was part of the
// //                     // apply/agreement/payment flow that's been deleted.
// //                     _drawerTile(
// //                       icon: Icons.history_rounded,
// //                       iconBg: const Color(0xFFE6F7EF),
// //                       iconColor: const Color(0xFF1FAE6B),
// //                       title: 'Visit History',
// //                       onTap: () {
// //                         Navigator.pop(context);
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(builder: (context) => const VisitHistoryScreen()),
// //                         );
// //                       },
// //                     ),
// //                     _drawerTile(
// //                       icon: Icons.calendar_month_rounded,
// //                       iconBg: const Color(0xFFFFECEC),
// //                       iconColor: const Color(0xFFE0483F),
// //                       title: 'Reschedule Visit',
// //                       onTap: () {
// //                         Navigator.pop(context);
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(builder: (context) => const RescheduleVisitScreen()),
// //                         );
// //                       },
// //                     ),

// //                     const SizedBox(height: 8),
// //                     const Divider(height: 1),
// //                     const SizedBox(height: 8),

// //                     _drawerSectionLabel('More'),
// //                     // New tile — opens the standalone Quick Access menu
// //                     // (Apply, Application Status, Rental Agreement,
// //                     // Payment, Rent Payment) without hooking into any
// //                     // other flow.
// //                     _drawerTile(
// //                       icon: Icons.apps_rounded,
// //                       iconBg: const Color(0xFFF3EEFE),
// //                       iconColor: const Color(0xFF8B5CF6),
// //                       title: 'Quick Access',
// //                       onTap: () {
// //                         Navigator.pop(context);
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(builder: (context) => const QuickAccessMenuScreen()),
// //                         );
// //                       },
// //                     ),
// //                   ],
// //                 ),
// //               ),

// //               Padding(
// //                 padding: const EdgeInsets.all(20),
// //                 child: Text(
// //                   'RENTO INDIA v1.0',
// //                   style: TextStyle(fontSize: 11, color: Colors.grey[400]),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           child: Padding(
// //             padding: const EdgeInsets.all(16),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Row(
// //                   children: [
// //                     GestureDetector(
// //                       onTap: () => _scaffoldKey.currentState?.openDrawer(),
// //                       child: const Icon(Icons.menu, color: primaryDark),
// //                     ),
// //                     const SizedBox(width: 12),
// //                     // Logo — narrower now so the text sits further left,
// //                     // closer to the logo.
// //                     _appLogo(height: 56, width: 76, radius: 14),
// //                     const SizedBox(width: 6),
// //                     // FIX: was `Flexible` + a separate `Spacer()` after it —
// //                     // both are flex widgets with equal weight, so they
// //                     // split the remaining width in half, squeezing this
// //                     // text into a narrow column that wrapped onto 4 lines.
// //                     // `Expanded` alone claims all the leftover space (and
// //                     // still pushes the heart/bell icons to the far right
// //                     // on its own).
// //                     // FIX 2: the tagline was still getting cut off with
// //                     // "…" on narrow screens. Wrapping it in a `FittedBox`
// //                     // (scaleDown) auto-shrinks the font just enough so the
// //                     // FULL text "Rent Anything, Anytime, Anywhere" always
// //                     // shows on a single line — nothing truncated.
// //                     Expanded(
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           const Text(
// //                             'RENTO INDIA',
// //                             style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, letterSpacing: 0.3),
// //                           ),
// //                           FittedBox(
// //                             fit: BoxFit.scaleDown,
// //                             alignment: Alignment.centerLeft,
// //                             child: const Text(
// //                               'Rent Anything, Anytime, Anywhere',
// //                               maxLines: 1,
// //                               style: TextStyle(fontSize: 10, color: Colors.grey),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                     GestureDetector(
// //                       onTap: () => Navigator.push(
// //                         context,
// //                         MaterialPageRoute(builder: (context) => const WishlistScreen()),
// //                       ),
// //                       child: AnimatedBuilder(
// //                         animation: FavoritesManager.instance,
// //                         builder: (context, _) {
// //                           final count = FavoritesManager.instance.count;
// //                           return Stack(
// //                             clipBehavior: Clip.none,
// //                             children: [
// //                               const Icon(Icons.favorite_border, color: primaryDark, size: 24),
// //                               if (count > 0)
// //                                 Positioned(
// //                                   top: -4,
// //                                   right: -4,
// //                                   child: Container(
// //                                     padding: const EdgeInsets.all(3),
// //                                     constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
// //                                     decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
// //                                     child: Text(
// //                                       '$count',
// //                                       textAlign: TextAlign.center,
// //                                       style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700),
// //                                     ),
// //                                   ),
// //                                 ),
// //                             ],
// //                           );
// //                         },
// //                       ),
// //                     ),
// //                     const SizedBox(width: 16),
// //                     GestureDetector(
// //                       onTap: () => Navigator.push(
// //                         context,
// //                         MaterialPageRoute(builder: (context) => const NotificationsScreen()),
// //                       ),
// //                       child: const Icon(Icons.notifications_none_rounded, color: primaryDark, size: 26),
// //                     ),
// //                   ],
// //                 ),

// //                 const SizedBox(height: 20),

// //                 Container(
// //                   padding: const EdgeInsets.all(18),
// //                   decoration: BoxDecoration(
// //                     color: const Color(0xFFEFEFF3),
// //                     borderRadius: BorderRadius.circular(cardRadius),
// //                   ),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       const Text(
// //                         'Find. Rent.\nLive Happy.',
// //                         style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, height: 1.15),
// //                       ),
// //                       const SizedBox(height: 8),
// //                       Text(
// //                         'Your all-in-one rental solution.',
// //                         style: TextStyle(fontSize: 13, color: Colors.grey[700]),
// //                       ),
// //                       const SizedBox(height: 16),
// //                       ClipRRect(
// //                         borderRadius: BorderRadius.circular(16),
// //                         child: Image.asset(
// //                           'assets/images/my_house/living_room_hero.jpg',
// //                           height: 160,
// //                           width: double.infinity,
// //                           fit: BoxFit.cover,
// //                           errorBuilder: (context, error, stackTrace) => Container(
// //                             height: 160,
// //                             color: Colors.grey[300],
// //                             child: const Icon(Icons.home, size: 40, color: Colors.grey),
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),

// //                 const SizedBox(height: 26),

// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     const Text(
// //                       'Popular Properties',
// //                       style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
// //                     ),
// //                     GestureDetector(
// //                       onTap: () {
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                             builder: (context) => AllPropertiesScreen(properties: properties),
// //                           ),
// //                         );
// //                       },
// //                       child: const Row(
// //                         children: [
// //                           Text('View All', style: TextStyle(fontSize: 13, color: primaryDark)),
// //                           Icon(Icons.chevron_right, size: 18, color: primaryDark),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 const SizedBox(height: 14),
// //                 SizedBox(
// //                   height: 290,
// //                   child: ListView(
// //                     scrollDirection: Axis.horizontal,
// //                     children: properties.map((p) => _propertyCard(p)).toList(),
// //                   ),
// //                 ),

// //                 const SizedBox(height: 26),

// //                 Container(
// //                   padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
// //                   decoration: BoxDecoration(
// //                     color: Colors.white,
// //                     borderRadius: BorderRadius.circular(cardRadius),
// //                     boxShadow: [
// //                       BoxShadow(
// //                         color: Colors.grey.withOpacity(0.08),
// //                         blurRadius: 14,
// //                         offset: const Offset(0, 4),
// //                       ),
// //                     ],
// //                   ),
// //                   child: Column(
// //                     children: [
// //                       const Text(
// //                         'Renting Made Simple',
// //                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
// //                       ),
// //                       const SizedBox(height: 18),
// //                       Row(
// //                         children: [
// //                           _stepItem(Icons.search, 'Search', 'Find the perfect\nproperty'),
// //                           const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
// //                           _stepItem(Icons.send_outlined, 'Request', 'Send request\nto owner'),
// //                           const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
// //                           _stepItem(Icons.assignment_outlined, 'Visit & Apply', 'Visit property &\nsubmit application'),
// //                           const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
// //                           _stepItem(Icons.home_outlined, 'Move In', 'Pay & move into\nyour new home'),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                 ),

// //                 const SizedBox(height: 90),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),

// //       bottomNavigationBar: Container(
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.grey.withOpacity(0.15),
// //               blurRadius: 12,
// //               offset: const Offset(0, -2),
// //             ),
// //           ],
// //         ),
// //         child: SafeArea(
// //           child: Padding(
// //             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceAround,
// //               children: [
// //                 _navItem(Icons.home, 'Home', 0),
// //                 _navItem(Icons.search, 'Search', 1),
// //                 _navAddButton(),
// //                 _navItem(Icons.chat_bubble_outline, 'Chat', 3),
// //                 _navItem(Icons.person_outline, 'Profile', 4),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _navItem(IconData icon, String label, int index) {
// //     final bool selected = currentNavIndex == index;
// //     return GestureDetector(
// //       onTap: () {
// //         setState(() => currentNavIndex = index);
// //         if (index == 1) {
// //           Navigator.push(
// //             context,
// //             MaterialPageRoute(builder: (context) => const SearchPropertyScreen()),
// //           );
// //         } else if (index == 3) {
// //           Navigator.push(
// //             context,
// //             MaterialPageRoute(builder: (context) => const ChatScreen()),
// //           );
// //         } else if (index == 4) {
// //           Navigator.push(
// //             context,
// //             MaterialPageRoute(builder: (context) => const ProfileScreen()),
// //           );
// //         }
// //       },
// //       child: Column(
// //         mainAxisSize: MainAxisSize.min,
// //         children: [
// //           Icon(icon, size: 22, color: selected ? primaryDark : Colors.grey),
// //           const SizedBox(height: 4),
// //           Text(
// //             label,
// //             style: TextStyle(
// //               fontSize: 11,
// //               color: selected ? primaryDark : Colors.grey,
// //               fontWeight: selected ? FontWeight.w700 : FontWeight.normal,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _navAddButton() {
// //     return GestureDetector(
// //       onTap: () {
// //         setState(() => currentNavIndex = 2);
// //         _goToOwnerFlow(context);
// //       },
// //       child: Column(
// //         mainAxisSize: MainAxisSize.min,
// //         children: [
// //           Container(
// //             padding: const EdgeInsets.all(10),
// //             decoration: BoxDecoration(
// //               color: primaryDark,
// //               borderRadius: BorderRadius.circular(10),
// //             ),
// //             child: const Icon(Icons.add, size: 20, color: Colors.white),
// //           ),
// //           const SizedBox(height: 4),
// //           const Text('Add Property', style: TextStyle(fontSize: 10, color: primaryDark)),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class _LikeButton extends StatelessWidget {
// //   final String propertyKey;
// //   const _LikeButton({required this.propertyKey});

// //   @override
// //   Widget build(BuildContext context) {
// //     return AnimatedBuilder(
// //       animation: FavoritesManager.instance,
// //       builder: (context, _) {
// //         final liked = FavoritesManager.instance.isLiked(propertyKey);
// //         return GestureDetector(
// //           onTap: () async {
// //             await FavoritesManager.instance.toggle(propertyKey);
// //             if (context.mounted) {
// //               ScaffoldMessenger.of(context).hideCurrentSnackBar();
// //               ScaffoldMessenger.of(context).showSnackBar(
// //                 SnackBar(
// //                   duration: const Duration(seconds: 1, milliseconds: 200),
// //                   behavior: SnackBarBehavior.floating,
// //                   backgroundColor: Colors.black87,
// //                   content: Text(
// //                     liked ? 'Removed from Wishlist' : 'Added to Wishlist ❤️',
// //                     style: const TextStyle(fontSize: 13),
// //                   ),
// //                 ),
// //               );
// //             }
// //           },
// //           child: Container(
// //             padding: const EdgeInsets.all(6),
// //             decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
// //             child: Icon(
// //               liked ? Icons.favorite : Icons.favorite_border,
// //               size: 16,
// //               color: liked ? Colors.redAccent : Colors.black,
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }


// // // import 'package:flutter/material.dart';
// // // import 'search_property_screen.dart';
// // // import 'all_properties_screen.dart';
// // // import 'favorites_manager.dart';
// // // import 'wishlist_screen.dart';
// // // import 'chat_screen.dart';
// // // import 'maintenance_request_screen.dart';
// // // import 'utility_payments_screen.dart';
// // // import 'visit_history_screen.dart';
// // // import 'reschedule_visit_screen.dart';
// // // import 'notifications_screen.dart';
// // // import 'profile_screen.dart';
// // // import 'quick_access_menu_screen.dart';
// // // import 'property_details_screen.dart'; // Property Details — opened on card tap
// // // import 'owner/owner_property_list_screen.dart'; // Owner Dashboard
// // // import 'owner/kyc/owner_kyc_aadhaar_screen.dart'; // Owner KYC entry
// // // import 'owner/owner_verification_status.dart';

// // // class myhousehomescreen extends StatefulWidget {
// // //   const myhousehomescreen({super.key});

// // //   @override
// // //   State<myhousehomescreen> createState() => _myhousehomescreenState();
// // // }

// // // class _myhousehomescreenState extends State<myhousehomescreen> {
// // //   int currentNavIndex = 0;
// // //   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     // Load previously-liked properties from disk so hearts show the
// // //     // correct state as soon as the Home screen opens.
// // //     FavoritesManager.instance.load();
// // //   }

// // //   // Pure black — was a navy/violet tone before (0xFF1A1A2E).
// // //   static const Color primaryDark = Color(0xFF000000);
// // //   static const Color bgLight = Color(0xFFF8F9FC);
// // //   static const double cardRadius = 20;

// // //   final List<Map<String, String>> properties = [
// // //     {
// // //       'bhk': '2 BHK',
// // //       'title': '2 BHK Apartment',
// // //       'location': 'Anna Nagar, Chennai',
// // //       'price': '₹12,000 / month',
// // //       'beds': '2 Bed',
// // //       'baths': '2 Bath',
// // //       'sqft': '1000 sqft',
// // //       'image': 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c',
// // //     },
// // //     {
// // //       'bhk': '3 BHK',
// // //       'title': '3 BHK Apartment',
// // //       'location': 'Nungambakkam, Chennai',
// // //       'price': '₹18,000 / month',
// // //       'beds': '3 Bed',
// // //       'baths': '2 Bath',
// // //       'sqft': '1200 sqft',
// // //       'image': 'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c',
// // //     },
// // //     {
// // //       'bhk': '1 BHK',
// // //       'title': '1 BHK Apartment',
// // //       'location': 'T. Nagar, Chennai',
// // //       'price': '₹10,000 / month',
// // //       'beds': '1 Bed',
// // //       'baths': '1 Bath',
// // //       'sqft': '650 sqft',
// // //       'image': 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c',
// // //     },
// // //     {
// // //       'bhk': 'Studio',
// // //       'title': 'A-Frame Modern Cabin',
// // //       'location': 'Anna Nagar, Chennai',
// // //       'price': '₹9,200 / month',
// // //       'beds': 'Studio',
// // //       'baths': '1 Bath',
// // //       'sqft': '420 sqft',
// // //       'image': 'assets/images/prop_extra_01.png',
// // //     },
// // //     {
// // //       'bhk': '3 BHK',
// // //       'title': '3 BHK Grand Villa',
// // //       'location': 'Adyar, Chennai',
// // //       'price': '₹32,000 / month',
// // //       'beds': '3 Bed',
// // //       'baths': '3 Bath',
// // //       'sqft': '2400 sqft',
// // //       'image': 'assets/images/prop_extra_02.png',
// // //     },
// // //     {
// // //       'bhk': '3 BHK',
// // //       'title': '3 BHK Contemporary Home',
// // //       'location': 'Nungambakkam, Chennai',
// // //       'price': '₹29,500 / month',
// // //       'beds': '3 Bed',
// // //       'baths': '3 Bath',
// // //       'sqft': '2100 sqft',
// // //       'image': 'assets/images/prop_extra_03.png',
// // //     },
// // //     {
// // //       'bhk': '3 BHK',
// // //       'title': '3 BHK Rooftop Garden Villa',
// // //       'location': 'Anna Nagar, Chennai',
// // //       'price': '₹35,000 / month',
// // //       'beds': '3 Bed',
// // //       'baths': '3 Bath',
// // //       'sqft': '2600 sqft',
// // //       'image': 'assets/images/prop_extra_04.png',
// // //     },
// // //     {
// // //       'bhk': '1 BHK',
// // //       'title': '1 BHK Glassy Loft',
// // //       'location': 'Velachery, Chennai',
// // //       'price': '₹11,500 / month',
// // //       'beds': '1 Bed',
// // //       'baths': '1 Bath',
// // //       'sqft': '700 sqft',
// // //       'image': 'assets/images/prop_extra_05.png',
// // //     },
// // //     {
// // //       'bhk': '3 BHK',
// // //       'title': '3 BHK Luxury Mansion',
// // //       'location': 'Velachery, Chennai',
// // //       'price': '₹38,000 / month',
// // //       'beds': '3 Bed',
// // //       'baths': '4 Bath',
// // //       'sqft': '3000 sqft',
// // //       'image': 'assets/images/prop_extra_06.png',
// // //     },
// // //     {
// // //       'bhk': '2 BHK',
// // //       'title': '2 BHK Beachside Bungalow',
// // //       'location': 'Adyar, Chennai',
// // //       'price': '₹19,000 / month',
// // //       'beds': '2 Bed',
// // //       'baths': '2 Bath',
// // //       'sqft': '1400 sqft',
// // //       'image': 'assets/images/prop_extra_07.png',
// // //     },
// // //     {
// // //       'bhk': '2 BHK',
// // //       'title': '2 BHK Balcony Residence',
// // //       'location': 'Anna Nagar, Chennai',
// // //       'price': '₹18,200 / month',
// // //       'beds': '2 Bed',
// // //       'baths': '2 Bath',
// // //       'sqft': '1300 sqft',
// // //       'image': 'assets/images/prop_extra_08.png',
// // //     },
// // //     {
// // //       'bhk': '3 BHK',
// // //       'title': '3 BHK Balcony View Home',
// // //       'location': 'Porur, Chennai',
// // //       'price': '₹27,800 / month',
// // //       'beds': '3 Bed',
// // //       'baths': '2 Bath',
// // //       'sqft': '1900 sqft',
// // //       'image': 'assets/images/prop_extra_09.png',
// // //     },
// // //     {
// // //       'bhk': '2 BHK',
// // //       'title': '2 BHK Modern Duplex',
// // //       'location': 'T Nagar, Chennai',
// // //       'price': '₹20,500 / month',
// // //       'beds': '2 Bed',
// // //       'baths': '2 Bath',
// // //       'sqft': '1500 sqft',
// // //       'image': 'assets/images/prop_extra_10.png',
// // //     },
// // //     {
// // //       'bhk': '2 BHK',
// // //       'title': '2 BHK Designer Home',
// // //       'location': 'Nungambakkam, Chennai',
// // //       'price': '₹21,000 / month',
// // //       'beds': '2 Bed',
// // //       'baths': '2 Bath',
// // //       'sqft': '1550 sqft',
// // //       'image': 'assets/images/prop_extra_11.png',
// // //     },
// // //   ];

// // //   Future<void> _goToOwnerFlow(BuildContext context) async {
// // //     final bool verified = await OwnerVerificationStatus.isVerified();
// // //     if (!context.mounted) return;
// // //     if (verified) {
// // //       Navigator.push(
// // //         context,
// // //         MaterialPageRoute(builder: (context) => const OwnerDashboardScreen()),
// // //       );
// // //     } else {
// // //       Navigator.push(
// // //         context,
// // //         MaterialPageRoute(builder: (context) => const OwnerKycAadhaarScreen()),
// // //       );
// // //     }
// // //   }

// // //   // NEW: reusable app logo widget — rectangle (rounded-corner box) shape.
// // //   // Used in both the AppBar and the Drawer header, replacing the old
// // //   // black icon-box + Icons.home_rounded combo.
// // //   // IMPORTANT: uses BoxFit.contain (not cover) so the ENTIRE logo — the
// // //   // house outline, the "MYHOUSE.IN" wordmark, and the "RENTAL PROPERTIES"
// // //   // subtext — is always fully visible with nothing cropped off.
// // //   // `width` defaults to `height` (square) but can be made larger than
// // //   // `height` to extend the box further to the right only — the logo
// // //   // stays left-aligned inside it and just gets more room to render bigger.
// // //   Widget _appLogo({double height = 32, double? width, double radius = 10}) {
// // //     final double boxWidth = width ?? height;
// // //     return SizedBox(
// // //       height: height,
// // //       width: boxWidth,
// // //       child: Align(
// // //         alignment: Alignment.centerLeft,
// // //         child: ClipRRect(
// // //           borderRadius: BorderRadius.circular(radius),
// // //           child: Image.asset(
// // //             'assets/images/app_logo.png',
// // //             height: height,
// // //             fit: BoxFit.contain,
// // //             errorBuilder: (context, error, stackTrace) => Container(
// // //               height: height,
// // //               width: height,
// // //               decoration: BoxDecoration(
// // //                 color: primaryDark,
// // //                 borderRadius: BorderRadius.circular(radius),
// // //               ),
// // //               child: const Icon(Icons.home_rounded, color: Colors.white, size: 18),
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _featureBadge(IconData icon, String label) {
// // //     return Expanded(
// // //       child: Container(
// // //         margin: const EdgeInsets.symmetric(horizontal: 4),
// // //         padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
// // //         decoration: BoxDecoration(
// // //           color: Colors.white,
// // //           borderRadius: BorderRadius.circular(cardRadius),
// // //           border: Border.all(color: const Color(0xFFEDEEF3)),
// // //           boxShadow: [
// // //             BoxShadow(
// // //               color: Colors.grey.withOpacity(0.08),
// // //               blurRadius: 12,
// // //               offset: const Offset(0, 4),
// // //             ),
// // //           ],
// // //         ),
// // //         child: Column(
// // //           children: [
// // //             Icon(icon, size: 24, color: primaryDark),
// // //             const SizedBox(height: 8),
// // //             Text(
// // //               label,
// // //               textAlign: TextAlign.center,
// // //               style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _propertyImage(String path, {required double height}) {
// // //     if (path.startsWith('assets/')) {
// // //       return Image.asset(
// // //         path,
// // //         height: height,
// // //         width: double.infinity,
// // //         fit: BoxFit.cover,
// // //         errorBuilder: (context, error, stackTrace) => Container(
// // //           height: height,
// // //           color: const Color(0xFFF0F0F0),
// // //           child: const Icon(Icons.home, color: Colors.grey, size: 30),
// // //         ),
// // //       );
// // //     }
// // //     return Image.network(
// // //       path,
// // //       height: height,
// // //       width: double.infinity,
// // //       fit: BoxFit.cover,
// // //       errorBuilder: (context, error, stackTrace) => Container(
// // //         height: height,
// // //         color: const Color(0xFFF0F0F0),
// // //         child: const Icon(Icons.home, color: Colors.grey, size: 30),
// // //       ),
// // //     );
// // //   }

// // //   // FIX: wrapped the card in a GestureDetector so tapping anywhere on the
// // //   // card (not just "View All") opens PropertyDetailsScreen.
// // //   Widget _propertyCard(Map<String, String> data) {
// // //     return GestureDetector(
// // //       onTap: () {
// // //         Navigator.push(
// // //           context,
// // //           MaterialPageRoute(
// // //             builder: (context) => PropertyDetailsScreen(data: data),
// // //           ),
// // //         );
// // //       },
// // //       child: Container(
// // //         width: 220,
// // //         margin: const EdgeInsets.only(right: 14),
// // //         decoration: BoxDecoration(
// // //           color: Colors.white,
// // //           borderRadius: BorderRadius.circular(cardRadius),
// // //           boxShadow: [
// // //             BoxShadow(
// // //               color: Colors.grey.withOpacity(0.10),
// // //               blurRadius: 14,
// // //               offset: const Offset(0, 4),
// // //             ),
// // //           ],
// // //         ),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             Stack(
// // //               children: [
// // //                 ClipRRect(
// // //                   borderRadius: const BorderRadius.vertical(top: Radius.circular(cardRadius)),
// // //                   child: _propertyImage(data['image']!, height: 130),
// // //                 ),
// // //                 Positioned(
// // //                   top: 10,
// // //                   left: 10,
// // //                   child: Container(
// // //                     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
// // //                     decoration: BoxDecoration(
// // //                       color: primaryDark,
// // //                       borderRadius: BorderRadius.circular(8),
// // //                     ),
// // //                     child: Text(
// // //                       data['bhk']!,
// // //                       style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
// // //                     ),
// // //                   ),
// // //                 ),
// // //                 Positioned(
// // //                   top: 10,
// // //                   right: 10,
// // //                   child: _LikeButton(propertyKey: data['title']! + data['image']!),
// // //                 ),
// // //               ],
// // //             ),
// // //             Padding(
// // //               padding: const EdgeInsets.all(12),
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   Text(
// // //                     data['title']!,
// // //                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
// // //                   ),
// // //                   const SizedBox(height: 4),
// // //                   Row(
// // //                     children: [
// // //                       const Icon(Icons.location_on, size: 13, color: Colors.grey),
// // //                       const SizedBox(width: 3),
// // //                       Expanded(
// // //                         child: Text(
// // //                           data['location']!,
// // //                           style: const TextStyle(fontSize: 12, color: Colors.grey),
// // //                           overflow: TextOverflow.ellipsis,
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                   const SizedBox(height: 6),
// // //                   Text(
// // //                     data['price']!,
// // //                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: primaryDark),
// // //                   ),
// // //                   const SizedBox(height: 8),
// // //                   const Divider(height: 1),
// // //                   const SizedBox(height: 8),
// // //                   Row(
// // //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                     children: [
// // //                       _miniInfo(Icons.bed_outlined, data['beds']!),
// // //                       _miniInfo(Icons.bathtub_outlined, data['baths']!),
// // //                       _miniInfo(Icons.straighten, data['sqft']!),
// // //                     ],
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _miniInfo(IconData icon, String label) {
// // //     return Row(
// // //       children: [
// // //         Icon(icon, size: 13, color: Colors.grey[600]),
// // //         const SizedBox(width: 3),
// // //         Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
// // //       ],
// // //     );
// // //   }

// // //   Widget _stepItem(IconData icon, String title, String subtitle) {
// // //     return Expanded(
// // //       child: Column(
// // //         children: [
// // //           Container(
// // //             padding: const EdgeInsets.all(14),
// // //             decoration: const BoxDecoration(color: Color(0xFFEDEEF3), shape: BoxShape.circle),
// // //             child: Icon(icon, size: 20, color: primaryDark),
// // //           ),
// // //           const SizedBox(height: 8),
// // //           Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
// // //           const SizedBox(height: 2),
// // //           Text(
// // //             subtitle,
// // //             textAlign: TextAlign.center,
// // //             style: TextStyle(fontSize: 10, color: Colors.grey[600]),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _drawerSectionLabel(String label) {
// // //     return Padding(
// // //       padding: const EdgeInsets.fromLTRB(10, 14, 10, 8),
// // //       child: Text(
// // //         label.toUpperCase(),
// // //         style: TextStyle(
// // //           fontSize: 11,
// // //           fontWeight: FontWeight.w700,
// // //           letterSpacing: 0.8,
// // //           color: Colors.grey[500],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _drawerTile({
// // //     required IconData icon,
// // //     required Color iconBg,
// // //     required Color iconColor,
// // //     required String title,
// // //     required VoidCallback onTap,
// // //   }) {
// // //     return Material(
// // //       color: Colors.transparent,
// // //       borderRadius: BorderRadius.circular(14),
// // //       child: InkWell(
// // //         borderRadius: BorderRadius.circular(14),
// // //         onTap: onTap,
// // //         child: Padding(
// // //           padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
// // //           child: Row(
// // //             children: [
// // //               Container(
// // //                 padding: const EdgeInsets.all(10),
// // //                 decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)),
// // //                 child: Icon(icon, color: iconColor, size: 20),
// // //               ),
// // //               const SizedBox(width: 14),
// // //               Expanded(
// // //                 child: Text(
// // //                   title,
// // //                   style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: primaryDark),
// // //                 ),
// // //               ),
// // //               Icon(Icons.chevron_right_rounded, color: Colors.grey[400], size: 20),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       key: _scaffoldKey,
// // //       backgroundColor: bgLight,
// // //       drawer: Drawer(
// // //         backgroundColor: Colors.white,
// // //         child: SafeArea(
// // //           child: Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               Container(
// // //                 width: double.infinity,
// // //                 padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
// // //                 decoration: BoxDecoration(
// // //                   // Light-grey card look instead of solid black.
// // //                   // Darkened slightly and now flush with the top/left/
// // //                   // right edges — only the bottom corners are rounded.
// // //                   color: const Color(0xFFBFBFBF),
// // //                   borderRadius: const BorderRadius.only(
// // //                     bottomLeft: Radius.circular(24),
// // //                     bottomRight: Radius.circular(24),
// // //                   ),
// // //                 ),
// // //                 child: Row(
// // //                   children: [
// // //                     // Logo — rectangle shape, replaces old translucent
// // //                     // icon box. Slightly narrower now so the text sits
// // //                     // further left, closer to the logo.
// // //                     _appLogo(height: 68, width: 78, radius: 14),
// // //                     const SizedBox(width: 6),
// // //                     // FIX: tagline was wrapping/getting cut off with "…".
// // //                     // FittedBox (scaleDown) auto-shrinks the font just
// // //                     // enough so the FULL text always shows on one line.
// // //                     Expanded(
// // //                       child: Column(
// // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // //                         children: [
// // //                           const Text(
// // //                             'RENTO INDIA',
// // //                             style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: primaryDark, letterSpacing: 0.3),
// // //                           ),
// // //                           const SizedBox(height: 2),
// // //                           FittedBox(
// // //                             fit: BoxFit.scaleDown,
// // //                             alignment: Alignment.centerLeft,
// // //                             child: const Text(
// // //                               'Rent Anything, Anytime, Anywhere',
// // //                               maxLines: 1,
// // //                               style: TextStyle(fontSize: 9.5, color: Colors.black54),
// // //                             ),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),

// // //               const SizedBox(height: 8),

// // //               Expanded(
// // //                 child: ListView(
// // //                   padding: const EdgeInsets.symmetric(horizontal: 14),
// // //                   children: [
// // //                     _drawerSectionLabel('Services'),
// // //                     _drawerTile(
// // //                       icon: Icons.build_rounded,
// // //                       iconBg: const Color(0xFFFFF1E6),
// // //                       iconColor: const Color(0xFFE07A1F),
// // //                       title: 'Raise Maintenance Request',
// // //                       onTap: () {
// // //                         Navigator.pop(context);
// // //                         Navigator.push(
// // //                           context,
// // //                           MaterialPageRoute(builder: (context) => const MaintenanceRequestScreen()),
// // //                         );
// // //                       },
// // //                     ),
// // //                     _drawerTile(
// // //                       icon: Icons.receipt_long_rounded,
// // //                       iconBg: const Color(0xFFE9F3FF),
// // //                       iconColor: const Color(0xFF2C7BE5),
// // //                       title: 'Utility & Services',
// // //                       onTap: () {
// // //                         Navigator.pop(context);
// // //                         Navigator.push(
// // //                           context,
// // //                           MaterialPageRoute(builder: (context) => const UtilityPaymentsScreen()),
// // //                         );
// // //                       },
// // //                     ),

// // //                     const SizedBox(height: 8),
// // //                     const Divider(height: 1),
// // //                     const SizedBox(height: 8),

// // //                     _drawerSectionLabel('My Activity'),
// // //                     // "My Requests" tile removed — it pointed to
// // //                     // ApplicationStatusScreen, which was part of the
// // //                     // apply/agreement/payment flow that's been deleted.
// // //                     _drawerTile(
// // //                       icon: Icons.history_rounded,
// // //                       iconBg: const Color(0xFFE6F7EF),
// // //                       iconColor: const Color(0xFF1FAE6B),
// // //                       title: 'Visit History',
// // //                       onTap: () {
// // //                         Navigator.pop(context);
// // //                         Navigator.push(
// // //                           context,
// // //                           MaterialPageRoute(builder: (context) => const VisitHistoryScreen()),
// // //                         );
// // //                       },
// // //                     ),
// // //                     _drawerTile(
// // //                       icon: Icons.calendar_month_rounded,
// // //                       iconBg: const Color(0xFFFFECEC),
// // //                       iconColor: const Color(0xFFE0483F),
// // //                       title: 'Reschedule Visit',
// // //                       onTap: () {
// // //                         Navigator.pop(context);
// // //                         Navigator.push(
// // //                           context,
// // //                           MaterialPageRoute(builder: (context) => const RescheduleVisitScreen()),
// // //                         );
// // //                       },
// // //                     ),

// // //                     const SizedBox(height: 8),
// // //                     const Divider(height: 1),
// // //                     const SizedBox(height: 8),

// // //                     _drawerSectionLabel('More'),
// // //                     // New tile — opens the standalone Quick Access menu
// // //                     // (Apply, Application Status, Rental Agreement,
// // //                     // Payment, Rent Payment) without hooking into any
// // //                     // other flow.
// // //                     _drawerTile(
// // //                       icon: Icons.apps_rounded,
// // //                       iconBg: const Color(0xFFF3EEFE),
// // //                       iconColor: const Color(0xFF8B5CF6),
// // //                       title: 'Quick Access',
// // //                       onTap: () {
// // //                         Navigator.pop(context);
// // //                         Navigator.push(
// // //                           context,
// // //                           MaterialPageRoute(builder: (context) => const QuickAccessMenuScreen()),
// // //                         );
// // //                       },
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),

// // //               Padding(
// // //                 padding: const EdgeInsets.all(20),
// // //                 child: Text(
// // //                   'RENTO INDIA v1.0',
// // //                   style: TextStyle(fontSize: 11, color: Colors.grey[400]),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //       body: SafeArea(
// // //         child: SingleChildScrollView(
// // //           child: Padding(
// // //             padding: const EdgeInsets.all(16),
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 Row(
// // //                   children: [
// // //                     GestureDetector(
// // //                       onTap: () => _scaffoldKey.currentState?.openDrawer(),
// // //                       child: const Icon(Icons.menu, color: primaryDark),
// // //                     ),
// // //                     const SizedBox(width: 12),
// // //                     // Logo — narrower now so the text sits further left,
// // //                     // closer to the logo.
// // //                     _appLogo(height: 56, width: 76, radius: 14),
// // //                     const SizedBox(width: 6),
// // //                     // FIX: was `Flexible` + a separate `Spacer()` after it —
// // //                     // both are flex widgets with equal weight, so they
// // //                     // split the remaining width in half, squeezing this
// // //                     // text into a narrow column that wrapped onto 4 lines.
// // //                     // `Expanded` alone claims all the leftover space (and
// // //                     // still pushes the heart/bell icons to the far right
// // //                     // on its own).
// // //                     // FIX 2: the tagline was still getting cut off with
// // //                     // "…" on narrow screens. Wrapping it in a `FittedBox`
// // //                     // (scaleDown) auto-shrinks the font just enough so the
// // //                     // FULL text "Rent Anything, Anytime, Anywhere" always
// // //                     // shows on a single line — nothing truncated.
// // //                     Expanded(
// // //                       child: Column(
// // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // //                         children: [
// // //                           const Text(
// // //                             'RENTO INDIA',
// // //                             style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, letterSpacing: 0.3),
// // //                           ),
// // //                           FittedBox(
// // //                             fit: BoxFit.scaleDown,
// // //                             alignment: Alignment.centerLeft,
// // //                             child: const Text(
// // //                               'Rent Anything, Anytime, Anywhere',
// // //                               maxLines: 1,
// // //                               style: TextStyle(fontSize: 10, color: Colors.grey),
// // //                             ),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                     GestureDetector(
// // //                       onTap: () => Navigator.push(
// // //                         context,
// // //                         MaterialPageRoute(builder: (context) => const WishlistScreen()),
// // //                       ),
// // //                       child: AnimatedBuilder(
// // //                         animation: FavoritesManager.instance,
// // //                         builder: (context, _) {
// // //                           final count = FavoritesManager.instance.count;
// // //                           return Stack(
// // //                             clipBehavior: Clip.none,
// // //                             children: [
// // //                               const Icon(Icons.favorite_border, color: primaryDark, size: 24),
// // //                               if (count > 0)
// // //                                 Positioned(
// // //                                   top: -4,
// // //                                   right: -4,
// // //                                   child: Container(
// // //                                     padding: const EdgeInsets.all(3),
// // //                                     constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
// // //                                     decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
// // //                                     child: Text(
// // //                                       '$count',
// // //                                       textAlign: TextAlign.center,
// // //                                       style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700),
// // //                                     ),
// // //                                   ),
// // //                                 ),
// // //                             ],
// // //                           );
// // //                         },
// // //                       ),
// // //                     ),
// // //                     const SizedBox(width: 16),
// // //                     GestureDetector(
// // //                       onTap: () => Navigator.push(
// // //                         context,
// // //                         MaterialPageRoute(builder: (context) => const NotificationsScreen()),
// // //                       ),
// // //                       child: const Icon(Icons.notifications_none_rounded, color: primaryDark, size: 26),
// // //                     ),
// // //                   ],
// // //                 ),

// // //                 const SizedBox(height: 20),

// // //                 Container(
// // //                   padding: const EdgeInsets.all(18),
// // //                   decoration: BoxDecoration(
// // //                     color: const Color(0xFFEFEFF3),
// // //                     borderRadius: BorderRadius.circular(cardRadius),
// // //                   ),
// // //                   child: Column(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       const Text(
// // //                         'Find. Rent.\nLive Happy.',
// // //                         style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, height: 1.15),
// // //                       ),
// // //                       const SizedBox(height: 8),
// // //                       Text(
// // //                         'Your all-in-one rental solution.',
// // //                         style: TextStyle(fontSize: 13, color: Colors.grey[700]),
// // //                       ),
// // //                       const SizedBox(height: 16),
// // //                       ClipRRect(
// // //                         borderRadius: BorderRadius.circular(16),
// // //                         child: Image.asset(
// // //                           'assets/images/living_room_hero.jpg',
// // //                           height: 160,
// // //                           width: double.infinity,
// // //                           fit: BoxFit.cover,
// // //                           errorBuilder: (context, error, stackTrace) => Container(
// // //                             height: 160,
// // //                             color: Colors.grey[300],
// // //                             child: const Icon(Icons.home, size: 40, color: Colors.grey),
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),

// // //                 const SizedBox(height: 26),

// // //                 Row(
// // //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                   children: [
// // //                     const Text(
// // //                       'Popular Properties',
// // //                       style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
// // //                     ),
// // //                     GestureDetector(
// // //                       onTap: () {
// // //                         Navigator.push(
// // //                           context,
// // //                           MaterialPageRoute(
// // //                             builder: (context) => AllPropertiesScreen(properties: properties),
// // //                           ),
// // //                         );
// // //                       },
// // //                       child: const Row(
// // //                         children: [
// // //                           Text('View All', style: TextStyle(fontSize: 13, color: primaryDark)),
// // //                           Icon(Icons.chevron_right, size: 18, color: primaryDark),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //                 const SizedBox(height: 14),
// // //                 SizedBox(
// // //                   height: 290,
// // //                   child: ListView(
// // //                     scrollDirection: Axis.horizontal,
// // //                     children: properties.map((p) => _propertyCard(p)).toList(),
// // //                   ),
// // //                 ),

// // //                 const SizedBox(height: 26),

// // //                 Container(
// // //                   padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
// // //                   decoration: BoxDecoration(
// // //                     color: Colors.white,
// // //                     borderRadius: BorderRadius.circular(cardRadius),
// // //                     boxShadow: [
// // //                       BoxShadow(
// // //                         color: Colors.grey.withOpacity(0.08),
// // //                         blurRadius: 14,
// // //                         offset: const Offset(0, 4),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                   child: Column(
// // //                     children: [
// // //                       const Text(
// // //                         'Renting Made Simple',
// // //                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
// // //                       ),
// // //                       const SizedBox(height: 18),
// // //                       Row(
// // //                         children: [
// // //                           _stepItem(Icons.search, 'Search', 'Find the perfect\nproperty'),
// // //                           const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
// // //                           _stepItem(Icons.send_outlined, 'Request', 'Send request\nto owner'),
// // //                           const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
// // //                           _stepItem(Icons.assignment_outlined, 'Visit & Apply', 'Visit property &\nsubmit application'),
// // //                           const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
// // //                           _stepItem(Icons.home_outlined, 'Move In', 'Pay & move into\nyour new home'),
// // //                         ],
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),

// // //                 const SizedBox(height: 90),
// // //               ],
// // //             ),
// // //           ),
// // //         ),
// // //       ),

// // //       bottomNavigationBar: Container(
// // //         decoration: BoxDecoration(
// // //           color: Colors.white,
// // //           boxShadow: [
// // //             BoxShadow(
// // //               color: Colors.grey.withOpacity(0.15),
// // //               blurRadius: 12,
// // //               offset: const Offset(0, -2),
// // //             ),
// // //           ],
// // //         ),
// // //         child: SafeArea(
// // //           child: Padding(
// // //             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
// // //             child: Row(
// // //               mainAxisAlignment: MainAxisAlignment.spaceAround,
// // //               children: [
// // //                 _navItem(Icons.home, 'Home', 0),
// // //                 _navItem(Icons.search, 'Search', 1),
// // //                 _navAddButton(),
// // //                 _navItem(Icons.chat_bubble_outline, 'Chat', 3),
// // //                 _navItem(Icons.person_outline, 'Profile', 4),
// // //               ],
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _navItem(IconData icon, String label, int index) {
// // //     final bool selected = currentNavIndex == index;
// // //     return GestureDetector(
// // //       onTap: () {
// // //         setState(() => currentNavIndex = index);
// // //         if (index == 1) {
// // //           Navigator.push(
// // //             context,
// // //             MaterialPageRoute(builder: (context) => const SearchPropertyScreen()),
// // //           );
// // //         } else if (index == 3) {
// // //           Navigator.push(
// // //             context,
// // //             MaterialPageRoute(builder: (context) => const ChatScreen()),
// // //           );
// // //         } else if (index == 4) {
// // //           Navigator.push(
// // //             context,
// // //             MaterialPageRoute(builder: (context) => const ProfileScreen()),
// // //           );
// // //         }
// // //       },
// // //       child: Column(
// // //         mainAxisSize: MainAxisSize.min,
// // //         children: [
// // //           Icon(icon, size: 22, color: selected ? primaryDark : Colors.grey),
// // //           const SizedBox(height: 4),
// // //           Text(
// // //             label,
// // //             style: TextStyle(
// // //               fontSize: 11,
// // //               color: selected ? primaryDark : Colors.grey,
// // //               fontWeight: selected ? FontWeight.w700 : FontWeight.normal,
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _navAddButton() {
// // //     return GestureDetector(
// // //       onTap: () {
// // //         setState(() => currentNavIndex = 2);
// // //         _goToOwnerFlow(context);
// // //       },
// // //       child: Column(
// // //         mainAxisSize: MainAxisSize.min,
// // //         children: [
// // //           Container(
// // //             padding: const EdgeInsets.all(10),
// // //             decoration: BoxDecoration(
// // //               color: primaryDark,
// // //               borderRadius: BorderRadius.circular(10),
// // //             ),
// // //             child: const Icon(Icons.add, size: 20, color: Colors.white),
// // //           ),
// // //           const SizedBox(height: 4),
// // //           const Text('Add Property', style: TextStyle(fontSize: 10, color: primaryDark)),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // // class _LikeButton extends StatelessWidget {
// // //   final String propertyKey;
// // //   const _LikeButton({required this.propertyKey});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return AnimatedBuilder(
// // //       animation: FavoritesManager.instance,
// // //       builder: (context, _) {
// // //         final liked = FavoritesManager.instance.isLiked(propertyKey);
// // //         return GestureDetector(
// // //           onTap: () async {
// // //             await FavoritesManager.instance.toggle(propertyKey);
// // //             if (context.mounted) {
// // //               ScaffoldMessenger.of(context).hideCurrentSnackBar();
// // //               ScaffoldMessenger.of(context).showSnackBar(
// // //                 SnackBar(
// // //                   duration: const Duration(seconds: 1, milliseconds: 200),
// // //                   behavior: SnackBarBehavior.floating,
// // //                   backgroundColor: Colors.black87,
// // //                   content: Text(
// // //                     liked ? 'Removed from Wishlist' : 'Added to Wishlist ❤️',
// // //                     style: const TextStyle(fontSize: 13),
// // //                   ),
// // //                 ),
// // //               );
// // //             }
// // //           },
// // //           child: Container(
// // //             padding: const EdgeInsets.all(6),
// // //             decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
// // //             child: Icon(
// // //               liked ? Icons.favorite : Icons.favorite_border,
// // //               size: 16,
// // //               color: liked ? Colors.redAccent : Colors.black,
// // //             ),
// // //           ),
// // //         );
// // //       },
// // //     );
// // //   }
// // // }

// import 'package:flutter/material.dart';
// import 'search_property_screen.dart';
// import 'all_properties_screen.dart';
// import 'favorites_manager.dart';
// import 'wishlist_screen.dart';
// import 'chat_screen.dart';
// import 'maintenance_request_screen.dart';
// import 'utility_payments_screen.dart';
// import 'visit_history_screen.dart';
// import 'reschedule_visit_screen.dart';
// import 'notifications_screen.dart';
// import 'profile_screen.dart';
// import 'quick_access_menu_screen.dart';
// import 'property_details_screen.dart'; // Property Details — opened on card tap
// import 'owner/owner_property_list_screen.dart'; // Owner Dashboard
// import 'owner/kyc/owner_kyc_aadhaar_screen.dart'; // Owner KYC entry
// import 'owner/owner_verification_status.dart';

// class myhousehomescreen extends StatefulWidget {
//   const myhousehomescreen({super.key});

//   @override
//   State<myhousehomescreen> createState() => _myhousehomescreenState();
// }

// class _myhousehomescreenState extends State<myhousehomescreen> {
//   int currentNavIndex = 0;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     // Load previously-liked properties from disk so hearts show the
//     // correct state as soon as the Home screen opens.
//     FavoritesManager.instance.load();
//   }

//   // Pure black — was a navy/violet tone before (0xFF1A1A2E).
//   static const Color primaryDark = Color(0xFF000000);
//   static const Color bgLight = Color(0xFFF8F9FC);
//   static const double cardRadius = 20;

//   final List<Map<String, String>> properties = [
//     {
//       'bhk': '2 BHK',
//       'title': '2 BHK Apartment',
//       'location': 'Anna Nagar, Chennai',
//       'price': '₹12,000 / month',
//       'beds': '2 Bed',
//       'baths': '2 Bath',
//       'sqft': '1000 sqft',
//       'image': 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c',
//     },
//     {
//       'bhk': '3 BHK',
//       'title': '3 BHK Apartment',
//       'location': 'Nungambakkam, Chennai',
//       'price': '₹18,000 / month',
//       'beds': '3 Bed',
//       'baths': '2 Bath',
//       'sqft': '1200 sqft',
//       'image': 'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c',
//     },
//     {
//       'bhk': '1 BHK',
//       'title': '1 BHK Apartment',
//       'location': 'T. Nagar, Chennai',
//       'price': '₹10,000 / month',
//       'beds': '1 Bed',
//       'baths': '1 Bath',
//       'sqft': '650 sqft',
//       'image': 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c',
//     },
//     {
//       'bhk': 'Studio',
//       'title': 'A-Frame Modern Cabin',
//       'location': 'Anna Nagar, Chennai',
//       'price': '₹9,200 / month',
//       'beds': 'Studio',
//       'baths': '1 Bath',
//       'sqft': '420 sqft',
//       'image': 'assets/images/my_house/prop_extra_01.png',
//     },
//     {
//       'bhk': '3 BHK',
//       'title': '3 BHK Grand Villa',
//       'location': 'Adyar, Chennai',
//       'price': '₹32,000 / month',
//       'beds': '3 Bed',
//       'baths': '3 Bath',
//       'sqft': '2400 sqft',
//       'image': 'assets/images/my_house/prop_extra_02.png',
//     },
//     {
//       'bhk': '3 BHK',
//       'title': '3 BHK Contemporary Home',
//       'location': 'Nungambakkam, Chennai',
//       'price': '₹29,500 / month',
//       'beds': '3 Bed',
//       'baths': '3 Bath',
//       'sqft': '2100 sqft',
//       'image': 'assets/images/my_house/prop_extra_03.png',
//     },
//     {
//       'bhk': '3 BHK',
//       'title': '3 BHK Rooftop Garden Villa',
//       'location': 'Anna Nagar, Chennai',
//       'price': '₹35,000 / month',
//       'beds': '3 Bed',
//       'baths': '3 Bath',
//       'sqft': '2600 sqft',
//       'image': 'assets/images/my_house/prop_extra_04.png',
//     },
//     {
//       'bhk': '1 BHK',
//       'title': '1 BHK Glassy Loft',
//       'location': 'Velachery, Chennai',
//       'price': '₹11,500 / month',
//       'beds': '1 Bed',
//       'baths': '1 Bath',
//       'sqft': '700 sqft',
//       'image': 'assets/images/my_house/prop_extra_05.png',
//     },
//     {
//       'bhk': '3 BHK',
//       'title': '3 BHK Luxury Mansion',
//       'location': 'Velachery, Chennai',
//       'price': '₹38,000 / month',
//       'beds': '3 Bed',
//       'baths': '4 Bath',
//       'sqft': '3000 sqft',
//       'image': 'assets/images/my_house/prop_extra_06.png',
//     },
//     {
//       'bhk': '2 BHK',
//       'title': '2 BHK Beachside Bungalow',
//       'location': 'Adyar, Chennai',
//       'price': '₹19,000 / month',
//       'beds': '2 Bed',
//       'baths': '2 Bath',
//       'sqft': '1400 sqft',
//       'image': 'assets/images/my_house/prop_extra_07.png',
//     },
//     {
//       'bhk': '2 BHK',
//       'title': '2 BHK Balcony Residence',
//       'location': 'Anna Nagar, Chennai',
//       'price': '₹18,200 / month',
//       'beds': '2 Bed',
//       'baths': '2 Bath',
//       'sqft': '1300 sqft',
//       'image': 'assets/images/my_house/prop_extra_08.png',
//     },
//     {
//       'bhk': '3 BHK',
//       'title': '3 BHK Balcony View Home',
//       'location': 'Porur, Chennai',
//       'price': '₹27,800 / month',
//       'beds': '3 Bed',
//       'baths': '2 Bath',
//       'sqft': '1900 sqft',
//       'image': 'assets/images/my_house/prop_extra_09.png',
//     },
//     {
//       'bhk': '2 BHK',
//       'title': '2 BHK Modern Duplex',
//       'location': 'T Nagar, Chennai',
//       'price': '₹20,500 / month',
//       'beds': '2 Bed',
//       'baths': '2 Bath',
//       'sqft': '1500 sqft',
//       'image': 'assets/images/my_house/prop_extra_10.png',
//     },
//     {
//       'bhk': '2 BHK',
//       'title': '2 BHK Designer Home',
//       'location': 'Nungambakkam, Chennai',
//       'price': '₹21,000 / month',
//       'beds': '2 Bed',
//       'baths': '2 Bath',
//       'sqft': '1550 sqft',
//       'image': 'assets/images/my_house/prop_extra_11.png',
//     },
//   ];

//   Future<void> _goToOwnerFlow(BuildContext context) async {
//     final bool verified = await OwnerVerificationStatus.isVerified();
//     if (!context.mounted) return;
//     if (verified) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const OwnerDashboardScreen()),
//       );
//     } else {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const OwnerKycAadhaarScreen()),
//       );
//     }
//   }

//   // FIX: "Back to Rento India" drawer action. My House is opened from the
//   // Rento India home screen via Navigator.push, so that home screen is the
//   // very first route on this stack. popUntil(isFirst) unwinds My House
//   // (and anything pushed on top of it) and lands back on it — matching the
//   // client requirement that closing My House returns to the Rento India
//   // home page instead of exiting the whole app.
//   void _backToRentoIndia(BuildContext context) {
//     Navigator.pop(context); // close the drawer first
//     Navigator.popUntil(context, (route) => route.isFirst);
//   }

//   // NEW: reusable app logo widget — rectangle (rounded-corner box) shape.
//   // Used in both the AppBar and the Drawer header, replacing the old
//   // black icon-box + Icons.home_rounded combo.
//   // IMPORTANT: uses BoxFit.contain (not cover) so the ENTIRE logo — the
//   // house outline, the "MYHOUSE.IN" wordmark, and the "RENTAL PROPERTIES"
//   // subtext — is always fully visible with nothing cropped off.
//   // `width` defaults to `height` (square) but can be made larger than
//   // `height` to extend the box further to the right only — the logo
//   // stays left-aligned inside it and just gets more room to render bigger.
//   Widget _appLogo({double height = 32, double? width, double radius = 10}) {
//     final double boxWidth = width ?? height;
//     return SizedBox(
//       height: height,
//       width: boxWidth,
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(radius),
//           child: Image.asset(
//             'assets/images/my_house/app_logo.png',
//             height: height,
//             fit: BoxFit.contain,
//             errorBuilder: (context, error, stackTrace) => Container(
//               height: height,
//               width: height,
//               decoration: BoxDecoration(
//                 color: primaryDark,
//                 borderRadius: BorderRadius.circular(radius),
//               ),
//               child: const Icon(Icons.home_rounded, color: Colors.white, size: 18),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _featureBadge(IconData icon, String label) {
//     return Expanded(
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 4),
//         padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(cardRadius),
//           border: Border.all(color: const Color(0xFFEDEEF3)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.08),
//               blurRadius: 12,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             Icon(icon, size: 24, color: primaryDark),
//             const SizedBox(height: 8),
//             Text(
//               label,
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _propertyImage(String path, {required double height}) {
//     if (path.startsWith('assets/')) {
//       return Image.asset(
//         path,
//         height: height,
//         width: double.infinity,
//         fit: BoxFit.cover,
//         errorBuilder: (context, error, stackTrace) => Container(
//           height: height,
//           color: const Color(0xFFF0F0F0),
//           child: const Icon(Icons.home, color: Colors.grey, size: 30),
//         ),
//       );
//     }
//     return Image.network(
//       path,
//       height: height,
//       width: double.infinity,
//       fit: BoxFit.cover,
//       errorBuilder: (context, error, stackTrace) => Container(
//         height: height,
//         color: const Color(0xFFF0F0F0),
//         child: const Icon(Icons.home, color: Colors.grey, size: 30),
//       ),
//     );
//   }

//   // FIX: wrapped the card in a GestureDetector so tapping anywhere on the
//   // card (not just "View All") opens PropertyDetailsScreen.
//   Widget _propertyCard(Map<String, String> data) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PropertyDetailsScreen(data: data),
//           ),
//         );
//       },
//       child: Container(
//         width: 220,
//         margin: const EdgeInsets.only(right: 14),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(cardRadius),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.10),
//               blurRadius: 14,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(cardRadius)),
//                   child: _propertyImage(data['image']!, height: 130),
//                 ),
//                 Positioned(
//                   top: 10,
//                   left: 10,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                     decoration: BoxDecoration(
//                       color: primaryDark,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text(
//                       data['bhk']!,
//                       style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 10,
//                   right: 10,
//                   child: _LikeButton(propertyKey: data['title']! + data['image']!),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     data['title']!,
//                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     children: [
//                       const Icon(Icons.location_on, size: 13, color: Colors.grey),
//                       const SizedBox(width: 3),
//                       Expanded(
//                         child: Text(
//                           data['location']!,
//                           style: const TextStyle(fontSize: 12, color: Colors.grey),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     data['price']!,
//                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: primaryDark),
//                   ),
//                   const SizedBox(height: 8),
//                   const Divider(height: 1),
//                   const SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _miniInfo(Icons.bed_outlined, data['beds']!),
//                       _miniInfo(Icons.bathtub_outlined, data['baths']!),
//                       _miniInfo(Icons.straighten, data['sqft']!),
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

//   Widget _miniInfo(IconData icon, String label) {
//     return Row(
//       children: [
//         Icon(icon, size: 13, color: Colors.grey[600]),
//         const SizedBox(width: 3),
//         Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
//       ],
//     );
//   }

//   Widget _stepItem(IconData icon, String title, String subtitle) {
//     return Expanded(
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(14),
//             decoration: const BoxDecoration(color: Color(0xFFEDEEF3), shape: BoxShape.circle),
//             child: Icon(icon, size: 20, color: primaryDark),
//           ),
//           const SizedBox(height: 8),
//           Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
//           const SizedBox(height: 2),
//           Text(
//             subtitle,
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 10, color: Colors.grey[600]),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _drawerSectionLabel(String label) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(10, 14, 10, 8),
//       child: Text(
//         label.toUpperCase(),
//         style: TextStyle(
//           fontSize: 11,
//           fontWeight: FontWeight.w700,
//           letterSpacing: 0.8,
//           color: Colors.grey[500],
//         ),
//       ),
//     );
//   }

//   Widget _drawerTile({
//     required IconData icon,
//     required Color iconBg,
//     required Color iconColor,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return Material(
//       color: Colors.transparent,
//       borderRadius: BorderRadius.circular(14),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(14),
//         onTap: onTap,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//           child: Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)),
//                 child: Icon(icon, color: iconColor, size: 20),
//               ),
//               const SizedBox(width: 14),
//               Expanded(
//                 child: Text(
//                   title,
//                   style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: primaryDark),
//                 ),
//               ),
//               Icon(Icons.chevron_right_rounded, color: Colors.grey[400], size: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: bgLight,
//       drawer: Drawer(
//         backgroundColor: Colors.white,
//         child: SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
//                 decoration: BoxDecoration(
//                   // Light-grey card look instead of solid black.
//                   // Darkened slightly and now flush with the top/left/
//                   // right edges — only the bottom corners are rounded.
//                   color: const Color(0xFFBFBFBF),
//                   borderRadius: const BorderRadius.only(
//                     bottomLeft: Radius.circular(24),
//                     bottomRight: Radius.circular(24),
//                   ),
//                 ),
//                 child: Row(
//                   children: [
//                     // Logo — rectangle shape, replaces old translucent
//                     // icon box. Slightly narrower now so the text sits
//                     // further left, closer to the logo.
//                     _appLogo(height: 68, width: 78, radius: 14),
//                     const SizedBox(width: 6),
//                     // FIX: tagline was wrapping/getting cut off with "…".
//                     // FittedBox (scaleDown) auto-shrinks the font just
//                     // enough so the FULL text always shows on one line.
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'RENTO INDIA',
//                             style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: primaryDark, letterSpacing: 0.3),
//                           ),
//                           const SizedBox(height: 2),
//                           FittedBox(
//                             fit: BoxFit.scaleDown,
//                             alignment: Alignment.centerLeft,
//                             child: const Text(
//                               'Rent Anything, Anytime, Anywhere',
//                               maxLines: 1,
//                               style: TextStyle(fontSize: 9.5, color: Colors.black54),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 8),

//               Expanded(
//                 child: ListView(
//                   padding: const EdgeInsets.symmetric(horizontal: 14),
//                   children: [
//                     _drawerSectionLabel('Services'),
//                     _drawerTile(
//                       icon: Icons.build_rounded,
//                       iconBg: const Color(0xFFFFF1E6),
//                       iconColor: const Color(0xFFE07A1F),
//                       title: 'Raise Maintenance Request',
//                       onTap: () {
//                         Navigator.pop(context);
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => const MaintenanceRequestScreen()),
//                         );
//                       },
//                     ),
//                     _drawerTile(
//                       icon: Icons.receipt_long_rounded,
//                       iconBg: const Color(0xFFE9F3FF),
//                       iconColor: const Color(0xFF2C7BE5),
//                       title: 'Utility & Services',
//                       onTap: () {
//                         Navigator.pop(context);
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => const UtilityPaymentsScreen()),
//                         );
//                       },
//                     ),

//                     const SizedBox(height: 8),
//                     const Divider(height: 1),
//                     const SizedBox(height: 8),

//                     _drawerSectionLabel('My Activity'),
//                     // "My Requests" tile removed — it pointed to
//                     // ApplicationStatusScreen, which was part of the
//                     // apply/agreement/payment flow that's been deleted.
//                     _drawerTile(
//                       icon: Icons.history_rounded,
//                       iconBg: const Color(0xFFE6F7EF),
//                       iconColor: const Color(0xFF1FAE6B),
//                       title: 'Visit History',
//                       onTap: () {
//                         Navigator.pop(context);
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => const VisitHistoryScreen()),
//                         );
//                       },
//                     ),
//                     _drawerTile(
//                       icon: Icons.calendar_month_rounded,
//                       iconBg: const Color(0xFFFFECEC),
//                       iconColor: const Color(0xFFE0483F),
//                       title: 'Reschedule Visit',
//                       onTap: () {
//                         Navigator.pop(context);
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => const RescheduleVisitScreen()),
//                         );
//                       },
//                     ),

//                     const SizedBox(height: 8),
//                     const Divider(height: 1),
//                     const SizedBox(height: 8),

//                     _drawerSectionLabel('More'),
//                     // New tile — opens the standalone Quick Access menu
//                     // (Apply, Application Status, Rental Agreement,
//                     // Payment, Rent Payment) without hooking into any
//                     // other flow.
//                     _drawerTile(
//                       icon: Icons.apps_rounded,
//                       iconBg: const Color(0xFFF3EEFE),
//                       iconColor: const Color(0xFF8B5CF6),
//                       title: 'Quick Access',
//                       onTap: () {
//                         Navigator.pop(context);
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => const QuickAccessMenuScreen()),
//                         );
//                       },
//                     ),

//                     const SizedBox(height: 8),
//                     const Divider(height: 1),
//                     const SizedBox(height: 8),

//                     // NEW: client requirement — closing My House should
//                     // never close the whole app; it should always return
//                     // the user to the Rento India home page. This tile
//                     // gives users an explicit, visible way to do that from
//                     // the side menu (matches the reference screenshot).
//                     _drawerSectionLabel('Exit'),
//                     _drawerTile(
//                       icon: Icons.arrow_back_rounded,
//                       iconBg: const Color(0xFFEFEFEF),
//                       iconColor: primaryDark,
//                       title: 'Back to Rento India',
//                       onTap: () => _backToRentoIndia(context),
//                     ),
//                   ],
//                 ),
//               ),

//               Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Text(
//                   'RENTO INDIA v1.0',
//                   style: TextStyle(fontSize: 11, color: Colors.grey[400]),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     GestureDetector(
//                       onTap: () => _scaffoldKey.currentState?.openDrawer(),
//                       child: const Icon(Icons.menu, color: primaryDark),
//                     ),
//                     const SizedBox(width: 12),
//                     // Logo — narrower now so the text sits further left,
//                     // closer to the logo.
//                     _appLogo(height: 56, width: 76, radius: 14),
//                     const SizedBox(width: 6),
//                     // FIX: was `Flexible` + a separate `Spacer()` after it —
//                     // both are flex widgets with equal weight, so they
//                     // split the remaining width in half, squeezing this
//                     // text into a narrow column that wrapped onto 4 lines.
//                     // `Expanded` alone claims all the leftover space (and
//                     // still pushes the heart/bell icons to the far right
//                     // on its own).
//                     // FIX 2: the tagline was still getting cut off with
//                     // "…" on narrow screens. Wrapping it in a `FittedBox`
//                     // (scaleDown) auto-shrinks the font just enough so the
//                     // FULL text "Rent Anything, Anytime, Anywhere" always
//                     // shows on a single line — nothing truncated.
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'RENTO INDIA',
//                             style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, letterSpacing: 0.3),
//                           ),
//                           FittedBox(
//                             fit: BoxFit.scaleDown,
//                             alignment: Alignment.centerLeft,
//                             child: const Text(
//                               'Rent Anything, Anytime, Anywhere',
//                               maxLines: 1,
//                               style: TextStyle(fontSize: 10, color: Colors.grey),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => const WishlistScreen()),
//                       ),
//                       child: AnimatedBuilder(
//                         animation: FavoritesManager.instance,
//                         builder: (context, _) {
//                           final count = FavoritesManager.instance.count;
//                           return Stack(
//                             clipBehavior: Clip.none,
//                             children: [
//                               const Icon(Icons.favorite_border, color: primaryDark, size: 24),
//                               if (count > 0)
//                                 Positioned(
//                                   top: -4,
//                                   right: -4,
//                                   child: Container(
//                                     padding: const EdgeInsets.all(3),
//                                     constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
//                                     decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
//                                     child: Text(
//                                       '$count',
//                                       textAlign: TextAlign.center,
//                                       style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700),
//                                     ),
//                                   ),
//                                 ),
//                             ],
//                           );
//                         },
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     GestureDetector(
//                       onTap: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => const NotificationsScreen()),
//                       ),
//                       child: const Icon(Icons.notifications_none_rounded, color: primaryDark, size: 26),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 20),

//                 Container(
//                   padding: const EdgeInsets.all(18),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFEFEFF3),
//                     borderRadius: BorderRadius.circular(cardRadius),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Find. Rent.\nLive Happy.',
//                         style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, height: 1.15),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         'Your all-in-one rental solution.',
//                         style: TextStyle(fontSize: 13, color: Colors.grey[700]),
//                       ),
//                       const SizedBox(height: 16),
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(16),
//                         child: Image.asset(
//                           'assets/images/my_house/living_room_hero.jpg',
//                           height: 160,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) => Container(
//                             height: 160,
//                             color: Colors.grey[300],
//                             child: const Icon(Icons.home, size: 40, color: Colors.grey),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 26),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Popular Properties',
//                       style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => AllPropertiesScreen(properties: properties),
//                           ),
//                         );
//                       },
//                       child: const Row(
//                         children: [
//                           Text('View All', style: TextStyle(fontSize: 13, color: primaryDark)),
//                           Icon(Icons.chevron_right, size: 18, color: primaryDark),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 14),
//                 SizedBox(
//                   height: 290,
//                   child: ListView(
//                     scrollDirection: Axis.horizontal,
//                     children: properties.map((p) => _propertyCard(p)).toList(),
//                   ),
//                 ),

//                 const SizedBox(height: 26),

//                 Container(
//                   padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(cardRadius),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.08),
//                         blurRadius: 14,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       const Text(
//                         'Renting Made Simple',
//                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                       ),
//                       const SizedBox(height: 18),
//                       Row(
//                         children: [
//                           _stepItem(Icons.search, 'Search', 'Find the perfect\nproperty'),
//                           const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
//                           _stepItem(Icons.send_outlined, 'Request', 'Send request\nto owner'),
//                           const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
//                           _stepItem(Icons.assignment_outlined, 'Visit & Apply', 'Visit property &\nsubmit application'),
//                           const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
//                           _stepItem(Icons.home_outlined, 'Move In', 'Pay & move into\nyour new home'),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 90),
//               ],
//             ),
//           ),
//         ),
//       ),

//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.15),
//               blurRadius: 12,
//               offset: const Offset(0, -2),
//             ),
//           ],
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _navItem(Icons.home, 'Home', 0),
//                 _navItem(Icons.search, 'Search', 1),
//                 _navAddButton(),
//                 _navItem(Icons.chat_bubble_outline, 'Chat', 3),
//                 _navItem(Icons.person_outline, 'Profile', 4),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _navItem(IconData icon, String label, int index) {
//     final bool selected = currentNavIndex == index;
//     return GestureDetector(
//       onTap: () {
//         setState(() => currentNavIndex = index);
//         if (index == 1) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const SearchPropertyScreen()),
//           );
//         } else if (index == 3) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const ChatScreen()),
//           );
//         } else if (index == 4) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const ProfileScreen()),
//           );
//         }
//       },
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 22, color: selected ? primaryDark : Colors.grey),
//           const SizedBox(height: 4),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 11,
//               color: selected ? primaryDark : Colors.grey,
//               fontWeight: selected ? FontWeight.w700 : FontWeight.normal,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _navAddButton() {
//     return GestureDetector(
//       onTap: () {
//         setState(() => currentNavIndex = 2);
//         _goToOwnerFlow(context);
//       },
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: primaryDark,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Icon(Icons.add, size: 20, color: Colors.white),
//           ),
//           const SizedBox(height: 4),
//           const Text('Add Property', style: TextStyle(fontSize: 10, color: primaryDark)),
//         ],
//       ),
//     );
//   }
// }

// class _LikeButton extends StatelessWidget {
//   final String propertyKey;
//   const _LikeButton({required this.propertyKey});

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: FavoritesManager.instance,
//       builder: (context, _) {
//         final liked = FavoritesManager.instance.isLiked(propertyKey);
//         return GestureDetector(
//           onTap: () async {
//             await FavoritesManager.instance.toggle(propertyKey);
//             if (context.mounted) {
//               ScaffoldMessenger.of(context).hideCurrentSnackBar();
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   duration: const Duration(seconds: 1, milliseconds: 200),
//                   behavior: SnackBarBehavior.floating,
//                   backgroundColor: Colors.black87,
//                   content: Text(
//                     liked ? 'Removed from Wishlist' : 'Added to Wishlist ❤️',
//                     style: const TextStyle(fontSize: 13),
//                   ),
//                 ),
//               );
//             }
//           },
//           child: Container(
//             padding: const EdgeInsets.all(6),
//             decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
//             child: Icon(
//               liked ? Icons.favorite : Icons.favorite_border,
//               size: 16,
//               color: liked ? Colors.redAccent : Colors.black,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'search_property_screen.dart';
import 'all_properties_screen.dart';
import 'favorites_manager.dart';
import 'wishlist_screen.dart';
import 'chat_screen.dart';
import 'maintenance_request_screen.dart';
import 'utility_payments_screen.dart';
import 'visit_history_screen.dart';
import 'reschedule_visit_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';
import 'quick_access_menu_screen.dart';
import 'property_details_screen.dart'; // Property Details — opened on card tap
import 'owner/owner_property_list_screen.dart'; // Owner Dashboard
import 'owner/kyc/owner_kyc_aadhaar_screen.dart'; // Owner KYC entry
import 'owner/owner_verification_status.dart';
import 'package:rento_india/screens/home_screen.dart';


class myhousehomescreen extends StatefulWidget {
  const myhousehomescreen({super.key});

  @override
  State<myhousehomescreen> createState() => _myhousehomescreenState();
}

class _myhousehomescreenState extends State<myhousehomescreen> {
  int currentNavIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // Load previously-liked properties from disk so hearts show the
    // correct state as soon as the Home screen opens.
    FavoritesManager.instance.load();
  }

  // Pure black — was a navy/violet tone before (0xFF1A1A2E).
  static const Color primaryDark = Color(0xFF000000);
  static const Color bgLight = Color(0xFFF8F9FC);
  static const double cardRadius = 20;

  final List<Map<String, String>> properties = [
    {
      'bhk': '2 BHK',
      'title': '2 BHK Apartment',
      'location': 'Anna Nagar, Chennai',
      'price': '₹12,000 / month',
      'beds': '2 Bed',
      'baths': '2 Bath',
      'sqft': '1000 sqft',
      'image': 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c',
    },
    {
      'bhk': '3 BHK',
      'title': '3 BHK Apartment',
      'location': 'Nungambakkam, Chennai',
      'price': '₹18,000 / month',
      'beds': '3 Bed',
      'baths': '2 Bath',
      'sqft': '1200 sqft',
      'image': 'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c',
    },
    {
      'bhk': '1 BHK',
      'title': '1 BHK Apartment',
      'location': 'T. Nagar, Chennai',
      'price': '₹10,000 / month',
      'beds': '1 Bed',
      'baths': '1 Bath',
      'sqft': '650 sqft',
      'image': 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c',
    },
    {
      'bhk': 'Studio',
      'title': 'A-Frame Modern Cabin',
      'location': 'Anna Nagar, Chennai',
      'price': '₹9,200 / month',
      'beds': 'Studio',
      'baths': '1 Bath',
      'sqft': '420 sqft',
      'image': 'assets/images/my_house/prop_extra_01.png',
    },
    {
      'bhk': '3 BHK',
      'title': '3 BHK Grand Villa',
      'location': 'Adyar, Chennai',
      'price': '₹32,000 / month',
      'beds': '3 Bed',
      'baths': '3 Bath',
      'sqft': '2400 sqft',
      'image': 'assets/images/my_house/prop_extra_02.png',
    },
    {
      'bhk': '3 BHK',
      'title': '3 BHK Contemporary Home',
      'location': 'Nungambakkam, Chennai',
      'price': '₹29,500 / month',
      'beds': '3 Bed',
      'baths': '3 Bath',
      'sqft': '2100 sqft',
      'image': 'assets/images/my_house/prop_extra_03.png',
    },
    {
      'bhk': '3 BHK',
      'title': '3 BHK Rooftop Garden Villa',
      'location': 'Anna Nagar, Chennai',
      'price': '₹35,000 / month',
      'beds': '3 Bed',
      'baths': '3 Bath',
      'sqft': '2600 sqft',
      'image': 'assets/images/my_house/prop_extra_04.png',
    },
    {
      'bhk': '1 BHK',
      'title': '1 BHK Glassy Loft',
      'location': 'Velachery, Chennai',
      'price': '₹11,500 / month',
      'beds': '1 Bed',
      'baths': '1 Bath',
      'sqft': '700 sqft',
      'image': 'assets/images/my_house/prop_extra_05.png',
    },
    {
      'bhk': '3 BHK',
      'title': '3 BHK Luxury Mansion',
      'location': 'Velachery, Chennai',
      'price': '₹38,000 / month',
      'beds': '3 Bed',
      'baths': '4 Bath',
      'sqft': '3000 sqft',
      'image': 'assets/images/my_house/prop_extra_06.png',
    },
    {
      'bhk': '2 BHK',
      'title': '2 BHK Beachside Bungalow',
      'location': 'Adyar, Chennai',
      'price': '₹19,000 / month',
      'beds': '2 Bed',
      'baths': '2 Bath',
      'sqft': '1400 sqft',
      'image': 'assets/images/my_house/prop_extra_07.png',
    },
    {
      'bhk': '2 BHK',
      'title': '2 BHK Balcony Residence',
      'location': 'Anna Nagar, Chennai',
      'price': '₹18,200 / month',
      'beds': '2 Bed',
      'baths': '2 Bath',
      'sqft': '1300 sqft',
      'image': 'assets/images/my_house/prop_extra_08.png',
    },
    {
      'bhk': '3 BHK',
      'title': '3 BHK Balcony View Home',
      'location': 'Porur, Chennai',
      'price': '₹27,800 / month',
      'beds': '3 Bed',
      'baths': '2 Bath',
      'sqft': '1900 sqft',
      'image': 'assets/images/my_house/prop_extra_09.png',
    },
    {
      'bhk': '2 BHK',
      'title': '2 BHK Modern Duplex',
      'location': 'T Nagar, Chennai',
      'price': '₹20,500 / month',
      'beds': '2 Bed',
      'baths': '2 Bath',
      'sqft': '1500 sqft',
      'image': 'assets/images/my_house/prop_extra_10.png',
    },
    {
      'bhk': '2 BHK',
      'title': '2 BHK Designer Home',
      'location': 'Nungambakkam, Chennai',
      'price': '₹21,000 / month',
      'beds': '2 Bed',
      'baths': '2 Bath',
      'sqft': '1550 sqft',
      'image': 'assets/images/my_house/prop_extra_11.png',
    },
  ];

  Future<void> _goToOwnerFlow(BuildContext context) async {
    final bool verified = await OwnerVerificationStatus.isVerified();
    if (!context.mounted) return;
    if (verified) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OwnerDashboardScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OwnerKycAadhaarScreen()),
      );
    }
  }

  // FIX: "Back to Rento India" drawer action. My House is opened from the
  // Rento India home screen via Navigator.push, so that home screen is the
  // very first route on this stack. popUntil(isFirst) unwinds My House
  // (and anything pushed on top of it) and lands back on it — matching the
  // client requirement that closing My House returns to the Rento India
  // home page instead of exiting the whole app.
  //
  // FIX 2: closing the drawer (Navigator.pop) and then immediately popping
  // routes (Navigator.popUntil) in the same synchronous call caused
  // "Looking up a deactivated widget's ancestor is unsafe" — the drawer's
  // pop hadn't finished tearing down its subtree yet. Deferring the second
  // navigation to the next frame (and checking context.mounted first)
  // avoids touching a context that's mid-deactivation.
void _backToRentoIndia(BuildContext context) {
  Navigator.of(context).pop(); // close the drawer first

  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false, // clear the whole stack, land fresh on Home
      );
    }
  });
}

  // NEW: reusable app logo widget — rectangle (rounded-corner box) shape.
  // Used in both the AppBar and the Drawer header, replacing the old
  // black icon-box + Icons.home_rounded combo.
  // IMPORTANT: uses BoxFit.contain (not cover) so the ENTIRE logo — the
  // house outline, the "MYHOUSE.IN" wordmark, and the "RENTAL PROPERTIES"
  // subtext — is always fully visible with nothing cropped off.
  // `width` defaults to `height` (square) but can be made larger than
  // `height` to extend the box further to the right only — the logo
  // stays left-aligned inside it and just gets more room to render bigger.
  Widget _appLogo({double height = 32, double? width, double radius = 10}) {
    final double boxWidth = width ?? height;
    return SizedBox(
      height: height,
      width: boxWidth,
      child: Align(
        alignment: Alignment.centerLeft,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Image.asset(
            'assets/images/my_house/app_logo.png',
            height: height,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Container(
              height: height,
              width: height,
              decoration: BoxDecoration(
                color: primaryDark,
                borderRadius: BorderRadius.circular(radius),
              ),
              child: const Icon(Icons.home_rounded, color: Colors.white, size: 18),
            ),
          ),
        ),
      ),
    );
  }

  Widget _featureBadge(IconData icon, String label) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(cardRadius),
          border: Border.all(color: const Color(0xFFEDEEF3)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 24, color: primaryDark),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _propertyImage(String path, {required double height}) {
    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        height: height,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          height: height,
          color: const Color(0xFFF0F0F0),
          child: const Icon(Icons.home, color: Colors.grey, size: 30),
        ),
      );
    }
    return Image.network(
      path,
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        height: height,
        color: const Color(0xFFF0F0F0),
        child: const Icon(Icons.home, color: Colors.grey, size: 30),
      ),
    );
  }

  // FIX: wrapped the card in a GestureDetector so tapping anywhere on the
  // card (not just "View All") opens PropertyDetailsScreen.
  Widget _propertyCard(Map<String, String> data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PropertyDetailsScreen(data: data),
          ),
        );
      },
      child: Container(
        width: 220,
        margin: const EdgeInsets.only(right: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(cardRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.10),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(cardRadius)),
                  child: _propertyImage(data['image']!, height: 130),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: primaryDark,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      data['bhk']!,
                      style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: _LikeButton(propertyKey: data['title']! + data['image']!),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['title']!,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 13, color: Colors.grey),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          data['location']!,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    data['price']!,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: primaryDark),
                  ),
                  const SizedBox(height: 8),
                  const Divider(height: 1),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _miniInfo(Icons.bed_outlined, data['beds']!),
                      _miniInfo(Icons.bathtub_outlined, data['baths']!),
                      _miniInfo(Icons.straighten, data['sqft']!),
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

  Widget _miniInfo(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 13, color: Colors.grey[600]),
        const SizedBox(width: 3),
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
      ],
    );
  }

  Widget _stepItem(IconData icon, String title, String subtitle) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(color: Color(0xFFEDEEF3), shape: BoxShape.circle),
            child: Icon(icon, size: 20, color: primaryDark),
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
          const SizedBox(height: 2),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _drawerSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 14, 10, 8),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
          color: Colors.grey[500],
        ),
      ),
    );
  }

  Widget _drawerTile({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: primaryDark),
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: Colors.grey[400], size: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: bgLight,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
                decoration: BoxDecoration(
                  // Light-grey card look instead of solid black.
                  // Darkened slightly and now flush with the top/left/
                  // right edges — only the bottom corners are rounded.
                  color: const Color(0xFFBFBFBF),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: Row(
                  children: [
                    // Logo — rectangle shape, replaces old translucent
                    // icon box. Slightly narrower now so the text sits
                    // further left, closer to the logo.
                    _appLogo(height: 68, width: 78, radius: 14),
                    const SizedBox(width: 6),
                    // FIX: tagline was wrapping/getting cut off with "…".
                    // FittedBox (scaleDown) auto-shrinks the font just
                    // enough so the FULL text always shows on one line.
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'RENTO INDIA',
                            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: primaryDark, letterSpacing: 0.3),
                          ),
                          const SizedBox(height: 2),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Rent Anything, Anytime, Anywhere',
                              maxLines: 1,
                              style: TextStyle(fontSize: 9.5, color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  children: [
                    _drawerSectionLabel('Services'),
                    _drawerTile(
                      icon: Icons.build_rounded,
                      iconBg: const Color(0xFFFFF1E6),
                      iconColor: const Color(0xFFE07A1F),
                      title: 'Raise Maintenance Request',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MaintenanceRequestScreen()),
                        );
                      },
                    ),
                    _drawerTile(
                      icon: Icons.receipt_long_rounded,
                      iconBg: const Color(0xFFE9F3FF),
                      iconColor: const Color(0xFF2C7BE5),
                      title: 'Utility & Services',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const UtilityPaymentsScreen()),
                        );
                      },
                    ),

                    const SizedBox(height: 8),
                    const Divider(height: 1),
                    const SizedBox(height: 8),

                    _drawerSectionLabel('My Activity'),
                    // "My Requests" tile removed — it pointed to
                    // ApplicationStatusScreen, which was part of the
                    // apply/agreement/payment flow that's been deleted.
                    _drawerTile(
                      icon: Icons.history_rounded,
                      iconBg: const Color(0xFFE6F7EF),
                      iconColor: const Color(0xFF1FAE6B),
                      title: 'Visit History',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const VisitHistoryScreen()),
                        );
                      },
                    ),
                    _drawerTile(
                      icon: Icons.calendar_month_rounded,
                      iconBg: const Color(0xFFFFECEC),
                      iconColor: const Color(0xFFE0483F),
                      title: 'Reschedule Visit',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RescheduleVisitScreen()),
                        );
                      },
                    ),

                    const SizedBox(height: 8),
                    const Divider(height: 1),
                    const SizedBox(height: 8),

                    _drawerSectionLabel('More'),
                    // New tile — opens the standalone Quick Access menu
                    // (Apply, Application Status, Rental Agreement,
                    // Payment, Rent Payment) without hooking into any
                    // other flow.
                    _drawerTile(
                      icon: Icons.apps_rounded,
                      iconBg: const Color(0xFFF3EEFE),
                      iconColor: const Color(0xFF8B5CF6),
                      title: 'Quick Access',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const QuickAccessMenuScreen()),
                        );
                      },
                    ),

                    const SizedBox(height: 8),
                    const Divider(height: 1),
                    const SizedBox(height: 8),

                    // NEW: client requirement — closing My House should
                    // never close the whole app; it should always return
                    // the user to the Rento India home page. This tile
                    // gives users an explicit, visible way to do that from
                    // the side menu (matches the reference screenshot).
                    _drawerSectionLabel('Exit'),
                    _drawerTile(
                      icon: Icons.arrow_back_rounded,
                      iconBg: const Color(0xFFEFEFEF),
                      iconColor: primaryDark,
                      title: 'Back to Rento India',
                      onTap: () => _backToRentoIndia(context),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'RENTO INDIA v1.0',
                  style: TextStyle(fontSize: 11, color: Colors.grey[400]),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => _scaffoldKey.currentState?.openDrawer(),
                      child: const Icon(Icons.menu, color: primaryDark),
                    ),
                    const SizedBox(width: 12),
                    // Logo — narrower now so the text sits further left,
                    // closer to the logo.
                    _appLogo(height: 56, width: 76, radius: 14),
                    const SizedBox(width: 6),
                    // FIX: was `Flexible` + a separate `Spacer()` after it —
                    // both are flex widgets with equal weight, so they
                    // split the remaining width in half, squeezing this
                    // text into a narrow column that wrapped onto 4 lines.
                    // `Expanded` alone claims all the leftover space (and
                    // still pushes the heart/bell icons to the far right
                    // on its own).
                    // FIX 2: the tagline was still getting cut off with
                    // "…" on narrow screens. Wrapping it in a `FittedBox`
                    // (scaleDown) auto-shrinks the font just enough so the
                    // FULL text "Rent Anything, Anytime, Anywhere" always
                    // shows on a single line — nothing truncated.
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'RENTO INDIA',
                            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, letterSpacing: 0.3),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Rent Anything, Anytime, Anywhere',
                              maxLines: 1,
                              style: TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const WishlistScreen()),
                      ),
                      child: AnimatedBuilder(
                        animation: FavoritesManager.instance,
                        builder: (context, _) {
                          final count = FavoritesManager.instance.count;
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              const Icon(Icons.favorite_border, color: primaryDark, size: 24),
                              if (count > 0)
                                Positioned(
                                  top: -4,
                                  right: -4,
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                                    decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
                                    child: Text(
                                      '$count',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NotificationsScreen()),
                      ),
                      child: const Icon(Icons.notifications_none_rounded, color: primaryDark, size: 26),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFEFF3),
                    borderRadius: BorderRadius.circular(cardRadius),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Find. Rent.\nLive Happy.',
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, height: 1.15),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your all-in-one rental solution.',
                        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/images/my_house/living_room_hero.jpg',
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 160,
                            color: Colors.grey[300],
                            child: const Icon(Icons.home, size: 40, color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 26),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Popular Properties',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllPropertiesScreen(properties: properties),
                          ),
                        );
                      },
                      child: const Row(
                        children: [
                          Text('View All', style: TextStyle(fontSize: 13, color: primaryDark)),
                          Icon(Icons.chevron_right, size: 18, color: primaryDark),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 290,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: properties.map((p) => _propertyCard(p)).toList(),
                  ),
                ),

                const SizedBox(height: 26),

                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(cardRadius),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.08),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Renting Made Simple',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          _stepItem(Icons.search, 'Search', 'Find the perfect\nproperty'),
                          const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
                          _stepItem(Icons.send_outlined, 'Request', 'Send request\nto owner'),
                          const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
                          _stepItem(Icons.assignment_outlined, 'Visit & Apply', 'Visit property &\nsubmit application'),
                          const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
                          _stepItem(Icons.home_outlined, 'Move In', 'Pay & move into\nyour new home'),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 90),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navItem(Icons.home, 'Home', 0),
                _navItem(Icons.search, 'Search', 1),
                _navAddButton(),
                _navItem(Icons.chat_bubble_outline, 'Chat', 3),
                _navItem(Icons.person_outline, 'Profile', 4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final bool selected = currentNavIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() => currentNavIndex = index);
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SearchPropertyScreen()),
          );
        } else if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatScreen()),
          );
        } else if (index == 4) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 22, color: selected ? primaryDark : Colors.grey),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: selected ? primaryDark : Colors.grey,
              fontWeight: selected ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _navAddButton() {
    return GestureDetector(
      onTap: () {
        setState(() => currentNavIndex = 2);
        _goToOwnerFlow(context);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: primaryDark,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.add, size: 20, color: Colors.white),
          ),
          const SizedBox(height: 4),
          const Text('Add Property', style: TextStyle(fontSize: 10, color: primaryDark)),
        ],
      ),
    );
  }
}

class _LikeButton extends StatelessWidget {
  final String propertyKey;
  const _LikeButton({required this.propertyKey});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: FavoritesManager.instance,
      builder: (context, _) {
        final liked = FavoritesManager.instance.isLiked(propertyKey);
        return GestureDetector(
          onTap: () async {
            await FavoritesManager.instance.toggle(propertyKey);
            if (context.mounted) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 1, milliseconds: 200),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.black87,
                  content: Text(
                    liked ? 'Removed from Wishlist' : 'Added to Wishlist ❤️',
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Icon(
              liked ? Icons.favorite : Icons.favorite_border,
              size: 16,
              color: liked ? Colors.redAccent : Colors.black,
            ),
          ),
        );
      },
    );
  }
}