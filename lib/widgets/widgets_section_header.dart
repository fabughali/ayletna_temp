import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:flutter/material.dart';

/// Section title for grouped lists (admin hub, profile).
class WidgetsSectionHeader extends StatelessWidget {
  const WidgetsSectionHeader({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(
        top: CoreSpacing.md(context),
        bottom: CoreSpacing.sm(context),
      ),
      child: Text(
        title,
        style: CoreTypography.titleMedium(context, scheme.primary),
      ),
    );
  }
}
