// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// /// Result handed back to ProfileScreen when the user saves changes.
// class EditProfileResult {
//   final String name;
//   final String phone;
//   final File? avatar;
//   const EditProfileResult({required this.name, required this.phone, this.avatar});
// }

// class EditProfileScreen extends StatefulWidget {
//   final String initialName;
//   final String initialPhone;
//   final File? initialAvatar;

//   const EditProfileScreen({
//     super.key,
//     required this.initialName,
//     required this.initialPhone,
//     this.initialAvatar,
//   });

//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   late final TextEditingController _nameController;
//   late final TextEditingController _phoneController;
//   File? _avatar;

//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(text: widget.initialName);
//     _phoneController = TextEditingController(text: widget.initialPhone);
//     _avatar = widget.initialAvatar;
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _phoneController.dispose();
//     super.dispose();
//   }

//   Future<void> _pickAvatar() async {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
//       builder: (sheetContext) => SafeArea(
//         child: Wrap(
//           children: [
//             ListTile(
//               leading: const Icon(Icons.photo_camera_outlined),
//               title: const Text('Take a photo'),
//               onTap: () async {
//                 Navigator.pop(sheetContext);
//                 await _pickFrom(ImageSource.camera);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.photo_library_outlined),
//               title: const Text('Choose from gallery'),
//               onTap: () async {
//                 Navigator.pop(sheetContext);
//                 await _pickFrom(ImageSource.gallery);
//               },
//             ),
//             if (_avatar != null)
//               ListTile(
//                 leading: const Icon(Icons.delete_outline, color: Colors.redAccent),
//                 title: const Text('Remove photo', style: TextStyle(color: Colors.redAccent)),
//                 onTap: () {
//                   Navigator.pop(sheetContext);
//                   setState(() => _avatar = null);
//                 },
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _pickFrom(ImageSource source) async {
//     try {
//       final picked = await ImagePicker().pickImage(source: source, maxWidth: 800, imageQuality: 85);
//       if (picked != null) setState(() => _avatar = File(picked.path));
//     } catch (e) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not open image picker: $e')));
//     }
//   }

//   void _save() {
//     final name = _nameController.text.trim();
//     final phone = _phoneController.text.trim();
//     if (name.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Name cannot be empty')),
//       );
//       return;
//     }
//     Navigator.pop(context, EditProfileResult(name: name, phone: phone, avatar: _avatar));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         foregroundColor: Colors.black,
//         title: const Text('Edit Profile',
//             style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: Colors.black)),
//       ),
//       body: SafeArea(
//         child: ListView(
//           padding: const EdgeInsets.all(20),
//           children: [
//             Center(
//               child: GestureDetector(
//                 onTap: _pickAvatar,
//                 child: Stack(
//                   children: [
//                     Container(
//                       width: 88,
//                       height: 88,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(color: const Color(0xFFF0F0F0), width: 2),
//                       ),
//                       child: CircleAvatar(
//                         backgroundColor: const Color(0xFFF3F4F6),
//                         backgroundImage: _avatar != null ? FileImage(_avatar!) : null,
//                         child: _avatar == null
//                             ? const Icon(Icons.person, size: 44, color: Colors.black87)
//                             : null,
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: Container(
//                         padding: const EdgeInsets.all(6),
//                         decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
//                         child: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 28),
//             const Text('Full Name', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
//             const SizedBox(height: 8),
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(
//                 hintText: 'Enter your name',
//                 filled: true,
//                 fillColor: const Color(0xFFF7F8FA),
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 18),
//             const Text('Phone Number', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
//             const SizedBox(height: 8),
//             TextField(
//               controller: _phoneController,
//               keyboardType: TextInputType.phone,
//               decoration: InputDecoration(
//                 hintText: 'Enter your phone number',
//                 filled: true,
//                 fillColor: const Color(0xFFF7F8FA),
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 32),
//             SizedBox(
//               width: double.infinity,
//               height: 52,
//               child: ElevatedButton(
//                 onPressed: _save,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.black,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
//                   elevation: 0,
//                 ),
//                 child: const Text('Save Changes',
//                     style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Result handed back to ProfileScreen when the user saves changes.
class EditProfileResult {
  final String name;
  final String phone;
  final File? avatar;
  const EditProfileResult({required this.name, required this.phone, this.avatar});
}

class EditProfileScreen extends StatefulWidget {
  final String initialName;
  final String initialPhone;
  final File? initialAvatar;

  const EditProfileScreen({
    super.key,
    required this.initialName,
    required this.initialPhone,
    this.initialAvatar,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  File? _avatar;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _phoneController = TextEditingController(text: widget.initialPhone);
    _avatar = widget.initialAvatar;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickAvatar() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (sheetContext) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: const Text('Take a photo'),
              onTap: () async {
                Navigator.pop(sheetContext);
                await _pickFrom(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Choose from gallery'),
              onTap: () async {
                Navigator.pop(sheetContext);
                await _pickFrom(ImageSource.gallery);
              },
            ),
            if (_avatar != null)
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.redAccent),
                title: const Text('Remove photo', style: TextStyle(color: Colors.redAccent)),
                onTap: () {
                  Navigator.pop(sheetContext);
                  setState(() => _avatar = null);
                },
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickFrom(ImageSource source) async {
    try {
      final picked = await ImagePicker().pickImage(source: source, maxWidth: 800, imageQuality: 85);
      if (picked != null) setState(() => _avatar = File(picked.path));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not open image picker: $e')));
    }
  }

  void _save() {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name cannot be empty')),
      );
      return;
    }
    Navigator.pop(context, EditProfileResult(name: name, phone: phone, avatar: _avatar));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text('Edit Profile',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: Colors.black)),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: GestureDetector(
                onTap: _pickAvatar,
                child: Stack(
                  children: [
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFF0F0F0), width: 2),
                      ),
                      child: CircleAvatar(
                        backgroundColor: const Color(0xFFF3F4F6),
                        backgroundImage: _avatar != null ? FileImage(_avatar!) : null,
                        child: _avatar == null
                            ? const Icon(Icons.person, size: 44, color: Colors.black87)
                            : null,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                        child: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),
            const Text('Full Name', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Enter your name',
                filled: true,
                fillColor: const Color(0xFFF7F8FA),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Text('Phone Number', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            const SizedBox(height: 8),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Enter your phone number',
                filled: true,
                fillColor: const Color(0xFFF7F8FA),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                  elevation: 0,
                ),
                child: const Text('Save Changes',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}