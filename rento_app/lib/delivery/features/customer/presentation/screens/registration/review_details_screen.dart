// import 'package:flutter/material.dart';
// import '../../../../../core/constants/app_colors.dart';
// import '../../../../../core/routes/route_names.dart';
// import '../../../data/models/customer_registration_data.dart';
// import '../../widgets/registration_scaffold.dart';

// /// Customer registration step 4 — Review Details.
// class ReviewDetailsScreen extends StatelessWidget {
//   const ReviewDetailsScreen({super.key});

//   void _onSubmit(BuildContext context) {
//     // TODO: call CustomerRepository.submitRegistration(CustomerRegistrationData.instance)
//     Navigator.of(context).pushReplacementNamed(RouteNames.customerUnderReview);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final data = CustomerRegistrationData.instance;
//     final fullAddress = [
//       data.addressLine1,
//       data.addressLine2,
//       data.city,
//       data.pincode,
//     ].where((s) => s.trim().isNotEmpty).join(', ');

//     return RegistrationScaffold(
//       title: 'Review Details',
//       subtitle: 'Please review your details',
//       currentStep: 3,
//       buttonLabel: 'Submit',
//       onButtonPressed: () => _onSubmit(context),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: AppColors.pureWhite,
//           border: Border.all(color: AppColors.divider),
//           borderRadius: BorderRadius.circular(14),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _ReviewRow(
//               icon: Icons.person_outline,
//               label: 'Name',
//               value: data.fullName,
//             ),
//             _ReviewRow(
//               icon: Icons.phone_outlined,
//               label: 'Mobile',
//               value: '+91 ${data.mobileNumber}',
//             ),
//             _ReviewRow(
//               icon: Icons.email_outlined,
//               label: 'Email',
//               value: data.email,
//             ),
//             _ReviewRow(
//               icon: Icons.location_on_outlined,
//               label: 'Address',
//               value: fullAddress,
//               isLast: true,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _ReviewRow extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String value;
//   final bool isLast;

//   const _ReviewRow({
//     required this.icon,
//     required this.label,
//     required this.value,
//     this.isLast = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, size: 18, color: AppColors.textSecondary),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: const TextStyle(
//                     fontSize: 11,
//                     color: AppColors.textSecondary,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   value.trim().isEmpty ? '—' : value,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
//import '../../../../../core/constants/app_colors.dart';
import 'package:rento_india/delivery/core/constants/app_colors.dart';
import '../../../../../core/routes/route_names.dart';
import '../../../data/models/customer_registration_data.dart';
import '../../widgets/registration_scaffold.dart';

/// Customer registration step 4 — Review Details.
class ReviewDetailsScreen extends StatelessWidget {
  const ReviewDetailsScreen({super.key});

  void _onSubmit(BuildContext context) {
    // TODO: call CustomerRepository.submitRegistration(CustomerRegistrationData.instance)
    Navigator.of(context).pushReplacementNamed(RouteNames.customerUnderReview);
  }

  @override
  Widget build(BuildContext context) {
    final data = CustomerRegistrationData.instance;
    final fullAddress = [
      data.addressLine1,
      data.addressLine2,
      data.city,
      data.pincode,
    ].where((s) => s.trim().isNotEmpty).join(', ');

    return RegistrationScaffold(
      title: 'Review Details',
      subtitle: 'Please review your details',
      currentStep: 3,
      buttonLabel: 'Submit',
      onButtonPressed: () => _onSubmit(context),
      child: Column(
        children: [
          Center(
            child: Image.asset(
              'assets/images/rental/verification/magnifying_docs.png',
              width: 200,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              border: Border.all(color: AppColors.divider),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ReviewRow(
                  icon: Icons.person_outline,
                  label: 'Name',
                  value: data.fullName,
                ),
                _ReviewRow(
                  icon: Icons.phone_outlined,
                  label: 'Mobile',
                  value: '+91 ${data.mobileNumber}',
                ),
                _ReviewRow(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: data.email,
                ),
                _ReviewRow(
                  icon: Icons.location_on_outlined,
                  label: 'Address',
                  value: fullAddress,
                  isLast: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isLast;

  const _ReviewRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value.trim().isEmpty ? '—' : value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
