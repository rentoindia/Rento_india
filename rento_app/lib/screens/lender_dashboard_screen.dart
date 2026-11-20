import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'dart:io';

import '../services/lender_service.dart';
import 'add_product_screen.dart';
import 'owner_product_detail_screen.dart';
import 'rental_requests_screen.dart';
import 'earnings_screen.dart';

class LenderDashboardScreen extends StatelessWidget {
  const LenderDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: LenderService.instance,
      builder: (context, _) => _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final products = LenderService.instance.products;
    final pendingCount = LenderService.instance.pendingRequestCount;
    final earnings = LenderService.instance.totalEarnings;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
      children: [
        Row(
          children: [
            Expanded(
              child: _statCard(
                icon: Icons.inventory_2_outlined,
                label: 'Products',
                value: '${products.length}',
                onTap: null,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _statCard(
                icon: Icons.receipt_long_outlined,
                label: 'Requests',
                value: pendingCount > 0 ? '$pendingCount new' : 'View all',
                highlight: pendingCount > 0,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RentalRequestsScreen(),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _statCard(
                icon: Icons.account_balance_wallet_outlined,
                label: 'Earnings',
                value: '₹${earnings.toStringAsFixed(0)}',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EarningsScreen()),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        Text(
          'Your Listed Products (${products.length})',
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
        const SizedBox(height: 12),

        if (products.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 40,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'No products listed yet',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tap "Add Product" below to list your first item',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 11),
                  ),
                ],
              ),
            ),
          )
        else
          ...products.map((p) => _productRow(context, p)),
      ],
    );
  }

  Widget _productRow(BuildContext context, LenderProduct p) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => OwnerProductDetailScreen(product: p)),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFF0F0F0)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: p.firstImage != null
                  ? _productImage(p.firstImage!)
                  : Container(
                      width: 50,
                      height: 50,
                      color: const Color(0xFFF3F4F6),
                      child: const Icon(Icons.inventory_2_outlined),
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          p.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      if (p.isPaused) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'Paused',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  Text(
                    '${p.category} · ₹${p.pricePerDay}/day · Deposit ₹${p.securityDeposit}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                  ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              icon: const Icon(
                Icons.more_vert,
                size: 20,
                color: Colors.black54,
              ),
              onSelected: (value) {
                switch (value) {
                  case 'edit':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddProductScreen(existingProduct: p),
                      ),
                    );
                    break;
                  case 'pause':
                    LenderService.instance.togglePause(p.id);
                    break;
                  case 'delete':
                    LenderService.instance.removeProduct(p.id);
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'edit', child: Text('Edit')),
                PopupMenuItem(
                  value: 'pause',
                  child: Text(p.isPaused ? 'Resume Listing' : 'Pause Listing'),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _productImage(String path) {
    if (kIsWeb || path.startsWith('http')) {
      return Image.network(
        path,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: 50,
          height: 50,
          color: const Color(0xFFF3F4F6),
          child: const Icon(Icons.image_outlined, color: Colors.grey),
        ),
      );
    }
    return Image.file(
      File(path),
      width: 50,
      height: 50,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        width: 50,
        height: 50,
        color: const Color(0xFFF3F4F6),
        child: const Icon(Icons.image_outlined, color: Colors.grey),
      ),
    );
  }

  Widget _statCard({
    required IconData icon,
    required String label,
    required String value,
    bool highlight = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: highlight ? Colors.black : const Color(0xFFF0F0F0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 18, color: Colors.black87),
            const SizedBox(height: 8),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 13.5,
              ),
            ),
            Text(
              label,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 10.5),
            ),
          ],
        ),
      ),
    );
  }
}
