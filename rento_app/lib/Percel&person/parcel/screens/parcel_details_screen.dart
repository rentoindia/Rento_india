import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/section_card.dart';
import '../../core/widgets/step_progress_indicator.dart';
import '../models/parcel_details_model.dart';
import '../models/vehicle_option_model.dart';
import '../providers/booking_provider.dart';
import 'fare_estimate_screen.dart';
import 'pickup_address_screen.dart';

const _kStepShortLabels = ['Pickup', 'Receiver', 'Parcel Details', 'Fare', 'Payment'];

class _SendingOption {
  const _SendingOption(this.label, this.icon, this.parcelType);
  final String label;
  final IconData icon;
  final ParcelType parcelType;
}

const _kSendingOptions = [
  _SendingOption('Documents', Icons.description_outlined, ParcelType.documents),
  _SendingOption('Package', Icons.inventory_2_outlined, ParcelType.electronics),
  _SendingOption('Gifts', Icons.card_giftcard_outlined, ParcelType.food),
  _SendingOption('Medicine', Icons.medical_services_outlined, ParcelType.clothing),
  _SendingOption('Others', Icons.more_horiz_outlined, ParcelType.other),
];

class _WeightBucket {
  const _WeightBucket(this.label, this.kg, this.size);
  final String label;
  final double kg;
  final ParcelSize size;
}

const _kWeightBuckets = [
  _WeightBucket('Under 1 kg', 0.5, ParcelSize.small),
  _WeightBucket('1 - 5 kg', 3.0, ParcelSize.small),
  _WeightBucket('5 - 10 kg', 7.5, ParcelSize.medium),
  _WeightBucket('10+ kg', 12.0, ParcelSize.medium),
];

/// Single scrollable page for parcel details — sending type, weight,
/// description, photos, special instructions, auto-assigned vehicle, and
/// safety declaration. The Continue button is a normal item at the end
/// of the scroll content (NOT pinned/sticky), so it only comes into view
/// once the user scrolls all the way down.
class ParcelDetailsScreen extends ConsumerStatefulWidget {
  const ParcelDetailsScreen({super.key});

  @override
  ConsumerState<ParcelDetailsScreen> createState() =>
      _ParcelDetailsScreenState();
}

class _ParcelDetailsScreenState extends ConsumerState<ParcelDetailsScreen> {
  int _sendingIndex = 0;
  int _weightIndex = 3;
  final _descriptionController = TextEditingController();
  final List<Uint8List?> _photos = [null, null, null];
  final _instructionsController = TextEditingController();
  String? _selectedVehicleId;
  bool _safetyDeclared = false;

  @override
  void initState() {
    super.initState();
    _descriptionController.addListener(_refresh);
    _instructionsController.addListener(_refresh);
  }

  void _refresh() => setState(() {});

  @override
  void dispose() {
    _descriptionController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  ParcelDetailsModel get _parcel {
    final bucket = _kWeightBuckets[_weightIndex];
    return ParcelDetailsModel(
      type: _kSendingOptions[_sendingIndex].parcelType,
      size: bucket.size,
      weightKg: bucket.kg,
      instructions: _instructionsController.text.trim().isEmpty
          ? null
          : _instructionsController.text.trim(),
    );
  }

  // Show all available vehicle types — Bike, Bike XL, Auto, Van.
  List<VehicleOptionModel> get _vehicles => kVehicleOptions;

  VehicleOptionModel get _recommendedVehicle {
    final suitable = _vehicles.where((v) => v.canCarry(_parcel)).toList()
      ..sort((a, b) => a.fare.compareTo(b.fare));
    return suitable.isNotEmpty ? suitable.first : _vehicles.last;
  }

  VehicleOptionModel get _selectedVehicle {
    if (_selectedVehicleId != null) {
      for (final v in _vehicles) {
        if (v.id == _selectedVehicleId) return v;
      }
    }
    return _recommendedVehicle;
  }

  int get _photosCount => _photos.where((p) => p != null).length;

  bool get _canContinue => _safetyDeclared;

  Future<void> _pickPhoto(int index) async {
    try {
      final xfile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1600,
        imageQuality: 85,
      );
      if (xfile == null || !mounted) return;
      final bytes = await xfile.readAsBytes();
      if (!mounted) return;
      setState(() => _photos[index] = bytes);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not open photo picker: $e')));
    }
  }

