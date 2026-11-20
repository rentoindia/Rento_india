




// import 'package:flutter/material.dart';

// class DeliveryBookingScreen extends StatefulWidget {
//   const DeliveryBookingScreen({super.key});

//   @override
//   State<DeliveryBookingScreen> createState() => _DeliveryBookingScreenState();
// }

// class _DeliveryBookingScreenState extends State<DeliveryBookingScreen> {
//   final _formKey = GlobalKey<FormState>();

//   final _nameController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _cityController = TextEditingController();
//   final _vehicleNumberController = TextEditingController();
//   final _licenseNumberController = TextEditingController();

//   String _vehicleType = 'Bike';
//   bool _hasLicenseUploaded = false;
//   bool _hasIdProofUploaded = false;
//   bool _isSubmitting = false;

//   final List<String> _vehicleTypes = const ['Bike', 'Scooter', 'Bicycle', 'Van'];

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _phoneController.dispose();
//     _emailController.dispose();
//     _cityController.dispose();
//     _vehicleNumberController.dispose();
//     _licenseNumberController.dispose();
//     super.dispose();
//   }

//   void _submitApplication() {
//     if (!_formKey.currentState!.validate()) return;

//     if (!_hasIdProofUploaded) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please upload your ID proof')),
//       );
//       return;
//     }
//     if (!_hasLicenseUploaded) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please upload your driving license')),
//       );
//       return;
//     }

//     setState(() => _isSubmitting = true);

//     // Simulated submission — replace with a real API call when ready.
//     Future.delayed(const Duration(seconds: 2), () {
//       if (!mounted) return;
//       setState(() => _isSubmitting = false);
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           title: const Text('Application Submitted!'),
//           content: const Text(
//             'Thanks for applying to become a Rento delivery partner. '
//             'Our team will verify your documents and get back to you '
//             'within 24-48 hours.',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // close dialog
//                 Navigator.pop(context); // go back
//               },
//               child: const Text('OK', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
//             ),
//           ],
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F8FA),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.black),
//         title: const Text('Become a Rider',
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
//       ),
//       body: Form(
//         key: _formKey,
//         child: ListView(
//           padding: const EdgeInsets.all(16),
//           children: [
//             _buildHeaderBanner(),
//             const SizedBox(height: 22),

//             _sectionTitle('Personal Details'),
//             const SizedBox(height: 10),
//             _buildTextField(
//               controller: _nameController,
//               label: 'Full Name',
//               icon: Icons.person_outline,
//               validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter your full name' : null,
//             ),
//             const SizedBox(height: 12),
//             _buildTextField(
//               controller: _phoneController,
//               label: 'Mobile Number',
//               icon: Icons.phone_outlined,
//               keyboardType: TextInputType.phone,
//               validator: (v) {
//                 if (v == null || v.trim().length != 10) return 'Enter a valid 10-digit number';
//                 return null;
//               },
//             ),
//             const SizedBox(height: 12),
//             _buildTextField(
//               controller: _emailController,
//               label: 'Email Address',
//               icon: Icons.email_outlined,
//               keyboardType: TextInputType.emailAddress,
//               validator: (v) {
//                 if (v == null || !v.contains('@')) return 'Enter a valid email';
//                 return null;
//               },
//             ),
//             const SizedBox(height: 12),
//             _buildTextField(
//               controller: _cityController,
//               label: 'City',
//               icon: Icons.location_city_outlined,
//               validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter your city' : null,
//             ),

//             const SizedBox(height: 22),
//             _sectionTitle('Vehicle Details'),
//             const SizedBox(height: 10),
//             _buildVehicleTypeSelector(),
//             const SizedBox(height: 12),
//             _buildTextField(
//               controller: _vehicleNumberController,
//               label: 'Vehicle Number (e.g. KA 05 JK 1234)',
//               icon: Icons.two_wheeler_outlined,
//               validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter your vehicle number' : null,
//             ),
//             const SizedBox(height: 12),
//             _buildTextField(
//               controller: _licenseNumberController,
//               label: 'Driving License Number',
//               icon: Icons.badge_outlined,
//               validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter your license number' : null,
//             ),

