import 'package:ayletna_restaurant_app/core/core_color_scheme.dart';
import 'package:ayletna_restaurant_app/core/core_spacing.dart';
import 'package:ayletna_restaurant_app/core/core_typography.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_avatar.dart';
import 'package:flutter/material.dart';

/// Approved role session picker (PRD §3.2).
class WidgetsRoleCard extends StatelessWidget {
  const WidgetsRoleCard({
    required this.role,
    required this.title,
    required this.subtitle,
    required this.onTap,
    super.key,
  });

  final AppRole role;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent =
        CoreColorScheme.build(
          role: role,
          brightness: scheme.brightness,
        ).primary;
    return WidgetsAppCard(
      onTap: onTap,
      accentColor: accent,
      child: Row(
        children: [
          WidgetsAvatar(icon: Icons.badge_outlined, color: accent),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: CoreTypography.titleMedium(context, scheme.onSurface),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
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
          Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
        ],
      ),
    );
  }
}
