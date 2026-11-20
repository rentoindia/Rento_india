
import 'package:flutter/material.dart';
import 'owner_theme.dart';
import 'owner_approve_tenant_screen.dart';

/// RENTO INDIA — Owner Flow Screen 8: Tenant / My Tenants
class OwnerMyTenantsScreen extends StatelessWidget {
  const OwnerMyTenantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tenants = [
      {
        'name': 'Karthik Raj',
        'property': '2 BHK Apartment, Anna Nagar, Chennai',
        'rent': '₹12,000 / month',
        'moveIn': 'Move-in: 15 May 2025',
      },
      {
        'name': 'Vignesh Kumar',
        'property': '1 BHK Apartment, Nungambakkam, Chennai',
        'rent': '₹9,000 / month',
        'moveIn': 'Move-in: 10 May 2025',
      },
    ];

    return Scaffold(
      backgroundColor: OwnerTheme.bgGrey,
      appBar: OwnerTheme.appBar(context, 'My Tenants'),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: tenants.length,
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          final t = tenants[index];
          return InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OwnerApproveTenantScreen(),
                ),
              );
            },
            child: Container(
            padding: const EdgeInsets.all(16),
            decoration: OwnerTheme.card,
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: OwnerTheme.borderGrey,
                  child: Icon(Icons.person, color: OwnerTheme.primaryDark),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t['name']!, style: OwnerTheme.heading),
                      const SizedBox(height: 3),
                      Text(t['property']!, style: OwnerTheme.subText),
                      const SizedBox(height: 3),
                      Text(t['rent']!, style: const TextStyle(
                          color: OwnerTheme.primaryDark,
                          fontWeight: FontWeight.w600,
                          fontSize: 13)),
                      const SizedBox(height: 2),
                      Text(t['moveIn']!, style: OwnerTheme.subText),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: OwnerTheme.textGrey),
              ],
            ),
            ),
          );
        },
      ),
    );
  }
}