//             const SizedBox(height: 22),
//             _sectionTitle('Upload Documents'),
//             const SizedBox(height: 10),
//             _buildUploadTile(
//               label: 'ID Proof (Aadhaar / PAN)',
//               uploaded: _hasIdProofUploaded,
//               onTap: () => setState(() => _hasIdProofUploaded = true),
//             ),
//             const SizedBox(height: 10),
//             _buildUploadTile(
//               label: 'Driving License',
//               uploaded: _hasLicenseUploaded,
//               onTap: () => setState(() => _hasLicenseUploaded = true),
//             ),

//             const SizedBox(height: 26),
//             SizedBox(
//               width: double.infinity,
//               height: 52,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.black,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
//                 ),
//                 onPressed: _isSubmitting ? null : _submitApplication,
//                 child: _isSubmitting
//                     ? const SizedBox(
//                         width: 20,
//                         height: 20,
//                         child: CircularProgressIndicator(
//                           strokeWidth: 2,
//                           color: Colors.white,
//                         ),
//                       )
//                     : const Text('Submit Application',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w700,
//                             fontSize: 14)),
//               ),
//             ),
//             const SizedBox(height: 8),
//             const Center(
//               child: Text(
//                 'By submitting, you agree to Rento\'s Rider Terms & Conditions',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.grey, fontSize: 11),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeaderBanner() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.black,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.electric_moped_outlined, color: Colors.white, size: 36),
//           const SizedBox(width: 14),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text('Earn with Rento',
//                     style: TextStyle(
//                         color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
//                 SizedBox(height: 4),
//                 Text(
//                   'Deliver orders in your city, work flexible hours, and get paid weekly.',
//                   style: TextStyle(color: Colors.white70, fontSize: 12),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _sectionTitle(String title) {
//     return Text(title,
//         style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15));
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     TextInputType keyboardType = TextInputType.text,
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
//         validator: validator,
//         decoration: InputDecoration(
//           prefixIcon: Icon(icon, color: Colors.black87, size: 20),
//           hintText: label,
//           hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13),
//           border: InputBorder.none,
//           errorBorder: InputBorder.none,
//           focusedErrorBorder: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
//         ),
//       ),
//     );
//   }

