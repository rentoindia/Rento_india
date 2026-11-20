// import 'package:flutter/material.dart';
// import 'owner_kyc_theme.dart';
// import 'owner_kyc_selfie_screen.dart';

// /// MYHOUSE OWNER — KYC Screen 1: Aadhaar Verification
// class OwnerKycAadhaarScreen extends StatefulWidget {
//   const OwnerKycAadhaarScreen({super.key});
//   @override
//   State<OwnerKycAadhaarScreen> createState() => _OwnerKycAadhaarScreenState();
// }

// class _OwnerKycAadhaarScreenState extends State<OwnerKycAadhaarScreen> {
//   bool _frontUploaded = false;
//   bool _backUploaded = false;
//   bool get _canContinue => _frontUploaded && _backUploaded;

//   @override
//   Widget build(BuildContext context) {
//     return KycTheme.blockBack(
//       child: Scaffold(
//         backgroundColor: KycTheme.bg,
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(20),
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
//                 const SizedBox(height: 22),
//                 KycTheme.stepDots(0, 7),
//                 const SizedBox(height: 26),
//                 const Text('Aadhaar Verification', style: TextStyle(
//                     fontSize: 21, fontWeight: FontWeight.w700, color: KycTheme.black)),
//                 const SizedBox(height: 4),
//                 const Text('Upload a clear photo of your Aadhaar card',
//                     style: TextStyle(fontSize: 13, color: KycTheme.textGrey)),
//                 const SizedBox(height: 26),
//                 const Text('Front Side', style: TextStyle(
//                     fontSize: 13, fontWeight: FontWeight.w600, color: KycTheme.black)),
//                 const SizedBox(height: 8), 
//                 KycTheme.uploadBox(
//                   label: 'Tap to upload',
//                   uploaded: _frontUploaded,
//                   onTap: () => setState(() => _frontUploaded = true),
//                 ),
//                 const SizedBox(height: 18),
//                 const Text('Back Side', style: TextStyle(
//                     fontSize: 13, fontWeight: FontWeight.w600, color: KycTheme.black)),
//                 const SizedBox(height: 8),
//                 KycTheme.uploadBox(
//                   label: 'Tap to upload',
//                   uploaded: _backUploaded,
//                   onTap: () => setState(() => _backUploaded = true),
//                 ),
//                 const Spacer(),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: KycTheme.primaryButton,
//                     onPressed: _canContinue
//                         ? () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const OwnerKycSelfieScreen(),
//                               ),
//                             );
//                           }
//                         : null,
//                     child: const Text('Continue',
//                         style: TextStyle(color: KycTheme.white)),
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
import 'package:image_picker/image_picker.dart';
import 'owner_kyc_theme.dart';
import 'owner_kyc_selfie_screen.dart';

/// MYHOUSE OWNER — KYC Screen 1: Aadhaar Verification
class OwnerKycAadhaarScreen extends StatefulWidget {
  const OwnerKycAadhaarScreen({super.key});
  @override
  State<OwnerKycAadhaarScreen> createState() => _OwnerKycAadhaarScreenState();
}

class _OwnerKycAadhaarScreenState extends State<OwnerKycAadhaarScreen> {
  XFile? _frontFile;
  XFile? _backFile;
  bool get _canContinue => _frontFile != null && _backFile != null;

  Future<void> _pickFront() async {
    final file = await KycTheme.pickImageSheet(context);
    if (file != null) setState(() => _frontFile = file);
  }

  Future<void> _pickBack() async {
    final file = await KycTheme.pickImageSheet(context);
    if (file != null) setState(() => _backFile = file);
  }

  @override
  Widget build(BuildContext context) {
    return KycTheme.blockBack(
      child: Scaffold(
        backgroundColor: KycTheme.bg,
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
                const SizedBox(height: 22),
                KycTheme.stepDots(0, 7),
                const SizedBox(height: 26),
                const Text('Aadhaar Verification', style: TextStyle(
                    fontSize: 21, fontWeight: FontWeight.w700, color: KycTheme.black)),
                const SizedBox(height: 4),
                const Text('Upload a clear photo of your Aadhaar card',
                    style: TextStyle(fontSize: 13, color: KycTheme.textGrey)),
                const SizedBox(height: 26),
                const Text('Front Side', style: TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600, color: KycTheme.black)),
                const SizedBox(height: 8),
                KycTheme.uploadBox(
                  label: 'Tap to upload',
                  uploaded: _frontFile != null,
                  fileName: _frontFile?.name,
                  onTap: _pickFront,
                ),
                const SizedBox(height: 18),
                const Text('Back Side', style: TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600, color: KycTheme.black)),
                const SizedBox(height: 8),
                KycTheme.uploadBox(
                  label: 'Tap to upload',
                  uploaded: _backFile != null,
                  fileName: _backFile?.name,
                  onTap: _pickBack,
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: KycTheme.primaryButton,
                    onPressed: _canContinue
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OwnerKycSelfieScreen(),
                              ),
                            );
                          }
                        : null,
                    child: const Text('Continue',
                        style: TextStyle(color: KycTheme.white)),
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


