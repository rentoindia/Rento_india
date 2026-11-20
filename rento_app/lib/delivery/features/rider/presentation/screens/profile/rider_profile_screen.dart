// // import 'dart:typed_data';

// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:image_picker/image_picker.dart';
// // import '../../../../../core/constants/app_colors.dart';
// // import '../../../providers/rider_tab_provider.dart';
// // import '../../../../../core/routes/route_names.dart';

// // /// Profile tab — Rider module.
// // ///
// // /// Pure UI screen (no backend yet): every field below is local mock data
// // /// mirroring the reference design. Wire up a real RiderProfileRepository /
// // /// Riverpod-or-GetX provider later — the section builders are already
// // /// split out so swapping mock fields for provider data is a small, local
// // /// change. Follows the same black-header + curved-white-sheet pattern as
// // /// the Earnings tab.
// // ///
// // /// Reached as a bottom-nav tab in RiderShell — there's no Navigator route
// // /// to pop, so the back button falls back to riderTabIndexProvider (same
// // /// fix as EarningsScreen / AvailableRequestsScreen).
// // ///
// // /// NOTE: the "Performance Summary" grid was removed from this screen — it
// // /// duplicates what "View Dashboard" already shows (see _DashboardScreen
// // /// below), so there's no need to render it twice.
// // class RiderProfileScreen extends ConsumerStatefulWidget {
// //   const RiderProfileScreen({super.key});

// //   @override
// //   ConsumerState<RiderProfileScreen> createState() => _RiderProfileScreenState();
// // }

// // class _RiderProfileScreenState extends ConsumerState<RiderProfileScreen>
// //     with TickerProviderStateMixin {
// //   late final AnimationController _entrance;
// //   final ImagePicker _picker = ImagePicker();

// //   // ---- Mock rider profile data ---------------------------------------
// //   String _name = 'Karthik R';
// //   final String _riderId = 'RENTO-RDR-00412';
// //   double _rating = 4.8;
// //   int _totalTrips = 128;
// //   int _completedTrips = 125;
// //   double _successRate = 98;

// //   String _phone = '+91 98765 43210';
// //   String _email = 'karthik.rider@gmail.com';
// //   String _vehicleNumber = 'TN 09 AB 1234';
// //   String _vehicleType = '2 Wheeler';
// //   String _drivingLicense = 'TN09 20210012345';
// //   final String _licenseValidTill = '12 Jan 2027';
// //   final String _joiningDate = '12 March 2023';

// //   String _bankHolder = 'Karthik R';
// //   String _bankAccountNumber = '••••••••4242';
// //   String _ifsc = 'HDFC0001234';

// //   double _walletBalance = 2750;
// //   bool _autoPayout = true;
// //   String _payoutFrequency = 'Weekly';

// //   bool _notifTrips = true;
// //   bool _notifPromos = false;
// //   bool _notifPayouts = true;
// //   String _language = 'English';

// //   // Selected profile photo, picked via image_picker. Stored as raw bytes
// //   // (not a File) so this works on Flutter Web too — Image.file throws on
// //   // web since there's no real filesystem there. Null == no photo yet,
// //   // falls back to the initial-letter avatar.
// //   Uint8List? _profileImageBytes;

// //   static const List<_DocumentItem> _documents = [
// //     _DocumentItem(
// //       icon: Icons.badge_outlined,
// //       label: 'Aadhaar Card',
// //       status: 'Verified',
// //       valid: true,
// //       detail: 'Uploaded 12 March 2023 · Verified 14 March 2023',
// //     ),
// //     _DocumentItem(
// //       icon: Icons.credit_card,
// //       label: 'Driving License',
// //       status: 'Verified',
// //       valid: true,
// //       detail: 'Valid till 12 Jan 2027',
// //     ),
// //     _DocumentItem(
// //       icon: Icons.directions_car_outlined,
// //       label: 'Vehicle RC',
// //       status: 'Verified',
// //       valid: true,
// //       detail: 'Registered TN 09 AB 1234',
// //     ),
// //     _DocumentItem(
// //       icon: Icons.shield_outlined,
// //       label: 'Insurance',
// //       status: 'Valid till 10 Dec 2025',
// //       valid: true,
// //       detail: 'Policy renews automatically 30 days before expiry',
// //     ),
// //   ];

// //   static const List<_WalletTxn> _walletHistory = [
// //     _WalletTxn(
// //       title: 'Withdrawal to Bank',
// //       subtitle: 'HDFC •••• 4242',
// //       amount: -2000,
// //       date: '4 July, 2026',
// //       credit: false,
// //     ),
// //     _WalletTxn(
// //       title: 'Trip Earnings Credited',
// //       subtitle: 'Week of 30 June – 6 July',
// //       amount: 3120,
// //       date: '3 July, 2026',
// //       credit: true,
// //     ),
// //     _WalletTxn(
// //       title: 'Withdrawal to Bank',
// //       subtitle: 'HDFC •••• 4242',
// //       amount: 2500,
// //       date: '27 June, 2026',
// //       credit: false,
// //     ),
// //     _WalletTxn(
// //       title: 'Trip Earnings Credited',
// //       subtitle: 'Week of 23 – 29 June',
// //       amount: 2890,
// //       date: '26 June, 2026',
// //       credit: true,
// //     ),
// //   ];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _entrance = AnimationController(
// //       vsync: this,
// //       duration: const Duration(milliseconds: 900),
// //     )..forward();
// //   }

// //   @override
// //   void dispose() {
// //     _entrance.dispose();
// //     super.dispose();
// //   }

// //   void _toast(String message) {
// //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: Text(message),
// //         behavior: SnackBarBehavior.floating,
// //         backgroundColor: AppColors.primaryBlack,
// //         duration: const Duration(seconds: 2),
// //       ),
// //     );
// //   }

// //   // ---------------------------------------------------------------------
// //   // Profile photo — opens the device file/gallery picker via image_picker.
// //   // ---------------------------------------------------------------------
// //   Future<void> _pickProfilePhoto() async {
// //     try {
// //       final XFile? picked = await _picker.pickImage(
// //         source: ImageSource.gallery,
// //         imageQuality: 85,
// //         maxWidth: 800,
// //       );
// //       if (picked == null) return; // user cancelled the picker
// //       final bytes = await picked.readAsBytes();
// //       if (mounted) {
// //         setState(() => _profileImageBytes = bytes);
// //         _toast('Profile photo updated');
// //       }
// //     } catch (e) {
// //       if (mounted) _toast('Could not open photo picker');
// //     }
// //   }

// //   // ---------------------------------------------------------------------
// //   // Entrance animation helper — same staggered fade+slide as Earnings tab.
// //   // ---------------------------------------------------------------------
// //   // Section count reduced from 14 -> 12 after removing the Performance
// //   // Summary title + grid (that data now only lives in "View Dashboard").
// //   static const int _sectionCount = 12;

