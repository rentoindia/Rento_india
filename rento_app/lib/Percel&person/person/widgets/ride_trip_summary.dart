import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../parcel/models/address_model.dart';

/// The compact pickup/drop card shown right under the map header, plus
/// the "6.4 km · 18 min · ₹92-₹298" pill row — matches the reference
/// design's trip summary block.
class RideTripSummaryCard extends StatelessWidget {
  const RideTripSummaryCard({
    super.key,
    required this.pickup,
    required this.destination,
    this.distanceLabel,
    this.durationLabel,
    this.fareRangeLabel,
    this.compact = false,
  });

  final AddressModel? pickup;
  final AddressModel? destination;
  final String? distanceLabel;
  final String? durationLabel;
  final String? fareRangeLabel;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RideTripTimeline(pickup: pickup, destination: destination),
          if (distanceLabel != null || durationLabel != null) ...[
            const SizedBox(height: 14),
            const Divider(height: 1),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (distanceLabel != null)
                  _StatPill(
                    icon: Icons.location_on_outlined,
                    label: distanceLabel!,
                  ),
                if (durationLabel != null)
                  _StatPill(icon: Icons.schedule, label: durationLabel!),
                if (fareRangeLabel != null)
                  _StatPill(icon: Icons.currency_rupee, label: fareRangeLabel!),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppColors.grey500),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.captionStrong.copyWith(fontSize: 11.5),
          ),
        ],
      ),
    );
  }
}

/// The pickup (dot) → drop (square) timeline rows shared by the
/// Ride Confirmation and Ride Tracking screens.
class RideTripTimeline extends StatelessWidget {
  const RideTripTimeline({
    super.key,
    required this.pickup,
    required this.destination,
  });

  final AddressModel? pickup;
  final AddressModel? destination;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TimelineRow(
          marker: _TimelineMarker.dot,
          label: 'Pickup',
          title: pickup?.label ?? 'Pondicherry University',
          subtitle: pickup?.fullAddress ?? 'Kalapet, Puducherry',
          showConnector: true,
        ),
        _TimelineRow(
          marker: _TimelineMarker.square,
          label: 'Drop',
          title: destination?.label ?? 'White Town',
          subtitle: destination?.fullAddress ?? 'Puducherry, 605001',
          showConnector: false,
        ),
      ],
    );
  }
}

enum _TimelineMarker { dot, square }

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({
    required this.marker,
    required this.label,
    required this.title,
    required this.subtitle,
    required this.showConnector,
  });

  final _TimelineMarker marker;
  final String label;
  final String title;
  final String subtitle;
  final bool showConnector;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            marker == _TimelineMarker.dot
                ? Container(
                    height: 10,
                    width: 10,
                    margin: const EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.black,
                    ),
                  )
                : Container(
                    height: 10,
                    width: 10,
                    margin: const EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
            if (showConnector)
              Container(
                width: 1.4,
                height: 32,
                margin: const EdgeInsets.symmetric(vertical: 4),
                color: AppColors.divider,
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: showConnector ? 14 : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.caption),
                const SizedBox(height: 2),
                Text(title, style: AppTextStyles.bodyStrong),
                Text(
                  subtitle,
                  style: AppTextStyles.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
