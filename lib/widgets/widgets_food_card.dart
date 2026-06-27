import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_media_panel.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_price_badge.dart';
import 'package:flutter/material.dart';

/// Customer-facing food card for menu browsing and recommendations.
class WidgetsFoodCard extends StatelessWidget {
  const WidgetsFoodCard({
    required this.title,
    required this.description,
    required this.priceLabel,
    required this.media,
    required this.actionLabel,
    required this.onAction,
    required this.loyaltyLabel,
    this.badges = const [],
    this.badgeLabel,
    this.ratingLabel = '4.8',
    this.onTap,
    this.fillHeight = false,
    super.key,
  });

  final String title;
  final String description;
  final String priceLabel;
  final Widget media;
  final String actionLabel;
  final VoidCallback onAction;
  final List<Widget> badges;
  final String? badgeLabel;
  final String ratingLabel;
  final String loyaltyLabel;
  final VoidCallback? onTap;
  final bool fillHeight;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding:
          fillHeight
              ? EdgeInsets.zero
              : EdgeInsets.all(CoreSpacing.md(context)),
      onTap: onTap,
      child:
          fillHeight
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 13,
                    child: WidgetsFoodMediaPanel(
                      expand: true,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(CoreSpacing.radiusCard),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          media,
                          _MediaTags(
                            priceLabel: priceLabel,
                            badgeLabel: badgeLabel,
                            ratingLabel: ratingLabel,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: CoreSpacing.sm(context)),
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        CoreSpacing.md(context),
                        CoreSpacing.sm(context),
                        CoreSpacing.md(context),
                        CoreSpacing.md(context),
                      ),
                      child: _foodCardDetails(scheme: scheme),
                    ),
                  ),
                ],
              )
              : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  WidgetsFoodMediaPanel(child: media),
                  SizedBox(height: CoreSpacing.md(context)),
                  _foodCardDetails(scheme: scheme),
                ],
              ),
    );
  }

  Widget _foodCardDetails({required ColorScheme scheme}) {
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        textDirection: TextDirection.ltr,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _LoyaltyPill(label: loyaltyLabel),
                          SizedBox(width: CoreSpacing.sm(context)),
                          Expanded(
                            child: Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: CoreTypography.titleMedium(
                                context,
                                scheme.onSurface,
                              ).copyWith(fontWeight: FontWeight.w900),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: CoreSpacing.xs(context)),
                      Text(
                        description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: CoreTypography.caption(
                          context,
                          scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: CoreSpacing.sm(context)),
                if (!fillHeight)
                  WidgetsPriceBadge(priceLabel: priceLabel, compact: true),
              ],
            ),
            if (!fillHeight && badges.isNotEmpty) ...[
              SizedBox(height: CoreSpacing.xs(context)),
              Wrap(
                spacing: CoreSpacing.xs(context),
                runSpacing: CoreSpacing.xs(context),
                children: badges,
              ),
            ],
            if (fillHeight) const Spacer(),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppButton(
              label: actionLabel,
              onPressed: onAction,
              icon: Icons.add_shopping_cart_outlined,
              fullWidth: true,
            ),
          ],
        );
      },
    );
  }
}

class _MediaTags extends StatelessWidget {
  const _MediaTags({
    required this.priceLabel,
    required this.badgeLabel,
    required this.ratingLabel,
  });

  final String priceLabel;
  final String? badgeLabel;
  final String ratingLabel;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final inset = CoreSpacing.sm(context);
        final tagMaxWidth = (constraints.maxWidth * 0.52).clamp(84.0, 170.0);

        return Stack(
          children: [
            Positioned(
              top: inset,
              left: inset,
              child: _MediaTag(
                label: ratingLabel,
                icon: Icons.star_rounded,
                emphasized: true,
                maxWidth: tagMaxWidth,
              ),
            ),
            if (badgeLabel != null)
              Positioned(
                top: inset,
                right: inset,
                child: _MediaTag(label: badgeLabel!, maxWidth: tagMaxWidth),
              ),
            Positioned(
              bottom: inset,
              left: inset,
              child: _MediaTag(
                label: priceLabel,
                emphasized: true,
                maxWidth: tagMaxWidth,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _LoyaltyPill extends StatelessWidget {
  const _LoyaltyPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: CoreColors.brandOlive.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
        border: Border.all(
          color: CoreColors.brandOlive.withValues(alpha: 0.28),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: CoreSpacing.xs(context),
          vertical: CoreSpacing.xs(context) * 0.55,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.stars_rounded, size: 15, color: CoreColors.brandOlive),
            SizedBox(width: CoreSpacing.xs(context) * 0.7),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: CoreTypography.caption(
                context,
                scheme.primary,
              ).copyWith(fontWeight: FontWeight.w900, height: 1.0),
            ),
          ],
        ),
      ),
    );
  }
}

class _MediaTag extends StatelessWidget {
  const _MediaTag({
    required this.label,
    required this.maxWidth,
    this.icon,
    this.emphasized = false,
  });

  final String label;
  final double maxWidth;
  final IconData? icon;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final foreground = emphasized ? scheme.primary : scheme.onSurface;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
        border: Border.all(
          color:
              emphasized
                  ? CoreColors.brandGold.withValues(alpha: 0.78)
                  : scheme.outlineVariant,
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth, minHeight: 30),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, color: CoreColors.brandGold, size: 15),
                SizedBox(width: CoreSpacing.xs(context)),
              ],
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.caption(
                    context,
                    foreground,
                  ).copyWith(fontWeight: FontWeight.w900, height: 1.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