// //   Widget _fadeIn(int index, {required Widget child}) {
// //     final start = (index / _sectionCount) * 0.6;
// //     final end = (start + 0.4).clamp(0.0, 1.0);
// //     final curved = CurvedAnimation(
// //       parent: _entrance,
// //       curve: Interval(start, end, curve: Curves.easeOutCubic),
// //     );
// //     return AnimatedBuilder(
// //       animation: curved,
// //       child: child,
// //       builder: (context, child) {
// //         return Opacity(
// //           opacity: curved.value.clamp(0.0, 1.0),
// //           child: Transform.translate(
// //             offset: Offset(0, (1 - curved.value) * 18),
// //             child: child,
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: AppColors.primaryBlack,
// //       body: Column(
// //         children: [
// //           SafeArea(bottom: false, child: _buildCurvedHeaderBar(context)),
// //           Expanded(
// //             child: ClipRRect(
// //               borderRadius: const BorderRadius.vertical(
// //                 top: Radius.circular(28),
// //               ),
// //               child: Container(
// //                 color: const Color(0xFFF4F4F4),
// //                 child: SingleChildScrollView(
// //                   padding: const EdgeInsets.fromLTRB(16, 20, 16, 28),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.stretch,
// //                     children: [
// //                       _fadeIn(0, child: _buildProfileHeaderCard(context)),
// //                       const SizedBox(height: 22),
// //                       _fadeIn(1, child: _sectionTitle('Account Information')),
// //                       const SizedBox(height: 10),
// //                       _fadeIn(2, child: _buildAccountInfoCard()),
// //                       const SizedBox(height: 22),
// //                       _fadeIn(
// //                         3,
// //                         child: _sectionTitle(
// //                           'Documents',
// //                           action: 'View All',
// //                           onActionTap: () => _openDocuments(context),
// //                         ),
// //                       ),
// //                       const SizedBox(height: 10),
// //                       _fadeIn(4, child: _buildDocumentsCard(context)),
// //                       const SizedBox(height: 22),
// //                       _fadeIn(5, child: _sectionTitle('Wallet & Payout')),
// //                       const SizedBox(height: 10),
// //                       _fadeIn(6, child: _buildWalletCard(context)),
// //                       const SizedBox(height: 12),
// //                       _fadeIn(7, child: _buildWalletLinksCard(context)),
// //                       const SizedBox(height: 22),
// //                       _fadeIn(8, child: _sectionTitle('Settings')),
// //                       const SizedBox(height: 10),
// //                       _fadeIn(9, child: _buildSettingsCard(context)),
// //                       const SizedBox(height: 22),
// //                       _fadeIn(10, child: _buildLogoutButton(context)),
// //                       const SizedBox(height: 14),
// //                       _fadeIn(11, child: _buildVersionFooter()),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   // ---------------------------------------------------------------------
// //   // Curved black header bar (back button, title, edit action)
// //   // ---------------------------------------------------------------------
// //   Widget _buildCurvedHeaderBar(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.fromLTRB(4, 4, 12, 16),
// //       child: Row(
// //         children: [
// //           IconButton(
// //             icon: const Icon(Icons.arrow_back, color: AppColors.pureWhite),
// //             tooltip: 'Back',
// //             // FIX — Profile is always a bottom-nav TAB inside RiderShell,
// //             // never a separately pushed route. canPop() was true here
// //             // because of whatever sits underneath RiderShell in the
// //             // navigator stack (Mobile Entry, etc.), so pop() was popping
// //             // the entire shell instead of just switching tabs — that's
// //             // what caused the blank/broken-route screen. Always just
// //             // switch RiderShell back to the Home tab.
// //             onPressed: () {
// //               ref.read(riderTabIndexProvider.notifier).state = 0;
// //             },
// //           ),
// //           const Expanded(
// //             child: Text(
// //               'Profile',
// //               textAlign: TextAlign.center,
// //               style: TextStyle(
// //                 color: AppColors.pureWhite,
// //                 fontWeight: FontWeight.bold,
// //                 fontSize: 19,
// //               ),
// //             ),
// //           ),
// //           _HoverPressable(
// //             onTap: () => _openEditProfile(context),
// //             child: Container(
// //               padding: const EdgeInsets.all(9),
// //               decoration: BoxDecoration(
// //                 shape: BoxShape.circle,
// //                 border: Border.all(color: AppColors.pureWhite.withOpacity(0.4)),
// //               ),
// //               child: const Icon(
// //                 Icons.edit_outlined,
// //                 color: AppColors.pureWhite,
// //                 size: 17,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   // ---------------------------------------------------------------------
// //   // Profile header card: avatar, name, id, rating/trips, verified badge,
// //   // View Dashboard / Edit Profile actions.
// //   // ---------------------------------------------------------------------
// //   Widget _buildProfileHeaderCard(BuildContext context) {
// //     return Container(
// //       width: double.infinity,
// //       padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 20),
// //       decoration: BoxDecoration(
// //         color: AppColors.pureWhite,
// //         borderRadius: BorderRadius.circular(22),
// //         border: Border.all(color: AppColors.border),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.04),
// //             blurRadius: 16,
// //             offset: const Offset(0, 8),
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         children: [
// //           Stack(
// //             clipBehavior: Clip.none,
// //             children: [
// //               TweenAnimationBuilder<double>(
// //                 tween: Tween(begin: 0.85, end: 1),
// //                 duration: const Duration(milliseconds: 600),
// //                 curve: Curves.easeOutBack,
// //                 builder: (context, scale, child) =>
// //                     Transform.scale(scale: scale, child: child),
// //                 child: Container(
// //                   width: 84,
// //                   height: 84,
// //                   decoration: const BoxDecoration(
// //                     color: AppColors.primaryBlack,
// //                     shape: BoxShape.circle,
// //                   ),
// //                   alignment: Alignment.center,
// //                   clipBehavior: Clip.antiAlias,
// //                   child: _profileImageBytes != null
// //                       ? ClipOval(
// //                           child: Image.memory(
// //                             _profileImageBytes!,
// //                             width: 84,
// //                             height: 84,
// //                             fit: BoxFit.cover,
// //                           ),
// //                         )
// //                       : Text(
// //                           _name.trim().isNotEmpty
// //                               ? _name.trim()[0].toUpperCase()
// //                               : '?',
// //                           style: const TextStyle(
// //                             color: AppColors.pureWhite,
// //                             fontSize: 32,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                 ),
// //               ),
// //               Positioned(
// //                 right: -2,
// //                 bottom: -2,
// //                 child: _HoverPressable(
// //                   // Tapping the camera badge now opens the device's file /
// //                   // gallery picker (image_picker) instead of just a toast.
// //                   onTap: () => _pickProfilePhoto(),
// //                   child: Container(
// //                     padding: const EdgeInsets.all(6),
// //                     decoration: BoxDecoration(
// //                       color: AppColors.pureWhite,
// //                       shape: BoxShape.circle,
// //                       border: Border.all(color: AppColors.border),
// //                     ),
// //                     child: const Icon(
// //                       Icons.camera_alt_outlined,
// //                       size: 14,
// //                       color: AppColors.textPrimary,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //           const SizedBox(height: 14),
// //           Text(
// //             _name,
// //             style: const TextStyle(
// //               fontSize: 18,
// //               fontWeight: FontWeight.bold,
// //               color: AppColors.textPrimary,
// //             ),
// //           ),
// //           const SizedBox(height: 3),
// //           Text(
// //             'ID: $_riderId',
// //             style: const TextStyle(fontSize: 12, color: AppColors.textHint),
// //           ),
// //           const SizedBox(height: 10),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               const Icon(
// //                 Icons.star_rounded,
// //                 size: 16,
// //                 color: Color(0xFFF5A623),
// //               ),
// //               const SizedBox(width: 3),
// //               Text(
// //                 '$_rating Rating',
// //                 style: const TextStyle(
// //                   fontSize: 12.5,
// //                   fontWeight: FontWeight.w600,
// //                   color: AppColors.textSecondary,
// //                 ),
// //               ),
// //               const SizedBox(width: 14),
// //               Text(
// //                 '$_totalTrips Trips',
// //                 style: const TextStyle(
// //                   fontSize: 12.5,
// //                   fontWeight: FontWeight.w600,
// //                   color: AppColors.textSecondary,
// //                 ),
// //               ),
// //             ],
// //           ),
// //           const SizedBox(height: 12),
// //           Container(
// //             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
// //             decoration: BoxDecoration(
// //               color: AppColors.success.withOpacity(0.12),
// //               borderRadius: BorderRadius.circular(20),
// //             ),
// //             child: const Row(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 Icon(Icons.check_circle, size: 14, color: AppColors.success),
// //                 SizedBox(width: 5),
// //                 Text(
// //                   'Verified Rider',
// //                   style: TextStyle(
// //                     fontSize: 11.5,
// //                     fontWeight: FontWeight.w700,
// //                     color: AppColors.success,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           const SizedBox(height: 18),
// //           Row(
// //             children: [
// //               Expanded(
// //                 child: _HoverPressable(
// //                   onTap: () => _openDashboard(context),
// //                   child: Container(
// //                     padding: const EdgeInsets.symmetric(vertical: 12),
// //                     decoration: BoxDecoration(
// //                       color: AppColors.inputFill,
// //                       borderRadius: BorderRadius.circular(24),
// //                     ),
// //                     child: const Row(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: [
// //                         Icon(Icons.bar_chart, size: 15),
// //                         SizedBox(width: 6),
// //                         Text(
// //                           'View Dashboard',
// //                           style: TextStyle(
// //                             fontWeight: FontWeight.w700,
// //                             fontSize: 12.5,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(width: 10),
// //               Expanded(
// //                 child: _HoverPressable(
// //                   onTap: () => _openEditProfile(context),
// //                   child: Container(
// //                     padding: const EdgeInsets.symmetric(vertical: 12),
// //                     decoration: BoxDecoration(
// //                       color: AppColors.primaryBlack,
// //                       borderRadius: BorderRadius.circular(24),
// //                     ),
// //                     child: const Row(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: [
// //                         Icon(
// //                           Icons.edit_outlined,
// //                           size: 14,
// //                           color: AppColors.pureWhite,
// //                         ),
// //                         SizedBox(width: 6),
// //                         Text(
// //                           'Edit Profile',
// //                           style: TextStyle(
// //                             color: AppColors.pureWhite,
// //                             fontWeight: FontWeight.w700,
// //                             fontSize: 12.5,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   // ---------------------------------------------------------------------
// //   // Section title helper (reused for every section on this page)
// //   // ---------------------------------------------------------------------
// //   Widget _sectionTitle(
// //     String title, {
// //     String? action,
// //     VoidCallback? onActionTap,
// //   }) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //       children: [
// //         Text(
// //           title,
// //           style: const TextStyle(
// //             fontSize: 16,
// //             fontWeight: FontWeight.bold,
// //             color: AppColors.textPrimary,
// //           ),
// //         ),
// //         if (action != null)
// //           _HoverPressable(
// //             onTap: onActionTap ?? () => _toast('$action — coming soon'),
// //             child: Row(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 Text(
// //                   action,
// //                   style: const TextStyle(
// //                     fontSize: 12.5,
// //                     fontWeight: FontWeight.w600,
// //                     color: AppColors.textSecondary,
// //                   ),
// //                 ),
// //                 const Icon(
// //                   Icons.chevron_right,
// //                   size: 16,
// //                   color: AppColors.textSecondary,
// //                 ),
// //               ],
// //             ),
// //           ),
// //       ],
// //     );
// //   }

// //   // ---------------------------------------------------------------------
// //   // Account Information card
// //   // ---------------------------------------------------------------------
// //   Widget _buildAccountInfoCard() {
// //     final rows = [
// //       _InfoRowData(
// //         Icons.phone_outlined,
// //         const Color(0xFF4A90E2),
// //         'Phone Number',
// //         _phone,
// //       ),
// //       _InfoRowData(
// //         Icons.mail_outline,
// //         const Color(0xFFE86AA6),
// //         'Email',
// //         _email,
// //       ),
// //       _InfoRowData(
// //         Icons.directions_car_outlined,
// //         const Color(0xFFF5A623),
// //         'Vehicle Number',
// //         _vehicleNumber,
// //       ),
// //       _InfoRowData(
// //         Icons.category_outlined,
// //         const Color(0xFF2ECC71),
// //         'Vehicle Type',
// //         _vehicleType,
// //       ),
// //       _InfoRowData(
// //         Icons.badge_outlined,
// //         const Color(0xFF6C5CE7),
// //         'Driving License',
// //         '$_drivingLicense · Valid till $_licenseValidTill',
// //       ),
// //       _InfoRowData(
// //         Icons.event_outlined,
// //         const Color(0xFF888888),
// //         'Joining Date',
// //         _joiningDate,
// //       ),
// //     ];

// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
// //       decoration: BoxDecoration(
// //         color: AppColors.pureWhite,
// //         borderRadius: BorderRadius.circular(18),
// //         border: Border.all(color: AppColors.border),
// //       ),
// //       child: Column(
// //         children: List.generate(rows.length, (i) {
// //           final row = rows[i];
// //           final isLast = i == rows.length - 1;
// //           return Column(
// //             children: [
// //               _infoRow(row.icon, row.iconColor, row.label, row.value),
// //               if (!isLast) const Divider(height: 1, color: AppColors.divider),
// //             ],
// //           );
// //         }),
// //       ),
// //     );
// //   }

// //   Widget _infoRow(
// //     IconData icon,
// //     Color iconColor,
// //     String label,
// //     String value, {
// //     VoidCallback? onTap,
// //   }) {
// //     return _HoverPressable(
// //       onTap: onTap,
// //       child: Padding(
// //         padding: const EdgeInsets.symmetric(vertical: 12),
// //         child: Row(
// //           children: [
// //             Container(
// //               padding: const EdgeInsets.all(9),
// //               decoration: BoxDecoration(
// //                 color: iconColor.withOpacity(0.12),
// //                 borderRadius: BorderRadius.circular(10),
// //               ),
// //               child: Icon(icon, size: 16, color: iconColor),
// //             ),
// //             const SizedBox(width: 12),
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     label,
// //                     style: const TextStyle(
// //                       fontSize: 11.5,
// //                       color: AppColors.textHint,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 2),
// //                   Text(
// //                     value,
// //                     maxLines: 1,
// //                     overflow: TextOverflow.ellipsis,
// //                     style: const TextStyle(
// //                       fontSize: 13.5,
// //                       fontWeight: FontWeight.w600,
// //                       color: AppColors.textPrimary,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             if (onTap != null)
// //               const Icon(
// //                 Icons.chevron_right,
// //                 size: 18,
// //                 color: AppColors.textHint,
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // ---------------------------------------------------------------------
// //   // Documents card (preview — first few, "View All" opens the full list)
// //   // ---------------------------------------------------------------------
// //   Widget _buildDocumentsCard(BuildContext context) {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
// //       decoration: BoxDecoration(
// //         color: AppColors.pureWhite,
// //         borderRadius: BorderRadius.circular(18),
// //         border: Border.all(color: AppColors.border),
// //       ),
// //       child: Column(
// //         children: List.generate(_documents.length, (i) {
// //           final doc = _documents[i];
// //           final isLast = i == _documents.length - 1;
// //           return Column(
// //             children: [
// //               _documentRow(context, doc),
// //               if (!isLast) const Divider(height: 1, color: AppColors.divider),
// //             ],
// //           );
// //         }),
// //       ),
// //     );
// //   }

// //   Widget _documentRow(BuildContext context, _DocumentItem doc) {
// //     return _HoverPressable(
// //       onTap: () => _showDocumentDetail(context, doc),
// //       child: Padding(
// //         padding: const EdgeInsets.symmetric(vertical: 12),
// //         child: Row(
// //           children: [
// //             Container(
// //               padding: const EdgeInsets.all(9),
// //               decoration: BoxDecoration(
// //                 color: AppColors.inputFill,
// //                 shape: BoxShape.circle,
// //               ),
// //               child: Icon(doc.icon, size: 16, color: AppColors.textPrimary),
// //             ),
// //             const SizedBox(width: 12),
// //             Expanded(
// //               child: Text(
// //                 doc.label,
// //                 style: const TextStyle(
// //                   fontSize: 13.5,
// //                   fontWeight: FontWeight.w600,
// //                   color: AppColors.textPrimary,
// //                 ),
// //               ),
// //             ),
// //             Icon(
// //               doc.valid ? Icons.check_circle : Icons.error_outline,
// //               size: 15,
// //               color: doc.valid ? AppColors.success : Colors.orange,
// //             ),
// //             const SizedBox(width: 5),
// //             Flexible(
// //               child: Text(
// //                 doc.status,
// //                 textAlign: TextAlign.right,
// //                 maxLines: 1,
// //                 overflow: TextOverflow.ellipsis,
// //                 style: TextStyle(
// //                   fontSize: 11.5,
// //                   fontWeight: FontWeight.w600,
// //                   color: doc.valid ? AppColors.success : Colors.orange[800],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   void _showDocumentDetail(BuildContext context, _DocumentItem doc) {
// //     showModalBottomSheet(
// //       context: context,
// //       shape: const RoundedRectangleBorder(
// //         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
// //       ),
// //       builder: (sheetContext) => SafeArea(
// //         child: Padding(
// //           padding: const EdgeInsets.all(22),
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Center(
// //                 child: Container(
// //                   width: 40,
// //                   height: 4,
// //                   margin: const EdgeInsets.only(bottom: 18),
// //                   decoration: BoxDecoration(
// //                     color: AppColors.border,
// //                     borderRadius: BorderRadius.circular(4),
// //                   ),
// //                 ),
// //               ),
// //               Row(
// //                 children: [
// //                   Icon(doc.icon, size: 20, color: AppColors.textPrimary),
// //                   const SizedBox(width: 10),
// //                   Text(
// //                     doc.label,
// //                     style: const TextStyle(
// //                       fontWeight: FontWeight.bold,
// //                       fontSize: 17,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               const SizedBox(height: 8),
// //               Text(
// //                 doc.status,
// //                 style: TextStyle(
// //                   color: doc.valid ? AppColors.success : Colors.orange[800],
// //                   fontWeight: FontWeight.w700,
// //                   fontSize: 13,
// //                 ),
// //               ),
// //               const SizedBox(height: 10),
// //               Text(
// //                 doc.detail,
// //                 style: const TextStyle(
// //                   color: AppColors.textSecondary,
// //                   fontSize: 13,
// //                   height: 1.4,
// //                 ),
// //               ),
// //               const SizedBox(height: 18),
// //               SizedBox(
// //                 width: double.infinity,
// //                 height: 48,
// //                 child: OutlinedButton(
// //                   style: OutlinedButton.styleFrom(
// //                     side: const BorderSide(color: AppColors.border),
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(24),
// //                     ),
// //                   ),
// //                   onPressed: () {
// //                     Navigator.pop(sheetContext);
// //                     _toast('Re-upload ${doc.label} — coming soon');
// //                   },
// //                   child: const Text(
// //                     'Re-upload Document',
// //                     style: TextStyle(fontWeight: FontWeight.w600),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   void _openDocuments(BuildContext context) {
// //     Navigator.of(context).push(
// //       MaterialPageRoute(
// //         builder: (_) => _DocumentsListScreen(
// //           documents: _documents,
// //           onTapDocument: _showDocumentDetail,
// //         ),
// //       ),
// //     );
// //   }

// //   // ---------------------------------------------------------------------
// //   // Wallet balance card (black, matches Earnings hero-card styling)
// //   // ---------------------------------------------------------------------
// //   Widget _buildWalletCard(BuildContext context) {
// //     return Container(
// //       width: double.infinity,
// //       padding: const EdgeInsets.all(20),
// //       decoration: BoxDecoration(
// //         color: AppColors.primaryBlack,
// //         borderRadius: BorderRadius.circular(22),
// //         boxShadow: [
// //           BoxShadow(
// //             color: AppColors.primaryBlack.withOpacity(0.25),
// //             blurRadius: 20,
// //             offset: const Offset(0, 10),
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const Text(
// //             'WALLET BALANCE',
// //             style: TextStyle(
// //               color: AppColors.textHint,
// //               fontSize: 11,
// //               fontWeight: FontWeight.bold,
// //               letterSpacing: 0.6,
// //             ),
// //           ),
// //           const SizedBox(height: 8),
// //           _AnimatedCounter(
// //             animation: _entrance,
// //             target: _walletBalance,
// //             prefix: '₹',
// //             decimals: 2,
// //             style: const TextStyle(
// //               color: AppColors.pureWhite,
// //               fontSize: 30,
// //               fontWeight: FontWeight.bold,
// //               height: 1,
// //             ),
// //           ),
// //           const SizedBox(height: 18),
// //           Row(
// //             children: [
// //               Expanded(
// //                 child: _HoverPressable(
// //                   onTap: () => _showWithdrawSheet(context),
// //                   child: Container(
// //                     padding: const EdgeInsets.symmetric(vertical: 13),
// //                     decoration: BoxDecoration(
// //                       color: AppColors.pureWhite,
// //                       borderRadius: BorderRadius.circular(26),
// //                     ),
// //                     child: const Row(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: [
// //                         Icon(Icons.account_balance_wallet_outlined, size: 15),
// //                         SizedBox(width: 6),
// //                         Text(
// //                           'Withdraw',
// //                           style: TextStyle(
// //                             fontWeight: FontWeight.w700,
// //                             fontSize: 13,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(width: 10),
// //               Expanded(
// //                 child: _HoverPressable(
// //                   onTap: () => _openWalletHistory(context),
// //                   child: Container(
// //                     padding: const EdgeInsets.symmetric(vertical: 13),
// //                     decoration: BoxDecoration(
// //                       color: AppColors.pureWhite.withOpacity(0.12),
// //                       borderRadius: BorderRadius.circular(26),
// //                     ),
// //                     child: const Row(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: [
// //                         Icon(
// //                           Icons.history_rounded,
// //                           size: 15,
// //                           color: AppColors.pureWhite,
// //                         ),
// //                         SizedBox(width: 6),
// //                         Text(
// //                           'History',
// //                           style: TextStyle(
// //                             color: AppColors.pureWhite,
// //                             fontWeight: FontWeight.w700,
// //                             fontSize: 13,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   void _showWithdrawSheet(BuildContext context) {
// //     showModalBottomSheet(
// //       context: context,
// //       shape: const RoundedRectangleBorder(
// //         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
// //       ),
// //       builder: (sheetContext) => SafeArea(
// //         child: Padding(
// //           padding: const EdgeInsets.all(22),
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             crossAxisAlignment: CrossAxisAlignment.stretch,
// //             children: [
// //               Center(
// //                 child: Container(
// //                   width: 40,
// //                   height: 4,
// //                   margin: const EdgeInsets.only(bottom: 18),
// //                   decoration: BoxDecoration(
// //                     color: AppColors.border,
// //                     borderRadius: BorderRadius.circular(4),
// //                   ),
// //                 ),
// //               ),
// //               const Text(
// //                 'Withdraw',
// //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
// //               ),
// //               const SizedBox(height: 6),
// //               Text(
// //                 '₹${_walletBalance.toStringAsFixed(2)} will be transferred to '
// //                 'your linked bank account $_bankAccountNumber within 24 hours.',
// //                 style: const TextStyle(
// //                   color: AppColors.textSecondary,
// //                   fontSize: 13,
// //                 ),
// //               ),
// //               const SizedBox(height: 20),
// //               SizedBox(
// //                 width: double.infinity,
// //                 height: 52,
// //                 child: ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: AppColors.primaryBlack,
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(28),
// //                     ),
// //                     elevation: 0,
// //                   ),
// //                   onPressed: () {
// //                     Navigator.pop(sheetContext);
// //                     setState(() => _walletBalance = 0);
// //                     _toast('Withdrawal requested — funds arrive within 24h');
// //                   },
// //                   child: const Text(
// //                     'Confirm Withdrawal',
// //                     style: TextStyle(
// //                       color: AppColors.pureWhite,
// //                       fontWeight: FontWeight.w600,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   void _openWalletHistory(BuildContext context) {
// //     Navigator.of(context).push(
// //       MaterialPageRoute(
// //         builder: (_) =>
// //             const _WalletHistoryScreen(transactions: _walletHistory),
// //       ),
// //     );
// //   }

// //   // ---------------------------------------------------------------------
// //   // Wallet links card: Bank Account / Payout Settings / Transaction History
// //   // ---------------------------------------------------------------------
// //   Widget _buildWalletLinksCard(BuildContext context) {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
// //       decoration: BoxDecoration(
// //         color: AppColors.pureWhite,
// //         borderRadius: BorderRadius.circular(18),
// //         border: Border.all(color: AppColors.border),
// //       ),
// //       child: Column(
// //         children: [
// //           _infoRow(
// //             Icons.account_balance_outlined,
// //             const Color(0xFF4A90E2),
// //             'Bank Account',
// //             '•••• ${_bankAccountNumber.substring(_bankAccountNumber.length - 4)}',
// //             onTap: () => _openBankAccount(context),
// //           ),
// //           const Divider(height: 1, color: AppColors.divider),
// //           _infoRow(
// //             Icons.tune,
// //             const Color(0xFF6C5CE7),
// //             'Payout Settings',
// //             _autoPayout ? 'Auto · $_payoutFrequency' : 'Manual',
// //             onTap: () => _openPayoutSettings(context),
// //           ),
// //           const Divider(height: 1, color: AppColors.divider),
// //           _infoRow(
// //             Icons.list_alt_outlined,
// //             const Color(0xFF2ECC71),
// //             'Transaction History',
// //             '${_walletHistory.length} recent transactions',
// //             onTap: () => _openWalletHistory(context),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Future<void> _openBankAccount(BuildContext context) async {
// //     final result = await Navigator.of(context).push<Map<String, String>>(
// //       MaterialPageRoute(
// //         builder: (_) => _BankAccountScreen(
// //           holder: _bankHolder,
// //           accountNumber: _bankAccountNumber,
// //           ifsc: _ifsc,
// //         ),
// //       ),
// //     );
// //     if (result != null && mounted) {
// //       setState(() {
// //         _bankHolder = result['holder'] ?? _bankHolder;
// //         _bankAccountNumber = result['accountNumber'] ?? _bankAccountNumber;
// //         _ifsc = result['ifsc'] ?? _ifsc;
// //       });
// //       _toast('Bank details updated');
// //     }
// //   }

// //   Future<void> _openPayoutSettings(BuildContext context) async {
// //     final result = await Navigator.of(context).push<Map<String, dynamic>>(
// //       MaterialPageRoute(
// //         builder: (_) => _PayoutSettingsScreen(
// //           autoPayout: _autoPayout,
// //           frequency: _payoutFrequency,
// //         ),
// //       ),
// //     );
// //     if (result != null && mounted) {
// //       setState(() {
// //         _autoPayout = result['autoPayout'] as bool? ?? _autoPayout;
// //         _payoutFrequency = result['frequency'] as String? ?? _payoutFrequency;
// //       });
// //       _toast('Payout settings saved');
// //     }
// //   }

// //   // ---------------------------------------------------------------------
// //   // Settings card
// //   // ---------------------------------------------------------------------
// //   Widget _buildSettingsCard(BuildContext context) {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
// //       decoration: BoxDecoration(
// //         color: AppColors.pureWhite,
// //         borderRadius: BorderRadius.circular(18),
// //         border: Border.all(color: AppColors.border),
// //       ),
// //       child: Column(
// //         children: [
// //           _infoRow(
// //             Icons.notifications_none,
// //             const Color(0xFFF5A623),
// //             'Notification Settings',
// //             _notifTrips || _notifPromos || _notifPayouts ? 'On' : 'Off',
// //             onTap: () => _openNotificationSettings(context),
// //           ),
// //           const Divider(height: 1, color: AppColors.divider),
// //           _infoRow(
// //             Icons.language,
// //             const Color(0xFF4A90E2),
// //             'Language',
// //             _language,
// //             onTap: () => _pickLanguage(context),
// //           ),
// //           const Divider(height: 1, color: AppColors.divider),
// //           _infoRow(
// //             Icons.help_outline,
// //             const Color(0xFF6C5CE7),
// //             'Help & Support',
// //             'FAQs & contact',
// //             onTap: () => _showHelpSheet(context),
// //           ),
// //           const Divider(height: 1, color: AppColors.divider),
// //           _infoRow(
// //             Icons.description_outlined,
// //             const Color(0xFF888888),
// //             'Terms & Conditions',
// //             '',
// //             onTap: () => Navigator.of(context).push(
// //               MaterialPageRoute(
// //                 builder: (_) => const _StaticTextScreen(
// //                   title: 'Terms & Conditions',
// //                   body: _termsText,
// //                 ),
// //               ),
// //             ),
// //           ),
// //           const Divider(height: 1, color: AppColors.divider),
// //           _infoRow(
// //             Icons.lock_outline,
// //             const Color(0xFFE86AA6),
// //             'Privacy Policy',
// //             '',
// //             onTap: () => Navigator.of(context).push(
// //               MaterialPageRoute(
// //                 builder: (_) => const _StaticTextScreen(
// //                   title: 'Privacy Policy',
// //                   body: _privacyText,
// //                 ),
// //               ),
// //             ),
// //           ),
// //           const Divider(height: 1, color: AppColors.divider),
// //           _infoRow(
// //             Icons.info_outline,
// //             const Color(0xFF2ECC71),
// //             'About App',
// //             'v2.4.1',
// //             onTap: () => _showAboutDialog(context),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Future<void> _openNotificationSettings(BuildContext context) async {
// //     final result = await Navigator.of(context).push<Map<String, bool>>(
// //       MaterialPageRoute(
// //         builder: (_) => _NotificationSettingsScreen(
// //           trips: _notifTrips,
// //           promos: _notifPromos,
// //           payouts: _notifPayouts,
// //         ),
// //       ),
// //     );
// //     if (result != null && mounted) {
// //       setState(() {
// //         _notifTrips = result['trips'] ?? _notifTrips;
// //         _notifPromos = result['promos'] ?? _notifPromos;
// //         _notifPayouts = result['payouts'] ?? _notifPayouts;
// //       });
// //       _toast('Notification preferences saved');
// //     }
// //   }

// //   Future<void> _pickLanguage(BuildContext context) async {
// //     const options = [
// //       'English',
// //       'हिन्दी (Hindi)',
// //       'தமிழ் (Tamil)',
// //       'తెలుగు (Telugu)',
// //     ];
// //     final picked = await showDialog<String>(
// //       context: context,
// //       builder: (dialogContext) => SimpleDialog(
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// //         title: const Text('Choose Language'),
// //         children: options
// //             .map(
// //               (lang) => RadioListTile<String>(
// //                 value: lang,
// //                 groupValue: _language,
// //                 activeColor: AppColors.primaryBlack,
// //                 title: Text(lang),
// //                 onChanged: (value) => Navigator.pop(dialogContext, value),
// //               ),
// //             )
// //             .toList(),
// //       ),
// //     );
// //     if (picked != null && mounted) {
// //       setState(() => _language = picked);
// //       _toast('Language set to $picked');
// //     }
// //   }

// //   void _showAboutDialog(BuildContext context) {
// //     showDialog(
// //       context: context,
// //       builder: (dialogContext) => AlertDialog(
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// //         title: const Text('Rento India Rider'),
// //         content: const Text(
// //           'Version 2.4.1 (Build 2026.07)\n\n'
// //           'Rento India connects riders with rental pickup, delivery, and '
// //           'return jobs across the city.',
// //           style: TextStyle(height: 1.4),
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.pop(dialogContext),
// //             child: const Text('Close'),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   void _showHelpSheet(BuildContext context) {
// //     showModalBottomSheet(
// //       context: context,
// //       isScrollControlled: true,
// //       shape: const RoundedRectangleBorder(
// //         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
// //       ),
// //       builder: (sheetContext) {
// //         final maxHeight = MediaQuery.of(sheetContext).size.height * 0.85;
// //         return ConstrainedBox(
// //           constraints: BoxConstraints(maxHeight: maxHeight),
// //           child: SafeArea(
// //             child: SingleChildScrollView(
// //               padding: const EdgeInsets.all(22),
// //               child: Column(
// //                 mainAxisSize: MainAxisSize.min,
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Center(
// //                     child: Container(
// //                       width: 40,
// //                       height: 4,
// //                       margin: const EdgeInsets.only(bottom: 18),
// //                       decoration: BoxDecoration(
// //                         color: AppColors.border,
// //                         borderRadius: BorderRadius.circular(4),
// //                       ),
// //                     ),
// //                   ),
// //                   const Text(
// //                     'Help & Support',
// //                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
// //                   ),
// //                   const SizedBox(height: 16),
// //                   _helpItem(
// //                     'How do I update my documents?',
// //                     'Go to Documents → tap the document → Re-upload '
// //                         'Document. Verification usually takes under 24 hours.',
// //                   ),
// //                   _helpItem(
// //                     'How do I change my bank account?',
// //                     'Go to Wallet & Payout → Bank Account → Edit, then '
// //                         'save your new account details.',
// //                   ),
// //                   _helpItem(
// //                     'Who do I contact for a trip issue?',
// //                     'Use "Contact Support" from the Help & Support menu, '
// //                         'or reach the in-app support chat from your trip '
// //                         'details screen.',
// //                   ),
// //                   const SizedBox(height: 10),
// //                   SizedBox(
// //                     width: double.infinity,
// //                     height: 48,
// //                     child: OutlinedButton(
// //                       style: OutlinedButton.styleFrom(
// //                         side: const BorderSide(color: AppColors.border),
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(24),
// //                         ),
// //                       ),
// //                       onPressed: () {
// //                         Navigator.pop(sheetContext);
// //                         _toast('Opening support chat — coming soon');
// //                       },
// //                       child: const Text(
// //                         'Contact Support',
// //                         style: TextStyle(fontWeight: FontWeight.w600),
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   Widget _helpItem(String question, String answer) {
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 16),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(
// //             question,
// //             style: const TextStyle(
// //               fontWeight: FontWeight.w700,
// //               fontSize: 14,
// //               color: AppColors.textPrimary,
// //             ),
// //           ),
// //           const SizedBox(height: 4),
// //           Text(
// //             answer,
// //             style: const TextStyle(
// //               fontSize: 13,
// //               color: AppColors.textSecondary,
// //               height: 1.4,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   // ---------------------------------------------------------------------
// //   // Edit profile / view dashboard
// //   // ---------------------------------------------------------------------
// //   Future<void> _openEditProfile(BuildContext context) async {
// //     final result = await Navigator.of(context).push<Map<String, String>>(
// //       MaterialPageRoute(
// //         builder: (_) => _EditProfileScreen(
// //           name: _name,
// //           phone: _phone,
// //           email: _email,
// //           vehicleNumber: _vehicleNumber,
// //           vehicleType: _vehicleType,
// //           drivingLicense: _drivingLicense,
// //         ),
// //       ),
// //     );
// //     if (result != null && mounted) {
// //       setState(() {
// //         _name = result['name'] ?? _name;
// //         _phone = result['phone'] ?? _phone;
// //         _email = result['email'] ?? _email;
// //         _vehicleNumber = result['vehicleNumber'] ?? _vehicleNumber;
// //         _vehicleType = result['vehicleType'] ?? _vehicleType;
// //         _drivingLicense = result['drivingLicense'] ?? _drivingLicense;
// //       });
// //       _toast('Profile updated');
// //     }
// //   }

// //   void _openDashboard(BuildContext context) {
// //     Navigator.of(context).push(
// //       MaterialPageRoute(
// //         builder: (_) => _DashboardScreen(
// //           totalTrips: _totalTrips,
// //           completedTrips: _completedTrips,
// //           rating: _rating,
// //           successRate: _successRate,
// //         ),
// //       ),
// //     );
// //   }

// //   // ---------------------------------------------------------------------
// //   // Log out
// //   // ---------------------------------------------------------------------
// //   Widget _buildLogoutButton(BuildContext context) {
// //     return _HoverPressable(
// //       onTap: () => _confirmLogout(context),
// //       child: Container(
// //         padding: const EdgeInsets.symmetric(vertical: 15),
// //         decoration: BoxDecoration(
// //           color: AppColors.pureWhite,
// //           borderRadius: BorderRadius.circular(18),
// //           border: Border.all(color: AppColors.border),
// //         ),
// //         child: const Row(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             Icon(Icons.logout_rounded, size: 17, color: Colors.redAccent),
// //             SizedBox(width: 8),
// //             Text(
// //               'Log Out',
// //               style: TextStyle(
// //                 color: Colors.redAccent,
// //                 fontWeight: FontWeight.w700,
// //                 fontSize: 14,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Future<void> _confirmLogout(BuildContext context) async {
// //     final confirmed = await showDialog<bool>(
// //       context: context,
// //       builder: (dialogContext) => AlertDialog(
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// //         title: const Text('Log Out?'),
// //         content: const Text(
// //           'You\'ll need to verify your mobile number again to sign back in.',
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.pop(dialogContext, false),
// //             child: const Text('Cancel'),
// //           ),
// //           TextButton(
// //             onPressed: () => Navigator.pop(dialogContext, true),
// //             child: const Text(
// //               'Log Out',
// //               style: TextStyle(color: Colors.redAccent),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //     if (confirmed == true && mounted) {
// //       // TODO: wire this to the real auth/session controller
// //       // (e.g. Get.find<AuthController>().logout()) once the backend
// //       // and login flow are connected.
// //       // ⭐ FIX — route.isFirst popped to whatever sits at the very
// //       // bottom of the navigator stack instead of actually logging out;
// //       // this now clears the whole stack and sends the rider back to
// //       // Mobile Entry, same as the drawer's Log Out action.
// //       Navigator.of(
// //         context,
// //       ).pushNamedAndRemoveUntil(RouteNames.mobileEntry, (route) => false);
// //       _toast('Logged out');
// //     }
// //   }

// //   Widget _buildVersionFooter() {
// //     return const Center(
// //       child: Text(
// //         'Rento India Rider v2.4.1 · Build 2026.07',
// //         style: TextStyle(fontSize: 11, color: AppColors.textHint),
// //       ),
// //     );
// //   }
// // }

// // // =============================================================================
// // // Full Documents list screen ("View All")
// // // =============================================================================
// // class _DocumentsListScreen extends StatelessWidget {
// //   final List<_DocumentItem> documents;
// //   final void Function(BuildContext, _DocumentItem) onTapDocument;

// //   const _DocumentsListScreen({
// //     required this.documents,
// //     required this.onTapDocument,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF4F4F4),
// //       appBar: AppBar(
// //         backgroundColor: const Color(0xFFF4F4F4),
// //         elevation: 0,
// //         title: const Text(
// //           'Documents',
// //           style: TextStyle(
// //             color: AppColors.textPrimary,
// //             fontWeight: FontWeight.bold,
// //             fontSize: 18,
// //           ),
// //         ),
// //         iconTheme: const IconThemeData(color: AppColors.textPrimary),
// //       ),
// //       body: SafeArea(
// //         top: false,
// //         child: ListView.separated(
// //           padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
// //           itemCount: documents.length,
// //           separatorBuilder: (_, __) => const SizedBox(height: 10),
// //           itemBuilder: (context, i) {
// //             final doc = documents[i];
// //             return _HoverPressable(
// //               onTap: () => onTapDocument(context, doc),
// //               liftOnHover: true,
// //               child: Container(
// //                 padding: const EdgeInsets.all(14),
// //                 decoration: BoxDecoration(
// //                   color: AppColors.pureWhite,
// //                   borderRadius: BorderRadius.circular(16),
// //                   border: Border.all(color: AppColors.border),
// //                 ),
// //                 child: Row(
// //                   children: [
// //                     Container(
// //                       padding: const EdgeInsets.all(10),
// //                       decoration: const BoxDecoration(
// //                         color: AppColors.inputFill,
// //                         shape: BoxShape.circle,
// //                       ),
// //                       child: Icon(
// //                         doc.icon,
// //                         size: 18,
// //                         color: AppColors.textPrimary,
// //                       ),
// //                     ),
// //                     const SizedBox(width: 12),
// //                     Expanded(
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Text(
// //                             doc.label,
// //                             style: const TextStyle(
// //                               fontSize: 13.5,
// //                               fontWeight: FontWeight.w700,
// //                               color: AppColors.textPrimary,
// //                             ),
// //                           ),
// //                           const SizedBox(height: 2),
// //                           Text(
// //                             doc.status,
// //                             style: TextStyle(
// //                               fontSize: 11.5,
// //                               fontWeight: FontWeight.w600,
// //                               color: doc.valid
// //                                   ? AppColors.success
// //                                   : Colors.orange[800],
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                     const Icon(
// //                       Icons.chevron_right,
// //                       size: 18,
// //                       color: AppColors.textHint,
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // =============================================================================
// // // Wallet transaction history screen
// // // =============================================================================
// // class _WalletHistoryScreen extends StatelessWidget {
// //   final List<_WalletTxn> transactions;

// //   const _WalletHistoryScreen({required this.transactions});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF4F4F4),
// //       appBar: AppBar(
// //         backgroundColor: const Color(0xFFF4F4F4),
// //         elevation: 0,
// //         title: const Text(
// //           'Wallet History',
// //           style: TextStyle(
// //             color: AppColors.textPrimary,
// //             fontWeight: FontWeight.bold,
// //             fontSize: 18,
// //           ),
// //         ),
// //         iconTheme: const IconThemeData(color: AppColors.textPrimary),
// //       ),
// //       body: SafeArea(
// //         top: false,
// //         child: ListView.separated(
// //           padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
// //           itemCount: transactions.length,
// //           separatorBuilder: (_, __) => const SizedBox(height: 10),
// //           itemBuilder: (context, i) {
// //             final txn = transactions[i];
// //             return Container(
// //               padding: const EdgeInsets.all(14),
// //               decoration: BoxDecoration(
// //                 color: AppColors.pureWhite,
// //                 borderRadius: BorderRadius.circular(16),
// //                 border: Border.all(color: AppColors.border),
// //               ),
// //               child: Row(
// //                 children: [
// //                   Container(
// //                     padding: const EdgeInsets.all(10),
// //                     decoration: BoxDecoration(
// //                       color: (txn.credit ? AppColors.success : Colors.redAccent)
// //                           .withOpacity(0.12),
// //                       shape: BoxShape.circle,
// //                     ),
// //                     child: Icon(
// //                       txn.credit
// //                           ? Icons.arrow_downward_rounded
// //                           : Icons.arrow_upward_rounded,
// //                       size: 18,
// //                       color: txn.credit ? AppColors.success : Colors.redAccent,
// //                     ),
// //                   ),
// //                   const SizedBox(width: 12),
// //                   Expanded(
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text(
// //                           txn.title,
// //                           style: const TextStyle(
// //                             fontSize: 13.5,
// //                             fontWeight: FontWeight.w700,
// //                             color: AppColors.textPrimary,
// //                           ),
// //                         ),
// //                         const SizedBox(height: 2),
// //                         Text(
// //                           txn.subtitle,
// //                           style: const TextStyle(
// //                             fontSize: 11.5,
// //                             color: AppColors.textSecondary,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   Column(
// //                     crossAxisAlignment: CrossAxisAlignment.end,
// //                     children: [
// //                       Text(
// //                         '${txn.credit ? '+' : '-'}₹${txn.amount.abs()}',
// //                         style: TextStyle(
// //                           fontSize: 14.5,
// //                           fontWeight: FontWeight.bold,
// //                           color: txn.credit
// //                               ? AppColors.success
// //                               : Colors.redAccent,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 3),
// //                       Text(
// //                         txn.date,
// //                         style: const TextStyle(
// //                           fontSize: 10,
// //                           color: AppColors.textHint,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // =============================================================================
// // // Edit Profile screen
// // // =============================================================================
// // class _EditProfileScreen extends StatefulWidget {
// //   final String name;
// //   final String phone;
// //   final String email;
// //   final String vehicleNumber;
// //   final String vehicleType;
// //   final String drivingLicense;

// //   const _EditProfileScreen({
// //     required this.name,
// //     required this.phone,
// //     required this.email,
// //     required this.vehicleNumber,
// //     required this.vehicleType,
// //     required this.drivingLicense,
// //   });

// //   @override
// //   State<_EditProfileScreen> createState() => _EditProfileScreenState();
// // }

// // class _EditProfileScreenState extends State<_EditProfileScreen> {
// //   late final TextEditingController _nameCtrl;
// //   late final TextEditingController _phoneCtrl;
// //   late final TextEditingController _emailCtrl;
// //   late final TextEditingController _vehicleNumberCtrl;
// //   late final TextEditingController _vehicleTypeCtrl;
// //   late final TextEditingController _licenseCtrl;
// //   final _formKey = GlobalKey<FormState>();

// //   @override
// //   void initState() {
// //     super.initState();
// //     _nameCtrl = TextEditingController(text: widget.name);
// //     _phoneCtrl = TextEditingController(text: widget.phone);
// //     _emailCtrl = TextEditingController(text: widget.email);
// //     _vehicleNumberCtrl = TextEditingController(text: widget.vehicleNumber);
// //     _vehicleTypeCtrl = TextEditingController(text: widget.vehicleType);
// //     _licenseCtrl = TextEditingController(text: widget.drivingLicense);
// //   }

// //   @override
// //   void dispose() {
// //     _nameCtrl.dispose();
// //     _phoneCtrl.dispose();
// //     _emailCtrl.dispose();
// //     _vehicleNumberCtrl.dispose();
// //     _vehicleTypeCtrl.dispose();
// //     _licenseCtrl.dispose();
// //     super.dispose();
// //   }

// //   InputDecoration _decoration(String label) {
// //     return InputDecoration(
// //       labelText: label,
// //       filled: true,
// //       fillColor: AppColors.inputFill,
// //       border: OutlineInputBorder(
// //         borderRadius: BorderRadius.circular(14),
// //         borderSide: BorderSide.none,
// //       ),
// //       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //     );
// //   }

// //   void _save() {
// //     if (!_formKey.currentState!.validate()) return;
// //     Navigator.pop(context, {
// //       'name': _nameCtrl.text.trim(),
// //       'phone': _phoneCtrl.text.trim(),
// //       'email': _emailCtrl.text.trim(),
// //       'vehicleNumber': _vehicleNumberCtrl.text.trim(),
// //       'vehicleType': _vehicleTypeCtrl.text.trim(),
// //       'drivingLicense': _licenseCtrl.text.trim(),
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF4F4F4),
// //       appBar: AppBar(
// //         backgroundColor: const Color(0xFFF4F4F4),
// //         elevation: 0,
// //         title: const Text(
// //           'Edit Profile',
// //           style: TextStyle(
// //             color: AppColors.textPrimary,
// //             fontWeight: FontWeight.bold,
// //             fontSize: 18,
// //           ),
// //         ),
// //         iconTheme: const IconThemeData(color: AppColors.textPrimary),
// //       ),
// //       body: SafeArea(
// //         top: false,
// //         child: Form(
// //           key: _formKey,
// //           child: ListView(
// //             padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
// //             children: [
// //               TextFormField(
// //                 controller: _nameCtrl,
// //                 decoration: _decoration('Full Name'),
// //                 validator: (v) =>
// //                     (v == null || v.trim().isEmpty) ? 'Required' : null,
// //               ),
// //               const SizedBox(height: 14),
// //               TextFormField(
// //                 controller: _phoneCtrl,
// //                 keyboardType: TextInputType.phone,
// //                 decoration: _decoration('Phone Number'),
// //                 validator: (v) =>
// //                     (v == null || v.trim().isEmpty) ? 'Required' : null,
// //               ),
// //               const SizedBox(height: 14),
// //               TextFormField(
// //                 controller: _emailCtrl,
// //                 keyboardType: TextInputType.emailAddress,
// //                 decoration: _decoration('Email'),
// //                 validator: (v) =>
// //                     (v == null || v.trim().isEmpty) ? 'Required' : null,
// //               ),
// //               const SizedBox(height: 14),
// //               TextFormField(
// //                 controller: _vehicleNumberCtrl,
// //                 decoration: _decoration('Vehicle Number'),
// //                 validator: (v) =>
// //                     (v == null || v.trim().isEmpty) ? 'Required' : null,
// //               ),
// //               const SizedBox(height: 14),
// //               TextFormField(
// //                 controller: _vehicleTypeCtrl,
// //                 decoration: _decoration('Vehicle Type'),
// //               ),
// //               const SizedBox(height: 14),
// //               TextFormField(
// //                 controller: _licenseCtrl,
// //                 decoration: _decoration('Driving License Number'),
// //               ),
// //               const SizedBox(height: 24),
// //               SizedBox(
// //                 width: double.infinity,
// //                 height: 52,
// //                 child: ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: AppColors.primaryBlack,
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(26),
// //                     ),
// //                     elevation: 0,
// //                   ),
// //                   onPressed: _save,
// //                   child: const Text(
// //                     'Save Changes',
// //                     style: TextStyle(
// //                       color: AppColors.pureWhite,
// //                       fontWeight: FontWeight.w700,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // =============================================================================
// // // Performance dashboard screen ("View Dashboard")
// // // This is the ONLY place Total Trips / Completed / Rating / Success Rate
// // // are shown now — the duplicate grid on the main Profile screen was removed.
// // // =============================================================================
// // class _DashboardScreen extends StatelessWidget {
// //   final int totalTrips;
// //   final int completedTrips;
// //   final double rating;
// //   final double successRate;

// //   const _DashboardScreen({
// //     required this.totalTrips,
// //     required this.completedTrips,
// //     required this.rating,
// //     required this.successRate,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     final tiles = [
// //       _StatCardData(
// //         icon: Icons.map_outlined,
// //         iconColor: AppColors.textPrimary,
// //         value: '$totalTrips',
// //         label: 'Total Trips',
// //       ),
// //       _StatCardData(
// //         icon: Icons.check_circle_outline,
// //         iconColor: AppColors.success,
// //         value: '$completedTrips',
// //         label: 'Completed Trips',
// //       ),
// //       _StatCardData(
// //         icon: Icons.star_rounded,
// //         iconColor: const Color(0xFFF5A623),
// //         value: '$rating',
// //         label: 'Average Rating',
// //       ),
// //       _StatCardData(
// //         icon: Icons.bolt_outlined,
// //         iconColor: const Color(0xFF6C5CE7),
// //         value: '${successRate.toStringAsFixed(0)}%',
// //         label: 'Success Rate',
// //       ),
// //     ];

// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF4F4F4),
// //       appBar: AppBar(
// //         backgroundColor: const Color(0xFFF4F4F4),
// //         elevation: 0,
// //         title: const Text(
// //           'Performance Dashboard',
// //           style: TextStyle(
// //             color: AppColors.textPrimary,
// //             fontWeight: FontWeight.bold,
// //             fontSize: 17,
// //           ),
// //         ),
// //         iconTheme: const IconThemeData(color: AppColors.textPrimary),
// //       ),
// //       body: SafeArea(
// //         top: false,
// //         child: GridView.builder(
// //           padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
// //           itemCount: tiles.length,
// //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //             crossAxisCount: 2,
// //             mainAxisSpacing: 12,
// //             crossAxisSpacing: 12,
// //             mainAxisExtent: 120,
// //           ),
// //           itemBuilder: (context, i) {
// //             final tile = tiles[i];
// //             return Container(
// //               padding: const EdgeInsets.all(16),
// //               decoration: BoxDecoration(
// //                 color: AppColors.pureWhite,
// //                 borderRadius: BorderRadius.circular(18),
// //                 border: Border.all(color: AppColors.border),
// //               ),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Container(
// //                     padding: const EdgeInsets.all(8),
// //                     decoration: BoxDecoration(
// //                       color: tile.iconColor.withOpacity(0.12),
// //                       borderRadius: BorderRadius.circular(10),
// //                     ),
// //                     child: Icon(tile.icon, size: 18, color: tile.iconColor),
// //                   ),
// //                   Text(
// //                     tile.value,
// //                     style: const TextStyle(
// //                       fontSize: 20,
// //                       fontWeight: FontWeight.bold,
// //                       color: AppColors.textPrimary,
// //                     ),
// //                   ),
// //                   Text(
// //                     tile.label,
// //                     style: const TextStyle(
// //                       fontSize: 12,
// //                       color: AppColors.textHint,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // =============================================================================
// // // Bank account screen
// // // =============================================================================
// // class _BankAccountScreen extends StatefulWidget {
// //   final String holder;
// //   final String accountNumber;
// //   final String ifsc;

// //   const _BankAccountScreen({
// //     required this.holder,
// //     required this.accountNumber,
// //     required this.ifsc,
// //   });

// //   @override
// //   State<_BankAccountScreen> createState() => _BankAccountScreenState();
// // }

// // class _BankAccountScreenState extends State<_BankAccountScreen> {
// //   late String _holder = widget.holder;
// //   late String _accountNumber = widget.accountNumber;
// //   late String _ifsc = widget.ifsc;

// //   Future<void> _editDetails(BuildContext context) async {
// //     final holderCtrl = TextEditingController(text: _holder);
// //     final accountCtrl = TextEditingController(text: _accountNumber);
// //     final ifscCtrl = TextEditingController(text: _ifsc);

// //     final result = await showDialog<bool>(
// //       context: context,
// //       builder: (dialogContext) => AlertDialog(
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// //         title: const Text('Edit Bank Details'),
// //         content: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             TextField(
// //               controller: holderCtrl,
// //               decoration: const InputDecoration(labelText: 'Account Holder'),
// //             ),
// //             TextField(
// //               controller: accountCtrl,
// //               decoration: const InputDecoration(labelText: 'Account Number'),
// //             ),
// //             TextField(
// //               controller: ifscCtrl,
// //               decoration: const InputDecoration(labelText: 'IFSC Code'),
// //             ),
// //           ],
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.pop(dialogContext, false),
// //             child: const Text('Cancel'),
// //           ),
// //           TextButton(
// //             onPressed: () => Navigator.pop(dialogContext, true),
// //             child: const Text('Save'),
// //           ),
// //         ],
// //       ),
// //     );

// //     if (result == true) {
// //       setState(() {
// //         _holder = holderCtrl.text.trim();
// //         _accountNumber = accountCtrl.text.trim();
// //         _ifsc = ifscCtrl.text.trim();
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF4F4F4),
// //       appBar: AppBar(
// //         backgroundColor: const Color(0xFFF4F4F4),
// //         elevation: 0,
// //         title: const Text(
// //           'Bank Account',
// //           style: TextStyle(
// //             color: AppColors.textPrimary,
// //             fontWeight: FontWeight.bold,
// //             fontSize: 18,
// //           ),
// //         ),
// //         iconTheme: const IconThemeData(color: AppColors.textPrimary),
// //       ),
// //       body: SafeArea(
// //         top: false,
// //         child: Padding(
// //           padding: const EdgeInsets.all(16),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.stretch,
// //             children: [
// //               Container(
// //                 padding: const EdgeInsets.all(18),
// //                 decoration: BoxDecoration(
// //                   color: AppColors.pureWhite,
// //                   borderRadius: BorderRadius.circular(18),
// //                   border: Border.all(color: AppColors.border),
// //                 ),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     _bankLine('Account Holder', _holder),
// //                     const Divider(height: 24, color: AppColors.divider),
// //                     _bankLine('Account Number', _accountNumber),
// //                     const Divider(height: 24, color: AppColors.divider),
// //                     _bankLine('IFSC Code', _ifsc),
// //                   ],
// //                 ),
// //               ),
// //               const SizedBox(height: 16),
// //               SizedBox(
// //                 height: 50,
// //                 child: OutlinedButton(
// //                   style: OutlinedButton.styleFrom(
// //                     side: const BorderSide(color: AppColors.border),
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(24),
// //                     ),
// //                   ),
// //                   onPressed: () => _editDetails(context),
// //                   child: const Text(
// //                     'Edit Bank Details',
// //                     style: TextStyle(fontWeight: FontWeight.w600),
// //                   ),
// //                 ),
// //               ),
// //               const Spacer(),
// //               SizedBox(
// //                 width: double.infinity,
// //                 height: 52,
// //                 child: ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: AppColors.primaryBlack,
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(26),
// //                     ),
// //                     elevation: 0,
// //                   ),
// //                   onPressed: () => Navigator.pop(context, {
// //                     'holder': _holder,
// //                     'accountNumber': _accountNumber,
// //                     'ifsc': _ifsc,
// //                   }),
// //                   child: const Text(
// //                     'Done',
// //                     style: TextStyle(
// //                       color: AppColors.pureWhite,
// //                       fontWeight: FontWeight.w700,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _bankLine(String label, String value) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           label,
// //           style: const TextStyle(fontSize: 11.5, color: AppColors.textHint),
// //         ),
// //         const SizedBox(height: 4),
// //         Text(
// //           value,
// //           style: const TextStyle(
// //             fontSize: 15,
// //             fontWeight: FontWeight.w700,
// //             color: AppColors.textPrimary,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }

// // // =============================================================================
// // // Payout settings screen
// // // =============================================================================
// // class _PayoutSettingsScreen extends StatefulWidget {
// //   final bool autoPayout;
// //   final String frequency;

// //   const _PayoutSettingsScreen({
// //     required this.autoPayout,
// //     required this.frequency,
// //   });

// //   @override
// //   State<_PayoutSettingsScreen> createState() => _PayoutSettingsScreenState();
// // }

// // class _PayoutSettingsScreenState extends State<_PayoutSettingsScreen> {
// //   late bool _autoPayout = widget.autoPayout;
// //   late String _frequency = widget.frequency;

// //   static const _frequencies = ['Daily', 'Weekly', 'Monthly'];

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF4F4F4),
// //       appBar: AppBar(
// //         backgroundColor: const Color(0xFFF4F4F4),
// //         elevation: 0,
// //         title: const Text(
// //           'Payout Settings',
// //           style: TextStyle(
// //             color: AppColors.textPrimary,
// //             fontWeight: FontWeight.bold,
// //             fontSize: 18,
// //           ),
// //         ),
// //         iconTheme: const IconThemeData(color: AppColors.textPrimary),
// //       ),
// //       body: SafeArea(
// //         top: false,
// //         child: Padding(
// //           padding: const EdgeInsets.all(16),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.stretch,
// //             children: [
// //               Container(
// //                 padding: const EdgeInsets.symmetric(horizontal: 16),
// //                 decoration: BoxDecoration(
// //                   color: AppColors.pureWhite,
// //                   borderRadius: BorderRadius.circular(16),
// //                   border: Border.all(color: AppColors.border),
// //                 ),
// //                 child: SwitchListTile(
// //                   activeColor: AppColors.primaryBlack,
// //                   contentPadding: EdgeInsets.zero,
// //                   title: const Text(
// //                     'Enable Auto Payout',
// //                     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
// //                   ),
// //                   subtitle: const Text(
// //                     'Automatically send earnings to your bank account',
// //                     style: TextStyle(fontSize: 12),
// //                   ),
// //                   value: _autoPayout,
// //                   onChanged: (v) => setState(() => _autoPayout = v),
// //                 ),
// //               ),
// //               const SizedBox(height: 16),
// //               if (_autoPayout) ...[
// //                 const Text(
// //                   'Payout Frequency',
// //                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
// //                 ),
// //                 const SizedBox(height: 10),
// //                 ..._frequencies.map(
// //                   (freq) => Container(
// //                     margin: const EdgeInsets.only(bottom: 10),
// //                     decoration: BoxDecoration(
// //                       color: AppColors.pureWhite,
// //                       borderRadius: BorderRadius.circular(14),
// //                       border: Border.all(color: AppColors.border),
// //                     ),
// //                     child: RadioListTile<String>(
// //                       activeColor: AppColors.primaryBlack,
// //                       value: freq,
// //                       groupValue: _frequency,
// //                       title: Text(freq),
// //                       onChanged: (v) => setState(() => _frequency = v!),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //               const Spacer(),
// //               SizedBox(
// //                 width: double.infinity,
// //                 height: 52,
// //                 child: ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: AppColors.primaryBlack,
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(26),
// //                     ),
// //                     elevation: 0,
// //                   ),
// //                   onPressed: () => Navigator.pop(context, {
// //                     'autoPayout': _autoPayout,
// //                     'frequency': _frequency,
// //                   }),
// //                   child: const Text(
// //                     'Save Settings',
// //                     style: TextStyle(
// //                       color: AppColors.pureWhite,
// //                       fontWeight: FontWeight.w700,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // =============================================================================
// // // Notification settings screen
// // // =============================================================================
// // class _NotificationSettingsScreen extends StatefulWidget {
// //   final bool trips;
// //   final bool promos;
// //   final bool payouts;

// //   const _NotificationSettingsScreen({
// //     required this.trips,
// //     required this.promos,
// //     required this.payouts,
// //   });

// //   @override
// //   State<_NotificationSettingsScreen> createState() =>
// //       _NotificationSettingsScreenState();
// // }

// // class _NotificationSettingsScreenState
// //     extends State<_NotificationSettingsScreen> {
// //   late bool _trips = widget.trips;
// //   late bool _promos = widget.promos;
// //   late bool _payouts = widget.payouts;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF4F4F4),
// //       appBar: AppBar(
// //         backgroundColor: const Color(0xFFF4F4F4),
// //         elevation: 0,
// //         title: const Text(
// //           'Notification Settings',
// //           style: TextStyle(
// //             color: AppColors.textPrimary,
// //             fontWeight: FontWeight.bold,
// //             fontSize: 17,
// //           ),
// //         ),
// //         iconTheme: const IconThemeData(color: AppColors.textPrimary),
// //       ),
// //       body: SafeArea(
// //         top: false,
// //         child: Padding(
// //           padding: const EdgeInsets.all(16),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.stretch,
// //             children: [
// //               Container(
// //                 padding: const EdgeInsets.symmetric(horizontal: 16),
// //                 decoration: BoxDecoration(
// //                   color: AppColors.pureWhite,
// //                   borderRadius: BorderRadius.circular(16),
// //                   border: Border.all(color: AppColors.border),
// //                 ),
// //                 child: Column(
// //                   children: [
// //                     SwitchListTile(
// //                       activeColor: AppColors.primaryBlack,
// //                       contentPadding: EdgeInsets.zero,
// //                       title: const Text(
// //                         'Trip Updates',
// //                         style: TextStyle(
// //                           fontWeight: FontWeight.w600,
// //                           fontSize: 14,
// //                         ),
// //                       ),
// //                       subtitle: const Text(
// //                         'Pickup, delivery, and return alerts',
// //                         style: TextStyle(fontSize: 12),
// //                       ),
// //                       value: _trips,
// //                       onChanged: (v) => setState(() => _trips = v),
// //                     ),
// //                     const Divider(height: 1, color: AppColors.divider),
// //                     SwitchListTile(
// //                       activeColor: AppColors.primaryBlack,
// //                       contentPadding: EdgeInsets.zero,
// //                       title: const Text(
// //                         'Promotions & Offers',
// //                         style: TextStyle(
// //                           fontWeight: FontWeight.w600,
// //                           fontSize: 14,
// //                         ),
// //                       ),
// //                       subtitle: const Text(
// //                         'Bonus campaigns and incentives',
// //                         style: TextStyle(fontSize: 12),
// //                       ),
// //                       value: _promos,
// //                       onChanged: (v) => setState(() => _promos = v),
// //                     ),
// //                     const Divider(height: 1, color: AppColors.divider),
// //                     SwitchListTile(
// //                       activeColor: AppColors.primaryBlack,
// //                       contentPadding: EdgeInsets.zero,
// //                       title: const Text(
// //                         'Payout Alerts',
// //                         style: TextStyle(
// //                           fontWeight: FontWeight.w600,
// //                           fontSize: 14,
// //                         ),
// //                       ),
// //                       subtitle: const Text(
// //                         'Wallet credits and withdrawals',
// //                         style: TextStyle(fontSize: 12),
// //                       ),
// //                       value: _payouts,
// //                       onChanged: (v) => setState(() => _payouts = v),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               const Spacer(),
// //               SizedBox(
// //                 width: double.infinity,
// //                 height: 52,
// //                 child: ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: AppColors.primaryBlack,
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(26),
// //                     ),
// //                     elevation: 0,
// //                   ),
// //                   onPressed: () => Navigator.pop(context, {
// //                     'trips': _trips,
// //                     'promos': _promos,
// //                     'payouts': _payouts,
// //                   }),
// //                   child: const Text(
// //                     'Save Preferences',
// //                     style: TextStyle(
// //                       color: AppColors.pureWhite,
// //                       fontWeight: FontWeight.w700,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // =============================================================================
// // // Static text screen (Terms & Conditions / Privacy Policy)
// // // =============================================================================
// // class _StaticTextScreen extends StatelessWidget {
// //   final String title;
// //   final String body;

// //   const _StaticTextScreen({required this.title, required this.body});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF4F4F4),
// //       appBar: AppBar(
// //         backgroundColor: const Color(0xFFF4F4F4),
// //         elevation: 0,
// //         title: Text(
// //           title,
// //           style: const TextStyle(
// //             color: AppColors.textPrimary,
// //             fontWeight: FontWeight.bold,
// //             fontSize: 17,
// //           ),
// //         ),
// //         iconTheme: const IconThemeData(color: AppColors.textPrimary),
// //       ),
// //       body: SafeArea(
// //         top: false,
// //         child: SingleChildScrollView(
// //           padding: const EdgeInsets.all(20),
// //           child: Text(
// //             body,
// //             style: const TextStyle(
// //               fontSize: 13.5,
// //               color: AppColors.textSecondary,
// //               height: 1.55,
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // const String _termsText =
// //     'These Terms & Conditions govern your use of the Rento India Rider '
// //     'app. By registering as a rider, you agree to complete pickup, '
// //     'delivery, and return trips in accordance with the schedules and '
// //     'routes assigned to you, to maintain valid documents (driving '
// //     'license, vehicle RC, and insurance) at all times, and to represent '
// //     'trip and earnings information accurately.\n\n'
// //     'Rento India reserves the right to suspend or deactivate a rider '
// //     'account for repeated cancellations, safety violations, or '
// //     'fraudulent activity. Earnings, bonuses, and incentive structures '
// //     'are subject to change with prior notice.\n\n'
// //     'This is placeholder legal text — replace with the finalized rider '
// //     'agreement before release.';

// // const String _privacyText =
// //     'Rento India collects the information you provide during KYC '
// //     '(identity documents, vehicle details, bank information) and the '
// //     'location data required to route pickups, deliveries, and returns.\n\n'
// //     'This data is used to verify your identity, process payouts, and '
// //     'improve trip routing. We do not sell rider data to third parties. '
// //     'Location access can be managed from your device settings, though '
// //     'disabling it will affect trip assignment.\n\n'
// //     'This is placeholder legal text — replace with the finalized privacy '
// //     'policy before release.';

// // // =============================================================================
// // // Shared reusable pieces (mirrors the Earnings tab's private widgets)
// // // =============================================================================

// // /// Wraps a tappable widget with a hover-lift effect (mouse, on web/desktop)
// // /// and a press-scale effect (touch, on mobile).
// // class _HoverPressable extends StatefulWidget {
// //   final Widget child;
// //   final VoidCallback? onTap;
// //   final bool liftOnHover;

// //   const _HoverPressable({
// //     required this.child,
// //     this.onTap,
// //     this.liftOnHover = false,
// //   });

// //   @override
// //   State<_HoverPressable> createState() => _HoverPressableState();
// // }

// // class _HoverPressableState extends State<_HoverPressable> {
// //   bool _hovering = false;
// //   bool _pressed = false;

// //   @override
// //   Widget build(BuildContext context) {
// //     final scale = _pressed ? 0.96 : (_hovering ? 1.02 : 1.0);
// //     return MouseRegion(
// //       cursor: SystemMouseCursors.click,
// //       onEnter: (_) => setState(() => _hovering = true),
// //       onExit: (_) => setState(() => _hovering = false),
// //       child: GestureDetector(
// //         onTap: widget.onTap,
// //         onTapDown: (_) => setState(() => _pressed = true),
// //         onTapUp: (_) => setState(() => _pressed = false),
// //         onTapCancel: () => setState(() => _pressed = false),
// //         child: AnimatedScale(
// //           scale: scale,
// //           duration: const Duration(milliseconds: 150),
// //           curve: Curves.easeOut,
// //           child: AnimatedContainer(
// //             duration: const Duration(milliseconds: 150),
// //             decoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(18),
// //               boxShadow: (_hovering && widget.liftOnHover)
// //                   ? [
// //                       BoxShadow(
// //                         color: Colors.black.withOpacity(0.08),
// //                         blurRadius: 16,
// //                         offset: const Offset(0, 8),
// //                       ),
// //                     ]
// //                   : const [],
// //             ),
// //             child: widget.child,
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // /// Animates a numeric value counting up from 0 to [target].
// // class _AnimatedCounter extends StatelessWidget {
// //   final Animation<double> animation;
// //   final double target;
// //   final String prefix;
// //   final int decimals;
// //   final TextStyle style;

// //   const _AnimatedCounter({
// //     required this.animation,
// //     required this.target,
// //     required this.style,
// //     this.prefix = '',
// //     this.decimals = 0,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return AnimatedBuilder(
// //       animation: animation,
// //       builder: (context, _) {
// //         final value = (target * animation.value).clamp(0, target);
// //         final display = decimals == 0
// //             ? value.round().toString()
// //             : value.toStringAsFixed(decimals);
// //         return Text('$prefix${_thousands(display)}', style: style);
// //       },
// //     );
// //   }

// //   String _thousands(String number) {
// //     final parts = number.split('.');
// //     final isNegative = parts[0].startsWith('-');
// //     final digits = isNegative ? parts[0].substring(1) : parts[0];
// //     final buffer = StringBuffer();
// //     for (var i = 0; i < digits.length; i++) {
// //       final posFromEnd = digits.length - i;
// //       buffer.write(digits[i]);
// //       if (posFromEnd > 1 && posFromEnd % 3 == 1) {
// //         buffer.write(',');
// //       }
// //     }
// //     final whole = '${isNegative ? '-' : ''}$buffer';
// //     return parts.length > 1 ? '$whole.${parts[1]}' : whole;
// //   }
// // }

// // // =============================================================================
// // // Mock data models
// // // =============================================================================

// // class _DocumentItem {
// //   final IconData icon;
// //   final String label;
// //   final String status;
// //   final bool valid;
// //   final String detail;
// //   const _DocumentItem({
// //     required this.icon,
// //     required this.label,
// //     required this.status,
// //     required this.valid,
// //     required this.detail,
// //   });
// // }

// // class _WalletTxn {
// //   final String title;
// //   final String subtitle;
// //   final int amount;
// //   final String date;
// //   final bool credit;
// //   const _WalletTxn({
// //     required this.title,
// //     required this.subtitle,
// //     required this.amount,
// //     required this.date,
// //     required this.credit,
// //   });
// // }

// // class _StatCardData {
// //   final IconData icon;
// //   final Color iconColor;
// //   final String value;
// //   final String label;
// //   const _StatCardData({
// //     required this.icon,
// //     required this.iconColor,
// //     required this.value,
// //     required this.label,
// //   });
// // }

// // class _InfoRowData {
// //   final IconData icon;
// //   final Color iconColor;
// //   final String label;
// //   final String value;
// //   const _InfoRowData(this.icon, this.iconColor, this.label, this.value);
// // }

// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// //import '../../../../../core/constants/app_colors.dart';
// import 'package:rento/delivery/core/constants/app_colors.dart';
// import '../../../providers/rider_tab_provider.dart';
// import '../../../../../core/routes/route_names.dart';

// /// Profile tab — Rider module.
// ///
// /// Pure UI screen (no backend yet): every field below is local mock data
// /// mirroring the reference design. Wire up a real RiderProfileRepository /
// /// Riverpod-or-GetX provider later — the section builders are already
// /// split out so swapping mock fields for provider data is a small, local
// /// change. Follows the same black-header + curved-white-sheet pattern as
// /// the Earnings tab.
// ///
// /// Reached as a bottom-nav tab in RiderShell — there's no Navigator route
// /// to pop, so the back button falls back to riderTabIndexProvider (same
// /// fix as EarningsScreen / AvailableRequestsScreen).
// ///
// /// NOTE: the "Performance Summary" grid was removed from this screen — it
// /// duplicates what "View Dashboard" already shows (see _DashboardScreen
// /// below), so there's no need to render it twice.
// class RiderProfileScreen extends ConsumerStatefulWidget {
//   const RiderProfileScreen({super.key});

//   @override
//   ConsumerState<RiderProfileScreen> createState() => _RiderProfileScreenState();
// }

// class _RiderProfileScreenState extends ConsumerState<RiderProfileScreen>
//     with TickerProviderStateMixin {
//   late final AnimationController _entrance;
//   final ImagePicker _picker = ImagePicker();

//   // ---- Mock rider profile data ---------------------------------------
//   String _name = 'Karthik R';
//   final String _riderId = 'RENTO-RDR-00412';
//   double _rating = 4.8;
//   int _totalTrips = 128;
//   int _completedTrips = 125;
//   double _successRate = 98;

//   String _phone = '+91 98765 43210';
//   String _email = 'karthik.rider@gmail.com';
//   String _vehicleNumber = 'TN 09 AB 1234';
//   String _vehicleType = '2 Wheeler';
//   String _drivingLicense = 'TN09 20210012345';
//   final String _licenseValidTill = '12 Jan 2027';
//   final String _joiningDate = '12 March 2023';

//   String _bankHolder = 'Karthik R';
//   String _bankAccountNumber = '••••••••4242';
//   String _ifsc = 'HDFC0001234';

//   double _walletBalance = 2750;
//   bool _autoPayout = true;
//   String _payoutFrequency = 'Weekly';

//   bool _notifTrips = true;
//   bool _notifPromos = false;
//   bool _notifPayouts = true;
//   String _language = 'English';

//   // Selected profile photo, picked via image_picker. Stored as raw bytes
//   // (not a File) so this works on Flutter Web too — Image.file throws on
//   // web since there's no real filesystem there. Null == no photo yet,
//   // falls back to the initial-letter avatar.
//   Uint8List? _profileImageBytes;

//   static const List<_DocumentItem> _documents = [
//     _DocumentItem(
//       icon: Icons.badge_outlined,
//       label: 'Aadhaar Card',
//       status: 'Verified',
//       valid: true,
//       detail: 'Uploaded 12 March 2023 · Verified 14 March 2023',
//     ),
//     _DocumentItem(
//       icon: Icons.credit_card,
//       label: 'Driving License',
//       status: 'Verified',
//       valid: true,
//       detail: 'Valid till 12 Jan 2027',
//     ),
//     _DocumentItem(
//       icon: Icons.directions_car_outlined,
//       label: 'Vehicle RC',
//       status: 'Verified',
//       valid: true,
//       detail: 'Registered TN 09 AB 1234',
//     ),
//     _DocumentItem(
//       icon: Icons.shield_outlined,
//       label: 'Insurance',
//       status: 'Valid till 10 Dec 2025',
//       valid: true,
//       detail: 'Policy renews automatically 30 days before expiry',
//     ),
//   ];

//   static const List<_WalletTxn> _walletHistory = [
//     _WalletTxn(
//       title: 'Withdrawal to Bank',
//       subtitle: 'HDFC •••• 4242',
//       amount: -2000,
//       date: '4 July, 2026',
//       credit: false,
//     ),
//     _WalletTxn(
//       title: 'Trip Earnings Credited',
//       subtitle: 'Week of 30 June – 6 July',
//       amount: 3120,
//       date: '3 July, 2026',
//       credit: true,
//     ),
//     _WalletTxn(
//       title: 'Withdrawal to Bank',
//       subtitle: 'HDFC •••• 4242',
//       amount: 2500,
//       date: '27 June, 2026',
//       credit: false,
//     ),
//     _WalletTxn(
//       title: 'Trip Earnings Credited',
//       subtitle: 'Week of 23 – 29 June',
//       amount: 2890,
//       date: '26 June, 2026',
//       credit: true,
//     ),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _entrance = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 900),
//     )..forward();
//   }

//   @override
//   void dispose() {
//     _entrance.dispose();
//     super.dispose();
//   }

//   void _toast(String message) {
//     ScaffoldMessenger.of(context).hideCurrentSnackBar();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         behavior: SnackBarBehavior.floating,
//         backgroundColor: AppColors.primaryBlack,
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }

//   // ---------------------------------------------------------------------
//   // Profile photo — opens the device file/gallery picker via image_picker.
//   // ---------------------------------------------------------------------
//   Future<void> _pickProfilePhoto() async {
//     try {
//       final XFile? picked = await _picker.pickImage(
//         source: ImageSource.gallery,
//         imageQuality: 85,
//         maxWidth: 800,
//       );
//       if (picked == null) return; // user cancelled the picker
//       final bytes = await picked.readAsBytes();
//       if (mounted) {
//         setState(() => _profileImageBytes = bytes);
//         _toast('Profile photo updated');
//       }
//     } catch (e) {
//       if (mounted) _toast('Could not open photo picker');
//     }
//   }

//   // ---------------------------------------------------------------------
//   // Entrance animation helper — same staggered fade+slide as Earnings tab.
//   // ---------------------------------------------------------------------
//   // Section count reduced from 14 -> 12 after removing the Performance
//   // Summary title + grid (that data now only lives in "View Dashboard").
//   static const int _sectionCount = 12;

//   Widget _fadeIn(int index, {required Widget child}) {
//     final start = (index / _sectionCount) * 0.6;
//     final end = (start + 0.4).clamp(0.0, 1.0);
//     final curved = CurvedAnimation(
//       parent: _entrance,
//       curve: Interval(start, end, curve: Curves.easeOutCubic),
//     );
//     return AnimatedBuilder(
//       animation: curved,
//       child: child,
//       builder: (context, child) {
//         return Opacity(
//           opacity: curved.value.clamp(0.0, 1.0),
//           child: Transform.translate(
//             offset: Offset(0, (1 - curved.value) * 18),
//             child: child,
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primaryBlack,
//       body: Column(
//         children: [
//           SafeArea(bottom: false, child: _buildCurvedHeaderBar(context)),
//           Expanded(
//             child: ClipRRect(
//               borderRadius: const BorderRadius.vertical(
//                 top: Radius.circular(28),
//               ),
//               child: Container(
//                 color: const Color(0xFFF4F4F4),
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.fromLTRB(16, 20, 16, 28),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       _fadeIn(0, child: _buildProfileHeaderCard(context)),
//                       const SizedBox(height: 22),
//                       _fadeIn(1, child: _sectionTitle('Account Information')),
//                       const SizedBox(height: 10),
//                       _fadeIn(2, child: _buildAccountInfoCard()),
//                       const SizedBox(height: 22),
//                       _fadeIn(
//                         3,
//                         child: _sectionTitle(
//                           'Documents',
//                           action: 'View All',
//                           onActionTap: () => _openDocuments(context),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       _fadeIn(4, child: _buildDocumentsCard(context)),
//                       const SizedBox(height: 22),
//                       _fadeIn(5, child: _sectionTitle('Wallet & Payout')),
//                       const SizedBox(height: 10),
//                       _fadeIn(6, child: _buildWalletCard(context)),
//                       const SizedBox(height: 12),
//                       _fadeIn(7, child: _buildWalletLinksCard(context)),
//                       const SizedBox(height: 22),
//                       _fadeIn(8, child: _sectionTitle('Settings')),
//                       const SizedBox(height: 10),
//                       _fadeIn(9, child: _buildSettingsCard(context)),
//                       const SizedBox(height: 22),
//                       _fadeIn(10, child: _buildLogoutButton(context)),
//                       const SizedBox(height: 14),
//                       _fadeIn(11, child: _buildVersionFooter()),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ---------------------------------------------------------------------
//   // Curved black header bar (back button, title, edit action)
//   // ---------------------------------------------------------------------
//   Widget _buildCurvedHeaderBar(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(4, 4, 12, 16),
//       child: Row(
//         children: [
//           IconButton(
//             icon: const Icon(Icons.arrow_back, color: AppColors.pureWhite),
//             tooltip: 'Back',
//             // FIX — Profile is always a bottom-nav TAB inside RiderShell,
//             // never a separately pushed route. canPop() was true here
//             // because of whatever sits underneath RiderShell in the
//             // navigator stack (Mobile Entry, etc.), so pop() was popping
//             // the entire shell instead of just switching tabs — that's
//             // what caused the blank/broken-route screen. Always just
//             // switch RiderShell back to the Home tab.
//             onPressed: () {
//               ref.read(riderTabIndexProvider.notifier).state = 0;
//             },
//           ),
//           const Expanded(
//             child: Text(
//               'Profile',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: AppColors.pureWhite,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 19,
//               ),
//             ),
//           ),
//           _HoverPressable(
//             onTap: () => _openEditProfile(context),
//             child: Container(
//               padding: const EdgeInsets.all(9),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(color: AppColors.pureWhite.withOpacity(0.4)),
//               ),
//               child: const Icon(
//                 Icons.edit_outlined,
//                 color: AppColors.pureWhite,
//                 size: 17,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ---------------------------------------------------------------------
//   // Profile header card: avatar, name, id, rating/trips, verified badge,
//   // View Dashboard / Edit Profile actions.
//   // ---------------------------------------------------------------------
//   Widget _buildProfileHeaderCard(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 20),
//       decoration: BoxDecoration(
//         color: AppColors.pureWhite,
//         borderRadius: BorderRadius.circular(22),
//         border: Border.all(color: AppColors.border),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 16,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Stack(
//             clipBehavior: Clip.none,
//             children: [
//               TweenAnimationBuilder<double>(
//                 tween: Tween(begin: 0.85, end: 1),
//                 duration: const Duration(milliseconds: 600),
//                 curve: Curves.easeOutBack,
//                 builder: (context, scale, child) =>
//                     Transform.scale(scale: scale, child: child),
//                 child: Container(
//                   width: 84,
//                   height: 84,
//                   decoration: const BoxDecoration(
//                     color: AppColors.primaryBlack,
//                     shape: BoxShape.circle,
//                   ),
//                   alignment: Alignment.center,
//                   clipBehavior: Clip.antiAlias,
//                   child: _profileImageBytes != null
//                       ? ClipOval(
//                           child: Image.memory(
//                             _profileImageBytes!,
//                             width: 84,
//                             height: 84,
//                             fit: BoxFit.cover,
//                           ),
//                         )
//                       : Text(
//                           _name.trim().isNotEmpty
//                               ? _name.trim()[0].toUpperCase()
//                               : '?',
//                           style: const TextStyle(
//                             color: AppColors.pureWhite,
//                             fontSize: 32,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                 ),
//               ),
//               Positioned(
//                 right: -2,
//                 bottom: -2,
//                 child: _HoverPressable(
//                   // Tapping the camera badge now opens the device's file /
//                   // gallery picker (image_picker) instead of just a toast.
//                   onTap: () => _pickProfilePhoto(),
//                   child: Container(
//                     padding: const EdgeInsets.all(6),
//                     decoration: BoxDecoration(
//                       color: AppColors.pureWhite,
//                       shape: BoxShape.circle,
//                       border: Border.all(color: AppColors.border),
//                     ),
//                     child: const Icon(
//                       Icons.camera_alt_outlined,
//                       size: 14,
//                       color: AppColors.textPrimary,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 14),
//           Text(
//             _name,
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: AppColors.textPrimary,
//             ),
//           ),
//           const SizedBox(height: 3),
//           Text(
//             'ID: $_riderId',
//             style: const TextStyle(fontSize: 12, color: AppColors.textHint),
//           ),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(
//                 Icons.star_rounded,
//                 size: 16,
//                 color: Color(0xFFF5A623),
//               ),
//               const SizedBox(width: 3),
//               Text(
//                 '$_rating Rating',
//                 style: const TextStyle(
//                   fontSize: 12.5,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.textSecondary,
//                 ),
//               ),
//               const SizedBox(width: 14),
//               Text(
//                 '$_totalTrips Trips',
//                 style: const TextStyle(
//                   fontSize: 12.5,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.textSecondary,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             decoration: BoxDecoration(
//               color: AppColors.success.withOpacity(0.12),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: const Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(Icons.check_circle, size: 14, color: AppColors.success),
//                 SizedBox(width: 5),
//                 Text(
//                   'Verified Rider',
//                   style: TextStyle(
//                     fontSize: 11.5,
//                     fontWeight: FontWeight.w700,
//                     color: AppColors.success,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 18),
//           Row(
//             children: [
//               Expanded(
//                 child: _HoverPressable(
//                   onTap: () => _openDashboard(context),
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     decoration: BoxDecoration(
//                       color: AppColors.inputFill,
//                       borderRadius: BorderRadius.circular(24),
//                     ),
//                     child: const Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(Icons.bar_chart, size: 15),
//                         SizedBox(width: 6),
//                         Text(
//                           'View Dashboard',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w700,
//                             fontSize: 12.5,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: _HoverPressable(
//                   onTap: () => _openEditProfile(context),
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     decoration: BoxDecoration(
//                       color: AppColors.primaryBlack,
//                       borderRadius: BorderRadius.circular(24),
//                     ),
//                     child: const Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(
//                           Icons.edit_outlined,
//                           size: 14,
//                           color: AppColors.pureWhite,
//                         ),
//                         SizedBox(width: 6),
//                         Text(
//                           'Edit Profile',
//                           style: TextStyle(
//                             color: AppColors.pureWhite,
//                             fontWeight: FontWeight.w700,
//                             fontSize: 12.5,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // ---------------------------------------------------------------------
//   // Section title helper (reused for every section on this page)
//   // ---------------------------------------------------------------------
//   Widget _sectionTitle(
//     String title, {
//     String? action,
//     VoidCallback? onActionTap,
//   }) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: AppColors.textPrimary,
//           ),
//         ),
//         if (action != null)
//           _HoverPressable(
//             onTap: onActionTap ?? () => _toast('$action — coming soon'),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   action,
//                   style: const TextStyle(
//                     fontSize: 12.5,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textSecondary,
//                   ),
//                 ),
//                 const Icon(
//                   Icons.chevron_right,
//                   size: 16,
//                   color: AppColors.textSecondary,
//                 ),
//               ],
//             ),
//           ),
//       ],
//     );
//   }

//   // ---------------------------------------------------------------------
//   // Account Information card
//   // ---------------------------------------------------------------------
//   Widget _buildAccountInfoCard() {
//     final rows = [
//       _InfoRowData(
//         Icons.phone_outlined,
//         const Color(0xFF4A90E2),
//         'Phone Number',
//         _phone,
//       ),
//       _InfoRowData(
//         Icons.mail_outline,
//         const Color(0xFFE86AA6),
//         'Email',
//         _email,
//       ),
//       _InfoRowData(
//         Icons.directions_car_outlined,
//         const Color(0xFFF5A623),
//         'Vehicle Number',
//         _vehicleNumber,
//       ),
//       _InfoRowData(
//         Icons.category_outlined,
//         const Color(0xFF2ECC71),
//         'Vehicle Type',
//         _vehicleType,
//       ),
//       _InfoRowData(
//         Icons.badge_outlined,
//         const Color(0xFF6C5CE7),
//         'Driving License',
//         '$_drivingLicense · Valid till $_licenseValidTill',
//       ),
//       _InfoRowData(
//         Icons.event_outlined,
//         const Color(0xFF888888),
//         'Joining Date',
//         _joiningDate,
//       ),
//     ];

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
//       decoration: BoxDecoration(
//         color: AppColors.pureWhite,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: AppColors.border),
//       ),
//       child: Column(
//         children: List.generate(rows.length, (i) {
//           final row = rows[i];
//           final isLast = i == rows.length - 1;
//           return Column(
//             children: [
//               _infoRow(row.icon, row.iconColor, row.label, row.value),
//               if (!isLast) const Divider(height: 1, color: AppColors.divider),
//             ],
//           );
//         }),
//       ),
//     );
//   }

//   Widget _infoRow(
//     IconData icon,
//     Color iconColor,
//     String label,
//     String value, {
//     VoidCallback? onTap,
//   }) {
//     return _HoverPressable(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 12),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(9),
//               decoration: BoxDecoration(
//                 color: iconColor.withOpacity(0.12),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Icon(icon, size: 16, color: iconColor),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     label,
//                     style: const TextStyle(
//                       fontSize: 11.5,
//                       color: AppColors.textHint,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     value,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       fontSize: 13.5,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textPrimary,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (onTap != null)
//               const Icon(
//                 Icons.chevron_right,
//                 size: 18,
//                 color: AppColors.textHint,
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ---------------------------------------------------------------------
//   // Documents card (preview — first few, "View All" opens the full list)
//   // ---------------------------------------------------------------------
//   Widget _buildDocumentsCard(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
//       decoration: BoxDecoration(
//         color: AppColors.pureWhite,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: AppColors.border),
//       ),
//       child: Column(
//         children: List.generate(_documents.length, (i) {
//           final doc = _documents[i];
//           final isLast = i == _documents.length - 1;
//           return Column(
//             children: [
//               _documentRow(context, doc),
//               if (!isLast) const Divider(height: 1, color: AppColors.divider),
//             ],
//           );
//         }),
//       ),
//     );
//   }

//   Widget _documentRow(BuildContext context, _DocumentItem doc) {
//     return _HoverPressable(
//       onTap: () => _showDocumentDetail(context, doc),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 12),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(9),
//               decoration: BoxDecoration(
//                 color: AppColors.inputFill,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(doc.icon, size: 16, color: AppColors.textPrimary),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 doc.label,
//                 style: const TextStyle(
//                   fontSize: 13.5,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.textPrimary,
//                 ),
//               ),
//             ),
//             Icon(
//               doc.valid ? Icons.check_circle : Icons.error_outline,
//               size: 15,
//               color: doc.valid ? AppColors.success : Colors.orange,
//             ),
//             const SizedBox(width: 5),
//             Flexible(
//               child: Text(
//                 doc.status,
//                 textAlign: TextAlign.right,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                   fontSize: 11.5,
//                   fontWeight: FontWeight.w600,
//                   color: doc.valid ? AppColors.success : Colors.orange[800],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showDocumentDetail(BuildContext context, _DocumentItem doc) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       builder: (sheetContext) => SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(22),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Container(
//                   width: 40,
//                   height: 4,
//                   margin: const EdgeInsets.only(bottom: 18),
//                   decoration: BoxDecoration(
//                     color: AppColors.border,
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),
//               ),
//               Row(
//                 children: [
//                   Icon(doc.icon, size: 20, color: AppColors.textPrimary),
//                   const SizedBox(width: 10),
//                   Text(
//                     doc.label,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 17,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 doc.status,
//                 style: TextStyle(
//                   color: doc.valid ? AppColors.success : Colors.orange[800],
//                   fontWeight: FontWeight.w700,
//                   fontSize: 13,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 doc.detail,
//                 style: const TextStyle(
//                   color: AppColors.textSecondary,
//                   fontSize: 13,
//                   height: 1.4,
//                 ),
//               ),
//               const SizedBox(height: 18),
//               SizedBox(
//                 width: double.infinity,
//                 height: 48,
//                 child: OutlinedButton(
//                   style: OutlinedButton.styleFrom(
//                     side: const BorderSide(color: AppColors.border),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(24),
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.pop(sheetContext);
//                     _toast('Re-upload ${doc.label} — coming soon');
//                   },
//                   child: const Text(
//                     'Re-upload Document',
//                     style: TextStyle(fontWeight: FontWeight.w600),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _openDocuments(BuildContext context) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (_) => _DocumentsListScreen(
//           documents: _documents,
//           onTapDocument: _showDocumentDetail,
//         ),
//       ),
//     );
//   }

//   // ---------------------------------------------------------------------
//   // Wallet balance card (black, matches Earnings hero-card styling)
//   // ---------------------------------------------------------------------
//   Widget _buildWalletCard(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: AppColors.primaryBlack,
//         borderRadius: BorderRadius.circular(22),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.primaryBlack.withOpacity(0.25),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'WALLET BALANCE',
//             style: TextStyle(
//               color: AppColors.textHint,
//               fontSize: 11,
//               fontWeight: FontWeight.bold,
//               letterSpacing: 0.6,
//             ),
//           ),
//           const SizedBox(height: 8),
//           _AnimatedCounter(
//             animation: _entrance,
//             target: _walletBalance,
//             prefix: '₹',
//             decimals: 2,
//             style: const TextStyle(
//               color: AppColors.pureWhite,
//               fontSize: 30,
//               fontWeight: FontWeight.bold,
//               height: 1,
//             ),
//           ),
//           const SizedBox(height: 18),
//           Row(
//             children: [
//               Expanded(
//                 child: _HoverPressable(
//                   onTap: () => _showWithdrawSheet(context),
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(vertical: 13),
//                     decoration: BoxDecoration(
//                       color: AppColors.pureWhite,
//                       borderRadius: BorderRadius.circular(26),
//                     ),
//                     child: const Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(Icons.account_balance_wallet_outlined, size: 15),
//                         SizedBox(width: 6),
//                         Text(
//                           'Withdraw',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w700,
//                             fontSize: 13,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: _HoverPressable(
//                   onTap: () => _openWalletHistory(context),
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(vertical: 13),
//                     decoration: BoxDecoration(
//                       color: AppColors.pureWhite.withOpacity(0.12),
//                       borderRadius: BorderRadius.circular(26),
//                     ),
//                     child: const Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(
//                           Icons.history_rounded,
//                           size: 15,
//                           color: AppColors.pureWhite,
//                         ),
//                         SizedBox(width: 6),
//                         Text(
//                           'History',
//                           style: TextStyle(
//                             color: AppColors.pureWhite,
//                             fontWeight: FontWeight.w700,
//                             fontSize: 13,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   void _showWithdrawSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       builder: (sheetContext) => SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(22),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Center(
//                 child: Container(
//                   width: 40,
//                   height: 4,
//                   margin: const EdgeInsets.only(bottom: 18),
//                   decoration: BoxDecoration(
//                     color: AppColors.border,
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),
//               ),
//               const Text(
//                 'Withdraw',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//               const SizedBox(height: 6),
//               Text(
//                 '₹${_walletBalance.toStringAsFixed(2)} will be transferred to '
//                 'your linked bank account $_bankAccountNumber within 24 hours.',
//                 style: const TextStyle(
//                   color: AppColors.textSecondary,
//                   fontSize: 13,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               SizedBox(
//                 width: double.infinity,
//                 height: 52,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primaryBlack,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(28),
//                     ),
//                     elevation: 0,
//                   ),
//                   onPressed: () {
//                     Navigator.pop(sheetContext);
//                     setState(() => _walletBalance = 0);
//                     _toast('Withdrawal requested — funds arrive within 24h');
//                   },
//                   child: const Text(
//                     'Confirm Withdrawal',
//                     style: TextStyle(
//                       color: AppColors.pureWhite,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _openWalletHistory(BuildContext context) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (_) =>
//             const _WalletHistoryScreen(transactions: _walletHistory),
//       ),
//     );
//   }

//   // ---------------------------------------------------------------------
//   // Wallet links card: Bank Account / Payout Settings / Transaction History
//   // ---------------------------------------------------------------------
//   Widget _buildWalletLinksCard(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
//       decoration: BoxDecoration(
//         color: AppColors.pureWhite,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: AppColors.border),
//       ),
//       child: Column(
//         children: [
//           _infoRow(
//             Icons.account_balance_outlined,
//             const Color(0xFF4A90E2),
//             'Bank Account',
//             '•••• ${_bankAccountNumber.substring(_bankAccountNumber.length - 4)}',
//             onTap: () => _openBankAccount(context),
//           ),
//           const Divider(height: 1, color: AppColors.divider),
//           _infoRow(
//             Icons.tune,
//             const Color(0xFF6C5CE7),
//             'Withdraw Settings',
//             _autoPayout ? 'Auto · $_payoutFrequency' : 'Manual',
//             onTap: () => _openPayoutSettings(context),
//           ),
//           const Divider(height: 1, color: AppColors.divider),
//           _infoRow(
//             Icons.list_alt_outlined,
//             const Color(0xFF2ECC71),
//             'Transaction History',
//             '${_walletHistory.length} recent transactions',
//             onTap: () => _openWalletHistory(context),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _openBankAccount(BuildContext context) async {
//     final result = await Navigator.of(context).push<Map<String, String>>(
//       MaterialPageRoute(
//         builder: (_) => _BankAccountScreen(
//           holder: _bankHolder,
//           accountNumber: _bankAccountNumber,
//           ifsc: _ifsc,
//         ),
//       ),
//     );
//     if (result != null && mounted) {
//       setState(() {
//         _bankHolder = result['holder'] ?? _bankHolder;
//         _bankAccountNumber = result['accountNumber'] ?? _bankAccountNumber;
//         _ifsc = result['ifsc'] ?? _ifsc;
//       });
//       _toast('Bank details updated');
//     }
//   }

//   Future<void> _openPayoutSettings(BuildContext context) async {
//     final result = await Navigator.of(context).push<Map<String, dynamic>>(
//       MaterialPageRoute(
//         builder: (_) => _PayoutSettingsScreen(
//           autoPayout: _autoPayout,
//           frequency: _payoutFrequency,
//         ),
//       ),
//     );
//     if (result != null && mounted) {
//       setState(() {
//         _autoPayout = result['autoPayout'] as bool? ?? _autoPayout;
//         _payoutFrequency = result['frequency'] as String? ?? _payoutFrequency;
//       });
//       _toast('Withdraw settings saved');
//     }
//   }

//   // ---------------------------------------------------------------------
//   // Settings card
//   // ---------------------------------------------------------------------
//   Widget _buildSettingsCard(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
//       decoration: BoxDecoration(
//         color: AppColors.pureWhite,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: AppColors.border),
//       ),
//       child: Column(
//         children: [
//           _infoRow(
//             Icons.notifications_none,
//             const Color(0xFFF5A623),
//             'Notification Settings',
//             _notifTrips || _notifPromos || _notifPayouts ? 'On' : 'Off',
//             onTap: () => _openNotificationSettings(context),
//           ),
//           const Divider(height: 1, color: AppColors.divider),
//           _infoRow(
//             Icons.language,
//             const Color(0xFF4A90E2),
//             'Language',
//             _language,
//             onTap: () => _pickLanguage(context),
//           ),
//           const Divider(height: 1, color: AppColors.divider),
//           _infoRow(
//             Icons.help_outline,
//             const Color(0xFF6C5CE7),
//             'Help & Support',
//             'FAQs & contact',
//             onTap: () => _showHelpSheet(context),
//           ),
//           const Divider(height: 1, color: AppColors.divider),
//           _infoRow(
//             Icons.description_outlined,
//             const Color(0xFF888888),
//             'Terms & Conditions',
//             '',
//             onTap: () => Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (_) => const _StaticTextScreen(
//                   title: 'Terms & Conditions',
//                   body: _termsText,
//                 ),
//               ),
//             ),
//           ),
//           const Divider(height: 1, color: AppColors.divider),
//           _infoRow(
//             Icons.lock_outline,
//             const Color(0xFFE86AA6),
//             'Privacy Policy',
//             '',
//             onTap: () => Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (_) => const _StaticTextScreen(
//                   title: 'Privacy Policy',
//                   body: _privacyText,
//                 ),
//               ),
//             ),
//           ),
//           const Divider(height: 1, color: AppColors.divider),
//           _infoRow(
//             Icons.info_outline,
//             const Color(0xFF2ECC71),
//             'About App',
//             'v2.4.1',
//             onTap: () => _showAboutDialog(context),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _openNotificationSettings(BuildContext context) async {
//     final result = await Navigator.of(context).push<Map<String, bool>>(
//       MaterialPageRoute(
//         builder: (_) => _NotificationSettingsScreen(
//           trips: _notifTrips,
//           promos: _notifPromos,
//           payouts: _notifPayouts,
//         ),
//       ),
//     );
//     if (result != null && mounted) {
//       setState(() {
//         _notifTrips = result['trips'] ?? _notifTrips;
//         _notifPromos = result['promos'] ?? _notifPromos;
//         _notifPayouts = result['payouts'] ?? _notifPayouts;
//       });
//       _toast('Notification preferences saved');
//     }
//   }

//   Future<void> _pickLanguage(BuildContext context) async {
//     const options = [
//       'English',
//       'हिन्दी (Hindi)',
//       'தமிழ் (Tamil)',
//       'తెలుగు (Telugu)',
//     ];
//     final picked = await showDialog<String>(
//       context: context,
//       builder: (dialogContext) => SimpleDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         title: const Text('Choose Language'),
//         children: options
//             .map(
//               (lang) => RadioListTile<String>(
//                 value: lang,
//                 groupValue: _language,
//                 activeColor: AppColors.primaryBlack,
//                 title: Text(lang),
//                 onChanged: (value) => Navigator.pop(dialogContext, value),
//               ),
//             )
//             .toList(),
//       ),
//     );
//     if (picked != null && mounted) {
//       setState(() => _language = picked);
//       _toast('Language set to $picked');
//     }
//   }

//   void _showAboutDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (dialogContext) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         title: const Text('Rento India Rider'),
//         content: const Text(
//           'Version 2.4.1 (Build 2026.07)\n\n'
//           'Rento India connects riders with rental pickup, delivery, and '
//           'return jobs across the city.',
//           style: TextStyle(height: 1.4),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(dialogContext),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showHelpSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       builder: (sheetContext) {
//         final maxHeight = MediaQuery.of(sheetContext).size.height * 0.85;
//         return ConstrainedBox(
//           constraints: BoxConstraints(maxHeight: maxHeight),
//           child: SafeArea(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(22),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(
//                     child: Container(
//                       width: 40,
//                       height: 4,
//                       margin: const EdgeInsets.only(bottom: 18),
//                       decoration: BoxDecoration(
//                         color: AppColors.border,
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                     ),
//                   ),
//                   const Text(
//                     'Help & Support',
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                   ),
//                   const SizedBox(height: 16),
//                   _helpItem(
//                     'How do I update my documents?',
//                     'Go to Documents → tap the document → Re-upload '
//                         'Document. Verification usually takes under 24 hours.',
//                   ),
//                   _helpItem(
//                     'How do I change my bank account?',
//                     'Go to Wallet & Payout → Bank Account → Edit, then '
//                         'save your new account details.',
//                   ),
//                   _helpItem(
//                     'Who do I contact for a trip issue?',
//                     'Use "Contact Support" from the Help & Support menu, '
//                         'or reach the in-app support chat from your trip '
//                         'details screen.',
//                   ),
//                   const SizedBox(height: 10),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 48,
//                     child: OutlinedButton(
//                       style: OutlinedButton.styleFrom(
//                         side: const BorderSide(color: AppColors.border),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(24),
//                         ),
//                       ),
//                       onPressed: () {
//                         Navigator.pop(sheetContext);
//                         _toast('Opening support chat — coming soon');
//                       },
//                       child: const Text(
//                         'Contact Support',
//                         style: TextStyle(fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _helpItem(String question, String answer) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             question,
//             style: const TextStyle(
//               fontWeight: FontWeight.w700,
//               fontSize: 14,
//               color: AppColors.textPrimary,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             answer,
//             style: const TextStyle(
//               fontSize: 13,
//               color: AppColors.textSecondary,
//               height: 1.4,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ---------------------------------------------------------------------
//   // Edit profile / view dashboard
//   // ---------------------------------------------------------------------
//   Future<void> _openEditProfile(BuildContext context) async {
//     final result = await Navigator.of(context).push<Map<String, String>>(
//       MaterialPageRoute(
//         builder: (_) => _EditProfileScreen(
//           name: _name,
//           phone: _phone,
//           email: _email,
//           vehicleNumber: _vehicleNumber,
//           vehicleType: _vehicleType,
//           drivingLicense: _drivingLicense,
//         ),
//       ),
//     );
//     if (result != null && mounted) {
//       setState(() {
//         _name = result['name'] ?? _name;
//         _phone = result['phone'] ?? _phone;
//         _email = result['email'] ?? _email;
//         _vehicleNumber = result['vehicleNumber'] ?? _vehicleNumber;
//         _vehicleType = result['vehicleType'] ?? _vehicleType;
//         _drivingLicense = result['drivingLicense'] ?? _drivingLicense;
//       });
//       _toast('Profile updated');
//     }
//   }

//   void _openDashboard(BuildContext context) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (_) => _DashboardScreen(
//           totalTrips: _totalTrips,
//           completedTrips: _completedTrips,
//           rating: _rating,
//           successRate: _successRate,
//         ),
//       ),
//     );
//   }

//   // ---------------------------------------------------------------------
//   // Log out
//   // ---------------------------------------------------------------------
//   Widget _buildLogoutButton(BuildContext context) {
//     return _HoverPressable(
//       onTap: () => _confirmLogout(context),
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 15),
//         decoration: BoxDecoration(
//           color: AppColors.pureWhite,
//           borderRadius: BorderRadius.circular(18),
//           border: Border.all(color: AppColors.border),
//         ),
//         child: const Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(Icons.logout_rounded, size: 17, color: Colors.redAccent),
//             SizedBox(width: 8),
//             Text(
//               'Log Out',
//               style: TextStyle(
//                 color: Colors.redAccent,
//                 fontWeight: FontWeight.w700,
//                 fontSize: 14,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _confirmLogout(BuildContext context) async {
//     final confirmed = await showDialog<bool>(
//       context: context,
//       builder: (dialogContext) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         title: const Text('Log Out?'),
//         content: const Text(
//           'You\'ll need to verify your mobile number again to sign back in.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(dialogContext, false),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(dialogContext, true),
//             child: const Text(
//               'Log Out',
//               style: TextStyle(color: Colors.redAccent),
//             ),
//           ),
//         ],
//       ),
//     );
//     if (confirmed == true && mounted) {
//       // TODO: wire this to the real auth/session controller
//       // (e.g. Get.find<AuthController>().logout()) once the backend
//       // and login flow are connected.
//       // ⭐ FIX — route.isFirst popped to whatever sits at the very
//       // bottom of the navigator stack instead of actually logging out;
//       // this now clears the whole stack and sends the rider back to
//       // Mobile Entry, same as the drawer's Log Out action.
//       Navigator.of(
//         context,
//       ).pushNamedAndRemoveUntil(RouteNames.mobileEntry, (route) => false);
//       _toast('Logged out');
//     }
//   }

//   Widget _buildVersionFooter() {
//     return const Center(
//       child: Text(
//         'Rento India Rider v2.4.1 · Build 2026.07',
//         style: TextStyle(fontSize: 11, color: AppColors.textHint),
//       ),
//     );
//   }
// }

// // =============================================================================
// // Full Documents list screen ("View All")
// // =============================================================================
// class _DocumentsListScreen extends StatelessWidget {
//   final List<_DocumentItem> documents;
//   final void Function(BuildContext, _DocumentItem) onTapDocument;

//   const _DocumentsListScreen({
//     required this.documents,
//     required this.onTapDocument,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F4F4),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF4F4F4),
//         elevation: 0,
//         title: const Text(
//           'Documents',
//           style: TextStyle(
//             color: AppColors.textPrimary,
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: AppColors.textPrimary),
//       ),
//       body: SafeArea(
//         top: false,
//         child: ListView.separated(
//           padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
//           itemCount: documents.length,
//           separatorBuilder: (_, __) => const SizedBox(height: 10),
//           itemBuilder: (context, i) {
//             final doc = documents[i];
//             return _HoverPressable(
//               onTap: () => onTapDocument(context, doc),
//               liftOnHover: true,
//               child: Container(
//                 padding: const EdgeInsets.all(14),
//                 decoration: BoxDecoration(
//                   color: AppColors.pureWhite,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(color: AppColors.border),
//                 ),
//                 child: Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(10),
//                       decoration: const BoxDecoration(
//                         color: AppColors.inputFill,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         doc.icon,
//                         size: 18,
//                         color: AppColors.textPrimary,
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             doc.label,
//                             style: const TextStyle(
//                               fontSize: 13.5,
//                               fontWeight: FontWeight.w700,
//                               color: AppColors.textPrimary,
//                             ),
//                           ),
//                           const SizedBox(height: 2),
//                           Text(
//                             doc.status,
//                             style: TextStyle(
//                               fontSize: 11.5,
//                               fontWeight: FontWeight.w600,
//                               color: doc.valid
//                                   ? AppColors.success
//                                   : Colors.orange[800],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const Icon(
//                       Icons.chevron_right,
//                       size: 18,
//                       color: AppColors.textHint,
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// // =============================================================================
// // Wallet transaction history screen
// // =============================================================================
// class _WalletHistoryScreen extends StatelessWidget {
//   final List<_WalletTxn> transactions;

