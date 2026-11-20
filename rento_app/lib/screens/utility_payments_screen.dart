// // import 'package:flutter/material.dart';

// // class UtilityPaymentsScreen extends StatelessWidget {
// //   const UtilityPaymentsScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final utilities = [
// //       {'title': 'Electricity Bill', 'icon': Icons.bolt_outlined},
// //       {'title': 'Water Bill', 'icon': Icons.water_drop_outlined},
// //       {'title': 'Gas Bill', 'icon': Icons.local_fire_department_outlined},
// //       {'title': 'Internet & Cable', 'icon': Icons.wifi},
// //       {'title': 'Maintenance Fee', 'icon': Icons.receipt_long_outlined},
// //     ];
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Pay Rent / Utilities')),
// //       body: ListView.separated(
// //         padding: const EdgeInsets.all(16),
// //         itemCount: utilities.length,
// //         separatorBuilder: (_, __) => const SizedBox(height: 10),
// //         itemBuilder: (context, i) => Container(
// //           decoration: BoxDecoration(
// //             color: Colors.white,
// //             borderRadius: BorderRadius.circular(12),
// //             border: Border.all(color: const Color(0xFFF0F0F0)),
// //           ),
// //           child: ListTile(
// //             leading: Icon(utilities[i]['icon'] as IconData),
// //             title: Text(utilities[i]['title'] as String),
// //             trailing: const Icon(Icons.chevron_right),
// //             onTap: () {
// //               ScaffoldMessenger.of(context).showSnackBar(
// //                 SnackBar(content: Text('Opening ${utilities[i]['title']} payment...')),
// //               );
// //             },
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

























// import 'package:flutter/material.dart';
// import 'package:rento/delivery/core/constants/app_colors.dart';//import '../constants/app_colors.dart';
// import '../constants/app_text_styles.dart';

// class UtilityPaymentsScreen extends StatelessWidget {
//   const UtilityPaymentsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final utilities = [
//       {'title': 'Electricity Bill', 'icon': Icons.bolt_outlined},
//       {'title': 'Water Bill', 'icon': Icons.water_drop_outlined},
//       {'title': 'Gas Bill', 'icon': Icons.local_fire_department_outlined},
//       {'title': 'Internet & Cable', 'icon': Icons.wifi},
//       {'title': 'Maintenance Fee', 'icon': Icons.receipt_long_outlined},
//     ];
//     return Scaffold(
//       appBar: AppBar(title: Text('Pay Rent / Utilities', style: AppText.titleLg)),
//       body: ListView.separated(
//         padding: const EdgeInsets.all(16),
//         itemCount: utilities.length,
//         separatorBuilder: (_, __) => const SizedBox(height: 10),
//         itemBuilder: (context, i) => Container(
//           decoration: BoxDecoration(
//             color: AppColors.pureWhite,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: AppColors.border),
//           ),
//           child: ListTile(
//             leading: Icon(utilities[i]['icon'] as IconData, color: AppColors.textPrimary),
//             title: Text(utilities[i]['title'] as String, style: AppText.titleSm),
//             trailing: const Icon(Icons.chevron_right, color: AppColors.textHint),
//             onTap: () {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Opening ${utilities[i]['title']} payment...')),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class UtilityPaymentsScreen extends StatelessWidget {
  const UtilityPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final utilities = [
      {'title': 'Electricity Bill', 'icon': Icons.bolt_outlined},
      {'title': 'Water Bill', 'icon': Icons.water_drop_outlined},
      {'title': 'Gas Bill', 'icon': Icons.local_fire_department_outlined},
      {'title': 'Internet & Cable', 'icon': Icons.wifi},
      {'title': 'Maintenance Fee', 'icon': Icons.receipt_long_outlined},
    ];
    return Scaffold(
      appBar: AppBar(title: Text('Pay Rent / Utilities', style: AppText.titleLg)),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: utilities.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, i) => Container(
          decoration: BoxDecoration(
            color: AppColors.pureWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: ListTile(
            leading: Icon(utilities[i]['icon'] as IconData, color: AppColors.textPrimary),
            title: Text(utilities[i]['title'] as String, style: AppText.titleSm),
            trailing: const Icon(Icons.chevron_right, color: AppColors.textHint),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Opening ${utilities[i]['title']} payment...')),
              );
            },
          ),
        ),
      ),
    );
  }
}