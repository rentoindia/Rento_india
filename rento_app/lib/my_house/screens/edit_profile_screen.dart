import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

/// TENANT — Edit Profile Screen
///
/// FIX: previously the pencil (edit) icon had an empty `onTap: () {}`,
/// so tapping it did nothing — no image_picker was wired up at all, and
/// there was no way to pass initial values in or return edited values
/// back out. This version mirrors the working pattern already used on
/// the Owner side (OwnerEditProfileScreen) so both flows behave the same:
///   - accepts initialName/Phone/Email/Gender/Image from the caller
///   - pencil icon opens a "Camera / Gallery" bottom sheet
///   - Save button pops with a result map so the caller (ProfileScreen)
///     can update its state and actually show the new values.
class EditProfileScreen extends StatefulWidget {
  final String initialName;
  final String initialPhone;
  final String initialEmail;
  final String initialGender;
  final File? initialImage;

  const EditProfileScreen({
    super.key,
    this.initialName = 'Karthik Raj',
    this.initialPhone = '+91 98765 43210',
    this.initialEmail = 'karthik.raj@email.com',
    this.initialGender = 'Male',
    this.initialImage,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController nameController = TextEditingController(
    text: widget.initialName,
  );
  late final TextEditingController phoneController = TextEditingController(
    text: widget.initialPhone,
  );
  late final TextEditingController emailController = TextEditingController(
    text: widget.initialEmail,
  );
  late String selectedGender = widget.initialGender;

  // Holds the photo picked from camera/gallery. Starts from whatever
  // photo was already saved (widget.initialImage), null = default avatar.
  late File? pickedImage = widget.initialImage;
  final ImagePicker _picker = ImagePicker();

  static const Color primaryDark = Color(0xFF1A1A1A);
  static const Color bgLight = Color(0xFFF7F7F7);

  Future<void> _pickImage(ImageSource source) async {
    final XFile? file = await _picker.pickImage(
      source: source,
      imageQuality: 90,
    );
    if (file == null) return;

    // Passport-photo style: force a square crop with a visible crop UI,
    // instead of just silently center-cropping whatever full photo was
    // picked. The user drags/zooms to frame their face before saving.
    final CroppedFile? cropped = await ImageCropper().cropImage(
      sourcePath: file.path,
      compressQuality: 85,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Photo',
          toolbarColor: primaryDark,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Crop Photo',
          aspectRatioLockEnabled: true,
          resetAspectRatioEnabled: false,
        ),
      ],
    );
    if (cropped != null) {
      setState(() => pickedImage = File(cropped.path));
    }
  }

  // Bottom sheet so the tenant can choose "Camera" or "Gallery" — this is
  // what the pencil icon opens now instead of doing nothing.
  void _showImageSourceSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.camera_alt_outlined,
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
                    Icons.photo_library_outlined,
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
          ),
        );
      },
    );
  }

  Widget _fieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: primaryDark,
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          prefixIcon: Icon(icon, size: 18, color: Colors.grey[600]),
        ),
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
          'Edit Profile',
          style: TextStyle(
            color: primaryDark,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Stack(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAEAEA),
                    shape: BoxShape.circle,
                    image: pickedImage != null
                        ? DecorationImage(
                            image: FileImage(pickedImage!),
                            fit: BoxFit.cover,
                          )
                        : const DecorationImage(
                            image: AssetImage(
                              'assets/images/my_house/tenant_default.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    // FIX: was `onTap: () {}` — now actually opens the
                    // camera/gallery picker sheet.
                    onTap: _showImageSourceSheet,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: primaryDark,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _fieldLabel('Full Name'),
                  _textField(
                    controller: nameController,
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 18),
                  _fieldLabel('Gender'),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedGender,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: primaryDark,
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: primaryDark,
                        ),
                        items: ['Male', 'Female', 'Other']
                            .map(
                              (g) => DropdownMenuItem(value: g, child: Text(g)),
                            )
                            .toList(),
                        onChanged: (val) =>
                            setState(() => selectedGender = val!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  _fieldLabel('Phone Number'),
                  _textField(
                    controller: phoneController,
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 18),
                  _fieldLabel('Email'),
                  _textField(
                    controller: emailController,
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryDark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile updated successfully!'),
                    ),
                  );
                  // FIX: was `Navigator.pop(context)` with nothing returned,
                  // so edits never made it back to ProfileScreen. Now we
                  // pass a result map back, same pattern as Owner side.
                  Navigator.pop(context, {
                    'name': nameController.text,
                    'phone': phoneController.text,
                    'email': emailController.text,
                    'gender': selectedGender,
                    'image': pickedImage,
                  });
                },
                child: const Text(
                  'Save',
                  style: TextStyle(
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
}
