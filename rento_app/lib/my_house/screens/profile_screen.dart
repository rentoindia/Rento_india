
import 'dart:io';
import 'package:flutter/material.dart';
import 'my_documents_screen.dart';
import 'payment_methods_screen.dart';
import 'help_support_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // FIX: this state used to live nowhere — ProfileScreen was a
  // StatelessWidget with a hardcoded name/avatar, so anything typed or
  // picked on the Edit Profile screen was thrown away on Save. Now it
  // lives here, gets passed into EditProfileScreen as initial values,
  // and gets updated from the result EditProfileScreen returns.
  String tenantName = 'Karthik Raj';
  String tenantPhone = '+91 98765 43210';
  String tenantEmail = 'karthik.raj@email.com';
  String tenantGender = 'Male';
  File? tenantImage;

  // Pass current values in, await the result coming back from Save, then
  // setState so this screen re-renders with the new name/photo/etc.
  // Called from the "Edit Profile" row.
  Future<void> _openEditProfile(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          initialName: tenantName,
          initialPhone: tenantPhone,
          initialEmail: tenantEmail,
          initialGender: tenantGender,
          initialImage: tenantImage,
        ),
      ),
    );
    if (result != null && result is Map) {
      setState(() {
        tenantName = result['name'] as String;
        tenantPhone = result['phone'] as String;
        tenantEmail = result['email'] as String;
        tenantGender = result['gender'] as String;
        tenantImage = result['image'] as File?;
      });
    }
  }

  Widget _menuItem(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: const Color(0xFF1A1A1A)),
            const SizedBox(width: 14),
            Expanded(
              child: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
          ],
        ),
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
        iconTheme: const IconThemeData(color: Color(0xFF1A1A1A)),
        title: const Text(
          'Profile',
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
          children: [
            // FIX: removed the pencil edit badge that used to sit on top
            // of this avatar — the "Edit Profile" row below already opens
            // the same screen, so the badge here isn't needed.
            CircleAvatar(
              radius: 40,
              backgroundColor: const Color(0xFFF5F5F5),
              // Default avatar (the curly-hair photo) shows until the
              // tenant picks their own photo via Edit Profile.
              backgroundImage: tenantImage != null
                  ? FileImage(tenantImage!)
                  : const AssetImage('assets/images/rental/tenant_default.png') as ImageProvider,
            ),
            const SizedBox(height: 12),
            Text(
              tenantName,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Tenant',
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            ),
            const SizedBox(height: 28),

            _menuItem(context, Icons.edit_outlined, 'Edit Profile', () => _openEditProfile(context)),
            _menuItem(context, Icons.folder_outlined, 'My Documents', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyDocumentsScreen()),
              );
            }),
            _menuItem(context, Icons.payment_outlined, 'Payment Methods', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PaymentMethodsScreen()),
              );
            }),
            _menuItem(context, Icons.help_outline, 'Help & Support', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpSupportScreen()),
              );
            }),
            _menuItem(context, Icons.logout, 'Logout', () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out')),
              );
            }),
          ],
        ),
      ),
    );
  }
}


