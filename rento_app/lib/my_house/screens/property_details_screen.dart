import 'package:flutter/material.dart';
import 'request_visit_screen.dart';

class PropertyDetailsScreen extends StatelessWidget {
  final Map<String, String> data;

  const PropertyDetailsScreen({super.key, required this.data});

  static const Color primaryDark = Color(0xFF1A1A2E);

  /// Renders an image whether it's a network URL or a local asset path
  Widget _propertyImage(String path) {
    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        height: 260,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 260,
          color: const Color(0xFFF0F0F0),
          child: const Icon(Icons.home, color: Colors.grey, size: 40),
        ),
      );
    }
    return Image.network(
      path,
      height: 260,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        height: 260,
        color: const Color(0xFFF0F0F0),
        child: const Icon(Icons.home, color: Colors.grey, size: 40),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  child: _propertyImage(data['image']!),
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back, size: 20, color: primaryDark),
                    ),
                  ),
                ),
                // "1/10" image counter badge removed as requested.
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['title']!,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        data['location'] ??
                            '${data['locality'] ?? ''}, ${data['city'] ?? ''}',
                        style: const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.verified, size: 14, color: Colors.green),
                            SizedBox(width: 4),
                            Text(
                              'Verified Property',
                              style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        data['price']!,
                        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Deposit', style: TextStyle(color: Colors.grey, fontSize: 13)),
                            SizedBox(height: 4),
                            Text('₹36,000', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Maintenance', style: TextStyle(color: Colors.grey, fontSize: 13)),
                            SizedBox(height: 4),
                            Text('₹1,000', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      _featureItem(Icons.bed, data['bhk']!),
                      const SizedBox(width: 20),
                      _featureItem(Icons.bathtub_outlined, '2 Bathroom'),
                      const SizedBox(width: 20),
                      _featureItem(Icons.balcony, '1 Balcony'),
                    ],
                  ),
                  const SizedBox(height: 14),

                  Row(
                    children: [
                      _featureItem(Icons.apartment, '3rd Floor'),
                      const SizedBox(width: 20),
                      _featureItem(Icons.elevator, 'Lift Available'),
                      const SizedBox(width: 20),
                      _featureItem(Icons.local_parking, 'Parking'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 12),

                  const Text(
                    'Owner Contact',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Visible after visit request is accepted',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  const SizedBox(height: 90),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RequestVisitScreen(data: data)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Request Visit',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _featureItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 18, color: primaryDark),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}