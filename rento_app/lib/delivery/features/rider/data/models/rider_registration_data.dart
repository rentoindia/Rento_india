import 'dart:typed_data';

class RiderRegistrationData {
  RiderRegistrationData._();
  static final RiderRegistrationData instance = RiderRegistrationData._();

  String fullName = '';
  String mobileNumber = '';
  String email = '';

  String vehicleType = '';
  String vehicleNumber = '';

  String insuranceProvider = '';
  String policyNumber = '';
  String expiryDate = '';

  String bankName = '';
  String accountNumber = '';
  String ifscCode = '';

  String deliveryZone = '';

  // photos picked during registration (uploaded when the form is submitted)
  Uint8List? aadhaarFront;
  Uint8List? aadhaarBack;
  Uint8List? licenseImage;
  Uint8List? selfie;
}
