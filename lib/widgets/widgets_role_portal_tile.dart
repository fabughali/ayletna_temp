import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:flutter/material.dart';

class WidgetsRolePortalTile extends StatelessWidget {
  const WidgetsRolePortalTile({
    required this.title,
    required this.icon,
    required this.accent,
    required this.onTap,
    this.metric,
    super.key,
  });

  final String title;
  final IconData icon;
  final Color accent;
  final VoidCallback onTap;
  final String? metric;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      onTap: onTap,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: SizedBox.square(
              dimension: UtilitySizer.of(context, 40),
              child: Icon(
                icon,
                color: accent,
                size: CoreContentSizes.buttonIcon(context),
              ),
            ),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          if (metric != null) ...[
            const Spacer(),
            SizedBox(height: CoreSpacing.sm(context)),
            DecoratedBox(
              decoration: BoxDecoration(
                color: CoreColors.brandGold.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(CoreContentSizes.pillRadius(context)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: CoreSpacing.sm(context),
                  vertical: CoreSpacing.xs(context),
                ),
                child: Text(
                  metric!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.caption(
                    context,
                    CoreColors.brandBrown,
                  ).copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
