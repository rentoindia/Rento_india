import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/contact_launcher.dart';
import '../models/captain_model.dart';

/// Full captain detail card used on the OTP Verification screen: avatar
/// with an online dot, name, rating, vehicle, plate chip, and a
/// Call / Chat / Cancel Ride action row.
class CaptainDetailCard extends StatelessWidget {
  const CaptainDetailCard({
    super.key,
    required this.captain,
    this.onCall,
    this.onChat,
    this.onCancel,
  });

  final CaptainModel captain;
  final VoidCallback? onCall;
  final VoidCallback? onChat;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 56,
                    width: 56,
                    decoration: const BoxDecoration(
                      color: AppColors.black,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      captain.initials,
                      style: AppTextStyles.bodyStrong.copyWith(
                        color: AppColors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 1,
                    bottom: 1,
                    child: Container(
                      height: 13,
                      width: 13,
                      decoration: BoxDecoration(
                        color: AppColors.accentGreen,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(captain.name, style: AppTextStyles.h2),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 14, color: Color(0xFFF5A623)),
                        const SizedBox(width: 3),
                        Text(
                          '${captain.rating}',
                          style: AppTextStyles.bodyStrong.copyWith(fontSize: 13),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${captain.completedRides} rides)',
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(captain.vehicleName, style: AppTextStyles.caption),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.grey50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.divider),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.directions_car_filled_outlined,
                            size: 12,
                            color: AppColors.grey700,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            captain.vehicleNumber,
                            style: AppTextStyles.captionStrong.copyWith(
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _ActionPill(
                  icon: Icons.call_outlined,
                  label: 'Call',
                  onTap: onCall ?? () {},
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _ActionPill(
                  icon: Icons.chat_bubble_outline,
                  label: 'Chat',
                  onTap: onChat ?? () {},
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _ActionPill(
                  icon: Icons.close,
                  label: 'Cancel Ride',
                  onTap: onCancel ?? () {},
                  danger: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionPill extends StatelessWidget {
  const _ActionPill({
    required this.icon,
    required this.label,
    required this.onTap,
    this.danger = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: danger ? AppColors.accentRedBg : AppColors.grey50,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: danger ? AppColors.accentRed : AppColors.black,
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: AppTextStyles.caption.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                  color: danger ? AppColors.accentRed : AppColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Compact black bar used on the SOS screen ("current trip" card) — name,
/// plate + vehicle, and round call/chat/share icon buttons.
class CaptainCompactBar extends StatelessWidget {
  const CaptainCompactBar({super.key, required this.captain});

  final CaptainModel captain;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: const BoxDecoration(
              color: Color(0xFF2C2C2C),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              captain.initials,
              style: AppTextStyles.bodyStrong.copyWith(color: AppColors.white),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  captain.name,
                  style: AppTextStyles.bodyStrong.copyWith(
                    color: AppColors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${captain.vehicleNumber} \u00b7 ${captain.vehicleName}',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.grey400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          _RoundIconButton(
            icon: Icons.call_outlined,
            onTap: () => ContactLauncher.call(context, '+919876543210'),
          ),
          const SizedBox(width: 8),
          _RoundIconButton(icon: Icons.chat_bubble_outline, onTap: () {}),
          const SizedBox(width: 8),
          _RoundIconButton(icon: Icons.ios_share, onTap: () {}),
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
    return Material(
      color: const Color(0xFF2C2C2C),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Icon(icon, size: 15, color: AppColors.white),
        ),
      ),
    );
  }
}
