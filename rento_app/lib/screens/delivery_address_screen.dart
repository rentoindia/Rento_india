// // import 'package:flutter/material.dart';
// // import '../theme/app_theme.dart';
// // import '../widgets/primary_button.dart';
// // import '../services/orders_service.dart';
// // import 'rental_order.dart';
// // import 'select_duration_screen.dart' show BookingStepper;
// // import 'vendor_approval_screen.dart';

// // class _SavedAddress {
// //   final String label;
// //   final String line;
// //   final IconData icon;
// //   final bool isDefault;
// //   const _SavedAddress({required this.label, required this.line, required this.icon, this.isDefault = false});
// // }

// // class DeliveryAddressScreen extends StatefulWidget {
// //   final RentalOrder order;
// //   const DeliveryAddressScreen({super.key, required this.order});

// //   @override
// //   State<DeliveryAddressScreen> createState() => _DeliveryAddressScreenState();
// // }

// // class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
// //   int _selectedSaved = 0;
// //   bool _addingNew = false;
// //   String _addressType = 'Home';
// //   bool _setAsDefault = true;

// //   final _nameController = TextEditingController();
// //   final _phoneController = TextEditingController();
// //   final _addressController = TextEditingController();
// //   final _cityController = TextEditingController();
// //   final _pincodeController = TextEditingController();

// //   final List<_SavedAddress> _saved = const [
// //     _SavedAddress(label: 'Home', line: '102 Marine Lines, Churchgate, Mumbai 400020', icon: Icons.home_outlined, isDefault: true),
// //     _SavedAddress(label: 'Office', line: '15, Powai Techno Park, Powai, Mumbai 400076', icon: Icons.apartment_outlined),
// //   ];

