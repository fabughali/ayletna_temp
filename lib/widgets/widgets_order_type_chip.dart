import 'package:ayletna_restaurant_app/core/core_content_sizes.dart';
import 'package:ayletna_restaurant_app/core/core_color_scheme.dart';
import 'package:ayletna_restaurant_app/core/core_spacing.dart';
import 'package:ayletna_restaurant_app/core/core_typography.dart';
import 'package:flutter/material.dart';

/// Order type: icon + label + color strip (PRD §2.5).
class WidgetsOrderTypeChip extends StatelessWidget {
  const WidgetsOrderTypeChip({
    required this.type,
    required this.label,
    this.selected = false,
    this.onTap,
    super.key,
  });

  final OrderType type;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = type.color;
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: selected ? color.withValues(alpha: 0.12) : scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
        side: BorderSide(
          color: selected ? color : scheme.outline,
          width: selected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: CoreSpacing.md(context),
            vertical: CoreSpacing.sm(context),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: CoreContentSizes.orderTypeIndicatorWidth(context),
                height: CoreContentSizes.orderTypeIndicatorHeight(context),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(
                    CoreContentSizes.orderTypeIndicatorRadius(context),
                  ),
                ),
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Icon(
                _iconFor(type),
                size: CoreContentSizes.orderTypeIcon(context),
                color: color,
              ),
              SizedBox(width: CoreSpacing.xs(context)),
              Text(
                label,
                style: CoreTypography.caption(context, scheme.onSurface),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static IconData _iconFor(OrderType type) => switch (type) {
    OrderType.dineIn => Icons.table_restaurant_outlined,
    OrderType.takeaway => Icons.shopping_bag_outlined,
    OrderType.delivery => Icons.delivery_dining_outlined,
    OrderType.platedDelivery => Icons.dinner_dining_outlined,
  };
}
