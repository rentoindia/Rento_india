/// Route name constants. Add new route names here as you build more
/// rider screens, so navigation strings never get typo'd across files.
class RouteNames {
  RouteNames._();

  static const String splash = '/splash';
  static const String mobileEntry = '/mobile-entry';
  static const String otpVerification = '/otp-verification';
  static const String completeProfile = '/complete-profile';
  static const String roleSelection = '/role-selection';

  // Rider (to be wired as we build them)
  // static const String riderRegistration = '/delivery/registration';
  // static const String riderSelfieVerification = '/rider/selfie-verification';
  // static const String riderCommonInfo = '/rider/common-info';
  // static const String riderDrivingLicense = '/rider/driving-license';
  // static const String riderVehicleDetails = '/rider/vehicle-details';
  // static const String riderInsuranceDetails = '/rider/insurance-details';
  // static const String riderBankDetails = '/rider/bank-details';
  // static const String riderDeliveryZone = '/rider/delivery-zone';
  // static const String riderReviewDetails = '/rider/review-details';
  // static const String riderUnderReview = '/rider/under-review';
  // static const String riderApproved = '/rider/approved';
  // static const String riderHome = '/rider/home';
  // static const String riderTrips = '/rider/trips';

  static const String riderRegistration = '/rider/registration';
  static const String riderSelfieVerification = '/rider/selfie-verification';
  static const String riderCommonInfo = '/rider/common-info';
  static const String riderDrivingLicense = '/rider/driving-license';
  static const String riderVehicleDetails = '/rider/vehicle-details';
  static const String riderInsuranceDetails = '/rider/insurance-details';
  static const String riderBankDetails = '/rider/bank-details';
  static const String riderDeliveryZone = '/rider/delivery-zone';
  static const String riderReviewDetails = '/rider/review-details';
  static const String riderUnderReview = '/rider/under-review';
  static const String riderApproved = '/rider/approved';
  static const String riderHome = '/rider/home';
  static const String riderTrips = '/rider/trips';

  // Customer (teammate's module — verification flow only, for now)
  static const String customerCommonInfo = '/customer/common-info';
  static const String customerAddressInfo = '/customer/address-info';
  static const String customerReviewDetails = '/customer/review-details';
  static const String customerUnderReview = '/customer/under-review';
  static const String customerApproved = '/customer/approved';
  static const String customerHome = '/customer/home';
}
