import 'dart:typed_data';
import 'package:flutter/material.dart';
//import '../../../../../core/constants/app_colors.dart';
import 'package:rento_india/delivery/core/constants/app_colors.dart';
import '../../../../../core/routes/route_names.dart';
import '../../../data/models/rider_registration_data.dart';
import '../../widgets/document_upload_box.dart';
import '../../widgets/image_picker_sheet.dart';
import '../../widgets/registration_scaffold.dart';
import '../../widgets/registration_text_field.dart';

/// Rider registration step 5 — Vehicle Details.
class VehicleDetailsScreen extends StatefulWidget {
  const VehicleDetailsScreen({super.key});

  @override
  State<VehicleDetailsScreen> createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _numberController = TextEditingController(
    text: RiderRegistrationData.instance.vehicleNumber,
  );
  String? _vehicleType = RiderRegistrationData.instance.vehicleType.isEmpty
      ? null
      : RiderRegistrationData.instance.vehicleType;
  Uint8List? _rcImage;

  static const _vehicleTypes = ['Bike', 'Scooter', 'Bicycle', 'Auto Rickshaw'];

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  Future<void> _pickRcImage() async {
    final bytes = await pickImageFromSheet(context);
    if (bytes == null) return;
    setState(() => _rcImage = bytes);
    // TODO: upload via RiderRepository.uploadVehicleRc(bytes)
  }

  bool get _canContinue =>
      _vehicleType != null &&
      _numberController.text.trim().isNotEmpty &&
      _rcImage != null;

  void _onContinue() {
    if (!_formKey.currentState!.validate() || !_canContinue) return;

    RiderRegistrationData.instance
      ..vehicleType = _vehicleType!
      ..vehicleNumber = _numberController.text.trim();

    Navigator.of(context).pushNamed(RouteNames.riderInsuranceDetails);
  }

  @override
  Widget build(BuildContext context) {
    return RegistrationScaffold(
      title: 'Vehicle Details',
      subtitle: 'Tell us about your delivery vehicle',
      buttonLabel: 'Continue',
      onButtonPressed: _onContinue,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RegistrationDropdown(
              label: 'Vehicle Type',
              hint: 'Select Type',
              value: _vehicleType,
              options: _vehicleTypes,
              onChanged: (v) => setState(() => _vehicleType = v),
            ),
            RegistrationTextField(
              label: 'Vehicle Number',
              hint: 'TN 09 AB 1234',
              controller: _numberController,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Vehicle number is required'
                  : null,
            ),
            const SizedBox(height: 4),
            const Text(
              'RC Book',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            DocumentUploadBox(
              label: 'RC Book',
              isUploaded: _rcImage != null,
              previewBytes: _rcImage,
              onTap: _pickRcImage,
            ),
          ],
        ),
      ),
    );
  }
}
