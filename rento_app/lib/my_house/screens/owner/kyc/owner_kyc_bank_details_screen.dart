// import 'package:flutter/material.dart';
// import 'owner_kyc_theme.dart';
// import 'owner_kyc_review_screen.dart';

// /// MYHOUSE OWNER — KYC Screen 6: Bank Details
// class OwnerKycBankDetailsScreen extends StatefulWidget {
//   const OwnerKycBankDetailsScreen({super.key});

//   @override
//   State<OwnerKycBankDetailsScreen> createState() =>
//       _OwnerKycBankDetailsScreenState();
// }

// class _OwnerKycBankDetailsScreenState extends State<OwnerKycBankDetailsScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _bankNameController = TextEditingController(text: 'State Bank of India');
//   final _branchController = TextEditingController(text: 'Anna Nagar');
//   final _accountController = TextEditingController(text: '1234 5678 9010');
//   final _ifscController = TextEditingController(text: 'SBIN0001234');

//   @override
//   void dispose() {
//     _bankNameController.dispose();
//     _branchController.dispose();
//     _accountController.dispose();
//     _ifscController.dispose();
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
//                 KycTheme.stepDots(5, 7),
//                 const SizedBox(height: 24),

//                 const Text('Bank Details', style: TextStyle(
//                     fontSize: 20, fontWeight: FontWeight.w700, color: KycTheme.black)),
//                 const SizedBox(height: 20),

//                 TextFormField(
//                   controller: _bankNameController,
//                   decoration: KycTheme.inputDecoration('Bank Name'),
//                   validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
//                 ),
//                 const SizedBox(height: 14),
//                 TextFormField(
//                   controller: _branchController,
//                   decoration: KycTheme.inputDecoration('Select Branch'),
//                   validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
//                 ),
//                 const SizedBox(height: 14),
//                 TextFormField(
//                   controller: _accountController,
//                   keyboardType: TextInputType.number,
//                   decoration: KycTheme.inputDecoration('Account Number'),
//                   validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
//                 ),
//                 const SizedBox(height: 14),
//                 TextFormField(
//                   controller: _ifscController,
//                   textCapitalization: TextCapitalization.characters,
//                   decoration: KycTheme.inputDecoration('IFSC Code'),
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
//                             builder: (context) => const OwnerKycReviewScreen(),
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
import 'owner_kyc_review_screen.dart';

/// MYHOUSE OWNER — KYC Screen 6: Bank Details
class OwnerKycBankDetailsScreen extends StatefulWidget {
  const OwnerKycBankDetailsScreen({super.key});

  @override
  State<OwnerKycBankDetailsScreen> createState() =>
      _OwnerKycBankDetailsScreenState();
}

class _OwnerKycBankDetailsScreenState extends State<OwnerKycBankDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bankNameController = TextEditingController(text: 'State Bank of India');
  final _branchController = TextEditingController(text: 'Anna Nagar');
  final _accountController = TextEditingController(text: '1234 5678 9010');
  final _ifscController = TextEditingController(text: 'SBIN0001234');

  @override
  void dispose() {
    _bankNameController.dispose();
    _branchController.dispose();
    _accountController.dispose();
    _ifscController.dispose();
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
                KycTheme.stepDots(5, 7),
                const SizedBox(height: 24),

                const Text('Bank Details', style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w700, color: KycTheme.black)),
                const SizedBox(height: 20),

                TextFormField(
                  controller: _bankNameController,
                  decoration: KycTheme.inputDecoration('Bank Name'),
                  validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _branchController,
                  decoration: KycTheme.inputDecoration('Select Branch'),
                  validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _accountController,
                  keyboardType: TextInputType.number,
                  decoration: KycTheme.inputDecoration('Account Number'),
                  validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _ifscController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: KycTheme.inputDecoration('IFSC Code'),
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
                            builder: (context) => const OwnerKycReviewScreen(),
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

