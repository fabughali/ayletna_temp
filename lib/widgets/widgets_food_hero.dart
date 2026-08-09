import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_media_panel.dart';
import 'package:flutter/material.dart';

/// Warm storefront hero for featured dishes, chef picks, and meal occasions.
class WidgetsFoodHero extends StatelessWidget {
  const WidgetsFoodHero({
    required this.title,
    required this.subtitle,
    required this.media,
    required this.primaryLabel,
    required this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
    super.key,
  });

  final String title;
  final String subtitle;
  final Widget media;
  final String primaryLabel;
  final VoidCallback onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Color.alphaBlend(
          CoreColors.brandGold.withValues(alpha: 0.08),
          scheme.surface,
        ),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
        border: Border.all(color: CoreColors.brandGold.withValues(alpha: 0.24)),
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.lg(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WidgetsFoodMediaPanel(
              height: CoreContentSizes.heroImageHeight(context),
              child: media,
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            Text(
              title,
              style: CoreTypography.headlineLarge(
                context,
                CoreColors.brandBrown,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            Text(
              subtitle,
              style: CoreTypography.bodyMedium(
                context,
                scheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            Wrap(
              spacing: CoreSpacing.sm(context),
              runSpacing: CoreSpacing.sm(context),
              children: [
                WidgetsAppButton(
                  label: primaryLabel,
                  onPressed: onPrimary,
                  icon: Icons.restaurant_menu_outlined,
                ),
                if (secondaryLabel != null && onSecondary != null)
                  WidgetsAppButton(
                    label: secondaryLabel!,
                    onPressed: onSecondary,
                    icon: Icons.local_dining_outlined,
                    variant: WidgetsAppButtonVariant.secondary,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
