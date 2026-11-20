import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/section_card.dart';
import '../models/address_model.dart';
import '../models/receiver_model.dart';
import '../providers/booking_provider.dart';
import '../widgets/address_chip.dart';
import '../widgets/address_search_field.dart';
import '../widgets/dashed_add_card.dart';
import '../widgets/receiver_card.dart';
import '../widgets/receiver_flow_app_bar.dart';
import '../widgets/receiver_map_card.dart';
import '../widgets/verified_badge.dart';
import 'parcel_details_screen.dart';

class _QuickAddress {
  const _QuickAddress(this.label, this.icon, this.area, this.pincode);
  final String label;
  final IconData icon;
  final String area;
  final String pincode;
}

const _kQuickAddresses = [
  _QuickAddress('Home', Icons.home_outlined, 'Bandra West, Mumbai', '400 050'),
  _QuickAddress('Office', Icons.work_outline, 'Lower Parel, Mumbai', '400 013'),
  _QuickAddress(
    'Nearby',
    Icons.near_me_outlined,
    'Bandra West, Mumbai',
    '400 050',
  ),
];

const _kAllSuggestions = [
  ('Bandra West', 'Mumbai - 400 050'),
  ('Bandra Kurla Complex', 'Mumbai - 400 051'),
  ('Bandstand Promenade', 'Bandra West, Mumbai - 400 050'),
  ('Andheri West', 'Mumbai - 400 058'),
  ('Powai', 'Mumbai - 400 076'),
];

const _kAddressTypes = ['Home', 'Work', 'Other'];

/// Single-page receiver flow — search/pick a delivery location, expand
/// "Add Address Manually" inline, fill in the receiver, pick from saved
/// receivers, or add a new one — all on one scrollable page with a
/// sticky Continue button. No navigation happens until Continue is
/// pressed, at which point the flow moves on to Parcel Details.
class ReceiverAddressScreen extends ConsumerStatefulWidget {
  const ReceiverAddressScreen({super.key});

  @override
  ConsumerState<ReceiverAddressScreen> createState() =>
      _ReceiverAddressScreenState();
}

class _ReceiverAddressScreenState extends ConsumerState<ReceiverAddressScreen> {
  final _scrollController = ScrollController();
  final _savedReceiversKey = GlobalKey();

  // --- Address (search / chip / map) ---
  final _searchController = TextEditingController();
  int? _selectedChip;
  String _areaLabel = 'Bandra West, Mumbai';
  String _pincode = '400 050';
  List<(String, String)> _filtered = [];

  // --- Add Address Manually (inline, collapsible) ---
  bool _manualExpanded = false;
  final _houseController = TextEditingController();
  final _streetController = TextEditingController();
  final _landmarkController = TextEditingController();
  final _cityController = TextEditingController(text: 'Mumbai');
  final _manualPincodeController = TextEditingController();
  String _addressType = 'Home';

  // --- Receiver Information ---
  final _receiverNameController = TextEditingController(text: 'Rohan Verma');
  final _receiverPhoneController = TextEditingController(
    text: '+91 93456 78901',
  );

