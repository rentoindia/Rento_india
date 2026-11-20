import '../core/api_client.dart';

import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/lender_service.dart';
import '../screens/category_data.dart';

class AddProductScreen extends StatefulWidget {
  final LenderProduct? existingProduct;
  const AddProductScreen({super.key, this.existingProduct});

  bool get isEditing => existingProduct != null;

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  static const Color _kDeepBlack = Color(0xFF0A0A0A);
  static const Color _kBorderGrey = Color(0xFFEDEDED);

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _mrpController;
  late final TextEditingController _dayPriceController;
  late final TextEditingController _weekPriceController;
  late final TextEditingController _monthPriceController;
  late final TextEditingController _depositController;
  late final TextEditingController _descriptionController;
  late String _category;
  late String _subcategory;

  bool _descriptionEditedManually = false;

  final List<String> _slotLabels = const ['Photo 1', 'Photo 2', 'Photo 3'];
  late List<XFile?> _newImages;
  late List<String?> _existingImagePaths;

  XFile? _newVideo;
  String? _existingVideoPath;

  late List<TextEditingController> _specLabelControllers;
  late List<TextEditingController> _specValueControllers;

  final List<String> _categories = categoryDataMap.keys.toList();

  @override
  void initState() {
    super.initState();
    final existing = widget.existingProduct;

    _nameController = TextEditingController(text: existing?.name ?? '');
    _mrpController = TextEditingController(text: existing?.mrp ?? '');
    _dayPriceController = TextEditingController(
      text: existing?.pricePerDay ?? '',
    );
    _weekPriceController = TextEditingController(
      text: existing?.pricePerWeek ?? '',
    );
    _monthPriceController = TextEditingController(
      text: existing?.pricePerMonth ?? '',
    );
    _depositController = TextEditingController(
      text: existing?.securityDeposit ?? '',
    );
    _descriptionController = TextEditingController(
      text: existing?.description ?? '',
    );
    _category = existing?.category ?? _categories.first;
    _subcategory =
        existing?.subcategory ??
        categoryDataMap[_category]!.subcategories.firstWhere(
          (e) => !e.startsWith('All '),
        );

    _descriptionEditedManually = (existing?.description ?? '').isNotEmpty;

    _newImages = [null, null, null];
    _existingImagePaths = existing != null
        ? List<String?>.from(existing.imagePaths.take(3))
        : [null, null, null];
    while (_existingImagePaths.length < 3) {
      _existingImagePaths.add(null);
    }

    _existingVideoPath = existing?.videoPath;

    final existingSpecs = existing?.specs ?? const [];
    _specLabelControllers = existingSpecs.isEmpty
        ? [TextEditingController(), TextEditingController()]
        : existingSpecs
              .map((s) => TextEditingController(text: s.label))
              .toList();
    _specValueControllers = existingSpecs.isEmpty
        ? [TextEditingController(), TextEditingController()]
        : existingSpecs
              .map((s) => TextEditingController(text: s.value))
              .toList();

    _nameController.addListener(_onNameChanged);

    for (final c in [
      _nameController,
      _mrpController,
      _dayPriceController,
      _weekPriceController,
      _monthPriceController,
      _depositController,
      _descriptionController,
    ]) {
      c.addListener(_refreshSubmitState);
    }
  }

  void _refreshSubmitState() {
    if (mounted) setState(() {});
  }

  void _onNameChanged() {
    if (_descriptionEditedManually) return;
    final name = _nameController.text.trim();
    _descriptionController.text = _buildAutoDescription(name, _category);
  }

  String _buildAutoDescription(String name, String category) {
    if (name.isEmpty) return '';
    return 'Rent this $name — a well-maintained $category item, ready for '
        'immediate use. Comes clean, fully functional, and includes all '
        'standard accessories. Perfect for short or long-term rental.';
  }

  bool get _hasAnyPhoto {
    for (var i = 0; i < 3; i++) {
      if ((_newImages[i]?.path ?? _existingImagePaths[i]) != null) return true;
    }
    return false;
  }

  bool get _canSubmit => _missingFieldName == null;

  String? get _missingFieldName {
    if (_nameController.text.trim().isEmpty) return 'Product Name';
    if (!_hasAnyPhoto) return 'At least 1 product photo';
    if (_mrpController.text.trim().isEmpty) return 'MRP (Original Price)';
    if (_dayPriceController.text.trim().isEmpty) return 'Per Day price';
    if (_weekPriceController.text.trim().isEmpty) return 'Per Week price';
    if (_monthPriceController.text.trim().isEmpty) return 'Per Month price';
    if (_depositController.text.trim().isEmpty) return 'Security Deposit';
    if (_descriptionController.text.trim().isEmpty) return 'Description';
    return null;
  }

