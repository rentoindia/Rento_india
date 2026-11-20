import 'package:flutter/material.dart';
import 'owner_theme.dart';

/// RENTO INDIA — Owner Flow Screen 4: Track Rent Collection
class OwnerRentCollectionScreen extends StatelessWidget {
  const OwnerRentCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rentRows = [
      {'name': 'Karthik Raj', 'date': '15 May 2025', 'amount': '₹12,000', 'status': 'Paid'},
      {'name': 'Vignesh Kumar', 'date': '14 May 2025', 'amount': '₹9,000', 'status': 'Pending'},
    ];

    return Scaffold(
      backgroundColor: OwnerTheme.bgGrey,
      appBar: OwnerTheme.appBar(context, 'Rent Collection'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Property summary card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: OwnerTheme.card,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: OwnerTheme.borderGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.home_outlined,
                          color: OwnerTheme.primaryDark),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('2 BHK Apartment', style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: OwnerTheme.primaryDark)),
                        Text('Anna Nagar, Chennai',
                            style: TextStyle(
                                color: OwnerTheme.textGrey, fontSize: 13)),
                      ],
                    ),
                  ],
                ),
                const Divider(height: 28, color: OwnerTheme.borderGrey),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _statBlock('Total Tenants', '2'),
                    _statBlock('Total Rent', '₹24,000'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Text('Rent Status', style: OwnerTheme.heading),
          const SizedBox(height: 10),
          Container(
            decoration: OwnerTheme.card,
            child: Column(
              children: rentRows.map((row) {
                final isPaid = row['status'] == 'Paid';
                final isLast = row == rentRows.last;
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(row['name']!,
                                style: const TextStyle(
                                    color: OwnerTheme.primaryDark,
                                    fontWeight: FontWeight.w500)),
                            Text(row['date']!, style: OwnerTheme.subText),
                          ],
                        ),
                      ),
                      Text(row['amount']!,
                          style: const TextStyle(
                              color: OwnerTheme.primaryDark,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(width: 10),
                      OwnerTheme.statusBadge(row['status']!,
                          color: isPaid
                              ? OwnerTheme.success
                              : OwnerTheme.warning),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: generate/download PDF report
              },
              style: OwnerTheme.primaryButton,
              icon: const Icon(Icons.download, color: Colors.white, size: 18),
              label: const Text('Download Report',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statBlock(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: OwnerTheme.subText),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: OwnerTheme.primaryDark)),
      ],
    );
  }
}