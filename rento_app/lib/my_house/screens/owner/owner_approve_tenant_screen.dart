import 'package:flutter/material.dart';
import 'owner_theme.dart';

/// RENTO INDIA — Owner Flow Screen 3: Approve Tenant & Move-In
class OwnerApproveTenantScreen extends StatelessWidget {
  const OwnerApproveTenantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final documents = [
      {'label': 'Aadhaar Card', 'status': 'Verified'},
      {'label': 'Salary Slip', 'status': 'Verified'},
      {'label': 'Self Photo', 'status': 'Verified'},
    ];

    return Scaffold(
      backgroundColor: OwnerTheme.bgGrey,
      appBar: OwnerTheme.appBar(context, 'Tenant Details'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Tenant header card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: OwnerTheme.card,
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: OwnerTheme.borderGrey,
                  child: Icon(Icons.person,
                      color: OwnerTheme.primaryDark, size: 28),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Karthik Raj', style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: OwnerTheme.primaryDark)),
                    const SizedBox(height: 4),
                    OwnerTheme.statusBadge('Verified Tenant',
                        color: OwnerTheme.success),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Text('Documents', style: OwnerTheme.heading),
          const SizedBox(height: 10),
          Container(
            decoration: OwnerTheme.card,
            child: Column(
              children: documents.map((doc) {
                final isLast = doc == documents.last;
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    border: isLast
                        ? null
                        : const Border(
                            bottom: BorderSide(color: OwnerTheme.borderGrey)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.description_outlined,
                          color: OwnerTheme.textGrey, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(doc['label']!,
                            style: const TextStyle(
                                color: OwnerTheme.primaryDark, fontSize: 14)),
                      ),
                      OwnerTheme.statusBadge(doc['status']!,
                          color: OwnerTheme.success),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),

          Text('Permanent Address', style: OwnerTheme.heading),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: OwnerTheme.card,
            child: const Text(
              '12/4, 2nd Street, Villivakkam, Chennai - 600049',
              style: TextStyle(color: OwnerTheme.primaryDark, fontSize: 14),
            ),
          ),
          const SizedBox(height: 32),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // TODO: reject with reason dialog
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: OwnerTheme.danger),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Reject',
                      style: TextStyle(
                          color: OwnerTheme.danger,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: approve tenant -> generate rental agreement
                  },
                  style: OwnerTheme.primaryButton,
                  child: const Text('Approve',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                // Reuses tenant-side chat_screen.dart — pass tenant name via constructor
                // Navigator.push(context, MaterialPageRoute(
                //   builder: (context) => const ChatScreen(contactName: 'Karthik Raj'),
                // ));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening chat...')),
                );
              },
              icon: const Icon(Icons.chat_bubble_outline,
                  color: OwnerTheme.primaryDark, size: 18),
              label: const Text('Chat with Tenant',
                  style: TextStyle(color: OwnerTheme.primaryDark)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: OwnerTheme.borderGrey),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}