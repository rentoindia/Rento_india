import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';
import '../services/orders_service.dart';
import 'rental_order.dart';
import 'inspection_refund_screen.dart';

class ReturnOtpScreen extends StatefulWidget {
  final RentalOrder order;
  final DateTime pickupDate;
  final String pickupSlot;

  const ReturnOtpScreen({
    super.key,
    required this.order,
    required this.pickupDate,
    required this.pickupSlot,
  });

  @override
  State<ReturnOtpScreen> createState() => _ReturnOtpScreenState();
}

class _ReturnOtpScreenState extends State<ReturnOtpScreen> {
  bool _confirming = false;

  // the code comes from the server: the customer tells it to the rider who collects the item
  late final String _otp =
      OrdersService.instance.findById(widget.order.id)?.deliveryOtp ??
      widget.order.deliveryOtp ??
      '----';

  void _confirmShared() async {
    setState(() => _confirming = true);
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    await OrdersService.instance.load();
    if (!mounted) return;
    final latest =
        OrdersService.instance.findById(widget.order.id) ?? widget.order;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => InspectionRefundScreen(order: latest)),
    );
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
          'Product Returned',
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
                      color: Color(0xFFF3F4F6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.assignment_return_outlined,
                      size: 40,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Confirm Return Pickup',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Share this code with the rider to confirm\nthey\'ve collected your item.',
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
                'Your Return Code',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5),
              ),
            ),
            const SizedBox(height: 6),
            Center(
              child: Text(
                'Read this out to your rider — don\'t type it in yourself',
                style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600),
              ),
            ),
            const SizedBox(height: 18),
            Center(child: _buildOtpDisplay()),
            const SizedBox(height: 28),
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

  DateTime get pickupDate => widget.pickupDate;
  String get pickupSlot => widget.pickupSlot;

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.black54),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 12.5, color: Colors.grey.shade600),
          ),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700),
        ),
      ],
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
    final steps = ['Return Scheduled', 'Rider Assigned', 'Returned'];
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
                isCurrent ? Icons.assignment_return : Icons.check,
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