//   const _WalletHistoryScreen({required this.transactions});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F4F4),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF4F4F4),
//         elevation: 0,
//         title: const Text(
//           'Wallet History',
//           style: TextStyle(
//             color: AppColors.textPrimary,
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: AppColors.textPrimary),
//       ),
//       body: SafeArea(
//         top: false,
//         child: ListView.separated(
//           padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
//           itemCount: transactions.length,
//           separatorBuilder: (_, __) => const SizedBox(height: 10),
//           itemBuilder: (context, i) {
//             final txn = transactions[i];
//             return Container(
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(
//                 color: AppColors.pureWhite,
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: AppColors.border),
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: (txn.credit ? AppColors.success : Colors.redAccent)
//                           .withOpacity(0.12),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       txn.credit
//                           ? Icons.arrow_downward_rounded
//                           : Icons.arrow_upward_rounded,
//                       size: 18,
//                       color: txn.credit ? AppColors.success : Colors.redAccent,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           txn.title,
//                           style: const TextStyle(
//                             fontSize: 13.5,
//                             fontWeight: FontWeight.w700,
//                             color: AppColors.textPrimary,
//                           ),
//                         ),
//                         const SizedBox(height: 2),
//                         Text(
//                           txn.subtitle,
//                           style: const TextStyle(
//                             fontSize: 11.5,
//                             color: AppColors.textSecondary,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         '${txn.credit ? '+' : '-'}₹${txn.amount.abs()}',
//                         style: TextStyle(
//                           fontSize: 14.5,
//                           fontWeight: FontWeight.bold,
//                           color: txn.credit
//                               ? AppColors.success
//                               : Colors.redAccent,
//                         ),
//                       ),
//                       const SizedBox(height: 3),
//                       Text(
//                         txn.date,
//                         style: const TextStyle(
//                           fontSize: 10,
//                           color: AppColors.textHint,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// // =============================================================================
// // Edit Profile screen
// // =============================================================================
// class _EditProfileScreen extends StatefulWidget {
//   final String name;
//   final String phone;
//   final String email;
//   final String vehicleNumber;
//   final String vehicleType;
//   final String drivingLicense;

