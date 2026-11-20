import '../../../../../../core/api_client.dart';
import 'package:rento_india/delivery/core/rider_api.dart';

import 'package:flutter/material.dart';
import 'package:rento_india/delivery/core/constants/app_colors.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../data/models/rider_registration_data.dart';
import '../../widgets/registration_scaffold.dart';

class ReviewDetailsScreen extends StatelessWidget {
  const ReviewDetailsScreen({super.key});

  Future<void> _onSubmit(BuildContext context) async {
    final d = RiderRegistrationData.instance;
    try {
      // upload the photos first, then send the form
      final docs = <Map<String, dynamic>>[];
      Future<void> addDoc(
        String type,
        List<int>? bytes, {
        String? number,
      }) async {
        if (bytes == null && number == null) return;
        final url = bytes == null
            ? null
            : await Api.instance.uploadBytes(
                bytes,
                filename: '${type.toLowerCase()}.jpg',
              );
        docs.add({'type': type, 'documentNumber': number, 'fileUrl': url});
      }

      await addDoc('AADHAAR', d.aadhaarFront);
      await addDoc('DRIVING_LICENSE', d.licenseImage);
      await addDoc('PROFILE_PHOTO', d.selfie);
      await addDoc(
        'INSURANCE',
        null,
        number: d.policyNumber.isEmpty ? null : d.policyNumber,
      );

      await RiderApi.instance.register({
        'name': d.fullName,
        'email': d.email,
        'vehicleType': d.vehicleType,
        'vehicleNumber': d.vehicleNumber,
        'insuranceValidTill': d.expiryDate,
        'bankAccountNumber': d.accountNumber,
        'bankIfsc': d.ifscCode,
        'deliveryZone': d.deliveryZone,
        'documents': docs,
      });
    } on ApiException catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
      return;
    }
    if (!context.mounted) return;
    Navigator.of(context).pushReplacementNamed(RouteNames.riderUnderReview);
  }

  @override
  Widget build(BuildContext context) {
    final data = RiderRegistrationData.instance;

    return RegistrationScaffold(
      currentStep: 9,
      title: 'Review Details',
      subtitle: 'Please review your details',
      buttonLabel: 'Submit',
      onButtonPressed: () => _onSubmit(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          border: Border.all(color: AppColors.divider),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ReviewRow(
              icon: Icons.person_outline,
              label: 'Name',
              value: data.fullName,
            ),
            _ReviewRow(
              icon: Icons.phone_outlined,
              label: 'Mobile',
              value: '+91 ${data.mobileNumber}',
            ),
            _ReviewRow(
              icon: Icons.email_outlined,
              label: 'Email',
              value: data.email,
            ),
            _ReviewRow(
              icon: Icons.location_on_outlined,
              label: 'Delivery Zone',
              value: data.deliveryZone,
            ),
            _ReviewRow(
              icon: Icons.two_wheeler_outlined,
              label: 'Vehicle Type',
              value: '${data.vehicleType} · ${data.vehicleNumber}',
            ),
            _ReviewRow(
              icon: Icons.shield_outlined,
              label: 'Insurance',
              value: '${data.insuranceProvider} · Exp ${data.expiryDate}',
            ),
            _ReviewRow(
              icon: Icons.account_balance_outlined,
              label: 'Bank Details',
              value: '${data.bankName} · ${_maskAccount(data.accountNumber)}',
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  String _maskAccount(String account) {
    if (account.length <= 4) return account;
    return '••••${account.substring(account.length - 4)}';
  }
}

class _ReviewRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isLast;

  const _ReviewRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value.trim().isEmpty ? '—' : value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
