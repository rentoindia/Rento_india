import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';
import '../services/orders_service.dart';
import 'rental_order.dart';
import 'orders_screen.dart';

class DeliveryOtpScreen extends StatefulWidget {
  final RentalOrder order;
  const DeliveryOtpScreen({super.key, required this.order});

  @override
  State<DeliveryOtpScreen> createState() => _DeliveryOtpScreenState();
}

class _DeliveryOtpScreenState extends State<DeliveryOtpScreen> {
  bool _confirming = false;

  // the code comes from the server: the customer tells it to the delivery rider
  late final String _otp =
      OrdersService.instance.findById(widget.order.id)?.deliveryOtp ??
      widget.order.deliveryOtp ??
      '----';

  void _confirmShared() async {
    setState(() => _confirming = true);
    try {
      await Future.delayed(const Duration(milliseconds: 600));
      if (!mounted) return;

      // the rider confirms delivery with this OTP; the order then updates by itself (live)
      await OrdersService.instance.load();

      if (!mounted) return;

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const OrdersScreen()),
        (route) => route.isFirst,
      );
    } catch (e, stack) {
      debugPrint('DeliveryOtpScreen confirm failed: $e\n$stack');
      if (!mounted) return;
      setState(() => _confirming = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Something went wrong: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Product Delivered',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          children: [
            _buildTimeline(),
            const SizedBox(height: 28),
            Center(
              child: Column(
                children: [
                  Container(
                    width: 84,
                    height: 84,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEAFBF0),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      size: 44,
                      color: Color(0xFF22C55E),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(height: 6),
                  Text(
                    'Share the code below so\nthey can confirm the delivery.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12.5,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Center(
              child: Text(
                'Your Delivery Code',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5),
              ),
            ),
            const SizedBox(height: 6),
            Center(),
            const SizedBox(height: 18),
            Center(child: _buildOtpDisplay()),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: PrimaryButton(
            label: _confirming ? 'CONFIRMING...' : 'I\'VE SHARED THE CODE',
            icon: Icons.check,
            onPressed: _confirming ? () {} : _confirmShared,
          ),
        ),
      ),
    );
  }

  Widget _buildOtpDisplay() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
      decoration: BoxDecoration(
        color: AppTheme.lightGrey,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _otp.split('').map((digit) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              digit,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTimeline() {
    final steps = ['Rider Assigned', 'Out for Delivery', 'Delivered'];
    return Row(
      children: List.generate(steps.length * 2 - 1, (i) {
        if (i.isOdd) {
          return Expanded(child: Container(height: 2, color: Colors.black));
        }
        final index = i ~/ 2;
        final isCurrent = index == steps.length - 1;
        return Column(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isCurrent ? Icons.local_shipping : Icons.check,
                size: 12,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              steps[index],
              style: TextStyle(
                fontSize: 8.5,
                fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        );
      }),
    );
  }
}
