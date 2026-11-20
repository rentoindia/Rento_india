import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// A previously-used delivery contact — powers the Recent Receivers strip
/// and the full Saved Receivers screen.
class ReceiverModel {
  const ReceiverModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.addressLabel,
    required this.avatarColor,
  });

  final String id;
  final String name;
  final String phone;
  final String addressLabel;
  final Color avatarColor;

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }
}

/// Demo data standing in for a backend contacts/receivers list, same
/// spirit as the other hard-coded reference data in this module.
final kDemoReceivers = <ReceiverModel>[
  const ReceiverModel(
    id: 'r1',
    name: 'Priya Sharma',
    phone: '+91 98765 43210',
    addressLabel: '42, Lotus Tower, Bandra West, Mumbai',
    avatarColor: AppColors.accentBlue,
  ),
  const ReceiverModel(
    id: 'r2',
    name: 'Arjun Mehta',
    phone: '+91 87654 32109',
    addressLabel: '8, Green Park Extension, New Delhi',
    avatarColor: AppColors.accentGreen,
  ),
  const ReceiverModel(
    id: 'r3',
    name: 'Kavita Nair',
    phone: '+91 76543 21098',
    addressLabel: '17, MG Road, Indiranagar, Bengaluru',
    avatarColor: Color(0xFFE0A519),
  ),
];
