import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Reusable "tap to upload" box used across every rider registration
/// screen (Aadhaar, Driving License, Vehicle RC, ownership proof, etc).
///
/// When [previewBytes] is provided, shows the actual picked image as
/// a thumbnail instead of just a checkmark.
class DocumentUploadBox extends StatelessWidget {
  final String label;
  final bool isUploaded;
  final Uint8List? previewBytes;
  final VoidCallback onTap;

  const DocumentUploadBox({
    super.key,
    required this.label,
    required this.isUploaded,
    required this.onTap,
    this.previewBytes,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        height: previewBytes != null ? 140 : null,
        padding: previewBytes != null
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(vertical: 22),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: isUploaded ? const Color(0xFFE8F8EF) : AppColors.inputFill,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isUploaded ? AppColors.success : AppColors.border,
          ),
        ),
        child: previewBytes != null
            ? Stack(
                fit: StackFit.expand,
                children: [
                  Image.memory(previewBytes!, fit: BoxFit.cover),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: AppColors.pureWhite,
                        size: 14,
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isUploaded ? Icons.check_circle : Icons.camera_alt_outlined,
                    color: isUploaded
                        ? AppColors.success
                        : AppColors.textSecondary,
                    size: 26,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isUploaded ? '$label uploaded' : 'Tap to upload',
                    style: TextStyle(
                      fontSize: 13,
                      color: isUploaded
                          ? AppColors.success
                          : AppColors.textSecondary,
                      fontWeight: isUploaded
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
