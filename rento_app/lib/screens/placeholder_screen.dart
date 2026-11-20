// import 'package:flutter/material.dart';

// class PlaceholderScreen extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final String description;
//   final String actionLabel;

//   const PlaceholderScreen({
//     super.key,
//     required this.title,
//     required this.icon,
//     this.description = "There's nothing here yet. Once you have activity, it'll show up on this page.",
//     this.actionLabel = 'Explore Rentals',
//   });

//   static const _purple = Colors.black87;
//   static const _purpleLight = Color(0xFFEFEBFF);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         foregroundColor: Colors.black,
//         title: Text(title,
//             style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: Colors.black)),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(32),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 96,
//                 height: 96,
//                 decoration: const BoxDecoration(color: _purpleLight, shape: BoxShape.circle),
//                 child: Icon(icon, size: 40, color: _purple),
//               ),
//               const SizedBox(height: 20),
//               Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
//               const SizedBox(height: 8),
//               Text(
//                 description,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 1.4),
//               ),
//               const SizedBox(height: 24),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.black,
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//                   ),
//                   child: Text(actionLabel, style: const TextStyle(fontWeight: FontWeight.w700)),
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

class PlaceholderScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;
  final String actionLabel;

  const PlaceholderScreen({
    super.key,
    required this.title,
    required this.icon,
    this.description = "There's nothing here yet. Once you have activity, it'll show up on this page.",
    this.actionLabel = 'Explore Rentals',
  });

  static const _purple = Colors.black87;
  static const _purpleLight = Color(0xFFEFEBFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: Colors.black)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: const BoxDecoration(color: _purpleLight, shape: BoxShape.circle),
                child: Icon(icon, size: 40, color: _purple),
              ),
              const SizedBox(height: 20),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
              const SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text(actionLabel, style: const TextStyle(fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}