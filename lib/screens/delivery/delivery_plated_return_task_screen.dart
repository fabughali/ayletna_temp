import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_delivery_return_task.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/delivery_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/utilities/utility_url_actions.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_async_state_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD PlatedReturnTaskScreen — tray/crate collection route queue.
class DeliveryPlatedReturnTaskScreen extends ConsumerWidget {
  const DeliveryPlatedReturnTaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tasks = ref.watch(deliveryReturnTasksProvider);

    return WidgetsScaffoldPage(
      title: l10n.screenPlatedReturnTask,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.go(AppRoutePaths.delivery),
          icon: Icons.delivery_dining_outlined,
          tooltip: l10n.screenDeliveryDashboard,
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
        onRefresh:
            () async => UtilityMockFeedback.showSuccess(
              context,
              l10n.platedPickupsTitle,
            ),
        child: ListView(
          children: [
            _ReturnsHero(taskCount: tasks.length),
            SizedBox(height: CoreSpacing.lg(context)),
            if (tasks.isEmpty)
              WidgetsAsyncStateCard.empty(
                title: l10n.deliveryReturnTasks,
                message: l10n.deliveryDepositsRefunded,
                actionLabel: l10n.screenDeliveryDashboard,
                onAction: () => context.go(AppRoutePaths.delivery),
              )
            else
              for (final task in tasks) ...[
                _ReturnRouteCard(task: task),
                SizedBox(height: CoreSpacing.md(context)),
              ],
            _SustainabilityCard(),
            SizedBox(height: CoreSpacing.xxl(context)),
          ],
        ),
      ),
    );
  }
}

class _ReturnsHero extends StatelessWidget {
  const _ReturnsHero({required this.taskCount});

  final int taskCount;

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
                icon: Icons.inventory_2_outlined,
                color: scheme.primary,
                large: true,
              ),
              SizedBox(width: CoreSpacing.md(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.platedPickupsTitle,
                      style: CoreTypography.headlineSmall(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    Text(
                      l10n.platedPickupsSubtitle,
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
                label: '$taskCount ${l10n.deliveryReturnTasks}',
                color: scheme.primary,
                icon: Icons.route_outlined,
              ),
              _SoftBadge(
                label: l10n.deliveryActiveCollections,
                color: CoreColors.semanticSuccess,
                icon: Icons.assignment_turned_in_outlined,
              ),
              _SoftBadge(
                label: l10n.deliveryDepositsRefunded,
                color: CoreColors.brandGold,
                icon: Icons.savings_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReturnRouteCard extends ConsumerWidget {
  const _ReturnRouteCard({required this.task});

  final ModelDeliveryReturnTask task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final name = isAr ? task.nameAr : task.nameEn;
    final address = isAr ? task.addressAr : task.addressEn;
    final status = isAr ? task.statusAr : task.statusEn;
    final itemSummary = isAr ? task.itemSummaryAr : task.itemSummaryEn;
    final color = _taskColor(context, task.colorKey);

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      accentColor: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _IconBubble(icon: _taskIcon(task.iconKey), color: color),
              SizedBox(width: CoreSpacing.md(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: CoreTypography.titleMedium(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    Text(
                      address,
                      style: CoreTypography.bodyMedium(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              _SoftBadge(
                label: status,
                color: color,
                icon:
                    task.mapFilled
                        ? Icons.warning_amber_rounded
                        : Icons.schedule_outlined,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _ConditionStrip(
            icon: Icons.inventory_2_outlined,
            label: l10n.platedReturnItems,
            value: itemSummary,
            color: color,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          _ConditionStrip(
            icon: Icons.near_me_outlined,
            label: l10n.deliveryNextStop,
            value:
                task.mapFilled
                    ? l10n.deliveryMilesAway
                    : l10n.platedPickupScheduled,
            color: scheme.secondary,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Row(
            children: [
              Expanded(
                child: WidgetsAppButton(
                  label: l10n.platedOpenMaps,
                  onPressed: () => _openMaps(context, address),
                  icon:
                      task.mapFilled
                          ? Icons.map_outlined
                          : Icons.navigation_outlined,
                  variant: WidgetsAppButtonVariant.outline,
                ),
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: WidgetsAppButton(
                  label: l10n.platedConfirmCollection,
                  onPressed: () {
                    ref.read(deliveryActiveReturnProvider.notifier).beginTask(task);
                    UtilityMockFeedback.showSuccess(
                      context,
                      l10n.platedConfirmCollection,
                    );
                    context.push(AppRoutePaths.platedReturnProcess);
                  },
                  icon: Icons.inventory_2_outlined,
                  variant: WidgetsAppButtonVariant.success,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _openMaps(BuildContext context, String address) async {
    final l10n = AppLocalizations.of(context)!;
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}',
    );
    final launched = await UtilityUrlActions.launchExternalUri(uri);
    if (!context.mounted) return;
    if (launched) {
      UtilityMockFeedback.showSuccess(context, l10n.platedOpenMaps);
    } else {
      UtilityMockFeedback.showError(context, l10n.platedOpenMaps);
    }
  }

  Color _taskColor(BuildContext context, String key) {
    return switch (key) {
      'error' => CoreColors.semanticError,
      'success' => CoreColors.semanticSuccess,
      _ => Theme.of(context).colorScheme.primary,
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

class _SustainabilityCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      accentColor: scheme.primary,
      child: Row(
        children: [
          _IconBubble(icon: Icons.eco_outlined, color: scheme.primary),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.platedSustainableReturns,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  l10n.platedWasteReduced,
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
    );
  }
}

class _ConditionStrip extends StatelessWidget {
  const _ConditionStrip({
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: CoreTypography.caption(
                      context,
                      scheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    value,
                    style: CoreTypography.bodyMedium(
                      context,
                      scheme.onSurface,
                    ).copyWith(fontWeight: FontWeight.w800),
                  ),
                ],
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
