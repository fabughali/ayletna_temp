import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:flutter/material.dart';

/// Unified filter chip for tabs and segmented list filters.
class WidgetsFilterChip extends StatelessWidget {
  const WidgetsFilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
    this.icon,
    super.key,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final selectedColor = CoreColors.brandOlive;

    return ChoiceChip(
      selected: selected,
      onSelected: onSelected,
      avatar:
          icon == null
              ? null
              : Icon(
                icon,
                size: CoreContentSizes.orderTypeIcon(context),
                color: selected ? selectedColor : scheme.primary,
              ),
      label: Text(label),
      labelStyle: CoreTypography.caption(
        context,
        selected ? selectedColor : scheme.onSurface,
      ).copyWith(fontWeight: FontWeight.w800),
      selectedColor: selectedColor.withValues(alpha: 0.12),
      backgroundColor: scheme.surface,
      side: BorderSide(
        color:
            selected
                ? selectedColor.withValues(alpha: 0.42)
                : scheme.outlineVariant,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
      ),
    );
  }
}
