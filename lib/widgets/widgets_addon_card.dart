import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_admin_catalog.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_mock_food_image.dart';
import 'package:flutter/material.dart';

/// Shared addon merchandising / selection card (customer + marketing/admin).
class WidgetsAddonCard extends StatelessWidget {
  const WidgetsAddonCard({
    required this.title,
    required this.priceLabel,
    required this.selected,
    required this.onTap,
    this.imageUrl,
    this.subtitle,
    this.index = 0,
    super.key,
  });

  factory WidgetsAddonCard.fromAddon({
    required ModelMenuAddon addon,
    required String title,
    required String priceLabel,
    required bool selected,
    required VoidCallback onTap,
    int index = 0,
    Key? key,
  }) {
    return WidgetsAddonCard(
      key: key,
      title: title,
      priceLabel: priceLabel,
      selected: selected,
      onTap: onTap,
      imageUrl: addon.imageUrl,
      index: index,
    );
  }

  final String title;
  final String priceLabel;
  final bool selected;
  final VoidCallback onTap;
  final String? imageUrl;
  final String? subtitle;
  final int index;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = selected ? scheme.primary : CoreColors.brandOlive;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      accentColor: selected ? accent : null,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      onTap: onTap,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              CoreSpacing.radiusButtonOf(context),
            ),
            child: SizedBox.square(
              dimension: CoreContentSizes.emptyStateIcon(context) * 0.72,
              child: WidgetsMockFoodImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                fallback: ColoredBox(
                  color: accent.withValues(alpha: 0.12),
                  child: Icon(
                    Icons.extension_outlined,
                    color: accent,
                    size: CoreContentSizes.buttonIcon(context),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                if (subtitle != null && subtitle!.isNotEmpty) ...[
                  SizedBox(height: CoreSpacing.xs(context)),
                  Text(
                    subtitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: CoreTypography.caption(
                      context,
                      scheme.onSurfaceVariant,
                    ),
                  ),
                ],
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  priceLabel,
                  style: CoreTypography.caption(
                    context,
                    accent,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          Icon(
            selected ? Icons.check_circle : Icons.add_circle_outline,
            color: accent,
          ),
        ],
      ),
    );
  }
}
