import '../../../data/models/rider_registration_data.dart';

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:rento_india/delivery/core/constants/app_colors.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../../../../../core/widgets/step_progress_indicator.dart';
import 'aadhaar_verification_screen.dart';

class SelfieVerificationScreen extends StatefulWidget {
  const SelfieVerificationScreen({super.key});

  @override
  State<SelfieVerificationScreen> createState() =>
      _SelfieVerificationScreenState();
}

enum _CameraLoadState { loading, ready, error }

class _SelfieVerificationScreenState extends State<SelfieVerificationScreen> {
  CameraController? _controller;
  _CameraLoadState _loadState = _CameraLoadState.loading;
  String? _errorMessage;
  Uint8List? _capturedBytes;
  bool _isCapturing = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() {
          _loadState = _CameraLoadState.error;
          _errorMessage = 'No camera found on this device.';
        });
        return;
      }

      final camera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      final controller = CameraController(
        camera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await controller.initialize();
      if (!mounted) return;

      setState(() {
        _controller = controller;
        _loadState = _CameraLoadState.ready;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loadState = _CameraLoadState.error;
        _errorMessage = 'Could not access the camera. Please allow camera permission and try again.';
      });
    }
  }

  Future<void> _capture() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized || _isCapturing)
      return;

    setState(() => _isCapturing = true);
    try {
      final XFile file = await controller.takePicture();
      final bytes = await file.readAsBytes();
      setState(() => _capturedBytes = bytes);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not capture photo. Please try again.'),
        ),
      );
    } finally {
      if (mounted) setState(() => _isCapturing = false);
    }
  }

  void _retake() {
    setState(() => _capturedBytes = null);
  }

  void _onContinue() {
    RiderRegistrationData.instance.selfie = _capturedBytes;
    Navigator.of(context).pushNamed(RouteNames.riderCommonInfo);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldLight,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldLight,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const StepProgressIndicator(totalSteps: 10, currentStep: 2),
              const SizedBox(height: 8),
              const Text(
                'Selfie Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Take a clear selfie',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 32),
              Center(child: _buildCameraCircle()),
              const SizedBox(height: 16),
              if (_capturedBytes != null)
                Center(
                  child: TextButton.icon(
                    onPressed: _retake,
                    icon: const Icon(
                      Icons.refresh,
                      size: 18,
                      color: AppColors.textPrimary,
                    ),
                    label: const Text(
                      'Retake',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              const Spacer(),
              _buildBottomButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCameraCircle() {
    const double diameter = 240;

    Widget inner;
    switch (_loadState) {
      case _CameraLoadState.loading:
        inner = const Center(child: CircularProgressIndicator());
        break;
      case _CameraLoadState.error:
        inner = Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.videocam_off_outlined,
                color: AppColors.textHint,
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(
                _errorMessage ?? 'Camera unavailable',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        );
        break;
      case _CameraLoadState.ready:
        if (_capturedBytes != null) {
          inner = Image.memory(_capturedBytes!, fit: BoxFit.cover);
        } else if (_controller != null) {
          inner = CameraPreview(_controller!);
        } else {
          inner = const SizedBox.shrink();
        }
        break;
    }

    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.inputFill,
        border: Border.all(
          color: _capturedBytes != null ? AppColors.success : AppColors.border,
          width: 3,
        ),
      ),
      child: ClipOval(child: inner),
    );
  }

  Widget _buildBottomButton() {
    if (_loadState == _CameraLoadState.error) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PrimaryButton(
            label: 'Retry Camera',
            trailingIcon: Icons.refresh,
            onPressed: () {
              setState(() => _loadState = _CameraLoadState.loading);
              _initCamera();
            },
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: _onContinue,
            child: const Text(
              'Skip for now (testing)',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
          ),
        ],
      );
    }

    if (_capturedBytes != null) {
      return PrimaryButton(label: 'Continue', onPressed: _onContinue);
    }

    return PrimaryButton(
      label: 'Capture Selfie',
      trailingIcon: Icons.camera_alt_outlined,
      isLoading: _isCapturing,
      onPressed: _loadState == _CameraLoadState.ready ? _capture : null,
    );
  }
}
