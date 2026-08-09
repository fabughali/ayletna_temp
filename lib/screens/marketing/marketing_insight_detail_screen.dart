import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/marketing_dashboard_providers.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_filter_chip.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum MarketingInsightKind {
  visitors,
  purchases,
  topSellers,
  ratings,
  social,
  offers,
  campaigns,
}

class MarketingInsightDetailScreen extends ConsumerStatefulWidget {
  const MarketingInsightDetailScreen({required this.kind, super.key});

  final MarketingInsightKind kind;

  @override
  ConsumerState<MarketingInsightDetailScreen> createState() =>
      _MarketingInsightDetailScreenState();
}

class _MarketingInsightDetailScreenState
    extends ConsumerState<MarketingInsightDetailScreen> {
  String _filter = 'all';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final metrics = ref.watch(marketingDashboardMetricsProvider);

    return WidgetsScaffoldPage(
      title: _title(l10n),
      child: ListView(
        padding: EdgeInsets.all(CoreSpacing.md(context)),
        children: [
          if (widget.kind == MarketingInsightKind.ratings) ...[
            Wrap(
              spacing: CoreSpacing.sm(context),
              children: [
                WidgetsFilterChip(
                  label: l10n.marketingInsightFilterAll,
                  selected: _filter == 'all',
                  onSelected: (_) => setState(() => _filter = 'all'),
                ),
                WidgetsFilterChip(
                  label: l10n.marketingInsightFilterPending,
                  selected: _filter == 'pending',
                  onSelected: (_) => setState(() => _filter = 'pending'),
                ),
                WidgetsFilterChip(
                  label: l10n.marketingInsightFilterApproved,
                  selected: _filter == 'approved',
                  onSelected: (_) => setState(() => _filter = 'approved'),
                ),
              ],
            ),
            SizedBox(height: CoreSpacing.md(context)),
          ],
          if (widget.kind == MarketingInsightKind.visitors)
            Padding(
              padding: EdgeInsets.only(bottom: CoreSpacing.md(context)),
              child: Text(
                l10n.marketingInsightVisitorsHint,
                style: CoreTypography.bodyMedium(
                  context,
                  Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          if (widget.kind == MarketingInsightKind.purchases)
            Padding(
              padding: EdgeInsets.only(bottom: CoreSpacing.md(context)),
              child: Text(
                l10n.marketingInsightPurchasesHint,
                style: CoreTypography.bodyMedium(
                  context,
                  Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ..._rows(context, l10n, isAr, metrics),
        ],
      ),
    );
  }

  String _title(AppLocalizations l10n) => switch (widget.kind) {
    MarketingInsightKind.visitors => l10n.marketingVisitorsToday,
    MarketingInsightKind.purchases => l10n.marketingPurchasesToday,
    MarketingInsightKind.topSellers => l10n.marketingTopSellers,
    MarketingInsightKind.ratings => l10n.marketingTopRatings,
    MarketingInsightKind.social => l10n.marketingSocialInteractions,
    MarketingInsightKind.offers => l10n.marketingActiveOffers,
    MarketingInsightKind.campaigns => l10n.marketingActiveCampaigns,
  };

  List<Widget> _rows(
    BuildContext context,
    AppLocalizations l10n,
    bool isAr,
    MarketingDashboardMetrics metrics,
  ) {
    switch (widget.kind) {
      case MarketingInsightKind.topSellers:
        return [
          for (final s in metrics.topSellers)
            Padding(
              padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
              child: WidgetsAppCard(
                onTap:
                    () => context.push(
                      AppRoutePaths.marketingProductDetail(s.itemId),
                    ),
                child: ListTile(
                  title: Text(_itemName(s.itemId, isAr)),
                  subtitle: Text('${s.purchaseCount}'),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
            ),
        ];
      case MarketingInsightKind.ratings:
        final rows =
            metrics.topRatings.where((r) {
              if (_filter == 'pending') return r.pendingApproval;
              if (_filter == 'approved') return !r.pendingApproval;
              return true;
            });
        return [
          for (final r in rows)
            Padding(
              padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
              child: WidgetsAppCard(
                onTap:
                    () => context.push(
                      AppRoutePaths.marketingProductDetail(r.itemId),
                    ),
                child: ListTile(
                  title: Text(_itemName(r.itemId, isAr)),
                  subtitle: Text(isAr ? r.remarkAr : r.remarkEn),
                  trailing: WidgetsStatusPill(
                    label:
                        r.pendingApproval
                            ? l10n.marketingInsightFilterPending
                            : '${r.rating}★',
                  ),
                ),
              ),
            ),
        ];
      case MarketingInsightKind.social:
        return [
          for (final s in metrics.socialInsights)
            Padding(
              padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
              child: WidgetsAppCard(
                onTap: () => context.push(AppRoutePaths.marketingSocial),
                child: ListTile(
                  title: Text(s.platform.name),
                  subtitle: Text(
                    '${l10n.marketingSocialActionsToday}: ${s.actionsToday} · '
                    '${l10n.marketingSocialActionsWeek}: ${s.actionsWeek}',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
            ),
        ];
      case MarketingInsightKind.offers:
        return [
          WidgetsAppCard(
            onTap: () => context.push(AppRoutePaths.marketingOffers),
            child: ListTile(
              title: Text(l10n.marketingActiveOffers),
              subtitle: Text('${metrics.activeOffers}'),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
        ];
      case MarketingInsightKind.campaigns:
        return [
          WidgetsAppCard(
            onTap: () => context.push(AppRoutePaths.marketingCalendar),
            child: ListTile(
              title: Text(l10n.marketingActiveCampaigns),
              subtitle: Text('${metrics.activeCampaigns}'),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
        ];
      case MarketingInsightKind.visitors:
        return [
          for (final label in ['Organic', 'Campaign', 'Social', 'Direct'])
            Padding(
              padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
              child: WidgetsAppCard(
                onTap: () => context.push(AppRoutePaths.marketingCalendar),
                child: ListTile(
                  title: Text(label),
                  subtitle: Text(
                    '${(metrics.visitorsToday / 4).round()}',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
            ),
        ];
      case MarketingInsightKind.purchases:
        return [
          for (final s in metrics.topSellers.take(8))
            Padding(
              padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
              child: WidgetsAppCard(
                onTap:
                    () => context.push(
                      AppRoutePaths.marketingProductDetail(s.itemId),
                    ),
                child: ListTile(
                  title: Text(_itemName(s.itemId, isAr)),
                  subtitle: Text('${s.purchaseCount}'),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
            ),
        ];
    }
  }

  String _itemName(String id, bool isAr) {
    final item = ref.read(menuItemByIdProvider(id));
    if (item == null) return id;
    return isAr ? item.nameAr : item.nameEn;
  }
}
