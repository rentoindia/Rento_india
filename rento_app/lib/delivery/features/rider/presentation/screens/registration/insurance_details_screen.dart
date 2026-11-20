// import 'package:flutter/material.dart';
// import '../../../../../core/routes/route_names.dart';
// import '../../../data/models/rider_registration_data.dart';
// import '../../widgets/registration_scaffold.dart';
// import '../../widgets/registration_text_field.dart';

// /// Rider registration step 6 — Insurance Details.
// class InsuranceDetailsScreen extends StatefulWidget {
//   const InsuranceDetailsScreen({super.key});

//   @override
//   State<InsuranceDetailsScreen> createState() => _InsuranceDetailsScreenState();
// }

// class _InsuranceDetailsScreenState extends State<InsuranceDetailsScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late final _policyController = TextEditingController(
//     text: RiderRegistrationData.instance.policyNumber,
//   );
//   late final _expiryController = TextEditingController(
//     text: RiderRegistrationData.instance.expiryDate,
//   );
//   String? _provider = RiderRegistrationData.instance.insuranceProvider.isEmpty
//       ? null
//       : RiderRegistrationData.instance.insuranceProvider;

//   static const _providers = [
//     'ICICI Lombard',
//     'HDFC Ergo',
//     'Bajaj Allianz',
//     'New India Assurance',
//     'Other',
//   ];

//   @override
//   void dispose() {
//     _policyController.dispose();
//     _expiryController.dispose();
//     super.dispose();
//   }

//   Future<void> _pickExpiryDate() async {
//     final now = DateTime.now();
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: now,
//       firstDate: now,
//       lastDate: DateTime(now.year + 10),
//     );
//     if (picked != null) {
//       _expiryController.text =
//           '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
//     }
//   }

//   void _onContinue() {
//     if (!_formKey.currentState!.validate() || _provider == null) return;

//     RiderRegistrationData.instance
//       ..insuranceProvider = _provider!
//       ..policyNumber = _policyController.text.trim()
//       ..expiryDate = _expiryController.text.trim();

//     Navigator.of(context).pushNamed(RouteNames.riderBankDetails);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RegistrationScaffold(
//       title: 'Insurance Details',
//       subtitle: 'Vehicle insurance information',
//       buttonLabel: 'Continue',
//       onButtonPressed: _onContinue,
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             RegistrationDropdown(
//               label: 'Insurance Provider',
//               hint: 'Select Provider',
//               value: _provider,
//               options: _providers,
//               onChanged: (v) => setState(() => _provider = v),
//             ),
//             RegistrationTextField(
//               label: 'Policy Number',
//               hint: '1234567890',
//               controller: _policyController,
//               validator: (v) => (v == null || v.trim().isEmpty)
//                   ? 'Policy number is required'
//                   : null,
//             ),
//             RegistrationTextField(
//               label: 'Expiry Date',
//               hint: 'DD/MM/YYYY',
//               controller: _expiryController,
//               keyboardType: TextInputType.datetime,
//               validator: (v) => (v == null || v.trim().isEmpty)
//                   ? 'Expiry date is required'
//                   : null,
//             ),
//             Align(
//               alignment: Alignment.centerRight,
//               child: TextButton.icon(
//                 onPressed: _pickExpiryDate,
//                 icon: const Icon(Icons.calendar_today_outlined, size: 16),
//                 label: const Text('Pick date'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../../../core/routes/route_names.dart';
import '../../../data/models/rider_registration_data.dart';
import '../../widgets/registration_scaffold.dart';
import '../../widgets/registration_text_field.dart';

/// Rider registration step 6 — Insurance Details.
class InsuranceDetailsScreen extends StatefulWidget {
  const InsuranceDetailsScreen({super.key});

  @override
  State<InsuranceDetailsScreen> createState() => _InsuranceDetailsScreenState();
}

class _InsuranceDetailsScreenState extends State<InsuranceDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _policyController = TextEditingController(
    text: RiderRegistrationData.instance.policyNumber,
  );
  late final _expiryController = TextEditingController(
    text: RiderRegistrationData.instance.expiryDate,
  );
  String? _provider = RiderRegistrationData.instance.insuranceProvider.isEmpty
      ? null
      : RiderRegistrationData.instance.insuranceProvider;

  static const _providers = [
    'ICICI Lombard',
    'HDFC Ergo',
    'Bajaj Allianz',
    'New India Assurance',
    'Other',
  ];

  @override
  void dispose() {
    _policyController.dispose();
    _expiryController.dispose();
    super.dispose();
  }

  Future<void> _pickExpiryDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 10),
    );
    if (picked != null) {
      _expiryController.text =
          '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
    }
  }

  void _onContinue() {
    if (!_formKey.currentState!.validate() || _provider == null) return;

    RiderRegistrationData.instance
      ..insuranceProvider = _provider!
      ..policyNumber = _policyController.text.trim()
      ..expiryDate = _expiryController.text.trim();

    Navigator.of(context).pushNamed(RouteNames.riderBankDetails);
  }

  @override
  Widget build(BuildContext context) {
    return RegistrationScaffold(
      currentStep: 6,
      title: 'Insurance Details',
      subtitle: 'Vehicle insurance information',
      buttonLabel: 'Continue',
      onButtonPressed: _onContinue,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            RegistrationDropdown(
              label: 'Insurance Provider',
              hint: 'Select Provider',
              value: _provider,
              options: _providers,
              onChanged: (v) => setState(() => _provider = v),
            ),
            RegistrationTextField(
              label: 'Policy Number',
              hint: '1234567890',
              controller: _policyController,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Policy number is required'
                  : null,
            ),
            RegistrationTextField(
              label: 'Expiry Date',
              hint: 'DD/MM/YYYY',
              controller: _expiryController,
              keyboardType: TextInputType.datetime,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Expiry date is required'
                  : null,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: _pickExpiryDate,
                icon: const Icon(Icons.calendar_today_outlined, size: 16),
                label: const Text('Pick date'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
