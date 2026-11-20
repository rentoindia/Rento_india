/// Represents a pickup or delivery address, plus the receiver's contact
/// details when it's a delivery address.
class AddressModel {
  const AddressModel({
    required this.label,
    required this.fullAddress,
    this.contactName,
    this.contactPhone,
    this.latitude,
    this.longitude,
  });

  final String label; // e.g. "Door No. 12, 4th Avenue"
  final String fullAddress; // e.g. "Anna Nagar West, Chennai - 600040"
  final String? contactName;
  final String? contactPhone;
  final double? latitude;
  final double? longitude;

  String get combined => '$label, $fullAddress';

  AddressModel copyWith({
    String? label,
    String? fullAddress,
    String? contactName,
    String? contactPhone,
    double? latitude,
    double? longitude,
  }) {
    return AddressModel(
      label: label ?? this.label,
      fullAddress: fullAddress ?? this.fullAddress,
      contactName: contactName ?? this.contactName,
      contactPhone: contactPhone ?? this.contactPhone,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
