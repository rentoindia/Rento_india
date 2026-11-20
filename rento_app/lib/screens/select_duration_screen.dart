import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/primary_button.dart';
import '../core/api_client.dart';
import '../services/orders_service.dart';
import 'rental_order.dart';
import 'payment_screen.dart';

class SelectDurationScreen extends StatefulWidget {
  final String name;
  final String price; // per-day price string, e.g. '₹599'
  final String categoryLabel;
  final String imageQuery;
  final String? imageUrl;
  final double rating;
  final int reviewCount;
  final String securityDeposit;

  const SelectDurationScreen({
    super.key,
    required this.name,
    required this.price,
    this.imageUrl,
    this.categoryLabel = 'DSLR CAMERA',
    this.imageQuery = 'dslr camera',
    this.rating = 4.5,
    this.reviewCount = 120,
    this.securityDeposit = '₹5,000',
  });

  @override
  State<SelectDurationScreen> createState() => _SelectDurationScreenState();
}

class _SelectDurationScreenState extends State<SelectDurationScreen> {
  int _selectedPeriod =
      1; // 0 = day, 1 = week, 2 = month — controls RATE only now
  late DateTime _startDate;
  late DateTime _endDate;
  DateTime _visibleMonth = DateTime(DateTime.now().year, DateTime.now().month);

  bool _rangeComplete = true;

  static const List<Map<String, dynamic>> _timeSlots = [
    {'label': '9:00 AM - 11:00 AM', 'hour': 9, 'minute': 0},
    {'label': '11:00 AM - 1:00 PM', 'hour': 11, 'minute': 0},
    {'label': '1:00 PM - 3:00 PM', 'hour': 13, 'minute': 0},
    {'label': '3:00 PM - 5:00 PM', 'hour': 15, 'minute': 0},
    {'label': '5:00 PM - 7:00 PM', 'hour': 17, 'minute': 0},
  ];
  int _selectedSlotIndex = 0;

  Map<String, dynamic> get _selectedSlot => _timeSlots[_selectedSlotIndex];

  DateTime get _pickupDateTime => DateTime(
    _startDate.year,
    _startDate.month,
    _startDate.day,
    _selectedSlot['hour'] as int,
    _selectedSlot['minute'] as int,
  );

  DateTime get _returnDateTime => DateTime(
    _endDate.year,
    _endDate.month,
    _endDate.day,
    _selectedSlot['hour'] as int,
    _selectedSlot['minute'] as int,
  );

  void _setSlot(int index) {
    setState(() => _selectedSlotIndex = index);
  }

