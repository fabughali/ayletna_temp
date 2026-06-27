import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:flutter/material.dart';

class WidgetsEmptyState extends StatelessWidget {
  const WidgetsEmptyState({
    required this.message,
    this.icon = Icons.inbox_outlined,
    super.key,
  });

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.xl(context)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: CoreContentSizes.emptyStateIcon(context),
              color: scheme.onSurfaceVariant,
            ),
            SizedBox(height: CoreSpacing.md(context)),
            Text(
              message,
              textAlign: TextAlign.center,
              style: CoreTypography.bodyMedium(
                context,
                scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
