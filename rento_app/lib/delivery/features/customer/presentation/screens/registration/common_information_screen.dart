// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../../../../../core/routes/route_names.dart';
// import '../../../../../core/utils/validators.dart';
// import '../../../data/models/customer_registration_data.dart';
// import '../../widgets/registration_scaffold.dart';
// import '../../widgets/registration_text_field.dart';

// /// Customer registration step 2 — Common Information.
// class CommonInformationScreen extends StatefulWidget {
//   const CommonInformationScreen({super.key});

//   @override
//   State<CommonInformationScreen> createState() =>
//       _CommonInformationScreenState();
// }

// class _CommonInformationScreenState extends State<CommonInformationScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late final _nameController = TextEditingController(
//     text: CustomerRegistrationData.instance.fullName,
//   );
//   late final _mobileController = TextEditingController(
//     text: CustomerRegistrationData.instance.mobileNumber,
//   );
//   late final _emailController = TextEditingController(
//     text: CustomerRegistrationData.instance.email,
//   );

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _mobileController.dispose();
//     _emailController.dispose();
//     super.dispose();
//   }

//   void _onContinue() {
//     if (!_formKey.currentState!.validate()) return;

//     CustomerRegistrationData.instance
//       ..fullName = _nameController.text.trim()
//       ..mobileNumber = _mobileController.text.trim()
//       ..email = _emailController.text.trim();

//     Navigator.of(context).pushNamed(RouteNames.customerAddressInfo);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RegistrationScaffold(
//       title: 'Common Information',
//       subtitle: 'Tell us a bit about yourself',
//       currentStep: 1,
//       buttonLabel: 'Continue',
//       onButtonPressed: _onContinue,
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             RegistrationTextField(
//               label: 'Full Name',
//               hint: 'Enter your full name',
//               controller: _nameController,
//               validator: (v) => Validators.required(v, 'Full name'),
//             ),
//             RegistrationTextField(
//               label: 'Mobile Number',
//               hint: '9876543210',
//               controller: _mobileController,
//               keyboardType: TextInputType.phone,
//               inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//               maxLength: 10,
//               validator: Validators.mobile,
//             ),
//             RegistrationTextField(
//               label: 'Email Address',
//               hint: 'ramesh@gmail.com',
//               controller: _emailController,
//               keyboardType: TextInputType.emailAddress,
//               validator: Validators.email,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/routes/route_names.dart';
import '../../../../../core/utils/validators.dart';
import '../../../data/models/customer_registration_data.dart';
import '../../widgets/registration_scaffold.dart';
import '../../widgets/registration_text_field.dart';

/// Customer registration step 2 — Common Information.
class CommonInformationScreen extends StatefulWidget {
  const CommonInformationScreen({super.key});

  @override
  State<CommonInformationScreen> createState() =>
      _CommonInformationScreenState();
}

class _CommonInformationScreenState extends State<CommonInformationScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController(
    text: CustomerRegistrationData.instance.fullName,
  );
  late final _mobileController = TextEditingController(
    text: CustomerRegistrationData.instance.mobileNumber,
  );
  late final _emailController = TextEditingController(
    text: CustomerRegistrationData.instance.email,
  );

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onContinue() {
    if (!_formKey.currentState!.validate()) return;

    CustomerRegistrationData.instance
      ..fullName = _nameController.text.trim()
      ..mobileNumber = _mobileController.text.trim()
      ..email = _emailController.text.trim();

    Navigator.of(context).pushNamed(RouteNames.customerAddressInfo);
  }

  @override
  Widget build(BuildContext context) {
    return RegistrationScaffold(
      title: 'Common Information',
      subtitle: 'Tell us a bit about yourself',
      currentStep: 1,
      buttonLabel: 'Continue',
      onButtonPressed: _onContinue,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'assets/images/rental/verification/clipboard_checklist.png',
                width: 200,
              ),
            ),
            const SizedBox(height: 16),
            RegistrationTextField(
              label: 'Full Name',
              hint: 'Enter your full name',
              controller: _nameController,
              validator: (v) => Validators.required(v, 'Full name'),
            ),
            RegistrationTextField(
              label: 'Mobile Number',
              hint: '9876543210',
              controller: _mobileController,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 10,
              validator: Validators.mobile,
            ),
            RegistrationTextField(
              label: 'Email Address',
              hint: 'ramesh@gmail.com',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: Validators.email,
            ),
          ],
        ),
      ),
    );
  }
}
