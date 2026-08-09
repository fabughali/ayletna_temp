import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_catalog_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_mock_food_image.dart';
import 'package:flutter/material.dart';

/// Full-width featured offer row on customer home (Stitch v2).
class WidgetsOfferListCard extends StatelessWidget {
  const WidgetsOfferListCard({
    required this.title,
    required this.description,
    required this.priceLabel,
    required this.imageUrl,
    required this.actionLabel,
    required this.onAction,
    required this.index,
    this.tagLabel,
    this.onTap,
    this.onFavorite,
    super.key,
  });

  final String title;
  final String description;
  final String priceLabel;
  final String? imageUrl;
  final String actionLabel;
  final VoidCallback onAction;
  final int index;
  final String? tagLabel;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final imageHeight = CoreContentSizes.categoryHeroHeight(context) * 0.55;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: imageHeight,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(CoreSpacing.radiusCardOf(context)),
                  ),
                  child: WidgetsMockFoodImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    fallback: WidgetsFoodCatalogFallback(index: index),
                  ),
                ),
                Positioned(
                  top: CoreSpacing.sm(context),
                  right: CoreSpacing.sm(context),
                  child: WidgetsIconButton(
                    onPressed: onFavorite ?? () {},
                    icon: Icons.favorite_border,
                    tooltip: title,
                    variant: WidgetsIconButtonVariant.filled,
                    buttonSize: CoreContentSizes.compactIconButton(context),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(CoreSpacing.lg(context)),
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
                    SizedBox(width: CoreSpacing.sm(context)),
                    Text(
                      priceLabel,
                      style: CoreTypography.titleMedium(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
                if (tagLabel != null) ...[
                  SizedBox(height: CoreSpacing.sm(context)),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: CoreColors.brandGold.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(UtilitySizer.of(context, 6)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: CoreSpacing.sm(context),
                        vertical: CoreSpacing.xs(context),
                      ),
                      child: Text(
                        tagLabel!,
                        style: CoreTypography.caption(
                          context,
                          CoreColors.brandBrown,
                        ).copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ],
                SizedBox(height: CoreSpacing.md(context)),
                WidgetsAppButton(
                  label: actionLabel,
                  onPressed: onAction,
                  icon: Icons.add,
                  variant: WidgetsAppButtonVariant.outline,
                  fullWidth: true,
                  iconAlignment: IconAlignment.start,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
