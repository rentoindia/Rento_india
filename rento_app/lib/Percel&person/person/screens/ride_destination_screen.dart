import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/primary_button.dart';
import '../../parcel/models/address_model.dart';
import '../../parcel/models/saved_address_model.dart';
import '../../parcel/providers/saved_addresses_provider.dart';
import '../../parcel/screens/add_address_screen.dart';
import '../../parcel/widgets/address_chip.dart';
import '../../parcel/widgets/address_search_field.dart';
import '../../parcel/widgets/receiver_flow_app_bar.dart';
import '../../parcel/widgets/receiver_map_card.dart';
import '../../parcel/widgets/saved_address_card.dart';
import '../providers/ride_booking_provider.dart';
import '../widgets/ride_manual_address_section.dart';
import 'vehicle_selection_screen.dart';

class _QuickAddress {
  const _QuickAddress(this.label, this.icon, this.area, this.pincode);
  final String label;
  final IconData icon;
  final String area;
  final String pincode;
}

const _kQuickAddresses = [
  _QuickAddress('Home', Icons.home_outlined, 'Anna Nagar, Chennai', '600040'),
  _QuickAddress('Work', Icons.work_outline, 'White Town, Puducherry', '605001'),
  _QuickAddress(
    'Nearby',
    Icons.near_me_outlined,
    'White Town, Puducherry',
    '605001',
  ),
];

const _kAllSuggestions = [
  ('White Town', 'Puducherry - 605001'),
  ('Auroville', 'Puducherry - 605101'),
  ('Promenade Beach', 'Puducherry - 605001'),
  ('Puducherry Railway Station', 'Puducherry - 605001'),
  ('Kalapet', 'Puducherry - 605014'),
];

/// Step 2 of the ride flow — mirrors the parcel module's
/// `ReceiverAddressScreen` for everything address-related (search,
/// quick chips, map card, "Add Address Manually"), on the ride-scoped
/// `rideBookingProvider`. A ride destination is a place, not a person,
/// so the parcel screen's Receiver Information / Saved Receivers
/// sections are replaced with the same Saved Addresses list used on
/// the Pickup Location screen.
class RideDestinationScreen extends ConsumerStatefulWidget {
  const RideDestinationScreen({super.key});

  @override
  ConsumerState<RideDestinationScreen> createState() =>
      _RideDestinationScreenState();
}

class _RideDestinationScreenState extends ConsumerState<RideDestinationScreen> {
  final _scrollController = ScrollController();
  final _savedAddressesKey = GlobalKey();

  // --- Address (search / chip / map) ---
  final _searchController = TextEditingController();
  int? _selectedChip;
  String _areaLabel = 'White Town, Puducherry';
  String _pincode = '605001';
  List<(String, String)> _filtered = [];

