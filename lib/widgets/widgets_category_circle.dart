import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_catalog_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_mock_food_image.dart';
import 'package:flutter/material.dart';

/// Rectangular category card for customer home explore row (Stitch v2).
class WidgetsCategoryCircle extends StatelessWidget {
  const WidgetsCategoryCircle({
    required this.label,
    required this.onTap,
    this.selected = false,
    this.icon,
    this.imageUrl,
    this.index = 0,
    this.accentColor,
    super.key,
  });

  final String label;
  final VoidCallback onTap;
  final bool selected;
  final IconData? icon;
  final String? imageUrl;
  final int index;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = accentColor ?? scheme.primary;
    final cardSize = CoreContentSizes.logoWelcome(context) * 0.88;

    return SizedBox(
      width: cardSize + UtilitySizer.of(context, 24),
      child: WidgetsAppCard(
        variant: WidgetsAppCardVariant.elevated,
        padding: EdgeInsets.zero,
        onTap: onTap,
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(CoreSpacing.radiusCardOf(context)),
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  decoration: BoxDecoration(
                    color:
                        icon != null
                            ? CoreColors.brandBrown
                            : color.withValues(
                              alpha: selected ? 0.22 : 0.12,
                            ),
                    border: Border(
                      bottom: BorderSide(
                        color:
                            selected
                                ? scheme.primary
                                : (icon != null
                                    ? CoreColors.brandBrown
                                    : color.withValues(alpha: 0.24)),
                        width: selected ? UtilitySizer.of(context, 2) : 1,
                      ),
                    ),
                  ),
                  child:
                      icon != null
                          ? Center(
                              child: Icon(
                                icon,
                                color: CoreColors.brandGold,
                                size: CoreContentSizes.posCategoryIcon(context),
                              ),
                            )
                          : WidgetsMockFoodImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.cover,
                            fallback: WidgetsFoodCatalogFallback(index: index),
                          ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(CoreSpacing.sm(context)),
              child: Text(
                label,
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: CoreTypography.caption(
                  context,
                  selected ? scheme.primary : scheme.onSurface,
                ).copyWith(fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
