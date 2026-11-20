import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/section_card.dart';
import '../../parcel/models/booking_model.dart' show PaymentMethod;
import '../../parcel/widgets/payment_method_tile.dart';
import '../providers/ride_booking_provider.dart';
import '../widgets/ride_fare_breakdown_card.dart';
import 'ride_rating_screen.dart';

/// "Payment" — reuses the parcel module's `PaymentMethodTile` widget and
/// `PaymentMethod` enum directly, styled identically to `PaymentScreen`.
class RidePaymentScreen extends ConsumerStatefulWidget {
  const RidePaymentScreen({super.key});

  @override
  ConsumerState<RidePaymentScreen> createState() => _RidePaymentScreenState();
}

class _RidePaymentScreenState extends ConsumerState<RidePaymentScreen> {
  bool _paying = false;

  Future<void> _pay() async {
    setState(() => _paying = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _paying = false);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const RideRatingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final booking = ref.watch(rideBookingProvider);
    final notifier = ref.read(rideBookingProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: const FlowAppBar(eyebrow: 'RIDE', title: 'Payment'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                children: [
                  RideFareBreakdownCard(booking: booking),
                  const SizedBox(height: 22),
                  Text('PAYMENT METHOD', style: AppTextStyles.overline),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: Column(
                      children: [
                        for (final method in PaymentMethod.values)
                          PaymentMethodTile(
                            method: method,
                            selected: booking.paymentMethod == method,
                            onTap: () => notifier.selectPaymentMethod(method),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: PrimaryButton(
                label: 'Pay',
                leadingText: '\u20B9${booking.totalFare.toStringAsFixed(0)}',
                loading: _paying,
                onPressed: _pay,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
