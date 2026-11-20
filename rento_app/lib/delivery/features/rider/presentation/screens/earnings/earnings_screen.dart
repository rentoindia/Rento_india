// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../../core/constants/app_colors.dart';
// import '../../../providers/rider_tab_provider.dart';
// import '../notifications/notifications_screen.dart';

// /// Earnings tab — Rider module.
// ///
// /// Pure UI screen (no backend yet): every figure below is local mock data
// /// mirroring the reference design. Wire up a real EarningsRepository /
// /// Riverpod provider later; the section builders are already split out
// /// so swapping mock lists for provider data is a small, local change.
// ///
// /// Reached two ways: as a bottom-nav tab in RiderShell (no Navigator route
// /// to pop — back button falls through to riderTabIndexProvider) and as a
// /// pushed route from TripsListScreen's daily-earnings card (a real route
// /// to pop). The back button below checks canPop() to handle both.
// class EarningsScreen extends ConsumerStatefulWidget {
//   const EarningsScreen({super.key});

//   @override
//   ConsumerState<EarningsScreen> createState() => _EarningsScreenState();
// }

// class _EarningsScreenState extends ConsumerState<EarningsScreen>
//     with TickerProviderStateMixin {
//   late final AnimationController _entrance;
//   bool _showMonthly = false;
//   DateTimeRange? _selectedRange;

//   // ---- Mock data -----------------------------------------------------
//   static const List<_CreditRow> _creditBreakdown = [
//     _CreditRow('Pickup Reward', 60),
//     _CreditRow('Delivery Reward', 90),
//     _CreditRow('Return Trip', 80),
//     _CreditRow('Distance Bonus', 40),
//     _CreditRow('Peak Hour Bonus', 30),
//   ];

//   static const List<double> _weeklyValuesWeek = [
//     0.35,
//     0.5,
//     0.3,
//     0.55,
//     0.42,
//     1.0,
//     0.6,
//   ];
//   static const List<double> _weeklyValuesMonth = [0.5, 0.65, 0.8, 1.0];
//   static const _weekDayLabels = [
//     'Mon',
//     'Tue',
//     'Wed',
//     'Thu',
//     'Fri',
//     'Sat',
//     'Sun',
//   ];
//   static const _monthWeekLabels = ['Wk 1', 'Wk 2', 'Wk 3', 'Wk 4'];

//   static const List<_BreakdownItem> _earningsBreakdown = [
//     _BreakdownItem('Pickup Earnings', 1150, 2450),
//     _BreakdownItem('Delivery Earnings', 1650, 2450),
//     _BreakdownItem('Return Trips', 650, 2450),
//     _BreakdownItem('Bonuses', 400, 2450),
//     _BreakdownItem('Distance Incentives', 250, 2450),
//   ];

//   // Shown inline on the Earnings tab (most recent few).
//   static const List<_Transaction> _transactions = [
//     _Transaction(
//       id: '#2025001',
//       type: 'Pickup • Delivery • Return',
//       amount: 300,
//       status: _TxnStatus.credited,
//       customer: 'Arjun Mehta',
//       route: 'Andheri → Bandra',
//       time: '10:45 AM',
//       date: 'Today',
//     ),
//     _Transaction(
//       id: '#2025002',
//       type: 'Delivery + Return',
//       amount: 220,
//       status: _TxnStatus.credited,
//       customer: 'Priya Singh',
//       route: 'Powai → Thane',
//       time: '12:30 PM',
//       date: 'Today',
//     ),
//     _Transaction(
//       id: '#2025003',
//       type: 'Pickup Only',
//       amount: 180,
//       status: _TxnStatus.credited,
//       customer: 'Rahul Sharma',
//       route: 'Dadar → Kurla',
//       time: '2:15 PM',
//       date: 'Today',
//     ),
//     _Transaction(
//       id: '#2025004',
//       type: 'Delivery + Peak Bonus',
//       amount: 340,
//       status: _TxnStatus.processing,
//       customer: 'Sneha Kapoor',
//       route: 'Goregaon → Malad',
//       time: '4:00 PM',
//       date: 'Today',
//     ),
//   ];

//   // Full history shown on the "See All" screen — a superset of the above.
//   static const List<_Transaction> _allTransactions = [
//     ..._transactions,
//     _Transaction(
//       id: '#2024998',
//       type: 'Pickup + Return',
//       amount: 260,
//       status: _TxnStatus.credited,
//       customer: 'Karan Malhotra',
//       route: 'Vashi → Panvel',
//       time: '9:10 AM',
//       date: 'Yesterday',
//     ),
//     _Transaction(
//       id: '#2024991',
//       type: 'Delivery Only',
//       amount: 150,
//       status: _TxnStatus.credited,
//       customer: 'Neha Joshi',
//       route: 'Chembur → Sion',
//       time: '6:40 PM',
//       date: 'Yesterday',
//     ),
//     _Transaction(
//       id: '#2024987',
//       type: 'Pickup • Delivery • Return',
//       amount: 310,
//       status: _TxnStatus.credited,
//       customer: 'Vikram Rao',
//       route: 'Borivali → Malad',
//       time: '11:05 AM',
//       date: '9 July',
//     ),
//     _Transaction(
//       id: '#2024979',
//       type: 'Return Trip + Bonus',
//       amount: 190,
//       status: _TxnStatus.credited,
//       customer: 'Ananya Iyer',
//       route: 'Wadala → Byculla',
//       time: '3:50 PM',
//       date: '9 July',
//     ),
//     _Transaction(
//       id: '#2024965',
//       type: 'Delivery + Return',
//       amount: 240,
//       status: _TxnStatus.credited,
//       customer: 'Farhan Sheikh',
//       route: 'Kandivali → Andheri',
//       time: '1:20 PM',
//       date: '8 July',
//     ),
//     _Transaction(
//       id: '#2024958',
//       type: 'Pickup Only',
//       amount: 140,
//       status: _TxnStatus.credited,
//       customer: 'Divya Nair',
//       route: 'Mulund → Bhandup',
//       time: '5:05 PM',
//       date: '8 July',
//     ),
//   ];

//   static const List<_Achievement> _achievements = [
//     _Achievement(
//       icon: Icons.emoji_events_outlined,
//       title: 'Delivery Champion',
//       subtitle: 'Completed 200 Deliveries',
//       color: Color(0xFFF5A623),
//     ),
//     _Achievement(
//       icon: Icons.rocket_launch_outlined,
//       title: 'Top Performer',
//       subtitle: 'Highest Weekly Earnings',
//       color: Color(0xFF6C5CE7),
//     ),
//     _Achievement(
//       icon: Icons.star_outline,
//       title: '5-Star Rider',
//       subtitle: 'Maintained 4.9+ Rating',
//       color: Color(0xFF2ECC71),
//     ),
//   ];

//   // Mock payout history for the "Payment History" screen.
//   static const List<_Payout> _payouts = [
//     _Payout(
//       id: 'PYT-10245',
//       amount: 3120,
//       date: '4 July, 2025',
//       bankLast4: '4528',
//       status: 'Paid',
//     ),
//     _Payout(
//       id: 'PYT-10198',
//       amount: 2890,
//       date: '27 June, 2025',
//       bankLast4: '4528',
//       status: 'Paid',
//     ),
//     _Payout(
//       id: 'PYT-10151',
//       amount: 3340,
//       date: '20 June, 2025',
//       bankLast4: '4528',
//       status: 'Paid',
//     ),
//     _Payout(
//       id: 'PYT-10104',
//       amount: 2560,
//       date: '13 June, 2025',
//       bankLast4: '4528',
//       status: 'Paid',
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
//   // Date range ("week") picker — now wired to a real Flutter date picker
//   // instead of a stub toast. Both the calendar icon in the AppBar and the
//   // week-selector pill open this.
//   // ---------------------------------------------------------------------
//   Future<void> _pickDateRange(BuildContext context) async {
//     final now = DateTime.now();
//     final defaultStart = now.subtract(Duration(days: now.weekday - 1));
//     final defaultEnd = defaultStart.add(const Duration(days: 6));

