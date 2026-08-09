import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/marketing_dashboard_providers.dart';
import 'package:ayletna_restaurant_app/providers/marketing_social_providers.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_loyalty_config_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_menu_catalog_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_combos_management_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_offers_management_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_subscriptions_management_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_discounts_management_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_rewards_management_screen.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_metric_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MarketingDashboardScreen extends ConsumerWidget {
  const MarketingDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final metrics = ref.watch(marketingDashboardMetricsProvider);

    return WidgetsScaffoldPage(
      title: l10n.hubMarketing,
      child: ListView(
        padding: EdgeInsetsDirectional.only(bottom: CoreSpacing.xxl(context)),
        children: [
          Text(
            l10n.marketingHomeOpsTitle,
            style: CoreTypography.titleMedium(
              context,
              Theme.of(context).colorScheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _metricRow(
            context,
            left: WidgetsMetricCard(
              label: l10n.marketingVisitorsToday,
              value: '${metrics.visitorsToday}',
              icon: Icons.visibility_outlined,
              accentColor: CoreColors.hubMarketingAccent,
              onTap:
                  () => context.push(AppRoutePaths.marketingInsightVisitors),
            ),
            right: WidgetsMetricCard(
              label: l10n.marketingPurchasesToday,
              value: '${metrics.purchasesToday}',
              icon: Icons.shopping_bag_outlined,
              accentColor: CoreColors.hubMarketingAccent,
              onTap:
                  () => context.push(AppRoutePaths.marketingInsightPurchases),
            ),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          _metricRow(
            context,
            left: WidgetsMetricCard(
              label: l10n.marketingActiveOffers,
              value: '${metrics.activeOffers}',
              icon: Icons.local_offer_outlined,
              onTap: () => context.push(AppRoutePaths.marketingInsightOffers),
            ),
            right: WidgetsMetricCard(
              label: l10n.marketingActiveCampaigns,
              value: '${metrics.activeCampaigns}',
              icon: Icons.campaign_outlined,
              onTap:
                  () => context.push(AppRoutePaths.marketingInsightCampaigns),
            ),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppCard(
            onTap: () => context.push(AppRoutePaths.marketingInsightTopSellers),
            child: ListTile(
              leading: const Icon(Icons.trending_up_outlined),
              title: Text(
                l10n.marketingTopSellers,
                style: CoreTypography.titleMedium(context, Theme.of(context).colorScheme.onSurface).copyWith(fontWeight: FontWeight.w800),
              ),
              subtitle: Text(
                metrics.topSellers.isEmpty
                    ? '—'
                    : metrics.topSellers
                        .take(3)
                        .map((s) => s.itemId)
                        .join(' · '),
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppCard(
            onTap: () => context.push(AppRoutePaths.marketingInsightRatings),
            child: ListTile(
              leading: Icon(
                Icons.star_outline,
                color:
                    metrics.pendingRatingCount > 0
                        ? CoreColors.brandOrange
                        : null,
              ),
              title: Text(
                l10n.marketingTopRatings,
                style: CoreTypography.titleMedium(context, Theme.of(context).colorScheme.onSurface).copyWith(fontWeight: FontWeight.w800),
              ),
              subtitle: Text(
                l10n.marketingPendingApprovals(metrics.pendingRatingCount),
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppCard(
            onTap: () => context.push(AppRoutePaths.marketingInsightSocial),
            child: ListTile(
              leading: const Icon(Icons.share_outlined),
              title: Text(
                l10n.marketingSocialInteractions,
                style: CoreTypography.titleMedium(context, Theme.of(context).colorScheme.onSurface).copyWith(fontWeight: FontWeight.w800),
              ),
              subtitle: Text('${metrics.socialActionsToday}'),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
        ],
      ),
    );
  }

  Widget _metricRow(
    BuildContext context, {
    required Widget left,
    required Widget right,
  }) {
    return Row(
      children: [
        Expanded(child: left),
        SizedBox(width: CoreSpacing.sm(context)),
        Expanded(child: right),
      ],
    );
  }
}

class MarketingOffersRouteScreen extends StatelessWidget {
  const MarketingOffersRouteScreen({super.key});
  @override
  Widget build(BuildContext context) => const AdminOffersManagementScreen();
}

class MarketingDiscountsRouteScreen extends StatelessWidget {
  const MarketingDiscountsRouteScreen({super.key});
  @override
  Widget build(BuildContext context) => const AdminDiscountsManagementScreen();
}

/// @Deprecated — use [MarketingDiscountsRouteScreen].
class MarketingPromotionsRouteScreen extends MarketingDiscountsRouteScreen {
  const MarketingPromotionsRouteScreen({super.key});
}

class MarketingCombosRouteScreen extends StatelessWidget {
  const MarketingCombosRouteScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const AdminCombosManagementScreen();
}

class MarketingSubscriptionsRouteScreen extends StatelessWidget {
  const MarketingSubscriptionsRouteScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const AdminSubscriptionsManagementScreen();
}

class MarketingCatalogRouteScreen extends StatelessWidget {
  const MarketingCatalogRouteScreen({
    super.key,
    this.initialTabIndex = 0,
    this.productsHub = false,
    this.categoriesOnly = false,
  });

  final int initialTabIndex;

  /// Marketing → Products editor (tabs). Prefer [MarketingProductsListScreen] for list.
  final bool productsHub;

  final bool categoriesOnly;

  @override
  Widget build(BuildContext context) => AdminMenuCatalogScreen(
    initialTabIndex: initialTabIndex,
    productsHub: productsHub,
    categoriesOnly: categoriesOnly,
  );
}

class MarketingLoyaltyRouteScreen extends StatelessWidget {
  const MarketingLoyaltyRouteScreen({super.key});
  @override
  Widget build(BuildContext context) => const AdminLoyaltyConfigScreen();
}

class MarketingRewardsRouteScreen extends StatelessWidget {
  const MarketingRewardsRouteScreen({super.key});
  @override
  Widget build(BuildContext context) => const AdminRewardsManagementScreen();
}

class MarketingSocialIntegrationsScreen extends ConsumerWidget {
  const MarketingSocialIntegrationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final connections = ref.watch(socialConnectionsProvider);
    final metrics = ref.watch(marketingDashboardMetricsProvider);

    return WidgetsScaffoldPage(
      title: l10n.marketingSocialMonitorTitle,
      child: ListView(
        padding: EdgeInsetsDirectional.only(bottom: CoreSpacing.xxl(context)),
        children: [
          WidgetsPageHeader(
            title: l10n.marketingSocialConnectTitle,
            subtitle: l10n.marketingSocialConnectSubtitle,
          ),
          for (final connection in connections) ...[
            WidgetsAppCard(
              child: Padding(
                padding: EdgeInsets.all(CoreSpacing.lg(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Icon(
                          connection.platform == SocialPlatform.meta
                              ? Icons.facebook
                              : Icons.camera_alt_outlined,
                          color:
                              connection.platform == SocialPlatform.meta
                                  ? CoreColors.socialMetaBlue
                                  : CoreColors.socialInstagramPink,
                        ),
                        SizedBox(width: CoreSpacing.sm(context)),
                        Expanded(
                          child: Text(
                            connection.platform == SocialPlatform.meta
                                ? l10n.marketingSocialMetaBusiness
                                : l10n.marketingSocialInstagramPlatform,
                            style: CoreTypography.titleMedium(
                              context,
                              Theme.of(context).colorScheme.onSurface,
                            ).copyWith(fontWeight: FontWeight.w900),
                          ),
                        ),
                        WidgetsStatusPill(
                          label:
                              connection.connected
                                  ? l10n.marketingSocialConnected
                                  : l10n.marketingSocialNoIntegration,
                          color:
                              connection.connected
                                  ? CoreColors.semanticSuccess
                                  : Theme.of(context).colorScheme.outline,
                        ),
                      ],
                    ),
                    if (connection.connected &&
                        connection.accountLabel != null) ...[
                      SizedBox(height: CoreSpacing.sm(context)),
                      Text(
                        connection.accountLabel!,
                        style: CoreTypography.bodyMedium(
                          context,
                          Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      if (connection.connectedAt != null)
                        Text(
                          l10n.marketingSocialConnectedSince(
                            connection.connectedAt!.toIso8601String().split('T').first,
                          ),
                          style: CoreTypography.caption(
                            context,
                            Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                    ],
                    SizedBox(height: CoreSpacing.md(context)),
                    WidgetsAppButton(
                      label:
                          connection.connected
                              ? l10n.marketingSocialDisconnect
                              : l10n.marketingSocialConnectOAuth,
                      onPressed: () async {
                        final notifier = ref.read(
                          socialConnectionsProvider.notifier,
                        );
                        if (connection.connected) {
                          await notifier.disconnect(connection.platform);
                          if (!context.mounted) return;
                          UtilityMockFeedback.showSuccess(
                            context,
                            l10n.marketingSocialDisconnectedMock,
                          );
                        } else {
                          await notifier.connect(connection.platform);
                          if (!context.mounted) return;
                          UtilityMockFeedback.showSuccess(
                            context,
                            l10n.marketingSocialConnectedMock,
                          );
                        }
                      },
                      icon:
                          connection.connected
                              ? Icons.link_off_outlined
                              : Icons.link_outlined,
                      variant:
                          connection.connected
                              ? WidgetsAppButtonVariant.outline
                              : WidgetsAppButtonVariant.primary,
                      fullWidth: true,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: CoreSpacing.md(context)),
          ],
          for (final insight in metrics.socialInsights)
            Padding(
              padding: EdgeInsets.only(bottom: CoreSpacing.md(context)),
              child: WidgetsAppCard(
                child: Padding(
                  padding: EdgeInsets.all(CoreSpacing.lg(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            insight.platform == SocialPlatform.meta
                                ? Icons.facebook
                                : Icons.camera_alt_outlined,
                            color:
                                insight.platform == SocialPlatform.meta
                                    ? CoreColors.socialMetaBlue
                                    : CoreColors.socialInstagramPink,
                          ),
                          SizedBox(width: CoreSpacing.sm(context)),
                          Text(
                            insight.platform == SocialPlatform.meta
                                ? l10n.marketingSocialMetaBusiness
                                : l10n.marketingSocialInstagramPlatform,
                            style: CoreTypography.titleMedium(
                              context,
                              Theme.of(context).colorScheme.onSurface,
                            ).copyWith(fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      SizedBox(height: CoreSpacing.md(context)),
                      Wrap(
                        spacing: CoreSpacing.md(context),
                        runSpacing: CoreSpacing.sm(context),
                        children: [
                          WidgetsStatusPill(
                            label:
                                '${l10n.marketingSocialUsers}: ${insight.users}',
                          ),
                          WidgetsStatusPill(
                            label:
                                '${l10n.marketingSocialBlogs}: ${insight.blogs}',
                          ),
                          WidgetsStatusPill(
                            label:
                                '${l10n.marketingSocialActionsToday}: ${insight.actionsToday}',
                          ),
                          WidgetsStatusPill(
                            label:
                                '${l10n.marketingSocialActionsWeek}: ${insight.actionsWeek}',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
