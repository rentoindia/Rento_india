import '../../core/api_client.dart';
import '../core/my_house_api.dart';

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'payment_success_screen.dart';

class MaintenanceRequestScreen extends StatefulWidget {
  const MaintenanceRequestScreen({super.key});

  @override
  State<MaintenanceRequestScreen> createState() =>
      _MaintenanceRequestScreenState();
}

class _MaintenanceRequestScreenState extends State<MaintenanceRequestScreen> {
  String selectedCategory = 'Scrap Items';
  bool isRecording = false;
  bool submitted = false;
  final TextEditingController descController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController paymentAmountController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final List<Uint8List> pickedPhotos = [];

  bool paymentDone = false;

  static const Color primaryDark = Color(0xFF1A1A1A);
  static const Color bgLight = Color(0xFFF7F7F7);
  static const Color selectedBlue = Color(0xFF2F6BFF);

  final List<Map<String, dynamic>> categories = [
    {
      'label': 'Scrap Items',
      'image': 'assets/images/scrap_items.jpg',
      'icon': Icons.delete_sweep_rounded,
      'gradient': [const Color(0xFF9E9E9E), const Color(0xFF616161)],
    },
    {
      'label': 'Plumbing',
      'image': 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=300&q=80',
      'icon': Icons.plumbing_rounded,
      'gradient': [const Color(0xFF6FA8FF), const Color(0xFF2F6BFF)],
    },
    {
      'label': 'Electrical',
      'image': 'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?w=300&q=80',
      'icon': Icons.electrical_services_rounded,
      'gradient': [const Color(0xFFFFC15E), const Color(0xFFE08A00)],
    },
    {
      'label': 'Appliance',
      'image': 'https://images.unsplash.com/photo-1585771724684-38269d6639fd?w=300&q=80',
      'icon': Icons.kitchen_rounded,
      'gradient': [const Color(0xFFB99BFA), const Color(0xFF8B5CF6)],
    },
    {
      'label': 'Cleaning',
      'image': 'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=300&q=80',
      'icon': Icons.cleaning_services_rounded,
      'gradient': [const Color(0xFF5FE3C6), const Color(0xFF17A98B)],
    },
    {'label': 'Other', 'image': null, 'icon': null, 'gradient': null},
  ];