//     final picked = await showDateRangePicker(
//       context: context,
//       firstDate: DateTime(now.year - 1),
//       lastDate: DateTime(now.year + 1),
//       initialDateRange:
//           _selectedRange ?? DateTimeRange(start: defaultStart, end: defaultEnd),
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: Theme.of(
//               context,
//             ).colorScheme.copyWith(primary: AppColors.primaryBlack),
//           ),
//           child: child!,
//         );
//       },
//     );

//     if (picked != null) {
//       setState(() => _selectedRange = picked);
//       _toast('Showing earnings for the selected range');
//     }
//   }

//   String get _rangeLabel {
//     const months = [
//       'Jan',
//       'Feb',
//       'Mar',
//       'Apr',
//       'May',
//       'Jun',
//       'Jul',
//       'Aug',
//       'Sep',
//       'Oct',
//       'Nov',
//       'Dec',
//     ];
//     String fmt(DateTime d) => '${d.day} ${months[d.month - 1]}';

//     if (_selectedRange == null) {
//       return '15 July – 21 July, 2025';
//     }
//     final start = _selectedRange!.start;
//     final end = _selectedRange!.end;
//     return '${fmt(start)} – ${fmt(end)}, ${end.year}';
//   }

//   void _openTransactionHistory(BuildContext context) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (_) =>
//             const _TransactionHistoryScreen(transactions: _allTransactions),
//       ),
//     );
//   }

//   void _openPaymentHistory(BuildContext context) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (_) => const _PaymentHistoryScreen(payouts: _payouts),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final totalCredited = _creditBreakdown.fold<double>(
//       0,
//       (sum, r) => sum + r.amount,
//     );

//     // Black-header-plus-curved-white-sheet layout (matches the Trip Details
//     // screen convention): a black backdrop holds the header row (working
//     // back button, title, actions), and the page content lives in a white
//     // sheet with rounded top corners that visually curves out of the header.
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
//                       _fadeIn(0, child: _buildWeekSelector()),
//                       const SizedBox(height: 14),
//                       _fadeIn(1, child: _buildHeroEarningsCard()),
//                       const SizedBox(height: 14),
//                       _fadeIn(2, child: _buildCreditedBanner(totalCredited)),
//                       const SizedBox(height: 22),
//                       _fadeIn(3, child: _sectionTitle('Earnings Summary')),
//                       const SizedBox(height: 10),
//                       _fadeIn(4, child: _buildSummaryGrid()),
//                       const SizedBox(height: 22),
//                       _fadeIn(5, child: _buildWeeklyEarningsCard()),
//                       const SizedBox(height: 22),
//                       _fadeIn(6, child: _sectionTitle('Earnings Breakdown')),
//                       const SizedBox(height: 10),
//                       _fadeIn(7, child: _buildBreakdownCard()),
//                       const SizedBox(height: 22),
//                       _fadeIn(
//                         8,
//                         child: _sectionTitle(
//                           'Transaction History',
//                           action: 'See All',
//                           onActionTap: () => _openTransactionHistory(context),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       _fadeIn(9, child: _buildTransactionList()),
//                       const SizedBox(height: 22),
//                       _fadeIn(10, child: _sectionTitle('Performance Insights')),
//                       const SizedBox(height: 10),
//                       _fadeIn(11, child: _buildPerformanceInsights()),
//                       const SizedBox(height: 22),
//                       _fadeIn(12, child: _buildPayoutCard()),
//                       const SizedBox(height: 22),
//                       _fadeIn(13, child: _sectionTitle('Achievements')),
//                       const SizedBox(height: 10),
//                       _fadeIn(14, child: _buildAchievements()),
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
//   // Entrance animation helper — fades + slides each section up slightly,
//   // staggered by `index` across the total number of sections on the page.
//   // ---------------------------------------------------------------------
//   static const int _sectionCount = 15;

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

//   // ---------------------------------------------------------------------
//   // Curved black header bar (back button, title, actions)
//   // ---------------------------------------------------------------------
//   Widget _buildCurvedHeaderBar(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(4, 4, 8, 16),
//       child: Row(
//         children: [
//           IconButton(
//             icon: const Icon(Icons.arrow_back, color: AppColors.pureWhite),
//             tooltip: 'Back',
//             // Pushed from Trips' daily-earnings card → pop the route.
//             // Opened as the bottom-nav Earnings tab → there's no route
//             // to pop, so switch RiderShell back to the Home tab instead.
//             onPressed: () {
//               if (Navigator.of(context).canPop()) {
//                 Navigator.of(context).pop();
//               } else {
//                 ref.read(riderTabIndexProvider.notifier).state = 0;
//               }
//             },
//           ),
//           const Expanded(
//             child: Text(
//               'Earnings',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: AppColors.pureWhite,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 19,
//               ),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(
//               Icons.calendar_today_outlined,
//               color: AppColors.pureWhite,
//               size: 19,
//             ),
//             tooltip: 'Pick date range',
//             onPressed: () => _pickDateRange(context),
//           ),
//           Stack(
//             clipBehavior: Clip.none,
//             children: [
//               IconButton(
//                 icon: const Icon(
//                   Icons.notifications_none,
//                   color: AppColors.pureWhite,
//                 ),
//                 tooltip: 'Notifications',
//                 onPressed: () => Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (_) => const NotificationsScreen(),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 right: 8,
//                 top: 8,
//                 child: Container(
//                   padding: const EdgeInsets.all(3),
//                   decoration: const BoxDecoration(
//                     color: Colors.red,
//                     shape: BoxShape.circle,
//                   ),
//                   constraints: const BoxConstraints(
//                     minWidth: 15,
//                     minHeight: 15,
//                   ),
//                   child: const Text(
//                     '2',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.white, fontSize: 9),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           IconButton(
//             icon: const Icon(
//               Icons.help_outline,
//               color: AppColors.pureWhite,
//               size: 20,
//             ),
//             tooltip: 'Help',
//             onPressed: () => _showHelpSheet(context),
//           ),
//         ],
//       ),
//     );
//   }

//   // ---------------------------------------------------------------------
//   // Help bottom sheet — opened by the "?" icon in the header
//   // ---------------------------------------------------------------------
//   void _showHelpSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       builder: (sheetContext) {
//         // isScrollControlled + a max-height constraint + an inner
//         // SingleChildScrollView let this sheet grow with its content
//         // instead of overflowing the default (shorter) bottom-sheet height.
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
//                     'Earnings Help',
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                   ),
//                   const SizedBox(height: 16),
//                   _helpItem(
//                     'When do I get paid?',
//                     'Earnings are credited to your wallet right after each '
//                         'trip is marked complete — you\'ll see them under '
//                         '"Earnings Credited" above.',
//                   ),
//                   _helpItem(
//                     'How do withdrawals work?',
//                     'Tap "Withdraw" or "Withdraw Now" — funds are sent to '
//                         'your linked bank account within 24 hours.',
//                   ),
//                   _helpItem(
//                     'What counts as a bonus?',
//                     'Peak-hour trips, distance incentives, and return-trip '
//                         'rewards are added automatically and shown in your '
//                         'breakdown.',
//                   ),
//                   const SizedBox(height: 4),
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
//   // Week selector pill
//   // ---------------------------------------------------------------------
//   Widget _buildWeekSelector() {
//     return _HoverPressable(
//       onTap: () => _pickDateRange(context),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//         decoration: BoxDecoration(
//           color: AppColors.pureWhite,
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(color: AppColors.border),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     _selectedRange == null ? 'CURRENT WEEK' : 'SELECTED RANGE',
//                     style: const TextStyle(
//                       fontSize: 10,
//                       color: AppColors.textHint,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 0.4,
//                     ),
//                   ),
//                   const SizedBox(height: 3),
//                   Text(
//                     _rangeLabel,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.textPrimary,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Icon(
//               Icons.keyboard_arrow_down_rounded,
//               color: AppColors.textSecondary,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ---------------------------------------------------------------------
//   // Hero black earnings card
//   // ---------------------------------------------------------------------
//   Widget _buildHeroEarningsCard() {
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
//             'TOTAL EARNINGS',
//             style: TextStyle(
//               color: AppColors.textHint,
//               fontSize: 11,
//               fontWeight: FontWeight.bold,
//               letterSpacing: 0.6,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               _AnimatedCounter(
//                 animation: _entrance,
//                 target: 3850,
//                 prefix: '₹',
//                 style: const TextStyle(
//                   color: AppColors.pureWhite,
//                   fontSize: 34,
//                   fontWeight: FontWeight.bold,
//                   height: 1,
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 6),
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 8,
//                     vertical: 4,
//                   ),
//                   decoration: BoxDecoration(
//                     color: AppColors.success.withOpacity(0.18),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: const Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(
//                         Icons.arrow_upward,
//                         size: 11,
//                         color: AppColors.success,
//                       ),
//                       SizedBox(width: 3),
//                       Text(
//                         '+18% from last week',
//                         style: TextStyle(
//                           color: AppColors.success,
//                           fontSize: 10.5,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 18),
//           Container(height: 1, color: AppColors.pureWhite.withOpacity(0.08)),
//           const SizedBox(height: 16),
//           Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     Text(
//                       'Wallet Balance',
//                       style: TextStyle(color: AppColors.textHint, fontSize: 12),
//                     ),
//                     SizedBox(height: 4),
//                     Text(
//                       '₹2,750',
//                       style: TextStyle(
//                         color: AppColors.pureWhite,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       'available',
//                       style: TextStyle(color: AppColors.textHint, fontSize: 11),
//                     ),
//                   ],
//                 ),
//               ),
//               _HoverPressable(
//                 onTap: () => _showCashOutSheet(context),
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 18,
//                     vertical: 12,
//                   ),
//                   decoration: BoxDecoration(
//                     color: AppColors.pureWhite,
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: const Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(Icons.account_balance_wallet_outlined, size: 16),
//                       SizedBox(width: 6),
//                       Text(
//                         'Withdraw',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w700,
//                           fontSize: 13.5,
//                         ),
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

