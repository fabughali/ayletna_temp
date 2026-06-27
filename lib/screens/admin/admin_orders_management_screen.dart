import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_order_summary.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/admin_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
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
    final activeOrders = ref.watch(adminActiveOrdersProvider);
    final completedOrders = MockupCatalog.orderHistory;

    return WidgetsScaffoldPage(
      title: l10n.screenOrdersManagement,
      actions: [
        WidgetsIconButton(
          onPressed:
              () => UtilityMockFeedback.showActionSheet(
                context: context,
                title: isAr ? 'فلترة لوحة الطلبات' : 'Filter order board',
                message:
                    isAr
                        ? 'فلترة حسب القناة، المحطة، أو حالة التأخير.'
                        : 'Filter by channel, station, or delay status.',
                actions: [
                  MockSheetAction(
                    label: l10n.orderTypeDineIn,
                    icon: Icons.table_restaurant_outlined,
                    onSelected: () {},
                  ),
                  MockSheetAction(
                    label: l10n.orderTypeDelivery,
                    icon: Icons.delivery_dining_outlined,
                    onSelected: () {},
                  ),
                ],
              ),
          icon: Icons.tune_outlined,
          tooltip: isAr ? 'فلترة' : 'Filter',
        ),
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.admin),
          icon: Icons.dashboard_outlined,
          tooltip: l10n.screenAdminDashboard,
        ),
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
                if (isWide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _OrderLane(
                          title: isAr ? 'بانتظار القرار' : 'Needs Decision',
                          subtitle:
                              isAr
                                  ? 'تأخير أو نقص أو تصعيد'
                                  : 'Late, missing, or escalated',
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
                          title: isAr ? 'في التحضير' : 'Preparing',
                          subtitle:
                              isAr
                                  ? 'تحت متابعة المطبخ'
                                  : 'Kitchen in progress',
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
                          title: isAr ? 'جاهز / في الطريق' : 'Ready / On Route',
                          subtitle:
                              isAr
                                  ? 'جاهز للتسليم أو خرج'
                                  : 'Ready to handoff or on the road',
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
                    title: isAr ? 'بانتظار القرار' : 'Needs Decision',
                    subtitle:
                        isAr
                            ? 'تأخير أو نقص أو تصعيد'
                            : 'Late, missing, or escalated',
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
                    title: isAr ? 'في التحضير' : 'Preparing',
                    subtitle:
                        isAr ? 'تحت متابعة المطبخ' : 'Kitchen in progress',
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
                    title: isAr ? 'جاهز / في الطريق' : 'Ready / On Route',
                    subtitle:
                        isAr
                            ? 'جاهز للتسليم أو خرج'
                            : 'Ready to handoff or on the road',
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
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
        gradient: const LinearGradient(
          colors: [CoreColors.brandOlive, CoreColors.brandBrown],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SoftBadge(
            label: isAr ? 'لوحة الطلبات الحية' : 'Live Order Board',
            color: CoreColors.surfaceLight,
            foreground: CoreColors.brandBrown,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            isAr
                ? 'تابع كل طلب من الكاشير إلى المطبخ ثم التسليم.'
                : 'Track every order from POS to kitchen to handoff.',
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
                label: isAr ? 'طلبات مفتوحة' : 'Open orders',
                value: activeOrders.length.toString(),
                icon: Icons.receipt_long_outlined,
              ),
              _HeroStat(
                label: isAr ? 'قيمة نشطة' : 'Active value',
                value: UtilityFormatJod.format(
                  activeRevenue,
                  suffix: l10n.currencyJod,
                ),
                icon: Icons.payments_outlined,
              ),
              _HeroStat(
                label: isAr ? 'طلبات صواني' : 'Plated orders',
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
            _EmptyLane(message: isAr ? 'لا توجد طلبات هنا' : 'No orders here')
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
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
        border: Border.all(color: color.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _IconBubble(icon: _typeIcon(order.orderType), color: color),
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
                        _SoftBadge(
                          label: _typeLabel(l10n, order.orderType),
                          color: color,
                        ),
                        _SoftBadge(
                          label: _statusLabel(l10n, order.statusKey),
                          color: _statusColor(order.statusKey),
                        ),
                        if (order.isPlated)
                          _SoftBadge(
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
          _OrderOperationalLine(order: order, isAr: isAr),
          SizedBox(height: CoreSpacing.md(context)),
          Row(
            children: [
              Expanded(
                child: WidgetsAppButton(
                  label: isAr ? 'افتح التفاصيل' : 'Open detail',
                  onPressed:
                      () => context.push(
                        '${AppRoutePaths.adminOrderDetail}?id=${order.id}',
                      ),
                  variant: WidgetsAppButtonVariant.secondary,
                  icon: Icons.timeline_outlined,
                ),
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              WidgetsAppButton(
                label: isAr ? 'تصعيد' : 'Escalate',
                onPressed:
                    escalated
                        ? null
                        : () {
                          ref
                              .read(adminOrdersProvider.notifier)
                              .escalateOrder(order.id);
                          UtilityMockFeedback.showWarning(
                            context,
                            isAr ? 'تم تسجيل التصعيد' : 'Escalation logged',
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
  const _OrderOperationalLine({required this.order, required this.isAr});

  final ModelOrderSummary order;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    final message = switch (order.statusKey) {
      'pending' =>
        isAr
            ? 'بانتظار تأكيد المطبخ أو توفر المادة.'
            : 'Waiting for kitchen confirmation or item availability.',
      'ready' =>
        isAr
            ? 'جاهز للتسليم، تحقق من التغليف.'
            : 'Ready for handoff, verify packaging.',
      'on_way' =>
        isAr
            ? 'خرج للتوصيل، راقب وقت الوصول.'
            : 'On route, monitor arrival time.',
      _ =>
        isAr
            ? 'قيد التحضير، راقب وقت المحطة.'
            : 'In preparation, watch station timing.',
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
      title: isAr ? 'أغلقت مؤخراً' : 'Recently Closed',
      subtitle:
          isAr
              ? 'طلبات مكتملة أو مسلمة للتدقيق السريع.'
              : 'Completed or delivered orders for quick audit.',
      trailing: WidgetsAppButton(
        label: isAr ? 'السجل' : 'History',
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
          _IconBubble(
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
                  '${_typeLabel(l10n, order.orderType)} · ${isAr ? 'تم التسليم' : 'Delivered'}',
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
      width: 168,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      decoration: BoxDecoration(
        color: CoreColors.surfaceLight.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
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
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
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

class _IconBubble extends StatelessWidget {
  const _IconBubble({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
      ),
      child: Icon(icon, color: color, size: 20),
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
