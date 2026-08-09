import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:flutter/material.dart';

/// Featured dish hero with image overlay (Stitch v2 customer home).
class WidgetsStorefrontHero extends StatelessWidget {
  const WidgetsStorefrontHero({
    required this.title,
    required this.subtitle,
    required this.media,
    required this.badgeLabel,
    required this.actionLabel,
    required this.onAction,
    super.key,
  });

  final String title;
  final String subtitle;
  final Widget media;
  final String badgeLabel;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final height = CoreContentSizes.heroImageHeight(context) * 1.05;

    return ClipRRect(
      borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
      child: SizedBox(
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            media,
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    CoreColors.brandBrown.withValues(alpha: 0.08),
                    CoreColors.brandBrown.withValues(alpha: 0.72),
                  ],
                  stops: const [0.35, 0.62, 1.0],
                ),
              ),
            ),
            Positioned(
              left: CoreSpacing.lg(context),
              right: CoreSpacing.lg(context),
              bottom: CoreSpacing.lg(context),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: CoreColors.brandBrown.withValues(
                              alpha: 0.88,
                            ),
                            borderRadius: BorderRadius.circular(UtilitySizer.of(context, 6)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: CoreSpacing.sm(context),
                              vertical: CoreSpacing.xs(context),
                            ),
                            child: Text(
                              badgeLabel,
                              style: CoreTypography.caption(
                                context,
                                CoreColors.brandGold,
                              ).copyWith(fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                        SizedBox(height: CoreSpacing.sm(context)),
                        Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: CoreTypography.headlineSmall(
                            context,
                            Colors.white,
                          ).copyWith(fontWeight: FontWeight.w900),
                        ),
                        SizedBox(height: CoreSpacing.xs(context)),
                        Text(
                          subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: CoreTypography.bodyMedium(
                            context,
                            Colors.white.withValues(alpha: 0.92),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: CoreSpacing.md(context)),
                  WidgetsAppButton(
                    label: actionLabel,
                    onPressed: onAction,
                    variant: WidgetsAppButtonVariant.secondary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
