import '../../../data/models/rider_registration_data.dart';

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:rento_india/delivery/core/constants/app_colors.dart';

import '../../../../../core/routes/route_names.dart';
import '../../widgets/document_upload_box.dart';
import '../../widgets/image_picker_sheet.dart';
import '../../widgets/registration_scaffold.dart';

class DrivingLicenseScreen extends StatefulWidget {
  const DrivingLicenseScreen({super.key});

  @override
  State<DrivingLicenseScreen> createState() => _DrivingLicenseScreenState();
}

class _DrivingLicenseScreenState extends State<DrivingLicenseScreen> {
  Uint8List? _licenseImage;

  Future<void> _pickImage() async {
    final bytes = await pickImageFromSheet(context);
    if (bytes == null) return;
    setState(() => _licenseImage = bytes);
  }

  void _onContinue() {
    RiderRegistrationData.instance.licenseImage = _licenseImage;
    Navigator.of(context).pushNamed(RouteNames.riderVehicleDetails);
  }

  @override
  Widget build(BuildContext context) {
    return RegistrationScaffold(
      currentStep: 4,
      title: 'Driving License',
      subtitle: 'Upload your driving license',
      buttonLabel: 'Continue',
      onButtonPressed: _licenseImage != null ? _onContinue : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            isUploaded: _licenseImage != null,
            previewBytes: _licenseImage,
            onTap: _pickImage,
          ),
        ],
      ),
    );
  }
}
