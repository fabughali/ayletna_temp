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
    this.strong = false,
    this.compact = false,
    this.valueOverride,
    super.key,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final Color? accentColor;
  final bool prominent;
  final bool strong;
  final bool compact;
  final String? valueOverride;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final displayValue = valueOverride ?? value;
    final effectiveColor = valueColor ?? scheme.onSurface;

    final labelStyle = prominent
        ? CoreTypography.titleMedium(context, scheme.onSurface)
        : CoreTypography.bodyMedium(context, scheme.onSurfaceVariant);

    final TextStyle valueStyle = prominent || strong
        ? CoreTypography.titleMedium(context, effectiveColor)
        : CoreTypography.bodyMedium(context, effectiveColor);

    return Padding(
      padding: EdgeInsets.only(
        bottom: compact ? CoreSpacing.xs(context) : CoreSpacing.sm(context),
      ),
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
          Text(
            displayValue,
            style: valueStyle.copyWith(
              fontWeight: strong || prominent ? FontWeight.w900 : FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