  double get _basePrice =>
      double.tryParse(widget.price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 599;

  double get _dayRate => _basePrice;
  double get _weekRate =>
      (_basePrice * 0.83).roundToDouble(); // matches reference (599 -> 499)
  double get _monthRate =>
      (_basePrice * 0.67).roundToDouble(); // matches reference (599 -> 399)

  double get _selectedRate => _selectedPeriod == 0
      ? _dayRate
      : (_selectedPeriod == 1 ? _weekRate : _monthRate);

  @override
  void initState() {
    super.initState();
    _startDate = DateTime.now();
    _endDate = _startDate.add(const Duration(days: 7));
  }

  int get _days {
    final d = _endDate.difference(_startDate).inDays;
    return d <= 0 ? 1 : d;
  }

  double get _rentalAmount => _selectedRate * _days;
  static const double _baseDeliveryFee = 120;
  static const double _platformFee = 40;

  static const List<String> _noDeliveryCategories = [
    'Private Rental Jets',
    'Boats & Yachts',
    'Party Halls',
    'Hotels and Resorts',
  ];

  bool get _isNonDeliverable =>
      _noDeliveryCategories.contains(widget.categoryLabel);

  double get _deliveryFee => _isNonDeliverable ? 0 : _baseDeliveryFee;
  double get _totalAmount => _rentalAmount + _platformFee;

  void _setPeriod(int period) {
    setState(() {
      _selectedPeriod = period;
      final span = period == 0 ? 1 : (period == 1 ? 7 : 30);
      _endDate = _startDate.add(Duration(days: span));
      _rangeComplete = true;
    });
  }

  void _onDateTapped(DateTime date) {
    setState(() {
      if (_rangeComplete) {
        _startDate = date;
        _endDate = date;
        _rangeComplete = false;
      } else if (date.isBefore(_startDate)) {
        _startDate = date;
      } else {
        _endDate = date;
        _rangeComplete = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
          'Select Rental Duration',
          style: AppText.titleLg.copyWith(fontSize: 16),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Row(
                children: [
                  Icon(
                    Icons.verified_user_outlined,
                    size: 15,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(width: 4),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
          children: [
            const BookingStepper(currentStep: 1),
            const SizedBox(height: 18),
            _buildProductSummary(),
            const SizedBox(height: 22),
            Text(
              '1. Select Rental Period',
              style: AppText.titleLg.copyWith(fontSize: 14.5),
            ),
            Text(
              'Choose your rental duration',
              style: AppText.bodySm.copyWith(fontSize: 12),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _periodCard('1 Day', _dayRate, 0),
                const SizedBox(width: 10),
                _periodCard('1 Week', _weekRate, 1, popular: true),
                const SizedBox(width: 10),
                _periodCard('1 Month', _monthRate, 2),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              '2. Choose Dates',
              style: AppText.titleLg.copyWith(fontSize: 14.5),
            ),
            const SizedBox(height: 4),

            Text(
              _rangeComplete
                  ? 'Tap a date to start a new selection, then tap another to set the end date'
                  : 'Now tap your end date',
              style: AppText.bodySm.copyWith(fontSize: 11.5),
            ),
            const SizedBox(height: 10),
            _RangeCalendar(
              visibleMonth: _visibleMonth,
              startDate: _startDate,
              endDate: _endDate,
              onMonthChanged: (m) => setState(() => _visibleMonth = m),
              onDateTapped: _onDateTapped,
            ),
            const SizedBox(height: 24),
            Text(
              '3. Select Pickup Time Slot',
              style: AppText.titleLg.copyWith(fontSize: 14.5),
            ),
            Text(
              'Rental duration is calculated from this time',
              style: AppText.bodySm.copyWith(fontSize: 12),
            ),
            const SizedBox(height: 10),
            _buildTimeSlots(),
            const SizedBox(height: 16),
            _summaryCard(),
            const SizedBox(height: 16),
            Text(
              'Price Details',
              style: AppText.titleLg.copyWith(fontSize: 14.5),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.border),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _row(
                    'Rental Charge (₹${_selectedRate.toStringAsFixed(0)} x $_days Days)',
                    '₹${_rentalAmount.toStringAsFixed(0)}',
                  ),
                  _row('Platform Fee', '₹${_platformFee.toStringAsFixed(0)}'),
                  const Divider(height: 20),
                  _row(
                    'Total Amount',
                    '₹${_totalAmount.toStringAsFixed(0)}',
                    bold: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.lightGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.verified_user_outlined,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Security Deposit (Refundable)',
                      style: AppText.titleSm.copyWith(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    widget.securityDeposit,
                    style: AppText.titleSm.copyWith(fontSize: 12.5),
                  ),
                ],
              ),
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
                label: 'CONTINUE',
                icon: Icons.arrow_forward,
                onPressed: () async {
                  final order = RentalOrder(
                    name: widget.name,
                    categoryLabel: widget.categoryLabel,
                    imageQuery: widget.imageQuery,
                    imageUrl: widget.imageUrl,
                    rating: widget.rating,
                    reviewCount: widget.reviewCount,
                    securityDeposit: widget.securityDeposit,
                    ratePerDay: _selectedRate,
                    startDate: _pickupDateTime,
                    endDate: _returnDateTime,
                    deliveryFee: _deliveryFee,
                    platformFee: _platformFee,
                    status: OrderStatus.placed,
                  );
                  try {
                    // creates the order on the server (it returns the real order with its OTP)
                    final created = await OrdersService.instance.createOrder(
                      order,
                    );
                    if (!context.mounted) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PaymentScreen(order: created),
                      ),
                    );
                  } on ApiException catch (e) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.message)));
                  }
                },
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.lock_outline,
                    size: 13,
                    color: AppColors.textHint,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Your payment details are secure with us',
                    style: AppText.caption.copyWith(fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductSummary() {
    final imgPath =
        widget.imageUrl ??
        'https://loremflickr.com/120/120/${widget.imageQuery.replaceAll(' ', ',')}?lock=${widget.name.hashCode.abs() % 5000}';

    final isAsset = !imgPath.startsWith('http');

    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: isAsset
              ? Image.asset(
                  imgPath,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 56,
                    height: 56,
                    color: AppTheme.lightGrey,
                    child: const Icon(Icons.camera_alt_outlined),
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
                    child: const Icon(Icons.camera_alt_outlined),
                  ),
                ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppText.titleMd.copyWith(fontSize: 14.5),
              ),

              Text(
                widget.categoryLabel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppText.bodySm.copyWith(fontSize: 11.5),
              ),

              const SizedBox(height: 2),

              Row(
                children: [
                  const Icon(Icons.star, size: 13, color: Colors.amber),
                  const SizedBox(width: 3),

                  Expanded(
                    child: Text(
                      '${widget.rating} (${widget.reviewCount} reviews)',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.caption.copyWith(fontSize: 11),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(width: 8),

        SizedBox(
          width: 65,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: Text(
                  widget.price,
                  style: AppText.priceLg.copyWith(fontSize: 15),
                ),
              ),

              Text('/ day', style: AppText.caption.copyWith(fontSize: 11)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _periodCard(
    String label,
    double rate,
    int index, {
    bool popular = false,
  }) {
    final selected = _selectedPeriod == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => _setPeriod(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: selected ? AppColors.primaryBlack : AppColors.pureWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? AppColors.primaryBlack : AppTheme.border,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 14,
                    color: selected
                        ? AppColors.pureWhite
                        : AppColors.textPrimary,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      label,
                      style: AppText.titleSm.copyWith(
                        color: selected
                            ? AppColors.pureWhite
                            : AppColors.textPrimary,
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  '₹${rate.toStringAsFixed(0)} / day',
                  style: AppText.caption.copyWith(
                    color: selected
                        ? AppColors.pureWhite.withOpacity(0.7)
                        : AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ),
              if (popular) ...[
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.pureWhite : AppTheme.lightGrey,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Popular',
                    style: AppText.caption.copyWith(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: selected
                          ? AppColors.primaryBlack
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSlots() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(_timeSlots.length, (index) {
        final slot = _timeSlots[index];
        final selected = _selectedSlotIndex == index;
        return GestureDetector(
          onTap: () => _setSlot(index),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            decoration: BoxDecoration(
              color: selected ? AppColors.primaryBlack : AppColors.pureWhite,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: selected ? AppColors.primaryBlack : AppTheme.border,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time,
                  size: 14,
                  color: selected ? AppColors.pureWhite : AppColors.textPrimary,
                ),
                const SizedBox(width: 6),
                Text(
                  slot['label'] as String,
                  style: AppText.titleSm.copyWith(
                    fontSize: 12,
                    color: selected
                        ? AppColors.pureWhite
                        : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _summaryCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.lightGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Duration Summary',
                style: AppText.titleSm.copyWith(fontSize: 13),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlack,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  '$_days Days',
                  style: AppText.buttonSm.copyWith(fontSize: 11),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _iconRow(
            Icons.calendar_today_outlined,
            'Start Date',
            RentalOrder.formatDate(_startDate),
          ),
          _iconRow(
            Icons.calendar_today_outlined,
            'End Date',
            RentalOrder.formatDate(_endDate),
          ),
          _iconRow(
            Icons.access_time,
            'Pickup Time',
            _selectedSlot['label'] as String,
          ),
          _iconRow(Icons.access_time, 'Total Duration', '$_days Days'),
        ],
      ),
    );
  }

  Widget _iconRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 15, color: AppColors.textSecondary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(label, style: AppText.bodyMd.copyWith(fontSize: 12.5)),
          ),
          Text(value, style: AppText.titleSm.copyWith(fontSize: 12.5)),
        ],
      ),
    );
  }

  Widget _row(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppText.bodyMd.copyWith(
              color: bold ? AppColors.textPrimary : AppTheme.grey,
              fontWeight: bold ? FontWeight.w800 : FontWeight.w400,
              fontSize: bold ? 14 : 12.5,
            ),
          ),
          Text(
            value,
            style: AppText.titleSm.copyWith(
              fontWeight: bold ? FontWeight.w800 : FontWeight.w700,
              fontSize: bold ? 15 : 12.5,
            ),
          ),
        ],
      ),
    );
  }
}

class BookingStepper extends StatelessWidget {
  final int
  currentStep; // 0-indexed: 0=Product, 1=Duration, 2=Address, 3=Payment
  const BookingStepper({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    const labels = ['Product', 'Duration', 'Address', 'Payment'];
    return Row(
      children: List.generate(labels.length * 2 - 1, (i) {
        if (i.isOdd) {
          final leftDone = (i ~/ 2) < currentStep;
          return Expanded(
            child: Container(
              height: 2,
              color: leftDone ? AppColors.primaryBlack : AppTheme.border,
            ),
          );
        }
        final index = i ~/ 2;
        final done = index < currentStep;
        final active = index == currentStep;
        return Column(
          children: [
            Container(
              width: 26,
              height: 26,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: (done || active)
                    ? AppColors.primaryBlack
                    : AppColors.pureWhite,
                shape: BoxShape.circle,
                border: Border.all(
                  color: (done || active)
                      ? AppColors.primaryBlack
                      : AppTheme.border,
                ),
              ),
              child: done
                  ? const Icon(
                      Icons.check,
                      size: 14,
                      color: AppColors.pureWhite,
                    )
                  : Text(
                      '${index + 1}',
                      style: AppText.titleSm.copyWith(
                        color: active
                            ? AppColors.pureWhite
                            : AppColors.textHint,
                        fontSize: 12,
                      ),
                    ),
            ),
            const SizedBox(height: 4),
            Text(
              labels[index],
              style: AppText.caption.copyWith(
                fontSize: 9.5,
                fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                color: active ? AppColors.textPrimary : AppColors.textHint,
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _RangeCalendar extends StatelessWidget {
  final DateTime visibleMonth;
  final DateTime startDate;
  final DateTime endDate;
  final ValueChanged<DateTime> onMonthChanged;
  final ValueChanged<DateTime> onDateTapped;

  const _RangeCalendar({
    required this.visibleMonth,
    required this.startDate,
    required this.endDate,
    required this.onMonthChanged,
    required this.onDateTapped,
  });

  static const _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  List<DateTime?> _buildGrid() {
    final firstOfMonth = DateTime(visibleMonth.year, visibleMonth.month, 1);
    final daysInMonth = DateTime(
      visibleMonth.year,
      visibleMonth.month + 1,
      0,
    ).day;
    final leadingBlanks = firstOfMonth.weekday - 1; // Monday-first grid
    return [
      ...List.generate(leadingBlanks, (_) => null),
      ...List.generate(
        daysInMonth,
        (i) => DateTime(visibleMonth.year, visibleMonth.month, i + 1),
      ),
    ];
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    final grid = _buildGrid();
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => onMonthChanged(
                  DateTime(visibleMonth.year, visibleMonth.month - 1),
                ),
                child: const Icon(Icons.chevron_left),
              ),
              Text(
                '${_months[visibleMonth.month - 1]} ${visibleMonth.year}',
                style: AppText.titleSm.copyWith(fontSize: 14),
              ),
              GestureDetector(
                onTap: () => onMonthChanged(
                  DateTime(visibleMonth.year, visibleMonth.month + 1),
                ),
                child: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: ['M', 'T', 'W', 'T', 'F', 'S', 'S']
                .map(
                  (d) => Expanded(
                    child: Center(
                      child: Text(
                        d,
                        style: AppText.caption.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 6),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: grid.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, i) {
              final date = grid[i];
              if (date == null) return const SizedBox();

              final isStart = _isSameDay(date, startDate);
              final isEnd = _isSameDay(date, endDate);
              final inRange = date.isAfter(startDate) && date.isBefore(endDate);
              final isPast = date.isBefore(todayStart);

              return GestureDetector(
                onTap: isPast ? null : () => onDateTapped(date),
                child: Container(
                  margin: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: (isStart || isEnd)
                        ? AppColors.primaryBlack
                        : (inRange ? AppTheme.lightGrey : null),
                    shape: (isStart || isEnd)
                        ? BoxShape.circle
                        : BoxShape.rectangle,
                    borderRadius: (isStart || isEnd)
                        ? null
                        : BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${date.day}',
                        style: AppText.bodyMd.copyWith(
                          fontSize: 12.5,
                          color: isPast
                              ? AppColors.border
                              : ((isStart || isEnd)
                                    ? AppColors.pureWhite
                                    : AppColors.textPrimary),
                          fontWeight: (isStart || isEnd)
                              ? FontWeight.w700
                              : FontWeight.w400,
                        ),
                      ),
                      if (isStart)
                        Text(
                          'Start',
                          style: AppText.caption.copyWith(
                            fontSize: 7.5,
                            color: AppColors.pureWhite,
                          ),
                        ),
                      if (isEnd && !isStart)
                        Text(
                          'End',
                          style: AppText.caption.copyWith(
                            fontSize: 7.5,
                            color: AppColors.pureWhite,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
