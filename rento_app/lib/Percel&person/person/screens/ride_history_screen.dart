// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:rento/screens/home_screen.dart';
// import '../../core/theme/app_colors.dart';
// import '../../core/theme/app_text_styles.dart';
// import '../../core/widgets/section_card.dart';
// import '../../core/widgets/primary_button.dart';
// import '../models/ride_vehicle_option_model.dart';
// import 'ride_details_screen.dart';

// class _PastRide {
//   const _PastRide({
//     required this.rideId,
//     required this.pickup,
//     required this.destination,
//     required this.date,
//     required this.vehicle,
//     required this.fare,
//   });

//   final String rideId;
//   final String pickup;
//   final String destination;
//   final String date;
//   final RideVehicleOptionModel vehicle;
//   final double fare;
// }

// final _pastRides = [
//   _PastRide(
//     rideId: 'RIDE10234',
//     pickup: 'Pondicherry University',
//     destination: 'White Town',
//     date: 'Today, 9:41 AM',
//     vehicle: kRideVehicleOptions[0],
//     fare: 92,
//   ),
//   _PastRide(
//     rideId: 'RIDE10198',
//     pickup: 'Kalapet',
//     destination: 'Auroville',
//     date: 'Yesterday, 6:12 PM',
//     vehicle: kRideVehicleOptions[2],
//     fare: 214,
//   ),
//   _PastRide(
//     rideId: 'RIDE10142',
//     pickup: 'Puducherry Railway Station',
//     destination: 'Promenade Beach',
//     date: 'Mon, 11:05 AM',
//     vehicle: kRideVehicleOptions[1],
//     fare: 128,
//   ),
// ];

// /// "Ride History" — a simple, on-brand list of past rides. There was no
// /// equivalent screen to reuse in the parcel module (it only has a
// /// receiver-address history), so this is a small new page built with
// /// the same cards/typography as everything else.
// class RideHistoryScreen extends ConsumerWidget {
//   const RideHistoryScreen({super.key});

