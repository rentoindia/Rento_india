import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/primary_button.dart';
import '../models/receiver_model.dart';
import '../widgets/dashed_add_card.dart';
import '../widgets/receiver_card.dart';
import '../widgets/receiver_flow_app_bar.dart';
import 'manual_address_entry_screen.dart';
import 'receiver_information_screen.dart';

class SavedReceiversScreen extends StatefulWidget {
  const SavedReceiversScreen({super.key});

  @override
  State<SavedReceiversScreen> createState() => _SavedReceiversScreenState();
}

class _SavedReceiversScreenState extends State<SavedReceiversScreen> {
  ReceiverModel? _selected;

  void _continue() {
    final r = _selected;
    if (r == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ReceiverInformationScreen(
          receiverName: r.name,
          receiverPhone: r.phone,
          areaLabel: r.addressLabel,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: const ReceiverFlowAppBar(
        title: 'Saved Receivers',
        showActions: false,
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: kDemoReceivers.length + 1,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    if (index == kDemoReceivers.length) {
                      return DashedAddCard(
                        label: 'Add New Receiver',
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ManualAddressEntryScreen(),
                          ),
                        ),
                      );
                    }
                    final receiver = kDemoReceivers[index];
                    final isSelected = _selected?.id == receiver.id;
                    return AnimatedScale(
                      duration: const Duration(milliseconds: 180),
                      scale: isSelected ? 1.01 : 1.0,
                      child: ReceiverCard(
                        receiver: receiver,
                        onUse: () => setState(() => _selected = receiver),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              PrimaryButton(
                label: 'Continue for Parcel Details',
                enabled: _selected != null,
                onPressed: _selected != null ? _continue : null,
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
