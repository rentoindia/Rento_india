import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/section_card.dart';
import '../../parcel/widgets/map_preview.dart';
import '../models/captain_model.dart';
import '../models/ride_vehicle_option_model.dart';

/// "Ride Details" — full receipt-style view of a single past ride,
/// pushed from `RideHistoryScreen`.
class RideDetailsScreen extends StatelessWidget {
  const RideDetailsScreen({
    super.key,
    required this.rideId,
    required this.pickup,
    required this.destination,
    required this.date,
    required this.vehicle,
    required this.fare,
  });

  final String rideId;
  final String pickup;
  final String destination;
  final String date;
  final RideVehicleOptionModel vehicle;
  final double fare;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: FlowAppBar(eyebrow: 'RIDE', title: rideId),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            const MapPreview(height: 180, showRoute: true),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.divider),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(date, style: AppTextStyles.caption),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.trip_origin, size: 14, color: AppColors.black),
                      const SizedBox(width: 10),
                      Expanded(child: Text(pickup, style: AppTextStyles.bodyStrong)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Container(
                      width: 1.4,
                      height: 22,
                      color: AppColors.divider,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(destination, style: AppTextStyles.bodyStrong),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.divider),
              ),
              child: Row(
                children: [
                  Container(
                    height: 44,
                    width: 44,
                    decoration: const BoxDecoration(
                      color: AppColors.grey100,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(vehicle.icon, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(vehicle.name, style: AppTextStyles.bodyStrong),
                        Text(
                          'with ${kAssignedCaptain.name}',
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ),
                  Text('\u20B9${fare.toStringAsFixed(0)}', style: AppTextStyles.h2),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Paid',
                    style: AppTextStyles.bodyStrong.copyWith(color: AppColors.grey300),
                  ),
                  Text(
                    '\u20B9${fare.toStringAsFixed(0)}',
                    style: AppTextStyles.display.copyWith(
                      color: AppColors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
