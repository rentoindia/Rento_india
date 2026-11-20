import '../../../data/models/rider_registration_data.dart';

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:rento_india/delivery/core/constants/app_colors.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../../../../../core/widgets/step_progress_indicator.dart';
import '../../widgets/document_upload_box.dart';
import '../../widgets/image_picker_sheet.dart';

class AadhaarVerificationScreen extends StatefulWidget {
  const AadhaarVerificationScreen({super.key});

  @override
  State<AadhaarVerificationScreen> createState() =>
      _AadhaarVerificationScreenState();
}

class _AadhaarVerificationScreenState extends State<AadhaarVerificationScreen> {
  Uint8List? _frontImage;
  Uint8List? _backImage;

  Future<void> _pickImage(bool isFront) async {
    final bytes = await pickImageFromSheet(context);
    if (bytes == null) return;

    setState(() {
      if (isFront) {
        _frontImage = bytes;
      } else {
        _backImage = bytes;
      }
    });
  }

  void _onContinue() {
    RiderRegistrationData.instance.aadhaarFront = _frontImage;
    RiderRegistrationData.instance.aadhaarBack = _backImage;
    Navigator.of(context).pushNamed(RouteNames.riderSelfieVerification);
  }

  @override
  Widget build(BuildContext context) {
    final canContinue = _frontImage != null && _backImage != null;

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const StepProgressIndicator(totalSteps: 10, currentStep: 1),
              const SizedBox(height: 8),
              const Text(
                'Aadhaar Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Upload your Aadhaar card',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 28),

              const Text(
                'Front Side',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              DocumentUploadBox(
                label: 'Front side',
                isUploaded: _frontImage != null,
                previewBytes: _frontImage,
                onTap: () => _pickImage(true),
              ),
              const SizedBox(height: 20),

              const Text(
                'Back Side',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              DocumentUploadBox(
                label: 'Back side',
                isUploaded: _backImage != null,
                previewBytes: _backImage,
                onTap: () => _pickImage(false),
              ),

              const SizedBox(height: 32),

              PrimaryButton(
                label: 'Continue',
                onPressed: canContinue ? _onContinue : null,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
