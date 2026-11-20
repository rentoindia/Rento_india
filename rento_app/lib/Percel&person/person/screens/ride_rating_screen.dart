import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rento_india/screens/home_screen.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/primary_button.dart';
import '../models/captain_model.dart';
import '../providers/ride_booking_provider.dart';
import '../providers/ride_tracking_provider.dart';
import 'ride_history_screen.dart';

const _kPositiveTags = [
  'Safe Driving',
  'Friendly Captain',
  'On Time',
  'Clean Vehicle',
];
const _kNegativeTags = [
  'Late Pickup',
  'Rash Driving',
  'Rude Behavior',
  'Vehicle Condition',
];

/// "Rate Your Captain" — pixel-for-pixel the same layout as the parcel
/// module's `RateRiderScreen` (avatar, star row with animated label,
/// context-aware feedback chips, optional comment, Submit/Skip), just
/// pointed at the assigned captain and the ride-scoped providers.
class RideRatingScreen extends ConsumerStatefulWidget {
  const RideRatingScreen({super.key});

  @override
  ConsumerState<RideRatingScreen> createState() => _RideRatingScreenState();
}

class _RideRatingScreenState extends ConsumerState<RideRatingScreen> {
  final _commentController = TextEditingController();
  final Set<String> _selectedTags = {};

  static const _labels = {
    1: 'Poor',
    2: 'Fair',
    3: 'Good',
    4: 'Very Good',
    5: 'Excellent',
  };

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _finish() {
    ref.read(rideBookingProvider.notifier).reset();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  String _initialsFor(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final rating = ref.watch(captainRatingProvider);
    final captain = kAssignedCaptain;
    // Positive tags once the customer picks 4-5 stars, negative tags for
    // low ratings; nothing shown until a rating is picked.
    final tags = rating == 0
        ? const <String>[]
        : rating >= 4
        ? _kPositiveTags
        : _kNegativeTags;

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: _BackButton(
                  onTap: () => Navigator.of(context).maybePop(),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 72,
                width: 72,
                decoration: const BoxDecoration(
                  color: AppColors.black,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  _initialsFor(captain.name),
                  style: AppTextStyles.h1.copyWith(color: AppColors.white),
                ),
              ),
              const SizedBox(height: 12),
              Text(captain.name, style: AppTextStyles.h2),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star, size: 14, color: AppColors.black),
                  const SizedBox(width: 4),
                  Text('${captain.rating}', style: AppTextStyles.captionStrong),
                  const SizedBox(width: 6),
                  Text('\u00b7', style: AppTextStyles.caption),
                  const SizedBox(width: 6),
                  Text(
                    '${captain.completedRides} rides',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Text('Rate your experience', style: AppTextStyles.bodyStrong),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (i) {
                  final starIndex = i + 1;
                  final filled = starIndex <= rating;
                  return GestureDetector(
                    onTap: () =>
                        ref.read(captainRatingProvider.notifier).state =
                            starIndex,
                    child: AnimatedScale(
                      scale: filled ? 1.15 : 1.0,
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOut,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          filled ? Icons.star : Icons.star_border,
                          size: 38,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 8),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Text(
                  rating == 0 ? ' ' : _labels[rating]!,
                  key: ValueKey(rating),
                  style: AppTextStyles.bodyStrong,
                ),
              ),
              if (tags.isNotEmpty) ...[
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    rating >= 4 ? 'What went well?' : 'What could improve?',
                    style: AppTextStyles.captionStrong,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final tag in tags)
                      _FeedbackChip(
                        label: tag,
                        selected: _selectedTags.contains(tag),
                        onTap: () => setState(() {
                          if (!_selectedTags.remove(tag)) {
                            _selectedTags.add(tag);
                          }
                        }),
                      ),
                  ],
                ),
              ],
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Leave a comment (optional)',
                  style: AppTextStyles.captionStrong,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _commentController,
                maxLines: 3,
                style: AppTextStyles.body,
                decoration: const InputDecoration(
                  hintText: 'Tell us more about your ride experience...',
                ),
              ),
              const SizedBox(height: 28),
              PrimaryButton(
                label: 'Submit Rating',
                enabled: rating > 0,
                onPressed: rating > 0 ? _finish : null,
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: _finish,
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    color: AppColors.grey500,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      shape: const CircleBorder(),
      elevation: 3,
      shadowColor: Colors.black.withValues(alpha: 0.2),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: const Padding(
          padding: EdgeInsets.all(10),
          child: Icon(Icons.arrow_back, size: 18, color: AppColors.black),
        ),
      ),
    );
  }
}

class _FeedbackChip extends StatelessWidget {
  const _FeedbackChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? AppColors.black : AppColors.grey50,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.black : AppColors.divider,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: selected ? AppColors.white : AppColors.grey700,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
