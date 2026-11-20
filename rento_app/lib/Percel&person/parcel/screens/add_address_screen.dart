import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/section_card.dart';
import '../models/saved_address_model.dart';

/// Full-screen form to save a new address. Pops with the created
/// [SavedAddressModel] when saved, or `null` if the user backs out.
class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _landmarkController = TextEditingController();
  final _phoneController = TextEditingController();
  SavedAddressType _type = SavedAddressType.home;

  @override
  void dispose() {
    _addressController.dispose();
    _landmarkController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final address = SavedAddressModel(
      id: 'addr_${DateTime.now().millisecondsSinceEpoch}',
      type: _type,
      flatHouseBuilding: _addressController.text.trim(),
      streetAreaLandmark: _landmarkController.text.trim(),
      cityStatePin: 'Chennai',
      phone: _phoneController.text.trim(),
    );
    Navigator.of(context).pop(address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FlowAppBar(title: 'Add Address'),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            children: [
              Text('SAVE AS', style: AppTextStyles.overline),
              const SizedBox(height: 10),
              Row(
                children: SavedAddressType.values.map((type) {
                  final isSelected = _type == type;
                  final isLast = type == SavedAddressType.values.last;
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: isLast ? 0 : 10),
                      child: InkWell(
                        onTap: () => setState(() => _type = type),
                        borderRadius: BorderRadius.circular(14),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.black
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.black
                                  : AppColors.borderLight,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                type.icon,
                                size: 18,
                                color: isSelected
                                    ? AppColors.white
                                    : AppColors.black,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                type.label,
                                style: AppTextStyles.captionStrong.copyWith(
                                  color: isSelected
                                      ? AppColors.white
                                      : AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 22),
              Text('ADDRESS', style: AppTextStyles.overline),
              const SizedBox(height: 8),
              TextFormField(
                controller: _addressController,
                style: AppTextStyles.body,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  hintText: 'Flat / House / Building, Street',
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Enter an address' : null,
              ),
              const SizedBox(height: 16),
              Text('LANDMARK', style: AppTextStyles.overline),
              const SizedBox(height: 8),
              TextFormField(
                controller: _landmarkController,
                style: AppTextStyles.body,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(hintText: 'Nearby landmark'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Enter a landmark' : null,
              ),
              const SizedBox(height: 16),
              Text('PHONE NUMBER', style: AppTextStyles.overline),
              const SizedBox(height: 8),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: AppTextStyles.body,
                decoration: const InputDecoration(hintText: '+91 98765 43210'),
                validator: (v) => (v == null || v.trim().length < 8)
                    ? 'Enter a valid phone number'
                    : null,
              ),
              const SizedBox(height: 28),
              PrimaryButton(label: 'Save Address', onPressed: _save),
            ],
          ),
        ),
      ),
    );
  }
}
