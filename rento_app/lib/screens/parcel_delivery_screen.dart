// //import 'package:flutter/material.dart';
// //import '../constants/app_colors.dart';
// import 'package:rento/delivery/core/constants/app_colors.dart';
// import '../constants/app_text_styles.dart';
// import '../theme/app_theme.dart';
// import '../widgets/primary_button.dart';

// class ParcelDeliveryScreen extends StatefulWidget {
//   const ParcelDeliveryScreen({super.key});

//   @override
//   State<ParcelDeliveryScreen> createState() => _ParcelDeliveryScreenState();
// }

// class _ParcelDeliveryScreenState extends State<ParcelDeliveryScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _pickupController = TextEditingController();
//   final _dropController = TextEditingController();
//   final _receiverNameController = TextEditingController();
//   final _receiverPhoneController = TextEditingController();
//   String _selectedSize = 'Small';

//   final List<Map<String, dynamic>> _sizes = const [
//     {'label': 'Small', 'desc': 'Fits in a bag (up to 2kg)', 'icon': Icons.inventory_2_outlined},
//     {'label': 'Medium', 'desc': 'Box-sized (up to 10kg)', 'icon': Icons.all_inbox_outlined},
//     {'label': 'Large', 'desc': 'Bulky items (up to 25kg)', 'icon': Icons.local_shipping_outlined},
//   ];

//   @override
//   void dispose() {
//     _pickupController.dispose();
//     _dropController.dispose();
//     _receiverNameController.dispose();
//     _receiverPhoneController.dispose();
//     super.dispose();
//   }

//   void _submit() {
//     if (!_formKey.currentState!.validate()) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Looking for a nearby rider for your parcel...')),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.pureWhite,
//       appBar: AppBar(
//         backgroundColor: AppColors.pureWhite,
//         elevation: 0,
//         foregroundColor: AppColors.primaryBlack,
//         leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
//         title: Text('Parcel Delivery', style: AppText.titleLg.copyWith(fontSize: 16)),
//       ),
//       body: SafeArea(
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             padding: const EdgeInsets.all(16),
//             children: [
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(color: AppColors.inputFill, borderRadius: BorderRadius.circular(14)),
//                 child: Row(
//                   children: [
//                     const Icon(Icons.local_shipping_outlined, color: AppColors.accentLime, size: 28),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Send a Parcel', style: AppText.titleMd),
//                           const SizedBox(height: 2),
//                           Text('A rider will pick it up and deliver it for you.', style: AppText.bodySm),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 22),
//               Text('Pickup & Drop Details', style: AppText.titleLg.copyWith(fontSize: 14.5)),
//               const SizedBox(height: 12),
//               _addressField(
//                 controller: _pickupController,
//                 label: 'Pickup Address',
//                 icon: Icons.storefront_outlined,
//               ),
//               const SizedBox(height: 12),
//               _addressField(
//                 controller: _dropController,
//                 label: 'Drop Address',
//                 icon: Icons.location_on_outlined,
//               ),
//               const SizedBox(height: 22),
//               Text('Receiver Details', style: AppText.titleLg.copyWith(fontSize: 14.5)),
//               const SizedBox(height: 12),
//               _textField(
//                 controller: _receiverNameController,
//                 label: 'Receiver Name',
//                 icon: Icons.person_outline,
//               ),
//               const SizedBox(height: 12),
//               _textField(
//                 controller: _receiverPhoneController,
//                 label: 'Receiver Phone Number',
//                 icon: Icons.phone_outlined,
//                 keyboardType: TextInputType.phone,
//               ),
//               const SizedBox(height: 22),
//               Text('Parcel Size', style: AppText.titleLg.copyWith(fontSize: 14.5)),
//               const SizedBox(height: 4),
//               Text('Choose the size that best fits your item', style: AppText.bodySm.copyWith(fontSize: 11.5)),
//               const SizedBox(height: 12),
//               ..._sizes.map((s) => _sizeTile(s)),
//               const SizedBox(height: 8),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//                 decoration: BoxDecoration(color: AppTheme.lightGrey, borderRadius: BorderRadius.circular(12)),
//                 child: Row(
//                   children: [
//                     const Icon(Icons.info_outline, size: 16, color: AppColors.textSecondary),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: Text(
//                         'Final delivery fee is calculated based on distance and parcel size, and shown before you confirm.',
//                         style: AppText.caption.copyWith(fontSize: 11, height: 1.3),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
//           child: PrimaryButton(
//             label: 'FIND A RIDER',
//             icon: Icons.search,
//             onPressed: _submit,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _addressField({required TextEditingController controller, required String label, required IconData icon}) {
//     return TextFormField(
//       controller: controller,
//       maxLines: 2,
//       validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter $label' : null,
//       style: AppText.bodyMd,
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: AppColors.textSecondary, size: 20),
//         labelText: label,
//         labelStyle: AppText.bodySm,
//         filled: true,
//         fillColor: AppColors.inputFill,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
//         contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
//       ),
//     );
//   }

//   Widget _textField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     TextInputType keyboardType = TextInputType.text,
//   }) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter $label' : null,
//       style: AppText.bodyMd,
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: AppColors.textSecondary, size: 20),
//         labelText: label,
//         labelStyle: AppText.bodySm,
//         filled: true,
//         fillColor: AppColors.inputFill,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
//         contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
//       ),
//     );
//   }

