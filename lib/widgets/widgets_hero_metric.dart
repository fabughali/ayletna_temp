import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:flutter/material.dart';

class WidgetsHeroMetric extends StatelessWidget {
  const WidgetsHeroMetric({
    required this.label,
    required this.value,
    required this.icon,
    super.key,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: UtilitySizer.of(context, 184),
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      decoration: BoxDecoration(
        color: CoreColors.surfaceLight.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
        border: Border.all(
          color: CoreColors.surfaceLight.withValues(alpha: 0.30),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: CoreColors.surfaceLight),
          SizedBox(width: CoreSpacing.sm(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.titleMedium(
                    context,
                    CoreColors.surfaceLight,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.caption(
                    context,
                    CoreColors.surfaceLight.withValues(alpha: 0.84),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
