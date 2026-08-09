import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:flutter/material.dart';

/// Catalog image limits enforced across admin create/edit flows.
abstract final class CatalogImageLimits {
  static const minProductImages = 1;
  static const maxProductImages = 5;
  static const addonImages = 1;
}

/// Shared image URL picker for catalog admin screens.
abstract final class UtilityCatalogImages {
  static List<String> presetUrls({int take = 8}) {
    return MockupCatalog.items
        .map((item) => item.imageUrl)
        .whereType<String>()
        .where((url) => url.isNotEmpty)
        .toSet()
        .take(take)
        .toList();
  }

  static Future<String?> pickImageUrl(
    BuildContext context, {
    required bool isAr,
    String? currentUrl,
  }) async {
    final urlController = TextEditingController(text: currentUrl ?? '');
    final presets = presetUrls();
    final picked = await showDialog<String>(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text(isAr ? 'صورة' : 'Image'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  WidgetsAppTextField(
                    controller: urlController,
                    label: isAr ? 'رابط الصورة' : 'Image URL',
                    prefixIcon: Icons.link,
                  ),
                  if (presets.isNotEmpty) ...[
                    SizedBox(height: CoreSpacing.md(context)),
                    Text(
                      isAr ? 'صور جاهزة' : 'Preset photos',
                      style: CoreTypography.caption(
                        context,
                        Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: CoreSpacing.sm(context)),
                    Wrap(
                      spacing: CoreSpacing.sm(context),
                      runSpacing: CoreSpacing.sm(context),
                      children: [
                        for (final url in presets)
                          ActionChip(
                            label: Text(
                              url.split('/').last,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onPressed: () => Navigator.pop(dialogContext, url),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text(isAr ? 'إلغاء' : 'Cancel'),
              ),
              TextButton(
                onPressed:
                    () => Navigator.pop(
                      dialogContext,
                      urlController.text.trim(),
                    ),
                child: Text(isAr ? 'تطبيق' : 'Apply'),
              ),
            ],
          ),
    );
    urlController.dispose();
    if (picked == null || picked.isEmpty) return null;
    return picked;
  }
}