  Widget _categoryImage(String imageUrl, List<Color> gradient, IconData icon) {
    if (imageUrl.startsWith('assets/')) {
      return Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(child: Icon(icon, size: 26, color: Colors.white)),
        ),
      );
    }
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          color: const Color(0xFFF0F0F0),
          child: const Center(
            child: SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(child: Icon(icon, size: 26, color: Colors.white)),
      ),
    );
  }

  Widget _categoryTile(Map<String, dynamic> cat) {
    final bool selected = selectedCategory == cat['label'];
    final String? imageUrl = cat['image'];
    final IconData? icon = cat['icon'];
    final List<Color>? gradient = cat['gradient'];

    return GestureDetector(
      onTap: () => setState(() => selectedCategory = cat['label']),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: (MediaQuery.of(context).size.width - 32 - 30) / 4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? selectedBlue : const Color(0xFFECECEC),
            width: selected ? 1.6 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(selected ? 0.10 : 0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: imageUrl != null
                      ? _categoryImage(imageUrl, gradient!, icon!)
                      : Container(
                          color: const Color(0xFFF0F0F0),
                          child: const Center(
                            child: Icon(
                              Icons.more_horiz_rounded,
                              size: 24,
                              color: primaryDark,
                            ),
                          ),
                        ),
                ),
                if (selected)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: selectedBlue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 11,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: selected ? const Color(0xFFEAF0FF) : Colors.white,
              child: Text(
                cat['label'],
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                  color: primaryDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      if (source == ImageSource.gallery) {
        final List<XFile> picked = await _picker.pickMultiImage(
          imageQuality: 80,
        );

        if (picked.isNotEmpty) {
          final List<Uint8List> bytesList = await Future.wait(
            picked.map((f) => f.readAsBytes()),
          );

          setState(() {
            pickedPhotos.addAll(bytesList);
          });
        }
      } else {
        final XFile? picked = await _picker.pickImage(
          source: source,
          imageQuality: 80,
        );
        if (picked != null) {
          final Uint8List bytes = await picked.readAsBytes();
          setState(() => pickedPhotos.add(bytes));
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Could not pick image: $e')));
      }
    }
  }

  void _removePhoto(int index) {
    setState(() => pickedPhotos.removeAt(index));
  }

  void _showAddPhotoOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.photo_camera_rounded,
                  color: primaryDark,
                ),
                title: const Text('Take a photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_library_rounded,
                  color: primaryDark,
                ),
                title: const Text('Choose from gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPaymentMethodSheet() {
    final String payeeLabel = '$selectedCategory Service';
    final methods = [
      {
        'label': 'UPI',
        'sub': 'Google Pay, PhonePe, Paytm',
        'icon': Icons.qr_code_rounded,
        'color': const Color(0xFF10B981),
      },
      {
        'label': 'Credit / Debit Card',
        'sub': 'Visa, Mastercard, RuPay',
        'icon': Icons.credit_card_rounded,
        'color': const Color(0xFF3B82F6),
      },
      {
        'label': 'Net Banking',
        'sub': 'All major banks',
        'icon': Icons.account_balance_rounded,
        'color': const Color(0xFF8B5CF6),
      },
      {
        'label': 'Wallet',
        'sub': 'Amazon Pay, Mobikwik',
        'icon': Icons.account_balance_wallet_rounded,
        'color': const Color(0xFF616161),
      },
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  20,
                  12,
                  20,
                  20 + MediaQuery.of(context).viewInsets.bottom,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 18),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Text(
                        'Pay for $selectedCategory',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: primaryDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Enter an amount, then choose how to pay.',
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: paymentAmountController,
                        keyboardType: TextInputType.number,
                        autofocus: true,
                        onChanged: (_) => setSheetState(() {}),
                        decoration: InputDecoration(
                          prefixText: '₹ ',
                          hintText: 'Enter amount',
                          filled: true,
                          fillColor: const Color(0xFFF7F7F7),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      ...methods.map(
                        (m) => Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFECEDF3)),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 4,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            leading: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: (m['color'] as Color).withOpacity(0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                m['icon'] as IconData,
                                color: m['color'] as Color,
                                size: 20,
                              ),
                            ),
                            title: Text(
                              m['label'] as String,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            subtitle: Text(
                              m['sub'] as String,
                              style: TextStyle(
                                fontSize: 11.5,
                                color: Colors.grey[500],
                              ),
                            ),
                            trailing: const Icon(
                              Icons.chevron_right_rounded,
                              color: Colors.grey,
                            ),
                            onTap: () {
                              final amount = paymentAmountController.text
                                  .trim();
                              if (amount.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Enter an amount before paying',
                                    ),
                                  ),
                                );
                                return;
                              }
                              Navigator.pop(context);
                              setState(() => paymentDone = true);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaymentSuccessScreen(
                                    amount: '₹$amount',
                                    payee: payeeLabel,
                                    paymentMethod: '${m['label']} - Google Pay',
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(message, style: const TextStyle(fontSize: 13)),
            ),
          ],
        ),
        backgroundColor: Colors.red[700],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (descController.text.trim().isEmpty) {
      _showError('Please describe the issue before submitting');
      return;
    }
    if (addressController.text.trim().isEmpty) {
      _showError('Please enter the address before submitting');
      return;
    }
    if (phoneController.text.trim().isEmpty) {
      _showError('Please enter a phone number before submitting');
      return;
    }
    if (phoneController.text.trim().length < 10) {
      _showError('Please enter a valid phone number');
      return;
    }
    try {
      await MyHouseApi.instance.raiseMaintenance(
        issue: '${selectedCategory ?? 'Maintenance'} issue',
        category: selectedCategory?.toString().toLowerCase(),
        description: descController.text.trim(),
        location: addressController.text.trim(),
      );
    } on ApiException catch (e) {
      if (!mounted) return;
      _showError(e.message);
      return;
    }
    if (!mounted) return;
    setState(() => submitted = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 18),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Maintenance request submitted successfully!',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
        backgroundColor: primaryDark,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgLight,
      appBar: AppBar(
        backgroundColor: bgLight,
        elevation: 0,
        iconTheme: const IconThemeData(color: primaryDark),
        title: const Text(
          'Raise Maintenance',
          style: TextStyle(
            color: primaryDark,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Issue Category',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: primaryDark,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: categories.map((c) => _categoryTile(c)).toList(),
            ),

            const SizedBox(height: 26),
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: primaryDark,
              ),
            ),
            const SizedBox(height: 10),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isRecording ? primaryDark : const Color(0xFFECECEC),
                  width: isRecording ? 1.6 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Stack(
                  children: [
                    TextField(
                      controller: descController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 50, 12),
                        hintText: 'Describe the issue (e.g. Leaking pipe in the bathroom)',
                        hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ),
                    Positioned(
                      top: 6,
                      right: 6,
                      child: GestureDetector(
                        onTap: () {
                          setState(() => isRecording = !isRecording);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isRecording ? Colors.red : primaryDark,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isRecording
                                ? Icons.stop_rounded
                                : Icons.mic_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isRecording)
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 4),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Recording...',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 26),
            const Text(
              'Address',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: primaryDark,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFECECEC)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: addressController,
                maxLines: 2,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(14),
                  hintText: 'Enter flat / house no., street, area',
                  hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.location_on_outlined,
                    color: primaryDark,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),
            const Text(
              'Phone Number',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: primaryDark,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFECECEC)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(14),
                  hintText: 'Enter 10-digit phone number',
                  hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                  prefixIcon: Icon(Icons.call_outlined, color: primaryDark),
                  counterText: '',
                ),
              ),
            ),

            const SizedBox(height: 26),
            const Text(
              'Add Photos',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: primaryDark,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ...List.generate(pickedPhotos.length, (i) => _photoThumb(i)),
                _addPhotoBox(),
              ],
            ),

            const SizedBox(height: 6),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: submitted ? Colors.green[700] : primaryDark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  submitted ? 'Request Submitted ✓' : 'Submit Request',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _paymentSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFECECEC)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add Payment',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: primaryDark,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'If this service needs an upfront charge (e.g. parts, pickup fee), pay here.',
            style: TextStyle(fontSize: 11.5, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton.icon(
              onPressed: paymentDone ? null : _showPaymentMethodSheet,
              icon: Icon(
                paymentDone ? Icons.check_circle : Icons.payment_rounded,
                size: 18,
                color: Colors.white,
              ),
              label: Text(
                paymentDone ? 'Payment Done ✓' : 'Pay Now',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: paymentDone ? Colors.green[700] : primaryDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _photoThumb(int index) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.memory(
            pickedPhotos[index],
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: -6,
          right: -6,
          child: GestureDetector(
            onTap: () => _removePhoto(index),
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: primaryDark,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 12, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _addPhotoBox() {
    return GestureDetector(
      onTap: _showAddPhotoOptions,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFDADADA)),
        ),
        child: const Icon(Icons.add, color: Color(0xFF1A1A1A)),
      ),
    );
  }
}
