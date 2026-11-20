// import 'package:flutter/material.dart';
// import 'payment_success_screen.dart';

// class UtilityPaymentsScreen extends StatefulWidget {
//   final String bhkType;
//   final String city;
//   final String locality;

//   const UtilityPaymentsScreen({
//     super.key,
//     this.bhkType = '2 BHK',
//     this.city = 'Chennai',
//     this.locality = 'Anna Nagar',
//   });

//   @override
//   State<UtilityPaymentsScreen> createState() => _UtilityPaymentsScreenState();
// }

// class _UtilityPaymentsScreenState extends State<UtilityPaymentsScreen> {
//   static const Color primaryDark = Color(0xFF1A1A2E);
//   static const Color bgLight = Color(0xFFF8F9FC);

//   String selectedCategory = 'Electricity';

//   String selectedOperator = 'Jio';
//   String selectedPlan = '₹349 (28 days, 2 GB/Day)';
//   final TextEditingController mobileController =
//       TextEditingController(text: '9876543210');

//   final TextEditingController consumerNoController =
//       TextEditingController(text: '123456789012');
//   String selectedProvider = 'TNEB - Tamil Nadu';
//   final TextEditingController amountController =
//       TextEditingController(text: '1500');

//   final TextEditingController broadbandIdController =
//       TextEditingController(text: 'ACT1234567');
//   String selectedBroadbandProvider = 'ACT Fibernet';

//   final TextEditingController dthSubIdController =
//       TextEditingController(text: '1234567890');
//   String selectedDthProvider = 'Tata Play';
//   final TextEditingController dthAmountController =
//       TextEditingController(text: '300');

//   final List<String> operators = ['Jio', 'Airtel', 'Vi', 'BSNL'];
//   final List<String> plans = [
//     '₹349 (28 days, 2 GB/Day)',
//     '₹399 (56 days, 2 GB/day)',
//     '₹599 (84 days, 2 GB/day)',
//   ];

//   final Map<String, List<String>> providers = {
//     'Electricity': ['TNEB - Tamil Nadu', 'BESCOM', 'Adani Electricity', 'Tata Power'],
//     'Water': ['Chennai Metro Water', 'BWSSB', 'Municipal Corporation'],
//     'Gas': ['Indane Gas', 'HP Gas', 'Bharat Gas'],
//   };

//   final List<String> broadbandProviders = ['ACT Fibernet', 'Airtel Xstream', 'JioFiber', 'BSNL Broadband'];
//   final List<String> dthProviders = ['Tata Play', 'Dish TV', 'Airtel Digital TV', 'Sun Direct'];

//   final List<Map<String, dynamic>> categories = [
//     {
//       'label': 'Electricity',
//       'image': 'assets/images/my_house/electricity.png',
//       'icon': Icons.bolt_rounded,
//       'color': const Color(0xFFF5A623),
//     },
//     {
//       'label': 'Water',
//       'image': 'assets/images/my_house/water.png',
//       'icon': Icons.water_drop_rounded,
//       'color': const Color(0xFF3B82F6),
//     },
//     {
//       'label': 'Broadband',
//       'image': 'assets/images/my_house/broadband.png',
//       'icon': Icons.wifi_rounded,
//       'color': const Color(0xFF8B5CF6),
//     },
//     {
//       'label': 'Gas',
//       'image': 'assets/images/my_house/gas.png',
//       'icon': Icons.local_fire_department_rounded,
//       'color': const Color(0xFFEF4444),
//     },
//     {
//       'label': 'Mobile Recharge',
//       'image': 'assets/images/my_house/mobile_recharge.png',
//       'icon': Icons.phone_iphone_rounded,
//       'color': const Color(0xFF10B981),
//     },
//     {
//       'label': 'DTH',
//       'image': 'assets/images/my_house/dth.png',
//       'icon': Icons.live_tv_rounded,
//       'color': const Color(0xFFEC4899),
//     },
//   ];