//   const _EditProfileScreen({
//     required this.name,
//     required this.phone,
//     required this.email,
//     required this.vehicleNumber,
//     required this.vehicleType,
//     required this.drivingLicense,
//   });

//   @override
//   State<_EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<_EditProfileScreen> {
//   late final TextEditingController _nameCtrl;
//   late final TextEditingController _phoneCtrl;
//   late final TextEditingController _emailCtrl;
//   late final TextEditingController _vehicleNumberCtrl;
//   late final TextEditingController _vehicleTypeCtrl;
//   late final TextEditingController _licenseCtrl;
//   final _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     _nameCtrl = TextEditingController(text: widget.name);
//     _phoneCtrl = TextEditingController(text: widget.phone);
//     _emailCtrl = TextEditingController(text: widget.email);
//     _vehicleNumberCtrl = TextEditingController(text: widget.vehicleNumber);
//     _vehicleTypeCtrl = TextEditingController(text: widget.vehicleType);
//     _licenseCtrl = TextEditingController(text: widget.drivingLicense);
//   }

//   @override
//   void dispose() {
//     _nameCtrl.dispose();
//     _phoneCtrl.dispose();
//     _emailCtrl.dispose();
//     _vehicleNumberCtrl.dispose();
//     _vehicleTypeCtrl.dispose();
//     _licenseCtrl.dispose();
//     super.dispose();
//   }