//   Widget _buildVehicleTypeSelector() {
//     return Wrap(
//       spacing: 10,
//       runSpacing: 10,
//       children: _vehicleTypes.map((type) {
//         final isSelected = _vehicleType == type;
//         return GestureDetector(
//           onTap: () => setState(() => _vehicleType = type),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
//             decoration: BoxDecoration(
//               color: isSelected ? Colors.black : Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(
//                   color: isSelected ? Colors.black : const Color(0xFFEDEDED)),
//             ),
//             child: Text(
//               type,
//               style: TextStyle(
//                 color: isSelected ? Colors.white : Colors.black87,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 13,
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   Widget _buildUploadTile({
//     required String label,
//     required bool uploaded,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: uploaded ? const Color(0xFF16A34A) : const Color(0xFFEDEDED),
//           ),
//         ),
//         child: Row(
//           children: [
//             Icon(
//               uploaded ? Icons.check_circle : Icons.upload_file_outlined,
//               color: uploaded ? const Color(0xFF16A34A) : Colors.black54,
//               size: 20,
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Text(
//                 uploaded ? '$label — Uploaded' : label,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 13,
//                   color: uploaded ? const Color(0xFF16A34A) : Colors.black87,
//                 ),
//               ),
//             ),
//             if (!uploaded)
//               const Text('Upload',
//                   style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 12)),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class DeliveryBookingScreen extends StatefulWidget {
  const DeliveryBookingScreen({super.key});

  @override
  State<DeliveryBookingScreen> createState() => _DeliveryBookingScreenState();
}

class _DeliveryBookingScreenState extends State<DeliveryBookingScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _cityController = TextEditingController();
  final _vehicleNumberController = TextEditingController();
  final _licenseNumberController = TextEditingController();

  String _vehicleType = 'Bike';
  bool _hasLicenseUploaded = false;
  bool _hasIdProofUploaded = false;
  bool _isSubmitting = false;

  final List<String> _vehicleTypes = const ['Bike', 'Scooter', 'Bicycle', 'Van'];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    _vehicleNumberController.dispose();
    _licenseNumberController.dispose();
    super.dispose();
  }

  void _submitApplication() {
    if (!_formKey.currentState!.validate()) return;

    if (!_hasIdProofUploaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload your ID proof')),
      );
      return;
    }
    if (!_hasLicenseUploaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload your driving license')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    // Simulated submission — replace with a real API call when ready.
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Application Submitted!'),
          content: const Text(
            'Thanks for applying to become a Rento delivery partner. '
            'Our team will verify your documents and get back to you '
            'within 24-48 hours.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // close dialog
                Navigator.pop(context); // go back
              },
              child: const Text('OK', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Become a Rider',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildHeaderBanner(),
            const SizedBox(height: 22),

            _sectionTitle('Personal Details'),
            const SizedBox(height: 10),
            _buildTextField(
              controller: _nameController,
              label: 'Full Name',
              icon: Icons.person_outline,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter your full name' : null,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _phoneController,
              label: 'Mobile Number',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator: (v) {
                if (v == null || v.trim().length != 10) return 'Enter a valid 10-digit number';
                return null;
              },
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _emailController,
              label: 'Email Address',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || !v.contains('@')) return 'Enter a valid email';
                return null;
              },
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _cityController,
              label: 'City',
              icon: Icons.location_city_outlined,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter your city' : null,
            ),

            const SizedBox(height: 22),
            _sectionTitle('Vehicle Details'),
            const SizedBox(height: 10),
            _buildVehicleTypeSelector(),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _vehicleNumberController,
              label: 'Vehicle Number (e.g. KA 05 JK 1234)',
              icon: Icons.two_wheeler_outlined,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter your vehicle number' : null,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _licenseNumberController,
              label: 'Driving License Number',
              icon: Icons.badge_outlined,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter your license number' : null,
            ),

            const SizedBox(height: 22),
            _sectionTitle('Upload Documents'),
            const SizedBox(height: 10),
            _buildUploadTile(
              label: 'ID Proof (Aadhaar / PAN)',
              uploaded: _hasIdProofUploaded,
              onTap: () => setState(() => _hasIdProofUploaded = true),
            ),
            const SizedBox(height: 10),
            _buildUploadTile(
              label: 'Driving License',
              uploaded: _hasLicenseUploaded,
              onTap: () => setState(() => _hasLicenseUploaded = true),
            ),

            const SizedBox(height: 26),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                ),
                onPressed: _isSubmitting ? null : _submitApplication,
                child: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Submit Application',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 14)),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'By submitting, you agree to Rento\'s Rider Terms & Conditions',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.electric_moped_outlined, color: Colors.white, size: 36),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Earn with Rento',
                    style: TextStyle(
                        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                SizedBox(height: 4),
                Text(
                  'Deliver orders in your city, work flexible hours, and get paid weekly.',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(title,
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15));
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEDEDED)),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.black87, size: 20),
          hintText: label,
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13),
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        ),
      ),
    );
  }

  Widget _buildVehicleTypeSelector() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: _vehicleTypes.map((type) {
        final isSelected = _vehicleType == type;
        return GestureDetector(
          onTap: () => setState(() => _vehicleType = type),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: isSelected ? Colors.black : const Color(0xFFEDEDED)),
            ),
            child: Text(
              type,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildUploadTile({
    required String label,
    required bool uploaded,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: uploaded ? const Color(0xFF16A34A) : const Color(0xFFEDEDED),
          ),
        ),
        child: Row(
          children: [
            Icon(
              uploaded ? Icons.check_circle : Icons.upload_file_outlined,
              color: uploaded ? const Color(0xFF16A34A) : Colors.black54,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                uploaded ? '$label — Uploaded' : label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: uploaded ? const Color(0xFF16A34A) : Colors.black87,
                ),
              ),
            ),
            if (!uploaded)
              const Text('Upload',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}