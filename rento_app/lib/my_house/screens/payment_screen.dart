import 'package:flutter/material.dart';
import 'rent_payment_screen.dart';

class PaymentScreen extends StatefulWidget {
  final String bhkType;
  final String city;
  final String locality;

  const PaymentScreen({
    super.key,
    this.bhkType = '2 BHK',
    this.city = 'Chennai',
    this.locality = 'Anna Nagar',
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedMethod = '';

  final int securityDeposit = 36000;
  final int firstMonthRent = 12000;

  Widget _amountRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 15 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? const Color(0xFF1A1A1A) : Colors.grey[700],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: isTotal ? 17 : 14,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A1A1A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentMethodTile(IconData icon, String label) {
    final bool selected = selectedMethod == label;
    return GestureDetector(
      onTap: () => setState(() => selectedMethod = label),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? const Color(0xFF1A1A1A) : const Color(0xFFE0E0E0),
            width: selected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 22, color: const Color(0xFF1A1A1A)),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? const Color(0xFF1A1A1A) : Colors.grey[400],
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int total = securityDeposit + firstMonthRent;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1A1A1A)),
        title: const Text(
          'Payment',
          style: TextStyle(
            color: Color(0xFF1A1A1A),
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Details',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE0E0E0)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _amountRow('Security Deposit', '₹${securityDeposit.toString()}'),
                  const Divider(height: 1),
                  _amountRow('First Month Rent', '₹${firstMonthRent.toString()}'),
                  const Divider(height: 1),
                  _amountRow('Total Amount', '₹${total.toString()}', isTotal: true),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'Select Payment Method',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            _paymentMethodTile(Icons.qr_code_scanner, 'UPI'),
            _paymentMethodTile(Icons.credit_card, 'Card'),
            _paymentMethodTile(Icons.account_balance_wallet_outlined, 'Wallet'),
            _paymentMethodTile(Icons.account_balance_outlined, 'Net Banking'),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A1A1A),
                  disabledBackgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: selectedMethod.isNotEmpty
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RentPaymentScreen(
                              data: {
                                'bhk': widget.bhkType,
                                'city': widget.city,
                                'locality': widget.locality,
                              },
                            ),
                          ),
                        );
                      }
                    : null,
                child: Text(
                  'Pay ₹${total.toString()}',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 16),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.verified_user, size: 15, color: Colors.green[600]),
                  const SizedBox(width: 6),
                  Text(
                    '100% Secure Payment',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}