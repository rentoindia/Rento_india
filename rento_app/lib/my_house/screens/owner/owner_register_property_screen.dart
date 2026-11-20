// import 'package:flutter/material.dart';

// /// RENTO INDIA — Owner Flow Screen 1: Register & List Property
// /// Matches Figma: "Add Property" screen (Owner Flow)
// class OwnerRegisterPropertyScreen extends StatefulWidget {
//   const OwnerRegisterPropertyScreen({super.key});

//   @override
//   State<OwnerRegisterPropertyScreen> createState() =>
//       _OwnerRegisterPropertyScreenState();
// }

// class _OwnerRegisterPropertyScreenState
//     extends State<OwnerRegisterPropertyScreen> {
//   // ---------- Colors (match Rento India theme) ----------
//   static const Color primaryDark = Color(0xFF14152B);
//   static const Color bgGrey = Color(0xFFF6F6F8);
//   static const Color borderGrey = Color(0xFFE3E3E8);
//   static const Color textGrey = Color(0xFF8A8A93);

//   // ---------- Form state ----------
//   final _formKey = GlobalKey<FormState>();

//   String? _propertyType = 'Apartment';
//   String _bhkType = '2 BHK';
//   final TextEditingController _floorController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _localityController = TextEditingController();
//   String? _furnishing = 'Semi-Furnished';
//   final TextEditingController _rentController = TextEditingController();
//   final TextEditingController _depositController = TextEditingController();

//   final List<String> _propertyTypes = [
//     'Apartment',
//     'Independent House',
//     'Villa',
//     'PG / Hostel',
//   ];

//   final List<String> _bhkOptions = ['1 BHK', '2 BHK', '3 BHK', 'Studio'];

//   final List<String> _furnishingOptions = [
//     'Furnished',
//     'Semi-Furnished',
//     'Unfurnished',
//   ];

//   // Uploaded photo placeholders (max 4 shown, min 4 required per spec)
//   final List<String> _uploadedPhotos = [];

//   @override
//   void dispose() {
//     _floorController.dispose();
//     _addressController.dispose();
//     _localityController.dispose();
//     _rentController.dispose();
//     _depositController.dispose();
//     super.dispose();
//   }

//   void _pickPhoto() {
//     // TODO: wire to image_picker package
//     setState(() {
//       if (_uploadedPhotos.length < 6) {
//         _uploadedPhotos.add('photo_${_uploadedPhotos.length + 1}');
//       }
//     });
//   }

//   void _submitProperty() {
//     if (_formKey.currentState?.validate() ?? false) {
//       if (_uploadedPhotos.length < 4) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Please upload at least 4 property photos'),
//           ),
//         );
//         return;
//       }
//       // TODO: send data to backend / next screen
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Property submitted for review')),
//       );
//       // Navigator.pushNamed(context, '/owner/property-list');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: bgGrey,
//       appBar: AppBar(
//         backgroundColor: bgGrey,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: primaryDark),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Add Property',
//           style: TextStyle(
//             color: primaryDark,
//             fontWeight: FontWeight.w600,
//             fontSize: 18,
//           ),
//         ),
//         centerTitle: false,
//       ),
//       body: SafeArea(
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
//             children: [
//               _sectionLabel('Property Type'),
//               _dropdownField(
//                 value: _propertyType,
//                 items: _propertyTypes,
//                 onChanged: (v) => setState(() => _propertyType = v),
//               ),
//               const SizedBox(height: 18),

//               _sectionLabel('BHK Type'),
//               _chipSelector(
//                 options: _bhkOptions,
//                 selected: _bhkType,
//                 onSelect: (v) => setState(() => _bhkType = v),
//               ),
//               const SizedBox(height: 18),

//               _sectionLabel('Floor'),
//               _textField(
//                 controller: _floorController,
//                 hint: 'e.g. 3rd Floor',
//                 keyboardType: TextInputType.text,
//               ),
//               const SizedBox(height: 18),

//               _sectionLabel('Address'),
//               _textField(
//                 controller: _addressController,
//                 hint: 'House / Street / Area',
//                 maxLines: 2,
//               ),
//               const SizedBox(height: 18),

//               _sectionLabel('Locality'),
//               _textField(
//                 controller: _localityController,
//                 hint: 'e.g. Anjana Nagar, Chennai',
//               ),
//               const SizedBox(height: 18),

//               _sectionLabel('Furnishing'),
//               _dropdownField(
//                 value: _furnishing,
//                 items: _furnishingOptions,
//                 onChanged: (v) => setState(() => _furnishing = v),
//               ),
//               const SizedBox(height: 18),

//               _sectionLabel('Monthly Rent'),
//               _textField(
//                 controller: _rentController,
//                 hint: '₹ 12,000',
//                 keyboardType: TextInputType.number,
//                 prefixText: '₹ ',
//               ),
//               const SizedBox(height: 18),

//               _sectionLabel('Deposit Amount'),
//               _textField(
//                 controller: _depositController,
//                 hint: '₹ 36,000',
//                 keyboardType: TextInputType.number,
//                 prefixText: '₹ ',
//               ),
//               const SizedBox(height: 18),

