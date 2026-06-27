import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_cashier_postponed_order.dart';
import 'package:ayletna_restaurant_app/data/models/model_order_summary.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/cashier_postponed_orders_provider.dart';
import 'package:ayletna_restaurant_app/providers/cashier_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_file_download.dart';
import 'package:ayletna_restaurant_app/utilities/utility_report_export.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_async_state_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_price_badge.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD CashierOrderHistory — shift transaction history and receipts.
class CashierOrderHistoryScreen extends ConsumerStatefulWidget {
  const CashierOrderHistoryScreen({super.key});

  @override
  ConsumerState<CashierOrderHistoryScreen> createState() =>
      _CashierOrderHistoryScreenState();
}

class _CashierOrderHistoryScreenState
    extends ConsumerState<CashierOrderHistoryScreen> {
  var _selectedFilter = 'all';
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ModelOrderSummary> _allOrders() {
    final session = ref.watch(cashierSessionOrdersProvider);
    return [...session, ...MockupCatalog.cashierTransactions];
  }

  List<ModelOrderSummary> _filteredOrders(List<ModelOrderSummary> source) {
    final query = _searchController.text.trim().toLowerCase();
    return source.where((order) {
      final matchesFilter = switch (_selectedFilter) {
        'dineIn' => order.orderType == OrderType.dineIn,
        'takeaway' => order.orderType == OrderType.takeaway,
        'delivery' => order.orderType == OrderType.delivery,
        'plated' => order.orderType == OrderType.platedDelivery,
        'refunds' => order.statusKey == 'refunded',
        _ => true,
      };
      if (!matchesFilter) return false;
      if (query.isEmpty) return true;
      return order.id.toLowerCase().contains(query) ||
          order.customerLabel.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final postponed = ref.watch(cashierPostponedOrdersProvider);
    final orders = _filteredOrders(_allOrders());

    return WidgetsScaffoldPage(
      title: l10n.screenCashierOrderHistory,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.cashier),
          icon: Icons.point_of_sale_outlined,
          tooltip: l10n.screenCashierOrder,
        ),
        WidgetsIconButton(
          onPressed:
              () => UtilityMockFeedback.showInfo(
                context,
                l10n.screenNotifications,
              ),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          UtilityMockFeedback.showSuccess(context, l10n.cashierRecentTransactions);
        },
        child: ListView(
          children: [
            _LedgerHero(orderCount: orders.length),
            SizedBox(height: CoreSpacing.lg(context)),
            _ShiftCloseSummary(orders: _allOrders()),
            SizedBox(height: CoreSpacing.lg(context)),
            WidgetsAppTextField(
              controller: _searchController,
              label: l10n.cashierSearchHint,
              hintText: l10n.cashierSearchHint,
              prefixIcon: Icons.search,
              onChanged: (_) => setState(() {}),
            ),
            SizedBox(height: CoreSpacing.md(context)),
            _LedgerFilterRow(
              selectedFilter: _selectedFilter,
              onSelected: (filter) => setState(() => _selectedFilter = filter),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            if (postponed.isNotEmpty) ...[
              Text(
                l10n.cashierPostponed,
                style: CoreTypography.titleMedium(
                  context,
                  Theme.of(context).colorScheme.onSurface,
                ).copyWith(fontWeight: FontWeight.w900),
              ),
              SizedBox(height: CoreSpacing.sm(context)),
              for (final order in postponed) ...[
                _PostponedOrderCard(
                  order: order,
                  onResume: () {
                    ref.read(cashierResumeDraftProvider.notifier).state = order;
                    context.push(AppRoutePaths.cashier);
                  },
                ),
                SizedBox(height: CoreSpacing.sm(context)),
              ],
              SizedBox(height: CoreSpacing.lg(context)),
            ],
            _SectionHeader(
              title: l10n.cashierRecentTransactions,
              actionLabel: l10n.reportsExportCsv,
              onAction: () async {
                final csv = buildCashierOrdersCsv(_allOrders());
                await downloadTextFile(
                  'cashier-shift-orders.csv',
                  csv,
                  mimeType: 'text/csv',
                );
                if (!context.mounted) return;
                UtilityMockFeedback.showSuccess(context, l10n.reportsExportCsv);
              },
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            if (orders.isEmpty)
              WidgetsAsyncStateCard.empty(
                title: l10n.cashierRecentTransactions,
                message: l10n.searchEmptyBody,
                actionLabel: l10n.screenCashierOrder,
                onAction: () => context.push(AppRoutePaths.cashier),
              )
            else
              for (final order in orders) ...[
                _LedgerReceiptCard(
                  order: order,
                  onRefundConfirmed: () {
                    ref
                        .read(cashierSessionOrdersProvider.notifier)
                        .markRefunded(order.id);
                    setState(() {});
                  },
                ),
                SizedBox(height: CoreSpacing.sm(context)),
              ],
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsAppButton(
              label: l10n.cashierLoadOlder,
              onPressed:
                  () => UtilityMockFeedback.showInfo(
                    context,
                    l10n.cashierLoadOlder,
                  ),
              icon: Icons.history_outlined,
              variant: WidgetsAppButtonVariant.outline,
              fullWidth: true,
            ),
            SizedBox(height: CoreSpacing.xl(context)),
          ],
        ),
      ),
    );
  }
}

class _LedgerHero extends StatelessWidget {
  const _LedgerHero({required this.orderCount});

  final int orderCount;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.dashboard,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
            ),
            child: Padding(
              padding: EdgeInsets.all(CoreSpacing.md(context)),
              child: Icon(
                Icons.receipt_long_outlined,
                color: scheme.primary,
                size: CoreContentSizes.kpiIcon(context),
              ),
            ),
          ),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.screenCashierOrderHistory,
                  style: CoreTypography.headlineSmall(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  l10n.screenCashierOrderHistoryDesc,
                  style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          _LedgerBadge(
            label: orderCount.toString(),
            color: scheme.primary,
            icon: Icons.point_of_sale_outlined,
          ),
        ],
      ),
    );
  }
}