//   void _goHome(BuildContext context) {
//     Navigator.of(context).pushAndRemoveUntil(
//       MaterialPageRoute(builder: (_) => const HomeScreen()),
//       (route) => false,
//     );
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       backgroundColor: AppColors.offWhite,
//       appBar: const FlowAppBar(eyebrow: 'RIDE', title: 'Ride History'),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
//                 itemCount: _pastRides.length,
//                 itemBuilder: (context, index) {
//                   final ride = _pastRides[index];
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 12),
//                     child: Material(
//                       color: AppColors.white,
//                       borderRadius: BorderRadius.circular(18),
//                       child: InkWell(
//                         borderRadius: BorderRadius.circular(18),
//                         onTap: () => Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (_) => RideDetailsScreen(
//                               rideId: ride.rideId,
//                               pickup: ride.pickup,
//                               destination: ride.destination,
//                               date: ride.date,
//                               vehicle: ride.vehicle,
//                               fare: ride.fare,
//                             ),
//                           ),
//                         ),
//                         child: Container(
//                           padding: const EdgeInsets.all(14),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(18),
//                             border: Border.all(color: AppColors.divider),
//                           ),
//                           child: Row(
//                             children: [
//                               Container(
//                                 height: 44,
//                                 width: 44,
//                                 decoration: const BoxDecoration(
//                                   color: AppColors.grey100,
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: Icon(ride.vehicle.icon, size: 20),
//                               ),
//                               const SizedBox(width: 12),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       '${ride.pickup} \u2192 ${ride.destination}',
//                                       style: AppTextStyles.bodyStrong,
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                     Text(
//                                       ride.date,
//                                       style: AppTextStyles.caption,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Text(
//                                 '\u20B9${ride.fare.toStringAsFixed(0)}',
//                                 style: AppTextStyles.bodyStrong,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
//               child: PrimaryButton(
//                 label: 'Back to Home',
//                 onPressed: () => _goHome(context),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'package:rento_india/screens/home_screen.dart';
import '../models/ride_vehicle_option_model.dart';
import 'ride_details_screen.dart';

class _PastRide {
  const _PastRide({
    required this.rideId,
    required this.time,
    required this.pickup,
    required this.destination,
    required this.fare,
    required this.vehicle,
    required this.avatarColor,
    required this.avatarBgColor,
    required this.shared,
    this.status = 'Completed',
  });

  final String rideId;
  final String time;
  final String pickup;
  final String destination;
  final double fare;
  final RideVehicleOptionModel vehicle;
  final Color avatarColor;
  final Color avatarBgColor;
  final bool shared;
  final String status;
}

class _RideGroup {
  const _RideGroup({required this.label, required this.rides});
  final String label;
  final List<_PastRide> rides;
}

final _rideHistory = [
  _RideGroup(
    label: 'Today',
    rides: [
      _PastRide(
        rideId: 'RIDE10234',
        time: '9:41 AM',
        pickup: 'Pondicherry University',
        destination: 'White Town',
        fare: 92,
        vehicle: kRideVehicleOptions[0],
        avatarColor: AppColors.accentGreen,
        avatarBgColor: AppColors.accentGreenBg,
        shared: false,
      ),
    ],
  ),
  _RideGroup(
    label: 'Yesterday',
    rides: [
      _PastRide(
        rideId: 'RIDE10198',
        time: '6:12 PM',
        pickup: 'Anna Nagar',
        destination: 'T. Nagar',
        fare: 144,
        vehicle: kRideVehicleOptions[2],
        avatarColor: AppColors.accentPurple,
        avatarBgColor: AppColors.accentPurpleBg,
        shared: true,
      ),
    ],
  ),
  _RideGroup(
    label: '2 Aug 2026',
    rides: [
      _PastRide(
        rideId: 'RIDE10176',
        time: '11:05 AM',
        pickup: 'Velachery',
        destination: 'Guindy',
        fare: 108,
        vehicle: kRideVehicleOptions[1],
        avatarColor: AppColors.accentOrange,
        avatarBgColor: AppColors.accentOrangeBg,
        shared: false,
      ),
    ],
  ),
  _RideGroup(
    label: '1 Aug 2026',
    rides: [
      _PastRide(
        rideId: 'RIDE10158',
        time: '8:30 PM',
        pickup: 'Adyar',
        destination: 'OMR',
        fare: 176,
        vehicle: kRideVehicleOptions[2],
        avatarColor: AppColors.accentBlue,
        avatarBgColor: AppColors.accentBlueBg,
        shared: true,
      ),
      _PastRide(
        rideId: 'RIDE10151',
        time: '2:47 PM',
        pickup: 'Thoraipakkam',
        destination: 'Sholinganallur',
        fare: 0,
        vehicle: kRideVehicleOptions[1],
        avatarColor: AppColors.accentRed,
        avatarBgColor: AppColors.accentRedBg,
        shared: false,
        status: 'Cancelled',
      ),
    ],
  ),
  _RideGroup(
    label: '31 Jul 2026',
    rides: [
      _PastRide(
        rideId: 'RIDE10142',
        time: '7:10 AM',
        pickup: 'Porur',
        destination: 'Tambaram',
        fare: 120,
        vehicle: kRideVehicleOptions[0],
        avatarColor: AppColors.accentPink,
        avatarBgColor: AppColors.accentPinkBg,
        shared: false,
      ),
    ],
  ),
];

const _totalRideCount = 12;
const _totalDistanceLabel = '128 km';
const _totalTimeLabel = '6h 24m';
const _totalSpentLabel = '\u20B91,786';
const _avgRatingLabel = '4.8';

/// Filter options surfaced from the top-right "tune" button.
enum _RideFilter { all, completed, cancelled }

extension on _RideFilter {
  String get label {
    switch (this) {
      case _RideFilter.all:
        return 'All rides';
      case _RideFilter.completed:
        return 'Completed';
      case _RideFilter.cancelled:
        return 'Cancelled';
    }
  }

  bool matches(_PastRide ride) {
    switch (this) {
      case _RideFilter.all:
        return true;
      case _RideFilter.completed:
        return ride.status == 'Completed';
      case _RideFilter.cancelled:
        return ride.status == 'Cancelled';
    }
  }
}

/// "Rides history" — matches the reference design: a stats summary card
/// (distance / time / spend / rating), rides grouped by date, each ride
/// shown as a colored-avatar card with a pickup/drop route and a status
/// pill, ending with a "You've reached the end" footer.
class RideHistoryScreen extends ConsumerStatefulWidget {
  const RideHistoryScreen({super.key});

  @override
  ConsumerState<RideHistoryScreen> createState() => _RideHistoryScreenState();
}

class _RideHistoryScreenState extends ConsumerState<RideHistoryScreen> {
  _RideFilter _filter = _RideFilter.all;

  void _goHome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (route) => false,   
    );
  }

  Future<void> _openFilterSheet() async {
    final selected = await showModalBottomSheet<_RideFilter>(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: AppColors.grey200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                Text('Filter rides', style: AppTextStyles.bodyStrong),
                const SizedBox(height: 12),
                RadioGroup<_RideFilter>(
                  groupValue: _filter,
                  onChanged: (value) {
                    if (value != null) {
                      Navigator.of(sheetContext).pop(value);
                    }
                  },
                  child: Column(
                    children: [
                      for (final option in _RideFilter.values)
                        RadioListTile<_RideFilter>(
                          contentPadding: EdgeInsets.zero,
                          value: option,
                          activeColor: AppColors.black,
                          title: Text(option.label, style: AppTextStyles.body),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    if (selected != null && mounted) {
      setState(() => _filter = selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredGroups = [
      for (final group in _rideHistory)
        _RideGroup(
          label: group.label,
          rides: group.rides.where(_filter.matches).toList(),
        ),
    ].where((group) => group.rides.isNotEmpty).toList();

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _RoundIconButton(
                  icon: Icons.arrow_back_ios_new,
                  iconSize: 16,
                  onTap: () => Navigator.of(context).maybePop(),
                ),
                _RoundIconButton(
                  icon: Icons.tune,
                  iconSize: 18,
                  onTap: _openFilterSheet,
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text('Rides history', style: AppTextStyles.display),
            const SizedBox(height: 4),
            Text(
              _filter == _RideFilter.all
                  ? 'Total $_totalRideCount rides'
                  : '${_filter.label} \u00b7 ${filteredGroups.fold<int>(0, (sum, g) => sum + g.rides.length)} rides',
              style: AppTextStyles.subtitle,
            ),
            const SizedBox(height: 18),
            const _RideStatsCard(),
            const SizedBox(height: 24),
            if (filteredGroups.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Text(
                    'No ${_filter.label.toLowerCase()} rides yet',
                    style: AppTextStyles.caption,
                  ),
                ),
              ),
            for (final group in filteredGroups) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(group.label, style: AppTextStyles.bodyStrong),
              ),
              for (final ride in group.rides)
                Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: _RideHistoryCard(
                    ride: ride,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RideDetailsScreen(
                          rideId: ride.rideId,
                          pickup: ride.pickup,
                          destination: ride.destination,
                          date: '${group.label}, ${ride.time}',
                          vehicle: ride.vehicle,
                          fare: ride.fare,
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 8),
            ],
            if (filteredGroups.isNotEmpty)
              Center(
                child: Text(
                  "You've reached the end",
                  style: AppTextStyles.caption,
                ),
              ),
            const SizedBox(height: 20),
            PrimaryHomeButton(onTap: () => _goHome(context)),
          ],
        ),
      ),
    );
  }
}

/// Bottom "Back to Home" action — kept as a real button (in addition to
/// the header back arrow) so users can jump straight back to the home
/// screen from history without retracing the flow.
class PrimaryHomeButton extends StatelessWidget {
  const PrimaryHomeButton({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.black,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: Text('Back to Home', style: AppTextStyles.button),
        ),
      ),
    );
  }
}