//               _sectionLabel('Upload Photos (min. 4)'),
//               const SizedBox(height: 10),
//               _photoGrid(),

//               const SizedBox(height: 32),
//               SizedBox(
//                 width: double.infinity,
//                 height: 52,
//                 child: ElevatedButton(
//                   onPressed: _submitProperty,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: primaryDark,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     elevation: 0,
//                   ),
//                   child: const Text(
//                     'Submit Property',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ---------- Reusable pieces ----------

//   Widget _sectionLabel(String text) => Padding(
//         padding: const EdgeInsets.only(bottom: 8),
//         child: Text(
//           text,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//             color: primaryDark,
//           ),
//         ),
//       );

//   Widget _textField({
//     required TextEditingController controller,
//     required String hint,
//     TextInputType keyboardType = TextInputType.text,
//     int maxLines = 1,
//     String? prefixText,
//   }) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       maxLines: maxLines,
//       validator: (v) =>
//           (v == null || v.trim().isEmpty) ? 'This field is required' : null,
//       decoration: InputDecoration(
//         hintText: hint,
//         prefixText: prefixText,
//         hintStyle: const TextStyle(color: textGrey, fontSize: 14),
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding:
//             const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: borderGrey),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: borderGrey),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: primaryDark, width: 1.4),
//         ),
//       ),
//     );
//   }

//   Widget _dropdownField({
//     required String? value,
//     required List<String> items,
//     required ValueChanged<String?> onChanged,
//   }) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: borderGrey),
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           value: value,
//           isExpanded: true,
//           icon: const Icon(Icons.keyboard_arrow_down, color: primaryDark),
//           style: const TextStyle(color: primaryDark, fontSize: 14),
//           items: items
//               .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//               .toList(),
//           onChanged: onChanged,
//         ),
//       ),
//     );
//   }

//   Widget _chipSelector({
//     required List<String> options,
//     required String selected,
//     required ValueChanged<String> onSelect,
//   }) {
//     return Wrap(
//       spacing: 10,
//       runSpacing: 10,
//       children: options.map((option) {
//         final bool isSelected = option == selected;
//         return GestureDetector(
//           onTap: () => onSelect(option),
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 150),
//             padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
//             decoration: BoxDecoration(
//               color: isSelected ? primaryDark : Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(
//                 color: isSelected ? primaryDark : borderGrey,
//               ),
//             ),
//             child: Text(
//               option,
//               style: TextStyle(
//                 color: isSelected ? Colors.white : primaryDark,
//                 fontSize: 13,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   Widget _photoGrid() {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: _uploadedPhotos.length + 1,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 4,
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,
//       ),
//       itemBuilder: (context, index) {
//         if (index == _uploadedPhotos.length) {
//           // "+" add tile
//           return GestureDetector(
//             onTap: _pickPhoto,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: borderGrey),
//               ),
//               child: const Icon(Icons.add, color: textGrey),
//             ),
//           );
//         }
//         return Container(
//           decoration: BoxDecoration(
//             color: borderGrey,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: const Icon(Icons.image, color: Colors.white70),
//         );
//       },
//     );
//   }
// }



import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// RENTO INDIA — Owner Flow Screen 1: Register & List Property
/// Matches Figma: "Add Property" screen (Owner Flow)
class OwnerRegisterPropertyScreen extends StatefulWidget {
  const OwnerRegisterPropertyScreen({super.key});

  @override
  State<OwnerRegisterPropertyScreen> createState() =>
      _OwnerRegisterPropertyScreenState();
}

