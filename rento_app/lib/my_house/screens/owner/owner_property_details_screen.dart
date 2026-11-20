import 'package:flutter/material.dart';
import 'owner_theme.dart';
import 'owner_register_property_screen.dart';

/// RENTO INDIA — Owner Flow Screen 7: Property Details (Owner View)
///
/// Now takes a `data` map (passed from OwnerPropertyListScreen) so it
/// shows the correct photo/title/location/rent/etc for whichever
/// property the owner tapped, instead of always showing the same
/// hardcoded "2 BHK Apartment, Anna Nagar" placeholder.
class OwnerPropertyDetailsScreen extends StatelessWidget {
  final Map<String, String> data;

  const OwnerPropertyDetailsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final bool occupied = (data['status'] ?? 'Occupied') == 'Occupied';
    final String tenant = data['tenant'] ?? '';
    final String moveIn = data['moveIn'] ?? '';

    return Scaffold(
      backgroundColor: OwnerTheme.bgGrey,
      appBar: OwnerTheme.appBar(context, 'Property Details'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              data['image'] ?? '',
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 180,
                width: double.infinity,
                color: OwnerTheme.borderGrey,
                child: const Icon(Icons.image, size: 40, color: Colors.white70),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(data['title'] ?? '', style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: OwnerTheme.primaryDark)),
              OwnerTheme.statusBadge(
                data['status'] ?? 'Occupied',
                color: occupied ? OwnerTheme.success : OwnerTheme.warning,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(data['location'] ?? '',
              style: const TextStyle(color: OwnerTheme.textGrey, fontSize: 14)),
          Text(data['rent'] ?? '', style: const TextStyle(
              color: OwnerTheme.primaryDark,
              fontWeight: FontWeight.w600,
              fontSize: 15)),
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: OwnerTheme.card,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _DetailChip(icon: Icons.bed, label: data['bhk'] ?? ''),
                _DetailChip(icon: Icons.bathtub_outlined, label: data['bathroom'] ?? ''),
                _DetailChip(icon: Icons.layers_outlined, label: data['floor'] ?? ''),
                const _DetailChip(icon: Icons.local_parking_outlined, label: 'Parking'),
              ],
            ),
          ),
          const SizedBox(height: 20),

          if (occupied && tenant.isNotEmpty) ...[
            Text('Current Tenant', style: OwnerTheme.heading),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: OwnerTheme.card,
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundColor: OwnerTheme.borderGrey,
                    child: Icon(Icons.person, color: OwnerTheme.primaryDark),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tenant, style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: OwnerTheme.primaryDark)),
                        Text(moveIn, style: OwnerTheme.subText),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
          ] else ...[
            Container(
              padding: const EdgeInsets.all(14),
              decoration: OwnerTheme.card,
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: OwnerTheme.textGrey, size: 20),
                  const SizedBox(width: 10),
                  Text('No tenant yet — property is vacant', style: OwnerTheme.subText),
                ],
              ),
            ),
            const SizedBox(height: 28),
          ],

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OwnerRegisterPropertyScreen(),
                  ),
                );
              },
              style: OwnerTheme.primaryButton,
              icon: const Icon(Icons.edit_outlined, color: Colors.white, size: 18),
              label: const Text('Edit Property',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _DetailChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: OwnerTheme.primaryDark, size: 20),
        const SizedBox(height: 6),
        Text(label, style: OwnerTheme.subText),
      ],
    );
  }
}