class _ShiftCloseSummary extends StatelessWidget {
  const _ShiftCloseSummary({required this.orders});

  final List<ModelOrderSummary> orders;

  int get refunds => orders.where((order) => order.statusKey == 'refunded').length;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final paidTotal = orders
        .where((order) => order.statusKey != 'refunded')
        .fold<double>(0, (sum, order) => sum + order.totalJod);
    final refundTotal = orders
        .where((order) => order.statusKey == 'refunded')
        .fold<double>(0, (sum, order) => sum + order.totalJod);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 760;
        final cards = [
          _ShiftSummaryCard(
            label: l10n.cashierShiftTotalRevenue,
            value: UtilityFormatJod.format(paidTotal, suffix: l10n.currencyJod),
            detail: l10n.cashierShiftDelta,
            icon: Icons.payments_outlined,
            color: CoreColors.semanticSuccess,
          ),
          _ShiftSummaryCard(
            label: l10n.cashierOrdersCount,
            value: orders.length.toString(),
            detail: l10n.cashierAverageOrder(
              MockupCatalog.cashierAverageOrderJod.toStringAsFixed(1),
            ),
            icon: Icons.restaurant_menu_outlined,
            color: CoreColors.orderTypeDineIn,
          ),
          _ShiftSummaryCard(
            label: l10n.cashierRefunded,
            value: UtilityFormatJod.format(refundTotal, suffix: l10n.currencyJod),
            detail: '$refunds ${l10n.cashierRefunded}',
            icon: Icons.keyboard_return_outlined,
            color: CoreColors.semanticError,
          ),
        ];

        if (isWide) {
          return Row(
            children: [
              for (var index = 0; index < cards.length; index++) ...[
                Expanded(child: cards[index]),
                if (index != cards.length - 1) SizedBox(width: CoreSpacing.md(context)),
              ],
            ],
          );
        }

        return Column(
          children: [
            for (final card in cards) ...[
              card,
              SizedBox(height: CoreSpacing.sm(context)),
            ],
          ],
        );
      },
    );
  }
}

