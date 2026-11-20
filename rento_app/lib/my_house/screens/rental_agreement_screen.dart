
import 'package:flutter/material.dart';
import 'payment_screen.dart';

class RentalAgreementScreen extends StatefulWidget {
  final String bhkType;
  final String city;
  final String locality;

  const RentalAgreementScreen({
    super.key,
    this.bhkType = '2 BHK',
    this.city = 'Chennai',
    this.locality = 'Anna Nagar',
  });

  @override
  State<RentalAgreementScreen> createState() => _RentalAgreementScreenState();
}

class _RentalAgreementScreenState extends State<RentalAgreementScreen> {
  bool ownerSigned = true;
  bool tenantSigned = false;

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 13, color: Colors.grey[600]),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _signatureBox({
    required String label,
    required bool signed,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: signed ? const Color(0xFF1A1A1A) : const Color(0xFFE0E0E0),
                    width: 1.5,
                  ),
                ),
              ),
              child: signed
                  ? const Icon(Icons.draw, size: 28, color: Color(0xFF1A1A1A))
                  : Text(
                      'Tap to sign',
                      style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool allSigned = ownerSigned && tenantSigned;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1A1A1A)),
        title: const Text(
          'Rental Agreement',
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE0E0E0)),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'RENTAL AGREEMENT',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Center(
                    child: Text(
                      'This Agreement is made on 15 May 2025',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Between',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Owner: Mr. Ramesh Kumar',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'And',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Tenant: Mr. Kartik Raj',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 10),
                  Text(
                    'Property: ${widget.bhkType}, ${widget.locality}, ${widget.city}',
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                  ),

                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 8),

                  _detailRow('Monthly Rent', '₹12,000'),
                  _detailRow('Deposit', '₹36,000'),
                  _detailRow('Duration', '11 Months'),
                  _detailRow('Notice Period', '30 Days'),

                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 12),

                  const Text(
                    'Terms & Conditions',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tenant agrees to pay rent on or before the 5th of every month. '
                    'Deposit is refundable upon vacating the property, subject to '
                    'deductions for damages. Either party may terminate this '
                    'agreement by giving the notice period mentioned above.',
                    style: TextStyle(fontSize: 12, color: Colors.grey[700], height: 1.5),
                  ),

                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      _signatureBox(
                        label: 'Owner Signature',
                        signed: ownerSigned,
                        onTap: () {},
                      ),
                      const SizedBox(width: 20),
                      _signatureBox(
                        label: 'Tenant Signature',
                        signed: tenantSigned,
                        onTap: () => setState(() => tenantSigned = true),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
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
                onPressed: allSigned
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentScreen(
                              bhkType: widget.bhkType,
                              city: widget.city,
                              locality: widget.locality,
                            ),
                          ),
                        );
                      }
                    : () => setState(() => tenantSigned = true),
                child: Text(
                  allSigned ? 'Agreement Signed ✓' : 'Sign & Continue',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