class _RideStatsCard extends StatelessWidget {
  const _RideStatsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          _StatItem(
            icon: Icons.route_outlined,
            value: _totalDistanceLabel,
            label: 'Total Distance',
          ),
          _StatDivider(),
          _StatItem(
            icon: Icons.access_time,
            value: _totalTimeLabel,
            label: 'Total Time',
          ),
          _StatDivider(),
          _StatItem(
            icon: Icons.currency_rupee,
            value: _totalSpentLabel,
            label: 'Total Spent',
          ),
          _StatDivider(),
          _StatItem(
            icon: Icons.star_border,
            value: _avgRatingLabel,
            label: 'Avg. Rating',
          ),
        ],
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  const _StatDivider();

  @override
  Widget build(BuildContext context) {
    return Container(height: 44, width: 1, color: AppColors.divider);
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: AppColors.grey100,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 16, color: AppColors.black),
          ),
          const SizedBox(height: 8),
          Text(value, style: AppTextStyles.bodyStrong),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTextStyles.caption,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _RideHistoryCard extends StatelessWidget {
  const _RideHistoryCard({required this.ride, required this.onTap});

  final _PastRide ride;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.divider),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: ride.avatarBgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  ride.shared ? Icons.people_alt_rounded : Icons.person,
                  size: 20,
                  color: ride.avatarColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ride.time, style: AppTextStyles.caption),
                    const SizedBox(height: 8),
                    _RoutePoint(
                      color: AppColors.accentGreen,
                      label: ride.pickup,
                    ),
                    const SizedBox(height: 6),
                    _RoutePoint(
                      color: AppColors.accentRed,
                      label: ride.destination,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    ride.status == 'Cancelled'
                        ? '\u2014'
                        : '\u20B9${ride.fare.toStringAsFixed(0)}',
                    style: AppTextStyles.h2,
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: ride.status == 'Cancelled'
                          ? AppColors.accentRedBg
                          : AppColors.accentGreenBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      ride.status,
                      style: AppTextStyles.captionStrong.copyWith(
                        color: ride.status == 'Cancelled'
                            ? AppColors.accentRed
                            : AppColors.accentGreen,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 6),
              const Icon(
                Icons.chevron_right,
                size: 20,
                color: AppColors.grey400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoutePoint extends StatelessWidget {
  const _RoutePoint({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.bodyStrong,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
    required this.icon,
    required this.onTap,
    this.iconSize = 18,
  });

  final IconData icon;
  final VoidCallback onTap;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.divider),
          ),
          child: Icon(icon, size: iconSize, color: AppColors.black),
        ),
      ),
    );
  }
}