class _ShiftSummaryCard extends StatelessWidget {
  const _ShiftSummaryCard({
    required this.label,
    required this.value,
    required this.detail,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final String detail;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _IconBubble(icon: icon, color: color),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Text(
                  label,
                  style: CoreTypography.caption(context, scheme.onSurfaceVariant),
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            value,
            style: CoreTypography.headlineSmall(context, scheme.onSurface).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(detail, style: CoreTypography.caption(context, scheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}

class _LedgerFilterRow extends StatelessWidget {
  const _LedgerFilterRow({required this.selectedFilter, required this.onSelected});

  final String selectedFilter;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final filters = [
      _LedgerFilter('all', l10n.cashierAllOrders, Icons.receipt_long_outlined, Theme.of(context).colorScheme.primary),
      _LedgerFilter('dineIn', l10n.orderTypeDineIn, Icons.table_restaurant_outlined, CoreColors.orderTypeDineIn),
      _LedgerFilter('takeaway', l10n.orderTypeTakeaway, Icons.shopping_bag_outlined, CoreColors.orderTypeTakeaway),
      _LedgerFilter('delivery', l10n.orderTypeDelivery, Icons.delivery_dining_outlined, CoreColors.orderTypeDelivery),
      _LedgerFilter('plated', l10n.orderTypePlated, Icons.room_service_outlined, CoreColors.orderTypePlated),
      _LedgerFilter('refunds', l10n.cashierRefunded, Icons.keyboard_return_outlined, CoreColors.semanticError),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final filter in filters) ...[
            _LedgerFilterChip(
              filter: filter,
              selected: selectedFilter == filter.id,
              onTap: () => onSelected(filter.id),
            ),
            SizedBox(width: CoreSpacing.sm(context)),
          ],
        ],
      ),
    );
  }
}

class _LedgerFilter {
  const _LedgerFilter(this.id, this.label, this.icon, this.color);

  final String id;
  final String label;
  final IconData icon;
  final Color color;
}

class _LedgerFilterChip extends StatelessWidget {
  const _LedgerFilterChip({required this.filter, required this.selected, required this.onTap});

  final _LedgerFilter filter;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = selected ? filter.color : scheme.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.withValues(alpha: selected ? 0.16 : 0.08),
          borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
          border: Border.all(color: color.withValues(alpha: 0.24)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: CoreSpacing.md(context),
            vertical: CoreSpacing.sm(context),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(filter.icon, color: color, size: CoreContentSizes.orderTypeIcon(context)),
              SizedBox(width: CoreSpacing.xs(context)),
              Text(
                filter.label,
                style: CoreTypography.caption(context, color).copyWith(fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.actionLabel, required this.onAction});

  final String title;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
        ),
        TextButton.icon(
          onPressed: onAction,
          icon: const Icon(Icons.download_outlined),
          label: Text(actionLabel),
        ),
      ],
    );
  }
}

class _LedgerReceiptCard extends ConsumerWidget {
  const _LedgerReceiptCard({
    required this.order,
    required this.onRefundConfirmed,
  });

