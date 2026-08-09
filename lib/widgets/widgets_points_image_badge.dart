import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// Compact points badge for stacking on catalog/promo images.
class WidgetsPointsImageBadge extends StatelessWidget {
  const WidgetsPointsImageBadge({
    super.key,
    required this.points,
  });

  final int points;

  @override
  Widget build(BuildContext context) {
    if (points <= 0) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context)!;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: CoreColors.brandOrange.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: CoreSpacing.sm(context),
          vertical: CoreSpacing.xs(context),
        ),
        child: Text(
          l10n.loyaltyPointsShort('$points'),
          style: CoreTypography.caption(
            context,
            Colors.white,
          ).copyWith(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
