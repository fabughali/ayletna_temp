import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_order_summary.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/admin_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_filter_chip.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_hub_nav_actions.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_bubble.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_soft_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [OrdersManagementScreen].
class AdminOrdersManagementScreen extends ConsumerWidget {
  const AdminOrdersManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final activeOrders = ref.watch(adminFilteredActiveOrdersProvider);
    final filterState = ref.watch(adminOrdersFilterProvider);
    final completedOrders = MockupCatalog.orderHistory;

    return WidgetsScaffoldPage(
      title: l10n.screenOrdersManagement,
      actions: [
        ...WidgetsHubNavActions.forContext(context),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(adminActiveOrdersProvider);
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 900;
            return ListView(
              padding: EdgeInsetsDirectional.only(
                top: CoreSpacing.md(context),
                bottom: CoreSpacing.xxl(context),
              ),
              children: [
                _OrdersBoardHero(
                  l10n: l10n,
                  isAr: isAr,
                  activeOrders: activeOrders,
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                _OrderTypeFilters(
                  l10n: l10n,
                  currentFilter: filterState.orderTypeFilter,
                  onFilterChanged: (value) =>
                      ref.read(adminOrdersFilterProvider.notifier).setOrderTypeFilter(value),
                ),
                SizedBox(height: CoreSpacing.md(context)),
                if (isWide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _OrderLane(
                          title: l10n.ordersMgmtLaneNeedsDecision,
                          subtitle:
l10n.ordersMgmtLaneNeedsDecisionSub,
                          orders:
                              activeOrders
                                  .where(
                                    (order) => order.statusKey == 'pending',
                                  )
                                  .toList(),
                          color: CoreColors.semanticError,
                          l10n: l10n,
                          isAr: isAr,
                        ),
                      ),
                      SizedBox(width: CoreSpacing.md(context)),
                      Expanded(
                        child: _OrderLane(
                          title: l10n.ordersMgmtLanePreparing,
                          subtitle: l10n.ordersMgmtLanePreparingSub,
                          orders:
                              activeOrders
                                  .where(
                                    (order) => order.statusKey == 'preparing',
                                  )
                                  .toList(),
                          color: CoreColors.brandOrange,
                          l10n: l10n,
                          isAr: isAr,
                        ),
                      ),
                      SizedBox(width: CoreSpacing.md(context)),
                      Expanded(
                        child: _OrderLane(
                          title: l10n.ordersMgmtLaneReadyRoute,
                          subtitle: l10n.ordersMgmtLaneReadyRouteSub,
                          orders:
                              activeOrders
                                  .where(
                                    (order) =>
                                        order.statusKey == 'ready' ||
                                        order.statusKey == 'on_way',
                                  )
                                  .toList(),
                          color: CoreColors.brandOlive,
                          l10n: l10n,
                          isAr: isAr,
                        ),
                      ),
                    ],
                  )
                else ...[
                  _OrderLane(
                    title: l10n.ordersMgmtLaneNeedsDecision,
                    subtitle: l10n.ordersMgmtLaneNeedsDecisionSub,
                    orders:
                        activeOrders
                            .where((order) => order.statusKey == 'pending')
                            .toList(),
                    color: CoreColors.semanticError,
                    l10n: l10n,
                    isAr: isAr,
                  ),
                  SizedBox(height: CoreSpacing.lg(context)),
                  _OrderLane(
                    title: l10n.ordersMgmtLanePreparing,
                    subtitle:
                        l10n.ordersMgmtLanePreparingSub,
                    orders:
                        activeOrders
                            .where((order) => order.statusKey == 'preparing')
                            .toList(),
                    color: CoreColors.brandOrange,
                    l10n: l10n,
                    isAr: isAr,
                  ),
                  SizedBox(height: CoreSpacing.lg(context)),
                  _OrderLane(
                    title: l10n.ordersMgmtLaneReadyRoute,
                    subtitle: l10n.ordersMgmtLaneReadyRouteSub,
                    orders:
                        activeOrders
                            .where(
                              (order) =>
                                  order.statusKey == 'ready' ||
                                  order.statusKey == 'on_way',
                            )
                            .toList(),
                    color: CoreColors.brandOlive,
                    l10n: l10n,
                    isAr: isAr,
                  ),
                ],
                SizedBox(height: CoreSpacing.lg(context)),
                _RecentlyClosedOrders(
                  orders: completedOrders,
                  l10n: l10n,
                  isAr: isAr,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _OrdersBoardHero extends StatelessWidget {
  const _OrdersBoardHero({
    required this.l10n,
    required this.isAr,
    required this.activeOrders,
  });

  final AppLocalizations l10n;
  final bool isAr;
  final List<ModelOrderSummary> activeOrders;

  @override
  Widget build(BuildContext context) {
    final activeRevenue = activeOrders.fold<double>(
      0,
      (total, order) => total + order.totalJod + order.depositJod,
    );
    return Container(
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
        gradient: const LinearGradient(
          colors: [CoreColors.brandOlive, CoreColors.brandBrown],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetsSoftBadge(
            label: l10n.ordersMgmtHeroBadge,
            color: CoreColors.surfaceLight,
            foreground: CoreColors.brandBrown,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            l10n.ordersMgmtHeroHeadline,
            style: CoreTypography.headlineSmall(
              context,
              CoreColors.surfaceLight,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.sm(context),
            children: [
              _HeroStat(
                label: l10n.ordersMgmtOpenOrders,
                value: activeOrders.length.toString(),
                icon: Icons.receipt_long_outlined,
              ),
              _HeroStat(
                label: l10n.ordersMgmtActiveValue,
                value: UtilityFormatJod.format(
                  activeRevenue,
                  suffix: l10n.currencyJod,
                ),
                icon: Icons.payments_outlined,
              ),
              _HeroStat(
                label: l10n.ordersMgmtPlatedOrders,
                value:
                    activeOrders
                        .where((order) => order.isPlated)
                        .length
                        .toString(),
                icon: Icons.room_service_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OrderLane extends StatelessWidget {
  const _OrderLane({
    required this.title,
    required this.subtitle,
    required this.orders,
    required this.color,
    required this.l10n,
    required this.isAr,
  });

  final String title;
  final String subtitle;
  final List<ModelOrderSummary> orders;
  final Color color;
  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: title,
      subtitle: '$subtitle · ${orders.length}',
      accentColor: color,
      child: Column(
        children: [
          if (orders.isEmpty)
            _EmptyLane(message: l10n.ordersMgmtEmptyLane)
          else
            for (final order in orders)
              _AdminOrderCard(order: order, l10n: l10n, isAr: isAr),
        ],
      ),
    );
  }
}

class _AdminOrderCard extends ConsumerWidget {
  const _AdminOrderCard({
    required this.order,
    required this.l10n,
    required this.isAr,
  });

  final ModelOrderSummary order;
  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final escalated =
        ref.watch(adminOrdersProvider).escalatedOrderIds.contains(order.id);
    final color = order.orderType.color;
    final total = order.totalJod + order.depositJod;
    return Container(
      margin: EdgeInsets.only(bottom: CoreSpacing.md(context)),
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
        border: Border.all(color: color.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetsIconBubble(size: UtilitySizer.of(context, 38), iconSize: CoreContentSizes.buttonIcon(context), icon: _typeIcon(order.orderType), color: color),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '#${order.id} · ${order.customerLabel}',
                      style: CoreTypography.titleMedium(
                        context,
                        Theme.of(context).colorScheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    Wrap(
                      spacing: CoreSpacing.xs(context),
                      runSpacing: CoreSpacing.xs(context),
                      children: [
                        WidgetsSoftBadge(
                          label: _typeLabel(l10n, order.orderType),
                          color: color,
                        ),
                        WidgetsSoftBadge(
                          label: _statusLabel(l10n, order.statusKey),
                          color: _statusColor(order.statusKey),
                        ),
                        if (order.isPlated)
                          WidgetsSoftBadge(
                            label: l10n.orderTypePlated,
                            color: CoreColors.semanticDeposit,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                UtilityFormatJod.format(total, suffix: l10n.currencyJod),
                style: CoreTypography.titleMedium(
                  context,
                  Theme.of(context).colorScheme.onSurface,
                ).copyWith(fontWeight: FontWeight.w900),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _OrderOperationalLine(order: order, l10n: l10n),
          SizedBox(height: CoreSpacing.md(context)),
          Row(
            children: [
              Expanded(
                child: WidgetsAppButton(
                  label: l10n.ordersMgmtOpenDetail,
                  onPressed:
                      () => context.push(
                        '${AppRoutePaths.operatorOrderDetail}?id=${order.id}',
                      ),
                  variant: WidgetsAppButtonVariant.secondary,
                  icon: Icons.timeline_outlined,
                ),
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              WidgetsAppButton(
                label: l10n.ordersMgmtEscalate,
                onPressed:
                    escalated
                        ? null
                        : () {
                          ref
                              .read(adminOrdersProvider.notifier)
                              .escalateOrder(order.id);
                          UtilityMockFeedback.showWarning(
                            context,
                            l10n.ordersMgmtEscalationLogged,
                          );
                        },
                variant: WidgetsAppButtonVariant.outline,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OrderOperationalLine extends StatelessWidget {
  const _OrderOperationalLine({required this.order, required this.l10n});

  final ModelOrderSummary order;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final message = switch (order.statusKey) {
      'pending' => l10n.ordersMgmtOpPending,
      'ready' => l10n.ordersMgmtOpReady,
      'on_way' => l10n.ordersMgmtOpOnWay,
      _ => l10n.ordersMgmtOpPreparing,
    };
    return Text(
      message,
      style: CoreTypography.bodyMedium(
        context,
        Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}

class _RecentlyClosedOrders extends StatelessWidget {
  const _RecentlyClosedOrders({
    required this.orders,
    required this.l10n,
    required this.isAr,
  });

  final List<ModelOrderSummary> orders;
  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: l10n.ordersMgmtRecentlyClosed,
      subtitle: l10n.ordersMgmtRecentlyClosedSub,
      trailing: WidgetsAppButton(
        label: l10n.ordersMgmtHistory,
        onPressed: () => context.push(AppRoutePaths.cashierOrderHistory),
        variant: WidgetsAppButtonVariant.ghost,
      ),
      child: Column(
        children: [
          for (final order in orders)
            _ClosedOrderRow(order: order, l10n: l10n, isAr: isAr),
        ],
      ),
    );
  }
}

class _ClosedOrderRow extends StatelessWidget {
  const _ClosedOrderRow({
    required this.order,
    required this.l10n,
    required this.isAr,
  });

  final ModelOrderSummary order;
  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      child: Row(
        children: [
          WidgetsIconBubble(size: UtilitySizer.of(context, 38), iconSize: CoreContentSizes.buttonIcon(context), 
            icon: _typeIcon(order.orderType),
            color: order.orderType.color,
          ),
          SizedBox(width: CoreSpacing.sm(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '#${order.id} · ${order.customerLabel}',
                  style: CoreTypography.titleMedium(
                    context,
                    Theme.of(context).colorScheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w800),
                ),
                Text(
                  '${_typeLabel(l10n, order.orderType)} · ${l10n.ordersMgmtDeliveredStatus}',
                  style: CoreTypography.caption(
                    context,
                    Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            UtilityFormatJod.format(order.totalJod, suffix: l10n.currencyJod),
            style: CoreTypography.titleMedium(
              context,
              Theme.of(context).colorScheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class _HeroStat extends StatelessWidget {
  const _HeroStat({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: UtilitySizer.of(context, 168),
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      decoration: BoxDecoration(
        color: CoreColors.surfaceLight.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
        border: Border.all(
          color: CoreColors.surfaceLight.withValues(alpha: 0.28),
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

class _EmptyLane extends StatelessWidget {
  const _EmptyLane({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: CoreTypography.bodyMedium(
          context,
          Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

String _statusLabel(AppLocalizations l10n, String key) {
  return switch (key) {
    'ready' => l10n.orderStatusReady,
    'on_way' => l10n.orderStatusOnWay,
    'pending' => l10n.orderStatusPending,
    'delivered' => l10n.orderStatusDelivered,
    _ => l10n.orderStatusPreparing,
  };
}

Color _statusColor(String key) {
  return switch (key) {
    'ready' => CoreColors.semanticSuccess,
    'on_way' => CoreColors.orderTypeDelivery,
    'pending' => CoreColors.semanticError,
    _ => CoreColors.brandOrange,
  };
}

String _typeLabel(AppLocalizations l10n, OrderType type) {
  return switch (type) {
    OrderType.dineIn => l10n.orderTypeDineIn,
    OrderType.takeaway => l10n.orderTypeTakeaway,
    OrderType.delivery => l10n.orderTypeDelivery,
    OrderType.platedDelivery => l10n.orderTypePlated,
  };
}

IconData _typeIcon(OrderType type) {
  return switch (type) {
    OrderType.dineIn => Icons.table_restaurant_outlined,
    OrderType.takeaway => Icons.shopping_bag_outlined,
    OrderType.delivery => Icons.delivery_dining_outlined,
    OrderType.platedDelivery => Icons.room_service_outlined,
  };
}

class _OrderTypeFilters extends StatelessWidget {
  const _OrderTypeFilters({
    required this.l10n,
    required this.currentFilter,
    required this.onFilterChanged,
  });

  final AppLocalizations l10n;
  final String currentFilter;
  final ValueChanged<String> onFilterChanged;

  static const _filterOptions = [
    ('all', null),
    ('dineIn', Icons.table_restaurant_outlined),
    ('takeaway', Icons.shopping_bag_outlined),
    ('delivery', Icons.delivery_dining_outlined),
    ('platedDelivery', Icons.room_service_outlined),
  ];

  String _label(String key) => switch (key) {
    'all' => l10n.filterAll,
    'dineIn' => l10n.orderTypeDineIn,
    'takeaway' => l10n.orderTypeTakeaway,
    'delivery' => l10n.orderTypeDelivery,
    'platedDelivery' => l10n.orderTypePlated,
    _ => key,
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final option in _filterOptions)
            Padding(
              padding: EdgeInsetsDirectional.only(end: CoreSpacing.sm(context)),
              child: WidgetsFilterChip(
                label: _label(option.$1),
                selected: currentFilter == option.$1,
                onSelected: (_) => onFilterChanged(option.$1),
                icon: option.$2,
              ),
            ),
        ],
      ),
    );
  }
}
