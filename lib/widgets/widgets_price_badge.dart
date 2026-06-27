import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:flutter/material.dart';

/// Food-first price treatment, separate from operational status pills.
class WidgetsPriceBadge extends StatelessWidget {
  const WidgetsPriceBadge({
    required this.priceLabel,
    this.compact = false,
    super.key,
  });

  final String priceLabel;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: CoreColors.brandGold.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
        border: Border.all(color: CoreColors.brandGold.withValues(alpha: 0.28)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              compact ? CoreSpacing.sm(context) : CoreSpacing.md(context),
          vertical: compact ? CoreSpacing.xs(context) : CoreSpacing.sm(context),
        ),
        child: Text(
          priceLabel,
          style: CoreTypography.titleMedium(
            context,
            scheme.primary,
          ).copyWith(fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
