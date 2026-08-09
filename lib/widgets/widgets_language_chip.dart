import 'package:ayletna_restaurant_app/core/core_spacing.dart';
import 'package:ayletna_restaurant_app/core/core_typography.dart';
import 'package:flutter/material.dart';

/// AR / EN locale toggle chip.
class WidgetsLanguageChip extends StatelessWidget {
  const WidgetsLanguageChip({
    required this.label,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: selected ? scheme.primary : scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
        side: BorderSide(color: selected ? scheme.primary : scheme.outline),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: CoreSpacing.lg(context),
            vertical: CoreSpacing.md(context),
          ),
          child: Text(
            label,
            style: CoreTypography.titleMedium(
              context,
              selected ? scheme.onPrimary : scheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
