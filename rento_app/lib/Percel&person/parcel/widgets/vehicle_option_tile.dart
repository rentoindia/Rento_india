import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../models/vehicle_option_model.dart';

/// A single vehicle choice card on the Fare Estimate screen — icon, name,
/// short description, weight/time capacity, feature tags, and price with
/// a selection radio. The recommended option gets a corner ribbon.
class VehicleOptionTile extends StatelessWidget {
  const VehicleOptionTile({
    super.key,
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final VehicleOptionModel option;
  final bool selected;
  final VoidCallback onTap;

  IconData get _icon {
    switch (option.id) {
      case 'bike':
        return Icons.pedal_bike_outlined;
      case 'bikeXl':
        return Icons.two_wheeler_outlined;
      case 'auto':
        return Icons.electric_rickshaw_outlined;
      default:
        return Icons.local_shipping_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: selected ? AppColors.grey50 : AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: selected ? AppColors.black : AppColors.divider,
          width: selected ? 1.6 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  14,
                  option.recommended ? 30 : 14,
                  14,
                  14,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 44,
                      width: 44,
                      decoration: const BoxDecoration(
                        color: AppColors.grey100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(_icon, size: 22, color: AppColors.black),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 6,
                            runSpacing: 2,
                            children: [
                              Text(
                                option.name,
                                style: AppTextStyles.bodyStrong,
                              ),
                              Text(
                                option.tagline,
                                style: AppTextStyles.caption,
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            option.description,
                            style: AppTextStyles.caption,
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 8,
                            runSpacing: 4,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.monitor_weight_outlined,
                                    size: 13,
                                    color: AppColors.grey400,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    option.weightLabel,
                                    style: AppTextStyles.caption.copyWith(
                                      fontSize: 11.5,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '•',
                                style: AppTextStyles.caption.copyWith(
                                  fontSize: 11.5,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.schedule,
                                    size: 13,
                                    color: AppColors.grey400,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    option.etaLabel,
                                    style: AppTextStyles.caption.copyWith(
                                      fontSize: 11.5,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              for (final tag in option.tags)
                                _VehicleTagChip(tag),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(option.fareLabel, style: AppTextStyles.h2),
                        Text('total fare', style: AppTextStyles.caption),
                        const SizedBox(height: 12),
                        _RadioDot(selected: selected),
                      ],
                    ),
                  ],
                ),
              ),
              if (option.recommended)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    child: Text(
                      'RECOMMENDED',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.white,
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
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

class _VehicleTagChip extends StatelessWidget {
  const _VehicleTagChip(this.tag);
  final VehicleTag tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(tag.icon, size: 12, color: AppColors.grey700),
          const SizedBox(width: 4),
          Text(
            tag.label,
            style: AppTextStyles.caption.copyWith(
              fontSize: 11,
              color: AppColors.grey700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _RadioDot extends StatelessWidget {
  const _RadioDot({required this.selected});
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? AppColors.black : AppColors.grey300,
          width: 1.6,
        ),
      ),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: selected ? 10 : 0,
          width: selected ? 10 : 0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}
