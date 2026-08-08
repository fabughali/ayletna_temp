import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:ayletna_restaurant_app/data/models/model_admin_catalog.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

double subscriptionRegularSumJod(
  ModelSubscriptionMeal meal,
  double Function(String menuItemId) priceOf,
) {
  var sum = 0.0;
  for (final day in meal.dayPlans) {
    for (final id in day.menuItemIds) {
      sum += priceOf(id);
    }
  }
  return sum;
}

/// Compact day-coverage grid (filled = has meals, empty = uncovered).
class WidgetsSubscriptionDayMap extends StatelessWidget {
  const WidgetsSubscriptionDayMap({
    super.key,
    required this.meal,
    this.compact = false,
  });

  final ModelSubscriptionMeal meal;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final plans = meal.normalizedDayPlans();
    final columns = meal.billingPeriod == 'weekly' ? 7 : 6;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.marketingSubscriptionCoverage,
          style: CoreTypography.caption(
            context,
            scheme.onSurfaceVariant,
          ).copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: CoreSpacing.xs(context)),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: plans.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            mainAxisSpacing: CoreSpacing.xs(context),
            crossAxisSpacing: CoreSpacing.xs(context),
            childAspectRatio: compact ? 1.1 : 1,
          ),
          itemBuilder: (context, index) {
            final plan = plans[index];
            final covered = plan.menuItemIds.isNotEmpty;
            final count = plan.menuItemIds.length;
            return Tooltip(
              message: l10n.marketingSubscriptionDayMeals(
                plan.dayIndex,
                count,
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color:
                      covered
                          ? CoreColors.semanticSuccess.withValues(alpha: 0.22)
                          : scheme.errorContainer.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(UtilitySizer.of(context, 6)),
                  border: Border.all(
                    color:
                        covered
                            ? CoreColors.semanticSuccess.withValues(alpha: 0.5)
                            : scheme.error.withValues(alpha: 0.35),
                  ),
                ),
                child: Center(
                  child: Text(
                    '${plan.dayIndex}',
                    style: CoreTypography.caption(
                      context,
                      covered
                          ? CoreColors.semanticSuccess
                          : scheme.error,
                    ).copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: UtilitySizer.of(
                        context,
                        compact ? 10 : 11,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        if (meal.hasUncoveredDays) ...[
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            l10n.marketingSubscriptionUncovered(
              meal.periodDays - meal.coveredDayCount,
            ),
            style: CoreTypography.caption(context, scheme.error).copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ],
    );
  }
}
