import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/section_card.dart';
import '../models/receiver_model.dart';
import '../widgets/receiver_card.dart';
import '../widgets/receiver_flow_app_bar.dart';
import 'receiver_information_screen.dart';
import 'saved_receivers_screen.dart';

const _kAddressTypes = ['Home', 'Work', 'Other'];

class ManualAddressEntryScreen extends StatefulWidget {
  const ManualAddressEntryScreen({super.key});

  @override
  State<ManualAddressEntryScreen> createState() =>
      _ManualAddressEntryScreenState();
}

class _ManualAddressEntryScreenState extends State<ManualAddressEntryScreen> {
  final _addressController = TextEditingController();
  final _landmarkController = TextEditingController();
  final _cityController = TextEditingController(text: 'Mumbai');
  final _pincodeController = TextEditingController();
  String _addressType = 'Home';

  @override
  void dispose() {
    _addressController.dispose();
    _landmarkController.dispose();
    _cityController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  bool get _canContinue =>
      _addressController.text.trim().isNotEmpty &&
      _cityController.text.trim().isNotEmpty &&
      _pincodeController.text.trim().length >= 5;

  void _continue() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ReceiverInformationScreen(
          receiverName: 'Rohan Verma',
          receiverPhone: '+91 93456 78901',
          areaLabel:
              '${_addressController.text.trim()}, ${_cityController.text.trim()}',
          pincode: _pincodeController.text.trim(),
        ),
      ),
    );
  }

  void _useReceiver(ReceiverModel receiver) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ReceiverInformationScreen(
          receiverName: receiver.name,
          receiverPhone: receiver.phone,
          areaLabel: receiver.addressLabel,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recent = kDemoReceivers.take(2).toList();

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: const ReceiverFlowAppBar(
        title: 'Manual Address Entry',
        showActions: false,
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ADDRESS', style: AppTextStyles.overline),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _addressController,
                            onChanged: (_) => setState(() {}),
                            style: AppTextStyles.body,
                            decoration: const InputDecoration(
                              hintText: 'e.g. Carter Road, Bandra West',
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text('LANDMARK', style: AppTextStyles.overline),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _landmarkController,
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
                                    Text(
                                      'CITY *',
                                      style: AppTextStyles.overline,
                                    ),
                                    const SizedBox(height: 6),
                                    TextField(
                                      controller: _cityController,
                                      onChanged: (_) => setState(() {}),
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
                                      controller: _pincodeController,
                                      onChanged: (_) => setState(() {}),
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
                            initialValue: _addressType,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              size: 20,
                            ),
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.black,
                            ),
                            decoration: const InputDecoration(),
                            items: _kAddressTypes
                                .map(
                                  (t) => DropdownMenuItem(
                                    value: t,
                                    child: Text(t),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) => setState(
                              () => _addressType = v ?? _addressType,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'Recent Receivers',
                          style: AppTextStyles.bodyStrong,
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const SavedReceiversScreen(),
                            ),
                          ),
                          child: Text(
                            'See all →',
                            style: AppTextStyles.captionStrong.copyWith(
                              color: AppColors.accentBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    for (final r in recent) ...[
                      ReceiverCard(receiver: r, onUse: () => _useReceiver(r)),
                      const SizedBox(height: 10),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 8),
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
