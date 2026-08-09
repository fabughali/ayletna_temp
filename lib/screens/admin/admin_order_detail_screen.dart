import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_order_detail.dart';
import 'package:ayletna_restaurant_app/data/models/model_order_summary.dart';
import 'package:ayletna_restaurant_app/data/repositories/repository_providers.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/providers/admin_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/utilities/utility_url_actions.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_bubble.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_order_invoice_block.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_soft_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [OrderDetailAdminScreen].
class AdminOrderDetailScreen extends ConsumerWidget {
  const AdminOrderDetailScreen({super.key, this.orderId});

  final String? orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final effectiveId = orderId ?? MockupCatalog.activeOrders.first.id;
    final orderAsync = ref.watch(adminOrderDetailProvider(effectiveId));
    final session = ref.watch(adminOrdersProvider);
    final receiptAsync = ref.watch(orderDetailByIdProvider(effectiveId));

    return orderAsync.when(
      loading:
          () => WidgetsScaffoldPage(
            title: l10n.screenOrderDetailAdmin,
            child: const Center(child: CircularProgressIndicator()),
          ),
      error:
          (error, _) => WidgetsScaffoldPage(
            title: l10n.screenOrderDetailAdmin,
            child: Center(child: Text(error.toString())),
          ),
      data:
          (order) {
            final statusKey =
                session.statusOverrides[order.id] ?? order.statusKey;
            final mergedOrder = order.copyWith(statusKey: statusKey);
            return receiptAsync.when(
            loading:
                () => WidgetsScaffoldPage(
                  title: l10n.screenOrderDetailAdmin,
                  child: const Center(child: CircularProgressIndicator()),
                ),
            error:
                (error, _) => WidgetsScaffoldPage(
                  title: l10n.screenOrderDetailAdmin,
                  child: Center(child: Text(error.toString())),
                ),
            data:
                (receiptOrder) => _AdminOrderDetailBody(
                  order: mergedOrder,
                  receiptOrder: receiptOrder,
                  l10n: l10n,
                  isAr: isAr,
                ),
          );
          },
    );
  }
}

class _AdminOrderDetailBody extends ConsumerWidget {
  const _AdminOrderDetailBody({
    required this.order,
    required this.receiptOrder,
    required this.l10n,
    required this.isAr,
  });

  final ModelOrderSummary order;
  final ModelOrderDetail receiptOrder;
  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final receiptData = orderTicketSumDataFromOrderDetail(
      receiptOrder,
      l10n,
      paymentLabel: l10n.paymentMethodCash,
      paidTotal: order.totalJod,
    );

