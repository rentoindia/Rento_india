// import 'package:flutter/material.dart';

// /// MYHOUSE OWNER — Shared theme for KYC / Verification flow.
// /// STRICTLY monochrome: black, white, grey only. No colour accents.
// /// Polished for a professional, premium look.
// class KycTheme {
//   static const Color black = Color(0xFF0D0D0D);
//   static const Color white = Color(0xFFFFFFFF);
//   static const Color bg = Color(0xFFFAFAFA);
//   static const Color borderGrey = Color(0xFFE4E4E7);
//   static const Color fillGrey = Color(0xFFF4F4F5);
//   static const Color textGrey = Color(0xFF71717A);
//   static const Color placeholderGrey = Color(0xFFA1A1AA);

//   static const List<BoxShadow> cardShadow = [
//     BoxShadow(
//       color: Color(0x0F000000),
//       blurRadius: 16,
//       offset: Offset(0, 4),
//     ),
//   ];

//   static InputDecoration inputDecoration(String label, {String? hint}) {
//     return InputDecoration(
//       labelText: label,
//       hintText: hint,
//       labelStyle: const TextStyle(color: textGrey, fontSize: 13),
//       hintStyle: const TextStyle(color: placeholderGrey, fontSize: 13),
//       filled: true,
//       fillColor: white,
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: const BorderSide(color: borderGrey),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: const BorderSide(color: borderGrey),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: const BorderSide(color: black, width: 1.6),
//       ),
//     );
//   }

//   static ButtonStyle primaryButton = ElevatedButton.styleFrom(
//     backgroundColor: black,
//     disabledBackgroundColor: const Color(0xFFD4D4D8),
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//     elevation: 2,
//     shadowColor: Colors.black26,
//     padding: const EdgeInsets.symmetric(vertical: 17),
//   ).copyWith(
//     textStyle: WidgetStateProperty.all(
//       const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, letterSpacing: 0.3),
//     ),
//   );

//   static Widget appHeader(String subtitle) {
//     return Row(
//       children: [
//         Container(
//           width: 44,
//           height: 44,
//           decoration: BoxDecoration(
//             color: black,
//             borderRadius: BorderRadius.circular(13),
//             boxShadow: cardShadow,
//           ),
//           child: const Center(
//             child: Text('M', style: TextStyle(
//                 color: white, fontWeight: FontWeight.w800, fontSize: 19)),
//           ),
//         ),
//         const SizedBox(width: 13),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text('MYHOUSE',
//                 style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, letterSpacing: 0.6, color: black)),
//             Text(subtitle, style: const TextStyle(fontSize: 11, color: textGrey)),
//           ],
//         ),
//       ],
//     );
//   }

//   /// Step progress dots shown at the top of every KYC screen.
//   static Widget stepDots(int currentStep, int totalSteps) {
//     return Row(
//       children: List.generate(totalSteps, (index) {
//         final bool done = index <= currentStep;
//         return Expanded(
//           child: Container(
//             margin: const EdgeInsets.only(right: 6),
//             height: 5,
//             decoration: BoxDecoration(
//               color: done ? black : borderGrey,
//               borderRadius: BorderRadius.circular(3),
//             ),
//           ),
//         );
//       }),
//     );
//   }

