import '../../core/api_client.dart';
import '../core/my_house_api.dart';

import 'package:flutter/material.dart';

import 'application_status_screen.dart';

class ApplyPropertyScreen extends StatefulWidget {
  final Map<String, String> data;

  const ApplyPropertyScreen({super.key, required this.data});

  @override
  State<ApplyPropertyScreen> createState() => _ApplyPropertyScreenState();
}

class _ApplyPropertyScreenState extends State<ApplyPropertyScreen> {
  static const Color primaryDark = Color(0xFF1A1A2E);

  bool aadhaarUploaded = false;
  bool salarySlipUploaded = false;
  bool selfPhotoUploaded = false;
  bool emergencyContactAdded = false;
  bool termsAccepted = false;

  Widget _propertyImage(String? path) {
    final safePath = path ?? '';
    if (safePath.startsWith('assets/')) {
      return Image.asset(
        safePath,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: 60,
          height: 60,
          color: const Color(0xFFF5F5F5),
          child: const Icon(Icons.home, color: Colors.grey),
        ),
      );
    }
    return Image.network(
      safePath,
      width: 60,
      height: 60,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        width: 60,
        height: 60,
        color: const Color(0xFFF5F5F5),
        child: const Icon(Icons.home, color: Colors.grey),
      ),
    );
  }

  Widget _documentTile({
    required IconData icon,
    required String title,
    required bool uploaded,
    required String actionLabel,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: primaryDark),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          if (uploaded)
            const Icon(Icons.check_circle, color: Colors.green, size: 20)
          else
            GestureDetector(
              onTap: onTap,
              child: Text(
                actionLabel,
                style: const TextStyle(
                  color: primaryDark,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool allDone =
        aadhaarUploaded &&
        salarySlipUploaded &&
        selfPhotoUploaded &&
        emergencyContactAdded &&
        termsAccepted;

    final title =
        widget.data['title'] ?? '${widget.data['bhk'] ?? ''} Apartment';
    final location =
        widget.data['location'] ??
        '${widget.data['locality'] ?? ''}, ${widget.data['city'] ?? ''}';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: primaryDark),
        title: const Text(
          'Apply for Property',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Property',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE0E0E0)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: _propertyImage(widget.data['image']),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          location,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'Upload Documents',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            _documentTile(
              icon: Icons.badge_outlined,
              title: 'Aadhaar Card / ID Proof',
              uploaded: aadhaarUploaded,
              actionLabel: 'Upload',
              onTap: () => setState(() => aadhaarUploaded = true),
            ),
            _documentTile(
              icon: Icons.description_outlined,
              title: 'Salary Slip / Employment Proof',
              uploaded: salarySlipUploaded,
              actionLabel: 'Upload',
              onTap: () => setState(() => salarySlipUploaded = true),
            ),
            _documentTile(
              icon: Icons.phone_outlined,
              title: 'Emergency Contact',
              uploaded: emergencyContactAdded,
              actionLabel: 'Add',
              onTap: () => setState(() => emergencyContactAdded = true),
            ),
            _documentTile(
              icon: Icons.person_outline,
              title: 'Self Photo',
              uploaded: selfPhotoUploaded,
              actionLabel: 'Upload',
              onTap: () => setState(() => selfPhotoUploaded = true),
            ),

            const SizedBox(height: 12),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: termsAccepted,
                  activeColor: primaryDark,
                  onChanged: (val) =>
                      setState(() => termsAccepted = val ?? false),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      'I confirm that all the details provided are true.',
                      style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryDark,
                  disabledBackgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: allDone
                    ? () async {
                        try {
                          await MyHouseApi.instance.apply(
                            propertyId: widget.data['id'],
                          );
                        } on ApiException catch (e) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(e.message)));
                          return;
                        }
                        if (!mounted) return;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ApplicationStatusScreen(
                              bhkType: widget.data['bhk'] ?? '2 BHK',
                              city: widget.data['city'] ?? 'Chennai',
                              locality: widget.data['locality'] ?? 'Anna Nagar',
                            ),
                          ),
                        );
                      }
                    : null,
                child: const Text(
                  'Submit Application',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
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
