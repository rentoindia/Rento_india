import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/section_card.dart';
import '../../core/widgets/step_progress_indicator.dart';
import '../models/parcel_details_model.dart';
import '../models/vehicle_option_model.dart';
import '../providers/booking_provider.dart';
import '../widgets/vehicle_option_tile.dart';
import 'payment_screen.dart';
import 'pickup_address_screen.dart';

const _kFareStepShortLabels = [
  'Pickup',
  'Receiver',
  'Parcel',
  'Fare',
  'Payment',
];

/// Step 4 of the booking flow — lets the customer compare vehicles and
/// confirm one. Everything (including the "Confirm" button) lives inside
/// a single scroll view, so the button sits at the natural end of the
/// content rather than pinned to the bottom of the screen.
class FareEstimateScreen extends ConsumerStatefulWidget {
  const FareEstimateScreen({super.key});

  @override
  ConsumerState<FareEstimateScreen> createState() => _FareEstimateScreenState();
}

class _FareEstimateScreenState extends ConsumerState<FareEstimateScreen> {
  String? _selectedId;

  void _showHelp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "We pick the best vehicle for your parcel automatically — tap a "
          "different card any time to switch.",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final booking = ref.watch(bookingProvider);
    final parcel = booking.parcelDetails;

    // Which vehicles can carry this parcel changes with its size/weight, so
    // this list is recomputed on every build rather than being static.
    final options = VehicleOptionModel.availableFor(parcel);

    // Default to (or fall back to, if the previous selection is no longer
    // offered because the parcel details changed) the recommended option.
    if (_selectedId == null || !options.any((o) => o.id == _selectedId)) {
      _selectedId = options.firstWhere((o) => o.recommended).id;
    }
    final selected = options.firstWhere((v) => v.id == _selectedId);

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: FlowAppBar(
        title: 'Fare Estimate',
        subtitle: 'Choose the best vehicle for your parcel',
        onHelp: _showHelp,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StepProgressIndicator(
                steps: kBookingSteps,
                currentIndex: 3,
                shortLabels: _kFareStepShortLabels,
              ),
              const SizedBox(height: 20),
              SectionCard(
                child: Row(
                  children: [
                    _SummaryStat(
                      icon: Icons.description_outlined,
                      label: 'Type',
                      value: parcel?.type.label ?? 'Documents',
                    ),
                    _SummaryDivider(),
                    _SummaryStat(
                      icon: Icons.monitor_weight_outlined,
                      label: 'Weight',
                      value: parcel?.weightLabel ?? 'Under 1 kg',
                    ),
                    _SummaryDivider(),
                    _SummaryStat(
                      icon: Icons.shield_outlined,
                      label: 'Handling',
                      value: (parcel?.needsSpecialHandling ?? false)
                          ? 'Fragile'
                          : 'Standard',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const _RecommendationBanner(),
              const SizedBox(height: 20),
              Text('SELECT VEHICLE', style: AppTextStyles.overline),
              const SizedBox(height: 10),
              ...options.map(
                (option) => VehicleOptionTile(
                  option: option,
                  selected: option.id == _selectedId,
                  onTap: () => setState(() => _selectedId = option.id),
                ),
              ),
              const SizedBox(height: 8),
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('FARE BREAKDOWN', style: AppTextStyles.overline),
                    const SizedBox(height: 14),
                    _FareRow(
                      icon: Icons.receipt_long_outlined,
                      label: 'Base Fare',
                      value: '\u20B9${booking.baseFare.toStringAsFixed(0)}',
                    ),
                    _FareRow(
                      icon: Icons.trending_up,
                      label: 'Distance Charge',
                      value:
                          '\u20B9${booking.distanceCharge.toStringAsFixed(0)}',
                    ),
                    _FareRow(
                      icon: Icons.shield_outlined,
                      label: 'Handling Fee',
                      value: '\u20B9${booking.handlingFee.toStringAsFixed(0)}',
                    ),
                    _FareRow(
                      icon: Icons.check_circle_outline,
                      label: 'Taxes & Fees',
                      value: 'Included',
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(height: 1),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total', style: AppTextStyles.bodyStrong),
                        Text(selected.fareLabel, style: AppTextStyles.h2),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _InfoActionCard(
                icon: Icons.card_giftcard_outlined,
                title: 'Have a Coupon?',
                subtitle: 'Apply promo code and save more',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Coupons are coming soon.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              const _DeliveryProtectionCard(),
              const SizedBox(height: 20),
              PrimaryButton(
                label: 'Confirm ${selected.name}',
                leadingText: selected.fareLabel,
                trailing: const Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: AppColors.white,
                ),
                onPressed: () {
                  ref
                      .read(bookingProvider.notifier)
                      .selectVehicle(_selectedId!);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const PaymentScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// One black-on-white "AI picked this for you" banner shown above the
/// vehicle list.
class _RecommendationBanner extends StatelessWidget {
  const _RecommendationBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 26,
                width: 26,
                decoration: const BoxDecoration(
                  color: AppColors.charcoal,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  size: 14,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Best Vehicle Recommendation',
                  style: AppTextStyles.bodyStrong.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'AI',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 10.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "Based on parcel size, weight, destination, and live traffic — "
            "Bike is the fastest, most economical choice right now.",
            style: AppTextStyles.caption.copyWith(
              color: AppColors.grey300,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

/// Tappable card used for "Have a Coupon?" — icon, title/subtitle, chevron.
class _InfoActionCard extends StatelessWidget {
  const _InfoActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      padding: EdgeInsets.zero,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: AppColors.grey100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 19, color: AppColors.black),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTextStyles.bodyStrong),
                      const SizedBox(height: 2),
                      Text(subtitle, style: AppTextStyles.caption),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: AppColors.grey400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Static "your parcel is covered" reassurance card with an INCLUDED badge.
class _DeliveryProtectionCard extends StatelessWidget {
  const _DeliveryProtectionCard();

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              color: AppColors.grey100,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shield_outlined,
              size: 19,
              color: AppColors.black,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    Text(
                      'Delivery Protection',
                      style: AppTextStyles.bodyStrong,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.black,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'INCLUDED',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.white,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Your parcel is covered up to \u20B95,000 against loss or '
                  'damage during transit.',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FareRow extends StatelessWidget {
  const _FareRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 15, color: AppColors.grey400),
              const SizedBox(width: 8),
              Text(label, style: AppTextStyles.caption),
            ],
          ),
          Text(value, style: AppTextStyles.captionStrong),
        ],
      ),
    );
  }
}

class _SummaryStat extends StatelessWidget {
  const _SummaryStat({
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 18, color: AppColors.black),
          const SizedBox(height: 6),
          Text(
            label,
            style: AppTextStyles.caption,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: AppTextStyles.bodyStrong,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _SummaryDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: 34, width: 1, color: AppColors.divider);
  }
}
