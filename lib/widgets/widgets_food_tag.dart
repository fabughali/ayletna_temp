import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:flutter/material.dart';

class WidgetsFoodTag extends StatelessWidget {
  const WidgetsFoodTag({super.key, required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Semantics(
      label: label,
      child: DecoratedBox(
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
          child: Text(
            label,
            style: CoreTypography.caption(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}
