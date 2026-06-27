import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:flutter/material.dart';

/// Large, high-contrast status chip for kitchen / delivery pass screens.
class WidgetsOpsGlanceChip extends StatelessWidget {
  const WidgetsOpsGlanceChip({
    required this.label,
    required this.color,
    required this.icon,
    this.emphasized = false,
    super.key,
  });

  final String label;
  final Color color;
  final IconData icon;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final minHeight = emphasized ? 44.0 : 36.0;
    final fontSize = emphasized ? 14.0 : 12.5;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.withValues(alpha: emphasized ? 0.18 : 0.12),
          borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
          border: Border.all(
            color: color.withValues(alpha: emphasized ? 0.45 : 0.28),
            width: emphasized ? 1.6 : 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: CoreSpacing.md(context),
            vertical: CoreSpacing.sm(context),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: emphasized ? 20 : 16, color: color),
              SizedBox(width: CoreSpacing.sm(context)),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    color: emphasized ? color : scheme.onSurface,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
