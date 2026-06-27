import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:flutter/material.dart';

/// Unified page header for screen title, subtitle, eyebrow, and trailing action.
class WidgetsPageHeader extends StatelessWidget {
  const WidgetsPageHeader({
    required this.title,
    this.subtitle,
    this.eyebrow,
    this.trailing,
    this.centered = false,
    super.key,
  });

  final String title;
  final String? subtitle;
  final String? eyebrow;
  final Widget? trailing;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final alignment =
        centered ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = centered ? TextAlign.center : TextAlign.start;

    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: CoreSpacing.md(context),
        bottom: CoreSpacing.lg(context),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: alignment,
              children: [
                if (eyebrow != null) ...[
                  Text(
                    eyebrow!.toUpperCase(),
                    textAlign: textAlign,
                    style: CoreTypography.caption(
                      context,
                      scheme.primary,
                    ).copyWith(letterSpacing: 1.2, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: CoreSpacing.xs(context)),
                ],
                Text(
                  title,
                  textAlign: textAlign,
                  style: CoreTypography.headlineSmall(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: CoreSpacing.xs(context)),
                  Text(
                    subtitle!,
                    textAlign: textAlign,
                    style: CoreTypography.bodyMedium(
                      context,
                      scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[
            SizedBox(width: CoreSpacing.md(context)),
            trailing!,
          ],
        ],
      ),
    );
  }
}
