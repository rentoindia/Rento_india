import 'package:flutter/material.dart';

class VisitHistoryScreen extends StatelessWidget {
  const VisitHistoryScreen({super.key});

  static const Color primaryDark = Color(0xFF000000);
  static const Color bgLight = Color(0xFFF8F9FC);

  // Placeholder data — replace with real visit records from your
  // backend/storage once that's wired up.
  final List<Map<String, String>> _visits = const [
    {
      'property': '2 BHK Apartment, Anna Nagar',
      'date': '12 July 2026',
      'status': 'Completed',
    },
    {
      'property': '3 BHK Apartment, Nungambakkam',
      'date': '05 July 2026',
      'status': 'Completed',
    },
    {
      'property': '1 BHK Apartment, T. Nagar',
      'date': '28 June 2026',
      'status': 'Cancelled',
    },
  ];

  Color _statusColor(String status) {
    switch (status) {
      case 'Completed':
        return const Color(0xFF1FAE6B);
      case 'Cancelled':
        return const Color(0xFFE0483F);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgLight,
      appBar: AppBar(
        backgroundColor: bgLight,
        elevation: 0,
        foregroundColor: primaryDark,
        title: const Text(
          'Visit History',
          style: TextStyle(fontWeight: FontWeight.bold, color: primaryDark),
        ),
      ),
      body: _visits.isEmpty
          ? const Center(
              child: Text(
                'No past visits yet.',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _visits.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final visit = _visits[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDEEF3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.history_rounded, color: primaryDark),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              visit['property']!,
                              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              visit['date']!,
                              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: _statusColor(visit['status']!).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          visit['status']!,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: _statusColor(visit['status']!),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}