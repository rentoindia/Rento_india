// lib/features/rider/presentation/screens/parcel/navigate_to_parcel_screen.dart
//
// Parcel-delivery twin of TripNavigationScreen (trips/trip_navigation_screen.dart).
// Same exact design — black top bar, curved white sheet, live Google Map,
// contact row, stats row, Report Issue + Arrived button — but:
//   - works off ParcelRequestModel instead of TripRequestModel
//   - the stats row shows Parcel Type / Weight / Earnings instead of
//     Item / Qty / Earnings
//   - labels talk about "Sender" / "Receiver" instead of "Vendor" / "Customer"
//
// Step 1 of the parcel flow after a rider accepts a request:
//   Accept → NavigateToParcelScreen(stage: toSender) → ParcelPickupOtpScreen
//          → NavigateToParcelScreen(stage: toReceiver) → ParcelDeliveryOtpScreen

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../data/models/parcel_request_model.dart';
import 'parcel_delivery_otp_screen.dart';
import 'parcel_pickup_otp_screen.dart';

class NavigateToParcelScreen extends StatefulWidget {
  final ParcelRequestModel request;
  final ParcelNavigationStage stage;

  const NavigateToParcelScreen({
    super.key,
    required this.request,
    this.stage = ParcelNavigationStage.toSender,
  });

  bool get isToSender => stage == ParcelNavigationStage.toSender;

  String get destinationAddress =>
      isToSender ? request.pickupAddress : request.dropAddress;

  String get destinationLabel =>
      isToSender ? request.pickupLabel : request.dropLabel;

  String get sectionTitle => isToSender ? 'PICKUP FROM' : 'DELIVER TO';

  String get contactSectionTitle =>
      isToSender ? 'SENDER CONTACT' : 'RECEIVER CONTACT';

  String get screenTitle =>
      isToSender ? 'Navigate to Pickup' : 'Navigate to Receiver';

  String get arrivedButtonLabel =>
      isToSender ? 'Arrived at Pickup' : 'Complete Delivery';

  String get contactName =>
      isToSender ? request.senderName : request.receiverName;

  String get contactPhone =>
      isToSender ? request.senderPhone : request.receiverPhone;

  @override
  State<NavigateToParcelScreen> createState() => _NavigateToParcelScreenState();
}

