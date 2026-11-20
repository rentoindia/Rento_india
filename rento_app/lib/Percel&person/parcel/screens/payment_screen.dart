import '../../../core/api_client.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/section_card.dart';
import '../../core/widgets/step_progress_indicator.dart';
import '../models/booking_model.dart';
import '../models/parcel_details_model.dart';
import '../providers/booking_provider.dart';
import '../widgets/payment_method_tile.dart';
import 'live_tracking_screen.dart';
import 'pickup_address_screen.dart';

const _kPaymentStepShortLabels = [
  'Pickup',
  'Receiver',
  'Parcel',
  'Fare',
  'Payment',
];

class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({super.key});

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  PaymentMethod _selected = PaymentMethod.cashOnDelivery;
  bool _paying = false;

  Future<void> _pay() async {
    setState(() => _paying = true);
    ref.read(bookingProvider.notifier).selectPaymentMethod(_selected);
    try {
      // creates the booking on the server; riders nearby get it instantly
      await ref.read(bookingProvider.notifier).submit();
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() => _paying = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
      return;
    }
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LiveTrackingScreen()),
    );
  }

  void _showHelp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Choose any payment method below, then confirm to complete your '
          'booking.',
        ),
      ),
    );
  }

  void _editBooking() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Go back to earlier steps to edit your booking.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final booking = ref.watch(bookingProvider);
    final vehicle = booking.selectedVehicle;
    final parcel = booking.parcelDetails;

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: FlowAppBar(
        title: 'Payment',
        subtitle: 'Complete your parcel booking',
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
                currentIndex: 4,
                shortLabels: _kPaymentStepShortLabels,
              ),
              const SizedBox(height: 20),
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('BOOKING SUMMARY', style: AppTextStyles.overline),
                        InkWell(
                          onTap: _editBooking,
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.edit_outlined,
                                  size: 14,
                                  color: AppColors.grey500,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Edit',
                                  style: AppTextStyles.caption.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _AddressLine(
                      icon: Icons.circle,
                      iconSize: 8,
                      title: 'Pickup',
                      subtitle: booking.pickup?.combined ?? '—',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Container(
                        height: 18,
                        width: 1,
                        color: AppColors.grey300,
                      ),
                    ),
                    _AddressLine(
                      icon: Icons.location_on,
                      iconSize: 14,
                      title: 'Delivery',
                      subtitle: booking.receiver?.combined ?? '—',
                    ),
                    const SizedBox(height: 14),
                    const Divider(),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _StatBox(
                            icon: Icons.inventory_2_outlined,
                            label: 'Parcel Type',
                            value: parcel?.type.label ?? 'Documents',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _StatBox(
                            icon: Icons.monitor_weight_outlined,
                            label: 'Weight',
                            value: parcel?.weightLabel ?? 'Under 1 kg',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _StatBox(
                            icon: Icons.pedal_bike_outlined,
                            label: 'Vehicle',
                            value: vehicle?.name ?? 'Bike',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _StatBox(
                            icon: Icons.schedule,
                            label: 'Est. Time',
                            value: vehicle?.etaLabel ?? '—',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Divider(),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Fare', style: AppTextStyles.bodyStrong),
                        Text(
                          vehicle?.fareLabel ?? '\u20B90',
                          style: AppTextStyles.h2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text('CHOOSE A PAYMENT METHOD', style: AppTextStyles.overline),
              const SizedBox(height: 10),
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CASH', style: AppTextStyles.captionStrong),
                    const SizedBox(height: 2),
                    PaymentMethodTile(
                      method: PaymentMethod.cashOnDelivery,
                      subtitle: 'Pay with cash on delivery',
                      selected: _selected == PaymentMethod.cashOnDelivery,
                      onTap: () => setState(
                        () => _selected = PaymentMethod.cashOnDelivery,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('UPI', style: AppTextStyles.captionStrong),
                    const SizedBox(height: 2),
                    PaymentMethodTile(
                      method: PaymentMethod.googlePay,
                      subtitle: 'Pay via UPI',
                      selected: _selected == PaymentMethod.googlePay,
                      onTap: () =>
                          setState(() => _selected = PaymentMethod.googlePay),
                    ),
                    const Divider(height: 1),
                    PaymentMethodTile(
                      method: PaymentMethod.phonePe,
                      subtitle: 'Pay via UPI',
                      selected: _selected == PaymentMethod.phonePe,
                      onTap: () =>
                          setState(() => _selected = PaymentMethod.phonePe),
                    ),
                    const Divider(height: 1),
                    PaymentMethodTile(
                      method: PaymentMethod.paytmUpi,
                      subtitle: 'Pay via UPI',
                      selected: _selected == PaymentMethod.paytmUpi,
                      onTap: () =>
                          setState(() => _selected = PaymentMethod.paytmUpi),
                    ),
                    const Divider(height: 1),
                    PaymentMethodTile(
                      method: PaymentMethod.bhimUpi,
                      subtitle: 'Pay via UPI',
                      selected: _selected == PaymentMethod.bhimUpi,
                      onTap: () =>
                          setState(() => _selected = PaymentMethod.bhimUpi),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CARDS', style: AppTextStyles.captionStrong),
                    PaymentMethodTile(
                      method: PaymentMethod.card,
                      subtitle: 'Visa, Mastercard, Rupay',
                      selected: _selected == PaymentMethod.card,
                      onTap: () =>
                          setState(() => _selected = PaymentMethod.card),
                    ),
                    const Divider(height: 1),
                    Text('WALLETS', style: AppTextStyles.captionStrong),
                    PaymentMethodTile(
                      method: PaymentMethod.paytmWallet,
                      subtitle: 'Available balance \u20B9123.00',
                      trailingBadge: '\u20B9123',
                      selected: _selected == PaymentMethod.paytmWallet,
                      onTap: () =>
                          setState(() => _selected = PaymentMethod.paytmWallet),
                    ),
                    const Divider(height: 1),
                    Text('OTHER OPTIONS', style: AppTextStyles.captionStrong),
                    PaymentMethodTile(
                      method: PaymentMethod.netBanking,
                      subtitle: 'All major banks',
                      selected: _selected == PaymentMethod.netBanking,
                      onTap: () =>
                          setState(() => _selected = PaymentMethod.netBanking),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _CouponCard(
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
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('FARE SUMMARY', style: AppTextStyles.overline),
                    const SizedBox(height: 14),
                    _SummaryRow(
                      icon: Icons.receipt_long_outlined,
                      label: 'Base Fare',
                      value: '\u20B9${booking.baseFare.toStringAsFixed(0)}',
                    ),
                    _SummaryRow(
                      icon: Icons.trending_up,
                      label: 'Distance Charge',
                      value:
                          '\u20B9${booking.distanceCharge.toStringAsFixed(0)}',
                    ),
                    _SummaryRow(
                      icon: Icons.shield_outlined,
                      label: 'Handling Fee',
                      value: '\u20B9${booking.handlingFee.toStringAsFixed(0)}',
                    ),
                    _SummaryRow(
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
                        Text(
                          vehicle?.fareLabel ?? '\u20B90',
                          style: AppTextStyles.h2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const _SecurePaymentCard(),
              const SizedBox(height: 20),
              _PayCta(
                method: _selected,
                fareLabel: vehicle?.fareLabel ?? '\u20B90',
                loading: _paying,
                onTap: _pay,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PayCta extends StatefulWidget {
  const _PayCta({
    required this.method,
    required this.fareLabel,
    required this.loading,
    required this.onTap,
  });

  final PaymentMethod method;
  final String fareLabel;
  final bool loading;
  final VoidCallback onTap;

  @override
  State<_PayCta> createState() => _PayCtaState();
}

class _PayCtaState extends State<_PayCta> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 120),
    lowerBound: 0.0,
    upperBound: 0.04,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _active => !widget.loading;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final scale = 1 - _controller.value;
        return Transform.scale(scale: scale, child: child);
      },
      child: GestureDetector(
        onTapDown: _active ? (_) => _controller.forward() : null,
        onTapUp: _active ? (_) => _controller.reverse() : null,
        onTapCancel: _active ? () => _controller.reverse() : null,
        onTap: _active ? widget.onTap : null,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.black,
            borderRadius: BorderRadius.circular(16),
          ),
          child: widget.loading
              ? const SizedBox(
                  height: 24,
                  child: Center(
                    child: SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.4,
                        valueColor: AlwaysStoppedAnimation(AppColors.white),
                      ),
                    ),
                  ),
                )
              : Row(
                  children: [
                    Container(
                      height: 38,
                      width: 38,
                      decoration: const BoxDecoration(
                        color: AppColors.charcoal,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        paymentMethodIcon(widget.method),
                        size: 17,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Pay ${widget.fareLabel}',
                            style: AppTextStyles.button,
                          ),
                          const SizedBox(height: 1),
                          Text(
                            'via ${widget.method.label}',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.white.withValues(alpha: 0.65),
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.charcoal,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.lock_outline,
                            size: 12,
                            color: AppColors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Secure',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: AppColors.white,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _CouponCard extends StatelessWidget {
  const _CouponCard({required this.onTap});
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
                  child: const Icon(
                    Icons.card_giftcard_outlined,
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
                          Text('Apply Coupon', style: AppTextStyles.bodyStrong),
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
                              'OFFERS',
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
                      const SizedBox(height: 2),
                      Text(
                        'Save more on this delivery',
                        style: AppTextStyles.caption,
                      ),
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

class _SecurePaymentCard extends StatelessWidget {
  const _SecurePaymentCard();

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
              Icons.verified_user_outlined,
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
                    Text('Secure Payment', style: AppTextStyles.bodyStrong),
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
                        'ENCRYPTED',
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
                  'Your payment is protected with end-to-end encryption and '
                  'is 100% safe.',
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

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
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

class _StatBox extends StatelessWidget {
  const _StatBox({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: AppColors.grey500),
          const SizedBox(height: 8),
          Text(label, style: AppTextStyles.caption),
          const SizedBox(height: 2),
          Text(
            value,
            style: AppTextStyles.bodyStrong,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _AddressLine extends StatelessWidget {
  const _AddressLine({
    required this.icon,
    required this.iconSize,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final double iconSize;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Icon(icon, size: iconSize, color: AppColors.black),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.caption),
              Text(
                subtitle,
                style: AppTextStyles.bodyStrong,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
