import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
// import '../../../../../core/constants/app_colors.dart';
// import '../../../../../core/routes/route_names.dart';
// import '../../../../../core/utils/validators.dart';
// import '../../../data/models/customer_registration_data.dart';
// import '../../widgets/registration_scaffold.dart';
// import '../../widgets/registration_text_field.dart';

// /// Customer registration step 3 — Address Information.
// /// Riders/customers can EITHER tap "Use Current Location" to
// /// auto-fill the address fields via GPS + reverse geocoding, OR just
// /// type the address manually — both paths stay fully available, and
// /// the auto-filled fields remain editable afterward.
// class AddressInformationScreen extends StatefulWidget {
//   const AddressInformationScreen({super.key});

//   @override
//   State<AddressInformationScreen> createState() =>
//       _AddressInformationScreenState();
// }

// class _AddressInformationScreenState extends State<AddressInformationScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late final _line1Controller = TextEditingController(
//     text: CustomerRegistrationData.instance.addressLine1,
//   );
//   late final _line2Controller = TextEditingController(
//     text: CustomerRegistrationData.instance.addressLine2,
//   );
//   late final _cityController = TextEditingController(
//     text: CustomerRegistrationData.instance.city,
//   );
//   late final _pincodeController = TextEditingController(
//     text: CustomerRegistrationData.instance.pincode,
//   );

//   bool _isLocating = false;

//   @override
//   void dispose() {
//     _line1Controller.dispose();
//     _line2Controller.dispose();
//     _cityController.dispose();
//     _pincodeController.dispose();
//     super.dispose();
//   }

//   Future<void> _useCurrentLocation() async {
//     setState(() => _isLocating = true);
//     try {
//       // 1. Make sure location services are actually on.
//       final serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         _showMessage('Please turn on location services and try again.');
//         return;
//       }

//       // 2. Check/request permission.
//       var permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           _showMessage('Location permission denied.');
//           return;
//         }
//       }
//       if (permission == LocationPermission.deniedForever) {
//         _showMessage(
//           'Location permission is permanently denied. Please enable it in your device settings.',
//         );
//         return;
//       }

//       // 3. Get the current GPS position.
//       final position = await Geolocator.getCurrentPosition(
//         locationSettings: const LocationSettings(
//           accuracy: LocationAccuracy.high,
//         ),
//       );

//       // 4. Reverse-geocode lat/lng into a readable address.
//       final placemarks = await placemarkFromCoordinates(
//         position.latitude,
//         position.longitude,
//       );
//       if (placemarks.isEmpty) {
//         _showMessage(
//           'Could not determine your address. Please enter it manually.',
//         );
//         return;
//       }

//       final place = placemarks.first;
//       setState(() {
//         _line1Controller.text = [
//           place.subThoroughfare,
//           place.thoroughfare,
//         ].where((s) => s != null && s.isNotEmpty).join(', ');
//         _line2Controller.text = place.subLocality ?? '';
//         _cityController.text = place.locality ?? '';
//         _pincodeController.text = place.postalCode ?? '';
//       });

//       _showMessage(
//         'Address filled from your current location. You can still edit it below.',
//       );
//     } catch (e) {
//       _showMessage(
//         'Could not fetch your location. Please enter your address manually.',
//       );
//     } finally {
//       if (mounted) setState(() => _isLocating = false);
//     }
//   }

//   void _showMessage(String message) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text(message)));
//   }

//   void _onContinue() {
//     if (!_formKey.currentState!.validate()) return;

//     CustomerRegistrationData.instance
//       ..addressLine1 = _line1Controller.text.trim()
//       ..addressLine2 = _line2Controller.text.trim()
//       ..city = _cityController.text.trim()
//       ..pincode = _pincodeController.text.trim();

//     Navigator.of(context).pushNamed(RouteNames.customerReviewDetails);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RegistrationScaffold(
//       title: 'Address Information',
//       subtitle: 'Where should we deliver your rentals?',
//       currentStep: 2,
//       buttonLabel: 'Continue',
//       onButtonPressed: _onContinue,
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Location shortcut — entirely optional, manual typing
//             // below always works whether or not this is used.
//             OutlinedButton.icon(
//               onPressed: _isLocating ? null : _useCurrentLocation,
//               icon: _isLocating
//                   ? const SizedBox(
//                       width: 16,
//                       height: 16,
//                       child: CircularProgressIndicator(strokeWidth: 2),
//                     )
//                   : const Icon(Icons.my_location, size: 18),
//               label: Text(
//                 _isLocating
//                     ? 'Fetching your location…'
//                     : 'Use Current Location',
//               ),
//               style: OutlinedButton.styleFrom(
//                 minimumSize: const Size.fromHeight(48),
//                 side: const BorderSide(color: AppColors.border),
//                 foregroundColor: AppColors.textPrimary,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Row(
//               children: const [
//                 Expanded(child: Divider(color: AppColors.divider)),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 10),
//                   child: Text(
//                     'or enter manually',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: AppColors.textSecondary,
//                     ),
//                   ),
//                 ),
//                 Expanded(child: Divider(color: AppColors.divider)),
//               ],
//             ),
//             const SizedBox(height: 18),
//             RegistrationTextField(
//               label: 'Address Line 1',
//               hint: '123, Anna Nagar',
//               controller: _line1Controller,
//               validator: (v) => Validators.required(v, 'Address Line 1'),
//             ),
//             RegistrationTextField(
//               label: 'Address Line 2',
//               hint: 'Near 5th Avenue',
//               controller: _line2Controller,
//               optional: true,
//             ),
//             RegistrationTextField(
//               label: 'City',
//               hint: 'Chennai',
//               controller: _cityController,
//               validator: (v) => Validators.required(v, 'City'),
//             ),
//             RegistrationTextField(
//               label: 'Pincode',
//               hint: '600040',
//               controller: _pincodeController,
//               keyboardType: TextInputType.number,
//               maxLength: 6,
//               validator: Validators.pincode,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
//mport '../../../../../core/constants/app_colors.dart';
import 'package:rento_india/delivery/core/constants/app_colors.dart';
import '../../../../../core/routes/route_names.dart';
import '../../../../../core/utils/validators.dart';
import '../../../data/models/customer_registration_data.dart';
import '../../widgets/registration_scaffold.dart';
import '../../widgets/registration_text_field.dart';

