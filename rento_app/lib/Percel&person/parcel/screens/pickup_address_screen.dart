import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/section_card.dart';
import '../models/address_model.dart';
import '../models/saved_address_model.dart';
import '../providers/booking_provider.dart';
import '../providers/saved_addresses_provider.dart';
import '../widgets/pickup_location_card.dart';
import '../widgets/pickup_map_preview.dart';
import '../widgets/saved_address_card.dart';
import 'add_address_screen.dart';
import 'receiver_address_screen.dart';

const kBookingSteps = [
  'Pickup Address',
  'Receiver Address',
  'Parcel Details',
  'Fare Estimate',
  'Payment',
];

class PickupAddressScreen extends ConsumerStatefulWidget {
  const PickupAddressScreen({super.key});

  @override
  ConsumerState<PickupAddressScreen> createState() =>
      _PickupAddressScreenState();
}

class _PickupAddressScreenState extends ConsumerState<PickupAddressScreen>
    with SingleTickerProviderStateMixin {
  final _mapKey = GlobalKey<SampleMapPickerState>();
  final _flatController = TextEditingController(
    text: 'Door No. A2, Ground Floor',
  );
  final _landmarkController = TextEditingController(
    text: 'Near Anna Nagar West Bus Stop',
  );

  String _addressLine1 = 'Anna Nagar, Chennai';
  String _addressLine2 = 'Tamil Nadu 600040';
  double? _latitude;
  double? _longitude;
  bool _gpsLoading = false;

  late final AnimationController _entrance = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 420),
  )..forward();
  late final Animation<double> _fade = CurvedAnimation(
    parent: _entrance,
    curve: Curves.easeOut,
  );
  late final Animation<Offset> _slide = Tween<Offset>(
    begin: const Offset(0, 0.04),
    end: Offset.zero,
  ).animate(_fade);

  @override
  void dispose() {
    _flatController.dispose();
    _landmarkController.dispose();
    _entrance.dispose();
    super.dispose();
  }

  bool get _canContinue =>
      _flatController.text.trim().isNotEmpty &&
      _landmarkController.text.trim().isNotEmpty;

  void _onLocationResolved(double lat, double lng, String address) {
    if (!mounted) return;
    final parts = address
        .split(', ')
        .where((p) => p.trim().isNotEmpty)
        .toList();
    setState(() {
      _latitude = lat;
      _longitude = lng;
      _addressLine1 = parts.take(2).join(', ').isEmpty
          ? address
          : parts.take(2).join(', ');
      _addressLine2 = parts.skip(2).join(', ');
    });
  }

  Future<void> _useGps() async {
    setState(() => _gpsLoading = true);
    await _mapKey.currentState?.useCurrentLocation();
    if (mounted) setState(() => _gpsLoading = false);
  }

  void _selectSavedAddress(SavedAddressModel address) {
    ref.read(savedAddressesProvider.notifier).select(address.id);
    setState(() {
      _flatController.text = address.flatHouseBuilding;
      _landmarkController.text = address.streetAreaLandmark;
      _addressLine1 = address.streetAreaLandmark;
      _addressLine2 = address.cityStatePin;
    });
    if (address.latitude != null && address.longitude != null) {
      _mapKey.currentState?.moveTo(address.latitude!, address.longitude!);
    }
  }

  Future<void> _addNewAddress() async {
    final result = await Navigator.of(context).push<SavedAddressModel>(
      MaterialPageRoute(builder: (_) => const AddAddressScreen()),
    );
    if (result == null) return;
    ref.read(savedAddressesProvider.notifier).add(result);
    _selectSavedAddress(result);
  }

  void _showHelp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Drag the map or tap GPS to pin your exact pickup spot, '
          'or choose a saved address below.',
        ),
      ),
    );
  }

  void _continue() {
    if (!_canContinue) return;
    ref
        .read(bookingProvider.notifier)
        .setPickup(
          AddressModel(
            label: _flatController.text.trim(),
            fullAddress: _landmarkController.text.trim(),
            contactPhone: ref.read(savedAddressesProvider).selected?.phone,
            latitude: _latitude,
            longitude: _longitude,
          ),
        );
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const ReceiverAddressScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final savedState = ref.watch(savedAddressesProvider);

    return Scaffold(
      appBar: FlowAppBar(
        eyebrow: 'DELIVERY',
        title: 'Pickup Address',
        subtitle: 'Where should we pick up the parcel?',
        onHelp: _showHelp,
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                    children: [
                      PickupLocationCard(
                        addressLine1: _addressLine1,
                        addressLine2: _addressLine2,
                        flatController: _flatController,
                        landmarkController: _landmarkController,
                        onGpsTap: _useGps,
                        onFieldChanged: () => setState(() {}),
                        gpsLoading: _gpsLoading,
                      ),
                      const SizedBox(height: 18),
                      SampleMapPicker(
                        key: _mapKey,
                        onLocationResolved: _onLocationResolved,
                        initialLatitude: 13.0891,
                        initialLongitude: 80.2101,
                        height: 220,
                      ),
                      const SizedBox(height: 26),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'SAVED ADDRESSES',
                            style: AppTextStyles.overline,
                          ),
                          _AddNewButton(onTap: _addNewAddress),
                        ],
                      ),
                      const SizedBox(height: 12),
                      for (final address in savedState.addresses) ...[
                        SavedAddressCard(
                          address: address,
                          selected: address.id == savedState.selectedId,
                          onTap: () => _selectSavedAddress(address),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                  child: _NextStepButton(
                    enabled: _canContinue,
                    onPressed: _continue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AddNewButton extends StatelessWidget {
  const _AddNewButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.add, size: 14, color: AppColors.white),
            SizedBox(width: 4),
            Text(
              'Add New',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Sticky bottom CTA matching the two-line "NEXT STEP / Continue to
/// Receiver ->" reference button.
class _NextStepButton extends StatefulWidget {
  const _NextStepButton({required this.enabled, required this.onPressed});

  final bool enabled;
  final VoidCallback onPressed;

  @override
  State<_NextStepButton> createState() => _NextStepButtonState();
}

class _NextStepButtonState extends State<_NextStepButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 120),
    lowerBound: 0,
    upperBound: 0.03,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(scale: 1 - _controller.value, child: child);
      },
      child: GestureDetector(
        onTapDown: widget.enabled ? (_) => _controller.forward() : null,
        onTapUp: widget.enabled ? (_) => _controller.reverse() : null,
        onTapCancel: widget.enabled ? () => _controller.reverse() : null,
        onTap: widget.enabled ? widget.onPressed : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 68,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            color: widget.enabled ? AppColors.black : AppColors.grey300,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'NEXT STEP',
                      style: AppTextStyles.overline.copyWith(
                        color: AppColors.grey400,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Continue to Receiver',
                      style: AppTextStyles.bodyStrong.copyWith(
                        color: AppColors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 38,
                width: 38,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  size: 18,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
