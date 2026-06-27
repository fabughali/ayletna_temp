import 'package:ayletna_restaurant_app/core/core_color_scheme.dart';
import 'package:ayletna_restaurant_app/core/core_spacing.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_order_type_chip.dart';
import 'package:flutter/material.dart';

class WidgetsOrderTypeSelector extends StatelessWidget {
  const WidgetsOrderTypeSelector({
    required this.labels,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final Map<OrderType, String> labels;
  final OrderType selected;
  final ValueChanged<OrderType> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: CoreSpacing.sm(context),
      runSpacing: CoreSpacing.sm(context),
      children:
          OrderType.values.map((type) {
            return WidgetsOrderTypeChip(
              type: type,
              label: labels[type] ?? '',
              selected: selected == type,
              onTap: () => onSelected(type),
            );
          }).toList(),
    );
  }
}
