// import 'package:flutter/material.dart';
// import 'owner_kyc_theme.dart';
// import 'owner_kyc_common_info_screen.dart';

// /// MYHOUSE OWNER — KYC Screen 2: Selfie Verification
// class OwnerKycSelfieScreen extends StatefulWidget {
//   const OwnerKycSelfieScreen({super.key});

//   @override
//   State<OwnerKycSelfieScreen> createState() => _OwnerKycSelfieScreenState();
// }

// class _OwnerKycSelfieScreenState extends State<OwnerKycSelfieScreen> {
//   bool _captured = false;

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
//               KycTheme.stepDots(1, 7),
//               const SizedBox(height: 24),

//               const Text('Selfie Verification', style: TextStyle(
//                   fontSize: 20, fontWeight: FontWeight.w700, color: KycTheme.black)),
//               const SizedBox(height: 4),
//               const Text('Take a clear selfie',
//                   style: TextStyle(fontSize: 13, color: KycTheme.textGrey)),

//               const SizedBox(height: 40),
//               Center(
//                 child: GestureDetector(
//                   onTap: () => setState(() => _captured = !_captured),
//                   child: Container(
//                     width: 130,
//                     height: 130,
//                     decoration: BoxDecoration(
//                       color: KycTheme.fillGrey,
//                       shape: BoxShape.circle,
//                       border: Border.all(color: KycTheme.borderGrey),
//                     ),
//                     child: Icon(
//                       _captured ? Icons.check_circle : Icons.person_outline,
//                       size: 54,
//                       color: _captured ? KycTheme.black : KycTheme.placeholderGrey,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Center(
//                 child: TextButton.icon(
//                   onPressed: () => setState(() => _captured = !_captured),
//                   icon: const Icon(Icons.camera_alt_outlined, color: KycTheme.black, size: 18),
//                   label: Text(
//                     _captured ? 'Retake Selfie' : 'Capture Selfie',
//                     style: const TextStyle(color: KycTheme.black, fontWeight: FontWeight.w600),
//                   ),
//                 ),
//               ),

//               const Spacer(),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: KycTheme.primaryButton,
//                   onPressed: _captured
//                       ? () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const OwnerKycCommonInfoScreen(),
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
import 'owner_kyc_common_info_screen.dart';

/// MYHOUSE OWNER — KYC Screen 2: Selfie Verification
class OwnerKycSelfieScreen extends StatefulWidget {
  const OwnerKycSelfieScreen({super.key});

  @override
  State<OwnerKycSelfieScreen> createState() => _OwnerKycSelfieScreenState();
}

class _OwnerKycSelfieScreenState extends State<OwnerKycSelfieScreen> {
  XFile? _selfieFile;
  bool get _captured => _selfieFile != null;

  Future<void> _captureSelfie() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );
    if (file != null) setState(() => _selfieFile = file);
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
              KycTheme.stepDots(1, 7),
              const SizedBox(height: 24),

              const Text('Selfie Verification', style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w700, color: KycTheme.black)),
              const SizedBox(height: 4),
              const Text('Take a clear selfie',
                  style: TextStyle(fontSize: 13, color: KycTheme.textGrey)),

              const SizedBox(height: 40),
              Center(
                child: GestureDetector(
                  onTap: _captureSelfie,
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      color: KycTheme.fillGrey,
                      shape: BoxShape.circle,
                      border: Border.all(color: KycTheme.borderGrey),
                    ),
                    child: Icon(
                      _captured ? Icons.check_circle : Icons.person_outline,
                      size: 54,
                      color: _captured ? KycTheme.black : KycTheme.placeholderGrey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              if (_captured && _selfieFile != null)
                Center(
                  child: Text(
                    _selfieFile!.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11, color: KycTheme.textGrey),
                  ),
                ),
              const SizedBox(height: 8),
              Center(
                child: TextButton.icon(
                  onPressed: _captureSelfie,
                  icon: const Icon(Icons.camera_alt_outlined, color: KycTheme.black, size: 18),
                  label: Text(
                    _captured ? 'Retake Selfie' : 'Capture Selfie',
                    style: const TextStyle(color: KycTheme.black, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: KycTheme.primaryButton,
                  onPressed: _captured
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OwnerKycCommonInfoScreen(),
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



