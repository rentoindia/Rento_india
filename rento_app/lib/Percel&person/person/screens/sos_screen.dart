import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/contact_launcher.dart';
import '../../core/widgets/primary_button.dart';
import '../models/captain_model.dart';
import '../providers/sos_provider.dart';
import '../widgets/captain_card.dart';
import '../widgets/ride_safety_pill.dart';
import '../widgets/sos_button.dart';

class SosScreen extends ConsumerWidget {
  const SosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sos = ref.watch(sosProvider);

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        backgroundColor: AppColors.offWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 20, color: AppColors.black),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('SAFETY', style: AppTextStyles.overline),
                      const SizedBox(height: 4),
                      Text('SOS / Emergency', style: AppTextStyles.display),
                      const SizedBox(height: 4),
                      Text(
                        'Your safety is our priority',
                        style: AppTextStyles.subtitle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: RideSafetyPill(title: 'Safety First', danger: true),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.divider),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Need immediate help?', style: AppTextStyles.h2),
                        const SizedBox(height: 6),
                        Text(
                          'Tap the SOS button to alert our team and your '
                          'emergency contacts with your live location.',
                          style: AppTextStyles.caption,
                        ),
                        const SizedBox(height: 14),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _StatusPill(
                              icon: Icons.location_on_outlined,
                              label: sos.status == SosStatus.active
                                  ? 'Live tracking active'
                                  : 'Live tracking ready',
                            ),
                            _StatusPill(
                              icon: Icons.timer_outlined,
                              label: sos.status == SosStatus.active
                                  ? 'Help reaches in ~5 min'
                                  : 'Help reaches in ~5 min',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  SosButton(
                    status: sos.status,
                    onTap: () => ref.read(sosProvider.notifier).trigger(),
                  ),
                ],
              ),
            ),
            if (sos.status == SosStatus.active) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.accentRedBg,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      size: 18,
                      color: AppColors.accentRed,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Help is on the way. Our safety team and your '
                        'emergency contacts have been notified.',
                        style: AppTextStyles.captionStrong.copyWith(
                          color: AppColors.accentRed,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          ref.read(sosProvider.notifier).cancelAlert(),
                      child: const Text("I'm safe"),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 16),
            CaptainCompactBar(captain: kAssignedCaptain),
            const SizedBox(height: 16),
            Container(
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
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Share Live Location',
                              style: AppTextStyles.bodyStrong,
                            ),
                            Text(
                              'Share your location in real-time.',
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                      ),
                      _ShareNowButton(),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.grey50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 8,
                          width: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.accentGreen,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Your trusted contacts can see your route in '
                            'real-time.',
                            style: AppTextStyles.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.divider),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 8, 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Emergency Contacts',
                            style: AppTextStyles.bodyStrong,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Manage \u2192'),
                        ),
                      ],
                    ),
                  ),
                  const _ContactRow(
                    initials: 'M',
                    name: 'Mom',
                    phone: '+91 98765 43210',
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  const _ContactRow(
                    initials: 'D',
                    name: 'Dad',
                    phone: '+91 98765 56789',
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  const _ContactRow(
                    initials: 'S',
                    name: 'Sister',
                    phone: '+91 78901 76800',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.divider),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Safety Tools',
                            style: AppTextStyles.bodyStrong,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const _ToolRow(
                    icon: Icons.call_outlined,
                    title: 'Fake Call',
                    subtitle: 'Simulate a call discreetly',
                  ),
                  const _ToolRow(
                    icon: Icons.mic_none_outlined,
                    title: 'Record Audio',
                    subtitle: '5 contacts connected',
                  ),
                  const _ToolRow(
                    icon: Icons.people_outline,
                    title: 'Trusted Contacts',
                    subtitle: '5 contacts connected',
                  ),
                  const _ToolRow(
                    icon: Icons.info_outline,
                    title: 'Safety Tips',
                    subtitle: 'View safety guidelines',
                    showDivider: false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              label: 'Contact Support',
              onPressed: () => ContactLauncher.call(context, '+911800000000'),
              trailing: const Icon(
                Icons.support_agent,
                size: 16,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppColors.grey500),
          const SizedBox(width: 4),
          Text(label, style: AppTextStyles.caption.copyWith(fontSize: 10.5)),
        ],
      ),
    );
  }
}

class _ShareNowButton extends StatefulWidget {
  @override
  State<_ShareNowButton> createState() => _ShareNowButtonState();
}

class _ShareNowButtonState extends State<_ShareNowButton> {
  bool _shared = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.black,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => setState(() => _shared = true),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            _shared ? 'Sharing…' : 'Share Now',
            style: AppTextStyles.captionStrong.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({
    required this.initials,
    required this.name,
    required this.phone,
  });

  final String initials;
  final String name;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Container(
            height: 38,
            width: 38,
            decoration: const BoxDecoration(
              color: AppColors.grey100,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(initials, style: AppTextStyles.bodyStrong),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.bodyStrong),
                Text(phone, style: AppTextStyles.caption),
              ],
            ),
          ),
          _RoundCallButton(phone: phone),
        ],
      ),
    );
  }
}

class _RoundCallButton extends StatelessWidget {
  const _RoundCallButton({required this.phone});
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.grey50,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () => ContactLauncher.call(context, phone),
        child: const Padding(
          padding: EdgeInsets.all(9),
          child: Icon(Icons.call_outlined, size: 15, color: AppColors.black),
        ),
      ),
    );
  }
}

class _ToolRow extends StatelessWidget {
  const _ToolRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.showDivider = true,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      color: AppColors.grey50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, size: 17, color: AppColors.black),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: AppTextStyles.bodyStrong),
                        Text(subtitle, style: AppTextStyles.caption),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    size: 18,
                    color: AppColors.grey400,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider) const Divider(height: 1, indent: 16, endIndent: 16),
      ],
    );
  }
}
