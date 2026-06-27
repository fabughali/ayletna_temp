import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_amount_line.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:flutter/material.dart';

class WidgetsFinancialSummaryLine {
  const WidgetsFinancialSummaryLine({
    required this.label,
    required this.value,
    this.valueColor,
    this.accentColor,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final Color? accentColor;
}

/// Unified checkout, refund, deposit, tips, revenue, and wallet summary block.
class WidgetsFinancialSummary extends StatelessWidget {
  const WidgetsFinancialSummary({
    required this.title,
    required this.lines,
    required this.totalLabel,
    required this.totalValue,
    this.subtitle,
    this.totalColor,
    this.accentColor,
    this.footer,
    super.key,
  });

  final String title;
  final String? subtitle;
  final List<WidgetsFinancialSummaryLine> lines;
  final String totalLabel;
  final String totalValue;
  final Color? totalColor;
  final Color? accentColor;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final totalAccent = totalColor ?? accentColor ?? scheme.primary;

    return WidgetsAppCard(
      title: title,
      subtitle: subtitle,
      accentColor: accentColor,
      child: Column(
        children: [
          for (final line in lines)
            WidgetsAmountLine(
              label: line.label,
              value: line.value,
              valueColor: line.valueColor,
              accentColor: line.accentColor,
            ),
          Divider(
            height: CoreSpacing.xl(context),
            color: scheme.outlineVariant,
          ),
          WidgetsAmountLine(
            label: totalLabel,
            value: totalValue,
            valueColor: totalAccent,
            prominent: true,
          ),
          if (footer != null) ...[
            SizedBox(height: CoreSpacing.lg(context)),
            footer!,
          ],
        ],
      ),
    );
  }
}
