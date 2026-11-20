import 'package:flutter/material.dart';
import 'rental_agreement_screen.dart';

class ApplicationStatusScreen extends StatelessWidget {
  final String? bhkType;
  final String? city;
  final String? locality;

  const ApplicationStatusScreen({
    super.key,
    this.bhkType,
    this.city,
    this.locality,
  });

  static const Color primaryDark = Color(0xFF1A1A2E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: primaryDark),
        title: const Text(
          'Application Status',
          style: TextStyle(
            color: primaryDark,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 24),

            // Icon: clipboard with green check badge
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Icon(Icons.assignment_outlined, size: 40, color: primaryDark),
                  ),
                  Positioned(
                    right: 18,
                    bottom: 18,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check_circle, color: Colors.green, size: 20),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'Application Submitted',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: primaryDark),
            ),
            const SizedBox(height: 8),
            Text(
              'Owner will review your application and get back to you soon.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            ),

            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE0E0E0)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Application Status',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF3CD),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Under Review',
                          style: TextStyle(
                            color: Color(0xFF9A7D0A),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'You will be notified once the owner takes action.',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: primaryDark),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // NOTE: video ends right after this screen, so what "View
                  // Application" opens next isn't shown. Wiring it to the
                  // Rental Agreement screen since that's the next completed
                  // page in the flow (apply -> status -> agreement -> pay).
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RentalAgreementScreen(
                        bhkType: bhkType ?? '2 BHK',
                        city: city ?? 'Chennai',
                        locality: locality ?? 'Anna Nagar',
                      ),
                    ),
                  );
                },
                child: const Text(
                  'View Application',
                  style: TextStyle(color: primaryDark, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}