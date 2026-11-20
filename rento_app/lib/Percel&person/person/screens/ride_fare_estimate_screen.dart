import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/section_card.dart';
import '../../parcel/widgets/map_preview.dart';
import '../models/ride_vehicle_option_model.dart';
import '../providers/ride_booking_provider.dart';
import '../widgets/ride_trip_summary.dart';
import 'vehicle_selection_screen.dart';

/// Step 3 of the ride flow — a quick "here's your route" screen before
/// the customer compares vehicles. Reuses the dependency-free
/// `MapPreview` and the shared trip-summary widgets.
class RideFareEstimateScreen extends ConsumerWidget {
  const RideFareEstimateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booking = ref.watch(rideBookingProvider);

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: const FlowAppBar(
        eyebrow: 'RIDE',
        title: 'Fare Estimate',
        subtitle: 'Review your trip before choosing a ride',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MapPreview(height: 200, showRoute: true),
              const SizedBox(height: 16),
              RideTripSummaryCard(
                pickup: booking.pickup,
                destination: booking.destination,
                distanceLabel: booking.distanceLabel,
                durationLabel: booking.durationLabel,
                fareRangeLabel:
                    '${booking.lowestFareLabel}-${booking.highestFareLabel}',
              ),
              const SizedBox(height: 20),
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.insights_outlined,
                          size: 18,
                          color: AppColors.black,
                        ),
                        const SizedBox(width: 8),
                        Text('Estimated fare range', style: AppTextStyles.bodyStrong),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${booking.lowestFareLabel} - ${booking.highestFareLabel}',
                      style: AppTextStyles.display,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Final fare depends on the vehicle you choose next.',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              for (final option in kRideVehicleOptions)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Icon(option.icon, size: 18, color: AppColors.grey500),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(option.name, style: AppTextStyles.body),
                      ),
                      Text(option.fareLabel, style: AppTextStyles.bodyStrong),
                    ],
                  ),
                ),
              const SizedBox(height: 8),
              PrimaryButton(
                label: 'Choose Your Ride',
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const VehicleSelectionScreen(),
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
