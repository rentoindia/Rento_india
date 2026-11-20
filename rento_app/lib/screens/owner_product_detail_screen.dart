import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../services/lender_service.dart';
import 'add_product_screen.dart';

class OwnerProductDetailScreen extends StatefulWidget {
  final LenderProduct product;
  const OwnerProductDetailScreen({super.key, required this.product});

  @override
  State<OwnerProductDetailScreen> createState() =>
      _OwnerProductDetailScreenState();
}

class _OwnerProductDetailScreenState extends State<OwnerProductDetailScreen> {
  int _selectedIndex = 0; // index into the combined photos+video strip

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: LenderService.instance,
      builder: (context, _) {
        final product = LenderService.instance.products.firstWhere(
          (p) => p.id == widget.product.id,
          orElse: () => widget.product,
        );
        final photos = product.imagePaths.whereType<String>().toList();
        final hasVideo = product.videoPath != null;

        final renters = LenderService.instance.requests
            .where(
              (r) => r.productId == product.id || r.productName == product.name,
            )
            .toList();

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            foregroundColor: Colors.black,
            title: const Text(
              'Product Details',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17,
                color: Colors.black,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddProductScreen(existingProduct: product),
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            top: false,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              children: [
                _buildGallery(photos, hasVideo),
                const SizedBox(height: 16),
                _buildTitleBlock(product),
                const SizedBox(height: 14),
                _buildDepositBanner(product),
                const SizedBox(height: 22),
                const Text(
                  'Specifications',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(height: 10),
                _buildSpecsGrid(product),
                const SizedBox(height: 22),
                const Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  product.description,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    height: 1.4,
                    fontSize: 13.5,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Rented By',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${renters.length}',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildRentersList(renters),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGallery(List<String> photos, bool hasVideo) {
    final slotCount = photos.length + (hasVideo ? 1 : 0);
    if (slotCount == 0) {
      return Container(
        height: 220,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: Icon(
            Icons.inventory_2_outlined,
            size: 48,
            color: Colors.black26,
          ),
        ),
      );
    }

    final selected = _selectedIndex.clamp(0, slotCount - 1);
    final isVideoSelected = selected >= photos.length;

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: isVideoSelected
              ? _videoPlaceholder(height: 220)
              : _imageFor(
                  photos[selected],
                  height: 220,
                  width: double.infinity,
                ),
        ),
        if (slotCount > 1) ...[
          const SizedBox(height: 10),
          SizedBox(
            height: 64,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: slotCount,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final isSelected = i == selected;
                final isVideoThumb = i >= photos.length;
                return GestureDetector(
                  onTap: () => setState(() => _selectedIndex = i),
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected
                            ? Colors.black
                            : const Color(0xFFEDEDED),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: isVideoThumb
                          ? _videoPlaceholder(
                              height: 64,
                              width: 64,
                              iconSize: 20,
                            )
                          : _imageFor(photos[i], width: 64, height: 64),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }

  Widget _videoPlaceholder({
    required double height,
    double? width,
    double iconSize = 40,
  }) {
    return Container(
      height: height,
      width: width ?? double.infinity,
      color: const Color(0xFFF3F4F6),
      child: Center(
        child: Icon(
          Icons.play_circle_fill,
          size: iconSize,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _imageFor(
    String path, {
    required double width,
    required double height,
  }) {
    if (kIsWeb || path.startsWith('http')) {
      return Image.network(
        path,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: width,
          height: height,
          color: const Color(0xFFF3F4F6),
          child: const Icon(Icons.image_outlined, color: Colors.grey),
        ),
      );
    }
    return Image.file(
      File(path),
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        width: width,
        height: height,
        color: const Color(0xFFF3F4F6),
        child: const Icon(Icons.image_outlined, color: Colors.grey),
      ),
    );
  }

  Widget _buildTitleBlock(LenderProduct product) {
    final mrpValue =
        double.tryParse(product.mrp.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
    final dayValue =
        double.tryParse(
          product.pricePerDay.replaceAll(RegExp(r'[^0-9.]'), ''),
        ) ??
        0;
    final hasMrp = product.mrp.trim().isNotEmpty && mrpValue > dayValue;
    final discountPercent = hasMrp
        ? (((mrpValue - dayValue) / mrpValue) * 100).round()
        : 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                product.category.toUpperCase(),
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
            ),
            if (product.isPaused) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEECEC),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'PAUSED',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 10),
        Text(
          product.name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '₹${product.pricePerDay}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 4),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                '/ day',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
            ),
            if (hasMrp) ...[
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  '₹${product.mrp}',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 15,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.grey.shade500,
                  ),
                ),
              ),
            ],
          ],
        ),
        if (hasMrp) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFEAFBF0),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '$discountPercent% cheaper than buying new (MRP ₹${product.mrp})',
              style: const TextStyle(
                color: Color(0xFF15803D),
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDepositBanner(LenderProduct product) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFEAFBF0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.verified_user_outlined,
            color: Color(0xFF22C55E),
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Security Deposit ₹${product.securityDeposit} (Refundable)',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF15803D),
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecsGrid(LenderProduct product) {
    if (product.specs.isEmpty) {
      return Text(
        'No specifications added yet.',
        style: TextStyle(color: Colors.grey.shade500, fontSize: 12.5),
      );
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: product.specs.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2.6,
      ),
      itemBuilder: (context, i) {
        final spec = product.specs[i];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFEDEDED)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      spec.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      spec.value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRentersList(List<RentalRequest> renters) {
    if (renters.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 26),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F8FA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.people_outline, size: 32, color: Colors.grey.shade300),
              const SizedBox(height: 8),
              Text(
                'No one has rented this yet',
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12.5),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: renters.map((r) {
        final statusColor = switch (r.status) {
          RentalRequestStatus.pending => Colors.orange,
          RentalRequestStatus.accepted => Colors.green,
          RentalRequestStatus.rejected => Colors.redAccent,
        };
        final statusLabel = switch (r.status) {
          RentalRequestStatus.pending => 'Pending',
          RentalRequestStatus.accepted => 'Accepted',
          RentalRequestStatus.rejected => 'Rejected',
        };
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFF0F0F0)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFFF3F4F6),
                child: Text(
                  r.customerName.isNotEmpty
                      ? r.customerName[0].toUpperCase()
                      : '?',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      r.customerName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      '${r.duration} · ₹${r.amount.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
