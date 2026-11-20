/// Simple in-memory holder for data collected across the customer
/// registration flow (Common Info -> Address Info -> Review Details).
///
/// NOTE: same lightweight-placeholder approach as
/// RiderRegistrationData — migrate to a real provider once state
/// management is wired up properly.
class CustomerRegistrationData {
  CustomerRegistrationData._();
  static final CustomerRegistrationData instance = CustomerRegistrationData._();

  String fullName = '';
  String mobileNumber = '';
  String email = '';

  String addressLine1 = '';
  String addressLine2 = '';
  String city = '';
  String pincode = '';
}