  void _removePhoto(int index) => setState(() => _photos[index] = null);

  void _continue() {
    final vehicle = _selectedVehicle;
    ref.read(bookingProvider.notifier).setParcelDetails(_parcel);
    ref.read(bookingProvider.notifier).selectVehicle(vehicle.id);
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const FareEstimateScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: _ParcelDetailsAppBar(
        onHelp: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Need help? Contact support from the menu.'),
              duration: Duration(seconds: 2),
            ),
          );
        },
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StepProgressIndicator(
                steps: kBookingSteps,
                currentIndex: 2,
                shortLabels: _kStepShortLabels,
              ),
              const SizedBox(height: 26),

              const _SectionHeader('What are you sending?'),
              const SizedBox(height: 12),
              SectionCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                child: SizedBox(
                  height: 84,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _kSendingOptions.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 10),
                    itemBuilder: (context, i) => _SendingTypeTile(
                      option: _kSendingOptions[i],
                      selected: _sendingIndex == i,
                      onTap: () => setState(() {
                        _sendingIndex = i;
                        _selectedVehicleId = null;
                      }),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const _SectionHeader('Weight'),
                  Text('approx.', style: AppTextStyles.caption),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(_kWeightBuckets.length, (i) {
                  final selected = _weightIndex == i;
                  return GestureDetector(
                    onTap: () => setState(() {
                      _weightIndex = i;
                      _selectedVehicleId = null;
                    }),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOut,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 11,
                      ),
                      decoration: BoxDecoration(
                        color: selected ? AppColors.black : AppColors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: selected
                              ? AppColors.black
                              : AppColors.grey300,
                        ),
                      ),
                      child: Text(
                        _kWeightBuckets[i].label,
                        style: AppTextStyles.bodyStrong.copyWith(
                          color: selected
                              ? AppColors.white
                              : AppColors.black,
                        ),
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const _SectionHeader('Description'),
                  Text(
                    '${_descriptionController.text.length}/80',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _descriptionController,
                maxLength: 80,
                maxLines: 2,
                style: AppTextStyles.body,
                decoration: const InputDecoration(
                  hintText: 'e.g. Legal documents — A4 size, sealed envelope',
                  counterText: '',
                ),
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const _SectionHeader('Add Photos'),
                  Text('$_photosCount/3', style: AppTextStyles.caption),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: List.generate(3, (i) {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: i < 2 ? 10 : 0),
                      child: _PhotoSlot(
                        bytes: _photos[i],
                        onTap: () => _pickPhoto(i),
                        onRemove: () => _removePhoto(i),
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const _SectionHeader('Special Instructions'),
                  Text(
                    '${_instructionsController.text.length}/160',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _instructionsController,
                maxLength: 160,
                maxLines: 3,
                style: AppTextStyles.body,
                decoration: const InputDecoration(
                  hintText:
                      'e.g. Handle with care. Call before arrival. '
                      'Leave at reception.',
                  counterText: '',
                ),
              ),

              const SizedBox(height: 26),
              const _SectionHeader('Vehicle for You'),
              const SizedBox(height: 2),
              Text(
                'Auto-assigned based on parcel size & weight.',
                style: AppTextStyles.caption,
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 112,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _vehicles.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 10),
                  itemBuilder: (context, i) {
                    final v = _vehicles[i];
                    final selected = v.id == _selectedVehicle.id;
                    return _VehicleCard(
                      option: v,
                      selected: selected,
                      recommended: v.id == _recommendedVehicle.id,
                      onTap: () => setState(() => _selectedVehicleId = v.id),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),
              SectionCard(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info_outline,
                      size: 18,
                      color: AppColors.grey500,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'No need to choose a vehicle',
                            style: AppTextStyles.bodyStrong,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "We assign the best vehicle based on your "
                            "parcel's size, weight, and destination.",
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.verified_outlined,
                          size: 18,
                          color: AppColors.accentGreen,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Safety Declaration',
                            style: AppTextStyles.bodyStrong,
                          ),
                        ),
                        SizedBox(
                          height: 22,
                          width: 22,
                          child: Checkbox(
                            value: _safetyDeclared,
                            onChanged: (v) => setState(
                              () => _safetyDeclared = v ?? false,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            activeColor: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This parcel does not contain cash, jewellery, '
                      'illegal items, weapons, explosives, alcohol, '
                      'tobacco, or any restricted goods.',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),
              PrimaryButton(
                label: 'Continue to Fare Estimate',
                enabled: _canContinue,
                onPressed: _canContinue ? _continue : null,
                trailing: const Icon(
                  Icons.arrow_forward,
                  size: 18,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  'Your parcel will be delivered safely and on time',
                  style: AppTextStyles.caption,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Small "| Heading" section label used throughout this screen.
class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(height: 14, width: 3, color: AppColors.black),
        const SizedBox(width: 8),
        Text(label, style: AppTextStyles.bodyStrong),
      ],
    );
  }
}

/// Back button + left-aligned title/subtitle + a single circular help
/// icon on the right — matches the reference header exactly.
class _ParcelDetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _ParcelDetailsAppBar({this.onHelp});
  final VoidCallback? onHelp;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 6, 16, 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, size: 20),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Parcel Details',
                    style: AppTextStyles.h1.copyWith(height: 1.15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Tell us about your parcel',
                    style: AppTextStyles.caption.copyWith(height: 1.2),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Material(
              color: Colors.transparent,
              shape: const CircleBorder(side: BorderSide(color: AppColors.grey200)),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onHelp,
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.help_outline,
                    size: 18,
                    color: AppColors.grey700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Icon-over-label tile for a "what are you sending" option, with a
/// small check badge when selected.
class _SendingTypeTile extends StatelessWidget {
  const _SendingTypeTile({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final _SendingOption option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 68,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    color: selected ? AppColors.black : AppColors.grey100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    option.icon,
                    size: 22,
                    color: selected ? AppColors.white : AppColors.grey700,
                  ),
                ),
                if (selected)
                  Positioned(
                    top: -4,
                    right: -4,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: AppColors.black,
                        shape: BoxShape.circle,
                        border: Border.fromBorderSide(
                          BorderSide(color: AppColors.white, width: 1.6),
                        ),
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 9,
                        color: AppColors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              option.label,
              style: AppTextStyles.caption.copyWith(
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? AppColors.black : AppColors.grey700,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// One of the three "Add Photos" upload squares.
class _PhotoSlot extends StatelessWidget {
  const _PhotoSlot({
    required this.bytes,
    required this.onTap,
    required this.onRemove,
  });

  final Uint8List? bytes;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: bytes == null ? onTap : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.grey50,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.divider),
          ),
          child: bytes != null
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.memory(bytes!, fit: BoxFit.cover),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: onRemove,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            color: AppColors.black,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 12,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: Icon(
                    Icons.file_upload_outlined,
                    size: 20,
                    color: AppColors.grey400,
                  ),
                ),
        ),
      ),
    );
  }
}

/// Compact vehicle option card shown in the horizontal "Vehicle for
/// You" row — icon, name, capacity, with a green ribbon on the
/// recommended option.
class _VehicleCard extends StatelessWidget {
  const _VehicleCard({
    required this.option,
    required this.selected,
    required this.recommended,
    required this.onTap,
  });

  final VehicleOptionModel option;
  final bool selected;
  final bool recommended;
  final VoidCallback onTap;

  IconData get _icon {
    switch (option.id) {
      case 'bike':
      case 'bikeXl':
        return Icons.pedal_bike_outlined;
      case 'auto':
        return Icons.electric_rickshaw_outlined;
      default:
        return Icons.local_shipping_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        width: 104,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: selected ? AppColors.grey50 : AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppColors.black : AppColors.divider,
            width: selected ? 1.6 : 1,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(_icon, size: 26, color: AppColors.black),
                  const SizedBox(height: 8),
                  Text(
                    option.name,
                    style: AppTextStyles.captionStrong,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    option.capacity,
                    style: AppTextStyles.caption.copyWith(fontSize: 10.5),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            if (recommended)
              Positioned(
                top: 0,
                right: 0,
                child: ClipPath(
                  clipper: _RibbonClipper(),
                  child: Container(
                    height: 22,
                    width: 22,
                    color: AppColors.accentGreen,
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.only(top: 3, right: 3),
                    child: const Icon(
                      Icons.check,
                      size: 10,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _RibbonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}