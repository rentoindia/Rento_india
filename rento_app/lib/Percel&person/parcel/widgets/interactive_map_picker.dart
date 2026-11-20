import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// A live, draggable Google Map used to pin-point the exact pickup spot.
/// The pin is fixed at the center of the widget; as the user pans the map
/// underneath it, the camera's resting position (`onCameraIdle`) is
/// reverse-geocoded into a human-readable address via [onLocationResolved].
class InteractiveMapPicker extends StatefulWidget {
  const InteractiveMapPicker({
    super.key,
    required this.onLocationResolved,
    this.initialLatitude,
    this.initialLongitude,
    this.height = 260,
  });

  final void Function(double latitude, double longitude, String address)
  onLocationResolved;
  final double? initialLatitude;
  final double? initialLongitude;
  final double height;

  @override
  State<InteractiveMapPicker> createState() => InteractiveMapPickerState();
}

class InteractiveMapPickerState extends State<InteractiveMapPicker> {
  GoogleMapController? _controller;
  late LatLng _center;
  bool _resolving = false;
  bool _locating = false;
  String? _error;

  // Anna Nagar, Chennai — used only if no initial coordinates are supplied.
  static const _fallback = LatLng(13.0843, 80.2705);

  @override
  void initState() {
    super.initState();
    _center = LatLng(
      widget.initialLatitude ?? _fallback.latitude,
      widget.initialLongitude ?? _fallback.longitude,
    );
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _reverseGeocode(_center),
    );
  }

  Future<void> _reverseGeocode(LatLng position) async {
    if (!mounted) return;
    setState(() => _resolving = true);
    try {
      final placemarks = await geocoding.Geocoding().placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (!mounted) return;
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        final parts = <String?>[
          p.name,
          p.subLocality,
          p.locality,
          p.administrativeArea,
          p.postalCode,
        ].where((s) => s != null && s.trim().isNotEmpty).toSet().join(', ');
        widget.onLocationResolved(position.latitude, position.longitude, parts);
      }
    } catch (_) {
      // Reverse geocoding can legitimately fail (no network, no results for
      // this point) — keep whatever address is already showing rather than
      // surfacing a hard error for something this transient.
    } finally {
      if (mounted) setState(() => _resolving = false);
    }
  }

  /// Moves the map to a known location (e.g. a saved address) and
  /// re-resolves its address.
  Future<void> moveTo(double latitude, double longitude) async {
    final target = LatLng(latitude, longitude);
    setState(() => _center = target);
    await _controller?.animateCamera(CameraUpdate.newLatLngZoom(target, 17));
    await _reverseGeocode(target);
  }

  /// Fetches the device's current GPS position (handling permissions) and
  /// moves the map there.
  Future<void> useCurrentLocation() async {
    setState(() {
      _locating = true;
      _error = null;
    });
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        throw 'Turn on location services to use GPS.';
      }
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw 'Location permission is required to use GPS.';
      }
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      await moveTo(position.latitude, position.longitude);
    } catch (e) {
      if (mounted) {
        setState(
          () => _error = e is String ? e : 'Could not fetch your location.',
        );
      }
    } finally {
      if (mounted) setState(() => _locating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: widget.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(target: _center, zoom: 16),
              onMapCreated: (c) => _controller = c,
              onCameraMove: (position) => _center = position.target,
              onCameraIdle: () => _reverseGeocode(_center),
              myLocationButtonEnabled: false,
              myLocationEnabled: false,
              zoomControlsEnabled: true,
              compassEnabled: false,
              mapToolbarEnabled: false,
            ),
            // The pin never moves — the map pans underneath it, so its
            // screen position always represents the map's center point.
            IgnorePointer(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 28),
                child: Icon(
                  Icons.location_on,
                  size: 40,
                  color: AppColors.black,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 12,
              bottom: 64,
              child: _RoundIconButton(
                icon: Icons.my_location,
                loading: _locating,
                onTap: useCurrentLocation,
              ),
            ),
            Positioned(bottom: 14, child: _MovePinPill(resolving: _resolving)),
            if (_error != null)
              Positioned(
                top: 12,
                left: 12,
                right: 12,
                child: _ErrorBanner(
                  message: _error!,
                  onDismiss: () => setState(() => _error = null),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MovePinPill extends StatelessWidget {
  const _MovePinPill({required this.resolving});

  final bool resolving;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (resolving)
            const SizedBox(
              height: 12,
              width: 12,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(AppColors.white),
              ),
            )
          else
            const Icon(Icons.control_camera, size: 14, color: AppColors.white),
          const SizedBox(width: 8),
          Text(
            resolving ? 'Locating address…' : 'Move pin to adjust location',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
    required this.icon,
    required this.onTap,
    this.loading = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      shape: const CircleBorder(),
      elevation: 3,
      shadowColor: Colors.black.withValues(alpha: 0.2),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: loading ? null : onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: loading
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Icon(icon, size: 18, color: AppColors.black),
        ),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message, required this.onDismiss});

  final String message;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.caption.copyWith(color: AppColors.white),
            ),
          ),
          InkWell(
            onTap: onDismiss,
            child: const Icon(Icons.close, size: 14, color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