class _NavigateToParcelScreenState extends State<NavigateToParcelScreen>
    with TickerProviderStateMixin {
  late final AnimationController _entrance;
  late final Animation<double> _topCardAnim;
  late final Animation<double> _sheetAnim;

  bool _arriving = false;

  // ---- Real map state ----
  GoogleMapController? _mapController;
  StreamSubscription<Position>? _positionStream;
  LatLng? _riderPosition;
  double _riderHeading = 0;

  LatLng? _destination;
  bool _resolvingDestination = true;
  String? _mapError;

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();

    _entrance = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    )..forward();
    _topCardAnim = CurvedAnimation(
      parent: _entrance,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
    );
    _sheetAnim = CurvedAnimation(
      parent: _entrance,
      curve: const Interval(0.25, 1.0, curve: Curves.easeOutCubic),
    );

    _resolveDestinationThenTrack();
  }

  @override
  void dispose() {
    _entrance.dispose();
    _positionStream?.cancel();
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _resolveDestinationThenTrack() async {
    try {
      final results = await Geocoding().locationFromAddress(widget.destinationAddress);
      if (results.isEmpty) throw Exception('No geocoding results');
      _destination = LatLng(results.first.latitude, results.first.longitude);
    } catch (_) {
      if (mounted) {
        setState(() {
          _mapError =
              'Could not locate "${widget.destinationAddress}". Check the address.';
          _resolvingDestination = false;
        });
      }
      return;
    }

    await _startLiveTracking();
    if (mounted) setState(() => _resolvingDestination = false);
  }

  Future<void> _startLiveTracking() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(
        () => _mapError = 'Please enable location services to navigate.',
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => _mapError = 'Location permission denied.');
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      setState(
        () => _mapError =
            'Location permission permanently denied. Enable it from Settings.',
      );
      return;
    }

    try {
      final initial = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      _updateRiderPosition(initial);
    } catch (_) {
      // live stream below will populate it shortly
    }

    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen(_updateRiderPosition);
  }

  void _updateRiderPosition(Position position) {
    final newLatLng = LatLng(position.latitude, position.longitude);
    if (!mounted) return;
    setState(() {
      _riderPosition = newLatLng;
      _riderHeading = position.heading;
      _rebuildMarkersAndRoute();
    });

    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: newLatLng,
          zoom: 16.5,
          bearing: position.heading,
          tilt: 45,
        ),
      ),
    );
  }

  void _rebuildMarkersAndRoute() {
    if (_riderPosition == null) return;

    _markers
      ..clear()
      ..add(
        Marker(
          markerId: const MarkerId('rider'),
          position: _riderPosition!,
          rotation: _riderHeading,
          anchor: const Offset(0.5, 0.5),
          flat: true,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueAzure,
          ),
          infoWindow: const InfoWindow(title: 'You'),
        ),
      );

    if (_destination != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('destination'),
          position: _destination!,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            widget.isToSender
                ? BitmapDescriptor.hueOrange
                : BitmapDescriptor.hueRed,
          ),
          infoWindow: InfoWindow(title: widget.destinationLabel),
        ),
      );

      _polylines
        ..clear()
        ..add(
          Polyline(
            polylineId: const PolylineId('route'),
            points: [_riderPosition!, _destination!],
            color: Colors.black87,
            width: 4,
            patterns: [PatternItem.dash(20), PatternItem.gap(10)],
          ),
        );
    }
  }

  double? get _distanceKm {
    if (_riderPosition == null || _destination == null) return null;
    final meters = Geolocator.distanceBetween(
      _riderPosition!.latitude,
      _riderPosition!.longitude,
      _destination!.latitude,
      _destination!.longitude,
    );
    return meters / 1000;
  }

  int? get _etaMinutes {
    final km = _distanceKm;
    if (km == null) return null;
    const assumedSpeedKmh = 22.0;
    return ((km / assumedSpeedKmh) * 60).ceil().clamp(1, 999);
  }

  Future<void> _openExternalNav() async {
    if (_destination == null) return;
    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=${_destination!.latitude},${_destination!.longitude}&travelmode=driving',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open Google Maps.')),
      );
    }
  }

  Future<void> _call(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone.replaceAll(' ', ''));
    final ok = await launchUrl(uri);
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the dialer')),
      );
    }
  }

  Future<void> _message(String phone) async {
    final uri = Uri(scheme: 'sms', path: phone.replaceAll(' ', ''));
    final ok = await launchUrl(uri);
    if (!ok && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Could not open messages')));
    }
  }

  void _reportIssue() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Report an issue',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              ),
              const SizedBox(height: 4),
              Text(
                widget.isToSender
                    ? 'Let us know what went wrong on the way to the sender.'
                    : 'Let us know what went wrong on the way to the receiver.',
                style: const TextStyle(color: Colors.black54, fontSize: 13),
              ),
              const SizedBox(height: 16),
              // TODO: wire to trip_repository.reportIssue(tripId, reason)
              ..._issueReasons.map(
                (r) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.error_outline, size: 20),
                  title: Text(r, style: const TextStyle(fontSize: 14)),
                  onTap: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static const _issueReasons = [
    'Location is incorrect',
    'Recipient is not reachable',
    'Vehicle breakdown',
    'Traffic / road blockage',
  ];

  void _onArrived() {
    if (_arriving) return;
    setState(() => _arriving = true);
    Future.delayed(const Duration(milliseconds: 620), () {
      if (!mounted) return;

      switch (widget.stage) {
        case ParcelNavigationStage.toSender:
          // Sender leg done → go verify pickup OTP.
          Navigator.of(context).pushReplacement(
            _fadeSlideRoute(ParcelPickupOtpScreen(request: widget.request)),
          );
          break;

        case ParcelNavigationStage.toReceiver:
          // Receiver leg done → go verify delivery OTP + proof-of-delivery
          // photo before the trip is actually marked complete.
          Navigator.of(context).pushReplacement(
            _fadeSlideRoute(ParcelDeliveryOtpScreen(request: widget.request)),
          );
          break;
      }
    });
  }

  PageRouteBuilder<T> _fadeSlideRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      transitionDuration: const Duration(milliseconds: 420),
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, anim, __, child) {
        final curved = CurvedAnimation(
          parent: anim,
          curve: Curves.easeOutCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.06),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final trip = widget.request;

    return Scaffold(
      backgroundColor: AppColors.pureBlack,
      body: Column(
        children: [
          SafeArea(bottom: false, child: _buildTopBar(trip)),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  FadeTransition(
                    opacity: _topCardAnim,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, -0.15),
                        end: Offset.zero,
                      ).animate(_topCardAnim),
                      child: _buildInstructionCard(),
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned.fill(child: _buildMap()),
                        Positioned(
                          right: 14,
                          bottom: 14,
                          child: _buildMapControls(),
                        ),
                      ],
                    ),
                  ),
                  FadeTransition(
                    opacity: _sheetAnim,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.25),
                        end: Offset.zero,
                      ).animate(_sheetAnim),
                      child: _buildBottomSheet(trip),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    if (_resolvingDestination) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_mapError != null) {
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.location_off, size: 42, color: AppColors.error),
              const SizedBox(height: 12),
              Text(
                _mapError!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  setState(() {
                    _resolvingDestination = true;
                    _mapError = null;
                  });
                  _resolveDestinationThenTrack();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final initialTarget = _riderPosition ?? _destination!;
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: initialTarget, zoom: 15),
      onMapCreated: (controller) => _mapController = controller,
      markers: _markers,
      polylines: _polylines,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      compassEnabled: true,
    );
  }

  Widget _buildTopBar(ParcelRequestModel trip) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 16, 20),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 18,
              color: AppColors.pureWhite,
            ),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  widget.screenTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: AppColors.pureWhite,
                  ),
                ),
                Text(
                  'TRIP ID: ${trip.orderId}',
                  style: const TextStyle(
                    color: Color(0xFFB3B3B3),
                    fontSize: 11,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
          _pillButton(
            icon: Icons.headset_mic_outlined,
            label: 'Support',
            onTap: () {
              // TODO: wire to core/services support/help-center flow.
            },
          ),
        ],
      ),
    );
  }

  Widget _pillButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return _Pressable(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: AppColors.pureWhite),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.pureWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionCard() {
    final km = _distanceKm;
    final eta = _etaMinutes;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F6FB),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_upward_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    km != null ? '${(km * 1000).round()} m' : '—',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.isToSender
                        ? 'Head towards the sender\'s location'
                        : 'Head towards the receiver\'s location',
                    style: const TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _statChip(
                  km != null ? '${km.toStringAsFixed(1)} km' : '—',
                  'DISTANCE',
                ),
                const SizedBox(height: 8),
                _statChip(eta != null ? '$eta min' : '—', 'ETA'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statChip(String value, String label) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutCubic,
      builder: (context, t, _) => Opacity(
        opacity: t,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black45,
                fontSize: 10,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapControls() {
    return Column(
      children: [
        _circleControl(
          Icons.my_location,
          onTap: () {
            if (_riderPosition != null) {
              _mapController?.animateCamera(
                CameraUpdate.newLatLngZoom(_riderPosition!, 16.5),
              );
            }
          },
        ),
        const SizedBox(height: 10),
        _circleControl(Icons.navigation_outlined, onTap: _openExternalNav),
      ],
    );
  }

  Widget _circleControl(IconData icon, {required VoidCallback onTap}) {
    return _Pressable(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: Colors.black87),
      ),
    );
  }

  Widget _buildBottomSheet(ParcelRequestModel trip) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 24,
            offset: Offset(0, -6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 14),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.sectionTitle,
                      style: const TextStyle(
                        color: Colors.black45,
                        fontSize: 11,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.destinationLabel,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.destinationAddress,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              _circleControl(
                Icons.call_outlined,
                onTap: () => _call(widget.contactPhone),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.contactSectionTitle,
                      style: const TextStyle(
                        color: Colors.black45,
                        fontSize: 11,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.contactPhone,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              _pillButton(
                icon: Icons.chat_bubble_outline,
                label: 'Message',
                onTap: () => _message(widget.contactPhone),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F6FB),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                _tripStat(
                  Icons.inventory_2_outlined,
                  'PARCEL',
                  trip.parcelType.label,
                ),
                _vDivider(),
                _tripStat(Icons.scale_outlined, 'WEIGHT', trip.weightLabel),
                _vDivider(),
                _tripStat(Icons.currency_rupee, 'EARNINGS', trip.earningsLabel),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: _reportIssue,
                    icon: const Icon(Icons.warning_amber_rounded, size: 18),
                    label: const Text('Report Issue'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: _ArrivedButton(
                  label: widget.arrivedButtonLabel,
                  loading: _arriving,
                  onTap: _onArrived,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tripStat(IconData icon, String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 18, color: Colors.black54),
          const SizedBox(height: 6),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              color: Colors.black45,
              fontSize: 10,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _vDivider() =>
      Container(width: 1, height: 34, color: Colors.grey.shade300);
}

class _ArrivedButton extends StatelessWidget {
  final String label;
  final bool loading;
  final VoidCallback onTap;

  const _ArrivedButton({
    required this.label,
    required this.loading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _Pressable(
      onTap: loading ? () {} : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            child: loading
                ? const SizedBox(
                    key: ValueKey('loading'),
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      color: Colors.white,
                    ),
                  )
                : Row(
                    key: const ValueKey('label'),
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

/// Small helper that gives any child a tactile press-down scale.
class _Pressable extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _Pressable({required this.child, required this.onTap});

  @override
  State<_Pressable> createState() => _PressableState();
}

class _PressableState extends State<_Pressable> {
  double _scale = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.92),
      onTapUp: (_) => setState(() => _scale = 1),
      onTapCancel: () => setState(() => _scale = 1),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        child: widget.child,
      ),
    );
  }
}