  @override
  void dispose() {
    _nameController.removeListener(_onNameChanged);
    for (final c in [
      _nameController,
      _mrpController,
      _dayPriceController,
      _weekPriceController,
      _monthPriceController,
      _depositController,
      _descriptionController,
    ]) {
      c.removeListener(_refreshSubmitState);
    }
    _nameController.dispose();
    _mrpController.dispose();
    _dayPriceController.dispose();
    _weekPriceController.dispose();
    _monthPriceController.dispose();
    _depositController.dispose();
    _descriptionController.dispose();
    for (final c in _specLabelControllers) {
      c.dispose();
    }
    for (final c in _specValueControllers) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _pickImage(int slotIndex, ImageSource source) async {
    try {
      final picked = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1200,
        imageQuality: 85,
      );
      if (picked != null) {
        setState(() {
          _newImages[slotIndex] = picked;
          _existingImagePaths[slotIndex] = null;
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not access camera/gallery: $e')),
      );
    }
  }

  Future<void> _pickVideo(ImageSource source) async {
    try {
      final picked = await ImagePicker().pickVideo(source: source);
      if (picked != null) {
        setState(() {
          _newVideo = picked;
          _existingVideoPath = null;
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not access camera/gallery: $e')),
      );
    }
  }

  void _showImageSourceSheet(int slotIndex) {
    final hasPhoto =
        _newImages[slotIndex] != null || _existingImagePaths[slotIndex] != null;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: const Text('Take a photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(slotIndex, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Choose from gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(slotIndex, ImageSource.gallery);
              },
            ),
            if (hasPhoto)
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: const Text(
                  'Remove photo',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _newImages[slotIndex] = null;
                    _existingImagePaths[slotIndex] = null;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }

  void _showVideoSourceSheet() {
    final hasVideo = _newVideo != null || _existingVideoPath != null;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.videocam_outlined),
              title: const Text('Record a video'),
              onTap: () {
                Navigator.pop(context);
                _pickVideo(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_library_outlined),
              title: const Text('Choose from gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickVideo(ImageSource.gallery);
              },
            ),
            if (hasVideo)
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: const Text(
                  'Remove video',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _newVideo = null;
                    _existingVideoPath = null;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }

  void _addSpecRow() {
    setState(() {
      _specLabelControllers.add(TextEditingController());
      _specValueControllers.add(TextEditingController());
    });
  }

  void _removeSpecRow(int index) {
    setState(() {
      _specLabelControllers[index].dispose();
      _specValueControllers[index].dispose();
      _specLabelControllers.removeAt(index);
      _specValueControllers.removeAt(index);
    });
  }

  void _showSaveError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _submit() async {
    debugPrint('[AddProductScreen] _submit tapped');

    if (!_canSubmit) {
      debugPrint(
        '[AddProductScreen] Submit blocked. Missing: $_missingFieldName',
      );
      return;
    }

    final formValid = _formKey.currentState?.validate() ?? false;
    if (!formValid) {
      debugPrint('[AddProductScreen] Form validation failed.');
      return;
    }

    final resolvedPaths = List<String?>.generate(
      3,
      (i) => _newImages[i]?.path ?? _existingImagePaths[i],
    );
    final hasAnyPhoto = resolvedPaths.any((p) => p != null);
    if (!hasAnyPhoto) {
      debugPrint('[AddProductScreen] No product photo.');
      return;
    }

    final resolvedVideoPath = _newVideo?.path ?? _existingVideoPath;

    final specs = <ProductSpecEntry>[];
    for (var i = 0; i < _specLabelControllers.length; i++) {
      final label = _specLabelControllers[i].text.trim();
      final value = _specValueControllers[i].text.trim();
      if (label.isNotEmpty && value.isNotEmpty) {
        specs.add(ProductSpecEntry(label: label, value: value));
      }
    }

    if (widget.isEditing) {
      debugPrint('[AddProductScreen] Updating existing product...');
      try {
        await LenderService.instance.updateProduct(
          widget.existingProduct!.copyWith(
            name: _nameController.text.trim(),
            category: _category,
            subcategory: _subcategory,
            mrp: _mrpController.text.trim(),
            pricePerDay: _dayPriceController.text.trim(),
            pricePerWeek: _weekPriceController.text.trim(),
            pricePerMonth: _monthPriceController.text.trim(),
            securityDeposit: _depositController.text.trim(),
            description: _descriptionController.text.trim(),
            imagePaths: resolvedPaths,
            videoPath: resolvedVideoPath,
            clearVideo: resolvedVideoPath == null,
            specs: specs,
          ),
        );
      } on ApiException catch (e) {
        _showSaveError(e.message);
        return;
      }
    } else {
      debugPrint('[AddProductScreen] Adding new product...');
      try {
        await LenderService.instance.addProduct(
          name: _nameController.text.trim(),
          category: _category,
          subcategory: _subcategory,
          mrp: _mrpController.text.trim(),
          pricePerDay: _dayPriceController.text.trim(),
          pricePerWeek: _weekPriceController.text.trim(),
          pricePerMonth: _monthPriceController.text.trim(),
          securityDeposit: _depositController.text.trim(),
          description: _descriptionController.text.trim(),
          imagePaths: resolvedPaths,
          videoPath: resolvedVideoPath,
          specs: specs,
        );
      } on ApiException catch (e) {
        _showSaveError(e.message);
        return;
      }
    }

    debugPrint('[AddProductScreen] Product added/updated in LenderService.');

    if (!mounted) return;
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
      debugPrint('[AddProductScreen] Popped back to previous screen.');
    } else {
      debugPrint(
        '[AddProductScreen] Nothing to pop — no previous screen on the stack.',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Saved, but there was no previous screen to return to.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final canSubmit = _canSubmit;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: _kDeepBlack),
        title: Text(
          widget.isEditing ? 'Edit Product' : 'List a Product',
          style: const TextStyle(
            color: _kDeepBlack,
            fontWeight: FontWeight.w700,
            fontSize: 17,
            letterSpacing: 0.1,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _label('Product Photos (3)', required: true),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, i) => _photoSlot(i),
            ),
            const SizedBox(height: 18),

            _label('Product Video (optional)'),
            const SizedBox(height: 8),
            _videoSlot(),
            const SizedBox(height: 22),

            _label('Product Name', required: true),
            const SizedBox(height: 6),
            _textField(
              controller: _nameController,
              hint: 'e.g. Canon DSLR Camera',
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Enter a product name'
                  : null,
            ),
            const SizedBox(height: 18),

            _label('Category', required: true),
            const SizedBox(height: 6),
            _dropdownShell(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _category,
                  isExpanded: true,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                    color: _kDeepBlack,
                  ),
                  items: _categories
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (v) {
                    setState(() {
                      _category = v!;
                      _subcategory = categoryDataMap[_category]!.subcategories
                          .firstWhere((e) => !e.startsWith('All '));
                    });
                    _onNameChanged();
                  },
                ),
              ),
            ),

            const SizedBox(height: 18),

            _label('Subcategory', required: true),
            const SizedBox(height: 6),
            _dropdownShell(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _subcategory,
                  isExpanded: true,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                    color: _kDeepBlack,
                  ),
                  items: categoryDataMap[_category]!.subcategories
                      .where((e) => !e.startsWith('All '))
                      .map(
                        (sub) => DropdownMenuItem<String>(
                          value: sub,
                          child: Text(sub),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _subcategory = value!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 18),

            _label('MRP (Original Price) (₹)', required: true),
            const SizedBox(height: 3),
            Text(
              'The original price of this product when bought new.',
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 12,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 7),
            _textField(
              controller: _mrpController,
              hint: 'e.g. 45000',
              keyboardType: TextInputType.number,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Enter the original price (MRP)'
                  : null,
            ),
            const SizedBox(height: 22),

            _label('Pricing', required: true),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: _textField(
                    controller: _dayPriceController,
                    hint: 'Per Day (₹)',
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Required' : null,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _textField(
                    controller: _weekPriceController,
                    hint: 'Per Week (₹)',
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Required' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _textField(
              controller: _monthPriceController,
              hint: 'Per Month (₹)',
              keyboardType: TextInputType.number,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Enter a monthly price'
                  : null,
            ),
            const SizedBox(height: 18),

            _label('Security Deposit (₹, Refundable)', required: true),
            const SizedBox(height: 6),
            _textField(
              controller: _depositController,
              hint: 'e.g. 5000',
              keyboardType: TextInputType.number,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Enter a security deposit amount'
                  : null,
            ),
            const SizedBox(height: 22),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _label('Specifications'),
                TextButton.icon(
                  onPressed: _addSpecRow,
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text(
                    'Add spec',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  style: TextButton.styleFrom(foregroundColor: _kDeepBlack),
                ),
              ],
            ),
            Text(
              'e.g. "Sensor" → "APS-C 18MP", "Video" → "Full HD 1080p"',
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 12,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 10),
            ..._specRows(),
            const SizedBox(height: 22),

            _label('Description', required: true),
            const SizedBox(height: 3),
            Text(
              'Auto-filled from the product name — feel free to edit it.',
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 12,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 7),
            _textField(
              controller: _descriptionController,
              hint: 'Describe the condition, features, what\'s included...',
              maxLines: 4,
              onChanged: (_) => _descriptionEditedManually = true,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Add a short description'
                  : null,
            ),
            const SizedBox(height: 26),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: canSubmit ? _submit : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _kDeepBlack,
                  disabledBackgroundColor: Colors.grey.shade300,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27),
                  ),
                ),
                child: Text(
                  widget.isEditing ? 'Save Changes' : 'List Product',
                  style: TextStyle(
                    color: canSubmit ? Colors.white : Colors.grey.shade600,
                    fontWeight: FontWeight.w700,
                    fontSize: 15.5,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
            if (!canSubmit) ...[
              const SizedBox(height: 10),
              Text(
                'Still needed: ${_missingFieldName ?? "—"}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red.shade400,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
            ],
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  List<Widget> _specRows() {
    return List.generate(_specLabelControllers.length, (i) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: _textField(
                controller: _specLabelControllers[i],
                hint: 'Label (e.g. Sensor)',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 3,
              child: _textField(
                controller: _specValueControllers[i],
                hint: 'Value (e.g. APS-C 18MP)',
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, size: 18, color: Colors.black45),
              onPressed: _specLabelControllers.length > 1
                  ? () => _removeSpecRow(i)
                  : null,
            ),
          ],
        ),
      );
    });
  }

  Widget _photoSlot(int index) {
    final hasPhoto =
        _newImages[index] != null || _existingImagePaths[index] != null;
    return GestureDetector(
      onTap: () => _showImageSourceSheet(index),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _kBorderGrey),
        ),
        child: hasPhoto
            ? Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: _imagePreview(index),
                  ),
                  Positioned(
                    bottom: 4,
                    left: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        _slotLabels[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 11,
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_a_photo_outlined,
                    color: Colors.grey.shade500,
                    size: 20,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _slotLabels[index],
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _videoSlot() {
    final hasVideo = _newVideo != null || _existingVideoPath != null;
    return GestureDetector(
      onTap: _showVideoSourceSheet,
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _kBorderGrey),
        ),
        child: hasVideo
            ? Row(
                children: [
                  const SizedBox(width: 14),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.play_circle_fill,
                      color: Colors.black54,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Video attached',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: _kDeepBlack,
                      ),
                    ),
                  ),
                  const Icon(Icons.edit, size: 16, color: Colors.black45),
                  const SizedBox(width: 14),
                ],
              )
            : Row(
                children: [
                  const SizedBox(width: 14),
                  Icon(
                    Icons.videocam_outlined,
                    color: Colors.grey.shade500,
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Tap to add a product video',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _imagePreview(int index) {
    final path = _newImages[index]?.path ?? _existingImagePaths[index];
    if (path == null) return const SizedBox.shrink();

    if (kIsWeb || path.startsWith('http')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          color: const Color(0xFFF3F4F6),
          child: const Icon(Icons.image_outlined, color: Colors.grey),
        ),
      );
    }
    return Image.file(
      File(path),
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        color: const Color(0xFFF3F4F6),
        child: const Icon(Icons.image_outlined, color: Colors.grey),
      ),
    );
  }

  Widget _label(String text, {bool required = false}) => Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: RichText(
      text: TextSpan(
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: _kDeepBlack,
          letterSpacing: 0.1,
        ),
        children: [
          TextSpan(text: text),
          if (required)
            const TextSpan(
              text: '  *',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w700,
              ),
            ),
        ],
      ),
    ),
  );

  Widget _dropdownShell({required Widget child}) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _kBorderGrey),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
    child: child,
  );

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      onChanged: onChanged,
      validator: validator,
      style: const TextStyle(
        fontSize: 14.5,
        fontWeight: FontWeight.w500,
        color: _kDeepBlack,
        height: 1.3,
      ),
      cursorColor: _kDeepBlack,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 13.5,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _kBorderGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _kBorderGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _kDeepBlack, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.red.shade300),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.red.shade400, width: 1.4),
        ),
        errorStyle: TextStyle(color: Colors.red.shade400, fontSize: 11.5),
      ),
    );
  }
}
