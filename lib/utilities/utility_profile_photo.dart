import 'dart:convert';

import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
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
    final scheme = Theme.of(context).colorScheme;

    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              CoreSpacing.lg(sheetContext),
              CoreSpacing.sm(sheetContext),
              CoreSpacing.lg(sheetContext),
              CoreSpacing.lg(sheetContext),
            ),
            child: WidgetsAppCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          l10n.profileChangePhoto,
                          style: CoreTypography.headlineSmall(
                            sheetContext,
                            scheme.onSurface,
                          ),
                        ),
                      ),
                      WidgetsIconButton(
                        onPressed: () => Navigator.of(sheetContext).pop(),
                        icon: Icons.close,
                        tooltip:
                            MaterialLocalizations.of(
                              sheetContext,
                            ).closeButtonTooltip,
                      ),
                    ],
                  ),
                  SizedBox(height: CoreSpacing.sm(sheetContext)),
                  Text(
                    l10n.profileChoosePhoto,
                    style: CoreTypography.bodyMedium(
                      sheetContext,
                      scheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: CoreSpacing.lg(sheetContext)),
                  WidgetsAppButton(
                    label: l10n.profileTakePhoto,
                    icon: Icons.photo_camera_outlined,
                    fullWidth: true,
                    onPressed:
                        () => _pickFromSheet(
                          hostContext: context,
                          sheetContext: sheetContext,
                          source: ImageSource.camera,
                          onAvatarChanged: onAvatarChanged,
                        ),
                  ),
                  SizedBox(height: CoreSpacing.sm(sheetContext)),
                  WidgetsAppButton(
                    label: l10n.profileChooseFromGallery,
                    icon: Icons.photo_library_outlined,
                    fullWidth: true,
                    onPressed:
                        () => _pickFromSheet(
                          hostContext: context,
                          sheetContext: sheetContext,
                          source: ImageSource.gallery,
                          onAvatarChanged: onAvatarChanged,
                        ),
                  ),
                  if (hasExistingPhoto) ...[
                    SizedBox(height: CoreSpacing.sm(sheetContext)),
                    WidgetsAppButton(
                      label: l10n.profileRemovePhoto,
                      icon: Icons.delete_outline,
                      variant: WidgetsAppButtonVariant.outline,
                      fullWidth: true,
                      onPressed: () {
                        Navigator.of(sheetContext).pop();
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
                ],
              ),
            ),
          ),
        );
      },
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

  /// Starts the platform picker while the button gesture is still active
  /// (required on web), then closes the sheet.
  static Future<void> _pickFromSheet({
    required BuildContext hostContext,
    required BuildContext sheetContext,
    required ImageSource source,
    required ValueChanged<String?> onAvatarChanged,
  }) async {
    final l10n = AppLocalizations.of(hostContext)!;

    // Kick off pickImage immediately so web's <input>.click() stays inside
    // the user-activation window. Pop the sheet afterward.
    final pickFuture = _pickDataUri(source);
    if (sheetContext.mounted) {
      Navigator.of(sheetContext).pop();
    }

    try {
      final dataUri = await pickFuture;
      if (dataUri == null || !hostContext.mounted) return;
      onAvatarChanged(dataUri);
      UtilityMockFeedback.showSuccess(hostContext, l10n.profilePhotoUpdated);
    } catch (error, stack) {
      debugPrint('UtilityProfilePhoto.pick failed: $error\n$stack');
      if (!hostContext.mounted) return;

      // Desktop / some web builds reject camera — fall back to gallery once.
      if (source == ImageSource.camera) {
        try {
          final fallback = await _pickDataUri(ImageSource.gallery);
          if (fallback == null || !hostContext.mounted) return;
          onAvatarChanged(fallback);
          UtilityMockFeedback.showSuccess(
            hostContext,
            l10n.profilePhotoUpdated,
          );
          return;
        } catch (fallbackError, fallbackStack) {
          debugPrint(
            'UtilityProfilePhoto.gallery fallback failed: '
            '$fallbackError\n$fallbackStack',
          );
        }
      }

      if (hostContext.mounted) {
        UtilityMockFeedback.showError(hostContext, l10n.profilePhotoPickFailed);
      }
    }
  }

  static Future<String?> _pickDataUri(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? file;
    if (kIsWeb) {
      // Avoid resize options on web — they are optional and can add failure
      // modes; keep the picker click path as small as possible.
      file = await picker.pickImage(
        source: source,
        preferredCameraDevice:
            source == ImageSource.camera
                ? CameraDevice.front
                : CameraDevice.rear,
      );
    } else {
      file = await picker.pickImage(
        source: source,
        maxWidth: _maxDimension,
        maxHeight: _maxDimension,
        imageQuality: _imageQuality,
        preferredCameraDevice:
            source == ImageSource.camera
                ? CameraDevice.front
                : CameraDevice.rear,
      );
    }
    if (file == null) return null;
    final bytes = await file.readAsBytes();
    if (bytes.isEmpty) return null;
    final mime = _mimeTypeFor(file.name, file.mimeType);
    return 'data:$mime;base64,${base64Encode(bytes)}';
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
