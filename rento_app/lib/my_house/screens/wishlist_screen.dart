import 'package:flutter/material.dart';
import 'favorites_manager.dart';

/// Shows every property the user has liked (❤️), pulled straight from
/// [FavoritesManager]. Reached by tapping the heart icon on the Home
/// screen's app bar.
class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  static const Color primaryDark = Color(0xFF000000);
  static const Color bgLight = Color(0xFFF8F9FC);
  static const double cardRadius = 20;

  // Same master list used on the Home screen's "Popular Properties" +
  // "All Properties" — kept here so the Wishlist can show full details
  // (image/title/location/price) for whatever the user liked.
  static final List<Map<String, String>> _allKnownProperties = [
    {
      'bhk': '2 BHK',
      'title': '2 BHK Apartment',
      'location': 'Anna Nagar, Chennai',
      'price': '₹12,000 / month',
      'image': 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c',
    },
    {
      'bhk': '3 BHK',
      'title': '3 BHK Apartment',
      'location': 'Nungambakkam, Chennai',
      'price': '₹18,000 / month',
      'image': 'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c',
    },
    {
      'bhk': '1 BHK',
      'title': '1 BHK Apartment',
      'location': 'T. Nagar, Chennai',
      'price': '₹10,000 / month',
      'image': 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c',
    },
    {
      'bhk': 'Studio',
      'title': 'A-Frame Modern Cabin',
      'location': 'Anna Nagar, Chennai',
      'price': '₹9,200 / month',
      'image': 'assets/images/my_house/prop_extra_01.png',
    },
    {
      'bhk': '3 BHK',
      'title': '3 BHK Grand Villa',
      'location': 'Adyar, Chennai',
      'price': '₹32,000 / month',
      'image': 'assets/images/my_house/prop_extra_02.png',
    },
    {
      'bhk': '3 BHK',
      'title': '3 BHK Contemporary Home',
      'location': 'Nungambakkam, Chennai',
      'price': '₹29,500 / month',
      'image': 'assets/images/my_house/prop_extra_03.png',
    },
    {
      'bhk': '3 BHK',
      'title': '3 BHK Rooftop Garden Villa',
      'location': 'Anna Nagar, Chennai',
      'price': '₹35,000 / month',
      'image': 'assets/images/my_house/prop_extra_04.png',
    },
    {
      'bhk': '1 BHK',
      'title': '1 BHK Glassy Loft',
      'location': 'Velachery, Chennai',
      'price': '₹11,500 / month',
      'image': 'assets/images/my_house/prop_extra_05.png',
    },
    {
      'bhk': '3 BHK',
      'title': '3 BHK Luxury Mansion',
      'location': 'Velachery, Chennai',
      'price': '₹38,000 / month',
      'image': 'assets/images/my_house/prop_extra_06.png',
    },
    {
      'bhk': '2 BHK',
      'title': '2 BHK Beachside Bungalow',
      'location': 'Adyar, Chennai',
      'price': '₹19,000 / month',
      'image': 'assets/images/my_house/prop_extra_07.png',
    },
    {
      'bhk': '2 BHK',
      'title': '2 BHK Balcony Residence',
      'location': 'Anna Nagar, Chennai',
      'price': '₹18,200 / month',
      'image': 'assets/images/my_house/prop_extra_08.png',
    },
    {
      'bhk': '3 BHK',
      'title': '3 BHK Balcony View Home',
      'location': 'Porur, Chennai',
      'price': '₹27,800 / month',
      'image': 'assets/images/my_house/prop_extra_09.png',
    },
    {
      'bhk': '2 BHK',
      'title': '2 BHK Modern Duplex',
      'location': 'T Nagar, Chennai',
      'price': '₹20,500 / month',
      'image': 'assets/images/my_house/prop_extra_10.png',
    },
    {
      'bhk': '2 BHK',
      'title': '2 BHK Designer Home',
      'location': 'Nungambakkam, Chennai',
      'price': '₹21,000 / month',
      'image': 'assets/images/my_house/prop_extra_11.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    FavoritesManager.instance.load();
  }

  Widget _propertyImage(String path, {required double height}) {
    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        height: height,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          height: height,
          color: const Color(0xFFF0F0F0),
          child: const Icon(Icons.home, color: Colors.grey, size: 28),
        ),
      );
    }
    return Image.network(
      path,
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        height: height,
        color: const Color(0xFFF0F0F0),
        child: const Icon(Icons.home, color: Colors.grey, size: 28),
      ),
    );
  }

  Widget _wishlistCard(Map<String, String> data) {
    final key = data['title']! + data['image']!;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(cardRadius),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.10), blurRadius: 14, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(cardRadius)),
            child: SizedBox(
              width: 110,
              height: 90,
              child: _propertyImage(data['image']!, height: 90),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5)),
                  const SizedBox(height: 4),
                  Text(data['location']!, style: const TextStyle(fontSize: 11.5, color: Colors.grey)),
                  const SizedBox(height: 4),
                  Text(
                    data['price']!,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: primaryDark),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              await FavoritesManager.instance.toggle(key);
              setState(() {});
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 14),
              child: Icon(Icons.favorite, color: Colors.redAccent, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final liked = _allKnownProperties
        .where((p) => FavoritesManager.instance.isLiked(p['title']! + p['image']!))
        .toList();

    return Scaffold(
      backgroundColor: bgLight,
      appBar: AppBar(
        backgroundColor: bgLight,
        elevation: 0,
        iconTheme: const IconThemeData(color: primaryDark),
        title: const Text('My Wishlist', style: TextStyle(color: primaryDark, fontWeight: FontWeight.w800, fontSize: 20)),
      ),
      body: AnimatedBuilder(
        animation: FavoritesManager.instance,
        builder: (context, _) {
          final refreshedLiked = _allKnownProperties
              .where((p) => FavoritesManager.instance.isLiked(p['title']! + p['image']!))
              .toList();
          if (refreshedLiked.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.favorite_border, size: 48, color: Colors.grey[400]),
                    const SizedBox(height: 12),
                    const Text(
                      'No properties liked yet',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: primaryDark),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Tap the ♡ on any property to save it here.',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: refreshedLiked.length,
            itemBuilder: (context, index) => _wishlistCard(refreshedLiked[index]),
          );
        },
      ),
    );
  }
}