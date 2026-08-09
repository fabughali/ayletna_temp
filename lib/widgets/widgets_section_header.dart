import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_bubble.dart';
import 'package:flutter/material.dart';

class WidgetsSectionHeader extends StatelessWidget {
  const WidgetsSectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
    this.subtitle,
    this.icon,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;
  final String? subtitle;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    if (icon != null && subtitle != null) {
      return Row(
        children: [
          WidgetsIconBubble(
            borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
            icon: icon!,
            color: scheme.primary,
          ),
          SizedBox(width: CoreSpacing.sm(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  subtitle!,
                  style: CoreTypography.caption(context, scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      );
    }

    if (actionLabel != null && onAction != null) {
      return Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: CoreTypography.titleMedium(
                context,
                scheme.onSurface,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
          ),
          WidgetsAppButton(
            label: actionLabel!,
            onPressed: onAction,
            variant: WidgetsAppButtonVariant.ghost,
          ),
        ],
      );
    }

    return Text(
      title,
      style: CoreTypography.titleMedium(
        context,
        scheme.onSurface,
      ).copyWith(fontWeight: FontWeight.w900),
    );
  }
}
