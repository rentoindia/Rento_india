import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/primary_button.dart';
import '../core/api_client.dart';
import '../services/orders_service.dart';
import 'rental_order.dart';
import 'payment_screen.dart';

class VendorApprovalScreen extends StatefulWidget {
  final RentalOrder order;
  const VendorApprovalScreen({super.key, required this.order});

  @override
  State<VendorApprovalScreen> createState() => _VendorApprovalScreenState();
}

class _VendorApprovalScreenState extends State<VendorApprovalScreen> {
  bool _responding = false;

  @override
  void initState() {
    super.initState();
    // wait for the vendor: the server tells us live when the request is accepted / declined
    OrdersService.instance.addListener(_onOrdersChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) => _onOrdersChanged());
  }

  @override
  void dispose() {
    OrdersService.instance.removeListener(_onOrdersChanged);
    super.dispose();
  }

  RentalOrder get _latest =>
      OrdersService.instance.findById(widget.order.id) ?? widget.order;

  void _onOrdersChanged() {
    if (!mounted || _responding) return;
    final s = _latest.status;
    if (s == OrderStatus.cancelled) {
      _reject(declinedByVendor: true);
    } else if (s != OrderStatus.placed) {
      _accept();
    }
  }

  void _accept() {
    if (_responding) return;
    _responding = true;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => PaymentScreen(order: _latest)),
    );
  }

  Future<void> _reject({bool declinedByVendor = false}) async {
    if (_responding) return;
    _responding = true;
    if (!declinedByVendor) {
      try {
        await OrdersService.instance.cancelOrder(
          _latest,
          reason: 'Cancelled by customer',
        );
      } on ApiException catch (e) {
        _responding = false;
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
        return;
      }
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          declinedByVendor
              ? 'Request declined by vendor. Please try another product.'
              : 'Request cancelled.',
        ),
      ),
    );
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      appBar: AppBar(
        backgroundColor: AppColors.pureWhite,
        elevation: 0,
        foregroundColor: AppColors.primaryBlack,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Vendor Approval',
          style: AppText.titleLg.copyWith(fontSize: 16),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Row(
                children: [
                  const Icon(
                    Icons.verified_user_outlined,
                    size: 15,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Vendor Approval',
                    style: AppText.caption.copyWith(fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      color: AppTheme.lightGrey,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.storefront_outlined,
                      size: 34,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'New Rental Request',
                    style: AppText.displaySm.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'You have received a new rental request.\nPlease review the details and Accept or Reject the request.',
                    textAlign: TextAlign.center,
                    style: AppText.bodySm.copyWith(fontSize: 12.5, height: 1.4),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.lightGrey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.access_time, size: 14),
                        const SizedBox(width: 6),
                        Text(
                          'Response Time: 5–15 mins',
                          style: AppText.labelMd.copyWith(fontSize: 11.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Order Details',
              style: AppText.titleLg.copyWith(fontSize: 14.5),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.border),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  Row(
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
                                    width: 52,
                                    height: 52,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      width: 52,
                                      height: 52,
                                      color: AppTheme.lightGrey,
                                      child: const Icon(Icons.image_outlined),
                                    ),
                                  )
                                : Image.network(
                                    imgPath,
                                    width: 52,
                                    height: 52,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      width: 52,
                                      height: 52,
                                      color: AppTheme.lightGrey,
                                      child: const Icon(Icons.image_outlined),
                                    ),
                                  );
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.name,
                              style: AppText.titleSm.copyWith(fontSize: 13.5),
                            ),
                            Text(
                              order.categoryLabel,
                              style: AppText.caption.copyWith(fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '₹${order.ratePerDay.toStringAsFixed(0)} / day',
                        style: AppText.priceMd.copyWith(fontSize: 12.5),
                      ),
                    ],
                  ),
                  const Divider(height: 22),
                  _detailRow(
                    'Start Date',
                    RentalOrder.formatDate(order.startDate),
                  ),
                  _detailRow('End Date', RentalOrder.formatDate(order.endDate)),
                  _detailRow('Total Duration', '${order.days} Days'),
                  const Divider(height: 22),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Delivery Address',
                              style: AppText.caption.copyWith(
                                fontSize: 11.5,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Text(
                              order.deliveryAddress.isEmpty
                                  ? 'Not specified'
                                  : order.deliveryAddress,
                              style: AppText.titleSm.copyWith(fontSize: 12.5),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Opening full address details...'),
                          ),
                        ),
                        child: Text(
                          'View Address',
                          style: AppText.labelMd.copyWith(
                            fontSize: 11.5,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Text(
              'What happens next?',
              style: AppText.titleLg.copyWith(fontSize: 14.5),
            ),
            const SizedBox(height: 10),
            _nextStepRow(
              Icons.check_circle_outline,
              'If You Accept',
              'The customer will be notified instantly and the order will move to the next step.',
            ),
            _nextStepRow(
              Icons.cancel_outlined,
              'If You Reject',
              'The customer will be notified instantly. They can search for another vendor.',
            ),
            _nextStepRow(
              Icons.notifications_active_outlined,
              'Instant Notification',
              'You and the customer will receive an instant notification once a decision is made.',
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryButton(
                label: 'ACCEPT REQUEST',
                icon: Icons.check,
                onPressed: _accept,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => _reject(),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(color: AppTheme.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'REJECT REQUEST',
                    style: AppText.buttonSm.copyWith(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your response is secure and private.',
                style: AppText.caption.copyWith(fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppText.bodySm.copyWith(fontSize: 12.5)),
          Text(value, style: AppText.titleSm.copyWith(fontSize: 12.5)),
        ],
      ),
    );
  }

  Widget _nextStepRow(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.lightGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 16, color: AppColors.textPrimary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppText.titleSm),
                Text(
                  subtitle,
                  style: AppText.bodySm.copyWith(fontSize: 11.5, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
