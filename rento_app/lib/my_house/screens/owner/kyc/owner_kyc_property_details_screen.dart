// import 'package:flutter/material.dart';
// import 'owner_kyc_theme.dart';
// import 'owner_kyc_bank_details_screen.dart';

// /// MYHOUSE OWNER — KYC Screen 5: Property Details
// class OwnerKycPropertyDetailsScreen extends StatefulWidget {
//   const OwnerKycPropertyDetailsScreen({super.key});

//   @override
//   State<OwnerKycPropertyDetailsScreen> createState() =>
//       _OwnerKycPropertyDetailsScreenState();
// }

// class _OwnerKycPropertyDetailsScreenState
//     extends State<OwnerKycPropertyDetailsScreen> {
//   String _propertyType = 'House';
//   bool _proofUploaded = false;

//   final List<String> _types = ['House', 'Apartment', 'Villa', 'PG / Hostel'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: KycTheme.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Back button
//               GestureDetector(
//                 onTap: () => Navigator.pop(context),
//                 child: Container(
//                   width: 36,
//                   height: 36,
//                   decoration: BoxDecoration(
//                     color: KycTheme.fillGrey,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(Icons.arrow_back, size: 18, color: KycTheme.black),
//                 ),
//               ),
//               const SizedBox(height: 14),
//               KycTheme.appHeader('Owner Verification'),
//               const SizedBox(height: 20),
//               KycTheme.stepDots(4, 7),
//               const SizedBox(height: 24),

//               const Text('Property Details', style: TextStyle(
//                   fontSize: 20, fontWeight: FontWeight.w700, color: KycTheme.black)),
//               const SizedBox(height: 20),

//               const Text('Property Type', style: TextStyle(
//                   fontSize: 13, fontWeight: FontWeight.w600, color: KycTheme.black)),
//               const SizedBox(height: 8),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 14),
//                 decoration: BoxDecoration(
//                   color: KycTheme.white,
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: KycTheme.borderGrey),
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton<String>(
//                     value: _propertyType,
//                     isExpanded: true,
//                     icon: const Icon(Icons.keyboard_arrow_down, color: KycTheme.black),
//                     style: const TextStyle(color: KycTheme.black, fontSize: 14),
//                     items: _types
//                         .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                         .toList(),
//                     onChanged: (v) => setState(() => _propertyType = v!),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               const Text('Ownership Proof', style: TextStyle(
//                   fontSize: 13, fontWeight: FontWeight.w600, color: KycTheme.black)),
//               const SizedBox(height: 8),
//               KycTheme.uploadBox(
//                 label: 'Tap to upload',
//                 uploaded: _proofUploaded,
//                 onTap: () => setState(() => _proofUploaded = true),
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 'Accepted: Sale Deed / Patta / Tax Receipt',
//                 style: TextStyle(fontSize: 11, color: KycTheme.textGrey),
//               ),

//               const Spacer(),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: KycTheme.primaryButton,
//                   onPressed: _proofUploaded
//                       ? () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const OwnerKycBankDetailsScreen(),
//                             ),
//                           );
//                         }
//                       : null,
//                   child: const Text('Continue',
//                       style: TextStyle(color: KycTheme.white, fontWeight: FontWeight.w600)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'owner_kyc_theme.dart';
import 'owner_kyc_bank_details_screen.dart';

/// MYHOUSE OWNER — KYC Screen 5: Property Details
class OwnerKycPropertyDetailsScreen extends StatefulWidget {
  const OwnerKycPropertyDetailsScreen({super.key});

  @override
  State<OwnerKycPropertyDetailsScreen> createState() =>
      _OwnerKycPropertyDetailsScreenState();
}

class _OwnerKycPropertyDetailsScreenState
    extends State<OwnerKycPropertyDetailsScreen> {
  String _propertyType = 'House';
  XFile? _proofFile;

  final List<String> _types = ['House', 'Apartment', 'Villa', 'PG / Hostel'];

  Future<void> _pickProof() async {
    final file = await KycTheme.pickImageSheet(context);
    if (file != null) setState(() => _proofFile = file);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KycTheme.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: KycTheme.fillGrey,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back, size: 18, color: KycTheme.black),
                ),
              ),
              const SizedBox(height: 14),
              KycTheme.appHeader('Owner Verification'),
              const SizedBox(height: 20),
              KycTheme.stepDots(4, 7),
              const SizedBox(height: 24),

              const Text('Property Details', style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w700, color: KycTheme.black)),
              const SizedBox(height: 20),

              const Text('Property Type', style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w600, color: KycTheme.black)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: KycTheme.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: KycTheme.borderGrey),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _propertyType,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down, color: KycTheme.black),
                    style: const TextStyle(color: KycTheme.black, fontSize: 14),
                    items: _types
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) => setState(() => _propertyType = v!),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const Text('Ownership Proof', style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w600, color: KycTheme.black)),
              const SizedBox(height: 8),
              KycTheme.uploadBox(
                label: 'Tap to upload',
                uploaded: _proofFile != null,
                fileName: _proofFile?.name,
                onTap: _pickProof,
              ),
              const SizedBox(height: 8),
              const Text(
                'Accepted: Sale Deed / Patta / Tax Receipt',
                style: TextStyle(fontSize: 11, color: KycTheme.textGrey),
              ),

              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: KycTheme.primaryButton,
                  onPressed: _proofFile != null
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OwnerKycBankDetailsScreen(),
                            ),
                          );
                        }
                      : null,
                  child: const Text('Continue',
                      style: TextStyle(color: KycTheme.white, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


