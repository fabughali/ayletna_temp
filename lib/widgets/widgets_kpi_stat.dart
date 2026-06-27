import 'package:ayletna_restaurant_app/widgets/widgets_metric_card.dart';
import 'package:flutter/material.dart';

/// Admin dashboard KPI tile (PRD financial semantics).
class WidgetsKpiStat extends StatelessWidget {
  const WidgetsKpiStat({
    required this.label,
    required this.value,
    required this.icon,
    this.accentColor,
    super.key,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    return WidgetsMetricCard(
      label: label,
      value: value,
      icon: icon,
      accentColor: accentColor,
      compact: true,
    );
  }
}
