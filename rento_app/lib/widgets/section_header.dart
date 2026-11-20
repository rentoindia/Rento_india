// import 'package:flutter/material.dart';

// class SectionHeader extends StatelessWidget {
//   final String title;
//   final String? subtitle;
//   final VoidCallback? onSeeAll;

//   const SectionHeader({
//     super.key,
//     required this.title,
//     this.subtitle,
//     this.onSeeAll,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(title,
//                   style:
//                       const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
//               if (subtitle != null) ...[
//                 const SizedBox(height: 2),
//                 Text(subtitle!,
//                     style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
//               ],
//             ],
//           ),
//         ),
//         if (onSeeAll != null)
//           GestureDetector(
//             onTap: onSeeAll,
//             child: const Text('See all',
//                 style: TextStyle(
//                     color: Color(0xFF5B4FE5),
//                     fontWeight: FontWeight.w600,
//                     fontSize: 13)),
//           ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onSeeAll;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style:
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(subtitle!,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
              ],
            ],
          ),
        ),
        if (onSeeAll != null)
          GestureDetector(
            onTap: onSeeAll,
            child: const Text('See all',
                style: TextStyle(
                    color: Color(0xFF5B4FE5),
                    fontWeight: FontWeight.w600,
                    fontSize: 13)),
          ),
      ],
    );
  }
}