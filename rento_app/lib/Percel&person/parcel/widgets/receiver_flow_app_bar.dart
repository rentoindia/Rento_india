import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// Left-aligned title/subtitle header used across the receiver-address
/// flow (as opposed to [FlowAppBar]'s centered title, used elsewhere).
/// Shows a notification bell (with an unread dot) and a "more" icon by
/// default; pass [showActions] = false for the simpler sub-screens.
class ReceiverFlowAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ReceiverFlowAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.showActions = true,
    this.onNotifications,
    this.onMore,
    this.onBack,
    this.hasUnread = true,
  });

  final String title;
  final String? subtitle;
  final bool showActions;
  final VoidCallback? onNotifications;
  final VoidCallback? onMore;
  final VoidCallback? onBack;
  final bool hasUnread;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (subtitleReserved ? 20 : 6));

  /// Whether this instance renders a subtitle line, used to size
  /// [preferredSize] before the widget is actually built.
  bool get subtitleReserved => subtitle != null;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 6, 16, 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, size: 20),
              onPressed: onBack ?? () => Navigator.of(context).maybePop(),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.h1.copyWith(height: 1.15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: AppTextStyles.caption.copyWith(height: 1.2),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            if (showActions) ...[
              _HeaderIconButton(
                icon: Icons.notifications_none,
                dot: hasUnread,
                onTap: onNotifications ?? () {},
              ),
              const SizedBox(width: 4),
              _HeaderIconButton(icon: Icons.more_vert, onTap: onMore ?? () {}),
            ],
          ],
        ),
      ),
    );
  }
}

class _HeaderIconButton extends StatefulWidget {
  const _HeaderIconButton({
    required this.icon,
    required this.onTap,
    this.dot = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool dot;

  @override
  State<_HeaderIconButton> createState() => _HeaderIconButtonState();
}

class _HeaderIconButtonState extends State<_HeaderIconButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              AnimatedScale(
                duration: const Duration(milliseconds: 180),
                scale: _hovered ? 1.08 : 1.0,
                child: Icon(widget.icon, size: 22, color: AppColors.black),
              ),
              if (widget.dot)
                Positioned(
                  right: -1,
                  top: -1,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      color: AppColors.accentRed,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 1.5),
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
