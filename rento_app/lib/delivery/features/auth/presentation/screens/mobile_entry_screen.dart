// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// //import '../../../../core/constants/app_colors.dart';
// import '../../../../core/routes/route_names.dart';
// import '../../../../core/utils/validators.dart';
// import '../../../../core/widgets/primary_button.dart';
// import '../../../../core/widgets/icon_bubble.dart';
// import '../../../../core/widgets/onboarding_asset.dart';
// import '../widgets/social_icon_button.dart';
// import 'package:rento_india/delivery/core/constants/app_colors.dart';
// /// Screen 2 — Welcome + Login (Mobile Entry)
// /// Light version of the orbit layout, with the seated-character
// /// illustration in the center, then the OTP-first mobile number form.
// ///
// /// NOTE ON FIDELITY: the seated character + product renders are
// /// custom illustration assets I don't have. This screen mimics the
// /// exact composition/spacing using Material icon stand-ins so the
// /// layout is ready — swap ProductGlyph/the avatar Container for
// /// Image.asset(...) once you export the real PNGs.
// class MobileEntryScreen extends StatefulWidget {
//   const MobileEntryScreen({super.key});

//   @override
//   State<MobileEntryScreen> createState() => _MobileEntryScreenState();
// }

// class _MobileEntryScreenState extends State<MobileEntryScreen> {
//   final TextEditingController _mobileController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;

//   @override
//   void dispose() {
//     _mobileController.dispose();
//     super.dispose();
//   }

//   void _onSendOtp() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => _isLoading = true);

//     // TODO: call AuthRepository.sendOtp(mobileNumber) here.
//     await Future.delayed(const Duration(milliseconds: 900));

//     if (!mounted) return;
//     setState(() => _isLoading = false);

