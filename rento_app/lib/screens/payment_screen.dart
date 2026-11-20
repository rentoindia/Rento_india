import 'dart:math';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../core/api_client.dart';
import '../services/orders_service.dart';
import '../services/wallet_service.dart';
import 'rental_order.dart';
import 'delivery_otp_screen.dart';

class PaymentScreen extends StatefulWidget {
  final RentalOrder order;
  const PaymentScreen({super.key, required this.order});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedMethod = 'cash';
  bool _processing = false;
  bool _useWalletCoins = false;

  late double _riderTip;

  static const double _platformFeeRate = 0.05; // 5% of rental price
  static const double _insuranceRate =
      0.04; // 4% of rental price (matches the ₹20 on ₹500 example)
  static const double _gstRate = 0.18; // 18% on applicable service charges only

  double get _rentalPrice => widget.order.rentalAmount;
  double get _platformFee => _rentalPrice * _platformFeeRate;
  double get _insurance => _rentalPrice * _insuranceRate;
  double get _deliveryAndPickup =>
      widget.order.deliveryFee + widget.order.pickupFee;
  double get _gst =>
      (_platformFee + _insurance + _deliveryAndPickup) * _gstRate;
  double get _subtotal =>
      _rentalPrice + _platformFee + _insurance + _deliveryAndPickup + _gst;
  double get _refundableDeposit => widget.order.securityDepositValue;
  double get _totalPaidAtCheckout => _subtotal + _refundableDeposit;

  @override
  void initState() {
    super.initState();
    _riderTip = 0; // Rider tip is a separate, optional add-on — not part of the standard checkout breakdown.
  }

  double _maxRedeemable(double payableBeforeCoins) =>
      min(WalletService.instance.coins, payableBeforeCoins);

  double _coinsApplied(double payableBeforeCoins) =>
      _useWalletCoins ? _maxRedeemable(payableBeforeCoins) : 0;

