import 'package:ayletna_restaurant_app/core/core_spacing.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_filter_chip.dart';
import 'package:flutter/material.dart';

/// Tip presets 1 / 2 / 5 JOD + custom (PRD §12).
class WidgetsTipSelector extends StatelessWidget {
  const WidgetsTipSelector({
    required this.presets,
    required this.selectedIndex,
    required this.onPresetSelected,
    required this.customLabel,
    required this.onCustomTap,
    super.key,
  });

  final List<String> presets;
  final int? selectedIndex;
  final ValueChanged<int> onPresetSelected;
  final String customLabel;
  final VoidCallback onCustomTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: CoreSpacing.sm(context),
      runSpacing: CoreSpacing.sm(context),
      children: [
        for (var i = 0; i < presets.length; i++)
          WidgetsFilterChip(
            label: presets[i],
            selected: selectedIndex == i,
            onSelected: (_) => onPresetSelected(i),
          ),
        WidgetsFilterChip(
          label: customLabel,
          selected: selectedIndex == null,
          onSelected: (_) => onCustomTap(),
          icon: Icons.edit_outlined,
        ),
      ],
    );
  }
}
