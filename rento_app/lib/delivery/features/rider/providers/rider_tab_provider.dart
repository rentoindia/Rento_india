import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Which bottom-nav tab is active in RiderShell.
/// 0 = Home, 1 = Requests, 2 = Trips, 3 = Earnings, 4 = Profile.
///
/// Lives in a provider (not local State on RiderShell) specifically so
/// screens NESTED inside a tab — like AvailableRequestsScreen's back
/// button — can switch the shell back to Home without needing a
/// Navigator route to pop (there isn't one; tabs aren't routes).
final riderTabIndexProvider = StateProvider<int>((ref) => 0);
