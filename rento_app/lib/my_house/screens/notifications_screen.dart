import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  final List<Map<String, String>> notifications = const [
    {
      'text': 'Your visit is scheduled for 15 May 2025, 04:00 PM',
      'time': '10:00 AM',
      'icon': 'visit',
    },
    {
      'text': 'Your application is approved',
      'time': '09:30 AM',
      'icon': 'application',
    },
    {
      'text': 'Rent payment reminder\nDue on 15 May 2025',
      'time': 'Yesterday',
      'icon': 'payment',
    },
    {
      'text': 'Maintenance request updated',
      'time': '14 May 2025',
      'icon': 'maintenance',
    },
  ];

  IconData _iconFor(String type) {
    switch (type) {
      case 'visit':
        return Icons.event_available;
      case 'application':
        return Icons.description_outlined;
      case 'payment':
        return Icons.currency_rupee;
      case 'maintenance':
        return Icons.build_outlined;
      default:
        return Icons.notifications_none;
    }
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
          'Notifications',
          style: TextStyle(
            color: Color(0xFF1A1A1A),
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final n = notifications[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE0E0E0)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(_iconFor(n['icon']!), size: 18, color: const Color(0xFF1A1A1A)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    n['text']!,
                    style: const TextStyle(fontSize: 13, height: 1.4),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  n['time']!,
                  style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}