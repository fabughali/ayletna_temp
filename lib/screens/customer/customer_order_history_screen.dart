import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:ayletna_restaurant_app/data/models/model_customer_order_history.dart';
import 'package:ayletna_restaurant_app/data/repositories/repository_providers.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/utilities/utility_url_actions.dart';
import 'package:ayletna_restaurant_app/providers/cart_providers.dart';
import 'package:ayletna_restaurant_app/providers/customer_action_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_async_state_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_filter_chip.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_media_panel.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_tag.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_order_invoice_block.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_price_badge.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [OrderHistoryScreen] redesigned around favorite meals and reorders.
class CustomerOrderHistoryScreen extends ConsumerStatefulWidget {
  const CustomerOrderHistoryScreen({super.key});

  @override
  ConsumerState<CustomerOrderHistoryScreen> createState() =>
      _CustomerOrderHistoryScreenState();
}

class _CustomerOrderHistoryScreenState
    extends ConsumerState<CustomerOrderHistoryScreen> {
  var _selectedHistoryFilter = 'last30';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final ordersAsync = ref.watch(customerOrderHistoryProvider);

    return WidgetsScaffoldPage(
      title: l10n.screenOrderHistory,
      child: ordersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, _) => WidgetsAsyncStateCard.error(
              title: l10n.screenOrderHistory,
              message: error.toString(),
              actionLabel: l10n.homeViewAll,
              onAction: () => ref.invalidate(customerOrderHistoryProvider),
            ),
        data: (orders) {
          if (orders.isEmpty) {
            return WidgetsAsyncStateCard.empty(
              title: l10n.screenOrderHistory,
              message: l10n.cartEmptyMessage,
              actionLabel: l10n.guestMenuNav,
              onAction: () => context.push(AppRoutePaths.category),
            );
          }

          final favoriteOrder = orders.first;

          return WidgetsRefreshList(
            onRefresh: () async {
              ref.invalidate(customerOrderHistoryProvider);
              await ref.read(customerOrderHistoryProvider.future);
            },
            child: ListView.builder(
              itemCount: orders.length + 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: CoreSpacing.md(context)),
                      WidgetsPageHeader(
                        title: l10n.screenOrderHistory,
                        subtitle: l10n.orderHistorySubtitle,
                      ),
                      _HistoryHero(
                        selectedFilter: _selectedHistoryFilter,
                        onSelected:
                            (filter) => setState(
                              () => _selectedHistoryFilter = filter,
                            ),
                      ),
                      SizedBox(height: CoreSpacing.lg(context)),
                      _FavoriteMealCard(order: favoriteOrder),
                      SizedBox(height: CoreSpacing.lg(context)),
                      _WarmStatsCard(orders: orders),
                      SizedBox(height: CoreSpacing.lg(context)),
                      WidgetsSectionHeader(title: l10n.orderHistoryTitle),
                      SizedBox(height: CoreSpacing.md(context)),
                    ],
                  );
                }
                if (index == orders.length + 1) {
                  return Column(
                    children: [
                      Center(
                        child: WidgetsAppButton(
                          label: l10n.orderHistoryShowMore,
                          onPressed:
                              () => UtilityMockFeedback.showInfo(
                                context,
                                l10n.orderHistoryLast30Days,
                              ),
                          icon: Icons.keyboard_arrow_down,
                          variant: WidgetsAppButtonVariant.outline,
                        ),
                      ),
                      SizedBox(height: CoreSpacing.xxl(context)),
                    ],
                  );
                }
                final order = orders[index - 1];
                return Padding(
                  padding: EdgeInsets.only(bottom: CoreSpacing.md(context)),
                  child: _OrderHistoryCard(
                    order: order,
                    onViewInvoice: () => _showOrderReceipt(context, order),
                    onViewStatus: () => _showOrderProgress(context, order),
                    onReorder:
                        () => _reorder(
                          context,
                          order,
                          order.isCancelled
                              ? l10n.orderHistoryTryAgain
                              : l10n.orderHistoryReorder,
                        ),
                    onRate: () {
                      ref.read(ratingOrderIdProvider.notifier).state = order.id;
                      ref.read(activeTrackingOrderIdProvider.notifier).state =
                          order.id;
                      context.push(AppRoutePaths.ratingReview);
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> _showOrderReceipt(
    BuildContext context,
    ModelCustomerOrderHistory order,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final detail = await ref.read(checkoutOrderDetailProvider.future);
    if (!context.mounted) return;

    final sumData = orderTicketSumDataFromOrderDetail(
      detail,
      l10n,
      paidTotal: order.totalJod,
    );

    showDialog<void>(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            contentPadding: EdgeInsets.all(CoreSpacing.lg(dialogContext)),
            content: SizedBox(
              width: UtilitySizer.of(context, 420),
              child: WidgetsOrderInvoiceBlock(
                cart: detail.lines,
                sumData: sumData,
                showTitle: true,
                bare: true,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text(l10n.actionCancel),
              ),
            ],
          ),
    );
  }

  void _showOrderProgress(
    BuildContext context,
    ModelCustomerOrderHistory order,
  ) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder:
          (sheetContext) => _OrderProgressSheet(
            order: order,
            onTrackLive: () {
              Navigator.of(sheetContext).pop();
              ref.read(activeTrackingOrderIdProvider.notifier).state = order.id;
              context.push(AppRoutePaths.orderTracking);
            },
            trackLabel: l10n.screenOrderTracking,
          ),
    );
  }

  Future<void> _reorder(
    BuildContext context,
    ModelCustomerOrderHistory order,
    String successLabel,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final lines = await ref
          .read(repositoryOrderProvider)
          .buildReorderLines(order.id);
      ref.read(cartProvider.notifier).replaceAll(lines);
      if (!context.mounted) return;
      UtilityMockFeedback.showSuccess(context, successLabel);
      context.go(AppRoutePaths.cart);
    } catch (error) {
      if (!context.mounted) return;
      UtilityMockFeedback.showError(context, l10n.orderReorderFailed);
    }
  }
}

