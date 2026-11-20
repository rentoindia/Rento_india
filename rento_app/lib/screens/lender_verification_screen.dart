 
// import 'package:flutter/material.dart';
// import '../services/lender_service.dart';

// /// The identity-verification form shown to a customer who wants to
// /// become a lender. Purely the form UI + submission logic — RentoScreen
// /// owns the surrounding Scaffold/AppBar/BottomNav, so this widget is
// /// dropped in as just the `body` while unverified.
// class LenderVerificationScreen extends StatefulWidget {
//   const LenderVerificationScreen({super.key});

//   @override
//   State<LenderVerificationScreen> createState() => _LenderVerificationScreenState();
// }

// class _LenderVerificationScreenState extends State<LenderVerificationScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _mobileController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _aadharController = TextEditingController();
//   final _addressController = TextEditingController();

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _mobileController.dispose();
//     _emailController.dispose();
//     _aadharController.dispose();
//     _addressController.dispose();
//     super.dispose();
//   }

//   Future<void> _submitVerification() async {
//     if (!_formKey.currentState!.validate()) return;

//     await LenderService.instance.submitVerification(
//       name: _nameController.text.trim(),
//       mobile: _mobileController.text.trim(),
//       emailAddress: _emailController.text.trim(),
//       aadhar: _aadharController.text.trim(),
//       homeAddress: _addressController.text.trim(),
//     );

//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Verified! You can now list your products.')),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(18),
//             decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(16)),
//             child: Row(
//               children: [
//                 const Icon(Icons.verified_user_outlined, color: Colors.white, size: 32),
//                 const SizedBox(width: 14),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: const [
//                       Text('Become a Lender',
//                           style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
//                       SizedBox(height: 4),
//                       Text(
//                         'Verify your identity once, then list your products for others to rent.',
//                         style: TextStyle(color: Colors.white70, fontSize: 12),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 22),
//           const Text('Identity Verification', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
//           const SizedBox(height: 12),

//           _textField(
//             controller: _nameController,
//             hint: 'Full Name',
//             icon: Icons.person_outline,
//             validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter your full name' : null,
//           ),
//           const SizedBox(height: 12),
//           _textField(
//             controller: _mobileController,
//             hint: 'Mobile Number',
//             icon: Icons.phone_outlined,
//             keyboardType: TextInputType.phone,
//             validator: (v) => (v == null || v.trim().length != 10) ? 'Enter a valid 10-digit number' : null,
//           ),
//           const SizedBox(height: 12),
//           _textField(
//             controller: _emailController,
//             hint: 'Email Address',
//             icon: Icons.email_outlined,
//             keyboardType: TextInputType.emailAddress,
//             validator: (v) => (v == null || !v.contains('@')) ? 'Enter a valid email' : null,
//           ),
//           const SizedBox(height: 12),
//           _textField(
//             controller: _aadharController,
//             hint: 'Aadhaar Number',
//             icon: Icons.badge_outlined,
//             keyboardType: TextInputType.number,
//             validator: (v) => (v == null || v.trim().length != 12) ? 'Enter a valid 12-digit Aadhaar number' : null,
//           ),
//           const SizedBox(height: 12),
//           _textField(
//             controller: _addressController,
//             hint: 'Home Address',
//             icon: Icons.location_on_outlined,
//             maxLines: 2,
//             validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter your address' : null,
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Your Aadhaar and address are used only for identity verification and are kept secure.',
//             style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
//           ),
//           const SizedBox(height: 22),

//           SizedBox(
//             width: double.infinity,
//             height: 52,
//             child: ElevatedButton(
//               onPressed: _submitVerification,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.black,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
//               ),
//               child: const Text('Verify & Continue',
//                   style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _textField({
//     required TextEditingController controller,
//     required String hint,
//     required IconData icon,
//     TextInputType keyboardType = TextInputType.text,
//     int maxLines = 1,
//     String? Function(String?)? validator,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: const Color(0xFFEDEDED)),
//       ),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboardType,
//         maxLines: maxLines,
//         validator: validator,
//         decoration: InputDecoration(
//           prefixIcon: Icon(icon, color: Colors.black87, size: 20),
//           hintText: hint,
//           hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13),
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
//         ),
//       ),
//     );
//   }
// }
 import 'package:flutter/material.dart';
import '../services/lender_service.dart';

