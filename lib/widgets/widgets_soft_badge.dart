import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:flutter/material.dart';

class WidgetsSoftBadge extends StatelessWidget {
  const WidgetsSoftBadge({
    required this.label,
    required this.color,
    this.icon,
    this.foreground,
    super.key,
  });

  final String label;
  final Color color;
  final IconData? icon;
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    final badge = icon != null ? _iconBadge(context) : _textBadge(context);
    return Semantics(label: label, child: badge);
  }

  Widget _iconBadge(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
        border: Border.all(color: color.withValues(alpha: 0.24)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: CoreSpacing.sm(context),
          vertical: CoreSpacing.xs(context),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: CoreContentSizes.orderTypeIcon(context),
              color: color,
            ),
            SizedBox(width: CoreSpacing.xs(context)),
            Text(
              label,
              style: CoreTypography.caption(context, color).copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textBadge(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: CoreSpacing.sm(context),
        vertical: CoreSpacing.xs(context),
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: foreground == null ? 0.12 : 1),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
      ),
      child: Text(
        label,
        style: CoreTypography.caption(context, foreground ?? color).copyWith(
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