//   final Map<String, Map<String, String>> recentPayments = {
//     'Electricity': {'sub': 'TNEB - Home', 'amount': '₹1,500', 'date': '08 May 2025'},
//     'Water': {'sub': 'Chennai Water', 'amount': '₹500', 'date': '07 May 2025'},
//     'Broadband': {'sub': 'ACT Fibernet', 'amount': '₹999', 'date': '06 May 2025'},
//     'Gas': {'sub': 'Indane Gas', 'amount': '₹850', 'date': '05 May 2025'},
//     'Mobile Recharge': {'sub': 'Jio Recharge', 'amount': '₹349', 'date': '04 May 2025'},
//     'DTH': {'sub': 'Tata Play', 'amount': '₹300', 'date': '03 May 2025'},
//   };

//   Color get _activeColor =>
//       categories.firstWhere((c) => c['label'] == selectedCategory)['color'] as Color;

//   IconData get _activeIcon =>
//       categories.firstWhere((c) => c['label'] == selectedCategory)['icon'] as IconData;

//   /// Screenshot-1 style card: a photo thumbnail (rounded corners) with a
//   /// small round icon badge overlapping its bottom-left corner, and the
//   /// category label underneath.
//   Widget _serviceCard(String label, String imagePath, IconData icon, Color color) {
//     final bool selected = selectedCategory == label;
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedCategory = label;
//           if (providers.containsKey(label) && !providers[label]!.contains(selectedProvider)) {
//             selectedProvider = providers[label]!.first;
//           }
//         });
//       },
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Stack(
//             clipBehavior: Clip.none,
//             children: [
//               AnimatedContainer(
//                 duration: const Duration(milliseconds: 200),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(14),
//                   border: Border.all(
//                     color: selected ? color : Colors.transparent,
//                     width: 2,
//                   ),
//                   boxShadow: selected
//                       ? [
//                           BoxShadow(
//                             color: color.withOpacity(0.30),
//                             blurRadius: 10,
//                             offset: const Offset(0, 4),
//                           ),
//                         ]
//                       : [],
//                 ),
//                 padding: const EdgeInsets.all(2),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: AspectRatio(
//                     aspectRatio: 1,
//                     child: Image.asset(
//                       imagePath,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) => Container(
//                         color: color.withOpacity(0.12),
//                         child: Icon(icon, color: color, size: 26),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               // Small round badge overlapping the bottom-left corner
//               Positioned(
//                 bottom: -6,
//                 left: -6,
//                 child: Container(
//                   padding: const EdgeInsets.all(3),
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                   ),
//                   child: CircleAvatar(
//                     radius: 11,
//                     backgroundColor: color,
//                     child: Icon(icon, size: 12, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           // Reduced spacing (10 -> 6) to free up a few pixels of height
//           const SizedBox(height: 6),
//           Text(
//             label,
//             textAlign: TextAlign.center,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(
//               fontSize: 11,
//               fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
//               color: primaryDark,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _label(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8, left: 2),
//       child: Text(
//         text,
//         style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w600),
//       ),
//     );
//   }

//   BoxDecoration _fieldDecoration() => BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: const Color(0xFFE4E6ED)),
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.04),
//             blurRadius: 6,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       );

//   Widget _textField(TextEditingController controller, {TextInputType? type}) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 14),
//       decoration: _fieldDecoration(),
//       child: TextField(
//         controller: controller,
//         keyboardType: type,
//         style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//         decoration: const InputDecoration(
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.symmetric(vertical: 14),
//         ),
//       ),
//     );
//   }

//   Widget _dropdownField({
//     required String value,
//     required List<String> items,
//     required ValueChanged<String?> onChanged,
//   }) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 14),
//       decoration: _fieldDecoration(),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           isExpanded: true,
//           value: value,
//           icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey[500]),
//           items: items
//               .map((item) => DropdownMenuItem(
//                     value: item,
//                     child: Text(item, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500)),
//                   ))
//               .toList(),
//           onChanged: onChanged,
//         ),
//       ),
//     );
//   }

//   Widget _sectionCard({required Widget child}) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.08),
//             blurRadius: 16,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: child,
//     );
//   }

