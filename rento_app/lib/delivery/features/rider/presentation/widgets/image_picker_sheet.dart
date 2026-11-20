import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Opens the gallery/file picker directly — no Camera-vs-Gallery
/// chooser sheet. Used by document upload screens (Aadhaar, Driving
/// License, Vehicle RC, etc.) where riders are uploading an existing
/// photo of a physical document rather than taking a fresh one.
///
/// Works cross-platform — XFile.readAsBytes() runs on mobile, desktop,
/// and web alike. Keeps the BuildContext parameter (unused now) so
/// existing call sites don't need to change.
Future<Uint8List?> pickImageFromSheet(BuildContext context) async {
  final picker = ImagePicker();
  final XFile? file = await picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 80,
  );
  if (file == null) return null;

  return await file.readAsBytes();
}
