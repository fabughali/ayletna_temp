import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_delivery_return_task.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/delivery_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_ops_glance_chip.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_price_badge.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD DeliveryDashboardScreen — route queue first.
class DeliveryDashboardScreen extends ConsumerWidget {
  const DeliveryDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return WidgetsScaffoldPage(
      title: l10n.screenDeliveryDashboard,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.editProfile),
          icon: Icons.person_outline,
          tooltip: l10n.screenEditProfile,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh:
            () async => UtilityMockFeedback.showSuccess(
              context,
              l10n.deliveryDashboardTitle,
            ),
        child: ListView(
          children: [
            const _RouteHero(),
            SizedBox(height: CoreSpacing.lg(context)),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 940;
                final queue = Column(
                  children: [
                    _SectionHeader(
                      title: l10n.deliveryTasks,
                      subtitle: l10n.deliveryShiftSummary,
                      icon: Icons.route_outlined,
                    ),
                    SizedBox(height: CoreSpacing.md(context)),
                    const _ActiveDeliveryCard(),
                    SizedBox(height: CoreSpacing.md(context)),
                    const _PendingKitchenCard(),
                    SizedBox(height: CoreSpacing.lg(context)),
                    const _RouteMapCard(),
                  ],
                );
                final side = Column(
                  children: [
                    const _ReturnsPreviewCard(),
                    SizedBox(height: CoreSpacing.lg(context)),
                    const _EarningsMiniCard(),
                    SizedBox(height: CoreSpacing.lg(context)),
                    const _DriverActionsCard(),
                  ],
                );

                if (isWide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: queue),
                      SizedBox(width: CoreSpacing.lg(context)),
                      Expanded(flex: 2, child: side),
                    ],
                  );
                }

                return Column(
                  children: [
                    queue,
                    SizedBox(height: CoreSpacing.lg(context)),
                    side,
                  ],
                );
              },
            ),
            SizedBox(height: CoreSpacing.xxl(context)),
          ],
        ),
      ),
    );
  }
}

