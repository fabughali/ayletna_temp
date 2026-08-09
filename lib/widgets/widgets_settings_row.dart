import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:flutter/material.dart';

/// Settings list row used on account settings (Stitch v2).
class WidgetsSettingsRow extends StatelessWidget {
  const WidgetsSettingsRow({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.trailing,
    this.onTap,
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
        child: Padding(
          padding: EdgeInsets.all(CoreSpacing.lg(context)),
          child: Row(
            children: [
              Icon(icon, color: CoreColors.brandGold, size: CoreContentSizes.buttonIcon(context)),
              SizedBox(width: CoreSpacing.md(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: CoreTypography.titleMedium(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w800),
                    ),
                    Text(
                      subtitle,
                      style: CoreTypography.caption(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