  final ModelOrderSummary order;
  final VoidCallback onRefundConfirmed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final color = _typeColor(order.orderType);
    final refunded = order.statusKey == 'refunded';

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      accentColor: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _IconBubble(icon: _typeIcon(order.orderType), color: color),
              SizedBox(width: CoreSpacing.md(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${l10n.orderNumberLabel} #${order.id}',
                      style: CoreTypography.titleMedium(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    Text(
                      '${_typeLabel(l10n, order.orderType)} • ${order.customerLabel}',
                      style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              WidgetsPriceBadge(
                priceLabel: UtilityFormatJod.format(order.totalJod, suffix: l10n.currencyJod),
                compact: true,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.sm(context),
            children: [
              _LedgerBadge(
                label: refunded ? l10n.cashierRefunded : l10n.cashierPaid,
                color: refunded ? CoreColors.semanticError : CoreColors.semanticSuccess,
                icon: refunded ? Icons.keyboard_return_outlined : Icons.check_circle_outline,
              ),
              if (order.isPlated)
                _LedgerBadge(
                  label: l10n.orderTypePlated,
                  color: CoreColors.orderTypePlated,
                  icon: Icons.room_service_outlined,
                ),
              if (order.depositJod > 0)
                _LedgerBadge(
                  label: UtilityFormatJod.format(order.depositJod, suffix: l10n.currencyJod),
                  color: CoreColors.brandGold,
                  icon: Icons.savings_outlined,
                ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Row(
            children: [
              Expanded(
                child: WidgetsAppButton(
                  label: l10n.orderHistoryViewInvoice,
                  onPressed: () => _showReceiptActions(context, order),
                  icon: Icons.print_outlined,
                  variant: WidgetsAppButtonVariant.outline,
                ),
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: WidgetsAppButton(
                  label: l10n.cashierRefunded,
                  onPressed:
                      refunded
                          ? null
                          : () => _confirmRefund(context, order, onRefundConfirmed),
                  icon: Icons.keyboard_return_outlined,
                  variant: WidgetsAppButtonVariant.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showReceiptActions(BuildContext context, ModelOrderSummary order) {
    final l10n = AppLocalizations.of(context)!;
    showDialog<void>(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text('${l10n.orderNumberLabel} #${order.id}'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order.customerLabel),
                SizedBox(height: CoreSpacing.sm(dialogContext)),
                Text(
                  UtilityFormatJod.format(
                    order.totalJod,
                    suffix: l10n.currencyJod,
                  ),
                  style: CoreTypography.titleMedium(
                    dialogContext,
                    Theme.of(dialogContext).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text(l10n.actionCancel),
              ),
              WidgetsAppButton(
                label: l10n.reportsExportCsv,
                onPressed: () async {
                  Navigator.of(dialogContext).pop();
                  final csv = buildCashierOrdersCsv([order]);
                  await downloadTextFile(
                    'cashier-receipt-${order.id}.csv',
                    csv,
                    mimeType: 'text/csv',
                  );
                  if (!context.mounted) return;
                  UtilityMockFeedback.showSuccess(context, l10n.reportsExportCsv);
                },
                variant: WidgetsAppButtonVariant.outline,
              ),
            ],
          ),
    );
  }

  Future<void> _confirmRefund(
    BuildContext context,
    ModelOrderSummary order,
    VoidCallback onRefundConfirmed,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await UtilityMockFeedback.confirm(
      context: context,
      title: l10n.cashierRefunded,
      message: '${l10n.orderNumberLabel} #${order.id}',
      confirmLabel: l10n.cashierRefunded,
      cancelLabel: MaterialLocalizations.of(context).cancelButtonLabel,
      icon: Icons.keyboard_return_outlined,
      confirmVariant: WidgetsAppButtonVariant.secondary,
    );
    if (confirmed && context.mounted) {
      onRefundConfirmed();
      UtilityMockFeedback.showSuccess(context, l10n.cashierRefunded);
      context.push(AppRoutePaths.cashierDepositRefund);
    }
  }

  static Color _typeColor(OrderType type) => switch (type) {
    OrderType.dineIn => CoreColors.orderTypeDineIn,
    OrderType.takeaway => CoreColors.orderTypeTakeaway,
    OrderType.delivery => CoreColors.orderTypeDelivery,
    OrderType.platedDelivery => CoreColors.orderTypePlated,
  };

  static IconData _typeIcon(OrderType type) => switch (type) {
    OrderType.dineIn => Icons.table_restaurant_outlined,
    OrderType.takeaway => Icons.shopping_bag_outlined,
    OrderType.delivery => Icons.delivery_dining_outlined,
    OrderType.platedDelivery => Icons.room_service_outlined,
  };

  static String _typeLabel(AppLocalizations l10n, OrderType type) => switch (type) {
    OrderType.dineIn => l10n.orderTypeDineIn,
    OrderType.takeaway => l10n.orderTypeTakeaway,
    OrderType.delivery => l10n.orderTypeDelivery,
    OrderType.platedDelivery => l10n.orderTypePlated,
  };
}

class _PostponedOrderCard extends StatelessWidget {
  const _PostponedOrderCard({
    required this.order,
    required this.onResume,
  });

  final ModelCashierPostponedOrder order;
  final VoidCallback onResume;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.outlined,
      accentColor: CoreColors.brandOrange,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.pause_circle_outline, color: CoreColors.brandOrange),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Text(
                  '${l10n.orderNumberLabel} #${order.id}',
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
              WidgetsPriceBadge(
                priceLabel: UtilityFormatJod.format(
                  order.totalJod,
                  suffix: l10n.currencyJod,
                ),
                compact: true,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            '${order.cartLines.length} ${l10n.cashierItemsCount} • ${order.reasonKey}',
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.cashierResumeOrder,
            onPressed: onResume,
            icon: Icons.play_arrow_outlined,
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}

class _LedgerBadge extends StatelessWidget {
  const _LedgerBadge({required this.label, required this.color, required this.icon});

  final String label;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
        border: Border.all(color: color.withValues(alpha: 0.24)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: CoreSpacing.sm(context), vertical: CoreSpacing.xs(context)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: CoreContentSizes.orderTypeIcon(context), color: color),
            SizedBox(width: CoreSpacing.xs(context)),
            Text(label, style: CoreTypography.caption(context, color).copyWith(fontWeight: FontWeight.w900)),
          ],
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
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.sm(context)),
        child: Icon(icon, color: color, size: CoreContentSizes.orderTypeIcon(context)),
      ),
    );
  }
}