//   Widget _sizeTile(Map<String, dynamic> size) {
//     final selected = _selectedSize == size['label'];
//     return GestureDetector(
//       onTap: () => setState(() => _selectedSize = size['label']),
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 10),
//         padding: const EdgeInsets.all(14),
//         decoration: BoxDecoration(
//           border: Border.all(color: selected ? AppColors.primaryBlack : AppColors.border, width: selected ? 1.5 : 1),
//           borderRadius: BorderRadius.circular(12),
//           color: selected ? AppColors.inputFill : AppColors.pureWhite,
//         ),
//         child: Row(
//           children: [
//             Icon(size['icon'] as IconData, color: AppColors.textPrimary, size: 20),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(size['label'] as String, style: AppText.titleSm),
//                   Text(size['desc'] as String, style: AppText.caption),
//                 ],
//               ),
//             ),
//             Radio<String>(
//               value: size['label'] as String,
//               groupValue: _selectedSize,
//               activeColor: AppColors.primaryBlack,
//               onChanged: (v) => setState(() => _selectedSize = v!),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';

class ParcelDeliveryScreen extends StatefulWidget {
  const ParcelDeliveryScreen({super.key});

  @override
  State<ParcelDeliveryScreen> createState() => _ParcelDeliveryScreenState();
}

class _ParcelDeliveryScreenState extends State<ParcelDeliveryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pickupController = TextEditingController();
  final _dropController = TextEditingController();
  final _receiverNameController = TextEditingController();
  final _receiverPhoneController = TextEditingController();
  String _selectedSize = 'Small';

  final List<Map<String, dynamic>> _sizes = const [
    {'label': 'Small', 'desc': 'Fits in a bag (up to 2kg)', 'icon': Icons.inventory_2_outlined},
    {'label': 'Medium', 'desc': 'Box-sized (up to 10kg)', 'icon': Icons.all_inbox_outlined},
    {'label': 'Large', 'desc': 'Bulky items (up to 25kg)', 'icon': Icons.local_shipping_outlined},
  ];

  @override
  void dispose() {
    _pickupController.dispose();
    _dropController.dispose();
    _receiverNameController.dispose();
    _receiverPhoneController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Looking for a nearby rider for your parcel...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      appBar: AppBar(
        backgroundColor: AppColors.pureWhite,
        elevation: 0,
        foregroundColor: AppColors.primaryBlack,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: Text('Parcel Delivery', style: AppText.titleLg.copyWith(fontSize: 16)),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: AppColors.inputFill, borderRadius: BorderRadius.circular(14)),
                child: Row(
                  children: [
                    const Icon(Icons.local_shipping_outlined, color: AppColors.accentLime, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Send a Parcel', style: AppText.titleMd),
                          const SizedBox(height: 2),
                          Text('A rider will pick it up and deliver it for you.', style: AppText.bodySm),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Text('Pickup & Drop Details', style: AppText.titleLg.copyWith(fontSize: 14.5)),
              const SizedBox(height: 12),
              _addressField(
                controller: _pickupController,
                label: 'Pickup Address',
                icon: Icons.storefront_outlined,
              ),
              const SizedBox(height: 12),
              _addressField(
                controller: _dropController,
                label: 'Drop Address',
                icon: Icons.location_on_outlined,
              ),
              const SizedBox(height: 22),
              Text('Receiver Details', style: AppText.titleLg.copyWith(fontSize: 14.5)),
              const SizedBox(height: 12),
              _textField(
                controller: _receiverNameController,
                label: 'Receiver Name',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 12),
              _textField(
                controller: _receiverPhoneController,
                label: 'Receiver Phone Number',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 22),
              Text('Parcel Size', style: AppText.titleLg.copyWith(fontSize: 14.5)),
              const SizedBox(height: 4),
              Text('Choose the size that best fits your item', style: AppText.bodySm.copyWith(fontSize: 11.5)),
              const SizedBox(height: 12),
              ..._sizes.map((s) => _sizeTile(s)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(color: AppTheme.lightGrey, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, size: 16, color: AppColors.textSecondary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Final delivery fee is calculated based on distance and parcel size, and shown before you confirm.',
                        style: AppText.caption.copyWith(fontSize: 11, height: 1.3),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: PrimaryButton(
            label: 'FIND A RIDER',
            icon: Icons.search,
            onPressed: _submit,
          ),
        ),
      ),
    );
  }

  Widget _addressField({required TextEditingController controller, required String label, required IconData icon}) {
    return TextFormField(
      controller: controller,
      maxLines: 2,
      validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter $label' : null,
      style: AppText.bodyMd,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.textSecondary, size: 20),
        labelText: label,
        labelStyle: AppText.bodySm,
        filled: true,
        fillColor: AppColors.inputFill,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter $label' : null,
      style: AppText.bodyMd,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.textSecondary, size: 20),
        labelText: label,
        labelStyle: AppText.bodySm,
        filled: true,
        fillColor: AppColors.inputFill,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      ),
    );
  }

  Widget _sizeTile(Map<String, dynamic> size) {
    final selected = _selectedSize == size['label'];
    return GestureDetector(
      onTap: () => setState(() => _selectedSize = size['label']),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(color: selected ? AppColors.primaryBlack : AppColors.border, width: selected ? 1.5 : 1),
          borderRadius: BorderRadius.circular(12),
          color: selected ? AppColors.inputFill : AppColors.pureWhite,
        ),
        child: Row(
          children: [
            Icon(size['icon'] as IconData, color: AppColors.textPrimary, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(size['label'] as String, style: AppText.titleSm),
                  Text(size['desc'] as String, style: AppText.caption),
                ],
              ),
            ),
            Radio<String>(
              value: size['label'] as String,
              groupValue: _selectedSize,
              activeColor: AppColors.primaryBlack,
              onChanged: (v) => setState(() => _selectedSize = v!),
            ),
          ],
        ),
      ),
    );
  }
}