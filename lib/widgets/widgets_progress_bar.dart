import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:flutter/material.dart';

/// Unified linear progress bar with optional label row.
class WidgetsProgressBar extends StatelessWidget {
  const WidgetsProgressBar({
    required this.value,
    this.label,
    this.trailing,
    this.color,
    super.key,
  });

  final double value;
  final String? label;
  final String? trailing;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = color ?? scheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null || trailing != null) ...[
          Row(
            children: [
              if (label != null)
                Expanded(
                  child: Text(
                    label!,
                    style: CoreTypography.caption(
                      context,
                      scheme.onSurfaceVariant,
                    ),
                  ),
                ),
              if (trailing != null)
                Text(
                  trailing!,
                  style: CoreTypography.caption(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
            ],
          ),
          SizedBox(height: CoreSpacing.xs(context)),
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
          child: LinearProgressIndicator(
            value: value.clamp(0, 1),
            minHeight: CoreSpacing.sm(context),
            color: accent,
            backgroundColor: scheme.surfaceContainerHighest,
          ),
        ),
      ],
    );
  }
}
