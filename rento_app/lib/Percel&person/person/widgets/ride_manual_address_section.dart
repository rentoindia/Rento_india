import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/section_card.dart';

const kRideAddressTypes = ['Home', 'Work', 'Other'];

/// Collapsible "+ Add Address Manually" section — expands inline via
/// [AnimatedSize], never pushes a new route/sheet/dialog. Pixel-for-pixel
/// the same as the parcel module's `_ManualAddressSection`, just made
/// public so the ride module's destination screen can reuse it.
class RideManualAddressSection extends StatelessWidget {
  const RideManualAddressSection({
    super.key,
    required this.expanded,
    required this.onToggle,
    required this.houseController,
    required this.streetController,
    required this.landmarkController,
    required this.cityController,
    required this.pincodeController,
    required this.addressType,
    required this.onAddressTypeChanged,
    required this.onFieldChanged,
  });

  final bool expanded;
  final VoidCallback onToggle;
  final TextEditingController houseController;
  final TextEditingController streetController;
  final TextEditingController landmarkController;
  final TextEditingController cityController;
  final TextEditingController pincodeController;
  final String addressType;
  final ValueChanged<String?> onAddressTypeChanged;
  final VoidCallback onFieldChanged;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onToggle,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Row(
                children: [
                  const Icon(
                    Icons.add_circle_outline,
                    size: 20,
                    color: AppColors.black,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Add Address Manually',
                      style: AppTextStyles.bodyStrong,
                    ),
                  ),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 200),
                    turns: expanded ? 0.5 : 0,
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      size: 22,
                      color: AppColors.grey500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            alignment: Alignment.topCenter,
            child: !expanded
                ? const SizedBox(width: double.infinity, height: 0)
                : Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'HOUSE / FLAT / BUILDING *',
                          style: AppTextStyles.overline,
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: houseController,
                          onChanged: (_) => onFieldChanged(),
                          style: AppTextStyles.body,
                          decoration: const InputDecoration(
                            hintText: 'e.g. Flat 4B, Ocean Heights',
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text('STREET / AREA *', style: AppTextStyles.overline),
                        const SizedBox(height: 6),
                        TextField(
                          controller: streetController,
                          onChanged: (_) => onFieldChanged(),
                          style: AppTextStyles.body,
                          decoration: const InputDecoration(
                            hintText: 'e.g. Kalapet Main Road',
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text('LANDMARK', style: AppTextStyles.overline),
                        const SizedBox(height: 6),
                        TextField(
                          controller: landmarkController,
                          style: AppTextStyles.body,
                          decoration: const InputDecoration(
                            hintText: 'e.g. Near White Town Promenade',
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('CITY *', style: AppTextStyles.overline),
                                  const SizedBox(height: 6),
                                  TextField(
                                    controller: cityController,
                                    onChanged: (_) => onFieldChanged(),
                                    style: AppTextStyles.body,
                                    decoration: const InputDecoration(
                                      hintText: 'Puducherry',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'PINCODE *',
                                    style: AppTextStyles.overline,
                                  ),
                                  const SizedBox(height: 6),
                                  TextField(
                                    controller: pincodeController,
                                    onChanged: (_) => onFieldChanged(),
                                    keyboardType: TextInputType.number,
                                    style: AppTextStyles.body,
                                    decoration: const InputDecoration(
                                      hintText: '605001',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text('ADDRESS TYPE *', style: AppTextStyles.overline),
                        const SizedBox(height: 6),
                        DropdownButtonFormField<String>(
                          initialValue: addressType,
                          icon: const Icon(Icons.keyboard_arrow_down, size: 20),
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.black,
                          ),
                          decoration: const InputDecoration(),
                          items: kRideAddressTypes
                              .map(
                                (t) =>
                                    DropdownMenuItem(value: t, child: Text(t)),
                              )
                              .toList(),
                          onChanged: onAddressTypeChanged,
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
