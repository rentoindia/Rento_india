// import 'package:flutter/material.dart';
// import 'owner_kyc_theme.dart';
// import 'owner_kyc_property_details_screen.dart';

// /// MYHOUSE OWNER — KYC Screen 4: Address Information
// class OwnerKycAddressScreen extends StatefulWidget {
//   const OwnerKycAddressScreen({super.key});

//   @override
//   State<OwnerKycAddressScreen> createState() => _OwnerKycAddressScreenState();
// }

// class _OwnerKycAddressScreenState extends State<OwnerKycAddressScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _line1Controller = TextEditingController(text: '123, Anna Nagar');
//   final _line2Controller = TextEditingController(text: 'Near SRM Avenue');
//   final _cityController = TextEditingController(text: 'Chennai');
//   final _pincodeController = TextEditingController(text: '600040');

//   @override
//   void dispose() {
//     _line1Controller.dispose();
//     _line2Controller.dispose();
//     _cityController.dispose();
//     _pincodeController.dispose();
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
//                 KycTheme.stepDots(3, 7),
//                 const SizedBox(height: 24),

//                 const Text('Address Information', style: TextStyle(
//                     fontSize: 20, fontWeight: FontWeight.w700, color: KycTheme.black)),
//                 const SizedBox(height: 20),

//                 TextFormField(
//                   controller: _line1Controller,
//                   decoration: KycTheme.inputDecoration('Address Line 1'),
//                   validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
//                 ),
//                 const SizedBox(height: 14),
//                 TextFormField(
//                   controller: _line2Controller,
//                   decoration: KycTheme.inputDecoration('Address Line 2 (Optional)'),
//                 ),
//                 const SizedBox(height: 14),
//                 TextFormField(
//                   controller: _cityController,
//                   decoration: KycTheme.inputDecoration('City'),
//                   validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
//                 ),
//                 const SizedBox(height: 14),
//                 TextFormField(
//                   controller: _pincodeController,
//                   keyboardType: TextInputType.number,
//                   decoration: KycTheme.inputDecoration('Pincode'),
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
//                             builder: (context) => const OwnerKycPropertyDetailsScreen(),
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
import 'owner_kyc_property_details_screen.dart';

/// MYHOUSE OWNER — KYC Screen 4: Address Information
class OwnerKycAddressScreen extends StatefulWidget {
  const OwnerKycAddressScreen({super.key});

  @override
  State<OwnerKycAddressScreen> createState() => _OwnerKycAddressScreenState();
}

class _OwnerKycAddressScreenState extends State<OwnerKycAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _line1Controller = TextEditingController(text: '123, Anna Nagar');
  final _line2Controller = TextEditingController(text: 'Near SRM Avenue');
  final _cityController = TextEditingController(text: 'Chennai');
  final _pincodeController = TextEditingController(text: '600040');

  @override
  void dispose() {
    _line1Controller.dispose();
    _line2Controller.dispose();
    _cityController.dispose();
    _pincodeController.dispose();
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
                KycTheme.stepDots(3, 7),
                const SizedBox(height: 24),

                const Text('Address Information', style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w700, color: KycTheme.black)),
                const SizedBox(height: 20),

                TextFormField(
                  controller: _line1Controller,
                  decoration: KycTheme.inputDecoration('Address Line 1'),
                  validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _line2Controller,
                  decoration: KycTheme.inputDecoration('Address Line 2 (Optional)'),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _cityController,
                  decoration: KycTheme.inputDecoration('City'),
                  validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _pincodeController,
                  keyboardType: TextInputType.number,
                  decoration: KycTheme.inputDecoration('Pincode'),
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
                            builder: (context) => const OwnerKycPropertyDetailsScreen(),
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