//   String _currentAmountLabel() {
//     switch (selectedCategory) {
//       case 'Mobile Recharge':
//         return selectedPlan.split(' ').first;
//       case 'DTH':
//         return '₹${dthAmountController.text}';
//       case 'Broadband':
//         return '₹${broadbandIdController.text.isEmpty ? '999' : '999'}';
//       default:
//         return '₹${amountController.text}';
//     }
//   }

//   String _currentPayeeLabel() {
//     switch (selectedCategory) {
//       case 'Mobile Recharge':
//         return '$selectedOperator Recharge';
//       case 'DTH':
//         return selectedDthProvider;
//       case 'Broadband':
//         return selectedBroadbandProvider;
//       default:
//         return selectedProvider;
//     }
//   }

//   void _showPaymentSheet() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.white,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       builder: (context) {
//         final methods = [
//           {'label': 'UPI', 'sub': 'Google Pay, PhonePe, Paytm', 'icon': Icons.qr_code_rounded, 'color': const Color(0xFF10B981)},
//           {'label': 'Credit / Debit Card', 'sub': 'Visa, Mastercard, RuPay', 'icon': Icons.credit_card_rounded, 'color': const Color(0xFF3B82F6)},
//           {'label': 'Net Banking', 'sub': 'All major banks', 'icon': Icons.account_balance_rounded, 'color': const Color(0xFF8B5CF6)},
//           {'label': 'Wallet', 'sub': 'Amazon Pay, Mobikwik', 'icon': Icons.account_balance_wallet_rounded, 'color': const Color(0xFFF5A623)},
//         ];
//         return SafeArea(
//           child: Padding(
//             padding: EdgeInsets.fromLTRB(
//               20,
//               12,
//               20,
//               20 + MediaQuery.of(context).viewInsets.bottom,
//             ),
//             child: SingleChildScrollView(
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
//                         color: Colors.grey[300],
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                   const Text(
//                     'Choose Payment Method',
//                     style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: primaryDark),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     'Paying ${_currentAmountLabel()} to ${_currentPayeeLabel()}',
//                     style: TextStyle(fontSize: 13, color: Colors.grey[600]),
//                   ),
//                   const SizedBox(height: 18),
//                   ...methods.map((m) => Container(
//                         margin: const EdgeInsets.only(bottom: 10),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: const Color(0xFFECEDF3)),
//                           borderRadius: BorderRadius.circular(14),
//                         ),
//                         child: ListTile(
//                           contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//                           leading: Container(
//                             padding: const EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               color: (m['color'] as Color).withOpacity(0.12),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Icon(m['icon'] as IconData, color: m['color'] as Color, size: 20),
//                           ),
//                           title: Text(
//                             m['label'] as String,
//                             style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
//                           ),
//                           subtitle: Text(
//                             m['sub'] as String,
//                             style: TextStyle(fontSize: 11.5, color: Colors.grey[500]),
//                           ),
//                           trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
//                           onTap: () {
//                             Navigator.pop(context);
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => PaymentSuccessScreen(
//                                   amount: _currentAmountLabel(),
//                                   payee: _currentPayeeLabel(),
//                                   paymentMethod: '${m['label']} - Google Pay',
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       )),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _recentPaymentTile() {
//     final data = recentPayments[selectedCategory]!;
//     return Container(
//       margin: const EdgeInsets.only(top: 12),
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: bgLight,
//         borderRadius: BorderRadius.circular(14),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(9),
//             decoration: BoxDecoration(
//               color: _activeColor.withOpacity(0.12),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Icon(_activeIcon, size: 16, color: _activeColor),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(data['sub']!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
//                 const SizedBox(height: 2),
//                 Text(data['date']!, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
//               ],
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(data['amount']!, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 3),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF10B981).withOpacity(0.12),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: const Text(
//                   'Success',
//                   style: TextStyle(fontSize: 10, color: Color(0xFF10B981), fontWeight: FontWeight.w700),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildForm() {
//     switch (selectedCategory) {
//       case 'Mobile Recharge':
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _label('Mobile Number'),
//             _textField(mobileController, type: TextInputType.phone),
//             const SizedBox(height: 16),
//             _label('Operator'),
//             _dropdownField(
//               value: selectedOperator,
//               items: operators,
//               onChanged: (val) => setState(() => selectedOperator = val!),
//             ),
//             const SizedBox(height: 16),
//             _label('Select Plan'),
//             _dropdownField(
//               value: selectedPlan,
//               items: plans,
//               onChanged: (val) => setState(() => selectedPlan = val!),
//             ),
//           ],
//         );

//       case 'Broadband':
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _label('Select Provider'),
//             _dropdownField(
//               value: selectedBroadbandProvider,
//               items: broadbandProviders,
//               onChanged: (val) => setState(() => selectedBroadbandProvider = val!),
//             ),
//             const SizedBox(height: 16),
//             _label('Account Number'),
//             _textField(broadbandIdController),
//             const SizedBox(height: 16),
//             _label('Enter Amount'),
//             _textField(amountController, type: TextInputType.number),
//           ],
//         );

//       case 'DTH':
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _label('Select Provider'),
//             _dropdownField(
//               value: selectedDthProvider,
//               items: dthProviders,
//               onChanged: (val) => setState(() => selectedDthProvider = val!),
//             ),
//             const SizedBox(height: 16),
//             _label('Subscriber ID'),
//             _textField(dthSubIdController),
//             const SizedBox(height: 16),
//             _label('Enter Amount'),
//             _textField(dthAmountController, type: TextInputType.number),
//           ],
//         );

//       default:
//         // Electricity / Water / Gas
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _label('Select Provider'),
//             _dropdownField(
//               value: selectedProvider,
//               items: providers[selectedCategory] ?? ['Provider'],
//               onChanged: (val) => setState(() => selectedProvider = val!),
//             ),
//             const SizedBox(height: 16),
//             _label('Consumer Number'),
//             _textField(consumerNoController),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _label('Enter Amount'),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 8),
//                   child: GestureDetector(
//                     onTap: () {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Fetching latest bill...')),
//                       );
//                     },
//                     child: Text(
//                       'View Bill',
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w700,
//                         color: _activeColor,
//                         decoration: TextDecoration.underline,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             _textField(amountController, type: TextInputType.number),
//           ],
//         );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: bgLight,
//       appBar: AppBar(
//         backgroundColor: bgLight,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: primaryDark),
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             Text(
//               'Utility Payments',
//               style: TextStyle(color: primaryDark, fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             Text(
//               'Pay all your bills in one place',
//               style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.normal),
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _sectionCard(
//               child: GridView.count(
//                 crossAxisCount: 3,
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 mainAxisSpacing: 18,
//                 crossAxisSpacing: 14,
//                 // Lowered from 0.85 -> 0.72 so each grid cell gets more
//                 // height. This is what was causing the
//                 // "BOTTOM OVERFLOWED BY 8.1 PIXELS" error — the cell
//                 // (driven by childAspectRatio) was a few pixels too
//                 // short for the image + spacing + label inside it.
//                 childAspectRatio: 0.72,
//                 children: categories
//                     .map((c) => _serviceCard(
//                           c['label'] as String,
//                           c['image'] as String,
//                           c['icon'] as IconData,
//                           c['color'] as Color,
//                         ))
//                     .toList(),
//               ),
//             ),

//             const SizedBox(height: 20),

//             _sectionCard(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: _activeColor.withOpacity(0.12),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Icon(_activeIcon, size: 18, color: _activeColor),
//                       ),
//                       const SizedBox(width: 10),
//                       Text(
//                         selectedCategory,
//                         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: primaryDark),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 18),
//                   _buildForm(),
//                   const SizedBox(height: 22),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 52,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: primaryDark,
//                         elevation: 0,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(14),
//                         ),
//                       ),
//                       onPressed: _showPaymentSheet,
//                       child: const Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.lock_rounded, size: 17, color: Colors.white),
//                           SizedBox(width: 8),
//                           Text(
//                             'Proceed to Pay',
//                             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 18),
//                   const Text(
//                     'Recent Payments',
//                     style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: primaryDark),
//                   ),
//                   _recentPaymentTile(),
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
import 'payment_success_screen.dart';

class UtilityPaymentsScreen extends StatefulWidget {
  final String bhkType;
  final String city;
  final String locality;

  const UtilityPaymentsScreen({
    super.key,
    this.bhkType = '2 BHK',
    this.city = 'Chennai',
    this.locality = 'Anna Nagar',
  });

  @override
  State<UtilityPaymentsScreen> createState() => _UtilityPaymentsScreenState();
}

class _UtilityPaymentsScreenState extends State<UtilityPaymentsScreen> {
  static const Color primaryDark = Color(0xFF1A1A2E);
  static const Color bgLight = Color(0xFFF8F9FC);

  String selectedCategory = 'Electricity';

  String selectedOperator = 'Jio';
  String selectedPlan = '₹349 (28 days, 2 GB/Day)';
  final TextEditingController mobileController =
      TextEditingController(text: '9876543210');

  final TextEditingController consumerNoController =
      TextEditingController(text: '123456789012');
  String selectedProvider = 'TNEB - Tamil Nadu';
  final TextEditingController amountController =
      TextEditingController(text: '1500');

  final TextEditingController broadbandIdController =
      TextEditingController(text: 'ACT1234567');
  String selectedBroadbandProvider = 'ACT Fibernet';

  final TextEditingController dthSubIdController =
      TextEditingController(text: '1234567890');
  String selectedDthProvider = 'Tata Play';
  final TextEditingController dthAmountController =
      TextEditingController(text: '300');

  final List<String> operators = ['Jio', 'Airtel', 'Vi', 'BSNL'];
  final List<String> plans = [
    '₹349 (28 days, 2 GB/Day)',
    '₹399 (56 days, 2 GB/day)',
    '₹599 (84 days, 2 GB/day)',
  ];

  final Map<String, List<String>> providers = {
    'Electricity': ['TNEB - Tamil Nadu', 'BESCOM', 'Adani Electricity', 'Tata Power'],
    'Water': ['Chennai Metro Water', 'BWSSB', 'Municipal Corporation'],
    'Gas': ['Indane Gas', 'HP Gas', 'Bharat Gas'],
  };

  final List<String> broadbandProviders = ['ACT Fibernet', 'Airtel Xstream', 'JioFiber', 'BSNL Broadband'];
  final List<String> dthProviders = ['Tata Play', 'Dish TV', 'Airtel Digital TV', 'Sun Direct'];

  final List<Map<String, dynamic>> categories = [
    {
      'label': 'Electricity',
      'image': 'assets/images/my_house/electricity.png',
      'icon': Icons.bolt_rounded,
      'color': const Color(0xFFF5A623),
    },
    {
      'label': 'Water',
      'image': 'assets/images/my_house/water.png',
      'icon': Icons.water_drop_rounded,
      'color': const Color(0xFF3B82F6),
    },
    {
      'label': 'Broadband',
      'image': 'assets/images/my_house/broadband.png',
      'icon': Icons.wifi_rounded,
      'color': const Color(0xFF8B5CF6),
    },
    {
      'label': 'Gas',
      'image': 'assets/images/my_house/gas.png',
      'icon': Icons.local_fire_department_rounded,
      'color': const Color(0xFFEF4444),
    },
    {
      'label': 'Mobile Recharge',
      'image': 'assets/images/my_house/mobile_recharge.png',
      'icon': Icons.phone_iphone_rounded,
      'color': const Color(0xFF10B981),
    },
    {
      'label': 'DTH',
      'image': 'assets/images/my_house/dth.png',
      'icon': Icons.live_tv_rounded,
      'color': const Color(0xFFEC4899),
    },
  ];

  final Map<String, Map<String, String>> recentPayments = {
    'Electricity': {'sub': 'TNEB - Home', 'amount': '₹1,500', 'date': '08 May 2025'},
    'Water': {'sub': 'Chennai Water', 'amount': '₹500', 'date': '07 May 2025'},
    'Broadband': {'sub': 'ACT Fibernet', 'amount': '₹999', 'date': '06 May 2025'},
    'Gas': {'sub': 'Indane Gas', 'amount': '₹850', 'date': '05 May 2025'},
    'Mobile Recharge': {'sub': 'Jio Recharge', 'amount': '₹349', 'date': '04 May 2025'},
    'DTH': {'sub': 'Tata Play', 'amount': '₹300', 'date': '03 May 2025'},
  };

  Color get _activeColor =>
      categories.firstWhere((c) => c['label'] == selectedCategory)['color'] as Color;

  IconData get _activeIcon =>
      categories.firstWhere((c) => c['label'] == selectedCategory)['icon'] as IconData;

  /// Screenshot-1 style card: a photo thumbnail (rounded corners) with a
  /// small round icon badge overlapping its bottom-left corner, and the
  /// category label underneath.
  Widget _serviceCard(String label, String imagePath, IconData icon, Color color) {
    final bool selected = selectedCategory == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = label;
          if (providers.containsKey(label) && !providers[label]!.contains(selectedProvider)) {
            selectedProvider = providers[label]!.first;
          }
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: selected ? color : Colors.transparent,
                    width: 2,
                  ),
                  boxShadow: selected
                      ? [
                          BoxShadow(
                            color: color.withOpacity(0.30),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
                padding: const EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: color.withOpacity(0.12),
                        child: Icon(icon, color: color, size: 26),
                      ),
                    ),
                  ),
                ),
              ),
              // Small round badge overlapping the bottom-left corner
              Positioned(
                bottom: -6,
                left: -6,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 11,
                    backgroundColor: color,
                    child: Icon(icon, size: 12, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          // Reduced spacing (10 -> 6) to free up a few pixels of height
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
              color: primaryDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 2),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w600),
      ),
    );
  }

  BoxDecoration _fieldDecoration() => BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE4E6ED)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      );

  Widget _textField(TextEditingController controller, {TextInputType? type}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: _fieldDecoration(),
      child: TextField(
        controller: controller,
        keyboardType: type,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _dropdownField({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: _fieldDecoration(),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey[500]),
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500)),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _sectionCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }

  String _currentAmountLabel() {
    switch (selectedCategory) {
      case 'Mobile Recharge':
        return selectedPlan.split(' ').first;
      case 'DTH':
        return '₹${dthAmountController.text}';
      case 'Broadband':
        return '₹${broadbandIdController.text.isEmpty ? '999' : '999'}';
      default:
        return '₹${amountController.text}';
    }
  }

  String _currentPayeeLabel() {
    switch (selectedCategory) {
      case 'Mobile Recharge':
        return '$selectedOperator Recharge';
      case 'DTH':
        return selectedDthProvider;
      case 'Broadband':
        return selectedBroadbandProvider;
      default:
        return selectedProvider;
    }
  }

  void _showPaymentSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final methods = [
          {'label': 'UPI', 'sub': 'Google Pay, PhonePe, Paytm', 'icon': Icons.qr_code_rounded, 'color': const Color(0xFF10B981)},
          {'label': 'Credit / Debit Card', 'sub': 'Visa, Mastercard, RuPay', 'icon': Icons.credit_card_rounded, 'color': const Color(0xFF3B82F6)},
          {'label': 'Net Banking', 'sub': 'All major banks', 'icon': Icons.account_balance_rounded, 'color': const Color(0xFF8B5CF6)},
          {'label': 'Wallet', 'sub': 'Amazon Pay, Mobikwik', 'icon': Icons.account_balance_wallet_rounded, 'color': const Color(0xFFF5A623)},
        ];
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              12,
              20,
              20 + MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
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
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const Text(
                    'Choose Payment Method',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: primaryDark),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Paying ${_currentAmountLabel()} to ${_currentPayeeLabel()}',
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 18),
                  ...methods.map((m) => Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFECEDF3)),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: (m['color'] as Color).withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(m['icon'] as IconData, color: m['color'] as Color, size: 20),
                          ),
                          title: Text(
                            m['label'] as String,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text(
                            m['sub'] as String,
                            style: TextStyle(fontSize: 11.5, color: Colors.grey[500]),
                          ),
                          trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentSuccessScreen(
                                  amount: _currentAmountLabel(),
                                  payee: _currentPayeeLabel(),
                                  paymentMethod: '${m['label']} - Google Pay',
                                ),
                              ),
                            );
                          },
                        ),
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _recentPaymentTile() {
    final data = recentPayments[selectedCategory]!;
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgLight,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: _activeColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(_activeIcon, size: 16, color: _activeColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data['sub']!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(data['date']!, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(data['amount']!, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold)),
              const SizedBox(height: 3),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Success',
                  style: TextStyle(fontSize: 10, color: Color(0xFF10B981), fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    switch (selectedCategory) {
      case 'Mobile Recharge':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label('Mobile Number'),
            _textField(mobileController, type: TextInputType.phone),
            const SizedBox(height: 16),
            _label('Operator'),
            _dropdownField(
              value: selectedOperator,
              items: operators,
              onChanged: (val) => setState(() => selectedOperator = val!),
            ),
            const SizedBox(height: 16),
            _label('Select Plan'),
            _dropdownField(
              value: selectedPlan,
              items: plans,
              onChanged: (val) => setState(() => selectedPlan = val!),
            ),
          ],
        );

      case 'Broadband':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label('Select Provider'),
            _dropdownField(
              value: selectedBroadbandProvider,
              items: broadbandProviders,
              onChanged: (val) => setState(() => selectedBroadbandProvider = val!),
            ),
            const SizedBox(height: 16),
            _label('Account Number'),
            _textField(broadbandIdController),
            const SizedBox(height: 16),
            _label('Enter Amount'),
            _textField(amountController, type: TextInputType.number),
          ],
        );

      case 'DTH':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label('Select Provider'),
            _dropdownField(
              value: selectedDthProvider,
              items: dthProviders,
              onChanged: (val) => setState(() => selectedDthProvider = val!),
            ),
            const SizedBox(height: 16),
            _label('Subscriber ID'),
            _textField(dthSubIdController),
            const SizedBox(height: 16),
            _label('Enter Amount'),
            _textField(dthAmountController, type: TextInputType.number),
          ],
        );

      default:
        // Electricity / Water / Gas
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label('Select Provider'),
            _dropdownField(
              value: selectedProvider,
              items: providers[selectedCategory] ?? ['Provider'],
              onChanged: (val) => setState(() => selectedProvider = val!),
            ),
            const SizedBox(height: 16),
            _label('Consumer Number'),
            _textField(consumerNoController),
            const SizedBox(height: 16),
            _label('Enter Amount'),
            _textField(amountController, type: TextInputType.number),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgLight,
      appBar: AppBar(
        backgroundColor: bgLight,
        elevation: 0,
        iconTheme: const IconThemeData(color: primaryDark),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Utility Payments',
              style: TextStyle(color: primaryDark, fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              'Pay all your bills in one place',
              style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionCard(
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 18,
                crossAxisSpacing: 14,
                // Lowered from 0.85 -> 0.72 so each grid cell gets more
                // height. This is what was causing the
                // "BOTTOM OVERFLOWED BY 8.1 PIXELS" error — the cell
                // (driven by childAspectRatio) was a few pixels too
                // short for the image + spacing + label inside it.
                childAspectRatio: 0.72,
                children: categories
                    .map((c) => _serviceCard(
                          c['label'] as String,
                          c['image'] as String,
                          c['icon'] as IconData,
                          c['color'] as Color,
                        ))
                    .toList(),
              ),
            ),

            const SizedBox(height: 20),

            _sectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _activeColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(_activeIcon, size: 18, color: _activeColor),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        selectedCategory,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: primaryDark),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  _buildForm(),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryDark,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: _showPaymentSheet,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.lock_rounded, size: 17, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Proceed to Pay',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Recent Payments',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: primaryDark),
                  ),
                  _recentPaymentTile(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