  // --- Saved / new receivers ---
  late final List<ReceiverModel> _receivers = List.of(kDemoReceivers);
  String? _selectedReceiverId;
  bool _addNewExpanded = false;
  final _newNameController = TextEditingController();
  final _newPhoneController = TextEditingController();

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _houseController.dispose();
    _streetController.dispose();
    _landmarkController.dispose();
    _cityController.dispose();
    _manualPincodeController.dispose();
    _receiverNameController.dispose();
    _receiverPhoneController.dispose();
    _newNameController.dispose();
    _newPhoneController.dispose();
    super.dispose();
  }

  bool get _addressValid {
    if (!_manualExpanded) return true;
    return _houseController.text.trim().isNotEmpty &&
        _streetController.text.trim().isNotEmpty &&
        _cityController.text.trim().isNotEmpty &&
        _manualPincodeController.text.trim().length >= 5;
  }

  bool get _receiverValid =>
      _receiverNameController.text.trim().isNotEmpty &&
      _receiverPhoneController.text.trim().length >= 10;

  bool get _canContinue => _addressValid && _receiverValid;

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

  void _scrollToSavedReceivers() {
    final ctx = _savedReceiversKey.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOut,
    );
  }

  void _copy(String value, String label) {
    Clipboard.setData(ClipboardData(text: value));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copied'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _useReceiver(ReceiverModel receiver) {
    setState(() {
      _selectedReceiverId = receiver.id;
      _receiverNameController.text = receiver.name;
      _receiverPhoneController.text = receiver.phone;
      _areaLabel = receiver.addressLabel;
      _manualExpanded = false;
    });
  }

  void _addNewReceiver() {
    final name = _newNameController.text.trim();
    final phone = _newPhoneController.text.trim();
    if (name.isEmpty || phone.length < 10) return;
    final receiver = ReceiverModel(
      id: 'new_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      phone: phone,
      addressLabel: '$_areaLabel - $_pincode',
      avatarColor: AppColors.accentBlue,
    );
    setState(() {
      _receivers.insert(0, receiver);
      _selectedReceiverId = receiver.id;
      _receiverNameController.text = name;
      _receiverPhoneController.text = phone;
      _newNameController.clear();
      _newPhoneController.clear();
      _addNewExpanded = false;
    });
    FocusScope.of(context).unfocus();
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
        .read(bookingProvider.notifier)
        .setReceiver(
          AddressModel(
            label: label,
            fullAddress: fullAddress,
            contactName: _receiverNameController.text.trim(),
            contactPhone: _receiverPhoneController.text.trim(),
          ),
        );
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const ParcelDetailsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: ReceiverFlowAppBar(
        title: 'Receiver Address',
        subtitle: 'Where should we deliver your parcel?',
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
                  AddressSearchField(
                    controller: _searchController,
                    hint: 'Search receiver address',
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
                              onTap: _scrollToSavedReceivers,
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
                  _ManualAddressSection(
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

                  const SizedBox(height: 20),

                  // --- Receiver Information ---
                  Text('Receiver Information', style: AppTextStyles.bodyStrong),
                  const SizedBox(height: 10),
                  SectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Contact Details',
                              style: AppTextStyles.captionStrong,
                            ),
                            const Spacer(),
                            if (_receiverValid) const VerifiedBadge(),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text('RECEIVER NAME', style: AppTextStyles.overline),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _receiverNameController,
                          onChanged: (_) => setState(() {}),
                          style: AppTextStyles.body,
                          decoration: InputDecoration(
                            hintText: 'Receiver name',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.copy_outlined, size: 18),
                              onPressed: () =>
                                  _copy(_receiverNameController.text, 'Name'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text('MOBILE NUMBER', style: AppTextStyles.overline),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _receiverPhoneController,
                          onChanged: (_) => setState(() {}),
                          keyboardType: TextInputType.phone,
                          style: AppTextStyles.body,
                          decoration: InputDecoration(
                            hintText: '+91 00000 00000',
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.copy_outlined,
                                    size: 18,
                                  ),
                                  onPressed: () => _copy(
                                    _receiverPhoneController.text,
                                    'Number',
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.call,
                                    size: 18,
                                    color: AppColors.accentGreen,
                                  ),
                                  onPressed: () {},
                                ),
                                const SizedBox(width: 4),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // --- Saved Receivers ---
                  KeyedSubtree(
                    key: _savedReceiversKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Saved Receivers',
                          style: AppTextStyles.bodyStrong,
                        ),
                        const SizedBox(height: 10),
                        for (final r in _receivers) ...[
                          AnimatedScale(
                            duration: const Duration(milliseconds: 180),
                            scale: _selectedReceiverId == r.id ? 1.01 : 1.0,
                            child: ReceiverCard(
                              receiver: r,
                              onUse: () => _useReceiver(r),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],

                        // --- Add New Receiver (inline expandable) ---
                        AnimatedSize(
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOut,
                          alignment: Alignment.topCenter,
                          child: _addNewExpanded
                              ? _AddNewReceiverForm(
                                  nameController: _newNameController,
                                  phoneController: _newPhoneController,
                                  onCancel: () =>
                                      setState(() => _addNewExpanded = false),
                                  onAdd: _addNewReceiver,
                                )
                              : DashedAddCard(
                                  label: 'Add New Receiver',
                                  onTap: () =>
                                      setState(() => _addNewExpanded = true),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
              child: PrimaryButton(
                label: 'Continue for Parcel Details',
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
}

/// Collapsible "+ Add Address Manually" section. Expands inline via
/// [AnimatedSize] — never pushes a new route, sheet, or dialog.
class _ManualAddressSection extends StatelessWidget {
  const _ManualAddressSection({
    required this.expanded,
    required this.onToggle,
    required this.houseController,
    required this.streetController,
    required this.landmarkController,
    required this.cityController,
    required this.pincodeController,
    required this.addressType,
    required this.onAddressTypeChanged,
    required this.onFieldChanged,
  });

  final bool expanded;
  final VoidCallback onToggle;
  final TextEditingController houseController;
  final TextEditingController streetController;
  final TextEditingController landmarkController;
  final TextEditingController cityController;
  final TextEditingController pincodeController;
  final String addressType;
  final ValueChanged<String?> onAddressTypeChanged;
  final VoidCallback onFieldChanged;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onToggle,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Row(
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    size: 20,
                    color: AppColors.black,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Add Address Manually',
                      style: AppTextStyles.bodyStrong,
                    ),
                  ),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 200),
                    turns: expanded ? 0.5 : 0,
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      size: 22,
                      color: AppColors.grey500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            alignment: Alignment.topCenter,
            child: !expanded
                ? const SizedBox(width: double.infinity, height: 0)
                : Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'HOUSE / FLAT / BUILDING *',
                          style: AppTextStyles.overline,
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: houseController,
                          onChanged: (_) => onFieldChanged(),
                          style: AppTextStyles.body,
                          decoration: const InputDecoration(
                            hintText: 'e.g. Flat 4B, Ocean Heights',
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text('STREET / AREA *', style: AppTextStyles.overline),
                        const SizedBox(height: 6),
                        TextField(
                          controller: streetController,
                          onChanged: (_) => onFieldChanged(),
                          style: AppTextStyles.body,
                          decoration: const InputDecoration(
                            hintText: 'e.g. Carter Road, Bandra West',
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text('LANDMARK', style: AppTextStyles.overline),
                        const SizedBox(height: 6),
                        TextField(
                          controller: landmarkController,
                          style: AppTextStyles.body,
                          decoration: const InputDecoration(
                            hintText: "e.g. Near St. Andrew's Church",
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('CITY *', style: AppTextStyles.overline),
                                  const SizedBox(height: 6),
                                  TextField(
                                    controller: cityController,
                                    onChanged: (_) => onFieldChanged(),
                                    style: AppTextStyles.body,
                                    decoration: const InputDecoration(
                                      hintText: 'Mumbai',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'PINCODE *',
                                    style: AppTextStyles.overline,
                                  ),
                                  const SizedBox(height: 6),
                                  TextField(
                                    controller: pincodeController,
                                    onChanged: (_) => onFieldChanged(),
                                    keyboardType: TextInputType.number,
                                    style: AppTextStyles.body,
                                    decoration: const InputDecoration(
                                      hintText: '400 050',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text('ADDRESS TYPE *', style: AppTextStyles.overline),
                        const SizedBox(height: 6),
                        DropdownButtonFormField<String>(
                          initialValue: addressType,
                          icon: const Icon(Icons.keyboard_arrow_down, size: 20),
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.black,
                          ),
                          decoration: const InputDecoration(),
                          items: _kAddressTypes
                              .map(
                                (t) =>
                                    DropdownMenuItem(value: t, child: Text(t)),
                              )
                              .toList(),
                          onChanged: onAddressTypeChanged,
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

/// Inline "Add New Receiver" form, shown in place of the dashed card
/// once tapped. Collapses back via [AnimatedSize] on cancel/add.
class _AddNewReceiverForm extends StatelessWidget {
  const _AddNewReceiverForm({
    required this.nameController,
    required this.phoneController,
    required this.onCancel,
    required this.onAdd,
  });

  final TextEditingController nameController;
  final TextEditingController phoneController;
  final VoidCallback onCancel;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('New Receiver', style: AppTextStyles.bodyStrong),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close, size: 18),
                onPressed: onCancel,
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: nameController,
            style: AppTextStyles.body,
            decoration: const InputDecoration(hintText: 'Receiver name'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            style: AppTextStyles.body,
            decoration: const InputDecoration(hintText: '+91 00000 00000'),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(label: 'Add Receiver', onPressed: onAdd),
          ),
        ],
      ),
    );
  }
}
