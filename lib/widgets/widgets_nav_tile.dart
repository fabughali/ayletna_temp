import 'package:ayletna_restaurant_app/core/core_spacing.dart';
import 'package:ayletna_restaurant_app/core/core_typography.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WidgetsNavTile extends StatelessWidget {
  const WidgetsNavTile({
    required this.title,
    required this.route,
    this.icon = Icons.chevron_right,
    super.key,
  });

  final String title;
  final String route;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return WidgetsAppCard(
      onTap: () => context.push(route),
      accentColor: scheme.primary,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: CoreTypography.bodyMedium(context, scheme.onSurface),
            ),
          ),
          Icon(icon, color: scheme.primary),
        ],
      ),
    );
  }
}

class WidgetsNavSection extends StatelessWidget {
  const WidgetsNavSection({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0) SizedBox(height: CoreSpacing.sm(context)),
          children[i],
        ],
      ],
    );
  }
}