  // --- Add Address Manually (inline, collapsible) ---
  bool _manualExpanded = false;
  final _houseController = TextEditingController();
  final _streetController = TextEditingController();
  final _landmarkController = TextEditingController();
  final _cityController = TextEditingController(text: 'Puducherry');
  final _manualPincodeController = TextEditingController();
  String _addressType = 'Home';

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _houseController.dispose();
    _streetController.dispose();
    _landmarkController.dispose();
    _cityController.dispose();
    _manualPincodeController.dispose();
    super.dispose();
  }

  bool get _addressValid {
    if (!_manualExpanded) return true;
    return _houseController.text.trim().isNotEmpty &&
        _streetController.text.trim().isNotEmpty &&
        _cityController.text.trim().isNotEmpty &&
        _manualPincodeController.text.trim().length >= 5;
  }

  bool get _canContinue => _addressValid;

  void _onSearchChanged(String query) {
    setState(() {
      if (query.trim().isEmpty) {
        _filtered = [];
        return;
      }
      _filtered = _kAllSuggestions
          .where(
            (s) =>
                '${s.$1} ${s.$2}'.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  void _selectChip(int index) {
    setState(() {
      _selectedChip = index;
      _searchController.text = _kQuickAddresses[index].label;
      _areaLabel = _kQuickAddresses[index].area;
      _pincode = _kQuickAddresses[index].pincode;
      _manualExpanded = false;
      _filtered = [];
    });
  }

  void _selectSuggestion((String, String) s) {
    setState(() {
      _selectedChip = null;
      _searchController.text = s.$1;
      _areaLabel = '${s.$1}, ${s.$2}';
      _pincode = RegExp(r'\d{3} ?\d{3}').stringMatch(s.$2) ?? _pincode;
      _manualExpanded = false;
      _filtered = [];
    });
    FocusScope.of(context).unfocus();
  }

  void _scrollToSavedAddresses() {
    final ctx = _savedAddressesKey.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOut,
    );
  }

  void _selectSavedAddress(SavedAddressModel address) {
    ref.read(savedAddressesProvider.notifier).select(address.id);
    setState(() {
      _selectedChip = null;
      _areaLabel = address.streetAreaLandmark;
      _pincode =
          RegExp(r'\d{5,6}').stringMatch(address.cityStatePin) ?? _pincode;
      _manualExpanded = false;
    });
  }

  Future<void> _addNewAddress() async {
    final result = await Navigator.of(context).push<SavedAddressModel>(
      MaterialPageRoute(builder: (_) => const AddAddressScreen()),
    );
    if (result == null) return;
    ref.read(savedAddressesProvider.notifier).add(result);
    _selectSavedAddress(result);
  }

  void _continue() {
    final String label;
    final String fullAddress;
    if (_manualExpanded && _houseController.text.trim().isNotEmpty) {
      label = _houseController.text.trim();
      fullAddress =
          '${_streetController.text.trim()}, ${_cityController.text.trim()}'
          ' - ${_manualPincodeController.text.trim()}';
    } else {
      label = _areaLabel;
      fullAddress = '$_areaLabel - $_pincode';
    }

    ref
        .read(rideBookingProvider.notifier)
        .setDestination(AddressModel(label: label, fullAddress: fullAddress));
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const VehicleSelectionScreen()));
  }

  void _showMoreSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SafeArea(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.share_outlined),
                title: const Text('Share this location'),
                onTap: () => Navigator.of(context).pop(),
              ),
              ListTile(
                leading: const Icon(Icons.help_outline),
                title: const Text('Help & support'),
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final savedState = ref.watch(savedAddressesProvider);
    final pickup = ref.watch(rideBookingProvider).pickup;

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: ReceiverFlowAppBar(
        title: 'Destination',
        subtitle: 'Where are you headed?',
        onNotifications: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No new notifications'),
              duration: Duration(seconds: 1),
            ),
          );
        },
        onMore: () => _showMoreSheet(context),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                children: [
                  if (pickup != null) ...[
                    Row(
                      children: [
                        const Icon(
                          Icons.trip_origin,
                          size: 14,
                          color: AppColors.grey500,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${pickup.label}, ${pickup.fullAddress}',
                            style: AppTextStyles.caption,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                  AddressSearchField(
                    controller: _searchController,
                    hint: 'Search destination',
                    icon: Icons.search,
                    onChanged: _onSearchChanged,
                  ),
                  const SizedBox(height: 12),
                  if (_filtered.isNotEmpty)
                    ..._filtered.map(
                      (s) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(
                          Icons.location_on_outlined,
                          size: 20,
                        ),
                        title: Text(s.$1, style: AppTextStyles.bodyStrong),
                        subtitle: Text(
                          s.$2,
                          style: AppTextStyles.caption,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () => _selectSuggestion(s),
                      ),
                    )
                  else ...[
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _kQuickAddresses.length + 1,
                        separatorBuilder: (_, _) => const SizedBox(width: 8),
                        itemBuilder: (context, i) {
                          if (i == _kQuickAddresses.length) {
                            return AddressChip(
                              label: 'Saved Places',
                              icon: Icons.bookmark_border,
                              selected: false,
                              onTap: _scrollToSavedAddresses,
                            );
                          }
                          final q = _kQuickAddresses[i];
                          return AddressChip(
                            label: q.label,
                            icon: q.icon,
                            selected: _selectedChip == i,
                            onTap: () => _selectChip(i),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 230,
                      child: ReceiverMapCard(
                        height: 230,
                        addressLabel: '$_areaLabel - $_pincode',
                        onLocate: () => setState(() {
                          _selectedChip = 2;
                          _searchController.text = 'Nearby';
                          _areaLabel = _kQuickAddresses[2].area;
                          _pincode = _kQuickAddresses[2].pincode;
                          _manualExpanded = false;
                        }),
                      ),
                    ),
                  ],
                  const SizedBox(height: 18),
                  const Divider(),
                  const SizedBox(height: 4),

                  // --- Add Address Manually (inline expandable) ---
                  RideManualAddressSection(
                    expanded: _manualExpanded,
                    onToggle: () =>
                        setState(() => _manualExpanded = !_manualExpanded),
                    houseController: _houseController,
                    streetController: _streetController,
                    landmarkController: _landmarkController,
                    cityController: _cityController,
                    pincodeController: _manualPincodeController,
                    addressType: _addressType,
                    onAddressTypeChanged: (v) =>
                        setState(() => _addressType = v ?? _addressType),
                    onFieldChanged: () => setState(() {}),
                  ),

                  const SizedBox(height: 24),

                  // --- Saved Addresses ---
                  KeyedSubtree(
                    key: _savedAddressesKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
              child: PrimaryButton(
                label: 'Choose Your Ride',
                enabled: _canContinue,
                onPressed: _canContinue ? _continue : null,
                trailing: const Icon(
                  Icons.arrow_forward,
                  size: 18,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
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
