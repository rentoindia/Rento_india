import 'package:flutter/material.dart';
import 'property_details_screen.dart';
import 'favorites_manager.dart';

/// Shows EVERY photo/listing that appears in the Home page's
/// "Popular Properties" row — reached via the "View All" link.
class AllPropertiesScreen extends StatelessWidget {
  final List<Map<String, String>> properties;

  const AllPropertiesScreen({super.key, required this.properties});

  static const Color primaryDark = Color(0xFF000000);
  static const Color bgLight = Color(0xFFF8F9FC);
  static const double cardRadius = 20;

  /// Renders an image whether it's a network URL or a local asset path
  /// (local asset paths start with "assets/").
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

  Widget _card(BuildContext context, Map<String, String> data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PropertyDetailsScreen(data: data)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(cardRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.10),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(cardRadius)),
                  child: _propertyImage(data['image']!, height: 120),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: primaryDark,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      data['bhk']!,
                      style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: _LikeButton(propertyKey: data['title']! + data['image']!),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['title']!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, height: 1.2),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 12, color: Colors.grey),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          data['location']!,
                          style: const TextStyle(fontSize: 11, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    data['price']!,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: primaryDark),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FavoritesManager.instance.load(); // no-op if already loaded
    return Scaffold(
      backgroundColor: bgLight,
      appBar: AppBar(
        backgroundColor: bgLight,
        elevation: 0,
        iconTheme: const IconThemeData(color: primaryDark),
        title: const Text(
          'All Properties',
          style: TextStyle(color: primaryDark, fontWeight: FontWeight.w800, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: properties.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 0.68,
          ),
          itemBuilder: (context, index) => _card(context, properties[index]),
        ),
      ),
    );
  }
}

/// A small heart/like toggle backed by the shared, persisted
/// [FavoritesManager] — same liked state as everywhere else in the app.
class _LikeButton extends StatelessWidget {
  final String propertyKey;
  const _LikeButton({required this.propertyKey});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: FavoritesManager.instance,
      builder: (context, _) {
        final liked = FavoritesManager.instance.isLiked(propertyKey);
        return GestureDetector(
          onTap: () async {
            await FavoritesManager.instance.toggle(propertyKey);
            if (context.mounted) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 1, milliseconds: 200),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.black87,
                  content: Text(
                    liked ? 'Removed from Wishlist' : 'Added to Wishlist ❤️',
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Icon(
              liked ? Icons.favorite : Icons.favorite_border,
              size: 16,
              color: liked ? Colors.redAccent : Colors.black,
            ),
          ),
        );
      },
    );
  }
}