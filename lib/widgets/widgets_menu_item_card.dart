import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_avatar.dart';
import 'package:flutter/material.dart';

class WidgetsMenuItemCard extends StatelessWidget {
  const WidgetsMenuItemCard({
    required this.item,
    required this.name,
    required this.priceLabel,
    required this.onTap,
    super.key,
  });

  final ModelMenuItem item;
  final String name;
  final String priceLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return WidgetsAppCard(
      onTap: onTap,
      accentColor: scheme.primary,
      child: Row(
        children: [
          WidgetsAvatar(icon: Icons.restaurant, color: scheme.primary),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: CoreTypography.titleMedium(context, scheme.onSurface),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  priceLabel,
                  style: CoreTypography.caption(context, scheme.primary),
                ),
              ],
            ),
          ),
          Icon(Icons.add_circle_outline, color: scheme.primary),
        ],
      ),
    );
  }
}
