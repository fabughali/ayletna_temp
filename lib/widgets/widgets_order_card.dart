import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_order_summary.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_order_type_chip.dart';
import 'package:flutter/material.dart';

class WidgetsOrderCard extends StatelessWidget {
  const WidgetsOrderCard({
    required this.order,
    required this.typeLabel,
    required this.statusLabel,
    required this.totalLabel,
    required this.onTap,
    super.key,
  });

  final ModelOrderSummary order;
  final String typeLabel;
  final String statusLabel;
  final String totalLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return WidgetsAppCard(
      onTap: onTap,
      accentColor: scheme.primary,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              WidgetsOrderTypeChip(
                type: order.orderType,
                label: typeLabel,
                selected: true,
              ),
              const Spacer(),
              if (order.isPlated)
                Icon(Icons.dinner_dining, color: scheme.tertiary),
            ],
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            '#${order.id} · ${order.customerLabel}',
            style: CoreTypography.bodyMedium(context, scheme.onSurface),
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            '$statusLabel · $totalLabel',
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
