import 'package:flutter/material.dart';

class PaymentReceiptScreen extends StatelessWidget {
  final String amount;
  final String payee;
  final String paymentMethod;
  final String transactionId;
  final String dateTime;
  final String consumerNumber;

  const PaymentReceiptScreen({
    super.key,
    required this.amount,
    required this.payee,
    required this.paymentMethod,
    required this.transactionId,
    required this.dateTime,
    required this.consumerNumber,
  });

  static const Color primaryDark = Color(0xFF1A1A2E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FC),
        elevation: 0,
        iconTheme: const IconThemeData(color: primaryDark),
        title: const Text(
          'Payment Receipt',
          style: TextStyle(color: primaryDark, fontWeight: FontWeight.bold, fontSize: 17),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sharing receipt...')),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    payee,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: primaryDark),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    amount,
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: primaryDark),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check_circle, size: 13, color: Color(0xFF10B981)),
                            SizedBox(width: 5),
                            Text(
                              'Payment Successful',
                              style: TextStyle(fontSize: 11.5, color: Color(0xFF10B981), fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(height: 1),
                  const SizedBox(height: 20),
                  _row('Transaction ID', transactionId),
                  const SizedBox(height: 14),
                  _row('Consumer Number', consumerNumber),
                  const SizedBox(height: 14),
                  _row('Date & Time', dateTime),
                  const SizedBox(height: 14),
                  _row('Payment Method', paymentMethod),
                ],
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  side: const BorderSide(color: Color(0xFFE0E0E0)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Receipt downloaded!')),
                  );
                },
                icon: const Icon(Icons.download_rounded, color: primaryDark, size: 18),
                label: const Text(
                  'Download Receipt',
                  style: TextStyle(color: primaryDark, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
        Text(
          value,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: primaryDark),
        ),
      ],
    );
  }
}