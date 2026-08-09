import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_kitchen_prep_item.dart';
import 'package:ayletna_restaurant_app/data/models/model_kitchen_ready_order.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/kitchen_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_demo_actions.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_bubble.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_ops_glance_chip.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD KitchenDashboardScreen — kitchen pass with station lanes.
class KitchenDashboardScreen extends ConsumerWidget {
  const KitchenDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final board = ref.watch(kitchenBoardProvider);
    final readyOrders = board.readyOrders;
    final delayedOrders = board.delayedOrders;

    return WidgetsScaffoldPage(
      title: l10n.screenKitchenDashboard,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.kitchenPrep),
          icon: Icons.checklist_rtl_outlined,
          tooltip: l10n.screenOrderPrep,
        ),
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(kitchenBoardProvider);
          UtilityMockFeedback.showInfo(context, l10n.opsKitchenBoardRefreshed);
        },
        child: Builder(
          builder: (context) {
            final children = <Widget>[
            _KitchenPassHero(
              preparingCount: board.preparingCount,
              readyCount: readyOrders.length,
              delayedCount: delayedOrders.length,
              averageReadyTime: board.averageReadyTimeLabel,
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 980;
                final preparingChildren =
                    board.activePrepOrderId == null
                        ? <Widget>[]
                        : [const _PreparingTicket()];
                final lanes = [
                  _PassLane(
                    title: l10n.kitchenPreparing,
                    subtitle: l10n.prepKitchenNotes,
                    color: Theme.of(context).colorScheme.tertiary,
                    icon: Icons.soup_kitchen_outlined,
                    children: preparingChildren,
                  ),
                  _PassLane(
                    title: l10n.kitchenReadyHandover,
                    subtitle: l10n.kitchenReadyMinutes,
                    color: CoreColors.semanticSuccess,
                    icon: Icons.done_all_outlined,
                    children: [
                      for (final order in readyOrders)
                        _ReadyPassTicket(order: order),
                    ],
                  ),
                  _PassLane(
                    title: l10n.kitchenDelayed,
                    subtitle: l10n.prepUrgent,
                    color: CoreColors.semanticError,
                    icon: Icons.warning_amber_rounded,
                    children: [
                      for (final order in delayedOrders)
                        _ReadyPassTicket(order: order),
                    ],
                  ),
                ];

                if (isWide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var index = 0; index < lanes.length; index++) ...[
                        Expanded(child: lanes[index]),
                        if (index != lanes.length - 1)
                          SizedBox(width: CoreSpacing.md(context)),
                      ],
                    ],
                  );
                }

                return Column(
                  children: [
                    for (final lane in lanes) ...[
                      lane,
                      SizedBox(height: CoreSpacing.lg(context)),
                    ],
                  ],
                );
              },
            ),
            SizedBox(height: CoreSpacing.xxl(context)),
            ];
            return ListView.builder(
              itemCount: children.length,
              itemBuilder: (context, index) => children[index],
            );
          },
        ),
      ),
    );
  }
}

class _KitchenPassHero extends StatelessWidget {
  const _KitchenPassHero({
    required this.preparingCount,
    required this.readyCount,
    required this.delayedCount,
    required this.averageReadyTime,
  });