    return WidgetsScaffoldPage(
      title: l10n.screenOrderDetailAdmin,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.operatorOrders),
          icon: Icons.view_kanban_outlined,
          tooltip: l10n.screenOrdersManagement,
        ),
        WidgetsIconButton(
          onPressed:
              () => _sendGuestUpdate(context, ref, order, l10n),
          icon: Icons.sms_outlined,
          tooltip: l10n.orderDetailAdminSendUpdate,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(adminOrderDetailProvider(order.id));
          ref.invalidate(checkoutOrderDetailProvider);
          UtilityMockFeedback.showSuccess(context, l10n.screenOrderDetailAdmin);
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 840;
            final summary = _OrderSummaryColumn(
              order: order,
              l10n: l10n,
              isAr: isAr,
            );
            final timeline = _OrderTimelineColumn(
              order: order,
              l10n: l10n,
              isAr: isAr,
            );

            return ListView(
              padding: EdgeInsetsDirectional.only(
                top: CoreSpacing.md(context),
                bottom: CoreSpacing.xxl(context),
              ),
              children: [
                _DetailHero(order: order, l10n: l10n, isAr: isAr),
                SizedBox(height: CoreSpacing.lg(context)),
                WidgetsOrderInvoiceBlock(
                  cart: receiptOrder.lines,
                  sumData: receiptData,
                  showTitle: true,
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                if (isWide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 4, child: summary),
                      SizedBox(width: CoreSpacing.lg(context)),
                      Expanded(flex: 6, child: timeline),
                    ],
                  )
                else ...[
                  summary,
                  SizedBox(height: CoreSpacing.lg(context)),
                  timeline,
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _DetailHero extends StatelessWidget {
  const _DetailHero({
    required this.order,
    required this.l10n,
    required this.isAr,
  });

  final ModelOrderSummary order;
  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    final color = order.orderType.color;
    return Container(
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
        gradient: LinearGradient(
          colors: [color, CoreColors.brandBrown],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetsSoftBadge(
            label:
                '${_typeLabel(l10n, order.orderType)} · ${_statusLabel(l10n, order.statusKey)}',
            color: CoreColors.surfaceLight,
            foreground: color,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            l10n.orderDetailAdminHeroTitle(order.id),
            style: CoreTypography.headlineSmall(
              context,
              CoreColors.surfaceLight,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            l10n.orderDetailAdminHeroBody(order.customerLabel),
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
              _HeroChip(
                label: l10n.orderDetailAdminOrderTotal,
                value: UtilityFormatJod.format(
                  order.totalJod,
                  suffix: l10n.currencyJod,
                ),
              ),
              _HeroChip(
                label: l10n.orderDetailAdminDeposit,
                value: UtilityFormatJod.format(
                  order.depositJod,
                  suffix: l10n.currencyJod,
                ),
              ),
              _HeroChip(
                label: l10n.orderDetailAdminOnRoute,
                value: l10n.orderDetailAdminOnRouteValue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void _sendGuestUpdate(
  BuildContext context,
  WidgetRef ref,
  ModelOrderSummary order,
  AppLocalizations l10n,
) {
  UtilityMockFeedback.showActionSheet(
    context: context,
    title: l10n.orderDetailAdminSendGuestUpdateTitle,
    message: order.customerLabel,
    actions: [
      MockSheetAction(
        label: l10n.orderDetailAdminUpdatePreparing,
        icon: Icons.soup_kitchen_outlined,
        onSelected: () {
          ref
              .read(adminOrdersProvider.notifier)
              .updateOrderStatus(order.id, 'preparing');
          UtilityMockFeedback.showSuccess(
            context,
            l10n.orderDetailAdminUpdateSent,
          );
        },
      ),
      MockSheetAction(
        label: l10n.orderDetailAdminUpdateReady,
        icon: Icons.check_circle_outline,
        onSelected: () {
          ref
              .read(adminOrdersProvider.notifier)
              .updateOrderStatus(order.id, 'ready');
          UtilityMockFeedback.showSuccess(
            context,
            l10n.orderDetailAdminUpdateSent,
          );
        },
      ),
      MockSheetAction(
        label: l10n.orderDetailAdminUpdateOnWay,
        icon: Icons.delivery_dining_outlined,
        onSelected: () {
          ref
              .read(adminOrdersProvider.notifier)
              .updateOrderStatus(order.id, 'on_way');
          UtilityMockFeedback.showSuccess(
            context,
            l10n.orderDetailAdminUpdateSent,
          );
        },
      ),
      MockSheetAction(
        label: l10n.orderDetailAdminUpdateDelay,
        icon: Icons.schedule_outlined,
        onSelected: () {
          ref
              .read(adminOrdersProvider.notifier)
              .updateOrderStatus(order.id, 'delayed');
          UtilityMockFeedback.showSuccess(
            context,
            l10n.orderDetailAdminDelayNoticeSent,
          );
        },
      ),
    ],
  );
}

class _OrderSummaryColumn extends StatelessWidget {
  const _OrderSummaryColumn({
    required this.order,
    required this.l10n,
    required this.isAr,
  });

  final ModelOrderSummary order;
  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _GuestAndPaymentCard(order: order, l10n: l10n, isAr: isAr),
        SizedBox(height: CoreSpacing.lg(context)),
        _KitchenTicketCard(l10n: l10n, isAr: isAr),
        SizedBox(height: CoreSpacing.lg(context)),
        _AdminActionsCard(order: order, l10n: l10n, isAr: isAr),
      ],
    );
  }
}

class _OrderTimelineColumn extends StatelessWidget {
  const _OrderTimelineColumn({
    required this.order,
    required this.l10n,
    required this.isAr,
  });

  final ModelOrderSummary order;
  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TimelineCard(order: order, l10n: l10n, isAr: isAr),
        SizedBox(height: CoreSpacing.lg(context)),
        _ExceptionCard(order: order, l10n: l10n, isAr: isAr),
      ],
    );
  }
}

class _GuestAndPaymentCard extends StatelessWidget {
  const _GuestAndPaymentCard({
    required this.order,
    required this.l10n,
    required this.isAr,
  });

  final ModelOrderSummary order;
  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: l10n.orderDetailAdminGuestPaymentTitle,
      subtitle:
l10n.orderDetailAdminGuestPaymentSubtitle,
      leading: WidgetsIconBubble(size: UtilitySizer.of(context, 38), iconSize: CoreContentSizes.buttonIcon(context), 
        icon: _typeIcon(order.orderType),
        color: order.orderType.color,
      ),
      child: Column(
        children: [
          _InfoLine(
            label: l10n.orderDetailAdminGuestLabel,
            value: order.customerLabel,
          ),
          _InfoLine(
            label: l10n.orderDetailAdminChannelLabel,
            value: _typeLabel(l10n, order.orderType),
          ),
          _InfoLine(
            label: l10n.orderDetailAdminFoodTotal,
            value: UtilityFormatJod.format(
              order.totalJod,
              suffix: l10n.currencyJod,
            ),
          ),
          _InfoLine(
            label: l10n.orderDetailAdminTrayDeposit,
            value: UtilityFormatJod.format(
              order.depositJod,
              suffix: l10n.currencyJod,
            ),
            valueColor:
                order.depositJod > 0 ? CoreColors.semanticDeposit : null,
          ),
        ],
      ),
    );
  }
}

class _KitchenTicketCard extends StatelessWidget {
  const _KitchenTicketCard({required this.l10n, required this.isAr});

  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    final prepItems = MockupCatalog.kitchenPrepItems.take(3).toList();
    return WidgetsAppCard(
      title: l10n.orderDetailAdminKitchenTicketTitle,
      subtitle: l10n.orderDetailAdminKitchenTicketSubtitle,
      leading: WidgetsIconBubble(size: UtilitySizer.of(context, 38), iconSize: CoreContentSizes.buttonIcon(context), 
        icon: Icons.soup_kitchen_outlined,
        color: CoreColors.brandOrange,
      ),
      child: Column(
        children: [
          for (final item in prepItems)
            _TicketItemRow(
              quantity: item.quantity,
              name: isAr ? item.nameAr : item.nameEn,
              note: l10n.orderDetailAdminPrepStationNote,
            ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppButton(
            label: l10n.orderDetailAdminOpenKitchen,
            onPressed: () => context.push(AppRoutePaths.kitchen),
            variant: WidgetsAppButtonVariant.outline,
            icon: Icons.restaurant_outlined,
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}

class _AdminActionsCard extends ConsumerWidget {
  const _AdminActionsCard({
    required this.order,
    required this.l10n,
    required this.isAr,
  });

  final ModelOrderSummary order;
  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WidgetsAppCard(
      title: l10n.orderDetailAdminActionsTitle,
      subtitle: l10n.orderDetailAdminActionsSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WidgetsAppButton(
            label: l10n.orderDetailAdminContactGuest,
            onPressed: () async {
              final launched = await UtilityUrlActions.launchExternalUri(
                Uri.parse('tel:+962790000000'),
              );
              if (!context.mounted) return;
              if (!launched) {
                UtilityMockFeedback.showInfo(
                  context,
                  l10n.orderDetailAdminContactPhone,
                );
              }
            },
            icon: Icons.call_outlined,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppButton(
            label: l10n.orderDetailAdminChangeStatus,
            onPressed:
                () => UtilityMockFeedback.showActionSheet(
                  context: context,
                  title: l10n.orderDetailAdminChangeStatusTitle,
                  message: l10n.orderDetailAdminChangeStatusMessage,
                  actions: [
                    MockSheetAction(
                      label: l10n.orderStatusReady,
                      icon: Icons.check_circle_outline,
                      onSelected: () {
                        ref
                            .read(adminOrdersProvider.notifier)
                            .updateOrderStatus(order.id, 'ready');
                        UtilityMockFeedback.showSuccess(
                          context,
                          l10n.orderStatusReady,
                        );
                      },
                    ),
                    MockSheetAction(
                      label: l10n.orderStatusDelivered,
                      icon: Icons.done_all_outlined,
                      onSelected: () {
                        ref
                            .read(adminOrdersProvider.notifier)
                            .updateOrderStatus(order.id, 'delivered');
                        UtilityMockFeedback.showSuccess(
                          context,
                          l10n.orderStatusDelivered,
                        );
                      },
                    ),
                  ],
                ),
            icon: Icons.edit_note_outlined,
            variant: WidgetsAppButtonVariant.secondary,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppButton(
            label: l10n.orderDetailAdminBackToBoard,
            onPressed: () => context.push(AppRoutePaths.operatorOrders),
            icon: Icons.view_kanban_outlined,
            variant: WidgetsAppButtonVariant.outline,
          ),
        ],
      ),
    );
  }
}

class _TimelineCard extends StatelessWidget {
  const _TimelineCard({
    required this.order,
    required this.l10n,
    required this.isAr,
  });

  final ModelOrderSummary order;
  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    final steps = [
      _TimelineStepData(
        title: l10n.orderDetailAdminPosReceived,
        detail: l10n.orderDetailAdminTimelinePosDetail,
        time: '14:08',
        complete: true,
        icon: Icons.point_of_sale_outlined,
      ),
      _TimelineStepData(
        title: l10n.orderDetailAdminKitchenPrep,
        detail: l10n.orderDetailAdminTimelinePrepDetail,
        time: '14:16',
        complete: true,
        icon: Icons.soup_kitchen_outlined,
      ),
      _TimelineStepData(
        title: _statusLabel(l10n, order.statusKey),
        detail:
            order.statusKey == 'on_way'
                ? l10n.orderDetailAdminTimelineOnWayDetail
                : l10n.orderDetailAdminTimelineWaitingDetail,
        time: '14:24',
        complete: order.statusKey == 'on_way' || order.statusKey == 'delivered',
        icon: Icons.delivery_dining_outlined,
      ),
      _TimelineStepData(
        title: l10n.orderDetailAdminCloseSettle,
        detail: l10n.orderDetailAdminTimelineCloseDetail,
        time: l10n.orderDetailAdminTimelineNext,
        complete: false,
        icon: Icons.fact_check_outlined,
      ),
    ];
    return WidgetsAppCard(
      title: l10n.orderDetailAdminTimelineTitle,
      subtitle: l10n.orderDetailAdminTimelineSubtitle,
      child: Column(
        children: [
          for (var i = 0; i < steps.length; i++)
            _TimelineStep(data: steps[i], isLast: i == steps.length - 1),
        ],
      ),
    );
  }
}

class _ExceptionCard extends StatelessWidget {
  const _ExceptionCard({
    required this.order,
    required this.l10n,
    required this.isAr,
  });

  final ModelOrderSummary order;
  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: l10n.orderDetailAdminRisksTitle,
      subtitle: l10n.orderDetailAdminRisksSubtitle,
      leading: WidgetsIconBubble(size: UtilitySizer.of(context, 38), iconSize: CoreContentSizes.buttonIcon(context), 
        icon: Icons.warning_amber_outlined,
        color: CoreColors.semanticError,
      ),
      child: Column(
        children: [
          _RiskRow(
            label: l10n.orderDetailAdminDeliveryTiming,
            detail: l10n.orderDetailAdminRiskTimingDetail,
            color: CoreColors.semanticError,
          ),
          _RiskRow(
            label: l10n.orderDetailAdminTrayDeposit,
            detail:
                order.depositJod > 0
                    ? UtilityFormatJod.format(
                      order.depositJod,
                      suffix: l10n.currencyJod,
                    )
                    : l10n.orderDetailAdminNoDeposit,
            color: CoreColors.semanticDeposit,
          ),
          _RiskRow(
            label: l10n.orderDetailAdminOperationalNote,
            detail: l10n.orderDetailAdminRiskTrayDetail,
            color: CoreColors.brandOlive,
          ),
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.label, required this.value, this.valueColor});

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: CoreTypography.caption(
                context,
                Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          SizedBox(width: CoreSpacing.md(context)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: CoreTypography.titleMedium(
                context,
                valueColor ?? Theme.of(context).colorScheme.onSurface,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}

class _TicketItemRow extends StatelessWidget {
  const _TicketItemRow({
    required this.quantity,
    required this.name,
    required this.note,
  });

  final int quantity;
  final String name;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      child: Row(
        children: [
          WidgetsSoftBadge(label: 'x$quantity', color: CoreColors.brandOrange),
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
                  note,
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

class _TimelineStep extends StatelessWidget {
  const _TimelineStep({required this.data, required this.isLast});

  final _TimelineStepData data;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final color = data.complete ? CoreColors.brandOlive : CoreColors.brandBrown;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            WidgetsIconBubble(size: UtilitySizer.of(context, 38), iconSize: CoreContentSizes.buttonIcon(context), icon: data.icon, color: color),
            if (!isLast)
              Container(
                width: 2,
                height: UtilitySizer.of(context, 54),
                color: color.withValues(alpha: 0.22),
              ),
          ],
        ),
        SizedBox(width: CoreSpacing.md(context)),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: CoreSpacing.md(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        data.title,
                        style: CoreTypography.titleMedium(
                          context,
                          Theme.of(context).colorScheme.onSurface,
                        ).copyWith(fontWeight: FontWeight.w900),
                      ),
                    ),
                    WidgetsSoftBadge(label: data.time, color: color),
                  ],
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  data.detail,
                  style: CoreTypography.bodyMedium(
                    context,
                    Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RiskRow extends StatelessWidget {
  const _RiskRow({
    required this.label,
    required this.detail,
    required this.color,
  });

  final String label;
  final String detail;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
      ),
      child: Row(
        children: [
          WidgetsIconBubble(size: UtilitySizer.of(context, 38), iconSize: CoreContentSizes.buttonIcon(context), icon: Icons.priority_high_outlined, color: color),
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
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: UtilitySizer.of(context, 160),
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      decoration: BoxDecoration(
        color: CoreColors.surfaceLight.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
        border: Border.all(
          color: CoreColors.surfaceLight.withValues(alpha: 0.30),
        ),
      ),
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
    );
  }
}

class _TimelineStepData {
  const _TimelineStepData({
    required this.title,
    required this.detail,
    required this.time,
    required this.complete,
    required this.icon,
  });

  final String title;
  final String detail;
  final String time;
  final bool complete;
  final IconData icon;
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