// //   @override
// //   void dispose() {
// //     _nameController.dispose();
// //     _phoneController.dispose();
// //     _addressController.dispose();
// //     _cityController.dispose();
// //     _pincodeController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         foregroundColor: Colors.black,
// //         leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
// //         title: const Text('Delivery Address', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16)),
// //         actions: const [
// //           Padding(
// //             padding: EdgeInsets.only(right: 16),
// //             child: Center(
// //               child: Row(children: [
// //                 Icon(Icons.verified_user_outlined, size: 15, color: Colors.black54),
// //                 SizedBox(width: 4),
// //                 //Text('Secure Checkout', style: TextStyle(fontSize: 11, color: Colors.black54)),
// //               ]),
// //             ),
// //           ),
// //         ],
// //       ),
// //       body: SafeArea(
// //         child: ListView(
// //           padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
// //           children: [
// //             const BookingStepper(currentStep: 2),
// //             const SizedBox(height: 18),
// //             _buildMapPlaceholder(),
// //             const SizedBox(height: 16),
// //             const Text('Saved Addresses', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5)),
// //             const SizedBox(height: 10),
// //             ..._saved.asMap().entries.map((entry) => _savedAddressCard(entry.key, entry.value)),
// //             const SizedBox(height: 6),
// //             GestureDetector(
// //               onTap: () => setState(() => _addingNew = !_addingNew),
// //               child: Row(
// //                 children: [
// //                   Icon(_addingNew ? Icons.remove_circle_outline : Icons.add_circle_outline, size: 18, color: Colors.black),
// //                   const SizedBox(width: 8),
// //                   Text(_addingNew ? 'Cancel' : 'Add New Address',
// //                       style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
// //                 ],
// //               ),
// //             ),
// //             if (_addingNew) ...[
// //               const SizedBox(height: 16),
// //               _buildNewAddressForm(),
// //             ],
// //             const SizedBox(height: 20),
// //             Container(
// //               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
// //               decoration: BoxDecoration(color: AppTheme.lightGrey, borderRadius: BorderRadius.circular(12)),
// //               child: Row(
// //                 children: [
// //                   const Icon(Icons.shield_outlined, size: 18, color: Colors.black54),
// //                   const SizedBox(width: 8),
// //                   Expanded(
// //                     child: Text(
// //                       'Safe & Secure Delivery — your address is secure and will only be used for delivery purposes.',
// //                       style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700, height: 1.3),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //       bottomNavigationBar: SafeArea(
// //         child: Padding(
// //           padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
// //           child: PrimaryButton(
// //             label: 'SAVE & CONTINUE',
// //             icon: Icons.arrow_forward,
// //             onPressed: _handleContinue,
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   void _handleContinue() {
// //     String addressText;
// //     if (_addingNew && _addressController.text.trim().isNotEmpty) {
// //       addressText = '${_addressController.text.trim()}, ${_cityController.text.trim()} ${_pincodeController.text.trim()}';
// //     } else {
// //       addressText = _saved[_selectedSaved].line;
// //     }
// //     final updatedOrder = widget.order.copyWith(deliveryAddress: addressText);
// //     OrdersService.instance.upsert(updatedOrder);
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(builder: (_) => VendorApprovalScreen(order: updatedOrder)),
// //     );
// //   }

// //   Widget _buildMapPlaceholder() {
// //     return Container(
// //       height: 140,
// //       decoration: BoxDecoration(
// //         color: const Color(0xFFEFEFEF),
// //         borderRadius: BorderRadius.circular(14),
// //       ),
// //       child: Stack(
// //         alignment: Alignment.center,
// //         children: [
// //           CustomPaint(size: const Size.fromHeight(140), painter: _MapGridPainter()),
// //           Container(
// //             width: 40,
// //             height: 40,
// //             decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
// //             child: const Icon(Icons.location_on, color: Colors.white, size: 20),
// //           ),
// //           Positioned(
// //             bottom: 10,
// //             right: 10,
// //             child: GestureDetector(
// //               onTap: () => ScaffoldMessenger.of(context).showSnackBar(
// //                 const SnackBar(content: Text('Detecting your current location...')),
// //               ),
// //               child: Container(
// //                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// //                 decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
// //                   BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6),
// //                 ]),
// //                 child: const Row(mainAxisSize: MainAxisSize.min, children: [
// //                   Icon(Icons.my_location, size: 14),
// //                   SizedBox(width: 6),
// //                   Text('Use Current Location', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
// //                 ]),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _savedAddressCard(int index, _SavedAddress addr) {
// //     final selected = _selectedSaved == index && !_addingNew;
// //     return GestureDetector(
// //       onTap: () => setState(() {
// //         _selectedSaved = index;
// //         _addingNew = false;
// //       }),
// //       child: Container(
// //         margin: const EdgeInsets.only(bottom: 10),
// //         padding: const EdgeInsets.all(12),
// //         decoration: BoxDecoration(
// //           border: Border.all(color: selected ? Colors.black : AppTheme.border, width: selected ? 1.5 : 1),
// //           borderRadius: BorderRadius.circular(12),
// //         ),
// //         child: Row(
// //           children: [
// //             Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off, size: 18, color: selected ? Colors.black : Colors.grey.shade400),
// //             const SizedBox(width: 10),
// //             Icon(addr.icon, size: 18, color: Colors.black87),
// //             const SizedBox(width: 8),
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Row(children: [
// //                     Text(addr.label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
// //                     if (addr.isDefault) ...[
// //                       const SizedBox(width: 6),
// //                       Container(
// //                         padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
// //                         decoration: BoxDecoration(color: AppTheme.lightGrey, borderRadius: BorderRadius.circular(6)),
// //                         child: const Text('Default', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700)),
// //                       ),
// //                     ],
// //                   ]),
// //                   Text(addr.line, style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600)),
// //                 ],
// //               ),
// //             ),
// //             const Icon(Icons.more_vert, size: 18, color: Colors.black38),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildNewAddressForm() {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         const Text('Add New Address', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
// //         const SizedBox(height: 10),
// //         _field(_nameController, 'Full Name', Icons.person_outline),
// //         _field(_phoneController, 'Phone Number', Icons.call_outlined, keyboardType: TextInputType.phone),
// //         _field(_addressController, 'House No., Street, Area', Icons.home_outlined),
// //         Row(children: [
// //           Expanded(child: _field(_cityController, 'City', Icons.location_city_outlined)),
// //           const SizedBox(width: 10),
// //           Expanded(child: _field(_pincodeController, 'Pincode', Icons.pin_drop_outlined, keyboardType: TextInputType.number)),
// //         ]),
// //         const SizedBox(height: 6),
// //         const Text('Address Type', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.5)),
// //         const SizedBox(height: 8),
// //         Row(
// //           children: ['Home', 'Office', 'Other'].map((t) {
// //             final selected = _addressType == t;
// //             return Padding(
// //               padding: const EdgeInsets.only(right: 10),
// //               child: GestureDetector(
// //                 onTap: () => setState(() => _addressType = t),
// //                 child: Row(mainAxisSize: MainAxisSize.min, children: [
// //                   Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off, size: 16, color: selected ? Colors.black : Colors.grey.shade400),
// //                   const SizedBox(width: 4),
// //                   Text(t, style: const TextStyle(fontSize: 12.5)),
// //                 ]),
// //               ),
// //             );
// //           }).toList(),
// //         ),
// //         const SizedBox(height: 8),
// //         GestureDetector(
// //           onTap: () => setState(() => _setAsDefault = !_setAsDefault),
// //           child: Row(children: [
// //             Icon(_setAsDefault ? Icons.check_box : Icons.check_box_outline_blank, size: 18, color: Colors.black),
// //             const SizedBox(width: 8),
// //             const Text('Set as default address', style: TextStyle(fontSize: 12.5)),
// //           ]),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _field(TextEditingController controller, String hint, IconData icon, {TextInputType? keyboardType}) {
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 10),
// //       child: TextField(
// //         controller: controller,
// //         keyboardType: keyboardType,
// //         decoration: InputDecoration(
// //           hintText: hint,
// //           hintStyle: TextStyle(fontSize: 12.5, color: Colors.grey.shade500),
// //           prefixIcon: Icon(icon, size: 18),
// //           isDense: true,
// //           contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
// //           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppTheme.border)),
// //           enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppTheme.border)),
// //           focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black)),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // Faint grid lines to suggest "map" without needing a maps SDK/API key.
// // class _MapGridPainter extends CustomPainter {
// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     final paint = Paint()
// //       ..color = Colors.black.withOpacity(0.06)
// //       ..strokeWidth = 1;
// //     for (double x = 0; x < size.width; x += 24) {
// //       canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
// //     }
// //     for (double y = 0; y < size.height; y += 24) {
// //       canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
// //     }
// //   }

// //   @override
// //   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// // }


























// import 'package:flutter/material.dart';
// import '../theme/app_theme.dart';
// import '../widgets/primary_button.dart';
// import '../services/orders_service.dart';
// import 'rental_order.dart';
// import 'select_duration_screen.dart' show BookingStepper;
// import 'vendor_approval_screen.dart';

// class _SavedAddress {
//   final String label;
//   final String line;
//   final IconData icon;
//   final bool isDefault;
//   const _SavedAddress({required this.label, required this.line, required this.icon, this.isDefault = false});
// }

// class DeliveryAddressScreen extends StatefulWidget {
//   final RentalOrder order;
//   const DeliveryAddressScreen({super.key, required this.order});

//   @override
//   State<DeliveryAddressScreen> createState() => _DeliveryAddressScreenState();
// }

// class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
//   int _selectedSaved = 0;
//   bool _addingNew = false;
//   String _addressType = 'Home';
//   bool _setAsDefault = true;

//   // Delivery time SLOT, not an exact minute — no rider can honestly
//   // promise "2:45 PM"; a 2-hour window is what real delivery apps
//   // actually commit to.
//   late DateTime _deliveryDate;
//   int _selectedSlot = 0;
//   final List<String> _deliverySlots = const [
//     '10:00 AM - 12:00 PM',
//     '12:00 PM - 02:00 PM',
//     '02:00 PM - 04:00 PM',
//     '04:00 PM - 06:00 PM',
//     '06:00 PM - 08:00 PM',
//   ];

//   final _nameController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _addressController = TextEditingController();
//   final _cityController = TextEditingController();
//   final _pincodeController = TextEditingController();

//   final List<_SavedAddress> _saved = const [
//     _SavedAddress(label: 'Home', line: '102 Marine Lines, Churchgate, Mumbai 400020', icon: Icons.home_outlined, isDefault: true),
//     _SavedAddress(label: 'Office', line: '15, Powai Techno Park, Powai, Mumbai 400076', icon: Icons.apartment_outlined),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _deliveryDate = widget.order.startDate;
//   }

//   Future<void> _pickDeliveryDate() async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: _deliveryDate,
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(const Duration(days: 30)),
//     );
//     if (picked != null) setState(() => _deliveryDate = picked);
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _phoneController.dispose();
//     _addressController.dispose();
//     _cityController.dispose();
//     _pincodeController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         foregroundColor: Colors.black,
//         leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
//         title: const Text('Delivery Address', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16)),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 16),
//             child: Center(
//               child: Row(children: [
//                 Icon(Icons.verified_user_outlined, size: 15, color: Colors.black54),
//                 SizedBox(width: 4),
//                 Text('Secure Checkout', style: TextStyle(fontSize: 11, color: Colors.black54)),
//               ]),
//             ),
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: ListView(
//           padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
//           children: [
//             const BookingStepper(currentStep: 2),
//             const SizedBox(height: 18),
//             _buildMapPlaceholder(),
//             const SizedBox(height: 16),
//             const Text('Saved Addresses', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5)),
//             const SizedBox(height: 10),
//             ..._saved.asMap().entries.map((entry) => _savedAddressCard(entry.key, entry.value)),
//             const SizedBox(height: 6),
//             GestureDetector(
//               onTap: () => setState(() => _addingNew = !_addingNew),
//               child: Row(
//                 children: [
//                   Icon(_addingNew ? Icons.remove_circle_outline : Icons.add_circle_outline, size: 18, color: Colors.black),
//                   const SizedBox(width: 8),
//                   Text(_addingNew ? 'Cancel' : 'Add New Address',
//                       style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
//                 ],
//               ),
//             ),
//             if (_addingNew) ...[
//               const SizedBox(height: 16),
//               _buildNewAddressForm(),
//             ],
//             const SizedBox(height: 20),
//             const Text('Preferred Delivery Slot', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5)),
//             const SizedBox(height: 4),
//             Text('We\'ll deliver within your chosen 2-hour window — not an exact minute.',
//                 style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600)),
//             const SizedBox(height: 10),
//             GestureDetector(
//               onTap: _pickDeliveryDate,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//                 decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(10)),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(RentalOrder.formatDate(_deliveryDate), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
//                     const Icon(Icons.calendar_today_outlined, size: 16, color: Colors.black54),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             ..._deliverySlots.asMap().entries.map((entry) {
//               final selected = _selectedSlot == entry.key;
//               return GestureDetector(
//                 onTap: () => setState(() => _selectedSlot = entry.key),
//                 child: Container(
//                   margin: const EdgeInsets.only(bottom: 8),
//                   padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: selected ? Colors.black : AppTheme.border, width: selected ? 1.5 : 1),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off, size: 18, color: selected ? Colors.black : Colors.grey.shade400),
//                       const SizedBox(width: 10),
//                       Text(entry.value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
//                     ],
//                   ),
//                 ),
//               );
//             }),
//             const SizedBox(height: 12),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//               decoration: BoxDecoration(color: AppTheme.lightGrey, borderRadius: BorderRadius.circular(12)),
//               child: Row(
//                 children: [
//                   const Icon(Icons.shield_outlined, size: 18, color: Colors.black54),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: Text(
//                       'Safe & Secure Delivery — your address is secure and will only be used for delivery purposes.',
//                       style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700, height: 1.3),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
//           child: PrimaryButton(
//             label: 'SAVE & CONTINUE',
//             icon: Icons.arrow_forward,
//             onPressed: _handleContinue,
//           ),
//         ),
//       ),
//     );
//   }

//   void _handleContinue() {
//     String addressText;
//     if (_addingNew && _addressController.text.trim().isNotEmpty) {
//       addressText = '${_addressController.text.trim()}, ${_cityController.text.trim()} ${_pincodeController.text.trim()}';
//     } else {
//       addressText = _saved[_selectedSaved].line;
//     }
//     final updatedOrder = widget.order.copyWith(
//       deliveryAddress: addressText,
//       deliveryDate: _deliveryDate,
//       deliverySlot: _deliverySlots[_selectedSlot],
//     );
//     OrdersService.instance.upsert(updatedOrder);
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => VendorApprovalScreen(order: updatedOrder)),
//     );
//   }

//   Widget _buildMapPlaceholder() {
//     return Container(
//       height: 140,
//       decoration: BoxDecoration(
//         color: const Color(0xFFEFEFEF),
//         borderRadius: BorderRadius.circular(14),
//       ),
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           CustomPaint(size: const Size.fromHeight(140), painter: _MapGridPainter()),
//           Container(
//             width: 40,
//             height: 40,
//             decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
//             child: const Icon(Icons.location_on, color: Colors.white, size: 20),
//           ),
//           Positioned(
//             bottom: 10,
//             right: 10,
//             child: GestureDetector(
//               onTap: () => ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Detecting your current location...')),
//               ),
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
//                   BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6),
//                 ]),
//                 child: const Row(mainAxisSize: MainAxisSize.min, children: [
//                   Icon(Icons.my_location, size: 14),
//                   SizedBox(width: 6),
//                   Text('Use Current Location', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
//                 ]),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _savedAddressCard(int index, _SavedAddress addr) {
//     final selected = _selectedSaved == index && !_addingNew;
//     return GestureDetector(
//       onTap: () => setState(() {
//         _selectedSaved = index;
//         _addingNew = false;
//       }),
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 10),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           border: Border.all(color: selected ? Colors.black : AppTheme.border, width: selected ? 1.5 : 1),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           children: [
//             Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off, size: 18, color: selected ? Colors.black : Colors.grey.shade400),
//             const SizedBox(width: 10),
//             Icon(addr.icon, size: 18, color: Colors.black87),
//             const SizedBox(width: 8),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(children: [
//                     Text(addr.label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
//                     if (addr.isDefault) ...[
//                       const SizedBox(width: 6),
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                         decoration: BoxDecoration(color: AppTheme.lightGrey, borderRadius: BorderRadius.circular(6)),
//                         child: const Text('Default', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700)),
//                       ),
//                     ],
//                   ]),
//                   Text(addr.line, style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600)),
//                 ],
//               ),
//             ),
//             const Icon(Icons.more_vert, size: 18, color: Colors.black38),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNewAddressForm() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text('Add New Address', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
//         const SizedBox(height: 10),
//         _field(_nameController, 'Full Name', Icons.person_outline),
//         _field(_phoneController, 'Phone Number', Icons.call_outlined, keyboardType: TextInputType.phone),
//         _field(_addressController, 'House No., Street, Area', Icons.home_outlined),
//         Row(children: [
//           Expanded(child: _field(_cityController, 'City', Icons.location_city_outlined)),
//           const SizedBox(width: 10),
//           Expanded(child: _field(_pincodeController, 'Pincode', Icons.pin_drop_outlined, keyboardType: TextInputType.number)),
//         ]),
//         const SizedBox(height: 6),
//         const Text('Address Type', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.5)),
//         const SizedBox(height: 8),
//         Row(
//           children: ['Home', 'Office', 'Other'].map((t) {
//             final selected = _addressType == t;
//             return Padding(
//               padding: const EdgeInsets.only(right: 10),
//               child: GestureDetector(
//                 onTap: () => setState(() => _addressType = t),
//                 child: Row(mainAxisSize: MainAxisSize.min, children: [
//                   Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off, size: 16, color: selected ? Colors.black : Colors.grey.shade400),
//                   const SizedBox(width: 4),
//                   Text(t, style: const TextStyle(fontSize: 12.5)),
//                 ]),
//               ),
//             );
//           }).toList(),
//         ),
//         const SizedBox(height: 8),
//         GestureDetector(
//           onTap: () => setState(() => _setAsDefault = !_setAsDefault),
//           child: Row(children: [
//             Icon(_setAsDefault ? Icons.check_box : Icons.check_box_outline_blank, size: 18, color: Colors.black),
//             const SizedBox(width: 8),
//             const Text('Set as default address', style: TextStyle(fontSize: 12.5)),
//           ]),
//         ),
//       ],
//     );
//   }

//   Widget _field(TextEditingController controller, String hint, IconData icon, {TextInputType? keyboardType}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: TextField(
//         controller: controller,
//         keyboardType: keyboardType,
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle: TextStyle(fontSize: 12.5, color: Colors.grey.shade500),
//           prefixIcon: Icon(icon, size: 18),
//           isDense: true,
//           contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppTheme.border)),
//           enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppTheme.border)),
//           focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black)),
//         ),
//       ),
//     );
//   }
// }

// // Faint grid lines to suggest "map" without needing a maps SDK/API key.
// class _MapGridPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.black.withOpacity(0.06)
//       ..strokeWidth = 1;
//     for (double x = 0; x < size.width; x += 24) {
//       canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
//     }
//     for (double y = 0; y < size.height; y += 24) {
//       canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }