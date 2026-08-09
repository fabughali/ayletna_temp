import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:flutter/material.dart';

/// Centered elevated form panel (auth, settings, checkout forms).
class WidgetsFormCard extends StatelessWidget {
  const WidgetsFormCard({
    required this.child,
    this.title,
    this.subtitle,
    this.maxWidth,
    super.key,
  });

  final Widget child;
  final String? title;
  final String? subtitle;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWidth ?? CoreContentSizes.authCardMaxWidth(context),
      ),
      child: WidgetsAppCard(
        variant: WidgetsAppCardVariant.elevated,
        padding: EdgeInsets.all(CoreSpacing.xl(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null) ...[
              Text(
                title!,
                textAlign: TextAlign.center,
                style: CoreTypography.headlineLarge(
                  context,
                  scheme.onSurface,
                ).copyWith(fontWeight: FontWeight.w800),
              ),
              if (subtitle != null) ...[
                SizedBox(height: CoreSpacing.sm(context)),
                Text(
                  subtitle!,
                  textAlign: TextAlign.center,
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              ],
              SizedBox(height: CoreSpacing.xl(context)),
            ],
            child,
          ],
        ),
      ),
    );
  }
}
