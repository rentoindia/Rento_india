import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

// /// Fetches the device's current GPS position and reverse-geocodes it
// /// into a readable address, so the home screen can show it
// /// automatically instead of a manually-picked/hardcoded one.
// class LocationService extends ChangeNotifier {
//   LocationService._();
//   static final LocationService instance = LocationService._();

//   String address = 'Fetching your location...';
//   bool isLoading = true;
//   String? error;

//   Future<void> fetchCurrentLocation() async {
//     isLoading = true;
//     error = null;
//     notifyListeners();

//     try {
//       // 1. Check/request permission.
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//       }
//       if (permission == LocationPermission.denied ||
//           permission == LocationPermission.deniedForever) {
//         error = 'Location permission denied';
//         address = 'Enable location to see your address';
//         isLoading = false;
//         notifyListeners();
//         return;
//       }

//       // 2. Check if location services are even on.
//       final serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         error = 'Location services are off';
//         address = 'Turn on location services';
//         isLoading = false;
//         notifyListeners();
//         return;
//       }

//       // 3. Get current coordinates.
//       final position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       // 4. Reverse-geocode into a readable address.
//       final placemarks = await placemarkFromCoordinates(
//         position.latitude,
//         position.longitude,
//       );

//       if (placemarks.isNotEmpty) {
//         final p = placemarks.first;
//         final parts = [
//           p.subThoroughfare,
//           p.thoroughfare,
//           p.subLocality,
//           p.locality,
//         ].where((part) => part != null && part.trim().isNotEmpty).toList();
//         address = parts.isNotEmpty ? parts.join(', ') : 'Current Location';
//       } else {
//         address = 'Current Location';
//       }
//     } catch (e) {
//       error = e.toString();
//       address = 'Unable to fetch location';
//     }

//     isLoading = false;
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

/// Fetches the device's current GPS position and reverse-geocodes it
/// into a readable address, so the home screen can show it
/// automatically instead of a manually-picked/hardcoded one.
class LocationService extends ChangeNotifier {
  LocationService._();
  static final LocationService instance = LocationService._();

  String address = 'Fetching your location...';
  bool isLoading = true;
  String? error;

  Future<void> fetchCurrentLocation() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      // 1. Check/request permission.
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        error = 'Location permission denied';
        address = 'Enable location to see your address';
        isLoading = false;
        notifyListeners();
        return;
      }

      // 2. Check if location services are even on.
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        error = 'Location services are off';
        address = 'Turn on location services';
        isLoading = false;
        notifyListeners();
        return;
      }

      // 3. Get current coordinates.
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // 4. Reverse-geocode into a readable address.
      final placemarks = await Geocoding().placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        final parts = [
          p.subThoroughfare,
          p.thoroughfare,
          p.subLocality,
          p.locality,
        ].where((part) => part != null && part.trim().isNotEmpty).toList();
        address = parts.isNotEmpty ? parts.join(', ') : 'Current Location';
      } else {
        address = 'Current Location';
      }
    } catch (e) {
      error = e.toString();
      address = 'Unable to fetch location';
    }

    isLoading = false;
    notifyListeners();
  }
}