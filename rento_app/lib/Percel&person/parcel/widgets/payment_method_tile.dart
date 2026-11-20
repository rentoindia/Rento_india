import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../models/booking_model.dart';

/// Icon shown for each payment method — shared between [PaymentMethodTile]
/// and the "Pay" button on the payment screen so they always match.
IconData paymentMethodIcon(PaymentMethod method) {
  switch (method) {
    case PaymentMethod.cashOnDelivery:
      return Icons.currency_rupee;
    case PaymentMethod.googlePay:
    case PaymentMethod.phonePe:
    case PaymentMethod.paytmUpi:
    case PaymentMethod.bhimUpi:
      return Icons.qr_code_2_outlined;
    case PaymentMethod.card:
      return Icons.credit_card_outlined;
    case PaymentMethod.paytmWallet:
      return Icons.account_balance_wallet_outlined;
    case PaymentMethod.netBanking:
      return Icons.account_balance_outlined;
  }
}

class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile({
    super.key,
    required this.method,
    required this.selected,
    required this.onTap,
    this.subtitle,
    this.trailingBadge,
  });

  final PaymentMethod method;
  final bool selected;
  final VoidCallback onTap;
  final String? subtitle;

  /// Small pill shown before the radio, e.g. a wallet balance ("\u20B9123").
  final String? trailingBadge;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: selected ? AppColors.grey50 : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: selected ? AppColors.black : Colors.transparent,
          width: 1.4,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 9),
            child: Row(
              children: [
                Container(
                  height: 38,
                  width: 38,
                  decoration: const BoxDecoration(
                    color: AppColors.grey50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    paymentMethodIcon(method),
                    size: 18,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(method.label, style: AppTextStyles.bodyStrong),
                      if (subtitle != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(subtitle!, style: AppTextStyles.caption),
                        ),
                    ],
                  ),
                ),
                if (trailingBadge != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.grey100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      trailingBadge!,
                      style: AppTextStyles.caption.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected ? AppColors.black : Colors.transparent,
                    border: Border.all(
                      color: selected ? AppColors.black : AppColors.grey300,
                      width: 1.6,
                    ),
                  ),
                  child: selected
                      ? const Icon(
                          Icons.check,
                          size: 13,
                          color: AppColors.white,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