//   InputDecoration _decoration(String label) {
//     return InputDecoration(
//       labelText: label,
//       filled: true,
//       fillColor: AppColors.inputFill,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: BorderSide.none,
//       ),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//     );
//   }

//   void _save() {
//     if (!_formKey.currentState!.validate()) return;
//     Navigator.pop(context, {
//       'name': _nameCtrl.text.trim(),
//       'phone': _phoneCtrl.text.trim(),
//       'email': _emailCtrl.text.trim(),
//       'vehicleNumber': _vehicleNumberCtrl.text.trim(),
//       'vehicleType': _vehicleTypeCtrl.text.trim(),
//       'drivingLicense': _licenseCtrl.text.trim(),
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F4F4),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF4F4F4),
//         elevation: 0,
//         title: const Text(
//           'Edit Profile',
//           style: TextStyle(
//             color: AppColors.textPrimary,
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: AppColors.textPrimary),
//       ),
//       body: SafeArea(
//         top: false,
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
//             children: [
//               TextFormField(
//                 controller: _nameCtrl,
//                 decoration: _decoration('Full Name'),
//                 validator: (v) =>
//                     (v == null || v.trim().isEmpty) ? 'Required' : null,
//               ),
//               const SizedBox(height: 14),
//               TextFormField(
//                 controller: _phoneCtrl,
//                 keyboardType: TextInputType.phone,
//                 decoration: _decoration('Phone Number'),
//                 validator: (v) =>
//                     (v == null || v.trim().isEmpty) ? 'Required' : null,
//               ),
//               const SizedBox(height: 14),
//               TextFormField(
//                 controller: _emailCtrl,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: _decoration('Email'),
//                 validator: (v) =>
//                     (v == null || v.trim().isEmpty) ? 'Required' : null,
//               ),
//               const SizedBox(height: 14),
//               TextFormField(
//                 controller: _vehicleNumberCtrl,
//                 decoration: _decoration('Vehicle Number'),
//                 validator: (v) =>
//                     (v == null || v.trim().isEmpty) ? 'Required' : null,
//               ),
//               const SizedBox(height: 14),
//               TextFormField(
//                 controller: _vehicleTypeCtrl,
//                 decoration: _decoration('Vehicle Type'),
//               ),
//               const SizedBox(height: 14),
//               TextFormField(
//                 controller: _licenseCtrl,
//                 decoration: _decoration('Driving License Number'),
//               ),
//               const SizedBox(height: 24),
//               SizedBox(
//                 width: double.infinity,
//                 height: 52,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primaryBlack,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(26),
//                     ),
//                     elevation: 0,
//                   ),
//                   onPressed: _save,
//                   child: const Text(
//                     'Save Changes',
//                     style: TextStyle(
//                       color: AppColors.pureWhite,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // =============================================================================
// // Performance dashboard screen ("View Dashboard")
// // This is the ONLY place Total Trips / Completed / Rating / Success Rate
// // are shown now — the duplicate grid on the main Profile screen was removed.
// // =============================================================================
// class _DashboardScreen extends StatelessWidget {
//   final int totalTrips;
//   final int completedTrips;
//   final double rating;
//   final double successRate;

