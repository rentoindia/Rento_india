import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'owner_theme.dart';

/// RENTO INDIA — Owner Flow Screen 10: Owner Profile
class OwnerProfileScreen extends StatefulWidget {
  const OwnerProfileScreen({super.key});

  @override
  State<OwnerProfileScreen> createState() => _OwnerProfileScreenState();
}

class _OwnerProfileScreenState extends State<OwnerProfileScreen> {
  // These live HERE (in the parent) so that when Edit Profile saves new
  // values, this screen can update and actually show them — previously
  // OwnerProfileScreen was stateless with a hardcoded name, so nothing
  // typed on the Edit Profile screen ever made it back here.
  String ownerName = 'Ramesh Kumar';
  String ownerPhone = '+91 98765 43210';
  String ownerEmail = 'ramesh.kumar@email.com';
  String ownerGender = 'Male';
  File? ownerImage;

  // Bank details also live here so Bank Details screen can prefill +
  // hand back saved values the same way Edit Profile does.
  String bankName = 'State Bank of India';
  String bankBranch = 'Anna Nagar';
  String accountNumber = '1234 5678 9010';
  String ifscCode = 'SBIN0001234';

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {'icon': Icons.edit_outlined, 'label': 'Edit Profile'},
      {'icon': Icons.account_balance_outlined, 'label': 'Bank Details'},
      {'icon': Icons.notifications_none, 'label': 'Notification Settings'},
      {'icon': Icons.help_outline, 'label': 'Help & Support'},
      {'icon': Icons.logout, 'label': 'Logout'},
    ];

    void handleTap(String label) async {
      switch (label) {
        case 'Logout':
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logged out successfully')),
          );
          break;
        // Edit Profile now opens a real editable form (see
        // OwnerEditProfileScreen below) instead of the generic placeholder.
        case 'Edit Profile':
          // Pass the CURRENT values in, and `await` the result coming
          // back from Save — then setState so this screen re-renders
          // with the new name/photo/etc.
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OwnerEditProfileScreen(
                initialName: ownerName,
                initialPhone: ownerPhone,
                initialEmail: ownerEmail,
                initialGender: ownerGender,
                initialImage: ownerImage,
              ),
            ),
          );
          if (result != null && result is Map) {
            setState(() {
              ownerName = result['name'] as String;
              ownerPhone = result['phone'] as String;
              ownerEmail = result['email'] as String;
              ownerGender = result['gender'] as String;
              ownerImage = result['image'] as File?;
            });
          }
          break;
        case 'Bank Details':
          // Same pattern as Edit Profile: pass current values in, await
          // the result, then setState so anything changed is remembered.
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OwnerBankDetailsScreen(
                initialBankName: bankName,
                initialBranch: bankBranch,
                initialAccountNumber: accountNumber,
                initialIfsc: ifscCode,
              ),
            ),
          );
          if (result != null && result is Map) {
            setState(() {
              bankName = result['bankName'] as String;
              bankBranch = result['branch'] as String;
              accountNumber = result['accountNumber'] as String;
              ifscCode = result['ifsc'] as String;
            });
          }
          break;
        case 'Notification Settings':
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const _OwnerSimplePage(
                title: 'Notification Settings',
                icon: Icons.notifications_none,
                message: 'Choose which alerts you want to receive.',
              ),
            ),
          );
          break;
        case 'Help & Support':
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const _OwnerSimplePage(
                title: 'Help & Support',
                icon: Icons.help_outline,
                message: 'Reach our support team or browse FAQs.',
              ),
            ),
          );
          break;
      }
    }

    return Scaffold(
      backgroundColor: OwnerTheme.bgGrey,
      appBar: OwnerTheme.appBar(context, 'Profile'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Column(
              children: [
                // FIX: removed the pencil edit badge that used to sit on
                // top of this avatar — "Edit Profile" row below already
                // opens the same screen, so the badge here isn't needed.
                CircleAvatar(
                  radius: 40,
                  backgroundColor: OwnerTheme.borderGrey,
                  // Default avatar (the sweater photo) shows until the
                  // owner picks their own photo via Edit Profile.
                  backgroundImage: ownerImage != null
                      ? FileImage(ownerImage!)
                      : const AssetImage('assets/images/my_house/owner_default.png')
                          as ImageProvider,
                ),
                const SizedBox(height: 12),
                Text(ownerName, style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: OwnerTheme.primaryDark)),
                const SizedBox(height: 2),
                Text('Property Owner', style: OwnerTheme.subText),
              ],
            ),
          ),
          const SizedBox(height: 28),
          Container(
            decoration: OwnerTheme.card,
            child: Column(
              children: menuItems.map((item) {
                final isLast = item == menuItems.last;
                final isLogout = item['label'] == 'Logout';
                final label = item['label'] as String;
                return InkWell(
                  onTap: () => handleTap(label),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 15),
                    decoration: BoxDecoration(
                      border: isLast
                          ? null
                          : const Border(
                              bottom:
                                  BorderSide(color: OwnerTheme.borderGrey)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          item['icon'] as IconData,
                          color: isLogout
                              ? OwnerTheme.danger
                              : OwnerTheme.primaryDark,
                          size: 20,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            label,
                            style: TextStyle(
                              color: isLogout
                                  ? OwnerTheme.danger
                                  : OwnerTheme.primaryDark,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        if (!isLogout)
                          const Icon(Icons.chevron_right,
                              color: OwnerTheme.textGrey),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------
/// EDIT PROFILE — a real editable form (avatar with edit badge, Name,
/// Phone Number, Email fields + a Save button), styled to match the
/// existing OwnerTheme (same dark/grey palette as the rest of the app)
/// instead of the generic "coming soon" placeholder.
/// ---------------------------------------------------------------------
class OwnerEditProfileScreen extends StatefulWidget {
  final String initialName;
  final String initialPhone;
  final String initialEmail;
  final String initialGender;
  final File? initialImage;

  const OwnerEditProfileScreen({
    super.key,
    required this.initialName,
    required this.initialPhone,
    required this.initialEmail,
    required this.initialGender,
    this.initialImage,
  });

  @override
  State<OwnerEditProfileScreen> createState() =>
      _OwnerEditProfileScreenState();
}

class _OwnerEditProfileScreenState extends State<OwnerEditProfileScreen> {
  late final TextEditingController nameController =
      TextEditingController(text: widget.initialName);
  late final TextEditingController phoneController =
      TextEditingController(text: widget.initialPhone);
  late final TextEditingController emailController =
      TextEditingController(text: widget.initialEmail);

  late String selectedGender = widget.initialGender;
  final List<String> genders = ['Male', 'Female', 'Other'];

  // Holds the photo picked from camera/gallery. Starts from whatever
  // photo was already saved (widget.initialImage), null = default avatar.
  late File? pickedImage = widget.initialImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? file = await _picker.pickImage(
      source: source,
      imageQuality: 90,
    );
    if (file == null) return;

    // Passport-photo style: force a square crop with a visible crop UI,
    // instead of just silently center-cropping whatever full photo was
    // picked. The owner drags/zooms to frame their face before saving.
    final CroppedFile? cropped = await ImageCropper().cropImage(
      sourcePath: file.path,
      compressQuality: 85,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Photo',
          toolbarColor: OwnerTheme.primaryDark,
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

  // Bottom sheet so the owner can choose "Camera" or "Gallery", instead of
  // jumping straight to one source.
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
                    color: OwnerTheme.borderGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt_outlined,
                      color: OwnerTheme.primaryDark),
                  title: const Text('Take a photo'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library_outlined,
                      color: OwnerTheme.primaryDark),
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

  Widget _fieldLabel(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: OwnerTheme.primaryDark,
          ),
        ),
      );

  Widget _textField(TextEditingController controller,
      {TextInputType? type, IconData? icon}) {
    return Container(
      decoration: BoxDecoration(
        color: OwnerTheme.bgGrey,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: OwnerTheme.borderGrey),
      ),
      child: TextField(
        controller: controller,
        keyboardType: type,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: OwnerTheme.primaryDark,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          prefixIcon: icon == null
              ? null
              : Icon(icon, size: 19, color: OwnerTheme.textGrey),
        ),
      ),
    );
  }

  Widget _dropdownField({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: OwnerTheme.bgGrey,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: OwnerTheme.borderGrey),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: OwnerTheme.textGrey),
          items: items
              .map((g) => DropdownMenuItem(
                    value: g,
                    child: Text(
                      g,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: OwnerTheme.primaryDark,
                      ),
                    ),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OwnerTheme.bgGrey,
      appBar: OwnerTheme.appBar(context, 'Edit Profile'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Avatar with a small edit-pencil badge, same idea as the
          // reference screenshot's photo + pencil overlay.
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 44,
                  backgroundColor: OwnerTheme.borderGrey,
                  backgroundImage: pickedImage != null
                      ? FileImage(pickedImage!)
                      : const AssetImage('assets/images/my_house/owner_default.png')
                          as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _showImageSourceSheet,
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: OwnerTheme.primaryDark,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(Icons.edit,
                          size: 15, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: OwnerTheme.card,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _fieldLabel('Full Name'),
                _textField(nameController, icon: Icons.person_outline),
                const SizedBox(height: 18),
                _fieldLabel('Gender'),
                _dropdownField(
                  value: selectedGender,
                  items: genders,
                  onChanged: (val) => setState(() => selectedGender = val!),
                ),
                const SizedBox(height: 18),
                _fieldLabel('Phone Number'),
                _textField(phoneController,
                    type: TextInputType.phone, icon: Icons.phone_outlined),
                const SizedBox(height: 18),
                _fieldLabel('Email'),
                _textField(emailController,
                    type: TextInputType.emailAddress,
                    icon: Icons.email_outlined),
              ],
            ),
          ),

          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: OwnerTheme.primaryDark,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile updated successfully')),
                );
                // Passes a result map back so the Profile screen can
                // read the new name/phone/etc. back out.
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
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------
/// BANK DETAILS — matches the reference screen: Bank Name, Select Branch,
/// Account Number, IFSC Code, and a Save button.
///
/// FIX: previously only the Account Number field locked itself after
/// saving (with its own inline "Edit" link), while Bank Name / Branch /
/// IFSC stayed permanently editable with no Save button visible once
/// details already existed — so there was no consistent way to re-enter
/// "edit mode" for the whole form.
///
/// Now the WHOLE form behaves as one unit:
///   - If no bank details are saved yet -> form opens directly in edit
///     mode with the Save button visible.
///   - If bank details already exist -> form opens in a locked/read-only
///     view with a single "Edit" button up top.
///   - Tapping "Edit" unlocks all four fields + shows the Save button.
///   - Tapping Save validates, locks the form again, and pops the result
///     back to OwnerProfileScreen.
/// ---------------------------------------------------------------------
class OwnerBankDetailsScreen extends StatefulWidget {
  final String initialBankName;
  final String initialBranch;
  final String initialAccountNumber;
  final String initialIfsc;

  const OwnerBankDetailsScreen({
    super.key,
    this.initialBankName = '',
    this.initialBranch = '',
    this.initialAccountNumber = '',
    this.initialIfsc = '',
  });

  @override
  State<OwnerBankDetailsScreen> createState() =>
      _OwnerBankDetailsScreenState();
}

class _OwnerBankDetailsScreenState extends State<OwnerBankDetailsScreen> {
  late final TextEditingController bankNameController =
      TextEditingController(text: widget.initialBankName);
  late final TextEditingController branchController =
      TextEditingController(text: widget.initialBranch);
  late final TextEditingController accountController =
      TextEditingController(text: widget.initialAccountNumber);
  late final TextEditingController ifscController =
      TextEditingController(text: widget.initialIfsc);

  final _formKey = GlobalKey<FormState>();

  // Whole-form edit toggle. Starts unlocked (true) only when there's
  // nothing saved yet — first-time setup. Once details exist, the form
  // opens locked and the owner has to tap "Edit" to change anything.
  late bool isEditing = widget.initialAccountNumber.trim().isEmpty;

  Widget _fieldLabel(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: OwnerTheme.textGrey,
          ),
        ),
      );

  Widget _textField(
    TextEditingController controller, {
    TextInputType? type,
    String? Function(String?)? validator,
  }) {
    final locked = !isEditing;
    return Container(
      decoration: BoxDecoration(
        color: locked ? const Color(0xFFF2F2F2) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: OwnerTheme.borderGrey),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        readOnly: locked,
        validator: validator,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: OwnerTheme.primaryDark,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 14, vertical: 15),
        ),
      ),
    );
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => isEditing = false); // lock the form again after saving
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Bank details saved successfully')),
    );
    Navigator.pop(context, {
      'bankName': bankNameController.text.trim(),
      'branch': branchController.text.trim(),
      'accountNumber': accountController.text.trim(),
      'ifsc': ifscController.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: OwnerTheme.appBar(context, 'Bank Details'),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Only show the "Edit" toggle button when the form is
            // currently locked (i.e. details already exist and haven't
            // been unlocked yet).
            if (!isEditing)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () => setState(() => isEditing = true),
                  icon: const Icon(Icons.edit,
                      size: 16, color: OwnerTheme.primaryDark),
                  label: const Text(
                    'Edit',
                    style: TextStyle(
                      color: OwnerTheme.primaryDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

            _fieldLabel('Bank Name'),
            _textField(
              bankNameController,
              validator: (val) =>
                  (val == null || val.trim().isEmpty) ? 'Enter bank name' : null,
            ),
            const SizedBox(height: 18),

            _fieldLabel('Select Branch'),
            _textField(
              branchController,
              validator: (val) =>
                  (val == null || val.trim().isEmpty) ? 'Enter branch' : null,
            ),
            const SizedBox(height: 18),

            _fieldLabel('Account Number'),
            _textField(
              accountController,
              type: TextInputType.number,
              validator: (val) {
                if (val == null || val.trim().isEmpty) return 'Enter account number';
                if (val.replaceAll(' ', '').length < 9) return 'Enter a valid account number';
                return null;
              },
            ),
            const SizedBox(height: 18),

            _fieldLabel('IFSC Code'),
            _textField(
              ifscController,
              validator: (val) {
                if (val == null || val.trim().isEmpty) return 'Enter IFSC code';
                if (val.trim().length != 11) return 'Enter a valid 11-character IFSC code';
                return null;
              },
            ),

            const SizedBox(height: 32),

            // Save button only shows while the form is unlocked/editing.
            if (isEditing)
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: OwnerTheme.primaryDark,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: _save,
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
          ],
        ),
      ),
    );
  }
}

/// A small reusable placeholder page so every Profile menu item leads
/// somewhere real instead of doing nothing. Swap the body out for the
/// actual feature (forms, settings, FAQ list, etc.) whenever it's ready.
class _OwnerSimplePage extends StatelessWidget {
  final String title;
  final IconData icon;
  final String message;

  const _OwnerSimplePage({
    required this.title,
    required this.icon,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OwnerTheme.bgGrey,
      appBar: OwnerTheme.appBar(context, title),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, color: OwnerTheme.textGrey),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: OwnerTheme.subText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