//   static Widget uploadBox({
//     required String label,
//     required VoidCallback onTap,
//     bool uploaded = false,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         width: double.infinity,
//         height: 100,
//         decoration: BoxDecoration(
//           color: uploaded ? black.withOpacity(0.03) : fillGrey,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: uploaded ? black : borderGrey,
//             width: uploaded ? 1.4 : 1,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 38,
//               height: 38,
//               decoration: BoxDecoration(
//                 color: uploaded ? black : white,
//                 shape: BoxShape.circle,
//                 border: uploaded ? null : Border.all(color: borderGrey),
//               ),
//               child: Icon(
//                 uploaded ? Icons.check_rounded : Icons.camera_alt_outlined,
//                 color: uploaded ? white : textGrey,
//                 size: 18,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               uploaded ? 'Uploaded' : label,
//               style: TextStyle(
//                 fontSize: 11.5,
//                 color: uploaded ? black : textGrey,
//                 fontWeight: uploaded ? FontWeight.w600 : FontWeight.normal,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Wraps a screen so the hardware/gesture back action is disabled.
//   /// Use this on every screen in the KYC flow so the user cannot exit
//   /// midway — they can only move forward via the Continue/Submit button.
//   static Widget blockBack({required Widget child}) {
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: child,
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// MYHOUSE OWNER — Shared theme for KYC / Verification flow.
/// STRICTLY monochrome: black, white, grey only. No colour accents.
/// Polished for a professional, premium look.
class KycTheme {
  static const Color black = Color(0xFF0D0D0D);
  static const Color white = Color(0xFFFFFFFF);
  static const Color bg = Color(0xFFFAFAFA);
  static const Color borderGrey = Color(0xFFE4E4E7);
  static const Color fillGrey = Color(0xFFF4F4F5);
  static const Color textGrey = Color(0xFF71717A);
  static const Color placeholderGrey = Color(0xFFA1A1AA);

  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
  ];

  static InputDecoration inputDecoration(String label, {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: const TextStyle(color: textGrey, fontSize: 13),
      hintStyle: const TextStyle(color: placeholderGrey, fontSize: 13),
      filled: true,
      fillColor: white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: borderGrey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: borderGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: black, width: 1.6),
      ),
    );
  }

  static ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: black,
    disabledBackgroundColor: const Color(0xFFD4D4D8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    elevation: 2,
    shadowColor: Colors.black26,
    padding: const EdgeInsets.symmetric(vertical: 17),
  ).copyWith(
    textStyle: WidgetStateProperty.all(
      const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, letterSpacing: 0.3),
    ),
  );

  static Widget appHeader(String subtitle) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: Image.asset(
            'assets/images/my_house/app_logo.png',
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 13),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('MYHOUSE',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, letterSpacing: 0.6, color: black)),
            Text(subtitle, style: const TextStyle(fontSize: 11, color: textGrey)),
          ],
        ),
      ],
    );
  }

  /// Step progress dots shown at the top of every KYC screen.
  static Widget stepDots(int currentStep, int totalSteps) {
    return Row(
      children: List.generate(totalSteps, (index) {
        final bool done = index <= currentStep;
        return Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 6),
            height: 5,
            decoration: BoxDecoration(
              color: done ? black : borderGrey,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        );
      }),
    );
  }

  /// Upload box. When [uploaded] is true and [fileName] is provided,
  /// the picked file's name is shown under the "Uploaded" label.
  static Widget uploadBox({
    required String label,
    required VoidCallback onTap,
    bool uploaded = false,
    String? fileName,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 100),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: uploaded ? black.withOpacity(0.03) : fillGrey,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: uploaded ? black : borderGrey,
            width: uploaded ? 1.4 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: uploaded ? black : white,
                shape: BoxShape.circle,
                border: uploaded ? null : Border.all(color: borderGrey),
              ),
              child: Icon(
                uploaded ? Icons.check_rounded : Icons.camera_alt_outlined,
                color: uploaded ? white : textGrey,
                size: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              uploaded ? 'Uploaded' : label,
              style: TextStyle(
                fontSize: 11.5,
                color: uploaded ? black : textGrey,
                fontWeight: uploaded ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            if (uploaded && fileName != null) ...[
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  fileName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 10.5, color: textGrey),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Shows a Camera / Gallery choice sheet and returns the picked file,
  /// or null if the user cancelled.
  static Future<XFile?> pickImageSheet(BuildContext context) async {
    final picker = ImagePicker();
    return showModalBottomSheet<XFile?>(
      context: context,
      backgroundColor: white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined, color: black),
                title: const Text('Camera'),
                onTap: () async {
                  final file = await picker.pickImage(source: ImageSource.camera);
                  if (sheetContext.mounted) Navigator.pop(sheetContext, file);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined, color: black),
                title: const Text('Gallery'),
                onTap: () async {
                  final file = await picker.pickImage(source: ImageSource.gallery);
                  if (sheetContext.mounted) Navigator.pop(sheetContext, file);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// Wraps a screen so the hardware/gesture back action is disabled.
  /// Use this on every screen in the KYC flow so the user cannot exit
  /// midway — they can only move forward via the Continue/Submit button.
  static Widget blockBack({required Widget child}) {
    return WillPopScope(
      onWillPop: () async => false,
      child: child,
    );
  }
}

