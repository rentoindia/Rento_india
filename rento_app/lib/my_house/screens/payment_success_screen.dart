import 'package:flutter/material.dart';
import 'payment_receipt_screen.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final String amount;
  final String payee;
  final String paymentMethod;

  const PaymentSuccessScreen({
    super.key,
    required this.amount,
    required this.payee,
    required this.paymentMethod,
  });

  static const Color primaryDark = Color(0xFF1A1A2E);

  String get _transactionId => 'TXN${DateTime.now().millisecondsSinceEpoch.toString().substring(3)}';
  String get _dateTime {
    final now = DateTime.now();
    return '${now.day.toString().padLeft(2, '0')} ${_month(now.month)} ${now.year}, ${_time(now)}';
  }

  String _month(int m) => const [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ][m - 1];

  String _time(DateTime d) {
    final hour = d.hour % 12 == 0 ? 12 : d.hour % 12;
    final period = d.hour >= 12 ? 'PM' : 'AM';
    return '${hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')} $period';
  }

  @override
  Widget build(BuildContext context) {
    final txnId = _transactionId;
    final dateTime = _dateTime;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // Success icon with confetti-style burst
              SizedBox(
                width: 130,
                height: 130,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check_rounded, color: Colors.white, size: 34),
                    ),
                    const Positioned(top: 6, right: 14, child: Text('🎉', style: TextStyle(fontSize: 18))),
                    const Positioned(bottom: 10, left: 10, child: Text('✨', style: TextStyle(fontSize: 16))),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              const Text(
                'Payment Successful!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryDark),
              ),
              const SizedBox(height: 10),
              Text(
                amount,
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: Color(0xFF10B981)),
              ),
              const SizedBox(height: 6),
              Text(
                'Paid to $payee',
                style: TextStyle(fontSize: 13.5, color: Colors.grey[600]),
              ),

              const SizedBox(height: 30),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FC),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _detailRow('Transaction ID', txnId),
                    const SizedBox(height: 12),
                    _detailRow('Date & Time', dateTime),
                    const SizedBox(height: 12),
                    _detailRow('Payment Method', paymentMethod),
                  ],
                ),
              ),

              const Spacer(),

              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFE0E0E0)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentReceiptScreen(
                                amount: amount,
                                payee: payee,
                                paymentMethod: paymentMethod,
                                transactionId: txnId,
                                dateTime: dateTime,
                                consumerNumber: '123456789012',
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'View Receipt',
                          style: TextStyle(color: primaryDark, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryDark,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        child: const Text(
                          'Done',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.headset_mic_outlined, size: 15, color: Colors.grey[600]),
                    const SizedBox(width: 6),
                    Text(
                      'Need Help? Contact Support',
                      style: TextStyle(fontSize: 12.5, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
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