/// Customer registration step 3 — Address Information.
/// Riders/customers can EITHER tap "Use Current Location" to
/// auto-fill the address fields via GPS + reverse geocoding, OR just
/// type the address manually — both paths stay fully available, and
/// the auto-filled fields remain editable afterward.
class AddressInformationScreen extends StatefulWidget {
  const AddressInformationScreen({super.key});

  @override
  State<AddressInformationScreen> createState() =>
      _AddressInformationScreenState();
}

class _AddressInformationScreenState extends State<AddressInformationScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _line1Controller = TextEditingController(
    text: CustomerRegistrationData.instance.addressLine1,
  );
  late final _line2Controller = TextEditingController(
    text: CustomerRegistrationData.instance.addressLine2,
  );
  late final _cityController = TextEditingController(
    text: CustomerRegistrationData.instance.city,
  );
  late final _pincodeController = TextEditingController(
    text: CustomerRegistrationData.instance.pincode,
  );

  bool _isLocating = false;

  @override
  void dispose() {
    _line1Controller.dispose();
    _line2Controller.dispose();
    _cityController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  Future<void> _useCurrentLocation() async {
    setState(() => _isLocating = true);
    try {
      // 1. Make sure location services are actually on.
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showMessage('Please turn on location services and try again.');
        return;
      }

      // 2. Check/request permission.
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showMessage('Location permission denied.');
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        _showMessage(
          'Location permission is permanently denied. Please enable it in your device settings.',
        );
        return;
      }

      // 3. Get the current GPS position.
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      // 4. Reverse-geocode lat/lng into a readable address.
      final placemarks = await Geocoding().placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isEmpty) {
        _showMessage(
          'Could not determine your address. Please enter it manually.',
        );
        return;
      }

      final place = placemarks.first;
      setState(() {
        _line1Controller.text = [
          place.subThoroughfare,
          place.thoroughfare,
        ].where((s) => s != null && s.isNotEmpty).join(', ');
        _line2Controller.text = place.subLocality ?? '';
        _cityController.text = place.locality ?? '';
        _pincodeController.text = place.postalCode ?? '';
      });

      _showMessage(
        'Address filled from your current location. You can still edit it below.',
      );
    } catch (e) {
      _showMessage(
        'Could not fetch your location. Please enter your address manually.',
      );
    } finally {
      if (mounted) setState(() => _isLocating = false);
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _onContinue() {
    if (!_formKey.currentState!.validate()) return;

    CustomerRegistrationData.instance
      ..addressLine1 = _line1Controller.text.trim()
      ..addressLine2 = _line2Controller.text.trim()
      ..city = _cityController.text.trim()
      ..pincode = _pincodeController.text.trim();

    Navigator.of(context).pushNamed(RouteNames.customerReviewDetails);
  }

  @override
  Widget build(BuildContext context) {
    return RegistrationScaffold(
      title: 'Address Information',
      subtitle: 'Where should we deliver your rentals?',
      currentStep: 2,
      buttonLabel: 'Continue',
      onButtonPressed: _onContinue,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/rental/verification/location_pin.png',
                width: 200,
              ),
            ),
            const SizedBox(height: 16),
            // Location shortcut — entirely optional, manual typing
            // below always works whether or not this is used.
            OutlinedButton.icon(
              onPressed: _isLocating ? null : _useCurrentLocation,
              icon: _isLocating
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.my_location, size: 18),
              label: Text(
                _isLocating
                    ? 'Fetching your location…'
                    : 'Use Current Location',
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                side: const BorderSide(color: AppColors.border),
                foregroundColor: AppColors.textPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Expanded(child: Divider(color: AppColors.divider)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'or enter manually',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: AppColors.divider)),
              ],
            ),
            const SizedBox(height: 18),
            RegistrationTextField(
              label: 'Address Line 1',
              hint: '123, Anna Nagar',
              controller: _line1Controller,
              validator: (v) => Validators.required(v, 'Address Line 1'),
            ),
            RegistrationTextField(
              label: 'Address Line 2',
              hint: 'Near 5th Avenue',
              controller: _line2Controller,
              optional: true,
            ),
            RegistrationTextField(
              label: 'City',
              hint: 'Chennai',
              controller: _cityController,
              validator: (v) => Validators.required(v, 'City'),
            ),
            RegistrationTextField(
              label: 'Pincode',
              hint: '600040',
              controller: _pincodeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              validator: Validators.pincode,
            ),
          ],
        ),
      ),
    );
  }
}
