import 'package:flutter/material.dart';
import 'apply_property_screen.dart';
import 'application_status_screen.dart';
import 'rental_agreement_screen.dart';
import 'payment_screen.dart';
import 'rent_payment_screen.dart';

/// A standalone menu that links straight to the 5 requested screens.
/// This does NOT hook into any other flow in the app — it's just a
/// direct-access list so each screen can be opened and viewed on its own,
/// with placeholder property data so they render correctly.
class QuickAccessMenuScreen extends StatelessWidget {
  const QuickAccessMenuScreen({super.key});

  static const Color primaryDark = Color(0xFF1A1A2E);

  // Placeholder property data used to open the screens that expect a
  // `data` map or bhk/city/locality — same defaults used elsewhere in
  // the app (2 BHK, Anna Nagar, Chennai).
  static final Map<String, String> _placeholderData = {
    'bhk': '2 BHK',
    'city': 'Chennai',
    'locality': 'Anna Nagar',
    'title': '2 BHK Apartment',
    'location': 'Anna Nagar, Chennai',
  };

  Widget _menuTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget destination,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: primaryDark.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: primaryDark, size: 20),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 11.5, color: Colors.grey[600])),
        trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => destination));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: primaryDark),
        title: const Text(
          'Quick Access',
          style: TextStyle(color: primaryDark, fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _menuTile(
            context: context,
            icon: Icons.assignment_outlined,
            title: 'Apply for Property',
            subtitle: 'Upload documents & submit application',
            destination: ApplyPropertyScreen(data: _placeholderData),
          ),
          _menuTile(
            context: context,
            icon: Icons.fact_check_outlined,
            title: 'Application Status',
            subtitle: 'Track your submitted application',
            destination: const ApplicationStatusScreen(
              bhkType: '2 BHK',
              city: 'Chennai',
              locality: 'Anna Nagar',
            ),
          ),
          _menuTile(
            context: context,
            icon: Icons.description_outlined,
            title: 'Rental Agreement',
            subtitle: 'View & sign the rental agreement',
            destination: const RentalAgreementScreen(
              bhkType: '2 BHK',
              city: 'Chennai',
              locality: 'Anna Nagar',
            ),
          ),
          _menuTile(
            context: context,
            icon: Icons.payment_outlined,
            title: 'Payment',
            subtitle: 'Pay deposit & first month rent',
            destination: const PaymentScreen(
              bhkType: '2 BHK',
              city: 'Chennai',
              locality: 'Anna Nagar',
            ),
          ),
          _menuTile(
            context: context,
            icon: Icons.receipt_long_outlined,
            title: 'Rent Payment',
            subtitle: 'Pay monthly rent & view history',
            destination: RentPaymentScreen(data: _placeholderData),
          ),
        ],
      ),
    );
  }
}