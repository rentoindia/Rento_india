import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// The white card at the top of the Pickup Address screen: the currently
/// resolved location (from the map/GPS), plus editable
/// Flat/House/Building and Street/Area/Landmark fields.
class PickupLocationCard extends StatelessWidget {
  const PickupLocationCard({
    super.key,
    required this.addressLine1,
    required this.addressLine2,
    required this.flatController,
    required this.landmarkController,
    required this.onGpsTap,
    required this.onFieldChanged,
    this.gpsLoading = false,
  });

  final String addressLine1;
  final String addressLine2;
  final TextEditingController flatController;
  final TextEditingController landmarkController;
  final VoidCallback onGpsTap;
  final VoidCallback onFieldChanged;
  final bool gpsLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderLight),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 36,
                width: 36,
                decoration: const BoxDecoration(
                  color: AppColors.black,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.location_on,
                  color: AppColors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('PICKUP LOCATION', style: AppTextStyles.overline),
                    const SizedBox(height: 3),
                    Text(
                      addressLine1,
                      style: AppTextStyles.bodyStrong,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (addressLine2.isNotEmpty) ...[
                      const SizedBox(height: 1),
                      Text(
                        addressLine2,
                        style: AppTextStyles.caption,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _GpsButton(onTap: onGpsTap, loading: gpsLoading),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: AppColors.dividerLight),
          const SizedBox(height: 14),
          Text('FLAT / HOUSE / BUILDING', style: AppTextStyles.overline),
          const SizedBox(height: 8),
          TextField(
            controller: flatController,
            style: AppTextStyles.body,
            onChanged: (_) => onFieldChanged(),
            decoration: const InputDecoration(
              hintText: 'e.g. Door No. A2, Ground Floor',
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              filled: false,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
          const SizedBox(height: 8),
          const Divider(height: 1, color: AppColors.dividerLight),
          const SizedBox(height: 14),
          Text('STREET / AREA / LANDMARK', style: AppTextStyles.overline),
          const SizedBox(height: 8),
          TextField(
            controller: landmarkController,
            style: AppTextStyles.body,
            onChanged: (_) => onFieldChanged(),
            decoration: InputDecoration(
              hintText: 'e.g. Near Anna Nagar West Bus Stop',
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              filled: false,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              suffixIcon: landmarkController.text.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(
                        Icons.close,
                        size: 16,
                        color: AppColors.grey400,
                      ),
                      onPressed: () {
                        landmarkController.clear();
                        onFieldChanged();
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GpsButton extends StatelessWidget {
  const _GpsButton({required this.onTap, required this.loading});

  final VoidCallback onTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        constraints: const BoxConstraints(minHeight: 32, minWidth: 48),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: AppColors.grey50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.borderLight),
        ),
        alignment: Alignment.center,
        child: loading
            ? const SizedBox(
                height: 12,
                width: 12,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text('GPS', style: AppTextStyles.captionStrong),
      ),
    );
  }
}