  void _pay() async {
    setState(() => _processing = true);
    try {
      final order = widget.order;
      final payableBeforeCoins = _totalPaidAtCheckout + _riderTip;
      final coinsApplied = _coinsApplied(payableBeforeCoins);

      // The server records the payment, redeems the coins, credits cashback coins and
      // sends a rider. When you add Razorpay: open its checkout here first, then pass
      // razorpayOrderId / razorpayPaymentId / razorpaySignature to payOrder().
      final paidOrder = await OrdersService.instance.payOrder(
        order,
        method: _selectedMethod.toUpperCase(),
        amount: payableBeforeCoins - coinsApplied,
        coins: coinsApplied,
      );
      if (!mounted) return;

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => DeliveryOtpScreen(order: paidOrder)),
      );
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() => _processing = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Payment failed: ${e.message}')));
    } catch (e, stack) {
      debugPrint('PaymentScreen pay failed: $e\n$stack');
      if (!mounted) return;
      setState(() => _processing = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Payment failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: WalletService.instance,
      builder: (context, _) {
        final payableBeforeCoins = _totalPaidAtCheckout + _riderTip;
        final coinsApplied = _coinsApplied(payableBeforeCoins);
        final grandTotal = payableBeforeCoins - coinsApplied;
        final availableCoins = WalletService.instance.coins;

        return Scaffold(
          backgroundColor: const Color(0xFFF7F8FA),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            foregroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Column(
              children: [
                Text(
                  'Payment',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Complete your rental booking',
                  style: TextStyle(color: Colors.black54, fontSize: 10.5),
                ),
              ],
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.help_outline, color: Colors.black87),
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Need help? Contact support from the Profile tab.',
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              children: [
                _sectionLabel('CHOOSE A PAYMENT METHOD'),
                const SizedBox(height: 10),

                _sectionLabel('CASH'),
                const SizedBox(height: 8),
                _methodTile(
                  id: 'cash',
                  leading: _leadingIcon(
                    Icons.currency_rupee,
                    bg: const Color(0xFFEFEBFF),
                    fg: const Color(0xFF6D5EF8),
                  ),
                  title: 'Pay by cash',
                  subtitle: 'Pay by cash',
                ),
                const SizedBox(height: 18),

                _sectionLabel('UPI'),
                const SizedBox(height: 8),
                _methodTile(
                  id: 'gpay',
                  leading: _leadingIcon(
                    Icons.qr_code_2,
                    bg: AppTheme.lightGrey,
                    fg: Colors.black87,
                  ),
                  title: 'Google Pay',
                  subtitle: 'Pay via UPI',
                ),
                _methodTile(
                  id: 'phonepe',
                  leading: _leadingIcon(
                    Icons.qr_code_2,
                    bg: AppTheme.lightGrey,
                    fg: Colors.black87,
                  ),
                  title: 'PhonePe',
                  subtitle: 'Pay via UPI',
                ),
                _methodTile(
                  id: 'paytm_upi',
                  leading: _leadingIcon(
                    Icons.qr_code_2,
                    bg: AppTheme.lightGrey,
                    fg: Colors.black87,
                  ),
                  title: 'Paytm',
                  subtitle: 'Pay via UPI',
                ),
                _methodTile(
                  id: 'bhim',
                  leading: _leadingIcon(
                    Icons.qr_code_2,
                    bg: AppTheme.lightGrey,
                    fg: Colors.black87,
                  ),
                  title: 'BHIM UPI',
                  subtitle: 'Pay via UPI',
                ),
                const SizedBox(height: 18),

                _sectionLabel('CARDS'),
                const SizedBox(height: 8),
                _methodTile(
                  id: 'card',
                  leading: _leadingIcon(
                    Icons.credit_card,
                    bg: AppTheme.lightGrey,
                    fg: Colors.black87,
                  ),
                  title: 'Debit / Credit Card',
                  subtitle: 'Visa, Mastercard, Rupay',
                ),
                const SizedBox(height: 18),

                _sectionLabel('WALLETS'),
                const SizedBox(height: 8),
                _buildWalletCoinsCard(payableBeforeCoins, availableCoins),
                const SizedBox(height: 18),
                _sectionLabel('OTHER OPTIONS'),
                const SizedBox(height: 8),
                _methodTile(
                  id: 'netbanking',
                  leading: _leadingIcon(
                    Icons.account_balance_outlined,
                    bg: AppTheme.lightGrey,
                    fg: Colors.black87,
                  ),
                  title: 'Net Banking',
                  subtitle: 'All major banks',
                ),
                const SizedBox(height: 18),

                GestureDetector(
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Coupon codes coming soon')),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.border),
                    ),
                    child: Row(
                      children: [
                        _leadingIcon(
                          Icons.local_offer_outlined,
                          bg: const Color(0xFFFFF7ED),
                          fg: const Color(0xFFEA580C),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Apply Coupon',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13.5,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'OFFERS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.chevron_right, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  'Fare Summary',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppTheme.border),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _fareRow(
                        'Rental Price',
                        '₹${_rentalPrice.toStringAsFixed(2)}',
                      ),
                      _fareRow(
                        'Platform Convenience Fee (5%)',
                        '₹${_platformFee.toStringAsFixed(2)}',
                      ),
                      _fareRow(
                        'Product Protection / Insurance',
                        '₹${_insurance.toStringAsFixed(2)}',
                      ),
                      _fareRow(
                        'Delivery & Pickup',
                        '₹${_deliveryAndPickup.toStringAsFixed(2)}',
                      ),
                      _fareRow(
                        'GST (18% on applicable service charges)',
                        '₹${_gst.toStringAsFixed(2)}',
                      ),
                      const Divider(height: 20),
                      _fareRow(
                        'Subtotal',
                        '₹${_subtotal.toStringAsFixed(2)}',
                        bold: true,
                      ),
                      const SizedBox(height: 4),
                      _fareRow(
                        'Refundable Security Deposit',
                        '₹${_refundableDeposit.toStringAsFixed(2)}',
                      ),
                      const Divider(height: 20),
                      _fareRow(
                        'Total Paid at Checkout',
                        '₹${_totalPaidAtCheckout.toStringAsFixed(2)}',
                        bold: true,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                _buildRiderTipCard(),

                if (coinsApplied > 0) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.lightGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Wallet Coins Applied',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12.5,
                          ),
                        ),
                        Text(
                          '- ₹${coinsApplied.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Amount Payable',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '₹${grandTotal.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _processing ? null : _pay,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _processing
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'Pay ₹${grandTotal.toStringAsFixed(0)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock_outline,
                        size: 12,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Your payment is secure with Razorpay',
                        style: TextStyle(
                          fontSize: 10.5,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: Colors.grey.shade500,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _leadingIcon(IconData icon, {required Color bg, required Color fg}) {
    return Container(
      width: 38,
      height: 38,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, size: 18, color: fg),
    );
  }

  Widget _methodTile({
    required String id,
    required Widget leading,
    required String title,
    required String subtitle,
    String? trailingBadge,
  }) {
    final selected = _selectedMethod == id;
    return GestureDetector(
      onTap: () => setState(() => _selectedMethod = id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: selected ? Colors.black : AppTheme.border,
            width: selected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            leading,
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.5,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            if (trailingBadge != null) ...[
              Text(
                trailingBadge,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 11.5,
                ),
              ),
              const SizedBox(width: 8),
            ],
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              size: 20,
              color: selected ? Colors.black : Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _fareRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: bold ? Colors.black : AppTheme.grey,
                fontWeight: bold ? FontWeight.w800 : FontWeight.w400,
                fontSize: bold ? 14.5 : 12.5,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.w800 : FontWeight.w700,
              fontSize: bold ? 16 : 12.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiderTipCard() {
    const double step = 10;
    const double maxTip = 500;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppTheme.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF7ED),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.volunteer_activism_outlined,
              size: 18,
              color: Color(0xFFEA580C),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add a Rider Tip',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                ),
                const SizedBox(height: 2),
                Text(
                  '100% of your tip goes directly to your delivery rider.',
                  style: TextStyle(fontSize: 10.5, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Row(
            children: [
              GestureDetector(
                onTap: () => setState(
                  () => _riderTip = (_riderTip - step).clamp(0, maxTip),
                ),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppTheme.lightGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.remove,
                    size: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(
                width: 52,
                child: Text(
                  '₹${_riderTip.toStringAsFixed(0)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => setState(
                  () => _riderTip = (_riderTip + step).clamp(0, maxTip),
                ),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.add, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWalletCoinsCard(
    double payableBeforeCoins,
    double availableCoins,
  ) {
    final maxRedeemable = min(availableCoins, payableBeforeCoins);
    final hasCoins = availableCoins > 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: _useWalletCoins ? Colors.black : AppTheme.border,
          width: _useWalletCoins ? 1.5 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.monetization_on_outlined,
              size: 18,
              color: Color(0xFFB45309),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Rento Wallet',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                ),
                Text(
                  hasCoins
                      ? 'You have ₹${availableCoins.toStringAsFixed(0)} in coins · up to ₹${maxRedeemable.toStringAsFixed(0)} applicable'
                      : 'No coins available yet — earn some by renting!',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Switch(
            value: _useWalletCoins,
            onChanged: hasCoins
                ? (v) => setState(() => _useWalletCoins = v)
                : null,
            activeColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
