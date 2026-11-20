import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../models/receiver_model.dart';

/// The avatar-initials + name/phone/address + "Use" button row shown in
/// the Recent Receivers strip and the Saved Receivers list. Lifts
/// slightly and its border becomes visible on hover/press, per the
/// reference's interaction spec.
class ReceiverCard extends StatefulWidget {
  const ReceiverCard({super.key, required this.receiver, required this.onUse});

  final ReceiverModel receiver;
  final VoidCallback onUse;

  @override
  State<ReceiverCard> createState() => _ReceiverCardState();
}

class _ReceiverCardState extends State<ReceiverCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final r = widget.receiver;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.grey50 : AppColors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _hovered ? AppColors.grey300 : AppColors.divider,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: _hovered ? 16 : 10,
              offset: Offset(0, _hovered ? 6 : 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                color: r.avatarColor.withValues(alpha: 0.14),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                r.initials,
                style: AppTextStyles.bodyStrong.copyWith(color: r.avatarColor),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(r.name, style: AppTextStyles.bodyStrong),
                  const SizedBox(height: 2),
                  Text(r.phone, style: AppTextStyles.caption),
                  const SizedBox(height: 2),
                  Text(
                    r.addressLabel,
                    style: AppTextStyles.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            _UseButton(onTap: widget.onUse),
          ],
        ),
      ),
    );
  }
}

class _UseButton extends StatefulWidget {
  const _UseButton({required this.onTap});
  final VoidCallback onTap;

  @override
  State<_UseButton> createState() => _UseButtonState();
}

class _UseButtonState extends State<_UseButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 180),
          scale: _hovered ? 1.02 : 1.0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.accentGreenBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Use',
              style: AppTextStyles.captionStrong.copyWith(
                color: AppColors.accentGreen,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
