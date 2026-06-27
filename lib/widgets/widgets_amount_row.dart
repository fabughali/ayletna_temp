import 'package:ayletna_restaurant_app/widgets/widgets_amount_line.dart';
import 'package:flutter/material.dart';

class WidgetsAmountRow extends StatelessWidget {
  const WidgetsAmountRow({
    required this.label,
    required this.amount,
    this.accentColor,
    super.key,
  });

  final String label;
  final String amount;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    return WidgetsAmountLine(
      label: label,
      value: amount,
      valueColor: accentColor,
      accentColor: accentColor,
    );
  }
}
