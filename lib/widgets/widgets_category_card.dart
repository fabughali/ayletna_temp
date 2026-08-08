import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_category.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:flutter/material.dart';

/// Shared category tile — used on customer home, menu, and marketing catalogs.
class WidgetsCategoryCard extends StatelessWidget {
  const WidgetsCategoryCard({
    required this.label,
    required this.iconKey,
    required this.index,
    required this.onTap,
    this.selected = false,
    this.width,
    super.key,
  });

  /// Convenience from [ModelMenuCategory].
  factory WidgetsCategoryCard.fromCategory({
    required ModelMenuCategory category,
    required String label,
    required int index,
    required VoidCallback onTap,
    bool selected = false,
    double? width,
    Key? key,
  }) {
    return WidgetsCategoryCard(
      key: key,
      label: label,
      iconKey: category.iconKey,
      index: index,
      onTap: onTap,
      selected: selected,
      width: width,
    );
  }

  final String label;
  final String iconKey;
  final int index;
  final VoidCallback onTap;
  final bool selected;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = categoryAccentColor(context, index);
    final cardWidth = width ?? CoreContentSizes.logoWelcome(context) * 1.22;

    return SizedBox(
      width: cardWidth,
      child: WidgetsAppCard(
        variant: WidgetsAppCardVariant.food,
        padding: EdgeInsets.all(CoreSpacing.md(context)),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: color.withValues(alpha: selected ? 0.20 : 0.12),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsets.all(CoreSpacing.sm(context)),
                child: Icon(
                  categoryIconForKey(iconKey),
                  color: color,
                  size: CoreContentSizes.buttonIcon(context) * 1.15,
                ),
              ),
            ),
            SizedBox(height: CoreSpacing.md(context)),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: CoreTypography.bodyMedium(
                context,
                selected ? scheme.primary : scheme.onSurface,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }
}

IconData categoryIconForKey(String key) {
  return switch (key) {
    'shawarma' => Icons.fastfood_outlined,
    'skillet' => Icons.egg_alt_outlined,
    'hummus' => Icons.rice_bowl_outlined,
    'drink' => Icons.local_bar_outlined,
    'sandwich' => Icons.lunch_dining_outlined,
    'falafel' => Icons.circle_outlined,
    'pizza' => Icons.local_pizza_outlined,
    'snack' => Icons.fastfood_outlined,
    'manaqeesh' => Icons.bakery_dining_outlined,
    'pastry' => Icons.breakfast_dining_outlined,
    'burger' => Icons.lunch_dining,
    _ => Icons.restaurant_outlined,
  };
}

Color categoryAccentColor(BuildContext context, int index) {
  final scheme = Theme.of(context).colorScheme;
  return switch (index % 4) {
    0 => scheme.primary,
    1 => CoreColors.brandGold,
    2 => CoreColors.orderTypePlated,
    _ => scheme.secondary,
  };
}