//   // ---------------------------------------------------------------------
//   // "Earnings Credited" success banner
//   // ---------------------------------------------------------------------
//   Widget _buildCreditedBanner(double total) {
//     return TweenAnimationBuilder<double>(
//       tween: Tween(begin: 0.94, end: 1),
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.easeOutBack,
//       builder: (context, scale, child) =>
//           Transform.scale(scale: scale, child: child),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: AppColors.pureWhite,
//           borderRadius: BorderRadius.circular(18),
//           border: Border.all(color: AppColors.success.withOpacity(0.35)),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.success.withOpacity(0.12),
//               blurRadius: 16,
//               offset: const Offset(0, 6),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: AppColors.success.withOpacity(0.12),
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.check_circle,
//                     color: AppColors.success,
//                     size: 20,
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 const Expanded(
//                   child: Text(
//                     'Earnings Credited',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15,
//                       color: AppColors.textPrimary,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 2),
//             const Padding(
//               padding: EdgeInsets.only(left: 42),
//               child: Text(
//                 'Added to your rider wallet',
//                 style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
//               ),
//             ),
//             const SizedBox(height: 14),
//             ..._creditBreakdown.map(
//               (row) => Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       row.label,
//                       style: const TextStyle(
//                         fontSize: 13,
//                         color: AppColors.textSecondary,
//                       ),
//                     ),
//                     Text(
//                       '₹${row.amount.toStringAsFixed(0)}',
//                       style: const TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.textPrimary,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 10),
//               child: Divider(height: 1, color: AppColors.divider),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Total Credited',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//                 Text(
//                   '₹${total.toStringAsFixed(0)}',
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 15,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 5,
//                   ),
//                   decoration: BoxDecoration(
//                     color: AppColors.success.withOpacity(0.12),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: const Text(
//                     'Credited Successfully',
//                     style: TextStyle(
//                       color: AppColors.success,
//                       fontSize: 10.5,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 const Text(
//                   '2 minutes ago',
//                   style: TextStyle(fontSize: 11, color: AppColors.textHint),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ---------------------------------------------------------------------
//   // Section title helper
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
//   // Earnings Summary 2x2 grid
//   // ---------------------------------------------------------------------
//   Widget _buildSummaryGrid() {
//     const items = [
//       _SummaryCardData(
//         icon: Icons.inventory_2_outlined,
//         amount: 2450,
//         label: 'Trip Earnings',
//         caption: 'Completed Deliveries',
//       ),
//       _SummaryCardData(
//         icon: Icons.bolt_outlined,
//         amount: 450,
//         label: 'Bonuses',
//         caption: 'Peak Hour & Incentives',
//       ),
//       _SummaryCardData(
//         icon: Icons.schedule_outlined,
//         amount: 300,
//         label: 'Pending Payout',
//         caption: 'Available Tomorrow',
//       ),
//     ];

//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: items.length,
//       // NOTE: aspect-ratio-based sizing (was 1.5, then 1.3) still overflowed
//       // on narrower screens because the *height* it produces shrinks along
//       // with the width. A fixed mainAxisExtent gives every card the same,
//       // deterministic height regardless of screen width, so the icon +
//       // amount + label + caption always fit.
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         mainAxisSpacing: 12,
//         crossAxisSpacing: 12,
//         mainAxisExtent: 128,
//       ),
//       itemBuilder: (context, i) {
//         final item = items[i];
//         return _HoverPressable(
//           onTap: () => _toast('${item.label}: ₹${item.amount}'),
//           liftOnHover: true,
//           child: Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: AppColors.pureWhite,
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(color: AppColors.border),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(7),
//                   decoration: BoxDecoration(
//                     color: AppColors.inputFill,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Icon(
//                     item.icon,
//                     size: 16,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//                 Text(
//                   '₹${item.amount}',
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.textPrimary,
//                     height: 1.1,
//                   ),
//                 ),
//                 Text(
//                   item.label,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     fontSize: 11.5,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimary,
//                     height: 1.1,
//                   ),
//                 ),
//                 Text(
//                   item.caption,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     fontSize: 10,
//                     color: AppColors.textHint,
//                     height: 1.1,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // ---------------------------------------------------------------------
//   // Weekly earnings bar chart card
//   // ---------------------------------------------------------------------
//   Widget _buildWeeklyEarningsCard() {
//     final values = _showMonthly ? _weeklyValuesMonth : _weeklyValuesWeek;
//     final labels = _showMonthly ? _monthWeekLabels : _weekDayLabels;
//     final peakIndex = values.indexOf(values.reduce((a, b) => a > b ? a : b));

//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.pureWhite,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: AppColors.border),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Weekly Earnings',
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimary,
//                 ),
//               ),
//               _HoverPressable(
//                 onTap: () => setState(() => _showMonthly = !_showMonthly),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       _showMonthly ? 'View Weekly' : 'View Monthly',
//                       style: const TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.textSecondary,
//                       ),
//                     ),
//                     const Icon(
//                       Icons.chevron_right,
//                       size: 15,
//                       color: AppColors.textSecondary,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 18),
//           SizedBox(
//             height: 130,
//             child: Row(
//               key: ValueKey(_showMonthly),
//               crossAxisAlignment: CrossAxisAlignment.end,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: List.generate(values.length, (i) {
//                 final isPeak = i == peakIndex;
//                 return Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 4),
//                     child: _AnimatedBar(
//                       heightFactor: values[i],
//                       maxHeight: 96,
//                       color: isPeak
//                           ? AppColors.primaryBlack
//                           : AppColors.inputFill,
//                       label: labels[i],
//                       highlight: isPeak,
//                     ),
//                   ),
//                 );
//               }),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ---------------------------------------------------------------------
//   // Earnings breakdown list with animated progress bars
//   // ---------------------------------------------------------------------
//   Widget _buildBreakdownCard() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.pureWhite,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: AppColors.border),
//       ),
//       child: Column(
//         children: _earningsBreakdown.map((item) {
//           final fraction = (item.amount / item.total).clamp(0.0, 1.0);
//           final isLast = item == _earningsBreakdown.last;
//           return Padding(
//             padding: EdgeInsets.only(bottom: isLast ? 0 : 14),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       item.label,
//                       style: const TextStyle(
//                         fontSize: 13,
//                         color: AppColors.textSecondary,
//                       ),
//                     ),
//                     Text(
//                       '₹${item.amount.toStringAsFixed(0)}',
//                       style: const TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w700,
//                         color: AppColors.textPrimary,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 6),
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(20),
//                   child: SizedBox(
//                     height: 6,
//                     child: Stack(
//                       children: [
//                         Container(color: AppColors.inputFill),
//                         TweenAnimationBuilder<double>(
//                           tween: Tween(begin: 0, end: fraction),
//                           duration: const Duration(milliseconds: 800),
//                           curve: Curves.easeOutCubic,
//                           builder: (context, value, _) {
//                             return FractionallySizedBox(
//                               widthFactor: value,
//                               child: Container(color: AppColors.primaryBlack),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   // ---------------------------------------------------------------------
//   // Transaction history list (inline preview — most recent few)
//   // ---------------------------------------------------------------------
//   Widget _buildTransactionList() {
//     return Column(
//       children: _transactions.map((txn) {
//         final isLast = txn == _transactions.last;
//         return Padding(
//           padding: EdgeInsets.only(bottom: isLast ? 0 : 10),
//           child: _transactionCard(
//             txn,
//             onTap: () => _toast('Trip ${txn.id} details — coming soon'),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   // ---------------------------------------------------------------------
//   // Performance insights
//   // ---------------------------------------------------------------------
//   Widget _buildPerformanceInsights() {
//     return Column(
//       children: [
//         Row(
//           children: [
//             const Expanded(
//               child: _MiniStat(
//                 value: '98%',
//                 label: 'Excellent\nCompletion',
//                 icon: Icons.check_circle_outline,
//               ),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: _MiniStat(
//                 value: '4.9',
//                 label: 'Top Rated\nRating',
//                 icon: Icons.star_rounded,
//                 iconColor: const Color(0xFFF5A623),
//               ),
//             ),
//             const SizedBox(width: 10),
//             const Expanded(
//               child: _MiniStat(
//                 value: '22m',
//                 label: 'Per trip\nAvg Time',
//                 icon: Icons.access_time_rounded,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Row(
//           children: [
//             Expanded(
//               child: _buildBigStatTile(value: 248, label: 'Total Deliveries'),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: _buildBigStatTile(value: 67, label: 'Return Trips'),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildBigStatTile({required int value, required String label}) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
//       decoration: BoxDecoration(
//         color: AppColors.pureWhite,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: AppColors.border),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _AnimatedCounter(
//             animation: _entrance,
//             target: value.toDouble(),
//             style: const TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: AppColors.textPrimary,
//             ),
//           ),
//           const SizedBox(height: 2),
//           Text(
//             label,
//             style: const TextStyle(fontSize: 11.5, color: AppColors.textHint),
//           ),
//         ],
//       ),
//     );
//   }

//   // ---------------------------------------------------------------------
//   // Payout information card
//   // ---------------------------------------------------------------------
//   Widget _buildPayoutCard() {
//     return Container(
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: AppColors.primaryBlack,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: const [
//               Icon(
//                 Icons.account_balance_wallet_outlined,
//                 color: AppColors.pureWhite,
//                 size: 16,
//               ),
//               SizedBox(width: 6),
//               Text(
//                 'PAYOUT INFORMATION',
//                 style: TextStyle(
//                   color: AppColors.textHint,
//                   fontSize: 10.5,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 0.4,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 14),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     Text(
//                       'Available Balance',
//                       style: TextStyle(color: AppColors.textHint, fontSize: 12),
//                     ),
//                     SizedBox(height: 4),
//                     Text(
//                       '₹2,750',
//                       style: TextStyle(
//                         color: AppColors.pureWhite,
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     'Next Settlement',
//                     style: TextStyle(color: AppColors.textHint, fontSize: 11),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     'Tomorrow',
//                     style: TextStyle(
//                       color: AppColors.pureWhite,
//                       fontSize: 13,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 14),
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//             decoration: BoxDecoration(
//               color: AppColors.pureWhite.withOpacity(0.06),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Row(
//               children: const [
//                 Icon(Icons.credit_card, color: AppColors.pureWhite, size: 16),
//                 SizedBox(width: 10),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Payment Method',
//                       style: TextStyle(
//                         color: AppColors.textHint,
//                         fontSize: 10.5,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       'Bank Account •••• 4528',
//                       style: TextStyle(
//                         color: AppColors.pureWhite,
//                         fontSize: 12.5,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 14),
//           Row(
//             children: [
//               Expanded(
//                 child: _HoverPressable(
//                   onTap: () => _showCashOutSheet(context),
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
//                         Icon(Icons.north_east, size: 15),
//                         SizedBox(width: 6),
//                         Text(
//                           'Withdraw Now',
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
//                   onTap: () => _openPaymentHistory(context),
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(vertical: 13),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(26),
//                       border: Border.all(
//                         color: AppColors.pureWhite.withOpacity(0.35),
//                       ),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         'Payment History',
//                         style: TextStyle(
//                           color: AppColors.pureWhite,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 12.5,
//                         ),
//                       ),
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
//   // Achievements list
//   // ---------------------------------------------------------------------
//   Widget _buildAchievements() {
//     return Column(
//       children: _achievements.map((a) {
//         final isLast = a == _achievements.last;
//         return Padding(
//           padding: EdgeInsets.only(bottom: isLast ? 0 : 10),
//           child: _HoverPressable(
//             onTap: () => _toast('${a.title}: ${a.subtitle}'),
//             liftOnHover: true,
//             child: Container(
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
//                       color: a.color.withOpacity(0.12),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Icon(a.icon, color: a.color, size: 20),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           a.title,
//                           style: const TextStyle(
//                             fontSize: 13.5,
//                             fontWeight: FontWeight.w700,
//                             color: AppColors.textPrimary,
//                           ),
//                         ),
//                         const SizedBox(height: 2),
//                         Text(
//                           a.subtitle,
//                           style: const TextStyle(
//                             fontSize: 11.5,
//                             color: AppColors.textSecondary,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Icon(
//                     Icons.chevron_right,
//                     size: 18,
//                     color: AppColors.textHint,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   // ---------------------------------------------------------------------
//   // Cash out / withdraw bottom sheet
//   // ---------------------------------------------------------------------
//   void _showCashOutSheet(BuildContext context) {
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
//                 'Withdraw Earnings',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//               const SizedBox(height: 6),
//               const Text(
//                 '₹2,750 will be transferred to your linked bank account '
//                 'ending 4528 within 24 hours.',
//                 style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
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
// }

// // =============================================================================
// // Shared transaction card (used both on the Earnings tab preview and on the
// // full "See All" history screen so the two never drift out of sync).
// // =============================================================================
// Widget _transactionCard(_Transaction txn, {VoidCallback? onTap}) {
//   final credited = txn.status == _TxnStatus.credited;
//   return _HoverPressable(
//     onTap: onTap,
//     liftOnHover: true,
//     child: Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: AppColors.pureWhite,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: AppColors.border),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: (credited ? AppColors.success : Colors.orange).withOpacity(
//                 0.12,
//               ),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               credited
//                   ? Icons.arrow_downward_rounded
//                   : Icons.hourglass_bottom_rounded,
//               size: 18,
//               color: credited ? AppColors.success : Colors.orange[700],
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Trip ${txn.id}',
//                   style: const TextStyle(
//                     fontSize: 13.5,
//                     fontWeight: FontWeight.w700,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   txn.type,
//                   style: const TextStyle(
//                     fontSize: 11.5,
//                     color: AppColors.textSecondary,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   '${txn.customer} · ${txn.route}',
//                   style: const TextStyle(
//                     fontSize: 11,
//                     color: AppColors.textHint,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(width: 8),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 '₹${txn.amount}',
//                 style: const TextStyle(
//                   fontSize: 14.5,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimary,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//                 decoration: BoxDecoration(
//                   color: (credited ? AppColors.success : Colors.orange)
//                       .withOpacity(0.12),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   credited ? 'Credited' : 'Processing',
//                   style: TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w700,
//                     color: credited ? AppColors.success : Colors.orange[800],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 3),
//               Text(
//                 '${txn.date} · ${txn.time}',
//                 style: const TextStyle(fontSize: 10, color: AppColors.textHint),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }

// // =============================================================================
// // "See All" — full transaction history screen
// // =============================================================================
// class _TransactionHistoryScreen extends StatelessWidget {
//   final List<_Transaction> transactions;

//   const _TransactionHistoryScreen({required this.transactions});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F4F4),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF4F4F4),
//         elevation: 0,
//         title: const Text(
//           'Transaction History',
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
//             return _transactionCard(
//               txn,
//               onTap: () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('Trip ${txn.id} details — coming soon'),
//                     behavior: SnackBarBehavior.floating,
//                     backgroundColor: AppColors.primaryBlack,
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// // =============================================================================
// // "Payment History" — settlement / payout history screen
// // =============================================================================
// class _PaymentHistoryScreen extends StatelessWidget {
//   final List<_Payout> payouts;

//   const _PaymentHistoryScreen({required this.payouts});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F4F4),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF4F4F4),
//         elevation: 0,
//         title: const Text(
//           'Payment History',
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
//           itemCount: payouts.length,
//           separatorBuilder: (_, __) => const SizedBox(height: 10),
//           itemBuilder: (context, i) {
//             final payout = payouts[i];
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
//                       color: AppColors.success.withOpacity(0.12),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                       Icons.account_balance_outlined,
//                       size: 18,
//                       color: AppColors.success,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           payout.id,
//                           style: const TextStyle(
//                             fontSize: 13.5,
//                             fontWeight: FontWeight.w700,
//                             color: AppColors.textPrimary,
//                           ),
//                         ),
//                         const SizedBox(height: 2),
//                         Text(
//                           'Bank •••• ${payout.bankLast4}',
//                           style: const TextStyle(
//                             fontSize: 11.5,
//                             color: AppColors.textSecondary,
//                           ),
//                         ),
//                         const SizedBox(height: 2),
//                         Text(
//                           payout.date,
//                           style: const TextStyle(
//                             fontSize: 11,
//                             color: AppColors.textHint,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         '₹${payout.amount}',
//                         style: const TextStyle(
//                           fontSize: 14.5,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.textPrimary,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 8,
//                           vertical: 3,
//                         ),
//                         decoration: BoxDecoration(
//                           color: AppColors.success.withOpacity(0.12),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Text(
//                           payout.status,
//                           style: const TextStyle(
//                             fontSize: 10,
//                             fontWeight: FontWeight.w700,
//                             color: AppColors.success,
//                           ),
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
// // Small reusable pieces
// // =============================================================================

// /// Wraps a tappable widget with a hover-lift effect (mouse, on web/desktop)
// /// and a press-scale effect (touch, on mobile) so every interactive card on
// /// this page feels alive without needing any extra packages.
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

// /// Animates a numeric value counting up from 0 to [target] as [animation]
// /// plays, used for the big headline earnings figure and stat tiles.
// class _AnimatedCounter extends StatelessWidget {
//   final Animation<double> animation;
//   final double target;
//   final String prefix;
//   final TextStyle style;

//   const _AnimatedCounter({
//     required this.animation,
//     required this.target,
//     required this.style,
//     this.prefix = '',
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: animation,
//       builder: (context, _) {
//         final value = (target * animation.value).clamp(0, target);
//         final display = value.round().toString();
//         return Text('$prefix${_thousands(display)}', style: style);
//       },
//     );
//   }

//   String _thousands(String number) {
//     final isNegative = number.startsWith('-');
//     final digits = isNegative ? number.substring(1) : number;
//     final buffer = StringBuffer();
//     for (var i = 0; i < digits.length; i++) {
//       final posFromEnd = digits.length - i;
//       buffer.write(digits[i]);
//       if (posFromEnd > 1 && posFromEnd % 3 == 1) {
//         buffer.write(',');
//       }
//     }
//     return '${isNegative ? '-' : ''}$buffer';
//   }
// }

// /// A single animated bar in the weekly/monthly earnings chart. Grows from
// /// 0 to its target height once mounted, with a small per-bar stagger.
// class _AnimatedBar extends StatefulWidget {
//   final double heightFactor;
//   final double maxHeight;
//   final Color color;
//   final String label;
//   final bool highlight;

//   const _AnimatedBar({
//     required this.heightFactor,
//     required this.maxHeight,
//     required this.color,
//     required this.label,
//     this.highlight = false,
//   });

//   @override
//   State<_AnimatedBar> createState() => _AnimatedBarState();
// }

// class _AnimatedBarState extends State<_AnimatedBar> {
//   double _factor = 0;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) setState(() => _factor = widget.heightFactor);
//     });
//   }

//   @override
//   void didUpdateWidget(covariant _AnimatedBar old) {
//     super.didUpdateWidget(old);
//     if (old.heightFactor != widget.heightFactor) {
//       setState(() => _factor = widget.heightFactor);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         AnimatedContainer(
//           duration: const Duration(milliseconds: 700),
//           curve: Curves.easeOutCubic,
//           height: (widget.maxHeight * _factor).clamp(4, widget.maxHeight),
//           decoration: BoxDecoration(
//             color: widget.color,
//             borderRadius: BorderRadius.circular(6),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           widget.label,
//           style: TextStyle(
//             fontSize: 10.5,
//             fontWeight: widget.highlight ? FontWeight.w700 : FontWeight.w500,
//             color: widget.highlight
//                 ? AppColors.textPrimary
//                 : AppColors.textHint,
//           ),
//         ),
//       ],
//     );
//   }
// }

// /// Small icon + value + label stat card used in Performance Insights.
// class _MiniStat extends StatelessWidget {
//   final String value;
//   final String label;
//   final IconData icon;
//   final Color? iconColor;

//   const _MiniStat({
//     required this.value,
//     required this.label,
//     required this.icon,
//     this.iconColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
//       decoration: BoxDecoration(
//         color: AppColors.pureWhite,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: AppColors.border),
//       ),
//       child: Column(
//         children: [
//           Icon(icon, size: 20, color: iconColor ?? AppColors.textPrimary),
//           const SizedBox(height: 6),
//           Text(
//             value,
//             style: const TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.bold,
//               color: AppColors.textPrimary,
//             ),
//           ),
//           const SizedBox(height: 2),
//           Text(
//             label,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               fontSize: 9.5,
//               color: AppColors.textHint,
//               height: 1.2,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // =============================================================================
// // Mock data models
// // =============================================================================

// class _CreditRow {
//   final String label;
//   final double amount;
//   const _CreditRow(this.label, this.amount);
// }

// class _BreakdownItem {
//   final String label;
//   final double amount;
//   final double total;
//   const _BreakdownItem(this.label, this.amount, this.total);
// }

// class _SummaryCardData {
//   final IconData icon;
//   final int amount;
//   final String label;
//   final String caption;
//   const _SummaryCardData({
//     required this.icon,
//     required this.amount,
//     required this.label,
//     required this.caption,
//   });
// }

// enum _TxnStatus { credited, processing }

// class _Transaction {
//   final String id;
//   final String type;
//   final int amount;
//   final _TxnStatus status;
//   final String customer;
//   final String route;
//   final String time;
//   final String date;
//   const _Transaction({
//     required this.id,
//     required this.type,
//     required this.amount,
//     required this.status,
//     required this.customer,
//     required this.route,
//     required this.time,
//     required this.date,
//   });
// }

// class _Achievement {
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   final Color color;
//   const _Achievement({
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     required this.color,
//   });
// }

// class _Payout {
//   final String id;
//   final int amount;
//   final String date;
//   final String bankLast4;
//   final String status;
//   const _Payout({
//     required this.id,
//     required this.amount,
//     required this.date,
//     required this.bankLast4,
//     required this.status,
//   });
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import '../../../../../core/constants/app_colors.dart';
import 'package:rento_india/delivery/core/constants/app_colors.dart';
import '../notifications/notifications_screen.dart';

/// Earnings tab — Rider module.
///
/// Pure UI screen (no backend yet): every figure below is local mock data
/// mirroring the reference design. Wire up a real EarningsRepository /
/// Riverpod provider later; the section builders are already split out
/// so swapping mock lists for provider data is a small, local change.
///
/// Reached two ways: as a bottom-nav tab in RiderShell (no Navigator route
/// to pop — back button switches RiderShell to the Home tab via onBack)
/// and as a pushed route from TripsListScreen's daily-earnings card (a
/// real route to pop). onBack is only passed by RiderShell, so the back
/// button no longer has to guess using the unreliable canPop() check.
class EarningsScreen extends ConsumerStatefulWidget {
  final VoidCallback? onBack;

  const EarningsScreen({super.key, this.onBack});

  @override
  ConsumerState<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends ConsumerState<EarningsScreen>
    with TickerProviderStateMixin {
  late final AnimationController _entrance;
  bool _showMonthly = false;
  DateTimeRange? _selectedRange;

  // ---- Mock data -----------------------------------------------------
  static const List<_CreditRow> _creditBreakdown = [
    _CreditRow('Pickup Reward', 60),
    _CreditRow('Delivery Reward', 90),
    _CreditRow('Return Trip', 80),
    _CreditRow('Distance Bonus', 40),
    _CreditRow('Peak Hour Bonus', 30),
  ];

  static const List<double> _weeklyValuesWeek = [
    0.35,
    0.5,
    0.3,
    0.55,
    0.42,
    1.0,
    0.6,
  ];
  static const List<double> _weeklyValuesMonth = [0.5, 0.65, 0.8, 1.0];
  static const _weekDayLabels = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];
  static const _monthWeekLabels = ['Wk 1', 'Wk 2', 'Wk 3', 'Wk 4'];

  static const List<_BreakdownItem> _earningsBreakdown = [
    _BreakdownItem('Pickup Earnings', 1150, 2450),
    _BreakdownItem('Delivery Earnings', 1650, 2450),
    _BreakdownItem('Return Trips', 650, 2450),
    _BreakdownItem('Bonuses', 400, 2450),
    _BreakdownItem('Distance Incentives', 250, 2450),
  ];

  // Shown inline on the Earnings tab (most recent few).
  static const List<_Transaction> _transactions = [
    _Transaction(
      id: '#2025001',
      type: 'Pickup • Delivery • Return',
      amount: 300,
      status: _TxnStatus.credited,
      customer: 'Arjun Mehta',
      route: 'Andheri → Bandra',
      time: '10:45 AM',
      date: 'Today',
    ),
    _Transaction(
      id: '#2025002',
      type: 'Delivery + Return',
      amount: 220,
      status: _TxnStatus.credited,
      customer: 'Priya Singh',
      route: 'Powai → Thane',
      time: '12:30 PM',
      date: 'Today',
    ),
    _Transaction(
      id: '#2025003',
      type: 'Pickup Only',
      amount: 180,
      status: _TxnStatus.credited,
      customer: 'Rahul Sharma',
      route: 'Dadar → Kurla',
      time: '2:15 PM',
      date: 'Today',
    ),
    _Transaction(
      id: '#2025004',
      type: 'Delivery + Peak Bonus',
      amount: 340,
      status: _TxnStatus.processing,
      customer: 'Sneha Kapoor',
      route: 'Goregaon → Malad',
      time: '4:00 PM',
      date: 'Today',
    ),
  ];

  // Full history shown on the "See All" screen — a superset of the above.
  static const List<_Transaction> _allTransactions = [
    ..._transactions,
    _Transaction(
      id: '#2024998',
      type: 'Pickup + Return',
      amount: 260,
      status: _TxnStatus.credited,
      customer: 'Karan Malhotra',
      route: 'Vashi → Panvel',
      time: '9:10 AM',
      date: 'Yesterday',
    ),
    _Transaction(
      id: '#2024991',
      type: 'Delivery Only',
      amount: 150,
      status: _TxnStatus.credited,
      customer: 'Neha Joshi',
      route: 'Chembur → Sion',
      time: '6:40 PM',
      date: 'Yesterday',
    ),
    _Transaction(
      id: '#2024987',
      type: 'Pickup • Delivery • Return',
      amount: 310,
      status: _TxnStatus.credited,
      customer: 'Vikram Rao',
      route: 'Borivali → Malad',
      time: '11:05 AM',
      date: '9 July',
    ),
    _Transaction(
      id: '#2024979',
      type: 'Return Trip + Bonus',
      amount: 190,
      status: _TxnStatus.credited,
      customer: 'Ananya Iyer',
      route: 'Wadala → Byculla',
      time: '3:50 PM',
      date: '9 July',
    ),
    _Transaction(
      id: '#2024965',
      type: 'Delivery + Return',
      amount: 240,
      status: _TxnStatus.credited,
      customer: 'Farhan Sheikh',
      route: 'Kandivali → Andheri',
      time: '1:20 PM',
      date: '8 July',
    ),
    _Transaction(
      id: '#2024958',
      type: 'Pickup Only',
      amount: 140,
      status: _TxnStatus.credited,
      customer: 'Divya Nair',
      route: 'Mulund → Bhandup',
      time: '5:05 PM',
      date: '8 July',
    ),
  ];

  static const List<_Achievement> _achievements = [
    _Achievement(
      icon: Icons.emoji_events_outlined,
      title: 'Delivery Champion',
      subtitle: 'Completed 200 Deliveries',
      color: Color(0xFFF5A623),
    ),
    _Achievement(
      icon: Icons.rocket_launch_outlined,
      title: 'Top Performer',
      subtitle: 'Highest Weekly Earnings',
      color: Color(0xFF6C5CE7),
    ),
    _Achievement(
      icon: Icons.star_outline,
      title: '5-Star Rider',
      subtitle: 'Maintained 4.9+ Rating',
      color: Color(0xFF2ECC71),
    ),
  ];

  // Mock payout history for the "Payment History" screen.
  static const List<_Payout> _payouts = [
    _Payout(
      id: 'PYT-10245',
      amount: 3120,
      date: '4 July, 2025',
      bankLast4: '4528',
      status: 'Paid',
    ),
    _Payout(
      id: 'PYT-10198',
      amount: 2890,
      date: '27 June, 2025',
      bankLast4: '4528',
      status: 'Paid',
    ),
    _Payout(
      id: 'PYT-10151',
      amount: 3340,
      date: '20 June, 2025',
      bankLast4: '4528',
      status: 'Paid',
    ),
    _Payout(
      id: 'PYT-10104',
      amount: 2560,
      date: '13 June, 2025',
      bankLast4: '4528',
      status: 'Paid',
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
  // Date range ("week") picker — now wired to a real Flutter date picker
  // instead of a stub toast. Both the calendar icon in the AppBar and the
  // week-selector pill open this.
  // ---------------------------------------------------------------------
  Future<void> _pickDateRange(BuildContext context) async {
    final now = DateTime.now();
    final defaultStart = now.subtract(Duration(days: now.weekday - 1));
    final defaultEnd = defaultStart.add(const Duration(days: 6));

    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
      initialDateRange:
          _selectedRange ?? DateTimeRange(start: defaultStart, end: defaultEnd),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(
              context,
            ).colorScheme.copyWith(primary: AppColors.primaryBlack),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => _selectedRange = picked);
      _toast('Showing earnings for the selected range');
    }
  }

  String get _rangeLabel {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    String fmt(DateTime d) => '${d.day} ${months[d.month - 1]}';

    if (_selectedRange == null) {
      return '15 July – 21 July, 2025';
    }
    final start = _selectedRange!.start;
    final end = _selectedRange!.end;
    return '${fmt(start)} – ${fmt(end)}, ${end.year}';
  }

  void _openTransactionHistory(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            const _TransactionHistoryScreen(transactions: _allTransactions),
      ),
    );
  }

  void _openPaymentHistory(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const _PaymentHistoryScreen(payouts: _payouts),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalCredited = _creditBreakdown.fold<double>(
      0,
      (sum, r) => sum + r.amount,
    );

    // Black-header-plus-curved-white-sheet layout (matches the Trip Details
    // screen convention): a black backdrop holds the header row (working
    // back button, title, actions), and the page content lives in a white
    // sheet with rounded top corners that visually curves out of the header.
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
                      _fadeIn(0, child: _buildWeekSelector()),
                      const SizedBox(height: 14),
                      _fadeIn(1, child: _buildHeroEarningsCard()),
                      const SizedBox(height: 14),
                      _fadeIn(2, child: _buildCreditedBanner(totalCredited)),
                      const SizedBox(height: 22),
                      _fadeIn(3, child: _sectionTitle('Earnings Summary')),
                      const SizedBox(height: 10),
                      _fadeIn(4, child: _buildSummaryGrid()),
                      const SizedBox(height: 22),
                      _fadeIn(5, child: _buildWeeklyEarningsCard()),
                      const SizedBox(height: 22),
                      _fadeIn(6, child: _sectionTitle('Earnings Breakdown')),
                      const SizedBox(height: 10),
                      _fadeIn(7, child: _buildBreakdownCard()),
                      const SizedBox(height: 22),
                      _fadeIn(
                        8,
                        child: _sectionTitle(
                          'Transaction History',
                          action: 'See All',
                          onActionTap: () => _openTransactionHistory(context),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _fadeIn(9, child: _buildTransactionList()),
                      const SizedBox(height: 22),
                      _fadeIn(10, child: _sectionTitle('Performance Insights')),
                      const SizedBox(height: 10),
                      _fadeIn(11, child: _buildPerformanceInsights()),
                      const SizedBox(height: 22),
                      _fadeIn(12, child: _buildPayoutCard()),
                      const SizedBox(height: 22),
                      _fadeIn(13, child: _sectionTitle('Achievements')),
                      const SizedBox(height: 10),
                      _fadeIn(14, child: _buildAchievements()),
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
  // Entrance animation helper — fades + slides each section up slightly,
  // staggered by `index` across the total number of sections on the page.
  // ---------------------------------------------------------------------
  static const int _sectionCount = 15;

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

  // ---------------------------------------------------------------------
  // Curved black header bar (back button, title, actions)
  // ---------------------------------------------------------------------
  Widget _buildCurvedHeaderBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 8, 16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.pureWhite),
            tooltip: 'Back',
            // FIX — canPop() was true even in tab-mode (because of
            // whatever sits underneath RiderShell in the navigator
            // stack), so it was popping the whole shell instead of
            // switching tabs. Now RiderShell explicitly passes onBack
            // when Earnings is a tab; if onBack is null, this really
            // was pushed as its own route, so pop it normally.
            onPressed: () {
              if (widget.onBack != null) {
                widget.onBack!();
              } else {
                Navigator.of(context).maybePop();
              }
            },
          ),
          const Expanded(
            child: Text(
              'Earnings',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.pureWhite,
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.calendar_today_outlined,
              color: AppColors.pureWhite,
              size: 19,
            ),
            tooltip: 'Pick date range',
            onPressed: () => _pickDateRange(context),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_none,
                  color: AppColors.pureWhite,
                ),
                tooltip: 'Notifications',
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const NotificationsScreen(),
                  ),
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 15,
                    minHeight: 15,
                  ),
                  child: const Text(
                    '2',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 9),
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(
              Icons.help_outline,
              color: AppColors.pureWhite,
              size: 20,
            ),
            tooltip: 'Help',
            onPressed: () => _showHelpSheet(context),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Help bottom sheet — opened by the "?" icon in the header
  // ---------------------------------------------------------------------
  void _showHelpSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        // isScrollControlled + a max-height constraint + an inner
        // SingleChildScrollView let this sheet grow with its content
        // instead of overflowing the default (shorter) bottom-sheet height.
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
                    'Earnings Help',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  _helpItem(
                    'When do I get paid?',
                    'Earnings are credited to your wallet right after each '
                        'trip is marked complete — you\'ll see them under '
                        '"Earnings Credited" above.',
                  ),
                  _helpItem(
                    'How do withdrawals work?',
                    'Tap "Withdraw" or "Withdraw Now" — funds are sent to '
                        'your linked bank account within 24 hours.',
                  ),
                  _helpItem(
                    'What counts as a bonus?',
                    'Peak-hour trips, distance incentives, and return-trip '
                        'rewards are added automatically and shown in your '
                        'breakdown.',
                  ),
                  const SizedBox(height: 4),
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
  // Week selector pill
  // ---------------------------------------------------------------------
  Widget _buildWeekSelector() {
    return _HoverPressable(
      onTap: () => _pickDateRange(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _selectedRange == null ? 'CURRENT WEEK' : 'SELECTED RANGE',
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textHint,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    _rangeLabel,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Hero black earnings card
  // ---------------------------------------------------------------------
  Widget _buildHeroEarningsCard() {
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
            'TOTAL EARNINGS',
            style: TextStyle(
              color: AppColors.textHint,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _AnimatedCounter(
                animation: _entrance,
                target: 3850,
                prefix: '₹',
                style: const TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_upward,
                        size: 11,
                        color: AppColors.success,
                      ),
                      SizedBox(width: 3),
                      Text(
                        '+18% from last week',
                        style: TextStyle(
                          color: AppColors.success,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(height: 1, color: AppColors.pureWhite.withOpacity(0.08)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Wallet Balance',
                      style: TextStyle(color: AppColors.textHint, fontSize: 12),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '₹2,750',
                      style: TextStyle(
                        color: AppColors.pureWhite,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'available',
                      style: TextStyle(color: AppColors.textHint, fontSize: 11),
                    ),
                  ],
                ),
              ),
              _HoverPressable(
                onTap: () => _showCashOutSheet(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.pureWhite,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.account_balance_wallet_outlined, size: 16),
                      SizedBox(width: 6),
                      Text(
                        'Withdraw',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13.5,
                        ),
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

  // ---------------------------------------------------------------------
  // "Earnings Credited" success banner
  // ---------------------------------------------------------------------
  Widget _buildCreditedBanner(double total) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.94, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutBack,
      builder: (context, scale, child) =>
          Transform.scale(scale: scale, child: child),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.success.withOpacity(0.35)),
          boxShadow: [
            BoxShadow(
              color: AppColors.success.withOpacity(0.12),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: AppColors.success,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Earnings Credited',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            const Padding(
              padding: EdgeInsets.only(left: 42),
              child: Text(
                'Added to your rider wallet',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
            ),
            const SizedBox(height: 14),
            ..._creditBreakdown.map(
              (row) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      row.label,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      '₹${row.amount.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(height: 1, color: AppColors.divider),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Credited',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  '₹${total.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Credited Successfully',
                    style: TextStyle(
                      color: AppColors.success,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  '2 minutes ago',
                  style: TextStyle(fontSize: 11, color: AppColors.textHint),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Section title helper
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
  // Earnings Summary 2x2 grid
  // ---------------------------------------------------------------------
  Widget _buildSummaryGrid() {
    const items = [
      _SummaryCardData(
        icon: Icons.inventory_2_outlined,
        amount: 2450,
        label: 'Trip Earnings',
        caption: 'Completed Deliveries',
      ),
      _SummaryCardData(
        icon: Icons.bolt_outlined,
        amount: 450,
        label: 'Bonuses',
        caption: 'Peak Hour & Incentives',
      ),
      _SummaryCardData(
        icon: Icons.schedule_outlined,
        amount: 300,
        label: 'Pending Payout',
        caption: 'Available Tomorrow',
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      // NOTE: aspect-ratio-based sizing (was 1.5, then 1.3) still overflowed
      // on narrower screens because the *height* it produces shrinks along
      // with the width. A fixed mainAxisExtent gives every card the same,
      // deterministic height regardless of screen width, so the icon +
      // amount + label + caption always fit.
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        mainAxisExtent: 128,
      ),
      itemBuilder: (context, i) {
        final item = items[i];
        return _HoverPressable(
          onTap: () => _toast('${item.label}: ₹${item.amount}'),
          liftOnHover: true,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: AppColors.inputFill,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    item.icon,
                    size: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  '₹${item.amount}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    height: 1.1,
                  ),
                ),
                Text(
                  item.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    height: 1.1,
                  ),
                ),
                Text(
                  item.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.textHint,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------
  // Weekly earnings bar chart card
  // ---------------------------------------------------------------------
  Widget _buildWeeklyEarningsCard() {
    final values = _showMonthly ? _weeklyValuesMonth : _weeklyValuesWeek;
    final labels = _showMonthly ? _monthWeekLabels : _weekDayLabels;
    final peakIndex = values.indexOf(values.reduce((a, b) => a > b ? a : b));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Weekly Earnings',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              _HoverPressable(
                onTap: () => setState(() => _showMonthly = !_showMonthly),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _showMonthly ? 'View Weekly' : 'View Monthly',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      size: 15,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 130,
            child: Row(
              key: ValueKey(_showMonthly),
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(values.length, (i) {
                final isPeak = i == peakIndex;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: _AnimatedBar(
                      heightFactor: values[i],
                      maxHeight: 96,
                      color: isPeak
                          ? AppColors.primaryBlack
                          : AppColors.inputFill,
                      label: labels[i],
                      highlight: isPeak,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Earnings breakdown list with animated progress bars
  // ---------------------------------------------------------------------
  Widget _buildBreakdownCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: _earningsBreakdown.map((item) {
          final fraction = (item.amount / item.total).clamp(0.0, 1.0);
          final isLast = item == _earningsBreakdown.last;
          return Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.label,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      '₹${item.amount.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: 6,
                    child: Stack(
                      children: [
                        Container(color: AppColors.inputFill),
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: fraction),
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, _) {
                            return FractionallySizedBox(
                              widthFactor: value,
                              child: Container(color: AppColors.primaryBlack),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Transaction history list (inline preview — most recent few)
  // ---------------------------------------------------------------------
  Widget _buildTransactionList() {
    return Column(
      children: _transactions.map((txn) {
        final isLast = txn == _transactions.last;
        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : 10),
          child: _transactionCard(
            txn,
            onTap: () => _toast('Trip ${txn.id} details — coming soon'),
          ),
        );
      }).toList(),
    );
  }

  // ---------------------------------------------------------------------
  // Performance insights
  // ---------------------------------------------------------------------
  Widget _buildPerformanceInsights() {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: _MiniStat(
                value: '98%',
                label: 'Excellent\nCompletion',
                icon: Icons.check_circle_outline,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _MiniStat(
                value: '4.9',
                label: 'Top Rated\nRating',
                icon: Icons.star_rounded,
                iconColor: const Color(0xFFF5A623),
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: _MiniStat(
                value: '22m',
                label: 'Per trip\nAvg Time',
                icon: Icons.access_time_rounded,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildBigStatTile(value: 248, label: 'Total Deliveries'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildBigStatTile(value: 67, label: 'Return Trips'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBigStatTile({required int value, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _AnimatedCounter(
            animation: _entrance,
            target: value.toDouble(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(fontSize: 11.5, color: AppColors.textHint),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Payout information card
  // ---------------------------------------------------------------------
  Widget _buildPayoutCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.primaryBlack,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(
                Icons.account_balance_wallet_outlined,
                color: AppColors.pureWhite,
                size: 16,
              ),
              SizedBox(width: 6),
              Text(
                'PAYOUT INFORMATION',
                style: TextStyle(
                  color: AppColors.textHint,
                  fontSize: 10.5,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Available Balance',
                      style: TextStyle(color: AppColors.textHint, fontSize: 12),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '₹2,750',
                      style: TextStyle(
                        color: AppColors.pureWhite,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Next Settlement',
                    style: TextStyle(color: AppColors.textHint, fontSize: 11),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Tomorrow',
                    style: TextStyle(
                      color: AppColors.pureWhite,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.pureWhite.withOpacity(0.06),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: const [
                Icon(Icons.credit_card, color: AppColors.pureWhite, size: 16),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment Method',
                      style: TextStyle(
                        color: AppColors.textHint,
                        fontSize: 10.5,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Bank Account •••• 4528',
                      style: TextStyle(
                        color: AppColors.pureWhite,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _HoverPressable(
                  onTap: () => _showCashOutSheet(context),
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
                        Icon(Icons.north_east, size: 15),
                        SizedBox(width: 6),
                        Text(
                          'Withdraw Now',
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
                  onTap: () => _openPaymentHistory(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(
                        color: AppColors.pureWhite.withOpacity(0.35),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Payment History',
                        style: TextStyle(
                          color: AppColors.pureWhite,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.5,
                        ),
                      ),
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
  // Achievements list
  // ---------------------------------------------------------------------
  Widget _buildAchievements() {
    return Column(
      children: _achievements.map((a) {
        final isLast = a == _achievements.last;
        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : 10),
          child: _HoverPressable(
            onTap: () => _toast('${a.title}: ${a.subtitle}'),
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
                    decoration: BoxDecoration(
                      color: a.color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(a.icon, color: a.color, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          a.title,
                          style: const TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          a.subtitle,
                          style: const TextStyle(
                            fontSize: 11.5,
                            color: AppColors.textSecondary,
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
          ),
        );
      }).toList(),
    );
  }

  // ---------------------------------------------------------------------
  // Cash out / withdraw bottom sheet
  // ---------------------------------------------------------------------
  void _showCashOutSheet(BuildContext context) {
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
                'Withdraw Earnings',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 6),
              const Text(
                '₹2,750 will be transferred to your linked bank account '
                'ending 4528 within 24 hours.',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
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
}

// =============================================================================
// Shared transaction card (used both on the Earnings tab preview and on the
// full "See All" history screen so the two never drift out of sync).
// =============================================================================
Widget _transactionCard(_Transaction txn, {VoidCallback? onTap}) {
  final credited = txn.status == _TxnStatus.credited;
  return _HoverPressable(
    onTap: onTap,
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
            decoration: BoxDecoration(
              color: (credited ? AppColors.success : Colors.orange).withOpacity(
                0.12,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              credited
                  ? Icons.arrow_downward_rounded
                  : Icons.hourglass_bottom_rounded,
              size: 18,
              color: credited ? AppColors.success : Colors.orange[700],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Trip ${txn.id}',
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  txn.type,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${txn.customer} · ${txn.route}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹${txn.amount}',
                style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: (credited ? AppColors.success : Colors.orange)
                      .withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  credited ? 'Credited' : 'Processing',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: credited ? AppColors.success : Colors.orange[800],
                  ),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '${txn.date} · ${txn.time}',
                style: const TextStyle(fontSize: 10, color: AppColors.textHint),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// =============================================================================
// "See All" — full transaction history screen
// =============================================================================
class _TransactionHistoryScreen extends StatelessWidget {
  final List<_Transaction> transactions;

  const _TransactionHistoryScreen({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F4F4),
        elevation: 0,
        title: const Text(
          'Transaction History',
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
            return _transactionCard(
              txn,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Trip ${txn.id} details — coming soon'),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: AppColors.primaryBlack,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// =============================================================================
// "Payment History" — settlement / payout history screen
// =============================================================================
class _PaymentHistoryScreen extends StatelessWidget {
  final List<_Payout> payouts;

  const _PaymentHistoryScreen({required this.payouts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F4F4),
        elevation: 0,
        title: const Text(
          'Payment History',
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
          itemCount: payouts.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, i) {
            final payout = payouts[i];
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
                      color: AppColors.success.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.account_balance_outlined,
                      size: 18,
                      color: AppColors.success,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          payout.id,
                          style: const TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Bank •••• ${payout.bankLast4}',
                          style: const TextStyle(
                            fontSize: 11.5,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          payout.date,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textHint,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '₹${payout.amount}',
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          payout.status,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.success,
                          ),
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
// Small reusable pieces
// =============================================================================

/// Wraps a tappable widget with a hover-lift effect (mouse, on web/desktop)
/// and a press-scale effect (touch, on mobile) so every interactive card on
/// this page feels alive without needing any extra packages.
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

/// Animates a numeric value counting up from 0 to [target] as [animation]
/// plays, used for the big headline earnings figure and stat tiles.
class _AnimatedCounter extends StatelessWidget {
  final Animation<double> animation;
  final double target;
  final String prefix;
  final TextStyle style;

  const _AnimatedCounter({
    required this.animation,
    required this.target,
    required this.style,
    this.prefix = '',
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final value = (target * animation.value).clamp(0, target);
        final display = value.round().toString();
        return Text('$prefix${_thousands(display)}', style: style);
      },
    );
  }

  String _thousands(String number) {
    final isNegative = number.startsWith('-');
    final digits = isNegative ? number.substring(1) : number;
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      final posFromEnd = digits.length - i;
      buffer.write(digits[i]);
      if (posFromEnd > 1 && posFromEnd % 3 == 1) {
        buffer.write(',');
      }
    }
    return '${isNegative ? '-' : ''}$buffer';
  }
}

/// A single animated bar in the weekly/monthly earnings chart. Grows from
/// 0 to its target height once mounted, with a small per-bar stagger.
class _AnimatedBar extends StatefulWidget {
  final double heightFactor;
  final double maxHeight;
  final Color color;
  final String label;
  final bool highlight;

  const _AnimatedBar({
    required this.heightFactor,
    required this.maxHeight,
    required this.color,
    required this.label,
    this.highlight = false,
  });

  @override
  State<_AnimatedBar> createState() => _AnimatedBarState();
}

class _AnimatedBarState extends State<_AnimatedBar> {
  double _factor = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _factor = widget.heightFactor);
    });
  }

  @override
  void didUpdateWidget(covariant _AnimatedBar old) {
    super.didUpdateWidget(old);
    if (old.heightFactor != widget.heightFactor) {
      setState(() => _factor = widget.heightFactor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOutCubic,
          height: (widget.maxHeight * _factor).clamp(4, widget.maxHeight),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 10.5,
            fontWeight: widget.highlight ? FontWeight.w700 : FontWeight.w500,
            color: widget.highlight
                ? AppColors.textPrimary
                : AppColors.textHint,
          ),
        ),
      ],
    );
  }
}

/// Small icon + value + label stat card used in Performance Insights.
class _MiniStat extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color? iconColor;

  const _MiniStat({
    required this.value,
    required this.label,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: iconColor ?? AppColors.textPrimary),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 9.5,
              color: AppColors.textHint,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Mock data models
// =============================================================================

class _CreditRow {
  final String label;
  final double amount;
  const _CreditRow(this.label, this.amount);
}

class _BreakdownItem {
  final String label;
  final double amount;
  final double total;
  const _BreakdownItem(this.label, this.amount, this.total);
}

class _SummaryCardData {
  final IconData icon;
  final int amount;
  final String label;
  final String caption;
  const _SummaryCardData({
    required this.icon,
    required this.amount,
    required this.label,
    required this.caption,
  });
}

enum _TxnStatus { credited, processing }

class _Transaction {
  final String id;
  final String type;
  final int amount;
  final _TxnStatus status;
  final String customer;
  final String route;
  final String time;
  final String date;
  const _Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.status,
    required this.customer,
    required this.route,
    required this.time,
    required this.date,
  });
}

class _Achievement {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  const _Achievement({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });
}

class _Payout {
  final String id;
  final int amount;
  final String date;
  final String bankLast4;
  final String status;
  const _Payout({
    required this.id,
    required this.amount,
    required this.date,
    required this.bankLast4,
    required this.status,
  });
}
