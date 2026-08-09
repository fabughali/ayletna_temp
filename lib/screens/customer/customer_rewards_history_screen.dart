import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/providers/rewards_admin_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(loyaltyPointsProvider);
        },
        child: ListView(
          children: [
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsPageHeader(
              title: l10n.profilePointsHistory,
              subtitle: l10n.profilePointsHistorySubtitle,
              eyebrow: l10n.screenRewardsHistory,
            ),
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsAppCard(
              variant: WidgetsAppCardVariant.food,
              padding: EdgeInsets.all(CoreSpacing.lg(context)),
              child: Text(
                '$balance ${l10n.loyaltySavorPoints}',
                style: CoreTypography.titleMedium(
                  context,
                  scheme.primary,
                ).copyWith(fontWeight: FontWeight.w900),
              ),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            if (transactions.isEmpty)
              WidgetsAppCard(
                padding: EdgeInsets.all(CoreSpacing.lg(context)),
                child: Text(
                  l10n.rewardsHistoryEmpty,
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