class _HistoryHero extends StatelessWidget {
  const _HistoryHero({required this.selectedFilter, required this.onSelected});

  final String selectedFilter;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WidgetsFoodMediaPanel(
            height: CoreContentSizes.heroImageHeight(context),
            badge: WidgetsFoodTag(
              label: l10n.orderHistoryWeekendSpecial,
              color: scheme.primary,
            ),
            child: CustomPaint(
              painter: _FoodMemoryPainter(
                color: scheme.primary,
                accent: CoreColors.brandGold,
              ),
              child: Center(
                child: Icon(
                  Icons.favorite_outline,
                  color: scheme.primary,
                  size: CoreContentSizes.categoryMenuImageIcon(context),
                ),
              ),
            ),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Text(
            l10n.orderHistoryTitle,
            style: CoreTypography.headlineLarge(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            l10n.orderHistorySubtitle,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                WidgetsFilterChip(
                  label: l10n.filterAll,
                  icon: Icons.all_inclusive_outlined,
                  selected: selectedFilter == 'all',
                  onSelected: (_) => onSelected('all'),
                ),
                SizedBox(width: CoreSpacing.sm(context)),
                WidgetsFilterChip(
                  label: l10n.orderHistoryLast30Days,
                  icon: Icons.calendar_today_outlined,
                  selected: selectedFilter == 'last30',
                  onSelected: (_) => onSelected('last30'),
                ),
                SizedBox(width: CoreSpacing.sm(context)),
                WidgetsFilterChip(
                  label: l10n.orderHistoryCompleted,
                  icon: Icons.check_circle_outline,
                  selected: selectedFilter == 'completed',
                  onSelected: (_) => onSelected('completed'),
                ),
                SizedBox(width: CoreSpacing.sm(context)),
                WidgetsFilterChip(
                  label: l10n.orderHistoryCancelled,
                  icon: Icons.cancel_outlined,
                  selected: selectedFilter == 'cancelled',
                  onSelected: (_) => onSelected('cancelled'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteMealCard extends StatelessWidget {
  const _FavoriteMealCard({required this.order});

  final ModelCustomerOrderHistory order;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final items = isArabic ? order.itemsAr : order.itemsEn;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: CoreColors.brandGold.withValues(alpha: 0.16),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(CoreSpacing.sm(context)),
                  child: Icon(Icons.star_rounded, color: CoreColors.brandGold),
                ),
              ),
              SizedBox(width: CoreSpacing.md(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.orderHistoryWeekendSpecial,
                      style: CoreTypography.titleMedium(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    Text(
                      l10n.orderHistoryWeekendSubtitle,
                      style: CoreTypography.caption(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Wrap(
            spacing: CoreSpacing.xs(context),
            runSpacing: CoreSpacing.xs(context),
            children: [
              for (final item in items)
                WidgetsFoodTag(label: item, color: scheme.primary),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.orderHistoryReorder,
            onPressed: () {
              UtilityMockFeedback.showSuccess(
                context,
                l10n.orderHistoryReorder,
              );
              context.go(AppRoutePaths.cart);
            },
            icon: Icons.refresh,
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}

class _WarmStatsCard extends StatelessWidget {
  const _WarmStatsCard({required this.orders});

  final List<ModelCustomerOrderHistory> orders;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final totalSpent = orders.fold<double>(
      0,
      (sum, order) => sum + order.totalJod,
    );

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.plain,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.orderHistoryInsights,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Row(
            children: [
              Expanded(
                child: _WarmStatTile(
                  icon: Icons.restaurant_menu_outlined,
                  label: l10n.orderHistoryTotalOrders,
                  value: '${orders.length}',
                  color: scheme.primary,
                ),
              ),
              SizedBox(width: CoreSpacing.md(context)),
              Expanded(
                child: _WarmStatTile(
                  icon: Icons.favorite_outline,
                  label: l10n.orderHistoryTotalSpent,
                  value: UtilityFormatJod.format(
                    totalSpent,
                    suffix: l10n.currencyJod,
                  ),
                  color: CoreColors.brandGold,
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            l10n.orderHistoryQuote,
            textAlign: TextAlign.center,
            style: CoreTypography.caption(
              context,
              scheme.onSurfaceVariant,
            ).copyWith(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}

class _WarmStatTile extends StatelessWidget {
  const _WarmStatTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
        border: Border.all(color: color.withValues(alpha: 0.18)),
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.md(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            SizedBox(height: CoreSpacing.sm(context)),
            Text(
              value,
              style: CoreTypography.titleMedium(
                context,
                scheme.onSurface,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
            SizedBox(height: CoreSpacing.xs(context)),
            Text(
              label,
              style: CoreTypography.caption(context, scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderHistoryCard extends StatelessWidget {
  const _OrderHistoryCard({
    required this.order,
    required this.onViewInvoice,
    required this.onViewStatus,
    required this.onReorder,
    required this.onRate,
  });

  final ModelCustomerOrderHistory order;
  final VoidCallback onViewInvoice;
  final VoidCallback onViewStatus;
  final VoidCallback onReorder;
  final VoidCallback onRate;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final label = isAr ? order.labelAr : order.labelEn;
    final date = isAr ? order.dateAr : order.dateEn;
    final items = isAr ? order.itemsAr : order.itemsEn;
    final meta = isAr ? order.metaAr : order.metaEn;
    final price = UtilityFormatJod.format(
      order.totalJod,
      suffix: l10n.currencyJod,
    );
    final statusColor =
        order.isCancelled
            ? scheme.error
            : order.isActive
            ? scheme.primary
            : CoreColors.semanticSuccess;
    final statusLabel =
        order.isCancelled
            ? l10n.orderHistoryCancelled
            : order.isActive
            ? l10n.orderHistoryActive
            : l10n.orderHistoryCompleted;

    return Opacity(
      opacity: order.isCancelled ? 0.82 : 1,
      child: WidgetsAppCard(
        variant: WidgetsAppCardVariant.form,
        padding: EdgeInsets.all(CoreSpacing.lg(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: scheme.primary.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(CoreSpacing.md(context)),
                    child: Icon(
                      Icons.room_service_outlined,
                      color: scheme.primary,
                    ),
                  ),
                ),
                SizedBox(width: CoreSpacing.md(context)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: CoreTypography.bodyMedium(
                          context,
                          scheme.onSurface,
                        ).copyWith(fontWeight: FontWeight.w900),
                      ),
                      SizedBox(height: CoreSpacing.xs(context)),
                      Text(
                        date,
                        style: CoreTypography.caption(
                          context,
                          scheme.onSurfaceVariant,
                        ),
                      ),
                      if (meta != null) ...[
                        SizedBox(height: CoreSpacing.xs(context)),
                        Text(
                          meta,
                          style: CoreTypography.caption(
                            context,
                            scheme.primary,
                          ).copyWith(fontWeight: FontWeight.w800),
                        ),
                      ],
                    ],
                  ),
                ),
                WidgetsFoodTag(label: statusLabel, color: statusColor),
              ],
            ),
            SizedBox(height: CoreSpacing.md(context)),
            Wrap(
              spacing: CoreSpacing.xs(context),
              runSpacing: CoreSpacing.xs(context),
              children: [
                for (final item in items)
                  WidgetsFoodTag(label: item, color: scheme.onSurfaceVariant),
              ],
            ),
            SizedBox(height: CoreSpacing.md(context)),
            Row(
              children: [
                Expanded(
                  child: WidgetsPriceBadge(priceLabel: price, compact: true),
                ),
                SizedBox(width: CoreSpacing.sm(context)),
                if (order.isActive)
                  WidgetsAppButton(
                    label: l10n.orderHistoryViewStatus,
                    onPressed: onViewStatus,
                    icon: Icons.timeline_outlined,
                    variant: WidgetsAppButtonVariant.secondary,
                  )
                else
                  WidgetsAppButton(
                    label:
                        order.isCancelled
                            ? l10n.orderHistoryNoInvoice
                            : l10n.orderHistoryViewInvoice,
                    onPressed: order.isCancelled ? null : onViewInvoice,
                    icon: Icons.receipt_long_outlined,
                    variant: WidgetsAppButtonVariant.ghost,
                  ),
              ],
            ),
            if (!order.isActive) ...[
              SizedBox(height: CoreSpacing.md(context)),
              WidgetsAppButton(
                label:
                    order.isCancelled
                        ? l10n.orderHistoryTryAgain
                        : l10n.orderHistoryReorder,
                onPressed: onReorder,
                icon:
                    order.isCancelled
                        ? Icons.shopping_cart_outlined
                        : Icons.refresh,
                variant:
                    order.isCancelled
                        ? WidgetsAppButtonVariant.outline
                        : WidgetsAppButtonVariant.primary,
                fullWidth: true,
              ),
            ],
            if (!order.isCancelled && !order.isActive) ...[
              SizedBox(height: CoreSpacing.sm(context)),
              WidgetsAppButton(
                label: l10n.screenRatingReview,
                onPressed: onRate,
                icon: Icons.rate_review_outlined,
                variant: WidgetsAppButtonVariant.outline,
                fullWidth: true,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _OrderProgressSheet extends StatelessWidget {
  const _OrderProgressSheet({
    required this.order,
    required this.onTrackLive,
    required this.trackLabel,
  });

  final ModelCustomerOrderHistory order;
  final VoidCallback onTrackLive;
  final String trackLabel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final steps = _OrderProgressStep.steps(context);
    final currentStepIndex = order.currentStepIndex.clamp(0, steps.length - 1);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        CoreSpacing.lg(context),
        0,
        CoreSpacing.lg(context),
        CoreSpacing.lg(context) + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.orderHistoryProgressTitle,
                        style: CoreTypography.titleMedium(
                          context,
                          scheme.onSurface,
                        ).copyWith(fontWeight: FontWeight.w900),
                      ),
                      SizedBox(height: CoreSpacing.xs(context)),
                      Text(
                        order.id,
                        style: CoreTypography.caption(
                          context,
                          scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                WidgetsIconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icons.close,
                  tooltip: l10n.actionCancel,
                ),
              ],
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            Flexible(
              child: SingleChildScrollView(
                child: _OrderProgressTimeline(
                  steps: steps,
                  currentStepIndex: currentStepIndex,
                  driverPhone: currentStepIndex == 3 ? order.driverPhone : null,
                ),
              ),
            ),
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsAppButton(
              label: trackLabel,
              onPressed: onTrackLive,
              icon: Icons.my_location_outlined,
              fullWidth: true,
            ),
          ],
        ),
      ),
    );
  }
}

enum _OrderProgressPageState { done, current, remaining }

class _OrderProgressStep {
  const _OrderProgressStep({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  static List<_OrderProgressStep> steps(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      _OrderProgressStep(
        icon: Icons.receipt_long_outlined,
        title: l10n.trackingOrderReceived,
        body: l10n.trackingOrderReceivedBody,
      ),
      _OrderProgressStep(
        icon: Icons.soup_kitchen_outlined,
        title: l10n.trackingPreparingKitchen,
        body: l10n.trackingPreparingBody,
      ),
      _OrderProgressStep(
        icon: Icons.verified_outlined,
        title: l10n.trackingQualityAssured,
        body: l10n.trackingQualityBody,
      ),
      _OrderProgressStep(
        icon: Icons.delivery_dining_outlined,
        title: l10n.trackingOnWayTitle,
        body: l10n.trackingOnWayBody,
      ),
      _OrderProgressStep(
        icon: Icons.home_outlined,
        title: l10n.trackingDelivered,
        body: l10n.trackingDeliveredBody,
      ),
    ];
  }
}

class _OrderProgressTimeline extends StatelessWidget {
  const _OrderProgressTimeline({
    required this.steps,
    required this.currentStepIndex,
    this.driverPhone,
  });

  final List<_OrderProgressStep> steps;
  final int currentStepIndex;
  final String? driverPhone;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        children: [
          for (var index = 0; index < steps.length; index++)
            _OrderProgressTimelineRow(
              step: steps[index],
              state: _stateFor(index),
              isLast: index == steps.length - 1,
              driverPhone: index == 3 ? driverPhone : null,
            ),
        ],
      ),
    );
  }

  _OrderProgressPageState _stateFor(int index) {
    if (index < currentStepIndex) return _OrderProgressPageState.done;
    if (index == currentStepIndex) return _OrderProgressPageState.current;
    return _OrderProgressPageState.remaining;
  }
}

class _OrderProgressTimelineRow extends StatelessWidget {
  const _OrderProgressTimelineRow({
    required this.step,
    required this.state,
    required this.isLast,
    this.driverPhone,
  });

  final _OrderProgressStep step;
  final _OrderProgressPageState state;
  final bool isLast;
  final String? driverPhone;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final color = switch (state) {
      _OrderProgressPageState.done => CoreColors.semanticSuccess,
      _OrderProgressPageState.current => scheme.primary,
      _OrderProgressPageState.remaining => scheme.outline,
    };
    final statusLabel = switch (state) {
      _OrderProgressPageState.done => l10n.orderHistoryDoneStep,
      _OrderProgressPageState.current => l10n.orderHistoryCurrentStep,
      _OrderProgressPageState.remaining => l10n.orderHistoryRemainingStep,
    };
    final stepIcon =
        state == _OrderProgressPageState.done ? Icons.check_rounded : step.icon;
    final visibleDriverPhone =
        state == _OrderProgressPageState.current ? driverPhone : null;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: color.withValues(
                    alpha:
                        state == _OrderProgressPageState.remaining
                            ? 0.06
                            : 0.15,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: color.withValues(
                      alpha:
                          state == _OrderProgressPageState.remaining
                              ? 0.42
                              : 0.32,
                    ),
                  ),
                ),
                child: SizedBox.square(
                  dimension: CoreContentSizes.timelineIcon(context),
                  child: Icon(
                    stepIcon,
                    color: color,
                    size: CoreContentSizes.orderTypeIcon(context),
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: EdgeInsets.symmetric(
                      vertical: CoreSpacing.xs(context),
                    ),
                    color: color.withValues(
                      alpha:
                          state == _OrderProgressPageState.remaining
                              ? 0.18
                              : 0.46,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: CoreSpacing.lg(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          step.title,
                          style: CoreTypography.bodyMedium(
                            context,
                            scheme.onSurface,
                          ).copyWith(fontWeight: FontWeight.w900),
                        ),
                      ),
                      SizedBox(width: CoreSpacing.sm(context)),
                      WidgetsFoodTag(label: statusLabel, color: color),
                      if (visibleDriverPhone != null) ...[
                        SizedBox(width: CoreSpacing.xs(context)),
                        Flexible(
                          child: _DriverInlineCall(
                            phoneNumber: visibleDriverPhone,
                            color: color,
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: CoreSpacing.xs(context)),
                  Text(
                    step.body,
                    style: CoreTypography.caption(
                      context,
                      scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DriverInlineCall extends StatelessWidget {
  const _DriverInlineCall({required this.phoneNumber, required this.color});

  final String phoneNumber;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
        border: Border.all(color: color.withValues(alpha: 0.24)),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: CoreSpacing.sm(context),
          end: CoreSpacing.xs(context),
          top: CoreSpacing.xs(context),
          bottom: CoreSpacing.xs(context),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                phoneNumber,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textDirection: TextDirection.ltr,
                style: CoreTypography.caption(
                  context,
                  scheme.onSurface,
                ).copyWith(fontWeight: FontWeight.w900),
              ),
            ),
            SizedBox(width: CoreSpacing.xs(context)),
            Tooltip(
              message: l10n.orderHistoryCallDriver,
              child: InkWell(
                borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
                onTap: () async {
                  final launched = await UtilityUrlActions.launchExternalUri(
                    Uri(scheme: 'tel', path: phoneNumber),
                  );
                  if (!launched && context.mounted) {
                    UtilityMockFeedback.showWarning(context, phoneNumber);
                  }
                },
                child: Icon(Icons.call_outlined, color: color, size: CoreContentSizes.orderTypeIcon(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FoodMemoryPainter extends CustomPainter {
  const _FoodMemoryPainter({required this.color, required this.accent});

  final Color color;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final plate = Paint()..color = color.withValues(alpha: 0.12);
    final rim =
        Paint()
          ..color = color.withValues(alpha: 0.26)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.4;
    final accentPaint = Paint()..color = accent.withValues(alpha: 0.34);

    final center = Offset(size.width * 0.50, size.height * 0.56);
    final radius = size.shortestSide * 0.30;
    canvas.drawCircle(center, radius, plate);
    canvas.drawCircle(center, radius, rim);

    canvas.drawCircle(
      Offset(size.width * 0.39, size.height * 0.48),
      radius * 0.18,
      accentPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.57, size.height * 0.42),
      radius * 0.14,
      accentPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.62, size.height * 0.62),
      radius * 0.16,
      accentPaint,
    );

    final heartPath =
        Path()
          ..moveTo(size.width * 0.50, size.height * 0.70)
          ..cubicTo(
            size.width * 0.33,
            size.height * 0.58,
            size.width * 0.39,
            size.height * 0.44,
            size.width * 0.50,
            size.height * 0.52,
          )
          ..cubicTo(
            size.width * 0.61,
            size.height * 0.44,
            size.width * 0.67,
            size.height * 0.58,
            size.width * 0.50,
            size.height * 0.70,
          );
    canvas.drawPath(heartPath, Paint()..color = color.withValues(alpha: 0.22));
  }

  @override
  bool shouldRepaint(covariant _FoodMemoryPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.accent != accent;
  }
}
