import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/contact_launcher.dart';

/// Support number shown in the help sheet. Centralised here so it's easy
/// to swap for a real rider-support line later.
const String kRiderSupportPhone = '+91 80000 00000';

/// Bottom sheet opened from the "?" icon in the trip flow app bars.
/// Kept intentionally simple: a couple of quick answers plus a way to
/// actually reach support, rather than a dead icon.
Future<void> showHelpSupportSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppColors.grey200,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text('Need help with this trip?', style: AppTextStyles.h2),
              const SizedBox(height: 12),
              _HelpItem(
                title: "Can't get the customer's OTP?",
                body:
                    'Ask them to check their SMS or app notifications. '
                    "You can also call them from this screen's contact card.",
              ),
              const SizedBox(height: 12),
              _HelpItem(
                title: 'Parcel looks different from the details?',
                body:
                    'Take a clear photo before pickup and contact support '
                    'so we can confirm before you proceed.',
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () =>
                      ContactLauncher.call(context, kRiderSupportPhone),
                  icon: const Icon(Icons.call_outlined, size: 18),
                  label: const Text('Call Rider Support'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: AppColors.divider),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _HelpItem extends StatelessWidget {
  const _HelpItem({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.bodyStrong),
        const SizedBox(height: 4),
        Text(body, style: AppTextStyles.caption),
      ],
    );
  }
}
