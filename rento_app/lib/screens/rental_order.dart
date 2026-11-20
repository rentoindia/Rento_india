import '../core/api_config.dart';
import '../core/json_utils.dart';

enum OrderStatus {
  placed,
  vendorAccepted,
  paymentConfirmed,
  riderAssigned,
  outForDelivery,
  delivered,
  rentalActive,
  returnScheduled,
  returnCollected,
  completed,
  cancelled;

  String get label {
    switch (this) {
      case OrderStatus.placed:
        return 'Order Placed';
      case OrderStatus.vendorAccepted:
        return 'Vendor Accepted';
      case OrderStatus.paymentConfirmed:
        return 'Payment Confirmed';
      case OrderStatus.riderAssigned:
        return 'Rider Assigned';
      case OrderStatus.outForDelivery:
        return 'Out for Delivery';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.rentalActive:
        return 'Rental Active';
      case OrderStatus.returnScheduled:
        return 'Return Scheduled';
      case OrderStatus.returnCollected:
        return 'Return Collected';
      case OrderStatus.completed:
        return 'Completed';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  bool get isActive =>
      this != OrderStatus.completed && this != OrderStatus.cancelled;

  /// Converts the backend status (PAYMENT_CONFIRMED) to the app status.
  static OrderStatus fromApi(String? s) {
    switch ((s ?? '').toUpperCase()) {
      case 'VENDOR_ACCEPTED':
        return OrderStatus.vendorAccepted;
      case 'PAYMENT_CONFIRMED':
        return OrderStatus.paymentConfirmed;
      case 'RIDER_ASSIGNED':
        return OrderStatus.riderAssigned;
      case 'OUT_FOR_DELIVERY':
        return OrderStatus.outForDelivery;
      case 'DELIVERED':
        return OrderStatus.delivered;
      case 'RENTAL_ACTIVE':
        return OrderStatus.rentalActive;
      case 'RETURN_SCHEDULED':
        return OrderStatus.returnScheduled;
      case 'RETURN_COLLECTED':
        return OrderStatus.returnCollected;
      case 'COMPLETED':
        return OrderStatus.completed;
      case 'CANCELLED':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.placed;
    }
  }
}

class RentalOrder {
  final String id;
  final String name;
  final String categoryLabel;
  final String imageQuery;
  final String? imageUrl;
  final double rating;
  final int reviewCount;
  final String securityDeposit;

  final double ratePerDay;
  final DateTime startDate;
  final DateTime endDate;

  final double deliveryFee;
  final double platformFee;
  final double pickupFee;

  final String deliveryAddress;
  final OrderStatus status;

  final DateTime? deliveryDate;
  final String? deliverySlot;

  final DateTime? actualDeliveredTime;

  final DateTime? returnPickupDate;
  final String? returnPickupSlot;

  final bool purchaseRequested;
  final bool isAvailableForPurchase;
  final double? purchasePrice;

  // ---- filled by the server (all optional so older call sites keep working)
  final String? orderNo;
  final String?
  deliveryOtp; // the customer tells this code to the rider on delivery / return
  final String? vendorName;
  final String paymentStatus;
  final double paidAmount;
  final double discount;
  final String? couponCode;
  final String? cancelReason;

  RentalOrder({
    String? id,
    required this.name,
    this.categoryLabel = 'DSLR CAMERA',
    this.imageQuery = 'dslr camera',
    this.imageUrl,
    this.rating = 4.5,
    this.reviewCount = 120,
    this.securityDeposit = '₹5,000',
    this.ratePerDay = 499,
    required this.startDate,
    required this.endDate,
    this.deliveryFee = 120,
    this.platformFee = 40,
    this.pickupFee = 100,
    this.deliveryAddress = '',
    this.status = OrderStatus.placed,
    this.deliveryDate,
    this.deliverySlot,
    this.actualDeliveredTime,
    this.returnPickupDate,
    this.returnPickupSlot,
    this.purchaseRequested = false,
    this.isAvailableForPurchase = false,
    this.purchasePrice,
    this.orderNo,
    this.deliveryOtp,
    this.vendorName,
    this.paymentStatus = 'PENDING',
    this.paidAmount = 0,
    this.discount = 0,
    this.couponCode,
    this.cancelReason,
  }) : id = id ?? '${DateTime.now().microsecondsSinceEpoch}';

  int get days {
    final d = endDate.difference(startDate).inDays;
    return d <= 0 ? 1 : d;
  }

  double get rentalAmount => ratePerDay * days;
  double get checkoutTotal =>
      rentalAmount + deliveryFee + platformFee + pickupFee;
  bool get isPaid => paymentStatus == 'PAID';
  double get securityDepositValue =>
      double.tryParse(securityDeposit.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;

  String get priceLabel => '₹${ratePerDay.toStringAsFixed(0)}';

  RentalOrder copyWith({
    String? name,
    String? categoryLabel,
    String? imageQuery,
    String? imageUrl,
    double? rating,
    int? reviewCount,
    String? securityDeposit,
    double? ratePerDay,
    DateTime? startDate,
    DateTime? endDate,
    double? deliveryFee,
    double? platformFee,
    double? pickupFee,
    String? deliveryAddress,
    OrderStatus? status,
    DateTime? deliveryDate,
    String? deliverySlot,
    DateTime? actualDeliveredTime,
    DateTime? returnPickupDate,
    String? returnPickupSlot,
    bool? purchaseRequested,
    bool? isAvailableForPurchase,
    double? purchasePrice,
    String? orderNo,
    String? deliveryOtp,
    String? vendorName,
    String? paymentStatus,
    double? paidAmount,
    double? discount,
    String? couponCode,
    String? cancelReason,
  }) {
    return RentalOrder(
      id: id, // preserved — copyWith always keeps identity so upserts update, not duplicate
      name: name ?? this.name,
      categoryLabel: categoryLabel ?? this.categoryLabel,
      imageQuery: imageQuery ?? this.imageQuery,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      securityDeposit: securityDeposit ?? this.securityDeposit,
      ratePerDay: ratePerDay ?? this.ratePerDay,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      platformFee: platformFee ?? this.platformFee,
      pickupFee: pickupFee ?? this.pickupFee,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      status: status ?? this.status,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      deliverySlot: deliverySlot ?? this.deliverySlot,
      actualDeliveredTime: actualDeliveredTime ?? this.actualDeliveredTime,
      returnPickupDate: returnPickupDate ?? this.returnPickupDate,
      returnPickupSlot: returnPickupSlot ?? this.returnPickupSlot,
      purchaseRequested: purchaseRequested ?? this.purchaseRequested,
      isAvailableForPurchase:
          isAvailableForPurchase ?? this.isAvailableForPurchase,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      orderNo: orderNo ?? this.orderNo,
      deliveryOtp: deliveryOtp ?? this.deliveryOtp,
      vendorName: vendorName ?? this.vendorName,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paidAmount: paidAmount ?? this.paidAmount,
      discount: discount ?? this.discount,
      couponCode: couponCode ?? this.couponCode,
      cancelReason: cancelReason ?? this.cancelReason,
    );
  }

  /// Builds an order from the backend JSON.
  factory RentalOrder.fromApi(Map<String, dynamic> j) {
    final now = DateTime.now();
    final start = date(j['startDate']) ?? now;
    return RentalOrder(
      id: str(j['id']),
      name: str(j['productName']),
      categoryLabel: str(j['categoryLabel']).toUpperCase(),
      imageQuery: str(j['productName']),
      imageUrl: ApiConfig.resolveUrl(strOrNull(j['imageUrl'])),
      securityDeposit: '₹${_inr(dbl(j['securityDeposit']))}',
      ratePerDay: dbl(j['ratePerDay']),
      startDate: start,
      endDate: date(j['endDate']) ?? start.add(const Duration(days: 1)),
      deliveryFee: dbl(j['deliveryFee']),
      platformFee: dbl(j['platformFee']),
      pickupFee: dbl(j['pickupFee']),
      deliveryAddress: str(j['deliveryAddress']),
      status: OrderStatus.fromApi(strOrNull(j['status'])),
      deliveryDate: date(j['deliveryDate']),
      deliverySlot: strOrNull(j['deliverySlot']),
      actualDeliveredTime: date(j['actualDeliveredTime']),
      returnPickupDate: date(j['returnPickupDate']),
      returnPickupSlot: strOrNull(j['returnPickupSlot']),
      purchaseRequested: boolv(j['purchaseRequested']),
      isAvailableForPurchase: boolv(j['isAvailableForPurchase']),
      purchasePrice: j['purchasePrice'] == null
          ? null
          : dbl(j['purchasePrice']),
      orderNo: strOrNull(j['orderNo']),
      deliveryOtp: strOrNull(j['deliveryOtp']),
      vendorName: strOrNull(j['vendorName']),
      paymentStatus: str(j['paymentStatus'], 'PENDING'),
      paidAmount: dbl(j['paidAmount']),
      discount: dbl(j['discount']),
      couponCode: strOrNull(j['couponCode']),
      cancelReason: strOrNull(j['cancelReason']),
    );
  }

  static String _inr(double v) {
    final s = v.round().toString();
    final b = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) b.write(',');
      b.write(s[i]);
    }
    return b.toString();
  }

  static String formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  static String formatTime(DateTime date) {
    final hour24 = date.hour;
    final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = hour24 >= 12 ? 'PM' : 'AM';
    return '$hour12:$minute $period';
  }

  static String formatDateTime(DateTime date) =>
      '${formatDate(date)}, ${formatTime(date)}';
}