//   const _DashboardScreen({
//     required this.totalTrips,
//     required this.completedTrips,
//     required this.rating,
//     required this.successRate,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final tiles = [
//       _StatCardData(
//         icon: Icons.map_outlined,
//         iconColor: AppColors.textPrimary,
//         value: '$totalTrips',
//         label: 'Total Trips',
//       ),
//       _StatCardData(
//         icon: Icons.check_circle_outline,
//         iconColor: AppColors.success,
//         value: '$completedTrips',
//         label: 'Completed Trips',
//       ),
//       _StatCardData(
//         icon: Icons.star_rounded,
//         iconColor: const Color(0xFFF5A623),
//         value: '$rating',
//         label: 'Average Rating',
//       ),
//       _StatCardData(
//         icon: Icons.bolt_outlined,
//         iconColor: const Color(0xFF6C5CE7),
//         value: '${successRate.toStringAsFixed(0)}%',
//         label: 'Success Rate',
//       ),
//     ];

//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F4F4),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF4F4F4),
//         elevation: 0,
//         title: const Text(
//           'Performance Dashboard',
//           style: TextStyle(
//             color: AppColors.textPrimary,
//             fontWeight: FontWeight.bold,
//             fontSize: 17,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: AppColors.textPrimary),
//       ),
//       body: SafeArea(
//         top: false,
//         child: GridView.builder(
//           padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
//           itemCount: tiles.length,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             mainAxisSpacing: 12,
//             crossAxisSpacing: 12,
//             mainAxisExtent: 120,
//           ),
//           itemBuilder: (context, i) {
//             final tile = tiles[i];
//             return Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: AppColors.pureWhite,
//                 borderRadius: BorderRadius.circular(18),
//                 border: Border.all(color: AppColors.border),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: tile.iconColor.withOpacity(0.12),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Icon(tile.icon, size: 18, color: tile.iconColor),
//                   ),
//                   Text(
//                     tile.value,
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.textPrimary,
//                     ),
//                   ),
//                   Text(
//                     tile.label,
//                     style: const TextStyle(
//                       fontSize: 12,
//                       color: AppColors.textHint,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// // =============================================================================
// // Bank account screen
// // =============================================================================
// class _BankAccountScreen extends StatefulWidget {
//   final String holder;
//   final String accountNumber;
//   final String ifsc;

//   const _BankAccountScreen({
//     required this.holder,
//     required this.accountNumber,
//     required this.ifsc,
//   });

//   @override
//   State<_BankAccountScreen> createState() => _BankAccountScreenState();
// }

// class _BankAccountScreenState extends State<_BankAccountScreen> {
//   late String _holder = widget.holder;
//   late String _accountNumber = widget.accountNumber;
//   late String _ifsc = widget.ifsc;

//   Future<void> _editDetails(BuildContext context) async {
//     final holderCtrl = TextEditingController(text: _holder);
//     final accountCtrl = TextEditingController(text: _accountNumber);
//     final ifscCtrl = TextEditingController(text: _ifsc);

//     final result = await showDialog<bool>(
//       context: context,
//       builder: (dialogContext) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         title: const Text('Edit Bank Details'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: holderCtrl,
//               decoration: const InputDecoration(labelText: 'Account Holder'),
//             ),
//             TextField(
//               controller: accountCtrl,
//               decoration: const InputDecoration(labelText: 'Account Number'),
//             ),
//             TextField(
//               controller: ifscCtrl,
//               decoration: const InputDecoration(labelText: 'IFSC Code'),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(dialogContext, false),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(dialogContext, true),
//             child: const Text('Save'),
//           ),
//         ],
//       ),
//     );

//     if (result == true) {
//       setState(() {
//         _holder = holderCtrl.text.trim();
//         _accountNumber = accountCtrl.text.trim();
//         _ifsc = ifscCtrl.text.trim();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F4F4),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF4F4F4),
//         elevation: 0,
//         title: const Text(
//           'Bank Account',
//           style: TextStyle(
//             color: AppColors.textPrimary,
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: AppColors.textPrimary),
//       ),
//       body: SafeArea(
//         top: false,
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(18),
//                 decoration: BoxDecoration(
//                   color: AppColors.pureWhite,
//                   borderRadius: BorderRadius.circular(18),
//                   border: Border.all(color: AppColors.border),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _bankLine('Account Holder', _holder),
//                     const Divider(height: 24, color: AppColors.divider),
//                     _bankLine('Account Number', _accountNumber),
//                     const Divider(height: 24, color: AppColors.divider),
//                     _bankLine('IFSC Code', _ifsc),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 16),
//               SizedBox(
//                 height: 50,
//                 child: OutlinedButton(
//                   style: OutlinedButton.styleFrom(
//                     side: const BorderSide(color: AppColors.border),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(24),
//                     ),
//                   ),
//                   onPressed: () => _editDetails(context),
//                   child: const Text(
//                     'Edit Bank Details',
//                     style: TextStyle(fontWeight: FontWeight.w600),
//                   ),
//                 ),
//               ),
//               const Spacer(),
//               SizedBox(
//                 width: double.infinity,
//                 height: 52,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primaryBlack,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(26),
//                     ),
//                     elevation: 0,
//                   ),
//                   onPressed: () => Navigator.pop(context, {
//                     'holder': _holder,
//                     'accountNumber': _accountNumber,
//                     'ifsc': _ifsc,
//                   }),
//                   child: const Text(
//                     'Done',
//                     style: TextStyle(
//                       color: AppColors.pureWhite,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _bankLine(String label, String value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(fontSize: 11.5, color: AppColors.textHint),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           value,
//           style: const TextStyle(
//             fontSize: 15,
//             fontWeight: FontWeight.w700,
//             color: AppColors.textPrimary,
//           ),
//         ),
//       ],
//     );
//   }
// }

// // =============================================================================
// // Payout settings screen
// // =============================================================================
// class _PayoutSettingsScreen extends StatefulWidget {
//   final bool autoPayout;
//   final String frequency;

//   const _PayoutSettingsScreen({
//     required this.autoPayout,
//     required this.frequency,
//   });

//   @override
//   State<_PayoutSettingsScreen> createState() => _PayoutSettingsScreenState();
// }

// class _PayoutSettingsScreenState extends State<_PayoutSettingsScreen> {
//   late bool _autoPayout = widget.autoPayout;
//   late String _frequency = widget.frequency;

