import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/primary_button.dart';
import '../models/rider_model.dart';
import '../providers/booking_provider.dart';
import '../providers/tracking_provider.dart';

const _kPositiveTags = [
  'Fast Delivery',
  'Careful Handling',
  'Professional',
  'On Time',
];
const _kNegativeTags = [
  'Late Delivery',
  'Damaged Package',
  'Rude Behavior',
  'Poor Communication',
];

class RateRiderScreen extends ConsumerStatefulWidget {
  const RateRiderScreen({super.key});

  @override
  ConsumerState<RateRiderScreen> createState() => _RateRiderScreenState();
}

class _RateRiderScreenState extends ConsumerState<RateRiderScreen> {
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
    ref.read(bookingProvider.notifier).reset();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  String _initialsFor(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final rating = ref.watch(riderRatingProvider);
    final rider = kAssignedRider;
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
              Container(
                height: 72,
                width: 72,
                decoration: const BoxDecoration(
                  color: AppColors.black,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  _initialsFor(rider.name),
                  style: AppTextStyles.h1.copyWith(color: AppColors.white),
                ),
              ),
              const SizedBox(height: 12),
              Text(rider.name, style: AppTextStyles.h2),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star, size: 14, color: AppColors.black),
                  const SizedBox(width: 4),
                  Text('${rider.rating}', style: AppTextStyles.captionStrong),
                  const SizedBox(width: 6),
                  Text('·', style: AppTextStyles.caption),
                  const SizedBox(width: 6),
                  Text(
                    '${rider.completedDeliveries} deliveries',
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
                    onTap: () => ref.read(riderRatingProvider.notifier).state =
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
                  hintText: 'Tell us more about your delivery experience...',
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
