import 'package:ayletna_restaurant_app/core/core_typography.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:flutter/material.dart';

class WidgetsPlateCounter extends StatelessWidget {
  const WidgetsPlateCounter({
    required this.label,
    required this.count,
    required this.onDecrement,
    required this.onIncrement,
    super.key,
  });

  final String label;
  final int count;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: CoreTypography.bodyMedium(context, scheme.onSurface),
          ),
        ),
        WidgetsIconButton(
          onPressed: onDecrement,
          icon: Icons.remove,
          tooltip: '-',
        ),
        Text(
          '$count',
          style: CoreTypography.titleMedium(context, scheme.onSurface),
        ),
        WidgetsIconButton(
          onPressed: onIncrement,
          icon: Icons.add,
          tooltip: '+',
        ),
      ],
    );
  }
}
