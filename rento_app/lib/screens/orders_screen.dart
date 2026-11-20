import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../services/orders_service.dart';
import 'rental_order.dart';
import 'vendor_approval_screen.dart';
import 'payment_screen.dart';
import 'return_otp_screen.dart';
import 'delivery_otp_screen.dart';
import 'rental_active_screen.dart';
import 'complete_return_screen.dart';
import 'inspection_refund_screen.dart';
import 'refund_received_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F8FA),
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text(
          'My Orders',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.black,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: AnimatedBuilder(
        animation: OrdersService.instance,
        builder: (context, _) {
          final active = OrdersService.instance.activeOrders;
          final past = OrdersService.instance.pastOrders;
          return TabBarView(
            controller: _tabController,
            children: [
              _buildList(
                active,
                emptyText:
                    'No active rentals yet.\nBrowse products to get started.',
              ),
              _buildList(past, emptyText: 'No completed rentals yet.'),
            ],
          );
        },
      ),
    );
  }

  Widget _buildList(List<RentalOrder> orders, {required String emptyText}) {
    if (orders.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  color: AppTheme.lightGrey,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.receipt_long_outlined,
                  size: 36,
                  color: Colors.black38,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                emptyText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) => _OrderCard(
        order: orders[i],
        onTap: () => _resumeOrder(context, orders[i]),
      ),
    );
  }

  void _resumeOrder(BuildContext context, RentalOrder order) {
    Widget destination;
    switch (order.status) {
      case OrderStatus.placed:
      case OrderStatus.vendorAccepted:
        destination = order.status == OrderStatus.placed
            ? VendorApprovalScreen(order: order)
            : PaymentScreen(order: order);
        break;
      case OrderStatus.paymentConfirmed:
      case OrderStatus.riderAssigned:
      case OrderStatus.outForDelivery:
        destination = DeliveryOtpScreen(order: order);
        break;
      case OrderStatus.delivered:
      case OrderStatus.rentalActive:
        destination = RentalActiveScreen(order: order);
        break;
      case OrderStatus.returnScheduled:
        destination = ReturnOtpScreen(
          order: order,
          pickupDate: order.returnPickupDate ?? DateTime.now(),
          pickupSlot: order.returnPickupSlot ?? '10:00 AM - 12:00 PM',
        );
        break;
      case OrderStatus.returnCollected:
        destination = InspectionRefundScreen(order: order);
        break;
      case OrderStatus.completed:
        destination = RefundReceivedScreen(
          order: order,
          refundAmount: order.securityDepositValue,
        );
        break;
      case OrderStatus.cancelled:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(order.cancelReason ?? 'This order was cancelled'),
          ),
        );
        return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => destination));
  }
}

class _OrderCard extends StatelessWidget {
  final RentalOrder order;
  final VoidCallback onTap;
  const _OrderCard({required this.order, required this.onTap});

  String? _timingLine(RentalOrder order) {
    switch (order.status) {
      case OrderStatus.paymentConfirmed:
      case OrderStatus.riderAssigned:
      case OrderStatus.outForDelivery:
        return order.deliverySlot != null
            ? 'Delivery slot: ${order.deliverySlot}'
            : null;
      case OrderStatus.delivered:
      case OrderStatus.rentalActive:
        return order.actualDeliveredTime != null
            ? 'Delivered at ${RentalOrder.formatTime(order.actualDeliveredTime!)}'
            : null;
      default:
        return null;
    }
  }

  Color get _statusColor {
    switch (order.status) {
      case OrderStatus.placed:
      case OrderStatus.vendorAccepted:
        return const Color(0xFFF59E0B);
      case OrderStatus.paymentConfirmed:
      case OrderStatus.riderAssigned:
      case OrderStatus.outForDelivery:
        return const Color(0xFF2563EB);
      case OrderStatus.delivered:
      case OrderStatus.rentalActive:
        return const Color(0xFF16A34A);
      case OrderStatus.returnScheduled:
      case OrderStatus.returnCollected:
        return const Color(0xFF6D5EF8);
      case OrderStatus.completed:
        return const Color(0xFF6B7280);
      case OrderStatus.cancelled:
        return const Color(0xFFDC2626);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppTheme.border),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Builder(
                builder: (_) {
                  final imgPath =
                      order.imageUrl ??
                      'https://loremflickr.com/100/100/${order.imageQuery.replaceAll(' ', ',')}?lock=${order.name.hashCode.abs() % 5000}';
                  final isAsset = !imgPath.startsWith('http');
                  return isAsset
                      ? Image.asset(
                          imgPath,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 56,
                            height: 56,
                            color: AppTheme.lightGrey,
                            child: const Icon(Icons.image_outlined),
                          ),
                        )
                      : Image.network(
                          imgPath,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 56,
                            height: 56,
                            color: AppTheme.lightGrey,
                            child: const Icon(Icons.image_outlined),
                          ),
                        );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          order.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13.5,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: Colors.black38,
                        size: 18,
                      ),
                    ],
                  ),
                  Text(
                    order.categoryLabel,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${RentalOrder.formatDate(order.startDate)} — ${RentalOrder.formatDate(order.endDate)} · ${order.days} days',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                  if (_timingLine(order) != null) ...[
                    const SizedBox(height: 3),
                    Text(
                      _timingLine(order)!,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _statusColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      order.status.label,
                      style: TextStyle(
                        color: _statusColor,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
