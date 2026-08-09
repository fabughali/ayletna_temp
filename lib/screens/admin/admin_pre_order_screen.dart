import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_order_summary.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/admin_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_async_state_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_hero_metric.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_hub_nav_actions.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_bubble.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_soft_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [PreOrderScreen].
class AdminPreOrderScreen extends ConsumerWidget {
  const AdminPreOrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final scheduledOrders = ref.watch(adminPreOrdersProvider);

    return WidgetsScaffoldPage(
      title: l10n.screenPreOrder,
      actions: WidgetsHubNavActions.forContext(
        context,
        leading: [
          WidgetsIconButton(
            onPressed: () => context.push(AppRoutePaths.operatorOrders),
            icon: Icons.receipt_long_outlined,
            tooltip: l10n.adminNavOrders,
          ),
        ],
      ),
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(adminPreOrdersProvider);
        },
        child: ListView(
          padding: EdgeInsetsDirectional.only(
            top: CoreSpacing.md(context),
            bottom: CoreSpacing.xxl(context),
          ),
          children: [
            _PreOrderHero(l10n: l10n, count: scheduledOrders.length),
            SizedBox(height: CoreSpacing.lg(context)),
            if (scheduledOrders.isEmpty)
              WidgetsAsyncStateCard.empty(
                title: l10n.screenPreOrder,
                message: l10n.preOrderOpsEmptyMessage,
                actionLabel: l10n.adminNavOrders,
                onAction: () => context.push(AppRoutePaths.operatorOrders),
              )
            else
              LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 860;
                final queue = _PreOrderQueue(
                  orders: scheduledOrders,
                  l10n: l10n,
                  isAr: isAr,
                );
                final rules = Column(
                  children: [
                    _CapacityCard(l10n: l10n),
                    SizedBox(height: CoreSpacing.lg(context)),
                    _RulesCard(l10n: l10n),
                  ],
                );

                if (isWide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 6, child: queue),
                      SizedBox(width: CoreSpacing.lg(context)),
                      Expanded(flex: 4, child: rules),
                    ],
                  );
                }
                return Column(
                  children: [
                    queue,
                    SizedBox(height: CoreSpacing.lg(context)),
                    rules,
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PreOrderHero extends StatelessWidget {
  const _PreOrderHero({required this.l10n, required this.count});

  final AppLocalizations l10n;
  final int count;

  @override
  Widget build(BuildContext context) {
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
            label: l10n.preOrderOpsBadge,
            color: CoreColors.surfaceLight,
            foreground: CoreColors.brandBrown,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            l10n.preOrderOpsHeadline,
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
              WidgetsHeroMetric(
                label: l10n.preOrderOpsNeedDecision,
                value: '$count',
                icon: Icons.pending_actions_outlined,
              ),
              WidgetsHeroMetric(
                label: l10n.preOrderOpsPickupWindows,
                value: '6',
                icon: Icons.schedule_outlined,
              ),
              WidgetsHeroMetric(
                label: l10n.preOrderOpsReservedTrays,
                value: '12',
                icon: Icons.room_service_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PreOrderQueue extends StatelessWidget {
  const _PreOrderQueue({
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
      title: l10n.preOrderOpsReviewQueue,
      subtitle: l10n.preOrderOpsReviewQueueSub,
      leading: WidgetsIconBubble(
        icon: Icons.event_note_outlined,
        color: CoreColors.brandOlive,
      ),
      child: Column(
        children:
            orders
                .map(
                  (order) => _PreOrderRow(order: order, l10n: l10n, isAr: isAr),
                )
                .toList(),
      ),
    );
  }
}

class _PreOrderRow extends ConsumerWidget {
  const _PreOrderRow({
    required this.order,
    required this.l10n,
    required this.isAr,
  });

  final ModelOrderSummary order;
  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = _typeColor(order.orderType);
    return Container(
      margin: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
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
            children: [
              WidgetsIconBubble(icon: _typeIcon(order.orderType), color: color),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '#${order.id} • ${order.customerLabel}',
                      style: CoreTypography.titleMedium(
                        context,
                        Theme.of(context).colorScheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    Text(
                      '${_typeLabel(l10n, order.orderType)} • ${_statusLabel(l10n, order.statusKey)}',
                      style: CoreTypography.caption(
                        context,
                        Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              WidgetsSoftBadge(
                label: UtilityFormatJod.format(
                  order.totalJod + order.depositJod,
                  suffix: l10n.currencyJod,
                ),
                color: color,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Row(
            children: [
              Expanded(
                child: WidgetsAppButton(
                  label: l10n.preOrderOpsAccept,
                  onPressed: () {
                    ref
                        .read(adminOrdersProvider.notifier)
                        .acceptPreOrder(order.id);
                    UtilityMockFeedback.showSuccess(
                      context,
                      l10n.preOrderOpsAccepted,
                    );
                  },
                  icon: Icons.check,
                ),
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: WidgetsAppButton(
                  label: l10n.preOrderOpsAdjustTime,
                  onPressed: () async {
                    final confirmed = await UtilityMockFeedback.confirm(
                      context: context,
                      title: l10n.preOrderOpsAdjustTime,
                      message: '#${order.id}',
                      confirmLabel: l10n.actionConfirm,
                      cancelLabel: l10n.actionCancel,
                      icon: Icons.schedule,
                    );
                    if (!context.mounted || !confirmed) return;
                    ref
                        .read(adminOrdersProvider.notifier)
                        .adjustPreOrderTime(order.id, '18:30');
                    UtilityMockFeedback.showSuccess(
                      context,
                      l10n.preOrderOpsPickupUpdated,
                    );
                  },
                  icon: Icons.schedule,
                  variant: WidgetsAppButtonVariant.outline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CapacityCard extends StatelessWidget {
  const _CapacityCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: l10n.preOrderOpsPrepCapacity,
      subtitle: l10n.preOrderOpsPrepCapacitySub,
      leading: WidgetsIconBubble(
        icon: Icons.restaurant_menu_outlined,
        color: CoreColors.brandOrange,
      ),
      child: Column(
        children: [
          _CapacityLine(
            label: l10n.preOrderOpsStationShawarma,
            value: '78%',
            color: CoreColors.brandOrange,
          ),
          _CapacityLine(
            label: l10n.preOrderOpsStationPizza,
            value: '64%',
            color: CoreColors.semanticRevenue,
          ),
          _CapacityLine(
            label: l10n.preOrderOpsStationPlated,
            value: '12/20',
            color: CoreColors.orderTypePlated,
          ),
        ],
      ),
    );
  }
}

class _RulesCard extends StatelessWidget {
  const _RulesCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: l10n.preOrderOpsRulesTitle,
      subtitle: l10n.preOrderOpsRulesSubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.rule_outlined,
        color: CoreColors.semanticDeposit,
      ),
      child: Column(
        children: [
          _RuleLine(label: l10n.preOrderOpsRuleCutoff),
          _RuleLine(label: l10n.preOrderOpsRuleMinPrep),
          _RuleLine(label: l10n.preOrderOpsRuleTraysBeforePay),
        ],
      ),
    );
  }
}

class _CapacityLine extends StatelessWidget {
  const _CapacityLine({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: CoreTypography.titleMedium(
                context,
                Theme.of(context).colorScheme.onSurface,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
          ),
          WidgetsSoftBadge(label: value, color: color),
        ],
      ),
    );
  }
}

class _RuleLine extends StatelessWidget {
  const _RuleLine({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: CoreColors.brandOlive),
          SizedBox(width: CoreSpacing.sm(context)),
          Expanded(
            child: Text(
              label,
              style: CoreTypography.bodyMedium(
                context,
                Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
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

String _typeLabel(AppLocalizations l10n, OrderType type) {
  return switch (type) {
    OrderType.dineIn => l10n.orderTypeDineIn,
    OrderType.takeaway => l10n.orderTypeTakeaway,
    OrderType.platedDelivery => l10n.orderTypePlated,
    OrderType.delivery => l10n.orderTypeDelivery,
  };
}

Color _typeColor(OrderType type) {
  return switch (type) {
    OrderType.dineIn => CoreColors.orderTypeDineIn,
    OrderType.takeaway => CoreColors.orderTypeTakeaway,
    OrderType.platedDelivery => CoreColors.orderTypePlated,
    OrderType.delivery => CoreColors.orderTypeDelivery,
  };
}

IconData _typeIcon(OrderType type) {
  return switch (type) {
    OrderType.dineIn => Icons.table_restaurant_outlined,
    OrderType.takeaway => Icons.shopping_bag_outlined,
    OrderType.platedDelivery => Icons.room_service_outlined,
    OrderType.delivery => Icons.delivery_dining_outlined,
  };
}
