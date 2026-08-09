import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:flutter/material.dart';

/// Large, high-contrast status chip for kitchen / delivery pass screens.
///
/// [emphasized] uses a filled ink chip (pass-board readable under kitchen light).
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
    final minHeight = UtilitySizer.band(
      context,
      emphasized ? 48 : 40,
      emphasized ? 52 : 44,
      emphasized ? 56 : 48,
    );
    final iconSize = UtilitySizer.band(
      context,
      emphasized ? 22 : 18,
      emphasized ? 24 : 20,
      emphasized ? 26 : 22,
    );
    final onFill = _onFillColor(color);
    final fg = emphasized ? onFill : color;
    final labelStyle = (emphasized
            ? CoreTypography.bodyMedium(context, fg)
            : CoreTypography.caption(context, scheme.onSurface))
        .copyWith(
          fontWeight: FontWeight.w900,
          height: 1.1,
          color: emphasized ? fg : scheme.onSurface,
        );

    return Semantics(
      label: label,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: emphasized ? color : color.withValues(alpha: 0.12),
            borderRadius:
                BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
            border: Border.all(
              color: emphasized ? color : color.withValues(alpha: 0.36),
              width: UtilitySizer.of(context, emphasized ? 2 : 1.2),
            ),
            boxShadow: emphasized
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.28),
                      blurRadius: UtilitySizer.of(context, 10),
                      offset: Offset(0, UtilitySizer.of(context, 3)),
                    ),
                  ]
                : null,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: CoreSpacing.md(context),
              vertical: CoreSpacing.sm(context),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: iconSize, color: fg),
                SizedBox(width: CoreSpacing.sm(context)),
                Flexible(
                  child: Text(
                    label,
                    style: labelStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Readable ink on filled pass chips (kitchen distance readability).
  Color _onFillColor(Color fill) {
    final luminance = fill.computeLuminance();
    if (luminance > 0.55) {
      return CoreColors.textPrimaryLight;
    }
    return CoreColors.surfaceLight;
  }
}
