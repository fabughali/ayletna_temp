import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:flutter/material.dart';

/// Unified selectable card for payment, address, order type, role, and condition choices.
class WidgetsChoiceCard extends StatelessWidget {
  const WidgetsChoiceCard({
    required this.title,
    required this.selected,
    required this.onTap,
    this.subtitle,
    this.icon,
    this.trailing,
    this.accentColor,
    super.key,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget? trailing;
  final bool selected;
  final VoidCallback onTap;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = accentColor ?? scheme.primary;

    return WidgetsAppCard(
      onTap: onTap,
      accentColor: selected ? accent : null,
      variant:
          selected
              ? WidgetsAppCardVariant.filled
              : WidgetsAppCardVariant.outlined,
      child: Row(
        children: [
          if (icon != null) ...[
            DecoratedBox(
              decoration: BoxDecoration(
                color: accent.withValues(alpha: selected ? 0.18 : 0.10),
                borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
              ),
              child: SizedBox.square(
                dimension: CoreContentSizes.logoCard(context),
                child: Icon(icon, color: accent),
              ),
            ),
            SizedBox(width: CoreSpacing.md(context)),
          ],
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
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: CoreTypography.caption(
                      context,
                      scheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
          trailing ??
              Icon(
                selected ? Icons.check_circle : Icons.radio_button_unchecked,
                color: selected ? accent : scheme.onSurfaceVariant,
              ),
        ],
      ),
    );
  }
}
