import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../core/api_client.dart';
import '../core/session.dart';
import 'home_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool _verifying = false;
  final TextEditingController _otpController = TextEditingController();
  Timer? _timer;
  int _secondsLeft = 47;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _generateAndSendOtp();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  /// The 10-digit mobile number (the login screen may pass +91 or spaces).
  String get _phone {
    final digits = widget.phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    return digits.length > 10 ? digits.substring(digits.length - 10) : digits;
  }

  Future<void> _generateAndSendOtp() async {
    try {
      final devOtp = await Session.instance.requestOtp(_phone);
      if (!mounted) return;
      // devOtp is only returned while the server runs in dev-mode (no SMS key yet)
      if (devOtp != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Demo OTP: $devOtp (SMS gateway not configured yet)'),
            duration: const Duration(seconds: 8),
          ),
        );
      }
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() => _errorText = e.message);
    }
  }

  void _startTimer() {
    _secondsLeft = 47;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_secondsLeft == 0) {
        timer.cancel();
        setState(() {});
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  Future<void> _handleVerify() async {
    if (_verifying) return;
    if (_otpController.text.length < 4) {
      setState(() => _errorText = 'Enter the 4-digit OTP');
      return;
    }
    setState(() {
      _verifying = true;
      _errorText = null;
    });
    try {
      await Session.instance.verifyOtp(
        _phone,
        _otpController.text,
        role: 'CUSTOMER',
      );
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false,
      );
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _verifying = false;
        _errorText = e.message;
      });
    }
  }

  void _handleResend() {
    _otpController.clear();
    setState(() => _errorText = null);
    _generateAndSendOtp();
    _startTimer();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('A new OTP has been sent'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  String get _maskedNumber {
    final n = widget.phoneNumber;
    if (n.length < 4) return n;
    return '${n.substring(0, n.length - 4)}****${n.substring(n.length - 2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),

              SizedBox(
                height: 160,
                width: 160,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/rental/mailbox.png',
                      width: 130,
                      height: 130,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.mail_outline,
                        color: Colors.grey.shade400,
                        size: 70,
                      ),
                    ),

                    const Positioned(
                      top: 6,
                      right: 6,
                      child: Icon(
                        Icons.send_rounded,
                        color: Color(0xFFFB923C),
                        size: 26,
                      ),
                    ),

                    Positioned(
                      bottom: 18,
                      left: 6,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Color(0xFF22C55E),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),
              const Text(
                'OTP Verification',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                'Sent to +91 $_maskedNumber',
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),

              const SizedBox(height: 20),

              PinCodeTextField(
                appContext: context,
                length: 4,
                controller: _otpController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(12),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  activeColor: Colors.black,
                  selectedColor: Colors.black,
                  inactiveColor: const Color(0xFFE5E7EB),
                  activeFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                ),
                enableActiveFill: true,
                onChanged: (value) {},
                onCompleted: (value) => _handleVerify(),
              ),

              if (_errorText != null) ...[
                const SizedBox(height: 8),
                Text(
                  _errorText!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ],

              const SizedBox(height: 8),
              Text(
                _secondsLeft > 0
                    ? 'Resend in 00:${_secondsLeft.toString().padLeft(2, '0')}'
                    : "Didn't get it? You can resend now",
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _handleVerify,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.shield_outlined,
                        color: Colors.white,
                        size: 17,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'VERIFY & CONTINUE',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 15),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: _secondsLeft == 0 ? _handleResend : null,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: _secondsLeft == 0
                          ? Colors.black
                          : Colors.grey.shade300,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.refresh,
                        size: 17,
                        color: _secondsLeft == 0 ? Colors.black : Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'RESEND OTP',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          letterSpacing: 0.5,
                          color: _secondsLeft == 0 ? Colors.black : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.mail_outline,
                    size: 14,
                    color: Colors.grey.shade500,
                  ),
                  const SizedBox(width: 6),
                  Text.rich(
                    TextSpan(
                      text: "Didn't receive? ",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                      children: const [
                        TextSpan(
                          text: 'Check spam folder',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
