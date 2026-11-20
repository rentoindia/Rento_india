import 'package:flutter/material.dart';
import 'owner_theme.dart';

/// RENTO INDIA — Owner Flow Screen 9: Owner Notifications
class OwnerNotificationsScreen extends StatelessWidget {
  const OwnerNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'icon': Icons.calendar_today_outlined,
        'title': 'New visit request received',
        'time': '15 May 2025, 09:30 AM',
      },
      {
        'icon': Icons.assignment_turned_in_outlined,
        'title': 'Tenant application submitted',
        'time': '15 May 2025, 09:10 AM',
      },
      {
        'icon': Icons.payments_outlined,
        'title': 'Rent payment received',
        'time': '15 May 2025, 06:00 PM',
      },
      {
        'icon': Icons.build_outlined,
        'title': 'Maintenance request assigned',
        'time': '14 May 2025, 11:00 AM',
      },
    ];

    return Scaffold(
      backgroundColor: OwnerTheme.bgGrey,
      appBar: OwnerTheme.appBar(context, 'Notifications'),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final n = notifications[index];
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: OwnerTheme.card,
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: OwnerTheme.borderGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(n['icon'] as IconData,
                      color: OwnerTheme.primaryDark, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(n['title'] as String, style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: OwnerTheme.primaryDark,
                          fontSize: 14)),
                      const SizedBox(height: 3),
                      Text(n['time'] as String, style: OwnerTheme.subText),
                    ],
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