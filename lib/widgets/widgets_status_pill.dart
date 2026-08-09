import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:flutter/material.dart';

enum WidgetsStatusPillVariant { filled, tonal, outlined }

/// Unified status, role, tier, and order-type label.
///
/// Use this for operational state only: order status, staff state, role,
/// loyalty tier, audit state, or service availability. Do not use it for
/// prices, generic counters, decorative customer tags, or every label in a
/// card; use `WidgetsPriceBadge`, plain text, or a local neutral badge instead.
class WidgetsStatusPill extends StatelessWidget {
  const WidgetsStatusPill({
    required this.label,
    this.color,
    this.icon,
    this.variant = WidgetsStatusPillVariant.tonal,
    this.compact = false,
    super.key,
  });

  final String label;
  final Color? color;
  final IconData? icon;
  final WidgetsStatusPillVariant variant;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = color ?? scheme.primary;
    final foreground =
        variant == WidgetsStatusPillVariant.filled ? scheme.onPrimary : accent;

    return Semantics(
      label: label,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _background(scheme, accent),
          borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
          border:
              variant == WidgetsStatusPillVariant.outlined
                  ? Border.all(color: accent)
                  : null,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
                compact ? CoreSpacing.sm(context) : CoreSpacing.md(context),
            vertical:
                compact ? CoreSpacing.xs(context) : CoreSpacing.sm(context),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: CoreContentSizes.orderTypeIcon(context),
                  color: foreground,
                ),
                SizedBox(width: CoreSpacing.xs(context)),
              ],
              Text(
                label,
                style: CoreTypography.caption(context, foreground).copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: compact ? 0 : 0.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _background(ColorScheme scheme, Color accent) {
    return switch (variant) {
      WidgetsStatusPillVariant.filled => accent,
      WidgetsStatusPillVariant.tonal => accent.withValues(alpha: 0.14),
      WidgetsStatusPillVariant.outlined => scheme.surface,
    };
  }
}
