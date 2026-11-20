// import 'package:flutter/material.dart';
// import '../../../../../core/routes/route_names.dart';
// import '../../../data/models/rider_registration_data.dart';
// import '../../widgets/registration_scaffold.dart';
// import '../../widgets/registration_text_field.dart';

// /// Rider registration step 7 — Bank Details.
// class BankDetailsScreen extends StatefulWidget {
//   const BankDetailsScreen({super.key});

//   @override
//   State<BankDetailsScreen> createState() => _BankDetailsScreenState();
// }

// class _BankDetailsScreenState extends State<BankDetailsScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late final _accountController = TextEditingController(
//     text: RiderRegistrationData.instance.accountNumber,
//   );
//   late final _ifscController = TextEditingController(
//     text: RiderRegistrationData.instance.ifscCode,
//   );
//   String? _bankName = RiderRegistrationData.instance.bankName.isEmpty
//       ? null
//       : RiderRegistrationData.instance.bankName;

//   static const _banks = [
//     'State Bank of India',
//     'HDFC Bank',
//     'ICICI Bank',
//     'Axis Bank',
//     'Punjab National Bank',
//     'Other',
//   ];

//   @override
//   void dispose() {
//     _accountController.dispose();
//     _ifscController.dispose();
//     super.dispose();
//   }

//   void _onContinue() {
//     if (!_formKey.currentState!.validate() || _bankName == null) return;

//     RiderRegistrationData.instance
//       ..bankName = _bankName!
//       ..accountNumber = _accountController.text.trim()
//       ..ifscCode = _ifscController.text.trim();

//     Navigator.of(context).pushNamed(RouteNames.riderDeliveryZone);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RegistrationScaffold(
//       title: 'Bank Details',
//       subtitle: 'Where should we send your earnings?',
//       buttonLabel: 'Continue',
//       onButtonPressed: _onContinue,
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             RegistrationDropdown(
//               label: 'Bank Name',
//               hint: 'Select Bank',
//               value: _bankName,
//               options: _banks,
//               onChanged: (v) => setState(() => _bankName = v),
//             ),
//             RegistrationTextField(
//               label: 'Account Number',
//               hint: '1234 5678 9012',
//               controller: _accountController,
//               keyboardType: TextInputType.number,
//               validator: (v) => (v == null || v.trim().length < 6)
//                   ? 'Enter a valid account number'
//                   : null,
//             ),
//             RegistrationTextField(
//               label: 'IFSC Code',
//               hint: 'SBIN0001234',
//               controller: _ifscController,
//               validator: (v) => (v == null || v.trim().length < 8)
//                   ? 'Enter a valid IFSC code'
//                   : null,
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

/// Rider registration step 7 — Bank Details.
class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({super.key});

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _accountController = TextEditingController(
    text: RiderRegistrationData.instance.accountNumber,
  );
  late final _ifscController = TextEditingController(
    text: RiderRegistrationData.instance.ifscCode,
  );
  String? _bankName = RiderRegistrationData.instance.bankName.isEmpty
      ? null
      : RiderRegistrationData.instance.bankName;

  static const _banks = [
    'State Bank of India',
    'HDFC Bank',
    'ICICI Bank',
    'Axis Bank',
    'Punjab National Bank',
    'Other',
  ];

  @override
  void dispose() {
    _accountController.dispose();
    _ifscController.dispose();
    super.dispose();
  }

  void _onContinue() {
    if (!_formKey.currentState!.validate() || _bankName == null) return;

    RiderRegistrationData.instance
      ..bankName = _bankName!
      ..accountNumber = _accountController.text.trim()
      ..ifscCode = _ifscController.text.trim();

    Navigator.of(context).pushNamed(RouteNames.riderDeliveryZone);
  }

  @override
  Widget build(BuildContext context) {
    return RegistrationScaffold(
      currentStep: 7,
      title: 'Bank Details',
      subtitle: 'Where should we send your earnings?',
      buttonLabel: 'Continue',
      onButtonPressed: _onContinue,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            RegistrationDropdown(
              label: 'Bank Name',
              hint: 'Select Bank',
              value: _bankName,
              options: _banks,
              onChanged: (v) => setState(() => _bankName = v),
            ),
            RegistrationTextField(
              label: 'Account Number',
              hint: '1234 5678 9012',
              controller: _accountController,
              keyboardType: TextInputType.number,
              validator: (v) => (v == null || v.trim().length < 6)
                  ? 'Enter a valid account number'
                  : null,
            ),
            RegistrationTextField(
              label: 'IFSC Code',
              hint: 'SBIN0001234',
              controller: _ifscController,
              validator: (v) => (v == null || v.trim().length < 8)
                  ? 'Enter a valid IFSC code'
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
