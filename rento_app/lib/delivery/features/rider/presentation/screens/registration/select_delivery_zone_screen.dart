// import 'package:flutter/material.dart';
// import '../../../../../core/constants/app_colors.dart';
// import '../../../../../core/routes/route_names.dart';
// import '../../../data/models/rider_registration_data.dart';
// import '../../widgets/registration_scaffold.dart';

// /// Rider registration step 8 — Select Delivery Zone.
// class SelectDeliveryZoneScreen extends StatefulWidget {
//   const SelectDeliveryZoneScreen({super.key});

//   @override
//   State<SelectDeliveryZoneScreen> createState() =>
//       _SelectDeliveryZoneScreenState();
// }

// class _SelectDeliveryZoneScreenState extends State<SelectDeliveryZoneScreen> {
//   static const _zones = [
//     'Anna Nagar',
//     'T. Nagar',
//     'Adyar',
//     'Velachery',
//     'Guindy',
//     'Porur',
//     'Other Areas',
//   ];

//   String? _selectedZone = RiderRegistrationData.instance.deliveryZone.isEmpty
//       ? null
//       : RiderRegistrationData.instance.deliveryZone;

//   void _onSubmit() {
//     if (_selectedZone == null) return;
//     RiderRegistrationData.instance.deliveryZone = _selectedZone!;
//     Navigator.of(context).pushNamed(RouteNames.riderReviewDetails);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RegistrationScaffold(
//       title: 'Select Delivery Zone',
//       subtitle: 'Choose the zones where you want to deliver',
//       buttonLabel: 'Submit',
//       onButtonPressed: _selectedZone != null ? _onSubmit : null,
//       child: Column(
//         children: _zones.map((zone) {
//           final isSelected = zone == _selectedZone;
//           return Padding(
//             padding: const EdgeInsets.only(bottom: 4),
//             child: RadioListTile<String>(
//               value: zone,
//               groupValue: _selectedZone,
//               onChanged: (v) => setState(() => _selectedZone = v),
//               title: Text(
//                 zone,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: isSelected
//                       ? AppColors.textPrimary
//                       : AppColors.textSecondary,
//                 ),
//               ),
//               activeColor: AppColors.pureBlack,
//               contentPadding: EdgeInsets.zero,
//               controlAffinity: ListTileControlAffinity.leading,
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
//import '../../../../../core/constants/app_colors.dart';
import 'package:rento_india/delivery/core/constants/app_colors.dart';
import '../../../../../core/routes/route_names.dart';
import '../../../data/models/rider_registration_data.dart';
import '../../widgets/registration_scaffold.dart';

/// Rider registration step 8 — Select Delivery Zone.
class SelectDeliveryZoneScreen extends StatefulWidget {
  const SelectDeliveryZoneScreen({super.key});

  @override
  State<SelectDeliveryZoneScreen> createState() =>
      _SelectDeliveryZoneScreenState();
}

class _SelectDeliveryZoneScreenState extends State<SelectDeliveryZoneScreen> {
  static const _zones = [
    'Anna Nagar',
    'T. Nagar',
    'Adyar',
    'Velachery',
    'Guindy',
    'Porur',
    'Other Areas',
  ];

  String? _selectedZone = RiderRegistrationData.instance.deliveryZone.isEmpty
      ? null
      : RiderRegistrationData.instance.deliveryZone;

  void _onSubmit() {
    if (_selectedZone == null) return;
    RiderRegistrationData.instance.deliveryZone = _selectedZone!;
    Navigator.of(context).pushNamed(RouteNames.riderReviewDetails);
  }

  @override
  Widget build(BuildContext context) {
    return RegistrationScaffold(
      currentStep: 8,
      title: 'Select Delivery Zone',
      subtitle: 'Choose the zones where you want to deliver',
      buttonLabel: 'Submit',
      onButtonPressed: _selectedZone != null ? _onSubmit : null,
      child: Column(
        children: _zones.map((zone) {
          final isSelected = zone == _selectedZone;
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: RadioListTile<String>(
              value: zone,
              groupValue: _selectedZone,
              onChanged: (v) => setState(() => _selectedZone = v),
              title: Text(
                zone,
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                ),
              ),
              activeColor: AppColors.pureBlack,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
            ),
          );
        }).toList(),
      ),
    );
  }
}
