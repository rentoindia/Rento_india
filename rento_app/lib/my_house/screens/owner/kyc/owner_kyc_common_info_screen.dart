// import 'package:flutter/material.dart';
// import 'owner_kyc_theme.dart';
// import 'owner_kyc_address_screen.dart';

// /// MYHOUSE OWNER — KYC Screen 3: Common Information
// class OwnerKycCommonInfoScreen extends StatefulWidget {
//   const OwnerKycCommonInfoScreen({super.key});

//   @override
//   State<OwnerKycCommonInfoScreen> createState() => _OwnerKycCommonInfoScreenState();
// }

// class _OwnerKycCommonInfoScreenState extends State<OwnerKycCommonInfoScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController(text: 'Ramesh Kumar');
//   final _mobileController = TextEditingController(text: '+91 98765 43210');
//   final _emailController = TextEditingController(text: 'ramesh@gmail.com');

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _mobileController.dispose();
//     _emailController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: KycTheme.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Back button
//                 GestureDetector(
//                   onTap: () => Navigator.pop(context),
//                   child: Container(
//                     width: 36,
//                     height: 36,
//                     decoration: BoxDecoration(
//                       color: KycTheme.fillGrey,
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(Icons.arrow_back, size: 18, color: KycTheme.black),
//                   ),
//                 ),
//                 const SizedBox(height: 14),
//                 KycTheme.appHeader('Owner Verification'),
//                 const SizedBox(height: 20),
//                 KycTheme.stepDots(2, 7),
//                 const SizedBox(height: 24),

//                 const Text('Common Information', style: TextStyle(
//                     fontSize: 20, fontWeight: FontWeight.w700, color: KycTheme.black)),
//                 const SizedBox(height: 20),

//                 TextFormField(
//                   controller: _nameController,
//                   decoration: KycTheme.inputDecoration('Full Name'),
//                   validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
//                 ),
//                 const SizedBox(height: 14),
//                 TextFormField(
//                   controller: _mobileController,
//                   keyboardType: TextInputType.phone,
//                   decoration: KycTheme.inputDecoration('Mobile Number'),
//                   validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
//                 ),
//                 const SizedBox(height: 14),
//                 TextFormField(
//                   controller: _emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: KycTheme.inputDecoration('Email Address'),
//                   validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
//                 ),

//                 const Spacer(),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: KycTheme.primaryButton,
//                     onPressed: () {
//                       if (_formKey.currentState?.validate() ?? false) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const OwnerKycAddressScreen(),
//                           ),
//                         );
//                       }
//                     },
//                     child: const Text('Continue',
//                         style: TextStyle(color: KycTheme.white, fontWeight: FontWeight.w600)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'owner_kyc_theme.dart';
import 'owner_kyc_address_screen.dart';

/// MYHOUSE OWNER — KYC Screen 3: Common Information
class OwnerKycCommonInfoScreen extends StatefulWidget {
  const OwnerKycCommonInfoScreen({super.key});

  @override
  State<OwnerKycCommonInfoScreen> createState() => _OwnerKycCommonInfoScreenState();
}

class _OwnerKycCommonInfoScreenState extends State<OwnerKycCommonInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Ramesh Kumar');
  final _mobileController = TextEditingController(text: '+91 98765 43210');
  final _emailController = TextEditingController(text: 'ramesh@gmail.com');

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KycTheme.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: KycTheme.fillGrey,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back, size: 18, color: KycTheme.black),
                  ),
                ),
                const SizedBox(height: 14),
                KycTheme.appHeader('Owner Verification'),
                const SizedBox(height: 20),
                KycTheme.stepDots(2, 7),
                const SizedBox(height: 24),

                const Text('Common Information', style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w700, color: KycTheme.black)),
                const SizedBox(height: 20),

                TextFormField(
                  controller: _nameController,
                  decoration: KycTheme.inputDecoration('Full Name'),
                  validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: KycTheme.inputDecoration('Mobile Number'),
                  validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: KycTheme.inputDecoration('Email Address'),
                  validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
                ),

                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: KycTheme.primaryButton,
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OwnerKycAddressScreen(),
                          ),
                        );
                      }
                    },
                    child: const Text('Continue',
                        style: TextStyle(color: KycTheme.white, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