class _RouteHero extends StatelessWidget {
  const _RouteHero();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.dashboard,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _IconBubble(
                icon: Icons.delivery_dining_outlined,
                color: scheme.primary,
                large: true,
              ),
              SizedBox(width: CoreSpacing.md(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.deliveryDashboardTitle,
                      style: CoreTypography.headlineSmall(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    Text(
                      l10n.deliveryShiftSummary,
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
              _SoftBadge(
                label: l10n.deliveryReadyToGo,
                color: CoreColors.semanticSuccess,
                icon: Icons.check_circle_outline,
              ),
              _SoftBadge(
                label: l10n.deliveryPendingKitchen,
                color: CoreColors.orderTypePlated,
                icon: Icons.soup_kitchen_outlined,
              ),
              _SoftBadge(
                label: l10n.deliveryReturnTasks,
                color: scheme.primary,
                icon: Icons.assignment_return_outlined,
              ),
              _SoftBadge(
                label: l10n.deliveryMilesAway,
                color: scheme.secondary,
                icon: Icons.near_me_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        _IconBubble(icon: icon, color: scheme.primary),
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
                style: CoreTypography.caption(context, scheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActiveDeliveryCard extends ConsumerWidget {
  const _ActiveDeliveryCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final orderId = MockupCatalog.deliveryPickupOrderId;
    final note = ref.watch(deliveryOrderNoteProvider);

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      accentColor: scheme.secondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _IconBubble(
                icon: Icons.location_on_outlined,
                color: scheme.secondary,
              ),
              SizedBox(width: CoreSpacing.md(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.deliveryOrderTitle(orderId),
                      style: CoreTypography.titleMedium(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    Text(
                      l10n.deliveryOrder8842Address,
                      style: CoreTypography.bodyMedium(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              WidgetsPriceBadge(
                priceLabel: UtilityFormatJod.format(
                  MockupCatalog.deliveryPickupOrderTotalJod,
                  suffix: l10n.currencyJod,
                ),
                compact: true,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.sm(context),
            children: [
              WidgetsOpsGlanceChip(
                label: l10n.deliveryReadyToGo,
                color: CoreColors.semanticSuccess,
                icon: Icons.check_circle_outline,
                emphasized: true,
              ),
              WidgetsOpsGlanceChip(
                label: l10n.deliveryMilesAway,
                color: scheme.secondary,
                icon: Icons.near_me_outlined,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _InstructionStrip(
            icon: Icons.door_front_door_outlined,
            text:
                note.isEmpty
                    ? l10n.deliveryOrder8842Note
                    : '${l10n.deliveryOrder8842Note} • $note',
            color: scheme.secondary,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Row(
            children: [
              Expanded(
                child: WidgetsAppButton(
                  label: l10n.deliveryAddNote,
                  onPressed: () => _showAddNoteDialog(context, ref),
                  icon: Icons.note_add_outlined,
                  variant: WidgetsAppButtonVariant.outline,
                ),
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: WidgetsAppButton(
                  label: l10n.deliveryStartDelivery,
                  onPressed: () => context.push(AppRoutePaths.deliveryOrder),
                  icon: Icons.delivery_dining_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showAddNoteDialog(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController(
      text: ref.read(deliveryOrderNoteProvider),
    );
    final saved = await showDialog<bool>(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text(l10n.deliveryAddNote),
            content: WidgetsAppTextField(
              controller: controller,
              label: l10n.deliveryAddNote,
              hintText: l10n.deliveryOrder8842Note,
              maxLines: 3,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(l10n.actionCancel),
              ),
              WidgetsAppButton(
                label: l10n.deliveryAddNote,
                onPressed: () => Navigator.of(dialogContext).pop(true),
              ),
            ],
          ),
    );
    final note = controller.text.trim();
    controller.dispose();
    if (saved == true && context.mounted) {
      ref.read(deliveryOrderNoteProvider.notifier).state = note;
      UtilityMockFeedback.showSuccess(context, l10n.deliveryAddNote);
    }
  }
}

class _PendingKitchenCard extends StatelessWidget {
  const _PendingKitchenCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      accentColor: CoreColors.orderTypePlated,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _IconBubble(
                icon: Icons.soup_kitchen_outlined,
                color: CoreColors.orderTypePlated,
              ),
              SizedBox(width: CoreSpacing.md(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order #8845',
                      style: CoreTypography.titleMedium(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    Text(
                      l10n.deliveryOrder8845Address,
                      style: CoreTypography.bodyMedium(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              WidgetsOpsGlanceChip(
                label: l10n.deliveryPendingKitchen,
                color: CoreColors.orderTypePlated,
                icon: Icons.timer_outlined,
                emphasized: true,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _InstructionStrip(
            icon: Icons.restaurant_menu_outlined,
            text: l10n.deliveryOrder8845Note,
            color: CoreColors.orderTypePlated,
          ),
        ],
      ),
    );
  }
}

class _RouteMapCard extends StatelessWidget {
  const _RouteMapCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.dashboard,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _IconBubble(icon: Icons.map_outlined, color: scheme.primary),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Text(
                  l10n.deliveryNextStop,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
              _SoftBadge(
                label: l10n.deliveryMilesAway,
                color: scheme.secondary,
                icon: Icons.near_me_outlined,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          ClipRRect(
            borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
            child: SizedBox(
              height: CoreContentSizes.heroImageHeight(context) * 0.62,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: AlignmentDirectional.topStart,
                    end: AlignmentDirectional.bottomEnd,
                    colors: [
                      scheme.primaryContainer.withValues(alpha: 0.60),
                      scheme.surfaceContainerHighest,
                      scheme.secondaryContainer.withValues(alpha: 0.50),
                    ],
                  ),
                ),
                child: CustomPaint(
                  painter: _RoutePainter(
                    routeColor: scheme.primary,
                    pinColor: scheme.secondary,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _InstructionStrip(
            icon: Icons.navigation_outlined,
            text: '${l10n.deliveryCurrentDirection}: ${l10n.deliveryNorthPark}',
            color: scheme.primary,
          ),
        ],
      ),
    );
  }
}

class _ReturnsPreviewCard extends ConsumerWidget {
  const _ReturnsPreviewCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tasks = ref.watch(deliveryReturnTasksProvider);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      accentColor: scheme.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _IconBubble(
                icon: Icons.assignment_return_outlined,
                color: scheme.primary,
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.deliveryReturnTasks,
                      style: CoreTypography.titleMedium(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    Text(
                      l10n.deliveryReturnsContext,
                      style: CoreTypography.caption(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              _SoftBadge(
                label: tasks.length.toString(),
                color: scheme.primary,
                icon: Icons.inventory_2_outlined,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          for (final task in tasks.take(2)) ...[
            _ReturnTaskPreview(task: task, isAr: isAr),
            SizedBox(height: CoreSpacing.sm(context)),
          ],
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppButton(
            label: l10n.deliveryMarkCollected,
            onPressed: () => context.push(AppRoutePaths.platedReturnTask),
            icon: Icons.inventory_2_outlined,
            variant: WidgetsAppButtonVariant.secondary,
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}

class _ReturnTaskPreview extends StatelessWidget {
  const _ReturnTaskPreview({required this.task, required this.isAr});

  final ModelDeliveryReturnTask task;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = _taskColor(context, task.colorKey);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
        border: Border.all(color: color.withValues(alpha: 0.18)),
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.sm(context)),
        child: Row(
          children: [
            _IconBubble(icon: _taskIcon(task.iconKey), color: color),
            SizedBox(width: CoreSpacing.sm(context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isAr ? task.nameAr : task.nameEn,
                    style: CoreTypography.bodyMedium(
                      context,
                      scheme.onSurface,
                    ).copyWith(fontWeight: FontWeight.w900),
                  ),
                  Text(
                    isAr ? task.itemSummaryAr : task.itemSummaryEn,
                    style: CoreTypography.caption(
                      context,
                      scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            _SoftBadge(
              label: isAr ? task.statusAr : task.statusEn,
              color: color,
              icon: Icons.schedule_outlined,
            ),
          ],
        ),
      ),
    );
  }

  Color _taskColor(BuildContext context, String key) {
    return switch (key) {
      'error' => CoreColors.semanticError,
      'success' => CoreColors.semanticSuccess,
      'primary' => Theme.of(context).colorScheme.primary,
      _ => Theme.of(context).colorScheme.secondary,
    };
  }

  IconData _taskIcon(String key) {
    return switch (key) {
      'receipt' => Icons.receipt_long_outlined,
      'delivery' => Icons.delivery_dining_outlined,
      'kitchen' => Icons.soup_kitchen_outlined,
      _ => Icons.assignment_return_outlined,
    };
  }
}

class _EarningsMiniCard extends ConsumerWidget {
  const _EarningsMiniCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final earnings = ref.watch(deliveryShiftEarningsProvider);
    final runs = ref.watch(deliverySessionRunsProvider);
    final sessionTotal = runs.fold<double>(0, (sum, run) => sum + run.totalJod);

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.dashboard,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _IconBubble(
                icon: Icons.account_balance_wallet_outlined,
                color: scheme.secondary,
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Text(
                  l10n.deliveryShiftEarnings,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            UtilityFormatJod.format(
              earnings,
              suffix: l10n.currencyJod,
            ),
            style: CoreTypography.headlineSmall(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            l10n.deliveryIncludesTips(
              UtilityFormatJod.format(
                MockupCatalog.deliveryShiftTipsJod,
                suffix: l10n.currencyJod,
              ),
            ),
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.deliveryViewHistory,
            onPressed: () => _showHistoryDialog(context, ref, sessionTotal, runs.length),
            icon: Icons.history_outlined,
            variant: WidgetsAppButtonVariant.outline,
            fullWidth: true,
          ),
        ],
      ),
    );
  }

  void _showHistoryDialog(
    BuildContext context,
    WidgetRef ref,
    double sessionTotal,
    int sessionCount,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final refunds = ref.read(deliveryReturnStatsProvider);
    showDialog<void>(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text(l10n.deliveryHistoryTitle),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.deliveryHistoryTotalEarnings),
                Text(
                  UtilityFormatJod.format(
                    ref.read(deliveryShiftEarningsProvider),
                    suffix: l10n.currencyJod,
                  ),
                  style: CoreTypography.titleMedium(
                    dialogContext,
                    Theme.of(dialogContext).colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: CoreSpacing.sm(dialogContext)),
                Text(
                  '${l10n.deliveryHistoryCompleted}: ${MockupCatalog.deliveryHistoryCompletedCount + sessionCount}',
                ),
                Text(
                  '${l10n.deliveryShiftEarnings}: ${UtilityFormatJod.format(sessionTotal, suffix: l10n.currencyJod)}',
                ),
                if (refunds > 0)
                  Text(
                    '${l10n.deliveryDepositsRefunded}: ${UtilityFormatJod.format(refunds, suffix: l10n.currencyJod)}',
                  ),
              ],
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
}

class _DriverActionsCard extends StatelessWidget {
  const _DriverActionsCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.plain,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WidgetsAppButton(
            label: l10n.screenDeliveryOrder,
            onPressed: () => context.push(AppRoutePaths.deliveryOrder),
            icon: Icons.assignment_outlined,
            fullWidth: true,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppButton(
            label: l10n.deliveryReturnTasks,
            onPressed: () => context.push(AppRoutePaths.platedReturnTask),
            icon: Icons.assignment_return_outlined,
            variant: WidgetsAppButtonVariant.outline,
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}

class _InstructionStrip extends StatelessWidget {
  const _InstructionStrip({
    required this.icon,
    required this.text,
    required this.color,
  });

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
        border: Border.all(color: color.withValues(alpha: 0.18)),
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.sm(context)),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: CoreContentSizes.orderTypeIcon(context),
            ),
            SizedBox(width: CoreSpacing.sm(context)),
            Expanded(
              child: Text(
                text,
                style: CoreTypography.bodyMedium(context, scheme.onSurface),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SoftBadge extends StatelessWidget {
  const _SoftBadge({
    required this.label,
    required this.color,
    required this.icon,
  });

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
        padding: EdgeInsets.symmetric(
          horizontal: CoreSpacing.sm(context),
          vertical: CoreSpacing.xs(context),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: CoreContentSizes.orderTypeIcon(context),
              color: color,
            ),
            SizedBox(width: CoreSpacing.xs(context)),
            Text(
              label,
              style: CoreTypography.caption(
                context,
                color,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconBubble extends StatelessWidget {
  const _IconBubble({
    required this.icon,
    required this.color,
    this.large = false,
  });

  final IconData icon;
  final Color color;
  final bool large;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.sm(context)),
        child: Icon(
          icon,
          color: color,
          size:
              large
                  ? CoreContentSizes.logoCard(context) * 0.52
                  : CoreContentSizes.orderTypeIcon(context),
        ),
      ),
    );
  }
}

class _RoutePainter extends CustomPainter {
  const _RoutePainter({required this.routeColor, required this.pinColor});

  final Color routeColor;
  final Color pinColor;

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint =
        Paint()
          ..color = routeColor.withValues(alpha: 0.13)
          ..strokeWidth = 1;
    for (var i = 1; i < 8; i++) {
      final x = size.width * i / 8;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (var i = 1; i < 5; i++) {
      final y = size.height * i / 5;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final routePaint =
        Paint()
          ..color = routeColor
          ..strokeWidth = 4
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;
    final path =
        Path()
          ..moveTo(size.width * 0.14, size.height * 0.72)
          ..quadraticBezierTo(
            size.width * 0.42,
            size.height * 0.42,
            size.width * 0.62,
            size.height * 0.50,
          )
          ..quadraticBezierTo(
            size.width * 0.78,
            size.height * 0.57,
            size.width * 0.88,
            size.height * 0.22,
          );
    canvas.drawPath(path, routePaint);

    final pinPaint = Paint()..color = pinColor;
    for (final offset in [
      Offset(size.width * 0.18, size.height * 0.68),
      Offset(size.width * 0.55, size.height * 0.48),
      Offset(size.width * 0.84, size.height * 0.26),
    ]) {
      canvas.drawCircle(offset, 7, pinPaint);
      canvas.drawCircle(offset, 3, Paint()..color = CoreColors.surfaceLight);
    }
  }

  @override
  bool shouldRepaint(covariant _RoutePainter oldDelegate) {
    return oldDelegate.routeColor != routeColor ||
        oldDelegate.pinColor != pinColor;
  }
}
