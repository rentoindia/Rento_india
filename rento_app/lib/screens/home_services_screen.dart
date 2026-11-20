import 'package:flutter/material.dart';

class HomeServicesScreen extends StatelessWidget {
  const HomeServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      {'title': 'Cleaning Service', 'rating': '4.8', 'icon': Icons.cleaning_services_outlined},
      {'title': 'AC Repair', 'rating': '4.7', 'icon': Icons.ac_unit_outlined},
      {'title': 'Home Painting', 'rating': '4.6', 'icon': Icons.format_paint_outlined},
      {'title': 'Pest Control', 'rating': '4.7', 'icon': Icons.pest_control_outlined},
      {'title': 'Plumbing', 'rating': '4.5', 'icon': Icons.plumbing_outlined},
      {'title': 'Electrician', 'rating': '4.6', 'icon': Icons.electrical_services_outlined},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Book Services')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: services.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.1,
        ),
        itemBuilder: (context, i) {
          final s = services[i];
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFF0F0F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(s['icon'] as IconData, size: 28),
                const Spacer(),
                Text(s['title'] as String,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(s['rating'] as String, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}