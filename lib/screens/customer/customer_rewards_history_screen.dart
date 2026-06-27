import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/rewards_admin_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

/// Customer loyalty points transaction history.
class CustomerRewardsHistoryScreen extends ConsumerWidget {
  const CustomerRewardsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final balance = ref.watch(loyaltyPointsProvider).balance;
    final transactions = ref.watch(loyaltyTransactionsProvider);

    return WidgetsScaffoldPage(
      title: l10n.screenRewardsHistory,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(loyaltyPointsProvider);
        },
        child: ListView(
          children: [
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsAppCard(
              variant: WidgetsAppCardVariant.food,
              padding: EdgeInsets.all(CoreSpacing.lg(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.profilePointsHistory,
                    style: CoreTypography.headlineSmall(
                      context,
                      scheme.onSurface,
                    ).copyWith(fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: CoreSpacing.sm(context)),
                  Text(
                    l10n.profilePointsHistorySubtitle,
                    style: CoreTypography.bodyMedium(
                      context,
                      scheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: CoreSpacing.md(context)),
                  Text(
                    '$balance ${l10n.loyaltySavorPoints}',
                    style: CoreTypography.titleMedium(
                      context,
                      scheme.primary,
                    ).copyWith(fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            if (transactions.isEmpty)
              WidgetsAppCard(
                padding: EdgeInsets.all(CoreSpacing.lg(context)),
                child: Text(
                  isAr
                      ? 'لا توجد حركات نقاط بعد. اطلب أو استبدل مكافأة.'
                      : 'No point activity yet. Order or redeem a reward.',
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              )
            else
              for (final tx in transactions) ...[
                WidgetsAppCard(
                  variant: WidgetsAppCardVariant.form,
                  padding: EdgeInsets.all(CoreSpacing.lg(context)),
                  leading: Icon(
                    tx.pointsDelta >= 0
                        ? Icons.add_circle_outline
                        : Icons.remove_circle_outline,
                    color:
                        tx.pointsDelta >= 0
                            ? CoreColors.semanticSuccess
                            : CoreColors.semanticError,
                  ),
                  title: isAr ? tx.titleAr : tx.titleEn,
                  child: Text(
                    '${tx.pointsDelta >= 0 ? '+' : ''}${tx.pointsDelta} · ${DateFormat.yMMMd().add_jm().format(tx.occurredAt)}',
                    style: CoreTypography.bodyMedium(
                      context,
                      scheme.onSurfaceVariant,
                    ),
                  ),
                ),
                SizedBox(height: CoreSpacing.md(context)),
              ],
            SizedBox(height: CoreSpacing.xxl(context)),
          ],
        ),
      ),
    );
  }
}
