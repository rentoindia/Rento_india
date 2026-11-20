import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'map_preview.dart';

/// A pin-drop location picker built on the project's existing
/// dependency-free [MapPreview] placeholder — no `google_maps_flutter`,
/// no API key, no network calls, so it renders with zero setup and zero
/// errors.
///
/// It exposes the same public surface as `InteractiveMapPicker`
/// ([onLocationResolved], [useCurrentLocation], [moveTo]), so once Google
/// Maps is wired up (API key + `web/index.html` script tag, or native
/// platform config), swapping this widget back out for the real one in
/// `pickup_address_screen.dart` is a one-line change — nothing else in
/// the screen needs to change.
class SampleMapPicker extends StatefulWidget {
  const SampleMapPicker({
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
  State<SampleMapPicker> createState() => SampleMapPickerState();
}

class SampleMapPickerState extends State<SampleMapPicker> {
  bool _resolving = false;
  bool _locating = false;

  // Sample coordinate -> address lookup, standing in for reverse
  // geocoding. Matches the seeded saved-address coordinates plus a
  // couple of extra spots, so panning/GPS/selection all resolve to a
  // believable label without ever hitting a network.
  static final _knownPlaces = <_LatLng, String>{
    _LatLng(13.0891, 80.2101): 'Anna Nagar West, Chennai, Tamil Nadu 600040',
    _LatLng(13.1143, 80.1548): 'Ambattur, Chennai, Tamil Nadu 600058',
    _LatLng(13.0206, 80.2226): 'Saidapet, Chennai, Tamil Nadu 600015',
    _LatLng(13.0843, 80.2705): 'Anna Nagar, Chennai, Tamil Nadu 600040',
  };

  static const _currentLocationSample = _LatLng(13.0604, 80.2496);
  static const _currentLocationLabel = 'T Nagar, Chennai, Tamil Nadu 600017';

  late double _lat = widget.initialLatitude ?? 13.0891;
  late double _lng = widget.initialLongitude ?? 80.2101;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _resolve(_lat, _lng));
  }

  Future<void> _resolve(double lat, double lng) async {
    if (!mounted) return;
    setState(() => _resolving = true);
    // Small delay so the "Locating address…" state is visible, mirroring
    // what a real reverse-geocode call would feel like.
    await Future.delayed(const Duration(milliseconds: 350));
    if (!mounted) return;
    final address =
        _knownPlaces[_LatLng(lat, lng)] ?? 'Pinned location, Chennai';
    setState(() {
      _lat = lat;
      _lng = lng;
      _resolving = false;
    });
    widget.onLocationResolved(lat, lng, address);
  }

  /// Moves to a known location (e.g. a saved address) and resolves its
  /// label. Same signature as `InteractiveMapPickerState.moveTo`.
  Future<void> moveTo(double latitude, double longitude) =>
      _resolve(latitude, longitude);

  /// Simulates fetching the device's current location. Same signature as
  /// `InteractiveMapPickerState.useCurrentLocation` — swap this widget
  /// out for `InteractiveMapPicker` later to make it a real GPS fetch.
  Future<void> useCurrentLocation() async {
    setState(() => _locating = true);
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    setState(() => _locating = false);
    await _resolve(_currentLocationSample.lat, _currentLocationSample.lng);
    if (mounted) {
      widget.onLocationResolved(
        _currentLocationSample.lat,
        _currentLocationSample.lng,
        _currentLocationLabel,
      );
    }
  }

  void _simulateDrag() {
    // Tapping the map "moves the pin" to a nearby sample spot, so the
    // interaction still feels alive without real map drag gestures.
    final places = _knownPlaces.keys.toList();
    final current = _LatLng(_lat, _lng);
    final next = places.firstWhere(
      (p) => p != current,
      orElse: () => places.first,
    );
    _resolve(next.lat, next.lng);
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
            GestureDetector(
              onTap: _simulateDrag,
              child: MapPreview(showRoute: false, height: widget.height),
            ),
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
          ],
        ),
      ),
    );
  }
}

class _LatLng {
  const _LatLng(this.lat, this.lng);
  final double lat;
  final double lng;

  @override
  bool operator ==(Object other) =>
      other is _LatLng && other.lat == lat && other.lng == lng;

  @override
  int get hashCode => Object.hash(lat, lng);
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
