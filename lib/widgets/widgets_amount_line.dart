import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:flutter/material.dart';

/// Unified label/value amount row for JOD, deposits, tips, revenue, and refunds.
class WidgetsAmountLine extends StatelessWidget {
  const WidgetsAmountLine({
    required this.label,
    required this.value,
    this.valueColor,
    this.accentColor,
    this.prominent = false,
    super.key,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final Color? accentColor;
  final bool prominent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final effectiveValueColor = valueColor ?? scheme.onSurface;
    final labelStyle =
        prominent
            ? CoreTypography.titleMedium(context, scheme.onSurface)
            : CoreTypography.bodyMedium(context, scheme.onSurfaceVariant);
    final valueStyle =
        prominent
            ? CoreTypography.titleMedium(context, effectiveValueColor)
            : CoreTypography.bodyMedium(context, effectiveValueColor);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: CoreSpacing.xs(context)),
      child: Row(
        children: [
          if (accentColor != null) ...[
            DecoratedBox(
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(
                  CoreContentSizes.orderTypeIndicatorRadius(context),
                ),
              ),
              child: SizedBox(
                width: CoreContentSizes.amountIndicatorWidth(context),
                height: CoreContentSizes.amountIndicatorHeight(context),
              ),
            ),
            SizedBox(width: CoreSpacing.sm(context)),
          ],
          Expanded(child: Text(label, style: labelStyle)),
          Text(value, style: valueStyle.copyWith(fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}
