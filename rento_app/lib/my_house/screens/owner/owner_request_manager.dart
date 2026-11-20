import 'package:flutter/material.dart';

enum RequestStatus { pending, accepted, completed }

class TenantRequest {
  final String id;
  final String name;
  final String property;
  final String location;
  final String date;
  final String address;
  final List<Map<String, String>> documents;
  RequestStatus status;
  final String rent;
  final String moveIn;

  TenantRequest({
    required this.id,
    required this.name,
    required this.property,
    required this.location,
    required this.date,
    required this.address,
    required this.documents,
    this.status = RequestStatus.pending,
    this.rent = '',
    this.moveIn = '',
  });
}

class OwnerRequestManager extends ChangeNotifier {
  OwnerRequestManager._internal();
  static final OwnerRequestManager instance = OwnerRequestManager._internal();

  final List<TenantRequest> _requests = [
    TenantRequest(
      id: 'req_1',
      name: 'Karthik Raj',
      property: '2 BHK Apartment',
      location: 'Anna Nagar, Chennai',
      date: '15 May 2025, 10:00 AM',
      address: '12/4, 2nd Street, Villivakkam, Chennai - 600049',
      rent: '₹12,000 / month',
      moveIn: 'Move-in: 15 May 2025',
      documents: const [
        {'label': 'Aadhaar Card', 'status': 'Verified'},
        {'label': 'Salary Slip', 'status': 'Verified'},
        {'label': 'Self Photo', 'status': 'Verified'},
      ],
    ),
    TenantRequest(
      id: 'req_2',
      name: 'Vignesh Kumar',
      property: '1 BHK Apartment',
      location: 'Nungambakkam, Chennai',
      date: '14 May 2025, 04:00 PM',
      address: '45, Kamarajar Salai, Nungambakkam, Chennai - 600034',
      rent: '₹9,000 / month',
      moveIn: 'Move-in: 10 May 2025',
      documents: const [
        {'label': 'Aadhaar Card', 'status': 'Verified'},
        {'label': 'Salary Slip', 'status': 'Pending'},
        {'label': 'Self Photo', 'status': 'Verified'},
      ],
    ),
  ];

  List<TenantRequest> get pending =>
      _requests.where((r) => r.status == RequestStatus.pending).toList();
  List<TenantRequest> get accepted =>
      _requests.where((r) => r.status == RequestStatus.accepted).toList();
  List<TenantRequest> get completed =>
      _requests.where((r) => r.status == RequestStatus.completed).toList();

  void acceptVisit(String id) {
    final r = _requests.firstWhere((r) => r.id == id);
    r.status = RequestStatus.accepted;
    notifyListeners();
  }

  void approveTenant(String id) {
    final r = _requests.firstWhere((r) => r.id == id);
    r.status = RequestStatus.completed;
    notifyListeners();
  }

  void rejectRequest(String id) {
    _requests.removeWhere((r) => r.id == id);
    notifyListeners();
  }
}
