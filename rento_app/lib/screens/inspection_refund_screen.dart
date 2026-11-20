import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';
import '../services/orders_service.dart';
import '../services/wallet_service.dart';
import 'rental_order.dart';
import 'refund_received_screen.dart';

class InspectionRefundScreen extends StatelessWidget {
  final RentalOrder order;
  // In a real app this comes from the vendor's inspection submission —
  // defaults to "no damage" for the happy-path demo.
  final bool damageFound;
  final double deductionAmount;

  const InspectionRefundScreen({
    super.key,
    required this.order,
    this.damageFound = false,
    this.deductionAmount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final refundAmount = order.securityDepositValue - deductionAmount;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: const Text('Inspection & Refund', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 15)),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 84,
                    height: 84,
                    decoration: const BoxDecoration(color: Color(0xFFF3F4F6), shape: BoxShape.circle),
                    child: const Icon(Icons.shield_outlined, size: 38, color: Colors.black87),
                  ),
                  const SizedBox(height: 16),
                  const Text('Inspection Completed', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: damageFound ? const Color(0xFFFEE2E2) : const Color(0xFFEAFBF0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(damageFound ? Icons.warning_amber_rounded : Icons.check_circle, size: 15, color: damageFound ? const Color(0xFFB91C1C) : const Color(0xFF16A34A)),
                      const SizedBox(width: 6),
                      Text(
                        damageFound ? 'Damage Found' : 'No Damage Found',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: damageFound ? const Color(0xFFB91C1C) : const Color(0xFF166534)),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    damageFound
                        ? 'A deduction has been applied. See the breakdown below.'
                        : 'Great! Your item is in perfect condition.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12.5, height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(border: Border.all(color: AppTheme.border), borderRadius: BorderRadius.circular(14)),
              child: Column(
                children: [
                  _row('Security Deposit', '₹${order.securityDepositValue.toStringAsFixed(0)}'),
                  if (damageFound) ...[
                    const Divider(height: 22),
                    _row('Deduction', '- ₹${deductionAmount.toStringAsFixed(0)}'),
                  ],
                  const Divider(height: 22),
                  _row('Refund Status', 'Initiated'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(color: AppTheme.lightGrey, borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, size: 18, color: Colors.black54),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Refund will be credited to your Rento Wallet within 2–3 business days.',
                      style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700, height: 1.35),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: PrimaryButton(
            label: 'VIEW DETAILS',
            onPressed: () {
              final updatedOrder = order.copyWith(status: OrderStatus.completed);
              OrdersService.instance.upsert(updatedOrder);
              // Deposit refund lands in the wallet too, per the spec's
              // "Refund to Wallet" flow — separate from earned rental
              // coins so the transaction history stays readable.
              WalletService.instance.refund(refundAmount, 'Deposit refund: ${order.name}');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RefundReceivedScreen(
                    order: updatedOrder,
                    refundAmount: refundAmount,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 12.5, color: Colors.grey.shade600)),
        Text(value, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700)),
      ],
    );
  }
}