  final int preparingCount;
  final int readyCount;
  final int delayedCount;
  final String averageReadyTime;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.plain,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetsIconBubble(borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)), 
                icon: Icons.local_fire_department_outlined,
                color: scheme.tertiary,
                size: CoreContentSizes.emptyStateIcon(context), iconSize: CoreContentSizes.kpiIcon(context),
              ),
              SizedBox(width: CoreSpacing.md(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.kitchenView,
                      style: CoreTypography.headlineSmall(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    Text(
                      l10n.screenKitchenDashboardDesc,
                      style: CoreTypography.bodyMedium(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.sm(context),
            children: [
              WidgetsOpsGlanceChip(
                label: l10n.kitchenStatusWithCount(
                  l10n.kitchenPreparing,
                  preparingCount,
                ),
                color: scheme.tertiary,
                icon: Icons.soup_kitchen_outlined,
                emphasized: preparingCount > 0,
              ),
              WidgetsOpsGlanceChip(
                label: l10n.kitchenStatusWithCount(
                  l10n.orderStatusReady,
                  readyCount,
                ),
                color: CoreColors.semanticSuccess,
                icon: Icons.done_all_outlined,
                emphasized: readyCount > 0,
              ),
              WidgetsOpsGlanceChip(
                label: l10n.kitchenStatusWithCount(
                  l10n.kitchenDelayed,
                  delayedCount,
                ),
                color: CoreColors.semanticError,
                icon: Icons.warning_amber_rounded,
                emphasized: delayedCount > 0,
              ),
              WidgetsOpsGlanceChip(
                label: '${l10n.kitchenAverageReadyTime}: $averageReadyTime min',
                color: CoreColors.orderTypeTakeaway,
                icon: Icons.timer_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PassLane extends StatelessWidget {
  const _PassLane({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
    required this.children,
  });

  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.plain,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      accentColor: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              WidgetsIconBubble(borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)), icon: icon, color: color),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: CoreTypography.titleMedium(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    Text(
                      subtitle,
                      style: CoreTypography.caption(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              WidgetsOpsGlanceChip(
                label: children.length.toString(),
                color: color,
                icon: Icons.confirmation_number_outlined,
                emphasized: children.isNotEmpty,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          if (children.isEmpty)
            _EmptyLane(color: color)
          else
            for (final child in children) ...[
              child,
              SizedBox(height: CoreSpacing.sm(context)),
            ],
        ],
      ),
    );
  }
}

class _PreparingTicket extends ConsumerWidget {
  const _PreparingTicket();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final color = scheme.tertiary;
    final board = ref.watch(kitchenBoardProvider);
    final orderId = board.activePrepOrderId ?? '1086';
    final items = board.prepItems;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.plain,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      accentColor: color,
      onTap: () => context.push(AppRoutePaths.kitchenPrep),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.prepTitle(orderId),
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
              WidgetsOpsGlanceChip(
                label: l10n.prepPlated,
                color: CoreColors.orderTypePlated,
                icon: Icons.room_service_outlined,
                emphasized: true,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            '${l10n.prepTable14} • ${l10n.prepReceived}',
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsOpsGlanceChip(
            label: l10n.kitchenReadyTimer('8'),
            color: CoreColors.semanticWarning,
            icon: Icons.timer_outlined,
            emphasized: true,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          for (final entry in items.indexed) ...[
            _PrepItemLine(
              item: entry.$2,
              isAr: isAr,
              checked: board.checkedPrepIndexes.contains(entry.$1),
            ),
            SizedBox(height: CoreSpacing.xs(context)),
          ],
          SizedBox(height: CoreSpacing.md(context)),
          DecoratedBox(
            decoration: BoxDecoration(
              color: CoreColors.semanticError.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
              border: Border.all(
                color: CoreColors.semanticError.withValues(alpha: 0.22),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(CoreSpacing.sm(context)),
              child: Row(
                children: [
                  Icon(
                    Icons.priority_high_outlined,
                    color: CoreColors.semanticError,
                    size: CoreContentSizes.orderTypeIcon(context),
                  ),
                  SizedBox(width: CoreSpacing.sm(context)),
                  Expanded(
                    child: Text(
                      l10n.prepKitchenNoteBody,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: CoreTypography.caption(context, scheme.onSurface),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.prepProgress,
            onPressed: () => context.push(AppRoutePaths.kitchenPrep),
            icon: Icons.checklist_rtl_outlined,
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}

class _ReadyPassTicket extends ConsumerWidget {
  const _ReadyPassTicket({required this.order});

  final ModelKitchenReadyOrder order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final color = _orderColor(context, order.typeKey, order.isDelayed);
    final destination = isAr ? order.destinationAr : order.destinationEn;
    final badge = isAr ? order.badgeAr : order.badgeEn;
    final actionLabel = isAr ? order.actionLabelAr : order.actionLabelEn;
    final items = isAr ? order.itemsAr : order.itemsEn;
    final note = isAr ? order.noteAr : order.noteEn;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.plain,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      accentColor: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destination,
                      style: CoreTypography.titleMedium(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    Text(
                      l10n.kitchenOrd(order.id),
                      style: CoreTypography.bodyMedium(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              WidgetsOpsGlanceChip(
                label: badge,
                color: color,
                icon: _typeIcon(order.typeKey),
                emphasized: true,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsOpsGlanceChip(
            label: l10n.kitchenReadyTimer(order.readyTime),
            color:
                order.isDelayed
                    ? CoreColors.semanticError
                    : CoreColors.semanticSuccess,
            icon:
                order.isDelayed
                    ? Icons.warning_amber_rounded
                    : Icons.timer_outlined,
            emphasized: true,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          for (final item in items) ...[
            _ReadyItemLine(item: item, color: color),
            SizedBox(height: CoreSpacing.xs(context)),
          ],
          if (note != null) ...[
            SizedBox(height: CoreSpacing.sm(context)),
            _KitchenNote(note: note),
          ],
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: actionLabel,
            onPressed: () {
              ref.read(kitchenBoardProvider.notifier).handoverOrder(order.id);
              UtilityDemoActions.complete(context, successMessage: actionLabel);
            },
            icon: order.actionIcon,
            fullWidth: true,
          ),
        ],
      ),
    );
  }

  Color _orderColor(BuildContext context, String key, bool delayed) {
    if (delayed) return CoreColors.semanticError;
    return switch (key) {
      'dine_in' => CoreColors.orderTypeDineIn,
      'plated' => CoreColors.orderTypePlated,
      'takeaway' => CoreColors.orderTypeTakeaway,
      'delivery' => CoreColors.orderTypeDelivery,
      _ => Theme.of(context).colorScheme.primary,
    };
  }

  IconData _typeIcon(String key) {
    return switch (key) {
      'dine_in' => Icons.table_restaurant_outlined,
      'plated' => Icons.room_service_outlined,
      'takeaway' => Icons.shopping_bag_outlined,
      'delivery' => Icons.delivery_dining_outlined,
      _ => Icons.restaurant_menu_outlined,
    };
  }
}

class _PrepItemLine extends StatelessWidget {
  const _PrepItemLine({
    required this.item,
    required this.isAr,
    this.checked = false,
  });

  final ModelKitchenPrepItem item;
  final bool isAr;
  final bool checked;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final warning = isAr ? item.warningAr : item.warningEn;
    final lineColor = checked ? CoreColors.semanticSuccess : scheme.tertiary;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.54),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
        border:
            checked
                ? Border.all(
                  color: CoreColors.semanticSuccess.withValues(alpha: 0.24),
                )
                : null,
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.sm(context)),
        child: Row(
          children: [
            _QuantityMark(quantity: item.quantity, color: lineColor),
            SizedBox(width: CoreSpacing.sm(context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isAr ? item.nameAr : item.nameEn,
                    style: CoreTypography.bodyMedium(
                      context,
                      scheme.onSurface,
                    ).copyWith(fontWeight: FontWeight.w900),
                  ),
                  Text(
                    isAr ? item.specsAr : item.specsEn,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: CoreTypography.caption(
                      context,
                      scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (warning != null)
              WidgetsOpsGlanceChip(
                label: warning,
                color: CoreColors.semanticError,
                icon: Icons.warning_amber_rounded,
                emphasized: true,
              ),
          ],
        ),
      ),
    );
  }
}

class _ReadyItemLine extends StatelessWidget {
  const _ReadyItemLine({required this.item, required this.color});

  final ModelKitchenReadyItem item;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.54),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.sm(context)),
        child: Row(
          children: [
            _QuantityMark(quantity: item.quantity, color: color),
            SizedBox(width: CoreSpacing.sm(context)),
            Expanded(
              child: Text(
                item.name,
                style: CoreTypography.bodyMedium(
                  context,
                  scheme.onSurface,
                ).copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            Icon(
              Icons.check_circle_outline,
              color: CoreColors.semanticSuccess,
              size: CoreContentSizes.buttonIcon(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _KitchenNote extends StatelessWidget {
  const _KitchenNote({required this.note});

  final String note;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: CoreColors.semanticError.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
        border: Border.all(
          color: CoreColors.semanticError.withValues(alpha: 0.22),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.sm(context)),
        child: Row(
          children: [
            Icon(
              Icons.priority_high_outlined,
              color: CoreColors.semanticError,
              size: CoreContentSizes.orderTypeIcon(context),
            ),
            SizedBox(width: CoreSpacing.sm(context)),
            Expanded(
              child: Text(
                note,
                style: CoreTypography.caption(context, scheme.onSurface),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyLane extends StatelessWidget {
  const _EmptyLane({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: CoreSpacing.xl(context)),
      child: Column(
        children: [
          Icon(
            Icons.done_outline,
            color: color,
            size: CoreContentSizes.emptyStateIcon(context),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            AppLocalizations.of(context)!.kitchenAllActive,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _QuantityMark extends StatelessWidget {
  const _QuantityMark({required this.quantity, required this.color});

  final int quantity;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: 0.24)),
      ),
      child: SizedBox.square(
        dimension:
            CoreContentSizes.buttonIcon(context) + CoreSpacing.sm(context),
        child: Center(
          child: Text(
            quantity.toString(),
            style: CoreTypography.caption(
              context,
              color,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}


