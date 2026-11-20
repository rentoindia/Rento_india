import '../../../../../../core/api_client.dart';
import 'package:rento_india/delivery/core/rider_api.dart';

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rento_india/delivery/core/constants/app_colors.dart';

import '../../../../../core/widgets/primary_button.dart';
import '../../../data/models/trip_request_model.dart';
import 'trip_navigation_screen.dart';

class PickupOtpScreen extends StatefulWidget {
  final TripRequestModel request;

  const PickupOtpScreen({super.key, required this.request});

  @override
  State<PickupOtpScreen> createState() => _PickupOtpScreenState();
}

class _PickupOtpScreenState extends State<PickupOtpScreen>
    with TickerProviderStateMixin {
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _otpFocusNodes = List.generate(4, (_) => FocusNode());

  static const int _totalSeconds = 5 * 60;
  int _secondsLeft = _totalSeconds - 2;
  Timer? _timer;

  Uint8List? _photoBytes;
  bool _isSubmitting = false;

  late final AnimationController _entranceController;
  late final Animation<double> _fadeIn;
  late final Animation<Offset> _slideIn;

  late final AnimationController _shakeController;
  late final Animation<double> _shakeAnimation;

  static const bool _kTestModeAcceptAnyOtp = true;

  late final String _productId = 'PRD${widget.request.id.padLeft(6, '0')}';
  late final String _serialNumber =
      '${widget.request.itemName.replaceAll(' ', '').toUpperCase()}-${widget.request.id}';
  static const int _quantity = 1;
  static const int _rentalDurationDays = 7;
  static const double _securityDeposit = 5000;
  late final String _orderId = '#RENT${widget.request.id}';
  static const String _orderType = 'Delivery';
  static const String _mockPickupOtp =
      '1234'; // only used when test mode is off

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeIn = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOut,
    );
    _slideIn = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(_fadeIn);
    _entranceController.forward();

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _shakeAnimation = TweenSequence<double>(
      [
        TweenSequenceItem(tween: Tween(begin: 0.0, end: -10.0), weight: 1),
        TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 2),
        TweenSequenceItem(tween: Tween(begin: 10.0, end: -6.0), weight: 2),
        TweenSequenceItem(tween: Tween(begin: -6.0, end: 0.0), weight: 1),
      ],
    ).animate(CurvedAnimation(parent: _shakeController, curve: Curves.easeOut));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 0) {
        timer.cancel();
        _onOtpExpired();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _entranceController.dispose();
    _shakeController.dispose();
    for (final c in _otpControllers) {
      c.dispose();
    }
    for (final f in _otpFocusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _enteredOtp => _otpControllers.map((c) => c.text).join();

  String get _formattedTime {
    final minutes = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsLeft % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _onOtpDigitChanged(int index, String value) {
    if (value.isNotEmpty && index < 3) {
      _otpFocusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _otpFocusNodes[index - 1].requestFocus();
    }
    setState(() {});
  }

  void _onOtpExpired() {
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('OTP Expired'),
        content: const Text(
          'The pickup verification code has expired. Please ask the vendor to resend it.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Go Back'),
          ),
        ],
      ),
    );
  }

  Future<void> _capturePhoto() async {
    try {
      final picker = ImagePicker();
      final XFile? file = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      if (file == null) return;
      final bytes = await file.readAsBytes();
      setState(() => _photoBytes = bytes);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open camera. Please try again.'),
        ),
      );
    }
  }

  bool get _canConfirm =>
      _enteredOtp.length == 4 && _photoBytes != null && !_isSubmitting;

  Future<void> _onConfirm() async {
    if (_enteredOtp.length != 4) return;

    if (_photoBytes == null) return;

    // the server checks the code the customer / vendor tells the rider
    String? otpError;
    setState(() => _isSubmitting = true);
    try {
      await RiderApi.instance.verifyPickup(
        'TRIP',
        widget.request.id,
        _enteredOtp,
      );
    } on ApiException catch (e) {
      otpError = e.message;
    }
    if (!mounted) return;
    if (otpError != null) {
      setState(() => _isSubmitting = false);
      _shakeController.forward(from: 0);
      for (final c in _otpControllers) {
        c.clear();
      }
      _otpFocusNodes.first.requestFocus();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(otpError)));
      return;
    }

    if (_photoBytes == null) return;

    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;

    setState(() => _isSubmitting = false);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => TripNavigationScreen(
          request: widget.request,
          stage: NavigationStage.toCustomer,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.request;

    return Scaffold(
      backgroundColor: AppColors.scaffoldLight,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldLight,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Verify Pickup',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: FadeTransition(
          opacity: _fadeIn,
          child: SlideTransition(
            position: _slideIn,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildProductCard(r),
                  const SizedBox(height: 14),
                  _buildDetailsCard(),
                  const SizedBox(height: 14),
                  _buildOrderInfoCard(),
                  const SizedBox(height: 18),
                  const Text(
                    'Vendor Verification',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _kTestModeAcceptAnyOtp
                        ? 'Enter any 4-digit code (test mode)'
                        : 'Enter code from vendor',
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _buildOtpRow(),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 13,
                        color: _secondsLeft <= 60
                            ? AppColors.error
                            : AppColors.textSecondary,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'OTP will expire in $_formattedTime',
                        style: TextStyle(
                          fontSize: 12,
                          color: _secondsLeft <= 60
                              ? AppColors.error
                              : AppColors.textSecondary,
                          fontWeight: _secondsLeft <= 60
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildNoteCard(),
                  const SizedBox(height: 20),
                  const Text(
                    'Proof of Pickup (Required)',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildPhotoCapture(),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label: 'Confirm & Start Delivery',
                    trailingIcon: Icons.local_shipping_outlined,
                    isLoading: _isSubmitting,
                    onPressed: _canConfirm ? _onConfirm : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(TripRequestModel r) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        border: Border.all(color: AppColors.divider),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColors.inputFill,
              borderRadius: BorderRadius.circular(12),
            ),
            child: r.imageAsset != null
                ? Image.asset(r.imageAsset!, fit: BoxFit.cover)
                : const Icon(
                    Icons.inventory_2_outlined,
                    size: 28,
                    color: AppColors.textSecondary,
                  ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      r.itemName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.inputFill,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Qty: $_quantity',
                        style: TextStyle(
                          fontSize: 10.5,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  r.category,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  'Serial No: $_serialNumber',
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        border: Border.all(color: AppColors.divider),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          _DetailRow(label: 'Product ID', value: _productId),
          const _DetailRow(label: 'Category', value: 'Electronics'),
          const _DetailRow(
            label: 'Rental Duration',
            value: '$_rentalDurationDays Days',
          ),
          _DetailRow(
            label: 'Security Deposit',
            value: '₹${_securityDeposit.toStringAsFixed(0)}',
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildOrderInfoCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ORDER ID',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.textHint,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _orderId,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'TYPE',
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.textHint,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(height: 2),
              Text(
                _orderType,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOtpRow() {
    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) => Transform.translate(
        offset: Offset(_shakeAnimation.value, 0),
        child: child,
      ),
      child: Row(
        children: List.generate(4, (index) {
          return Padding(
            padding: EdgeInsets.only(right: index < 3 ? 14 : 0),
            child: SizedBox(
              width: 60,
              height: 60,
              child: TextField(
                controller: _otpControllers[index],
                focusNode: _otpFocusNodes[index],
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.number,
                maxLength: 1,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: AppColors.inputFill,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: AppColors.primaryBlack,
                      width: 1.6,
                    ),
                  ),
                ),
                onChanged: (value) => _onOtpDigitChanged(index, value),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildNoteCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 16, color: Color(0xFFB8860B)),
          SizedBox(width: 8),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Note\n',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB8860B),
                      fontSize: 12.5,
                    ),
                  ),
                  TextSpan(
                    text: 'Please check the product condition and accessories before pickup.',
                    style: TextStyle(color: Color(0xFF8A6D1D), fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoCapture() {
    final hasPhoto = _photoBytes != null;

    return GestureDetector(
      onTap: _capturePhoto,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        width: double.infinity,
        height: 190,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: hasPhoto ? const Color(0xFFE8F8EF) : AppColors.inputFill,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hasPhoto ? AppColors.success : AppColors.border,
            width: hasPhoto ? 1.4 : 1,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (hasPhoto)
              Positioned.fill(
                child: Image.memory(_photoBytes!, fit: BoxFit.cover),
              )
            else
              const Icon(
                Icons.smartphone_outlined,
                size: 70,
                color: AppColors.border,
              ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: hasPhoto ? 0 : 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 90),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: AppColors.pureBlack,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: AppColors.pureWhite,
                      size: 22,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Take Product Photo',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (hasPhoto)
              Positioned(
                right: 10,
                top: 10,
                child: AnimatedScale(
                  scale: hasPhoto ? 1 : 0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.elasticOut,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: AppColors.pureWhite,
                      size: 16,
                    ),
                  ),
                ),
              ),
            if (hasPhoto)
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.refresh, size: 13, color: Colors.white),
                      SizedBox(width: 4),
                      Text(
                        'Retake',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isLast;

  const _DetailRow({
    required this.label,
    required this.value,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
