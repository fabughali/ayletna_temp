import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:flutter/material.dart';

enum WidgetsInfoBannerTone { info, success, warning, danger, neutral }

/// Unified success, warning, info, policy, and deposit notice.
class WidgetsInfoBanner extends StatelessWidget {
  const WidgetsInfoBanner({
    required this.message,
    this.title,
    this.icon,
    this.tone = WidgetsInfoBannerTone.info,
    this.action,
    super.key,
  });

  final String? title;
  final String message;
  final IconData? icon;
  final WidgetsInfoBannerTone tone;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = _accent(scheme);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
        border: Border.all(color: accent.withValues(alpha: 0.26)),
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.lg(context)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon ?? _defaultIcon, color: accent),
            SizedBox(width: CoreSpacing.md(context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null) ...[
                    Text(
                      title!,
                      style: CoreTypography.bodyMedium(
                        context,
                        accent,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                  ],
                  Text(
                    message,
                    style: CoreTypography.bodyMedium(context, scheme.onSurface),
                  ),
                  if (action != null) ...[
                    SizedBox(height: CoreSpacing.md(context)),
                    action!,
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _accent(ColorScheme scheme) {
    return switch (tone) {
      WidgetsInfoBannerTone.info => CoreColors.orderTypeDelivery,
      WidgetsInfoBannerTone.success => CoreColors.semanticSuccess,
      WidgetsInfoBannerTone.warning => CoreColors.semanticWarning,
      WidgetsInfoBannerTone.danger => CoreColors.semanticError,
      WidgetsInfoBannerTone.neutral => scheme.onSurfaceVariant,
    };
  }

  IconData get _defaultIcon {
    return switch (tone) {
      WidgetsInfoBannerTone.success => Icons.check_circle_outline,
      WidgetsInfoBannerTone.warning => Icons.warning_amber_outlined,
      WidgetsInfoBannerTone.danger => Icons.error_outline,
      _ => Icons.info_outline,
    };
  }
}
