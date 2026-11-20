import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../models/rider_model.dart';

class RiderInfoCard extends StatelessWidget {
  const RiderInfoCard({super.key, required this.rider});

  final RiderModel rider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: const BoxDecoration(
              color: AppColors.grey200,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: AppColors.grey700),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 5,
                  runSpacing: 2,
                  children: [
                    Text(
                      rider.name,
                      style: AppTextStyles.bodyStrong,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (rider.verified)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.verified,
                            size: 13,
                            color: AppColors.grey700,
                          ),
                          const SizedBox(width: 2),
                          Text('Verified', style: AppTextStyles.caption),
                        ],
                      ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          size: 13,
                          color: AppColors.black,
                        ),
                        const SizedBox(width: 2),
                        Text('${rider.rating}', style: AppTextStyles.caption),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '${rider.vehicleName} · ${rider.vehicleNumber}',
                  style: AppTextStyles.caption,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _RoundIconButton(icon: Icons.call_outlined, onTap: () {}),
          const SizedBox(width: 8),
          _RoundIconButton(icon: Icons.chat_bubble_outline, onTap: () {}),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        height: 38,
        width: 38,
        decoration: const BoxDecoration(
          color: AppColors.black,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16, color: AppColors.white),
      ),
    );
  }
}
