import 'dart:convert';

import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Profile avatar pick helpers (gallery / camera → in-memory data URI).
abstract final class UtilityProfilePhoto {
  static const _maxDimension = 720.0;
  static const _imageQuality = 85;

  /// Offers camera / gallery (and remove when a photo exists), then applies
  /// the picked data URI via [onAvatarChanged]. Pass `null` to clear.
  static Future<void> presentPicker(
    BuildContext context, {
    required bool hasExistingPhoto,
    required ValueChanged<String?> onAvatarChanged,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return UtilityMockFeedback.showActionSheet(
      context: context,
      title: l10n.profileChangePhoto,
      message: l10n.profileChoosePhoto,
      actions: [
        MockSheetAction(
          label: l10n.profileTakePhoto,
          icon: Icons.photo_camera_outlined,
          onSelected:
              () => _pickAndApply(
                context,
                source: ImageSource.camera,
                onAvatarChanged: onAvatarChanged,
              ),
        ),
        MockSheetAction(
          label: l10n.profileChooseFromGallery,
          icon: Icons.photo_library_outlined,
          onSelected:
              () => _pickAndApply(
                context,
                source: ImageSource.gallery,
                onAvatarChanged: onAvatarChanged,
              ),
        ),
        if (hasExistingPhoto)
          MockSheetAction(
            label: l10n.profileRemovePhoto,
            icon: Icons.delete_outline,
            variant: WidgetsAppButtonVariant.outline,
            onSelected: () {
              onAvatarChanged(null);
              if (context.mounted) {
                UtilityMockFeedback.showSuccess(
                  context,
                  l10n.profilePhotoUpdated,
                );
              }
            },
          ),
      ],
    );
  }

  static ImageProvider? imageProvider(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) return null;
    if (imageUrl.startsWith('data:')) {
      final data = Uri.parse(imageUrl).data;
      if (data == null) return null;
      return MemoryImage(Uint8List.fromList(data.contentAsBytes()));
    }
    return NetworkImage(imageUrl);
  }

  static Future<void> _pickAndApply(
    BuildContext context, {
    required ImageSource source,
    required ValueChanged<String?> onAvatarChanged,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final picker = ImagePicker();
      final file = await picker.pickImage(
        source: source,
        maxWidth: _maxDimension,
        maxHeight: _maxDimension,
        imageQuality: _imageQuality,
        preferredCameraDevice: CameraDevice.front,
      );
      if (file == null) return;
      final bytes = await file.readAsBytes();
      if (bytes.isEmpty) return;
      final mime = _mimeTypeFor(file.name, file.mimeType);
      final dataUri = 'data:$mime;base64,${base64Encode(bytes)}';
      onAvatarChanged(dataUri);
      if (context.mounted) {
        UtilityMockFeedback.showSuccess(context, l10n.profilePhotoUpdated);
      }
    } catch (error, stack) {
      debugPrint('UtilityProfilePhoto.pick failed: $error\n$stack');
      if (context.mounted) {
        UtilityMockFeedback.showError(context, l10n.profilePhotoPickFailed);
      }
    }
  }

  static String _mimeTypeFor(String name, String? mimeType) {
    if (mimeType != null && mimeType.startsWith('image/')) return mimeType;
    final lower = name.toLowerCase();
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.webp')) return 'image/webp';
    if (lower.endsWith('.gif')) return 'image/gif';
    return 'image/jpeg';
  }
}
