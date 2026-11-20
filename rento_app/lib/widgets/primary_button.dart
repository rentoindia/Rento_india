// import 'package:flutter/material.dart';

// class PrimaryButton extends StatelessWidget {
//   final String label;
//   final VoidCallback onPressed;
//   final IconData? icon;
//   final bool outlined;

//   const PrimaryButton({
//     super.key,
//     required this.label,
//     required this.onPressed,
//     this.icon,
//     this.outlined = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     if (outlined) {
//       return SizedBox(
//         width: double.infinity,
//         height: 52,
//         child: OutlinedButton(
//           onPressed: onPressed,
//           style: OutlinedButton.styleFrom(
//             side: const BorderSide(color: Colors.black12),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//           child: Text(label,
//               style: const TextStyle(
//                   color: Colors.black, fontWeight: FontWeight.w600)),
//         ),
//       );
//     }
//     return ElevatedButton(
//       onPressed: onPressed,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
//           if (icon != null) ...[
//             const SizedBox(width: 8),
//             Icon(icon, size: 18),
//           ],
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool outlined;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    if (outlined) {
      return SizedBox(
        width: double.infinity,
        height: 52,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.black12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(label,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w600)),
        ),
      );
    }
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          if (icon != null) ...[
            const SizedBox(width: 8),
            Icon(icon, size: 18),
          ],
        ],
      ),
    );
  }
}