//     Navigator.of(context).pushNamed(
//       RouteNames.otpVerification,
//       arguments: _mobileController.text.trim(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: AppColors.scaffoldLight,
//       body: Stack(
//         children: [
//           SafeArea(
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   SizedBox(
//                     height: size.height * 0.46,
//                     child: _OrbitHero(size: size),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 24),
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           const Text(
//                             'Welcome to Rento India',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                               color: AppColors.textPrimary,
//                             ),
//                           ),
//                           const SizedBox(height: 6),
//                           const Text(
//                             'One App for Rent, Property, Services & more.',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: AppColors.textSecondary,
//                             ),
//                           ),
//                           const SizedBox(height: 28),
//                           _buildMobileField(),
//                           const SizedBox(height: 20),
//                           PrimaryButton(
//                             label: 'Send OTP',
//                             trailingIcon: Icons.arrow_forward,
//                             isLoading: _isLoading,
//                             onPressed: _onSendOtp,
//                           ),
//                           const SizedBox(height: 24),
//                           _buildDivider(),
//                           const SizedBox(height: 20),
//                           _buildSocialRow(),
//                           const SizedBox(height: 24),
//                           _buildSecureFooter(),
//                           const SizedBox(height: 24),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           // Floating back button, overlaid on the hero image
//           Positioned(
//             top: MediaQuery.of(context).padding.top + 8,
//             left: 16,
//             child: _FloatingBackButton(
//               onTap: () => Navigator.of(context).pop(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMobileField() {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Fixed width (not intrinsic) so this can never push the Row
//         // past the screen width on small devices.
//         Container(
//           width: 88,
//           height: 56,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: AppColors.inputFill,
//             borderRadius: BorderRadius.circular(14),
//           ),
//           child: const FittedBox(
//             fit: BoxFit.scaleDown,
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(
//                   Icons.phone_android,
//                   size: 16,
//                   color: AppColors.textSecondary,
//                 ),
//                 SizedBox(width: 4),
//                 Text(
//                   '+91',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//                 Icon(
//                   Icons.keyboard_arrow_down,
//                   size: 16,
//                   color: AppColors.textSecondary,
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//           child: TextFormField(
//             controller: _mobileController,
//             keyboardType: TextInputType.phone,
//             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//             maxLength: 10,
//             validator: Validators.mobile,
//             style: const TextStyle(fontSize: 15, color: AppColors.textPrimary),
//             decoration: InputDecoration(
//               counterText: '',
//               hintText: 'Mobile number',
//               hintStyle: const TextStyle(
//                 fontSize: 15,
//                 color: AppColors.textHint,
//               ),
//               errorMaxLines: 2,
//               filled: true,
//               fillColor: AppColors.inputFill,
//               // No fixed height / isDense here — the box now sizes
//               // itself naturally from this padding, and the error
//               // message flows in the space below it instead of being
//               // squeezed into a box that was too short to fit both.
//               contentPadding: const EdgeInsets.symmetric(
//                 horizontal: 16,
//                 vertical: 16,
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(14),
//                 borderSide: BorderSide.none,
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(14),
//                 borderSide: BorderSide.none,
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(14),
//                 borderSide: const BorderSide(
//                   color: AppColors.primaryBlack,
//                   width: 1.4,
//                 ),
//               ),
//               errorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(14),
//                 borderSide: const BorderSide(
//                   color: AppColors.error,
//                   width: 1.2,
//                 ),
//               ),
//               focusedErrorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(14),
//                 borderSide: const BorderSide(
//                   color: AppColors.error,
//                   width: 1.4,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDivider() {
//     return Row(
//       children: const [
//         Expanded(child: Divider(color: AppColors.divider)),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 12),
//           child: Text(
//             'or continue with',
//             style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
//           ),
//         ),
//         Expanded(child: Divider(color: AppColors.divider)),
//       ],
//     );
//   }

//   Widget _buildSocialRow() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SocialIconButton(
//           icon: Icons.g_mobiledata_rounded,
//           onTap: () {
//             // TODO: Google sign-in
//           },
//         ),
//         const SizedBox(width: 18),
//         SocialIconButton(
//           icon: Icons.apple,
//           onTap: () {
//             // TODO: Apple sign-in
//           },
//         ),
//         const SizedBox(width: 18),
//         SocialIconButton(
//           icon: Icons.chat,
//           iconColor: const Color(0xFF25D366),
//           onTap: () {
//             // TODO: WhatsApp continue
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildSecureFooter() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: const [
//         Icon(
//           Icons.verified_user_outlined,
//           size: 16,
//           color: AppColors.textSecondary,
//         ),
//         SizedBox(width: 6),
//         // Flexible lets the sentence wrap onto a second line on narrow
//         // screens instead of forcing the Row wider than the viewport
//         // (that's what was causing the "overflowed by N pixels" error).
//         Flexible(
//           child: Text(
//             'Secure & Trusted · Your data is 100% safe with us',
//             textAlign: TextAlign.center,
//             softWrap: true,
//             style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
//           ),
//         ),
//       ],
//     );
//   }
// }

// /// Top hero section: orbiting product glyphs (light theme) around the
// /// logo, with a seated-character placeholder in the center — mirrors
// /// the illustration composition in image 2 of the design.
// class _OrbitHero extends StatelessWidget {
//   final Size size;

//   const _OrbitHero({required this.size});

//   @override
//   Widget build(BuildContext context) {
//     final w = size.width;
//     final h = size.height * 0.46;
//     // Scale glyph sizes down on narrow phones (<360dp) so nothing
//     // overlaps the centered logo/character column.
//     final scale = (w / 390).clamp(0.72, 1.0);

//     return ClipRect(
//       child: Stack(
//         clipBehavior: Clip.hardEdge,
//         children: [
//           // Icon bubble — no matching real asset for this one, kept as icon
//           Positioned(
//             top: h * 0.03,
//             left: w * 0.06,
//             child: IconBubble(
//               icon: Icons.location_on_outlined,
//               diameter: 30 * scale,
//               background: AppColors.inputFill,
//               iconColor: AppColors.textPrimary,
//             ),
//           ),

//           // Real product photos — kept away from the center 26%-74%
//           // width band (where the logo/character column sits).
//           Positioned(
//             top: h * 0.04,
//             right: w * 0.06,
//             child: OnboardingAsset('laptop_light.png', width: 60 * scale),
//           ),
//           Positioned(
//             top: h * 0.20,
//             left: w * 0.02,
//             child: OnboardingAsset(
//               'washing_machine_light.png',
//               width: 54 * scale,
//             ),
//           ),
//           Positioned(
//             top: h * 0.18,
//             right: w * 0.01,
//             child: OnboardingAsset('scooter_light.png', width: 58 * scale),
//           ),
//           Positioned(
//             top: h * 0.42,
//             left: w * 0.01,
//             child: OnboardingAsset('bike_light.png', width: 60 * scale),
//           ),
//           Positioned(
//             top: h * 0.40,
//             right: w * 0.02,
//             child: OnboardingAsset('house_light.png', width: 54 * scale),
//           ),
//           Positioned(
//             top: h * 0.60,
//             left: w * 0.06,
//             child: OnboardingAsset('camera1_light.png', width: 48 * scale),
//           ),
//           Positioned(
//             top: h * 0.60,
//             right: w * 0.06,
//             child: OnboardingAsset('controller_light.png', width: 48 * scale),
//           ),

//           // Center logo + tagline + seated character placeholder
//           Positioned(
//             top: h * 0.04,
//             left: w * 0.22,
//             right: w * 0.22,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   width: 54,
//                   height: 54,
//                   decoration: BoxDecoration(
//                     color: AppColors.pureBlack,
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                   child: const Center(
//                     child: Text(
//                       'R',
//                       style: TextStyle(
//                         color: AppColors.pureWhite,
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   'RENTO',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 3,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//                 const Text(
//                   'I N D I A',
//                   style: TextStyle(
//                     fontSize: 10,
//                     letterSpacing: 5,
//                     color: AppColors.textSecondary,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   'Rent Anything.',
//                   style: TextStyle(fontSize: 13, color: AppColors.textPrimary),
//                 ),
//                 const Text(
//                   'Manage Everything.',
//                   style: TextStyle(fontSize: 13, color: AppColors.textPrimary),
//                 ),
//                 const SizedBox(height: 16),
//                 OnboardingAsset('character_light.png', width: 110 * scale),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// /// Small circular back button overlaid on top of hero/orbit images,
// /// used on screens that don't have a normal AppBar (like this one).
// class _FloatingBackButton extends StatelessWidget {
//   final VoidCallback onTap;

//   const _FloatingBackButton({required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       customBorder: const CircleBorder(),
//       child: Container(
//         width: 38,
//         height: 38,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: AppColors.pureWhite.withOpacity(0.9),
//           boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
//         ),
//         child: const Icon(
//           Icons.arrow_back,
//           color: AppColors.textPrimary,
//           size: 20,
//         ),
//       ),
//     );
//   }
// }
