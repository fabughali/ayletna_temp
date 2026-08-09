import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/utilities/utility_catalog_images.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_mock_food_image.dart';
import 'package:flutter/material.dart';

/// Admin image picker supporting single (add-ons) or multi (products/combos) mode.
class WidgetsCatalogImageEditor extends StatelessWidget {
  const WidgetsCatalogImageEditor({
    required this.imageUrls,
    required this.onChanged,
    required this.isAr,
    this.minImages = CatalogImageLimits.minProductImages,
    this.maxImages = CatalogImageLimits.maxProductImages,
    super.key,
  });

  final List<String> imageUrls;
  final ValueChanged<List<String>> onChanged;
  final bool isAr;
  final int minImages;
  final int maxImages;

  bool get _singleMode => maxImages == 1;

  Future<void> _addImage(BuildContext context) async {
    if (imageUrls.length >= maxImages) {
      UtilityMockFeedback.showWarning(
        context,
        isAr
            ? 'الحد الأقصى $maxImages صور'
            : 'Maximum $maxImages image${maxImages == 1 ? '' : 's'}',
      );
      return;
    }
    final picked = await UtilityCatalogImages.pickImageUrl(
      context,
      isAr: isAr,
    );
    if (picked == null || !context.mounted) return;
    if (_singleMode) {
      onChanged([picked]);
    } else {
      onChanged([...imageUrls, picked]);
    }
  }

  Future<void> _replaceImage(BuildContext context, int index) async {
    final picked = await UtilityCatalogImages.pickImageUrl(
      context,
      isAr: isAr,
      currentUrl: imageUrls[index],
    );
    if (picked == null) return;
    final next = [...imageUrls];
    next[index] = picked;
    onChanged(next);
  }

  void _removeImage(BuildContext context, int index) {
    if (imageUrls.length <= minImages) {
      UtilityMockFeedback.showWarning(
        context,
        isAr
            ? 'مطلوب $minImages صورة على الأقل'
            : 'At least $minImages image${minImages == 1 ? '' : 's'} required',
      );
      return;
    }
    final next = [...imageUrls]..removeAt(index);
    onChanged(next);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final countLabel =
        _singleMode
            ? (isAr ? 'صورة واحدة مطلوبة' : 'One image required')
            : (isAr
                ? '${imageUrls.length}/$maxImages (الحد الأدنى $minImages)'
                : '${imageUrls.length}/$maxImages (min $minImages)');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          countLabel,
          style: CoreTypography.caption(context, scheme.onSurfaceVariant),
        ),
        SizedBox(height: CoreSpacing.sm(context)),
        if (imageUrls.isEmpty)
          SizedBox(
            height: CoreContentSizes.heroImageHeight(context) * 0.35,
            width: double.infinity,
            child: WidgetsMockFoodImage(
              imageUrl: null,
              fallback: _ImageFallback(compact: false),
            ),
          )
        else if (_singleMode)
          _ImageTile(
            url: imageUrls.first,
            isAr: isAr,
            onReplace: () => _replaceImage(context, 0),
            onRemove: () => _removeImage(context, 0),
            canRemove: minImages == 0,
          )
        else
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.sm(context),
            children: [
              for (var i = 0; i < imageUrls.length; i++)
                SizedBox(
                  width: CoreContentSizes.catalogThumbWidth(context),
                  child: _ImageTile(
                    url: imageUrls[i],
                    isAr: isAr,
                    onReplace: () => _replaceImage(context, i),
                    onRemove: () => _removeImage(context, i),
                    canRemove: imageUrls.length > minImages,
                    compact: true,
                  ),
                ),
            ],
          ),
        SizedBox(height: CoreSpacing.md(context)),
        WidgetsAppButton(
          label:
              _singleMode
                  ? (isAr ? 'رفع / تغيير الصورة' : 'Upload / change image')
                  : (isAr ? 'إضافة صورة' : 'Add image'),
          onPressed:
              _singleMode && imageUrls.isNotEmpty
                  ? () => _replaceImage(context, 0)
                  : () => _addImage(context),
          icon: Icons.cloud_upload_outlined,
          variant: WidgetsAppButtonVariant.outline,
        ),
      ],
    );
  }
}

class _ImageTile extends StatelessWidget {
  const _ImageTile({
    required this.url,
    required this.isAr,
    required this.onReplace,
    required this.onRemove,
    required this.canRemove,
    this.compact = false,
  });

  final String url;
  final bool isAr;
  final VoidCallback onReplace;
  final VoidCallback onRemove;
  final bool canRemove;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final height =
        compact
            ? 88.0
            : CoreContentSizes.heroImageHeight(context) * 0.35;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
          child: SizedBox(
            height: height,
            width: double.infinity,
            child: WidgetsMockFoodImage(
              imageUrl: url,
              fallback: _ImageFallback(compact: compact),
            ),
          ),
        ),
        SizedBox(height: CoreSpacing.xs(context)),
        Row(
          children: [
            Expanded(
              child: TextButton.icon(
                onPressed: onReplace,
                icon: Icon(Icons.edit_outlined, size: CoreContentSizes.chipIcon(context)),
                label: Text(isAr ? 'تغيير' : 'Change'),
              ),
            ),
            if (canRemove)
              IconButton(
                onPressed: onRemove,
                icon: Icon(Icons.delete_outline, size: CoreContentSizes.buttonIcon(context)),
                tooltip: isAr ? 'حذف' : 'Remove',
              ),
          ],
        ),
      ],
    );
  }
}

class _ImageFallback extends StatelessWidget {
  const _ImageFallback({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ColoredBox(
      color: scheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          Icons.restaurant_outlined,
          size: compact ? 28 : 48,
          color: scheme.onSurfaceVariant.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}
