// import 'package:flutter/material.dart';

// class AboutAppScreen extends StatelessWidget {
//   const AboutAppScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         foregroundColor: Colors.black,
//         title: const Text('About App',
//             style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: Colors.black)),
//       ),
//       body: SafeArea(
//         child: ListView(
//           padding: const EdgeInsets.all(24),
//           children: [
//             Center(
//               child: Column(
//                 children: [
//                   Container(
//                     width: 72,
//                     height: 72,
//                     decoration: BoxDecoration(
//                       color: Colors.black,
//                       borderRadius: BorderRadius.circular(18),
//                     ),
//                     child: const Icon(Icons.home_work_outlined, color: Colors.white, size: 34),
//                   ),
//                   const SizedBox(height: 14),
//                   const Text('RENTO',
//                       style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22, letterSpacing: 2)),
//                   const SizedBox(height: 4),
//                   Text('Version 1.0.0', style: TextStyle(color: Colors.grey.shade600, fontSize: 12.5)),
//                   const SizedBox(height: 10),
//                   Text('"Why own it, when you can Rento it?"',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           color: Colors.grey.shade600, fontSize: 13, fontStyle: FontStyle.italic)),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 32),
//             _infoTile(Icons.description_outlined, 'Terms & Conditions'),
//             _infoTile(Icons.privacy_tip_outlined, 'Privacy Policy'),
//             _infoTile(Icons.gavel_outlined, 'Licenses'),
//             _infoTile(Icons.mail_outline, 'Contact Us'),
//             const SizedBox(height: 24),
//             Center(
//               child: Text('© 2026 Rento India. All rights reserved.',
//                   style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _infoTile(IconData icon, String title) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: const Color(0xFFF0F0F0)),
//       ),
//       child: ListTile(
//         leading: Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: const Color(0xFFF3F4F6),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Icon(icon, color: Colors.black87, size: 18),
//         ),
//         title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5)),
//         trailing: const Icon(Icons.chevron_right, color: Colors.grey),
//         onTap: () {},
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text('About App',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: Colors.black)),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(Icons.home_work_outlined, color: Colors.white, size: 34),
                  ),
                  const SizedBox(height: 14),
                  const Text('RENTO',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22, letterSpacing: 2)),
                  const SizedBox(height: 4),
                  Text('Version 1.0.0', style: TextStyle(color: Colors.grey.shade600, fontSize: 12.5)),
                  const SizedBox(height: 10),
                  Text('"Why own it, when you can Rento it?"',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey.shade600, fontSize: 13, fontStyle: FontStyle.italic)),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _infoTile(Icons.description_outlined, 'Terms & Conditions'),
            _infoTile(Icons.privacy_tip_outlined, 'Privacy Policy'),
            _infoTile(Icons.gavel_outlined, 'Licenses'),
            _infoTile(Icons.mail_outline, 'Contact Us'),
            const SizedBox(height: 24),
            Center(
              child: Text('© 2026 Rento India. All rights reserved.',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.black87, size: 18),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}