class _OwnerRegisterPropertyScreenState
    extends State<OwnerRegisterPropertyScreen> {
  // ---------- Colors (match Rento India theme) ----------
  static const Color primaryDark = Color(0xFF14152B);
  static const Color bgGrey = Color(0xFFF6F6F8);
  static const Color borderGrey = Color(0xFFE3E3E8);
  static const Color textGrey = Color(0xFF8A8A93);

  // ---------- Form state ----------
  final _formKey = GlobalKey<FormState>();

  String? _propertyType = 'Apartment';
  String _bhkType = '2 BHK';
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _localityController = TextEditingController();
  String? _furnishing = 'Semi-Furnished';
  final TextEditingController _rentController = TextEditingController();
  final TextEditingController _depositController = TextEditingController();

  final List<String> _propertyTypes = [
    'Apartment',
    'Independent House',
    'Villa',
    'PG / Hostel',
  ];

  final List<String> _bhkOptions = ['1 BHK', '2 BHK', '3 BHK', 'Studio'];

  final List<String> _furnishingOptions = [
    'Furnished',
    'Semi-Furnished',
    'Unfurnished',
  ];

  // Uploaded photos, stored as raw bytes (Uint8List) instead of a String
  // placeholder — Uint8List + Image.memory() works on Web, Android, and
  // iOS (unlike dart:io File, which fails on Flutter Web).
  final ImagePicker _picker = ImagePicker();
  final List<Uint8List> _uploadedPhotos = [];

  @override
  void dispose() {
    _floorController.dispose();
    _addressController.dispose();
    _localityController.dispose();
    _rentController.dispose();
    _depositController.dispose();
    super.dispose();
  }

  /// Handles both camera and gallery picking.
  /// - Camera: single photo only.
  /// - Gallery: supports picking MULTIPLE photos at once via
  ///   `pickMultiImage()`. No limit on how many can be added.
  Future<void> _pickImage(ImageSource source) async {
    try {
      if (source == ImageSource.gallery) {
        final List<XFile> picked = await _picker.pickMultiImage(
          imageQuality: 80,
        );

        if (picked.isNotEmpty) {
          final List<Uint8List> bytesList =
              await Future.wait(picked.map((f) => f.readAsBytes()));

          setState(() {
            _uploadedPhotos.addAll(bytesList);
          });
        }
      } else {
        final XFile? picked = await _picker.pickImage(
          source: source,
          imageQuality: 80,
        );
        if (picked != null) {
          final Uint8List bytes = await picked.readAsBytes();
          setState(() => _uploadedPhotos.add(bytes));
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not pick image: $e')),
        );
      }
    }
  }

  void _removePhoto(int index) {
    setState(() => _uploadedPhotos.removeAt(index));
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
                leading: const Icon(Icons.photo_camera_rounded, color: primaryDark),
                title: const Text('Take a photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_rounded, color: primaryDark),
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

  void _submitProperty() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_uploadedPhotos.length < 4) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please upload at least 4 property photos'),
          ),
        );
        return;
      }
      // TODO: send data to backend / next screen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Property submitted for review')),
      );
      // Navigator.pushNamed(context, '/owner/property-list');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGrey,
      appBar: AppBar(
        backgroundColor: bgGrey,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Property',
          style: TextStyle(
            color: primaryDark,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            children: [
              _sectionLabel('Property Type'),
              _dropdownField(
                value: _propertyType,
                items: _propertyTypes,
                onChanged: (v) => setState(() => _propertyType = v),
              ),
              const SizedBox(height: 18),

              _sectionLabel('BHK Type'),
              _chipSelector(
                options: _bhkOptions,
                selected: _bhkType,
                onSelect: (v) => setState(() => _bhkType = v),
              ),
              const SizedBox(height: 18),

              _sectionLabel('Floor'),
              _textField(
                controller: _floorController,
                hint: 'e.g. 3rd Floor',
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 18),

              _sectionLabel('Address'),
              _textField(
                controller: _addressController,
                hint: 'House / Street / Area',
                maxLines: 2,
              ),
              const SizedBox(height: 18),

              _sectionLabel('Locality'),
              _textField(
                controller: _localityController,
                hint: 'e.g. Anjana Nagar, Chennai',
              ),
              const SizedBox(height: 18),

              _sectionLabel('Furnishing'),
              _dropdownField(
                value: _furnishing,
                items: _furnishingOptions,
                onChanged: (v) => setState(() => _furnishing = v),
              ),
              const SizedBox(height: 18),

              _sectionLabel('Monthly Rent'),
              _textField(
                controller: _rentController,
                hint: '₹ 12,000',
                keyboardType: TextInputType.number,
                prefixText: '₹ ',
              ),
              const SizedBox(height: 18),

              _sectionLabel('Deposit Amount'),
              _textField(
                controller: _depositController,
                hint: '₹ 36,000',
                keyboardType: TextInputType.number,
                prefixText: '₹ ',
              ),
              const SizedBox(height: 18),

              _sectionLabel('Upload Photos'),
              const SizedBox(height: 10),
              _photoGrid(),

              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _submitProperty,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Submit Property',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- Reusable pieces ----------

  Widget _sectionLabel(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryDark,
          ),
        ),
      );

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? prefixText,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: (v) =>
          (v == null || v.trim().isEmpty) ? 'This field is required' : null,
      decoration: InputDecoration(
        hintText: hint,
        prefixText: prefixText,
        hintStyle: const TextStyle(color: textGrey, fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryDark, width: 1.4),
        ),
      ),
    );
  }

  Widget _dropdownField({
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderGrey),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: primaryDark),
          style: const TextStyle(color: primaryDark, fontSize: 14),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _chipSelector({
    required List<String> options,
    required String selected,
    required ValueChanged<String> onSelect,
  }) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((option) {
        final bool isSelected = option == selected;
        return GestureDetector(
          onTap: () => onSelect(option),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? primaryDark : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? primaryDark : borderGrey,
              ),
            ),
            child: Text(
              option,
              style: TextStyle(
                color: isSelected ? Colors.white : primaryDark,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _photoGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _uploadedPhotos.length + 1,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        if (index == _uploadedPhotos.length) {
          // "+" add tile
          return GestureDetector(
            onTap: _showAddPhotoOptions,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: borderGrey),
              ),
              child: const Icon(Icons.add, color: textGrey),
            ),
          );
        }
        return Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.memory(
                _uploadedPhotos[index],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
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
      },
    );
  }
}