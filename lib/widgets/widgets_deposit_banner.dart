import 'package:ayletna_restaurant_app/core/core_colors.dart';
import 'package:ayletna_restaurant_app/core/core_spacing.dart';
import 'package:ayletna_restaurant_app/core/core_typography.dart';
import 'package:flutter/material.dart';

/// Plated delivery deposit notice.
class WidgetsDepositBanner extends StatelessWidget {
  const WidgetsDepositBanner({
    required this.title,
    required this.body,
    super.key,
  });

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final deposit = CoreColors.semanticDeposit;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      decoration: BoxDecoration(
        color: deposit.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
        border: Border.all(color: deposit.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: deposit),
          SizedBox(width: CoreSpacing.sm(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: CoreTypography.titleMedium(context, deposit),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  body,
                  style: CoreTypography.bodyMedium(
                    context,
                    Theme.of(context).colorScheme.onSurfaceVariant,
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
