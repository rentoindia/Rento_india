import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/section_card.dart';
import '../models/address_model.dart';
import '../providers/booking_provider.dart';
import '../widgets/receiver_flow_app_bar.dart';
import '../widgets/verified_badge.dart';
import 'parcel_details_screen.dart';

/// Confirms the receiver's name/phone (carried over from the previous
/// step) and collects the remaining address specifics — house/flat and
/// street/area — before handing off to Parcel Details.
class ReceiverInformationScreen extends ConsumerStatefulWidget {
  const ReceiverInformationScreen({
    super.key,
    required this.receiverName,
    required this.receiverPhone,
    this.areaLabel = 'Bandra West, Mumbai',
    this.pincode = '400 050',
  });

  final String receiverName;
  final String receiverPhone;
  final String areaLabel;
  final String pincode;

  @override
  ConsumerState<ReceiverInformationScreen> createState() =>
      _ReceiverInformationScreenState();
}

class _ReceiverInformationScreenState
    extends ConsumerState<ReceiverInformationScreen> {
  final _houseController = TextEditingController();
  final _streetController = TextEditingController();

  @override
  void dispose() {
    _houseController.dispose();
    _streetController.dispose();
    super.dispose();
  }

  bool get _canContinue =>
      _houseController.text.trim().isNotEmpty &&
      _streetController.text.trim().isNotEmpty;

  void _copy(String value, String label) {
    Clipboard.setData(ClipboardData(text: value));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copied'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _continue() {
    ref
        .read(bookingProvider.notifier)
        .setReceiver(
          AddressModel(
            label: _houseController.text.trim(),
            fullAddress:
                '${_streetController.text.trim()}, ${widget.areaLabel} - ${widget.pincode}',
            contactName: widget.receiverName,
            contactPhone: widget.receiverPhone,
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
      appBar: const ReceiverFlowAppBar(
        title: 'Receiver Information',
        showActions: false,
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Receiver Information',
                                style: AppTextStyles.bodyStrong,
                              ),
                              const Spacer(),
                              const VerifiedBadge(),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text('RECEIVER NAME', style: AppTextStyles.overline),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.receiverName,
                                  style: AppTextStyles.h2,
                                ),
                              ),
                              _SmallIconButton(
                                icon: Icons.copy_outlined,
                                onTap: () => _copy(widget.receiverName, 'Name'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Text('MOBILE NUMBER', style: AppTextStyles.overline),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.receiverPhone,
                                  style: AppTextStyles.h2,
                                ),
                              ),
                              _SmallIconButton(
                                icon: Icons.copy_outlined,
                                onTap: () =>
                                    _copy(widget.receiverPhone, 'Number'),
                              ),
                              const SizedBox(width: 8),
                              _SmallIconButton(
                                icon: Icons.call,
                                filled: true,
                                onTap: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('Address Details', style: AppTextStyles.bodyStrong),
                    const SizedBox(height: 10),
                    SectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'HOUSE / FLAT / BUILDING',
                            style: AppTextStyles.overline,
                          ),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _houseController,
                            onChanged: (_) => setState(() {}),
                            style: AppTextStyles.body,
                            decoration: const InputDecoration(
                              hintText: 'e.g. Flat 4B, Ocean Heights',
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text('STREET / AREA', style: AppTextStyles.overline),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _streetController,
                            onChanged: (_) => setState(() {}),
                            style: AppTextStyles.body,
                            decoration: const InputDecoration(
                              hintText: 'e.g. Carter Road, Bandra West',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              PrimaryButton(
                label: 'Continue for Parcel Details',
                enabled: _canContinue,
                onPressed: _canContinue ? _continue : null,
                trailing: const Icon(
                  Icons.arrow_forward,
                  size: 18,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SmallIconButton extends StatelessWidget {
  const _SmallIconButton({
    required this.icon,
    required this.onTap,
    this.filled = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: filled ? AppColors.accentGreenBg : AppColors.grey50,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            size: 16,
            color: filled ? AppColors.accentGreen : AppColors.grey700,
          ),
        ),
      ),
    );
  }
}
