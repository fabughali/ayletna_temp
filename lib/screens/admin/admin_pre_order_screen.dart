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
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
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
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.adminOrders),
          icon: Icons.receipt_long_outlined,
          tooltip: l10n.adminNavOrders,
        ),
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.adminSettings),
          icon: Icons.settings_outlined,
          tooltip: l10n.screenSettings,
        ),
      ],
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
            _PreOrderHero(isAr: isAr, count: scheduledOrders.length),
            SizedBox(height: CoreSpacing.lg(context)),
            if (scheduledOrders.isEmpty)
              WidgetsAsyncStateCard.empty(
                title: l10n.screenPreOrder,
                message:
                    isAr ? 'لا توجد طلبات مسبقة' : 'No pre-orders pending',
                actionLabel: l10n.adminNavOrders,
                onAction: () => context.push(AppRoutePaths.adminOrders),
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
                    _CapacityCard(isAr: isAr),
                    SizedBox(height: CoreSpacing.lg(context)),
                    _RulesCard(isAr: isAr),
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
  const _PreOrderHero({required this.isAr, required this.count});

  final bool isAr;
  final int count;

  @override
  Widget build(BuildContext context) {
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
            label: isAr ? 'لوحة الطلبات المسبقة' : 'Pre-order Operations',
            color: CoreColors.surfaceLight,
            foreground: CoreColors.brandBrown,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            isAr
                ? 'راجع طلبات الغد، الطاقة التحضيرية، الصواني، ومواعيد الاستلام قبل قبول أي طلب مسبق.'
                : 'Review tomorrow orders, prep capacity, trays, and pickup windows before accepting pre-orders.',
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
              _HeroMetric(
                label: isAr ? 'بانتظار القرار' : 'Need decision',
                value: '$count',
                icon: Icons.pending_actions_outlined,
              ),
              _HeroMetric(
                label: isAr ? 'نوافذ الاستلام' : 'Pickup windows',
                value: '6',
                icon: Icons.schedule_outlined,
              ),
              _HeroMetric(
                label: isAr ? 'صواني محجوزة' : 'Reserved trays',
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
      title: isAr ? 'قائمة المراجعة' : 'Review Queue',
      subtitle:
          isAr
              ? 'كل طلب مسبق يحتاج قراراً واضحاً قبل التحضير.'
              : 'Each pre-order needs a clear decision before prep.',
      leading: const _IconBubble(
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
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
        border: Border.all(color: color.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _IconBubble(icon: _typeIcon(order.orderType), color: color),
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
              _SoftBadge(
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
                  label: isAr ? 'قبول' : 'Accept',
                  onPressed: () {
                    ref
                        .read(adminOrdersProvider.notifier)
                        .acceptPreOrder(order.id);
                    UtilityMockFeedback.showSuccess(
                      context,
                      isAr ? 'تم قبول الطلب المسبق' : 'Pre-order accepted',
                    );
                  },
                  icon: Icons.check,
                ),
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: WidgetsAppButton(
                  label: isAr ? 'تعديل الوقت' : 'Adjust time',
                  onPressed: () async {
                    final confirmed = await UtilityMockFeedback.confirm(
                      context: context,
                      title: isAr ? 'تعديل الوقت' : 'Adjust time',
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
                      isAr ? 'تم تحديث وقت الاستلام' : 'Pickup time updated',
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
  const _CapacityCard({required this.isAr});

  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: isAr ? 'طاقة التحضير' : 'Prep Capacity',
      subtitle:
          isAr
              ? 'اضبط قبول الطلبات حسب المحطات المتاحة.'
              : 'Accept orders based on available stations.',
      leading: const _IconBubble(
        icon: Icons.restaurant_menu_outlined,
        color: CoreColors.brandOrange,
      ),
      child: Column(
        children: [
          _CapacityLine(
            label: isAr ? 'الشاورما' : 'Shawarma',
            value: '78%',
            color: CoreColors.brandOrange,
          ),
          _CapacityLine(
            label: isAr ? 'البيتزا' : 'Pizza',
            value: '64%',
            color: CoreColors.semanticRevenue,
          ),
          _CapacityLine(
            label: isAr ? 'الصواني' : 'Plated trays',
            value: '12/20',
            color: CoreColors.orderTypePlated,
          ),
        ],
      ),
    );
  }
}

class _RulesCard extends StatelessWidget {
  const _RulesCard({required this.isAr});

  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: isAr ? 'قواعد الطلب المسبق' : 'Pre-order Rules',
      subtitle:
          isAr
              ? 'قواعد واجهة وهمية قابلة للتعديل لاحقاً.'
              : 'UI-only rules ready for later data wiring.',
      leading: const _IconBubble(
        icon: Icons.rule_outlined,
        color: CoreColors.semanticDeposit,
      ),
      child: Column(
        children: [
          _RuleLine(label: isAr ? 'آخر وقت قبول: ٩ مساءً' : 'Cutoff: 9 PM'),
          _RuleLine(
            label:
                isAr ? 'الحد الأدنى للتحضير: ساعتان' : 'Minimum prep: 2 hours',
          ),
          _RuleLine(
            label:
                isAr
                    ? 'تأكيد الصواني قبل الدفع'
                    : 'Confirm trays before payment',
          ),
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
          _SoftBadge(label: value, color: color),
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
      width: 172,
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

class _IconBubble extends StatelessWidget {
  const _IconBubble({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
      ),
      child: Icon(icon, color: color, size: 22),
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