//   static const _frequencies = ['Daily', 'Weekly', 'Monthly'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F4F4),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF4F4F4),
//         elevation: 0,
//         title: const Text(
//           'Withdraw Settings',
//           style: TextStyle(
//             color: AppColors.textPrimary,
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: AppColors.textPrimary),
//       ),
//       body: SafeArea(
//         top: false,
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 decoration: BoxDecoration(
//                   color: AppColors.pureWhite,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(color: AppColors.border),
//                 ),
//                 child: SwitchListTile(
//                   activeColor: AppColors.primaryBlack,
//                   contentPadding: EdgeInsets.zero,
//                   title: const Text(
//                     'Enable Auto Payout',
//                     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
//                   ),
//                   subtitle: const Text(
//                     'Automatically send earnings to your bank account',
//                     style: TextStyle(fontSize: 12),
//                   ),
//                   value: _autoPayout,
//                   onChanged: (v) => setState(() => _autoPayout = v),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               if (_autoPayout) ...[
//                 const Text(
//                   'Payout Frequency',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//                 ),
//                 const SizedBox(height: 10),
//                 ..._frequencies.map(
//                   (freq) => Container(
//                     margin: const EdgeInsets.only(bottom: 10),
//                     decoration: BoxDecoration(
//                       color: AppColors.pureWhite,
//                       borderRadius: BorderRadius.circular(14),
//                       border: Border.all(color: AppColors.border),
//                     ),
//                     child: RadioListTile<String>(
//                       activeColor: AppColors.primaryBlack,
//                       value: freq,
//                       groupValue: _frequency,
//                       title: Text(freq),
//                       onChanged: (v) => setState(() => _frequency = v!),
//                     ),
//                   ),
//                 ),
//               ],
//               const Spacer(),
//               SizedBox(
//                 width: double.infinity,
//                 height: 52,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primaryBlack,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(26),
//                     ),
//                     elevation: 0,
//                   ),
//                   onPressed: () => Navigator.pop(context, {
//                     'autoPayout': _autoPayout,
//                     'frequency': _frequency,
//                   }),
//                   child: const Text(
//                     'Save Settings',
//                     style: TextStyle(
//                       color: AppColors.pureWhite,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // =============================================================================
// // Notification settings screen
// // =============================================================================
// class _NotificationSettingsScreen extends StatefulWidget {
//   final bool trips;
//   final bool promos;
//   final bool payouts;

//   const _NotificationSettingsScreen({
//     required this.trips,
//     required this.promos,
//     required this.payouts,
//   });

//   @override
//   State<_NotificationSettingsScreen> createState() =>
//       _NotificationSettingsScreenState();
// }

// class _NotificationSettingsScreenState
//     extends State<_NotificationSettingsScreen> {
//   late bool _trips = widget.trips;
//   late bool _promos = widget.promos;
//   late bool _payouts = widget.payouts;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F4F4),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF4F4F4),
//         elevation: 0,
//         title: const Text(
//           'Notification Settings',
//           style: TextStyle(
//             color: AppColors.textPrimary,
//             fontWeight: FontWeight.bold,
//             fontSize: 17,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: AppColors.textPrimary),
//       ),
//       body: SafeArea(
//         top: false,
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 decoration: BoxDecoration(
//                   color: AppColors.pureWhite,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(color: AppColors.border),
//                 ),
//                 child: Column(
//                   children: [
//                     SwitchListTile(
//                       activeColor: AppColors.primaryBlack,
//                       contentPadding: EdgeInsets.zero,
//                       title: const Text(
//                         'Trip Updates',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 14,
//                         ),
//                       ),
//                       subtitle: const Text(
//                         'Pickup, delivery, and return alerts',
//                         style: TextStyle(fontSize: 12),
//                       ),
//                       value: _trips,
//                       onChanged: (v) => setState(() => _trips = v),
//                     ),
//                     const Divider(height: 1, color: AppColors.divider),
//                     SwitchListTile(
//                       activeColor: AppColors.primaryBlack,
//                       contentPadding: EdgeInsets.zero,
//                       title: const Text(
//                         'Promotions & Offers',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 14,
//                         ),
//                       ),
//                       subtitle: const Text(
//                         'Bonus campaigns and incentives',
//                         style: TextStyle(fontSize: 12),
//                       ),
//                       value: _promos,
//                       onChanged: (v) => setState(() => _promos = v),
//                     ),
//                     const Divider(height: 1, color: AppColors.divider),
//                     SwitchListTile(
//                       activeColor: AppColors.primaryBlack,
//                       contentPadding: EdgeInsets.zero,
//                       title: const Text(
//                         'Payout Alerts',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 14,
//                         ),
//                       ),
//                       subtitle: const Text(
//                         'Wallet credits and withdrawals',
//                         style: TextStyle(fontSize: 12),
//                       ),
//                       value: _payouts,
//                       onChanged: (v) => setState(() => _payouts = v),
//                     ),
//                   ],
//                 ),
//               ),
//               const Spacer(),
//               SizedBox(
//                 width: double.infinity,
//                 height: 52,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primaryBlack,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(26),
//                     ),
//                     elevation: 0,
//                   ),
//                   onPressed: () => Navigator.pop(context, {
//                     'trips': _trips,
//                     'promos': _promos,
//                     'payouts': _payouts,
//                   }),
//                   child: const Text(
//                     'Save Preferences',
//                     style: TextStyle(
//                       color: AppColors.pureWhite,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // =============================================================================
// // Static text screen (Terms & Conditions / Privacy Policy)
// // =============================================================================
// class _StaticTextScreen extends StatelessWidget {
//   final String title;
//   final String body;

//   const _StaticTextScreen({required this.title, required this.body});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F4F4),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF4F4F4),
//         elevation: 0,
//         title: Text(
//           title,
//           style: const TextStyle(
//             color: AppColors.textPrimary,
//             fontWeight: FontWeight.bold,
//             fontSize: 17,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: AppColors.textPrimary),
//       ),
//       body: SafeArea(
//         top: false,
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Text(
//             body,
//             style: const TextStyle(
//               fontSize: 13.5,
//               color: AppColors.textSecondary,
//               height: 1.55,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// const String _termsText =
//     'These Terms & Conditions govern your use of the Rento India Rider '
//     'app. By registering as a rider, you agree to complete pickup, '
//     'delivery, and return trips in accordance with the schedules and '
//     'routes assigned to you, to maintain valid documents (driving '
//     'license, vehicle RC, and insurance) at all times, and to represent '
//     'trip and earnings information accurately.\n\n'
//     'Rento India reserves the right to suspend or deactivate a rider '
//     'account for repeated cancellations, safety violations, or '
//     'fraudulent activity. Earnings, bonuses, and incentive structures '
//     'are subject to change with prior notice.\n\n'
//     'This is placeholder legal text — replace with the finalized rider '
//     'agreement before release.';

// const String _privacyText =
//     'Rento India collects the information you provide during KYC '
//     '(identity documents, vehicle details, bank information) and the '
//     'location data required to route pickups, deliveries, and returns.\n\n'
//     'This data is used to verify your identity, process payouts, and '
//     'improve trip routing. We do not sell rider data to third parties. '
//     'Location access can be managed from your device settings, though '
//     'disabling it will affect trip assignment.\n\n'
//     'This is placeholder legal text — replace with the finalized privacy '
//     'policy before release.';

// // =============================================================================
// // Shared reusable pieces (mirrors the Earnings tab's private widgets)
// // =============================================================================

// /// Wraps a tappable widget with a hover-lift effect (mouse, on web/desktop)
// /// and a press-scale effect (touch, on mobile).
// class _HoverPressable extends StatefulWidget {
//   final Widget child;
//   final VoidCallback? onTap;
//   final bool liftOnHover;

//   const _HoverPressable({
//     required this.child,
//     this.onTap,
//     this.liftOnHover = false,
//   });

//   @override
//   State<_HoverPressable> createState() => _HoverPressableState();
// }

// class _HoverPressableState extends State<_HoverPressable> {
//   bool _hovering = false;
//   bool _pressed = false;

//   @override
//   Widget build(BuildContext context) {
//     final scale = _pressed ? 0.96 : (_hovering ? 1.02 : 1.0);
//     return MouseRegion(
//       cursor: SystemMouseCursors.click,
//       onEnter: (_) => setState(() => _hovering = true),
//       onExit: (_) => setState(() => _hovering = false),
//       child: GestureDetector(
//         onTap: widget.onTap,
//         onTapDown: (_) => setState(() => _pressed = true),
//         onTapUp: (_) => setState(() => _pressed = false),
//         onTapCancel: () => setState(() => _pressed = false),
//         child: AnimatedScale(
//           scale: scale,
//           duration: const Duration(milliseconds: 150),
//           curve: Curves.easeOut,
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 150),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(18),
//               boxShadow: (_hovering && widget.liftOnHover)
//                   ? [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.08),
//                         blurRadius: 16,
//                         offset: const Offset(0, 8),
//                       ),
//                     ]
//                   : const [],
//             ),
//             child: widget.child,
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// Animates a numeric value counting up from 0 to [target].
// class _AnimatedCounter extends StatelessWidget {
//   final Animation<double> animation;
//   final double target;
//   final String prefix;
//   final int decimals;
//   final TextStyle style;

//   const _AnimatedCounter({
//     required this.animation,
//     required this.target,
//     required this.style,
//     this.prefix = '',
//     this.decimals = 0,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: animation,
//       builder: (context, _) {
//         final value = (target * animation.value).clamp(0, target);
//         final display = decimals == 0
//             ? value.round().toString()
//             : value.toStringAsFixed(decimals);
//         return Text('$prefix${_thousands(display)}', style: style);
//       },
//     );
//   }

//   String _thousands(String number) {
//     final parts = number.split('.');
//     final isNegative = parts[0].startsWith('-');
//     final digits = isNegative ? parts[0].substring(1) : parts[0];
//     final buffer = StringBuffer();
//     for (var i = 0; i < digits.length; i++) {
//       final posFromEnd = digits.length - i;
//       buffer.write(digits[i]);
//       if (posFromEnd > 1 && posFromEnd % 3 == 1) {
//         buffer.write(',');
//       }
//     }
//     final whole = '${isNegative ? '-' : ''}$buffer';
//     return parts.length > 1 ? '$whole.${parts[1]}' : whole;
//   }
// }

// // =============================================================================
// // Mock data models
// // =============================================================================

// class _DocumentItem {
//   final IconData icon;
//   final String label;
//   final String status;
//   final bool valid;
//   final String detail;
//   const _DocumentItem({
//     required this.icon,
//     required this.label,
//     required this.status,
//     required this.valid,
//     required this.detail,
//   });
// }

// class _WalletTxn {
//   final String title;
//   final String subtitle;
//   final int amount;
//   final String date;
//   final bool credit;
//   const _WalletTxn({
//     required this.title,
//     required this.subtitle,
//     required this.amount,
//     required this.date,
//     required this.credit,
//   });
// }

// class _StatCardData {
//   final IconData icon;
//   final Color iconColor;
//   final String value;
//   final String label;
//   const _StatCardData({
//     required this.icon,
//     required this.iconColor,
//     required this.value,
//     required this.label,
//   });
// }

// class _InfoRowData {
//   final IconData icon;
//   final Color iconColor;
//   final String label;
//   final String value;
//   const _InfoRowData(this.icon, this.iconColor, this.label, this.value);
// }


import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../providers/rider_tab_provider.dart';
import '../../../../../core/routes/route_names.dart';
// TEMP: dev-only entry point to preview the parcel flow — it isn't
// wired to any live accept path yet, so this is the only way to see
// the 3 parcel screens end-to-end until that integration is done.
import '../../../data/models/parcel_request_model.dart';
import '../parcel/navigate_to_parcel_screen.dart';
// TEMP: dev-only entry point to preview the person-ride flow — same
// reason as the parcel one above, not wired to a live accept path yet.
import '../../../data/models/person_ride_request_model.dart';
import '../person/navigate_to_person_screen.dart';

/// Profile tab — Rider module.
///
/// Pure UI screen (no backend yet): every field below is local mock data
/// mirroring the reference design. Wire up a real RiderProfileRepository /
/// Riverpod-or-GetX provider later — the section builders are already
/// split out so swapping mock fields for provider data is a small, local
/// change. Follows the same black-header + curved-white-sheet pattern as
/// the Earnings tab.
///
/// Reached as a bottom-nav tab in RiderShell — there's no Navigator route
/// to pop, so the back button falls back to riderTabIndexProvider (same
/// fix as EarningsScreen / AvailableRequestsScreen).
///
/// NOTE: the "Performance Summary" grid was removed from this screen — it
/// duplicates what "View Dashboard" already shows (see _DashboardScreen
/// below), so there's no need to render it twice.
class RiderProfileScreen extends ConsumerStatefulWidget {
  const RiderProfileScreen({super.key});

  @override
  ConsumerState<RiderProfileScreen> createState() => _RiderProfileScreenState();
}

class _RiderProfileScreenState extends ConsumerState<RiderProfileScreen>
    with TickerProviderStateMixin {
  late final AnimationController _entrance;
  final ImagePicker _picker = ImagePicker();

  // ---- Mock rider profile data ---------------------------------------
  String _name = 'Karthik R';
  final String _riderId = 'RENTO-RDR-00412';
  double _rating = 4.8;
  int _totalTrips = 128;
  int _completedTrips = 125;
  double _successRate = 98;

  String _phone = '+91 98765 43210';
  String _email = 'karthik.rider@gmail.com';
  String _vehicleNumber = 'TN 09 AB 1234';
  String _vehicleType = '2 Wheeler';
  String _drivingLicense = 'TN09 20210012345';
  final String _licenseValidTill = '12 Jan 2027';
  final String _joiningDate = '12 March 2023';

  String _bankHolder = 'Karthik R';
  String _bankAccountNumber = '••••••••4242';
  String _ifsc = 'HDFC0001234';

  double _walletBalance = 2750;
  bool _autoPayout = true;
  String _payoutFrequency = 'Weekly';

  bool _notifTrips = true;
  bool _notifPromos = false;
  bool _notifPayouts = true;
  String _language = 'English';

  // Selected profile photo, picked via image_picker. Stored as raw bytes
  // (not a File) so this works on Flutter Web too — Image.file throws on
  // web since there's no real filesystem there. Null == no photo yet,
  // falls back to the initial-letter avatar.
  Uint8List? _profileImageBytes;

  static const List<_DocumentItem> _documents = [
    _DocumentItem(
      icon: Icons.badge_outlined,
      label: 'Aadhaar Card',
      status: 'Verified',
      valid: true,
      detail: 'Uploaded 12 March 2023 · Verified 14 March 2023',
    ),
    _DocumentItem(
      icon: Icons.credit_card,
      label: 'Driving License',
      status: 'Verified',
      valid: true,
      detail: 'Valid till 12 Jan 2027',
    ),
    _DocumentItem(
      icon: Icons.directions_car_outlined,
      label: 'Vehicle RC',
      status: 'Verified',
      valid: true,
      detail: 'Registered TN 09 AB 1234',
    ),
    _DocumentItem(
      icon: Icons.shield_outlined,
      label: 'Insurance',
      status: 'Valid till 10 Dec 2025',
      valid: true,
      detail: 'Policy renews automatically 30 days before expiry',
    ),
  ];

  static const List<_WalletTxn> _walletHistory = [
    _WalletTxn(
      title: 'Withdrawal to Bank',
      subtitle: 'HDFC •••• 4242',
      amount: -2000,
      date: '4 July, 2026',
      credit: false,
    ),
    _WalletTxn(
      title: 'Trip Earnings Credited',
      subtitle: 'Week of 30 June – 6 July',
      amount: 3120,
      date: '3 July, 2026',
      credit: true,
    ),
    _WalletTxn(
      title: 'Withdrawal to Bank',
      subtitle: 'HDFC •••• 4242',
      amount: 2500,
      date: '27 June, 2026',
      credit: false,
    ),
    _WalletTxn(
      title: 'Trip Earnings Credited',
      subtitle: 'Week of 23 – 29 June',
      amount: 2890,
      date: '26 June, 2026',
      credit: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _entrance = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _entrance.dispose();
    super.dispose();
  }

  void _toast(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.primaryBlack,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Profile photo — opens the device file/gallery picker via image_picker.
  // ---------------------------------------------------------------------
  Future<void> _pickProfilePhoto() async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 800,
      );
      if (picked == null) return; // user cancelled the picker
      final bytes = await picked.readAsBytes();
      if (mounted) {
        setState(() => _profileImageBytes = bytes);
        _toast('Profile photo updated');
      }
    } catch (e) {
      if (mounted) _toast('Could not open photo picker');
    }
  }

  // ---------------------------------------------------------------------
  // Entrance animation helper — same staggered fade+slide as Earnings tab.
  // ---------------------------------------------------------------------
  // Section count reduced from 14 -> 12 after removing the Performance
  // Summary title + grid (that data now only lives in "View Dashboard").
  static const int _sectionCount = 12;

  Widget _fadeIn(int index, {required Widget child}) {
    final start = (index / _sectionCount) * 0.6;
    final end = (start + 0.4).clamp(0.0, 1.0);
    final curved = CurvedAnimation(
      parent: _entrance,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );
    return AnimatedBuilder(
      animation: curved,
      child: child,
      builder: (context, child) {
        return Opacity(
          opacity: curved.value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, (1 - curved.value) * 18),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      body: Column(
        children: [
          SafeArea(bottom: false, child: _buildCurvedHeaderBar(context)),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
              child: Container(
                color: const Color(0xFFF4F4F4),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _fadeIn(0, child: _buildProfileHeaderCard(context)),
                      const SizedBox(height: 22),
                      _fadeIn(1, child: _sectionTitle('Account Information')),
                      const SizedBox(height: 10),
                      _fadeIn(2, child: _buildAccountInfoCard()),
                      const SizedBox(height: 22),
                      _fadeIn(
                        3,
                        child: _sectionTitle(
                          'Documents',
                          action: 'View All',
                          onActionTap: () => _openDocuments(context),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _fadeIn(4, child: _buildDocumentsCard(context)),
                      const SizedBox(height: 22),
                      _fadeIn(5, child: _sectionTitle('Wallet & Payout')),
                      const SizedBox(height: 10),
                      _fadeIn(6, child: _buildWalletCard(context)),
                      const SizedBox(height: 12),
                      _fadeIn(7, child: _buildWalletLinksCard(context)),
                      const SizedBox(height: 22),
                      _fadeIn(8, child: _sectionTitle('Settings')),
                      const SizedBox(height: 10),
                      _fadeIn(9, child: _buildSettingsCard(context)),
                      const SizedBox(height: 22),
                      _fadeIn(10, child: _buildLogoutButton(context)),
                      const SizedBox(height: 14),
                      _fadeIn(11, child: _buildVersionFooter()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Curved black header bar (back button, title, edit action)
  // ---------------------------------------------------------------------
  Widget _buildCurvedHeaderBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 12, 16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.pureWhite),
            tooltip: 'Back',
            // FIX — Profile is always a bottom-nav TAB inside RiderShell,
            // never a separately pushed route. canPop() was true here
            // because of whatever sits underneath RiderShell in the
            // navigator stack (Mobile Entry, etc.), so pop() was popping
            // the entire shell instead of just switching tabs — that's
            // what caused the blank/broken-route screen. Always just
            // switch RiderShell back to the Home tab.
            onPressed: () {
              ref.read(riderTabIndexProvider.notifier).state = 0;
            },
          ),
          const Expanded(
            child: Text(
              'Profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.pureWhite,
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
          ),
          _HoverPressable(
            onTap: () => _openEditProfile(context),
            child: Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.pureWhite.withOpacity(0.4)),
              ),
              child: const Icon(
                Icons.edit_outlined,
                color: AppColors.pureWhite,
                size: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Profile header card: avatar, name, id, rating/trips, verified badge,
  // View Dashboard / Edit Profile actions.
  // ---------------------------------------------------------------------
  Widget _buildProfileHeaderCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.85, end: 1),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutBack,
                builder: (context, scale, child) =>
                    Transform.scale(scale: scale, child: child),
                child: Container(
                  width: 84,
                  height: 84,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryBlack,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  clipBehavior: Clip.antiAlias,
                  child: _profileImageBytes != null
                      ? ClipOval(
                          child: Image.memory(
                            _profileImageBytes!,
                            width: 84,
                            height: 84,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Text(
                          _name.trim().isNotEmpty
                              ? _name.trim()[0].toUpperCase()
                              : '?',
                          style: const TextStyle(
                            color: AppColors.pureWhite,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              Positioned(
                right: -2,
                bottom: -2,
                child: _HoverPressable(
                  // Tapping the camera badge now opens the device's file /
                  // gallery picker (image_picker) instead of just a toast.
                  onTap: () => _pickProfilePhoto(),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.pureWhite,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      size: 14,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            _name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'ID: $_riderId',
            style: const TextStyle(fontSize: 12, color: AppColors.textHint),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.star_rounded,
                size: 16,
                color: Color(0xFFF5A623),
              ),
              const SizedBox(width: 3),
              Text(
                '$_rating Rating',
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 14),
              Text(
                '$_totalTrips Trips',
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, size: 14, color: AppColors.success),
                SizedBox(width: 5),
                Text(
                  'Verified Rider',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _HoverPressable(
                  onTap: () => _openDashboard(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.inputFill,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.bar_chart, size: 15),
                        SizedBox(width: 6),
                        Text(
                          'View Dashboard',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _HoverPressable(
                  onTap: () => _openEditProfile(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlack,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.edit_outlined,
                          size: 14,
                          color: AppColors.pureWhite,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: AppColors.pureWhite,
                            fontWeight: FontWeight.w700,
                            fontSize: 12.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Section title helper (reused for every section on this page)
  // ---------------------------------------------------------------------
  Widget _sectionTitle(
    String title, {
    String? action,
    VoidCallback? onActionTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        if (action != null)
          _HoverPressable(
            onTap: onActionTap ?? () => _toast('$action — coming soon'),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  action,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
      ],
    );
  }

  // ---------------------------------------------------------------------
  // Account Information card
  // ---------------------------------------------------------------------
  Widget _buildAccountInfoCard() {
    final rows = [
      _InfoRowData(
        Icons.phone_outlined,
        const Color(0xFF4A90E2),
        'Phone Number',
        _phone,
      ),
      _InfoRowData(
        Icons.mail_outline,
        const Color(0xFFE86AA6),
        'Email',
        _email,
      ),
      _InfoRowData(
        Icons.directions_car_outlined,
        const Color(0xFFF5A623),
        'Vehicle Number',
        _vehicleNumber,
      ),
      _InfoRowData(
        Icons.category_outlined,
        const Color(0xFF2ECC71),
        'Vehicle Type',
        _vehicleType,
      ),
      _InfoRowData(
        Icons.badge_outlined,
        const Color(0xFF6C5CE7),
        'Driving License',
        '$_drivingLicense · Valid till $_licenseValidTill',
      ),
      _InfoRowData(
        Icons.event_outlined,
        const Color(0xFF888888),
        'Joining Date',
        _joiningDate,
      ),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: List.generate(rows.length, (i) {
          final row = rows[i];
          final isLast = i == rows.length - 1;
          return Column(
            children: [
              _infoRow(row.icon, row.iconColor, row.label, row.value),
              if (!isLast) const Divider(height: 1, color: AppColors.divider),
            ],
          );
        }),
      ),
    );
  }

  Widget _infoRow(
    IconData icon,
    Color iconColor,
    String label,
    String value, {
    VoidCallback? onTap,
  }) {
    return _HoverPressable(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 16, color: iconColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: AppColors.textHint,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              const Icon(
                Icons.chevron_right,
                size: 18,
                color: AppColors.textHint,
              ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Documents card (preview — first few, "View All" opens the full list)
  // ---------------------------------------------------------------------
  Widget _buildDocumentsCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: List.generate(_documents.length, (i) {
          final doc = _documents[i];
          final isLast = i == _documents.length - 1;
          return Column(
            children: [
              _documentRow(context, doc),
              if (!isLast) const Divider(height: 1, color: AppColors.divider),
            ],
          );
        }),
      ),
    );
  }

  Widget _documentRow(BuildContext context, _DocumentItem doc) {
    return _HoverPressable(
      onTap: () => _showDocumentDetail(context, doc),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: AppColors.inputFill,
                shape: BoxShape.circle,
              ),
              child: Icon(doc.icon, size: 16, color: AppColors.textPrimary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                doc.label,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Icon(
              doc.valid ? Icons.check_circle : Icons.error_outline,
              size: 15,
              color: doc.valid ? AppColors.success : Colors.orange,
            ),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                doc.status,
                textAlign: TextAlign.right,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: doc.valid ? AppColors.success : Colors.orange[800],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDocumentDetail(BuildContext context, _DocumentItem doc) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 18),
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(doc.icon, size: 20, color: AppColors.textPrimary),
                  const SizedBox(width: 10),
                  Text(
                    doc.label,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                doc.status,
                style: TextStyle(
                  color: doc.valid ? AppColors.success : Colors.orange[800],
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                doc.detail,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    _toast('Re-upload ${doc.label} — coming soon');
                  },
                  child: const Text(
                    'Re-upload Document',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openDocuments(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _DocumentsListScreen(
          documents: _documents,
          onTapDocument: _showDocumentDetail,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Wallet balance card (black, matches Earnings hero-card styling)
  // ---------------------------------------------------------------------
  Widget _buildWalletCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryBlack,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlack.withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'WALLET BALANCE',
            style: TextStyle(
              color: AppColors.textHint,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 8),
          _AnimatedCounter(
            animation: _entrance,
            target: _walletBalance,
            prefix: '₹',
            decimals: 2,
            style: const TextStyle(
              color: AppColors.pureWhite,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              height: 1,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _HoverPressable(
                  onTap: () => _showWithdrawSheet(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    decoration: BoxDecoration(
                      color: AppColors.pureWhite,
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.account_balance_wallet_outlined, size: 15),
                        SizedBox(width: 6),
                        Text(
                          'Withdraw',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _HoverPressable(
                  onTap: () => _openWalletHistory(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    decoration: BoxDecoration(
                      color: AppColors.pureWhite.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.history_rounded,
                          size: 15,
                          color: AppColors.pureWhite,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'History',
                          style: TextStyle(
                            color: AppColors.pureWhite,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showWithdrawSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 18),
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const Text(
                'Withdraw',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 6),
              Text(
                '₹${_walletBalance.toStringAsFixed(2)} will be transferred to '
                'your linked bank account $_bankAccountNumber within 24 hours.',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlack,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    setState(() => _walletBalance = 0);
                    _toast('Withdrawal requested — funds arrive within 24h');
                  },
                  child: const Text(
                    'Confirm Withdrawal',
                    style: TextStyle(
                      color: AppColors.pureWhite,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openWalletHistory(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            const _WalletHistoryScreen(transactions: _walletHistory),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Wallet links card: Bank Account / Payout Settings / Transaction History
  // ---------------------------------------------------------------------
  Widget _buildWalletLinksCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _infoRow(
            Icons.account_balance_outlined,
            const Color(0xFF4A90E2),
            'Bank Account',
            '•••• ${_bankAccountNumber.substring(_bankAccountNumber.length - 4)}',
            onTap: () => _openBankAccount(context),
          ),
          const Divider(height: 1, color: AppColors.divider),
          _infoRow(
            Icons.tune,
            const Color(0xFF6C5CE7),
            'Withdraw Settings',
            _autoPayout ? 'Auto · $_payoutFrequency' : 'Manual',
            onTap: () => _openPayoutSettings(context),
          ),
          const Divider(height: 1, color: AppColors.divider),
          _infoRow(
            Icons.list_alt_outlined,
            const Color(0xFF2ECC71),
            'Transaction History',
            '${_walletHistory.length} recent transactions',
            onTap: () => _openWalletHistory(context),
          ),
        ],
      ),
    );
  }

  Future<void> _openBankAccount(BuildContext context) async {
    final result = await Navigator.of(context).push<Map<String, String>>(
      MaterialPageRoute(
        builder: (_) => _BankAccountScreen(
          holder: _bankHolder,
          accountNumber: _bankAccountNumber,
          ifsc: _ifsc,
        ),
      ),
    );
    if (result != null && mounted) {
      setState(() {
        _bankHolder = result['holder'] ?? _bankHolder;
        _bankAccountNumber = result['accountNumber'] ?? _bankAccountNumber;
        _ifsc = result['ifsc'] ?? _ifsc;
      });
      _toast('Bank details updated');
    }
  }

  Future<void> _openPayoutSettings(BuildContext context) async {
    final result = await Navigator.of(context).push<Map<String, dynamic>>(
      MaterialPageRoute(
        builder: (_) => _PayoutSettingsScreen(
          autoPayout: _autoPayout,
          frequency: _payoutFrequency,
        ),
      ),
    );
    if (result != null && mounted) {
      setState(() {
        _autoPayout = result['autoPayout'] as bool? ?? _autoPayout;
        _payoutFrequency = result['frequency'] as String? ?? _payoutFrequency;
      });
      _toast('Withdraw settings saved');
    }
  }

  // ---------------------------------------------------------------------
  // Settings card
  // ---------------------------------------------------------------------
  Widget _buildSettingsCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _infoRow(
            Icons.notifications_none,
            const Color(0xFFF5A623),
            'Notification Settings',
            _notifTrips || _notifPromos || _notifPayouts ? 'On' : 'Off',
            onTap: () => _openNotificationSettings(context),
          ),
          const Divider(height: 1, color: AppColors.divider),
          _infoRow(
            Icons.language,
            const Color(0xFF4A90E2),
            'Language',
            _language,
            onTap: () => _pickLanguage(context),
          ),
          const Divider(height: 1, color: AppColors.divider),
          _infoRow(
            Icons.help_outline,
            const Color(0xFF6C5CE7),
            'Help & Support',
            'FAQs & contact',
            onTap: () => _showHelpSheet(context),
          ),
          const Divider(height: 1, color: AppColors.divider),
          _infoRow(
            Icons.description_outlined,
            const Color(0xFF888888),
            'Terms & Conditions',
            '',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const _StaticTextScreen(
                  title: 'Terms & Conditions',
                  body: _termsText,
                ),
              ),
            ),
          ),
          const Divider(height: 1, color: AppColors.divider),
          _infoRow(
            Icons.lock_outline,
            const Color(0xFFE86AA6),
            'Privacy Policy',
            '',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const _StaticTextScreen(
                  title: 'Privacy Policy',
                  body: _privacyText,
                ),
              ),
            ),
          ),
          const Divider(height: 1, color: AppColors.divider),
          // TEMP: preview-only row for the parcel navigation flow.
          // Remove once parcel requests are wired into the real
          // accept flow in rider_shell.dart (mirroring how
          // NavigateToVendorScreen is triggered there today).
          _infoRow(
            Icons.local_shipping_outlined,
            const Color(0xFF2ECC71),
            'Preview: Parcel Flow',
            'Dev only',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => NavigateToParcelScreen(
                  request: kDemoParcelRequest,
                  stage: ParcelNavigationStage.toSender,
                ),
              ),
            ),
          ),
          const Divider(height: 1, color: AppColors.divider),
          // TEMP: preview-only row for the person-ride navigation flow.
          // Remove once person-ride requests are wired into the real
          // accept flow in rider_shell.dart.
          _infoRow(
            Icons.directions_car_filled_outlined,
            const Color(0xFF4A90E2),
            'Preview: Person Ride Flow',
            'Dev only',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) =>
                    NavigateToPersonScreen(request: kDemoPersonRideRequest),
              ),
            ),
          ),
          const Divider(height: 1, color: AppColors.divider),
          _infoRow(
            Icons.info_outline,
            const Color(0xFF2ECC71),
            'About App',
            'v2.4.1',
            onTap: () => _showAboutDialog(context),
          ),
        ],
      ),
    );
  }

  Future<void> _openNotificationSettings(BuildContext context) async {
    final result = await Navigator.of(context).push<Map<String, bool>>(
      MaterialPageRoute(
        builder: (_) => _NotificationSettingsScreen(
          trips: _notifTrips,
          promos: _notifPromos,
          payouts: _notifPayouts,
        ),
      ),
    );
    if (result != null && mounted) {
      setState(() {
        _notifTrips = result['trips'] ?? _notifTrips;
        _notifPromos = result['promos'] ?? _notifPromos;
        _notifPayouts = result['payouts'] ?? _notifPayouts;
      });
      _toast('Notification preferences saved');
    }
  }

  Future<void> _pickLanguage(BuildContext context) async {
    const options = [
      'English',
      'हिन्दी (Hindi)',
      'தமிழ் (Tamil)',
      'తెలుగు (Telugu)',
    ];
    final picked = await showDialog<String>(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Choose Language'),
        children: options
            .map(
              (lang) => RadioListTile<String>(
                value: lang,
                groupValue: _language,
                activeColor: AppColors.primaryBlack,
                title: Text(lang),
                onChanged: (value) => Navigator.pop(dialogContext, value),
              ),
            )
            .toList(),
      ),
    );
    if (picked != null && mounted) {
      setState(() => _language = picked);
      _toast('Language set to $picked');
    }
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Rento India Rider'),
        content: const Text(
          'Version 2.4.1 (Build 2026.07)\n\n'
          'Rento India connects riders with rental pickup, delivery, and '
          'return jobs across the city.',
          style: TextStyle(height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showHelpSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        final maxHeight = MediaQuery.of(sheetContext).size.height * 0.85;
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(22),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 18),
                      decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const Text(
                    'Help & Support',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  _helpItem(
                    'How do I update my documents?',
                    'Go to Documents → tap the document → Re-upload '
                        'Document. Verification usually takes under 24 hours.',
                  ),
                  _helpItem(
                    'How do I change my bank account?',
                    'Go to Wallet & Payout → Bank Account → Edit, then '
                        'save your new account details.',
                  ),
                  _helpItem(
                    'Who do I contact for a trip issue?',
                    'Use "Contact Support" from the Help & Support menu, '
                        'or reach the in-app support chat from your trip '
                        'details screen.',
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(sheetContext);
                        _toast('Opening support chat — coming soon');
                      },
                      child: const Text(
                        'Contact Support',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _helpItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            answer,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Edit profile / view dashboard
  // ---------------------------------------------------------------------
  Future<void> _openEditProfile(BuildContext context) async {
    final result = await Navigator.of(context).push<Map<String, String>>(
      MaterialPageRoute(
        builder: (_) => _EditProfileScreen(
          name: _name,
          phone: _phone,
          email: _email,
          vehicleNumber: _vehicleNumber,
          vehicleType: _vehicleType,
          drivingLicense: _drivingLicense,
        ),
      ),
    );
    if (result != null && mounted) {
      setState(() {
        _name = result['name'] ?? _name;
        _phone = result['phone'] ?? _phone;
        _email = result['email'] ?? _email;
        _vehicleNumber = result['vehicleNumber'] ?? _vehicleNumber;
        _vehicleType = result['vehicleType'] ?? _vehicleType;
        _drivingLicense = result['drivingLicense'] ?? _drivingLicense;
      });
      _toast('Profile updated');
    }
  }

  void _openDashboard(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _DashboardScreen(
          totalTrips: _totalTrips,
          completedTrips: _completedTrips,
          rating: _rating,
          successRate: _successRate,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Log out
  // ---------------------------------------------------------------------
  Widget _buildLogoutButton(BuildContext context) {
    return _HoverPressable(
      onTap: () => _confirmLogout(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.logout_rounded, size: 17, color: Colors.redAccent),
            SizedBox(width: 8),
            Text(
              'Log Out',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Log Out?'),
        content: const Text(
          'You\'ll need to verify your mobile number again to sign back in.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text(
              'Log Out',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      // TODO: wire this to the real auth/session controller
      // (e.g. Get.find<AuthController>().logout()) once the backend
      // and login flow are connected.
      // ⭐ FIX — route.isFirst popped to whatever sits at the very
      // bottom of the navigator stack instead of actually logging out;
      // this now clears the whole stack and sends the rider back to
      // Mobile Entry, same as the drawer's Log Out action.
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(RouteNames.mobileEntry, (route) => false);
      _toast('Logged out');
    }
  }

  Widget _buildVersionFooter() {
    return const Center(
      child: Text(
        'Rento India Rider v2.4.1 · Build 2026.07',
        style: TextStyle(fontSize: 11, color: AppColors.textHint),
      ),
    );
  }
}

// =============================================================================
// Full Documents list screen ("View All")
// =============================================================================
class _DocumentsListScreen extends StatelessWidget {
  final List<_DocumentItem> documents;
  final void Function(BuildContext, _DocumentItem) onTapDocument;

  const _DocumentsListScreen({
    required this.documents,
    required this.onTapDocument,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F4F4),
        elevation: 0,
        title: const Text(
          'Documents',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SafeArea(
        top: false,
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
          itemCount: documents.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, i) {
            final doc = documents[i];
            return _HoverPressable(
              onTap: () => onTapDocument(context, doc),
              liftOnHover: true,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: AppColors.inputFill,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        doc.icon,
                        size: 18,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doc.label,
                            style: const TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            doc.status,
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: doc.valid
                                  ? AppColors.success
                                  : Colors.orange[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      size: 18,
                      color: AppColors.textHint,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// =============================================================================
// Wallet transaction history screen
// =============================================================================
class _WalletHistoryScreen extends StatelessWidget {
  final List<_WalletTxn> transactions;

  const _WalletHistoryScreen({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F4F4),
        elevation: 0,
        title: const Text(
          'Wallet History',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SafeArea(
        top: false,
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
          itemCount: transactions.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, i) {
            final txn = transactions[i];
            return Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: (txn.credit ? AppColors.success : Colors.redAccent)
                          .withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      txn.credit
                          ? Icons.arrow_downward_rounded
                          : Icons.arrow_upward_rounded,
                      size: 18,
                      color: txn.credit ? AppColors.success : Colors.redAccent,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          txn.title,
                          style: const TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          txn.subtitle,
                          style: const TextStyle(
                            fontSize: 11.5,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${txn.credit ? '+' : '-'}₹${txn.amount.abs()}',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                          color: txn.credit
                              ? AppColors.success
                              : Colors.redAccent,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        txn.date,
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.textHint,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// =============================================================================
// Edit Profile screen
// =============================================================================
class _EditProfileScreen extends StatefulWidget {
  final String name;
  final String phone;
  final String email;
  final String vehicleNumber;
  final String vehicleType;
  final String drivingLicense;

  const _EditProfileScreen({
    required this.name,
    required this.phone,
    required this.email,
    required this.vehicleNumber,
    required this.vehicleType,
    required this.drivingLicense,
  });

  @override
  State<_EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<_EditProfileScreen> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _vehicleNumberCtrl;
  late final TextEditingController _vehicleTypeCtrl;
  late final TextEditingController _licenseCtrl;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.name);
    _phoneCtrl = TextEditingController(text: widget.phone);
    _emailCtrl = TextEditingController(text: widget.email);
    _vehicleNumberCtrl = TextEditingController(text: widget.vehicleNumber);
    _vehicleTypeCtrl = TextEditingController(text: widget.vehicleType);
    _licenseCtrl = TextEditingController(text: widget.drivingLicense);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _vehicleNumberCtrl.dispose();
    _vehicleTypeCtrl.dispose();
    _licenseCtrl.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: AppColors.inputFill,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(context, {
      'name': _nameCtrl.text.trim(),
      'phone': _phoneCtrl.text.trim(),
      'email': _emailCtrl.text.trim(),
      'vehicleNumber': _vehicleNumberCtrl.text.trim(),
      'vehicleType': _vehicleTypeCtrl.text.trim(),
      'drivingLicense': _licenseCtrl.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F4F4),
        elevation: 0,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SafeArea(
        top: false,
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: _decoration('Full Name'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: _decoration('Phone Number'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: _decoration('Email'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _vehicleNumberCtrl,
                decoration: _decoration('Vehicle Number'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _vehicleTypeCtrl,
                decoration: _decoration('Vehicle Type'),
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _licenseCtrl,
                decoration: _decoration('Driving License Number'),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlack,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                    elevation: 0,
                  ),
                  onPressed: _save,
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(
                      color: AppColors.pureWhite,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// Performance dashboard screen ("View Dashboard")
// This is the ONLY place Total Trips / Completed / Rating / Success Rate
// are shown now — the duplicate grid on the main Profile screen was removed.
// =============================================================================
class _DashboardScreen extends StatelessWidget {
  final int totalTrips;
  final int completedTrips;
  final double rating;
  final double successRate;

  const _DashboardScreen({
    required this.totalTrips,
    required this.completedTrips,
    required this.rating,
    required this.successRate,
  });

  @override
  Widget build(BuildContext context) {
    final tiles = [
      _StatCardData(
        icon: Icons.map_outlined,
        iconColor: AppColors.textPrimary,
        value: '$totalTrips',
        label: 'Total Trips',
      ),
      _StatCardData(
        icon: Icons.check_circle_outline,
        iconColor: AppColors.success,
        value: '$completedTrips',
        label: 'Completed Trips',
      ),
      _StatCardData(
        icon: Icons.star_rounded,
        iconColor: const Color(0xFFF5A623),
        value: '$rating',
        label: 'Average Rating',
      ),
      _StatCardData(
        icon: Icons.bolt_outlined,
        iconColor: const Color(0xFF6C5CE7),
        value: '${successRate.toStringAsFixed(0)}%',
        label: 'Success Rate',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F4F4),
        elevation: 0,
        title: const Text(
          'Performance Dashboard',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SafeArea(
        top: false,
        child: GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
          itemCount: tiles.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            mainAxisExtent: 120,
          ),
          itemBuilder: (context, i) {
            final tile = tiles[i];
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: tile.iconColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(tile.icon, size: 18, color: tile.iconColor),
                  ),
                  Text(
                    tile.value,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    tile.label,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textHint,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// =============================================================================
// Bank account screen
// =============================================================================
class _BankAccountScreen extends StatefulWidget {
  final String holder;
  final String accountNumber;
  final String ifsc;

  const _BankAccountScreen({
    required this.holder,
    required this.accountNumber,
    required this.ifsc,
  });

  @override
  State<_BankAccountScreen> createState() => _BankAccountScreenState();
}

class _BankAccountScreenState extends State<_BankAccountScreen> {
  late String _holder = widget.holder;
  late String _accountNumber = widget.accountNumber;
  late String _ifsc = widget.ifsc;

  Future<void> _editDetails(BuildContext context) async {
    final holderCtrl = TextEditingController(text: _holder);
    final accountCtrl = TextEditingController(text: _accountNumber);
    final ifscCtrl = TextEditingController(text: _ifsc);

    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Edit Bank Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: holderCtrl,
              decoration: const InputDecoration(labelText: 'Account Holder'),
            ),
            TextField(
              controller: accountCtrl,
              decoration: const InputDecoration(labelText: 'Account Number'),
            ),
            TextField(
              controller: ifscCtrl,
              decoration: const InputDecoration(labelText: 'IFSC Code'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (result == true) {
      setState(() {
        _holder = holderCtrl.text.trim();
        _accountNumber = accountCtrl.text.trim();
        _ifsc = ifscCtrl.text.trim();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F4F4),
        elevation: 0,
        title: const Text(
          'Bank Account',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _bankLine('Account Holder', _holder),
                    const Divider(height: 24, color: AppColors.divider),
                    _bankLine('Account Number', _accountNumber),
                    const Divider(height: 24, color: AppColors.divider),
                    _bankLine('IFSC Code', _ifsc),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 50,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () => _editDetails(context),
                  child: const Text(
                    'Edit Bank Details',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlack,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () => Navigator.pop(context, {
                    'holder': _holder,
                    'accountNumber': _accountNumber,
                    'ifsc': _ifsc,
                  }),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      color: AppColors.pureWhite,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bankLine(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11.5, color: AppColors.textHint),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// Payout settings screen
// =============================================================================
class _PayoutSettingsScreen extends StatefulWidget {
  final bool autoPayout;
  final String frequency;

  const _PayoutSettingsScreen({
    required this.autoPayout,
    required this.frequency,
  });

  @override
  State<_PayoutSettingsScreen> createState() => _PayoutSettingsScreenState();
}

class _PayoutSettingsScreenState extends State<_PayoutSettingsScreen> {
  late bool _autoPayout = widget.autoPayout;
  late String _frequency = widget.frequency;

  static const _frequencies = ['Daily', 'Weekly', 'Monthly'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F4F4),
        elevation: 0,
        title: const Text(
          'Withdraw Settings',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: SwitchListTile(
                  activeColor: AppColors.primaryBlack,
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'Enable Auto Payout',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  subtitle: const Text(
                    'Automatically send earnings to your bank account',
                    style: TextStyle(fontSize: 12),
                  ),
                  value: _autoPayout,
                  onChanged: (v) => setState(() => _autoPayout = v),
                ),
              ),
              const SizedBox(height: 16),
              if (_autoPayout) ...[
                const Text(
                  'Payout Frequency',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 10),
                ..._frequencies.map(
                  (freq) => Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: AppColors.pureWhite,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: RadioListTile<String>(
                      activeColor: AppColors.primaryBlack,
                      value: freq,
                      groupValue: _frequency,
                      title: Text(freq),
                      onChanged: (v) => setState(() => _frequency = v!),
                    ),
                  ),
                ),
              ],
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlack,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () => Navigator.pop(context, {
                    'autoPayout': _autoPayout,
                    'frequency': _frequency,
                  }),
                  child: const Text(
                    'Save Settings',
                    style: TextStyle(
                      color: AppColors.pureWhite,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// Notification settings screen
// =============================================================================
class _NotificationSettingsScreen extends StatefulWidget {
  final bool trips;
  final bool promos;
  final bool payouts;

  const _NotificationSettingsScreen({
    required this.trips,
    required this.promos,
    required this.payouts,
  });

  @override
  State<_NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<_NotificationSettingsScreen> {
  late bool _trips = widget.trips;
  late bool _promos = widget.promos;
  late bool _payouts = widget.payouts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F4F4),
        elevation: 0,
        title: const Text(
          'Notification Settings',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    SwitchListTile(
                      activeColor: AppColors.primaryBlack,
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Trip Updates',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: const Text(
                        'Pickup, delivery, and return alerts',
                        style: TextStyle(fontSize: 12),
                      ),
                      value: _trips,
                      onChanged: (v) => setState(() => _trips = v),
                    ),
                    const Divider(height: 1, color: AppColors.divider),
                    SwitchListTile(
                      activeColor: AppColors.primaryBlack,
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Promotions & Offers',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: const Text(
                        'Bonus campaigns and incentives',
                        style: TextStyle(fontSize: 12),
                      ),
                      value: _promos,
                      onChanged: (v) => setState(() => _promos = v),
                    ),
                    const Divider(height: 1, color: AppColors.divider),
                    SwitchListTile(
                      activeColor: AppColors.primaryBlack,
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Payout Alerts',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: const Text(
                        'Wallet credits and withdrawals',
                        style: TextStyle(fontSize: 12),
                      ),
                      value: _payouts,
                      onChanged: (v) => setState(() => _payouts = v),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlack,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () => Navigator.pop(context, {
                    'trips': _trips,
                    'promos': _promos,
                    'payouts': _payouts,
                  }),
                  child: const Text(
                    'Save Preferences',
                    style: TextStyle(
                      color: AppColors.pureWhite,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// Static text screen (Terms & Conditions / Privacy Policy)
// =============================================================================
class _StaticTextScreen extends StatelessWidget {
  final String title;
  final String body;

  const _StaticTextScreen({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F4F4),
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Text(
            body,
            style: const TextStyle(
              fontSize: 13.5,
              color: AppColors.textSecondary,
              height: 1.55,
            ),
          ),
        ),
      ),
    );
  }
}

const String _termsText =
    'These Terms & Conditions govern your use of the Rento India Rider '
    'app. By registering as a rider, you agree to complete pickup, '
    'delivery, and return trips in accordance with the schedules and '
    'routes assigned to you, to maintain valid documents (driving '
    'license, vehicle RC, and insurance) at all times, and to represent '
    'trip and earnings information accurately.\n\n'
    'Rento India reserves the right to suspend or deactivate a rider '
    'account for repeated cancellations, safety violations, or '
    'fraudulent activity. Earnings, bonuses, and incentive structures '
    'are subject to change with prior notice.\n\n'
    'This is placeholder legal text — replace with the finalized rider '
    'agreement before release.';

const String _privacyText =
    'Rento India collects the information you provide during KYC '
    '(identity documents, vehicle details, bank information) and the '
    'location data required to route pickups, deliveries, and returns.\n\n'
    'This data is used to verify your identity, process payouts, and '
    'improve trip routing. We do not sell rider data to third parties. '
    'Location access can be managed from your device settings, though '
    'disabling it will affect trip assignment.\n\n'
    'This is placeholder legal text — replace with the finalized privacy '
    'policy before release.';

// =============================================================================
// Shared reusable pieces (mirrors the Earnings tab's private widgets)
// =============================================================================

/// Wraps a tappable widget with a hover-lift effect (mouse, on web/desktop)
/// and a press-scale effect (touch, on mobile).
class _HoverPressable extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool liftOnHover;

  const _HoverPressable({
    required this.child,
    this.onTap,
    this.liftOnHover = false,
  });

  @override
  State<_HoverPressable> createState() => _HoverPressableState();
}

class _HoverPressableState extends State<_HoverPressable> {
  bool _hovering = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final scale = _pressed ? 0.96 : (_hovering ? 1.02 : 1.0);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              boxShadow: (_hovering && widget.liftOnHover)
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : const [],
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

/// Animates a numeric value counting up from 0 to [target].
class _AnimatedCounter extends StatelessWidget {
  final Animation<double> animation;
  final double target;
  final String prefix;
  final int decimals;
  final TextStyle style;

  const _AnimatedCounter({
    required this.animation,
    required this.target,
    required this.style,
    this.prefix = '',
    this.decimals = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final value = (target * animation.value).clamp(0, target);
        final display = decimals == 0
            ? value.round().toString()
            : value.toStringAsFixed(decimals);
        return Text('$prefix${_thousands(display)}', style: style);
      },
    );
  }

  String _thousands(String number) {
    final parts = number.split('.');
    final isNegative = parts[0].startsWith('-');
    final digits = isNegative ? parts[0].substring(1) : parts[0];
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      final posFromEnd = digits.length - i;
      buffer.write(digits[i]);
      if (posFromEnd > 1 && posFromEnd % 3 == 1) {
        buffer.write(',');
      }
    }
    final whole = '${isNegative ? '-' : ''}$buffer';
    return parts.length > 1 ? '$whole.${parts[1]}' : whole;
  }
}

// =============================================================================
// Mock data models
// =============================================================================

class _DocumentItem {
  final IconData icon;
  final String label;
  final String status;
  final bool valid;
  final String detail;
  const _DocumentItem({
    required this.icon,
    required this.label,
    required this.status,
    required this.valid,
    required this.detail,
  });
}

class _WalletTxn {
  final String title;
  final String subtitle;
  final int amount;
  final String date;
  final bool credit;
  const _WalletTxn({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.credit,
  });
}

class _StatCardData {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;
  const _StatCardData({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });
}

class _InfoRowData {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  const _InfoRowData(this.icon, this.iconColor, this.label, this.value);
}

