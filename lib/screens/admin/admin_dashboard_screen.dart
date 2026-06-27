import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_inventory_mock.dart';
import 'package:ayletna_restaurant_app/data/models/model_list_entry.dart';
import 'package:ayletna_restaurant_app/data/models/model_order_summary.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/admin_plates_providers.dart';
import 'package:ayletna_restaurant_app/providers/admin_dashboard_providers.dart';
import 'package:ayletna_restaurant_app/providers/admin_session_providers.dart';
import 'package:ayletna_restaurant_app/providers/delivery_session_providers.dart';
import 'package:ayletna_restaurant_app/providers/inventory_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_avatar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD AdminDashboardScreen.
class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    final metrics = ref.watch(adminDashboardMetricsProvider);

    return WidgetsScaffoldPage(
      title: l10n.screenAdminDashboard,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.adminReports),
          icon: Icons.insights_outlined,
          tooltip: l10n.screenReports,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(adminActiveOrdersProvider);
          ref.invalidate(adminPlatesProvider);
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 840;
            final spacing = CoreSpacing.lg(context);

            return ListView(
              padding: EdgeInsetsDirectional.only(
                top: CoreSpacing.md(context),
                bottom: CoreSpacing.xxl(context),
              ),
              children: [
                _CommandHero(l10n: l10n, isAr: isAr, metrics: metrics),
                SizedBox(height: spacing),
                if (isWide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Column(
                          children: [
                            _ActionQueueCard(
                              l10n: l10n,
                              isAr: isAr,
                              metrics: metrics,
                            ),
                            SizedBox(height: spacing),
                            _LiveOrdersCard(
                              l10n: l10n,
                              isAr: isAr,
                              metrics: metrics,
                            ),
                            SizedBox(height: spacing),
                            _KitchenLoadCard(l10n: l10n, metrics: metrics),
                          ],
                        ),
                      ),
                      SizedBox(width: spacing),
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            _CashCloseCard(
                              l10n: l10n,
                              isAr: isAr,
                              metrics: metrics,
                            ),
                            SizedBox(height: spacing),
                            _StockoutsCard(l10n: l10n, isAr: isAr),
                            SizedBox(height: spacing),
                            _DriverDelaysCard(l10n: l10n, isAr: isAr, metrics: metrics),
                            SizedBox(height: spacing),
                            _TeamSnapshotCard(l10n: l10n, isAr: isAr),
                            SizedBox(height: spacing),
                            _AdminQuickControls(l10n: l10n, isAr: isAr),
                          ],
                        ),
                      ),
                    ],
                  )
                else ...[
                  _ActionQueueCard(l10n: l10n, isAr: isAr, metrics: metrics),
                  SizedBox(height: spacing),
                  _LiveOrdersCard(l10n: l10n, isAr: isAr, metrics: metrics),
                  SizedBox(height: spacing),
                  _KitchenLoadCard(l10n: l10n, metrics: metrics),
                  SizedBox(height: spacing),
                  _CashCloseCard(l10n: l10n, isAr: isAr, metrics: metrics),
                  SizedBox(height: spacing),
                  _StockoutsCard(l10n: l10n, isAr: isAr),
                  SizedBox(height: spacing),
                  _DriverDelaysCard(l10n: l10n, isAr: isAr, metrics: metrics),
                  SizedBox(height: spacing),
                  _TeamSnapshotCard(l10n: l10n, isAr: isAr),
                  SizedBox(height: spacing),
                  _AdminQuickControls(l10n: l10n, isAr: isAr),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CommandHero extends StatelessWidget {
  const _CommandHero({
    required this.l10n,
    required this.isAr,
    required this.metrics,
  });

  final AppLocalizations l10n;
  final bool isAr;
  final AdminDashboardMetrics metrics;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
        gradient: LinearGradient(
          colors: [
            CoreColors.brandOlive,
            CoreColors.brandBrown,
            CoreColors.brandOrange.withValues(alpha: 0.82),
          ],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
        boxShadow: [
          BoxShadow(
            color: CoreColors.brandBrown.withValues(alpha: 0.18),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SoftBadge(
            label: isAr ? 'مركز القيادة المباشر' : 'Live Command Center',
            color: CoreColors.surfaceLight,
            foreground: CoreColors.brandBrown,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            isAr
                ? 'الأولوية الآن: الطلبات المتأخرة، نفاد المواد، إغلاق الكاش، وتأخير السائقين.'
                : 'Priority now: late tickets, stockouts, cash close, and driver delays.',
            style: CoreTypography.headlineSmall(
              context,
              CoreColors.surfaceLight,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            isAr
                ? 'لوحة مصممة لصاحب المطعم: قرارات سريعة، تشغيل واضح، وروابط مباشرة لكل منطقة.'
                : 'Built for the restaurant owner: fast decisions, clear operations, and direct links into every station.',
            style: CoreTypography.bodyMedium(
              context,
              CoreColors.surfaceLight.withValues(alpha: 0.88),
            ),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.sm(context),
            children: [
              _HeroMetric(
                label: l10n.adminRevenueToday,
                value: UtilityFormatJod.format(
                  metrics.revenueTodayJod,
                  suffix: l10n.currencyJod,
                ),
                icon: Icons.point_of_sale_outlined,
              ),
              _HeroMetric(
                label: isAr ? 'طلبات نشطة' : 'Active orders',
                value: '${metrics.activeOrderCount}',
                icon: Icons.receipt_long_outlined,
              ),
              _HeroMetric(
                label: isAr ? 'تنبيهات عاجلة' : 'Urgent alerts',
                value: '${metrics.urgentAlerts}',
                icon: Icons.priority_high_outlined,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.sm(context),
            children: [
              WidgetsAppButton(
                label: isAr ? 'افتح لوحة الطلبات' : 'Open Orders Board',
                onPressed: () => context.push(AppRoutePaths.adminOrders),
                icon: Icons.table_restaurant_outlined,
              ),
              WidgetsAppButton(
                label: isAr ? 'إغلاق الكاش' : 'Cash Close',
                onPressed: () => context.push(AppRoutePaths.adminFinancial),
                icon: Icons.payments_outlined,
                variant: WidgetsAppButtonVariant.secondary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroMetric extends StatelessWidget {
  const _HeroMetric({
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
      width: 184,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      decoration: BoxDecoration(
        color: CoreColors.surfaceLight.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
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
                    CoreColors.surfaceLight.withValues(alpha: 0.82),
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

class _ActionQueueCard extends ConsumerWidget {
  const _ActionQueueCard({
    required this.l10n,
    required this.isAr,
    required this.metrics,
  });

  final AppLocalizations l10n;
  final bool isAr;
  final AdminDashboardMetrics metrics;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tipsApproved = ref.watch(adminTipDistributionProvider).approved;
    final lateCount =
        metrics.liveOrders
            .where((order) => order.statusKey == 'preparing')
            .length;
    final stockAlerts = MockupCatalog.inventoryAlerts.length;
    final platedOnWay =
        metrics.liveOrders
            .where(
              (order) =>
                  order.isPlated && order.statusKey == 'on_way',
            )
            .toList();
    final delayedPlated = platedOnWay.isNotEmpty ? platedOnWay.first : null;

    return WidgetsAppCard(
      title: isAr ? 'يحتاج تدخلك الآن' : 'Needs Your Attention',
      subtitle:
          isAr
              ? 'مرتبة حسب تأثيرها على تجربة الضيف والوردية.'
              : 'Prioritized by guest impact and shift risk.',
      leading: const _IconBubble(
        icon: Icons.notifications_active_outlined,
        color: CoreColors.semanticError,
      ),
      child: Column(
        children: [
          if (lateCount > 0)
            _ActionRow(
              label:
                  isAr
                      ? '$lateCount ${lateCount == 1 ? 'طلب' : 'طلبات'} تأخرت عن وقت التحضير'
                      : '$lateCount ticket${lateCount == 1 ? '' : 's'} running late',
              detail:
                  isAr
                      ? 'محطة الشاورما والمقالي تحتاج متابعة خلال ٤ دقائق.'
                      : 'Shawarma and fryer station need attention within 4 minutes.',
              color: CoreColors.semanticError,
              icon: Icons.timer_outlined,
              actionLabel: isAr ? 'افتح الطلبات' : 'Open orders',
              onPressed: () => context.push(AppRoutePaths.adminOrders),
            ),
          if (stockAlerts > 0)
            _ActionRow(
              label: l10n.adminInventoryLowTitle,
              detail:
                  isAr
                      ? '$stockAlerts ${stockAlerts == 1 ? 'مادة' : 'مواد'} تحت الحد الأدنى.'
                      : '$stockAlerts ingredient${stockAlerts == 1 ? '' : 's'} below threshold.',
              color: CoreColors.brandOlive,
              icon: Icons.inventory_2_outlined,
              actionLabel: l10n.adminRestockAction,
              onPressed: () => context.push(AppRoutePaths.inventory),
            ),
          if (!tipsApproved)
            _ActionRow(
              label: l10n.adminPendingTipTitle,
              detail: l10n.adminPendingTipBody,
              color: CoreColors.semanticTip,
              icon: Icons.volunteer_activism_outlined,
              actionLabel: l10n.adminReviewAction,
              onPressed: () => context.push(AppRoutePaths.adminTipDistribution),
            ),
          if (delayedPlated != null)
            _ActionRow(
              label:
                  isAr
                      ? 'مندوب متأخر عن تسليم صواني'
                      : 'Driver delayed on plated delivery',
              detail:
                  isAr
                      ? 'طلب #${delayedPlated.id} في الطريق — ${delayedPlated.customerLabel}.'
                      : 'Order #${delayedPlated.id} on the road — ${delayedPlated.customerLabel}.',
              color: CoreColors.orderTypeDelivery,
              icon: Icons.delivery_dining_outlined,
              actionLabel: isAr ? 'مسار التوصيل' : 'Delivery route',
              onPressed: () => context.push(AppRoutePaths.delivery),
            ),
          if (lateCount == 0 &&
              stockAlerts == 0 &&
              tipsApproved &&
              delayedPlated == null)
            Padding(
              padding: EdgeInsets.symmetric(vertical: CoreSpacing.md(context)),
              child: Text(
                isAr
                    ? 'لا توجد تنبيهات عاجلة — الوضع مستقر.'
                    : 'No urgent alerts — operations look stable.',
                style: CoreTypography.bodyMedium(
                  context,
                  Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _LiveOrdersCard extends StatelessWidget {
  const _LiveOrdersCard({
    required this.l10n,
    required this.isAr,
    required this.metrics,
  });

  final AppLocalizations l10n;
  final bool isAr;
  final AdminDashboardMetrics metrics;

  @override
  Widget build(BuildContext context) {
    final orders = metrics.liveOrders;
    return WidgetsAppCard(
      title: l10n.adminLiveOrderStatus,
      subtitle:
          isAr
              ? 'كل قناة طلب تظهر مع حالة التحضير والتحصيل.'
              : 'Every order channel with prep and settlement context.',
      trailing: WidgetsAppButton(
        label: l10n.adminNavOrders,
        onPressed: () => context.push(AppRoutePaths.adminOrders),
        variant: WidgetsAppButtonVariant.ghost,
      ),
      child: Column(
        children: [
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.sm(context),
            children: [
              _OrderCountTile(
                count: metrics.dineInCount,
                label: l10n.orderTypeDineIn,
                color: CoreColors.orderTypeDineIn,
              ),
              _OrderCountTile(
                count: metrics.takeawayCount,
                label: l10n.orderTypeTakeaway,
                color: CoreColors.orderTypeTakeaway,
              ),
              _OrderCountTile(
                count: metrics.deliveryCount,
                label: l10n.orderTypeDelivery,
                color: CoreColors.orderTypeDelivery,
              ),
              _OrderCountTile(
                count: metrics.platedCount,
                label: l10n.orderTypePlated,
                color: CoreColors.orderTypePlated,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          for (final order in orders) _OrderTicketRow(order: order, l10n: l10n),
        ],
      ),
    );
  }
}

class _KitchenLoadCard extends StatelessWidget {
  const _KitchenLoadCard({required this.l10n, required this.metrics});

  final AppLocalizations l10n;
  final AdminDashboardMetrics metrics;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: l10n.adminStationLoad,
      subtitle: l10n.adminMarketInsightBody,
      leading: const _IconBubble(
        icon: Icons.soup_kitchen_outlined,
        color: CoreColors.brandOrange,
      ),
      trailing: WidgetsAppButton(
        label: l10n.adminManageStations,
        onPressed: () => context.push(AppRoutePaths.kitchen),
        variant: WidgetsAppButtonVariant.ghost,
      ),
      child: Column(
        children: [
          _StationLoadRow(
            label: l10n.adminGrillStation,
            value: metrics.grillLoadPercent / 100,
            color: CoreColors.semanticError,
            note: l10n.adminHighDemand,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _StationLoadRow(
            label: l10n.adminColdPrepStation,
            value: metrics.coldPrepLoadPercent / 100,
            color: CoreColors.semanticSuccess,
            note: l10n.adminNormalFlow,
          ),
        ],
      ),
    );
  }
}

class _CashCloseCard extends StatelessWidget {
  const _CashCloseCard({
    required this.l10n,
    required this.isAr,
    required this.metrics,
  });

  final AppLocalizations l10n;
  final bool isAr;
  final AdminDashboardMetrics metrics;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: isAr ? 'إغلاق الكاش' : 'Cash Close',
      subtitle:
          isAr
              ? 'تحقق من المبيعات، البقشيش، والمرتجعات.'
              : 'Verify sales, tips, and refunds.',
      leading: const _IconBubble(
        icon: Icons.account_balance_wallet_outlined,
        color: CoreColors.semanticRevenue,
      ),
      child: Column(
        children: [
          _AmountLine(
            label: l10n.adminRevenueToday,
            value: UtilityFormatJod.format(
              metrics.revenueTodayJod,
              suffix: l10n.currencyJod,
            ),
          ),
          _AmountLine(
            label: l10n.adminTipsCollected,
            value: UtilityFormatJod.format(
              metrics.tipsPoolJod,
              suffix: l10n.currencyJod,
            ),
          ),
          _AmountLine(
            label: l10n.adminLossBreakage,
            value: UtilityFormatJod.format(
              metrics.breakageLossJod,
              suffix: l10n.currencyJod,
            ),
            valueColor: CoreColors.semanticError,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: isAr ? 'راجع إغلاق الوردية' : 'Review Shift Close',
            onPressed: () => context.push(AppRoutePaths.adminFinancial),
            icon: Icons.fact_check_outlined,
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}

class _StockoutsCard extends ConsumerWidget {
  const _StockoutsCard({required this.l10n, required this.isAr});

  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stock = ref.watch(inventoryStockProvider);
    final alerts = [...MockupCatalog.inventoryAlerts];
    if (stock.stockKg <= stock.thresholdKg * 1.5) {
      alerts.insert(
        0,
        ModelInventoryAlert(
          categoryAr: 'بروتين',
          categoryEn: 'Protein',
          nameAr: l10n.inventoryItemAtlanticSalmon,
          nameEn: l10n.inventoryItemAtlanticSalmon,
          remainingAr: '${stock.stockKg.toStringAsFixed(1)} كغ',
          remainingEn: '${stock.stockKg.toStringAsFixed(1)} kg remaining',
          detailAr: 'حد إعادة الطلب ${stock.thresholdKg.toStringAsFixed(0)} كغ',
          detailEn: 'Reorder point ${stock.thresholdKg.toStringAsFixed(0)} kg',
        ),
      );
    }

    final visible = alerts.take(3).toList();

    return WidgetsAppCard(
      title: isAr ? 'نفاد يؤثر على المنيو' : 'Menu Stockout Impact',
      subtitle:
          isAr
              ? 'اربط المواد الناقصة بالأطباق قبل الذروة.'
              : 'Connect low ingredients to dishes before peak.',
      leading: const _IconBubble(
        icon: Icons.eco_outlined,
        color: CoreColors.brandOlive,
      ),
      trailing: WidgetsAppButton(
        label: isAr ? 'المخزون' : 'Inventory',
        onPressed: () => context.push(AppRoutePaths.inventory),
        variant: WidgetsAppButtonVariant.ghost,
      ),
      child:
          visible.isEmpty
              ? Padding(
                padding: EdgeInsets.symmetric(vertical: CoreSpacing.md(context)),
                child: Text(
                  isAr ? 'لا توجد مواد حرجة حالياً.' : 'No critical stock alerts.',
                  style: CoreTypography.bodyMedium(
                    context,
                    Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              )
              : Column(
                children: [
                  for (final alert in visible)
                    _StockoutRow(
                      category: isAr ? alert.categoryAr : alert.categoryEn,
                      name: isAr ? alert.nameAr : alert.nameEn,
                      remaining: isAr ? alert.remainingAr : alert.remainingEn,
                      detail: isAr ? alert.detailAr : alert.detailEn,
                    ),
                ],
              ),
    );
  }
}

class _DriverDelaysCard extends ConsumerWidget {
  const _DriverDelaysCard({
    required this.l10n,
    required this.isAr,
    required this.metrics,
  });

  final AppLocalizations l10n;
  final bool isAr;
  final AdminDashboardMetrics metrics;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final returnTasks = ref.watch(deliveryReturnTasksProvider);
    final activeDeliveries =
        metrics.liveOrders
            .where(
              (order) =>
                  order.orderType == OrderType.delivery ||
                  order.orderType == OrderType.platedDelivery,
            )
            .take(2)
            .toList();

    return WidgetsAppCard(
      title: isAr ? 'السائقون والإرجاع' : 'Drivers & Returns',
      subtitle:
          isAr
              ? 'توصيل الطعام وإرجاع الصواني في نفس النظرة.'
              : 'Food delivery and plated returns in one view.',
      leading: const _IconBubble(
        icon: Icons.route_outlined,
        color: CoreColors.orderTypeDelivery,
      ),
      child: Column(
        children: [
          if (activeDeliveries.isEmpty && returnTasks.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: CoreSpacing.md(context)),
              child: Text(
                isAr ? 'لا مهام توصيل نشطة.' : 'No active delivery tasks.',
                style: CoreTypography.bodyMedium(
                  context,
                  Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          for (final order in activeDeliveries)
            _DriverRow(
              label: isAr ? 'طلب #${order.id}' : 'Order #${order.id}',
              detail: '${order.customerLabel} • ${order.statusKey}',
              badge:
                  order.isPlated ? l10n.orderTypePlated : l10n.orderTypeDelivery,
              color:
                  order.isPlated
                      ? CoreColors.orderTypePlated
                      : CoreColors.orderTypeDelivery,
            ),
          for (final task in returnTasks.take(2))
            _DriverRow(
              label: isAr ? 'إرجاع صواني #${task.id}' : 'Tray return #${task.id}',
              detail: isAr ? task.statusAr : task.statusEn,
              badge: isAr ? 'إرجاع' : 'Return',
              color: CoreColors.brandOlive,
            ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: isAr ? 'افتح مهام التوصيل' : 'Open Delivery Tasks',
            onPressed: () => context.push(AppRoutePaths.delivery),
            icon: Icons.delivery_dining_outlined,
            fullWidth: true,
            variant: WidgetsAppButtonVariant.outline,
          ),
        ],
      ),
    );
  }
}

class _TeamSnapshotCard extends ConsumerWidget {
  const _TeamSnapshotCard({required this.l10n, required this.isAr});

  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeMembers =
        ref
            .watch(adminUsersProvider)
            .allMembers
            .where((member) => member.active)
            .take(4)
            .toList();

    final staff =
        activeMembers.isEmpty
            ? MockupCatalog.staffOnShift.take(3).toList()
            : [
              for (final member in activeMembers)
                ModelListEntry(
                  id: member.email,
                  titleAr: member.nameAr,
                  titleEn: member.nameEn,
                  subtitleAr: member.roleAr,
                  subtitleEn: member.roleEn,
                ),
            ];

    return WidgetsAppCard(
      title: l10n.adminStaffOnShift,
      subtitle: isAr ? 'الطاقم الحالي حسب المحطة.' : 'Current team by station.',
      trailing: WidgetsAppButton(
        label: l10n.adminManageRoster,
        onPressed: () => context.push(AppRoutePaths.adminStaffHours),
        variant: WidgetsAppButtonVariant.ghost,
      ),
      child: Column(
        children: [
          for (var i = 0; i < staff.length; i++)
            _StaffSnapshotRow(
              entry: staff[i],
              isAr: isAr,
              active: activeMembers.isNotEmpty || i != staff.length - 1,
              status:
                  activeMembers.isNotEmpty || i != staff.length - 1
                      ? l10n.adminStaffActive
                      : l10n.adminStaffBreak,
            ),
        ],
      ),
    );
  }
}

class _AdminQuickControls extends StatelessWidget {
  const _AdminQuickControls({required this.l10n, required this.isAr});

  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: isAr ? 'تحكم سريع' : 'Quick Controls',
      subtitle:
          isAr
              ? 'روابط إدارية بدون شريط سفلي.'
              : 'Admin links without bottom navigation.',
      child: Wrap(
        spacing: CoreSpacing.sm(context),
        runSpacing: CoreSpacing.sm(context),
        children: [
          _ControlChip(
            label: l10n.screenMenuManagement,
            icon: Icons.restaurant_menu_outlined,
            onPressed: () => context.push(AppRoutePaths.adminMenu),
          ),
          _ControlChip(
            label: l10n.screenSettings,
            icon: Icons.tune_outlined,
            onPressed: () => context.push(AppRoutePaths.adminSettings),
          ),
          _ControlChip(
            label: l10n.screenReports,
            icon: Icons.analytics_outlined,
            onPressed: () => context.push(AppRoutePaths.adminReports),
          ),
          _ControlChip(
            label: l10n.screenPlatesManagement,
            icon: Icons.room_service_outlined,
            onPressed: () => context.push(AppRoutePaths.adminPlates),
          ),
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.label,
    required this.detail,
    required this.color,
    required this.icon,
    required this.actionLabel,
    required this.onPressed,
  });

  final String label;
  final String detail;
  final Color color;
  final IconData icon;
  final String actionLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: CoreSpacing.md(context)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
          border: Border.all(color: color.withValues(alpha: 0.20)),
        ),
        child: Padding(
          padding: EdgeInsets.all(CoreSpacing.md(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _IconBubble(icon: icon, color: color, compact: true),
                  SizedBox(width: CoreSpacing.sm(context)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: CoreTypography.titleMedium(
                            context,
                            Theme.of(context).colorScheme.onSurface,
                          ).copyWith(fontWeight: FontWeight.w900),
                        ),
                        SizedBox(height: CoreSpacing.xs(context)),
                        Text(
                          detail,
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
              SizedBox(height: CoreSpacing.sm(context)),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: WidgetsAppButton(
                  label: actionLabel,
                  onPressed: onPressed,
                  variant: WidgetsAppButtonVariant.secondary,
                  icon: Icons.arrow_forward,
                  iconAlignment: IconAlignment.end,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderCountTile extends StatelessWidget {
  const _OrderCountTile({
    required this.count,
    required this.label,
    required this.color,
  });

  final int count;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 136,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
        border: Border.all(color: color.withValues(alpha: 0.20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            count.toString().padLeft(2, '0'),
            style: CoreTypography.headlineSmall(
              context,
              color,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: CoreTypography.caption(
              context,
              Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderTicketRow extends StatelessWidget {
  const _OrderTicketRow({required this.order, required this.l10n});

  final ModelOrderSummary order;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final color = order.orderType.color;
    return Container(
      margin: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
      ),
      child: Row(
        children: [
          _IconBubble(
            icon: _orderIcon(order.orderType),
            color: color,
            compact: true,
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
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  '${_orderTypeLabel(order.orderType, l10n)} · ${order.statusKey}',
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
              color,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class _StationLoadRow extends StatelessWidget {
  const _StationLoadRow({
    required this.label,
    required this.value,
    required this.color,
    required this.note,
  });

  final String label;
  final double value;
  final Color color;
  final String note;

  @override
  Widget build(BuildContext context) {
    final percent = (value * 100).round();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: CoreTypography.titleMedium(
                  context,
                  Theme.of(context).colorScheme.onSurface,
                ).copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            _SoftBadge(label: '$percent%', color: color),
          ],
        ),
        SizedBox(height: CoreSpacing.xs(context)),
        ClipRRect(
          borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 10,
            backgroundColor: color.withValues(alpha: 0.12),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
        SizedBox(height: CoreSpacing.xs(context)),
        Text(
          note,
          style: CoreTypography.caption(
            context,
            Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _AmountLine extends StatelessWidget {
  const _AmountLine({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: CoreTypography.bodyMedium(
                context,
                Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Text(
            value,
            style: CoreTypography.titleMedium(
              context,
              valueColor ?? Theme.of(context).colorScheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class _StockoutRow extends StatelessWidget {
  const _StockoutRow({
    required this.category,
    required this.name,
    required this.remaining,
    required this.detail,
  });

  final String category;
  final String name;
  final String remaining;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: CoreSpacing.md(context)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _IconBubble(
            icon: Icons.warning_amber_outlined,
            color: CoreColors.brandOlive,
            compact: true,
          ),
          SizedBox(width: CoreSpacing.sm(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$category · $name',
                  style: CoreTypography.titleMedium(
                    context,
                    Theme.of(context).colorScheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  '$remaining · $detail',
                  style: CoreTypography.caption(
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

class _DriverRow extends StatelessWidget {
  const _DriverRow({
    required this.label,
    required this.detail,
    required this.badge,
    required this.color,
  });

  final String label;
  final String detail;
  final String badge;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: CoreTypography.titleMedium(
                    context,
                    Theme.of(context).colorScheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  detail,
                  style: CoreTypography.caption(
                    context,
                    Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          _SoftBadge(label: badge, color: color),
        ],
      ),
    );
  }
}

class _StaffSnapshotRow extends StatelessWidget {
  const _StaffSnapshotRow({
    required this.entry,
    required this.isAr,
    required this.active,
    required this.status,
  });

  final ModelListEntry entry;
  final bool isAr;
  final bool active;
  final String status;

  @override
  Widget build(BuildContext context) {
    final name = isAr ? entry.titleAr : entry.titleEn;
    final subtitle = isAr ? entry.subtitleAr ?? '' : entry.subtitleEn ?? '';
    final color = active ? CoreColors.semanticSuccess : CoreColors.brandBrown;
    return Padding(
      padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      child: Row(
        children: [
          WidgetsAvatar(initials: name.characters.first, color: color),
          SizedBox(width: CoreSpacing.sm(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: CoreTypography.titleMedium(
                    context,
                    Theme.of(context).colorScheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w800),
                ),
                Text(
                  subtitle,
                  style: CoreTypography.caption(
                    context,
                    Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          _SoftBadge(label: status, color: color),
        ],
      ),
    );
  }
}

class _ControlChip extends StatelessWidget {
  const _ControlChip({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon, size: 18, color: CoreColors.brandOlive),
      label: Text(label),
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.22),
        ),
      ),
    );
  }
}

class _IconBubble extends StatelessWidget {
  const _IconBubble({
    required this.icon,
    required this.color,
    this.compact = false,
  });

  final IconData icon;
  final Color color;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final size = compact ? 36.0 : CoreContentSizes.logoCard(context);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
      ),
      child: Icon(icon, color: color, size: compact ? 19 : 26),
    );
  }
}

class _SoftBadge extends StatelessWidget {
  const _SoftBadge({required this.label, required this.color, this.foreground});

  final String label;
  final Color color;
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: CoreSpacing.sm(context),
        vertical: CoreSpacing.xs(context),
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: foreground == null ? 0.12 : 1),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
      ),
      child: Text(
        label,
        style: CoreTypography.caption(
          context,
          foreground ?? color,
        ).copyWith(fontWeight: FontWeight.w900),
      ),
    );
  }
}

String _orderTypeLabel(OrderType type, AppLocalizations l10n) {
  return switch (type) {
    OrderType.dineIn => l10n.orderTypeDineIn,
    OrderType.takeaway => l10n.orderTypeTakeaway,
    OrderType.delivery => l10n.orderTypeDelivery,
    OrderType.platedDelivery => l10n.orderTypePlated,
  };
}

IconData _orderIcon(OrderType type) {
  return switch (type) {
    OrderType.dineIn => Icons.table_restaurant_outlined,
    OrderType.takeaway => Icons.shopping_bag_outlined,
    OrderType.delivery => Icons.delivery_dining_outlined,
    OrderType.platedDelivery => Icons.room_service_outlined,
  };
}
