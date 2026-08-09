import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_catalog_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_mock_food_image.dart';
import 'package:flutter/material.dart';

/// Horizontal search result row (Stitch v2).
class WidgetsSearchResultRow extends StatelessWidget {
  const WidgetsSearchResultRow({
    required this.title,
    required this.description,
    required this.priceLabel,
    required this.actionLabel,
    required this.imageUrl,
    required this.index,
    required this.onAdd,
    this.onTap,
    this.onFavorite,
    this.isFavorite = false,
    super.key,
  });

  final String title;
  final String description;
  final String priceLabel;
  final String actionLabel;
  final String? imageUrl;
  final int index;
  final VoidCallback onAdd;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final thumb = CoreContentSizes.logoWelcome(context) * 1.05;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
            child: SizedBox.square(
              dimension: thumb,
              child: WidgetsMockFoodImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                fallback: WidgetsFoodCatalogFallback(index: index),
              ),
            ),
          ),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: CoreTypography.titleMedium(
                          context,
                          scheme.onSurface,
                        ).copyWith(fontWeight: FontWeight.w900),
                      ),
                    ),
                    WidgetsIconButton(
                      onPressed: onFavorite ?? () {},
                      icon:
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                      tooltip: title,
                    ),
                  ],
                ),
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: CoreSpacing.sm(context)),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        priceLabel,
                        style: CoreTypography.titleMedium(
                          context,
                          CoreColors.brandBrown,
                        ).copyWith(fontWeight: FontWeight.w900),
                      ),
                    ),
                    WidgetsAppButton(
                      label: actionLabel,
                      onPressed: onAdd,
                      icon: Icons.add,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