/// The identity-verification form shown to a customer who wants to
/// become a lender. Purely the form UI + submission logic — RentoScreen
/// owns the surrounding Scaffold/AppBar/BottomNav, so this widget is
/// dropped in as just the `body` while unverified.
class LenderVerificationScreen extends StatefulWidget {
  const LenderVerificationScreen({super.key});

  @override
  State<LenderVerificationScreen> createState() => _LenderVerificationScreenState();
}

class _LenderVerificationScreenState extends State<LenderVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _aadharController = TextEditingController();
  final _addressController = TextEditingController();

  bool _submitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _aadharController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _submitVerification() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _submitting = true);
    try {
      await LenderService.instance.submitVerification(
        name: _nameController.text.trim(),
        mobile: _mobileController.text.trim(),
        emailAddress: _emailController.text.trim(),
        aadhar: _aadharController.text.trim(),
        homeAddress: _addressController.text.trim(),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.ink,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          content: const Text('Verified! You can now list your products.'),
        ),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bg,
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 32),
          children: [
            const _VerificationHeader(),
            const SizedBox(height: 26),
            const _SectionEyebrow(text: 'IDENTITY VERIFICATION'),
            const SizedBox(height: 12),

            _FieldBox(
              controller: _nameController,
              label: 'Full name',
              icon: Icons.person_outline_rounded,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter your full name' : null,
            ),
            const SizedBox(height: 10),
            _FieldBox(
              controller: _mobileController,
              label: 'Mobile number',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              validator: (v) =>
                  (v == null || v.trim().length != 10) ? 'Enter a valid 10-digit number' : null,
            ),
            const SizedBox(height: 10),
            _FieldBox(
              controller: _emailController,
              label: 'Email address',
              icon: Icons.mail_outline_rounded,
              keyboardType: TextInputType.emailAddress,
              validator: (v) => (v == null || !v.contains('@')) ? 'Enter a valid email' : null,
            ),
            const SizedBox(height: 10),
            _FieldBox(
              controller: _aadharController,
              label: 'Aadhaar number',
              icon: Icons.badge_outlined,
              keyboardType: TextInputType.number,
              maxLength: 12,
              validator: (v) =>
                  (v == null || v.trim().length != 12) ? 'Enter a valid 12-digit Aadhaar number' : null,
            ),
            const SizedBox(height: 10),
            _FieldBox(
              controller: _addressController,
              label: 'Home address',
              icon: Icons.location_on_outlined,
              maxLines: 3,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter your address' : null,
            ),

            const SizedBox(height: 16),
            const _PrivacyNote(),

            const SizedBox(height: 26),
            _SubmitButton(submitting: _submitting, onTap: _submitVerification),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Design tokens — Instagram-leaning palette: near-white surfaces, hairline
// grey borders on fields, ink-black text, IG blue for the primary action,
// and the purple→pink→orange brand gradient used sparingly as a signature
// accent (avatar ring + story-style progress bar) rather than everywhere.
// ---------------------------------------------------------------------------

class AppColors {
  AppColors._();
  static const bg = Colors.white;
  static const fieldFill = Color(0xFFFAFAFA);
  static const fieldBorder = Color(0xFFDBDBDB);
  static const ink = Color(0xFF262626);
  static const muted = Color(0xFF8E8E8E);
  static const igBlue = Color(0xFF0095F6);
  static const gradient = [Color(0xFF833AB4), Color(0xFFFD1D1D), Color(0xFFF77737)];
}

// ---------------------------------------------------------------------------
// Header — avatar-style gradient ring (the one deliberate IG nod) plus a
// stories-style segmented progress bar across the top.
// ---------------------------------------------------------------------------

class _VerificationHeader extends StatelessWidget {
  const _VerificationHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: _storySegment(active: true)),
            const SizedBox(width: 4),
            Expanded(child: _storySegment(active: false)),
            const SizedBox(width: 4),
            Expanded(child: _storySegment(active: false)),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              padding: const EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: AppColors.gradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Container(
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                padding: const EdgeInsets.all(3),
                child: Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.ink),
                  child: const Icon(Icons.shield_outlined, color: Colors.white, size: 22),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Become a lender',
                    style: TextStyle(
                      color: AppColors.ink,
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Verify your identity, then list your products',
                    style: TextStyle(color: AppColors.muted, fontSize: 12.5, height: 1.3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _storySegment({required bool active}) {
    return Container(
      height: 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        gradient: active
            ? const LinearGradient(colors: AppColors.gradient)
            : null,
        color: active ? null : const Color(0xFFEFEFEF),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section label
// ---------------------------------------------------------------------------

class _SectionEyebrow extends StatelessWidget {
  const _SectionEyebrow({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.muted,
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.0,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Field — a standalone bordered box per field (IG login-form pattern),
// filled with an explicit near-white color so it never inherits a global
// grey "filled" input theme, with the border snapping to black on focus.
// ---------------------------------------------------------------------------

class _FieldBox extends StatefulWidget {
  const _FieldBox({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.maxLength,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType keyboardType;
  final int maxLines;
  final int? maxLength;
  final String? Function(String?)? validator;

  @override
  State<_FieldBox> createState() => _FieldBoxState();
}

class _FieldBoxState extends State<_FieldBox> {
  final _focusNode = FocusNode();
  bool _focused = false;

  static const _errorColor = Color(0xFFED4956);

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() => _focused = _focusNode.hasFocus));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // FormField (rather than a bare TextFormField) so this widget can read
    // its own error state and reflect it directly on the box — a red
    // border + tinted icon — instead of leaving the box neutral while an
    // error line prints underneath it.
    return FormField<String>(
      initialValue: widget.controller.text,
      validator: widget.validator,
      builder: (state) {
        final hasError = state.hasError;
        final borderColor = hasError
            ? _errorColor
            : (_focused ? AppColors.ink : AppColors.fieldBorder);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 130),
              decoration: BoxDecoration(
                color: AppColors.fieldFill,
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: borderColor, width: hasError || _focused ? 1.3 : 1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Row(
                crossAxisAlignment:
                    widget.maxLines > 1 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: widget.maxLines > 1 ? 13 : 0),
                    child: Icon(widget.icon, size: 18, color: hasError ? _errorColor : AppColors.muted),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: widget.controller,
                      focusNode: _focusNode,
                      keyboardType: widget.keyboardType,
                      minLines: widget.maxLines > 1 ? 2 : 1,
                      maxLines: widget.maxLines,
                      maxLength: widget.maxLength,
                      onChanged: (v) => state.didChange(v),
                      cursorColor: AppColors.ink,
                      textAlignVertical: TextAlignVertical.top,
                      style: const TextStyle(fontSize: 14, color: AppColors.ink, fontWeight: FontWeight.w500),
                      // Explicitly unfilled/transparent so this never picks
                      // up a global grey "filled" InputDecorationTheme from
                      // the app — the box styling above is the only fill.
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        labelText: widget.label,
                        counterText: '',
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelStyle:
                            const TextStyle(color: AppColors.muted, fontSize: 13.5, fontWeight: FontWeight.w400),
                        floatingLabelStyle: TextStyle(
                          color: hasError ? _errorColor : (_focused ? AppColors.ink : AppColors.muted),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        // Error text is rendered by this FormField's own
                        // AnimatedSwitcher below, styled to match the box —
                        // suppress TextFormField's own error line so it
                        // doesn't duplicate/misalign with it.
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 120),
              child: hasError
                  ? Padding(
                      key: ValueKey(state.errorText),
                      padding: const EdgeInsets.only(top: 5, left: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.error_outline_rounded, size: 12, color: _errorColor),
                          const SizedBox(width: 4),
                          Text(
                            state.errorText ?? '',
                            style: const TextStyle(color: _errorColor, fontSize: 11.5, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(width: double.infinity, height: 0),
            ),
          ],
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Privacy note
// ---------------------------------------------------------------------------

class _PrivacyNote extends StatelessWidget {
  const _PrivacyNote();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 1),
          child: Icon(Icons.lock_outline_rounded, size: 14, color: AppColors.muted),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'Your Aadhaar and address are used only for identity verification and are kept secure.',
            style: TextStyle(color: AppColors.muted, fontSize: 11.5, height: 1.45),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Submit button — IG's signature blue, slightly rounded (not a pill).
// ---------------------------------------------------------------------------

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({required this.submitting, required this.onTap});
  final bool submitting;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: ElevatedButton(
        onPressed: submitting ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.igBlue,
          disabledBackgroundColor: AppColors.igBlue.withOpacity(0.5),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: submitting
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2.2, color: Colors.white),
              )
            : const Text(
                'Verify & continue',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14.5),
              ),
      ),
    );
  }
}