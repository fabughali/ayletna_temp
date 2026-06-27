import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:flutter/material.dart';

/// Unified KPI, balance, count, revenue, stock, and shift metric card.
class WidgetsMetricCard extends StatelessWidget {
  const WidgetsMetricCard({
    required this.label,
    required this.value,
    this.subtitle,
    this.icon,
    this.accentColor,
    this.compact = false,
    super.key,
  });

  final String label;
  final String value;
  final String? subtitle;
  final IconData? icon;
  final Color? accentColor;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = accentColor ?? scheme.primary;

    return WidgetsAppCard(
      accentColor: compact ? null : accent,
      padding: EdgeInsets.all(
        compact ? CoreSpacing.md(context) : CoreSpacing.lg(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, color: accent, size: CoreContentSizes.kpiIcon(context)),
            SizedBox(height: CoreSpacing.sm(context)),
          ],
          Text(
            value,
            style: CoreTypography.headlineSmall(
              context,
              accent,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            label,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
          if (subtitle != null) ...[
            SizedBox(height: CoreSpacing.xs(context)),
            Text(
              subtitle!,
              style: CoreTypography.caption(context, scheme.onSurfaceVariant),
            ),
          ],
        ],
      ),
    );
  }
}
