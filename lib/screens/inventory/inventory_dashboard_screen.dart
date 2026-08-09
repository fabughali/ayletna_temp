import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_inventory_mock.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/inventory_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_file_download.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_demo_actions.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/utilities/utility_report_export.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_bubble.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_soft_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD InventoryDashboardScreen — ingredient freshness and storage zones.
class InventoryDashboardScreen extends ConsumerWidget {
  const InventoryDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final query = ref.watch(inventorySearchQueryProvider).trim().toLowerCase();
    final alerts =
        MockupCatalog.inventoryAlerts.where((alert) {
          if (query.isEmpty) return true;
          return alert.nameEn.toLowerCase().contains(query) ||
              alert.nameAr.contains(query) ||
              alert.categoryEn.toLowerCase().contains(query);
        }).toList();
    final levels =
        MockupCatalog.inventoryLevels.where((level) {
          if (query.isEmpty) return true;
          return level.nameEn.toLowerCase().contains(query) ||
              level.nameAr.contains(query);
        }).toList();

    return WidgetsScaffoldPage(
      title: l10n.screenInventoryDashboard,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh:
            () async => UtilityMockFeedback.showInfo(
              context,
              l10n.screenInventoryDashboard,
            ),
        child: ListView(
          children: [
            const _InventoryHero(),
            SizedBox(height: CoreSpacing.lg(context)),
            const _InventoryActions(),
            SizedBox(height: CoreSpacing.lg(context)),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 980;
                final freshness = Column(
                  children: [
                    _FreshnessAlertBoard(alerts: alerts),
                    SizedBox(height: CoreSpacing.lg(context)),
                    const _DishImpactCard(),
                  ],
                );
                final zones = Column(
                  children: [
                    const _StorageZonesCard(),
                    SizedBox(height: CoreSpacing.lg(context)),
                    const _SupplierArrivalCard(),
                  ],
                );

                if (isWide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: freshness),
                      SizedBox(width: CoreSpacing.lg(context)),
                      Expanded(flex: 2, child: zones),
                    ],
                  );
                }

                return Column(
                  children: [
                    freshness,
                    SizedBox(height: CoreSpacing.lg(context)),
                    zones,
                  ],
                );
              },
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            _IngredientLevelsBoard(levels: levels),
            SizedBox(height: CoreSpacing.lg(context)),
            const _WastageBoard(),
            SizedBox(height: CoreSpacing.xxl(context)),
          ],
        ),
      ),
    );
  }
}

class _InventoryHero extends StatelessWidget {
  const _InventoryHero();

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
              WidgetsIconBubble(borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)), 
                icon: Icons.inventory_2_outlined,
                color: scheme.primary,
                size: CoreContentSizes.emptyStateIcon(context), iconSize: CoreContentSizes.kpiIcon(context),
              ),
              SizedBox(width: CoreSpacing.md(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.screenInventoryDashboard,
                      style: CoreTypography.headlineSmall(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    Text(
                      l10n.screenInventoryDashboardDesc,
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
              WidgetsSoftBadge(
                label: l10n.inventoryLowStockAlerts,
                color: CoreColors.semanticError,
                icon: Icons.warning_amber_rounded,
              ),
              WidgetsSoftBadge(
                label: l10n.inventoryShipmentsToday,
                color: CoreColors.orderTypeTakeaway,
                icon: Icons.local_shipping_outlined,
              ),
              WidgetsSoftBadge(
                label: l10n.inventoryStorageHealth,
                color: CoreColors.semanticSuccess,
                icon: Icons.thermostat_outlined,
              ),
              WidgetsSoftBadge(
                label: l10n.inventoryValueDelta,
                color: CoreColors.brandGold,
                icon: Icons.trending_up_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InventoryActions extends ConsumerWidget {
  const _InventoryActions();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.plain,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        children: [
          WidgetsAppTextField(
            label: l10n.inventorySearchHint,
            hintText: l10n.inventorySearchHint,
            prefixIcon: Icons.search,
            onChanged:
                (value) =>
                    ref.read(inventorySearchQueryProvider.notifier).state =
                        value,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Row(
            children: [
              Expanded(
                child: WidgetsAppButton(
                  label: l10n.inventoryLogWastage,
                  onPressed: () => _showWastageDialog(context, ref),
                  icon: Icons.delete_sweep_outlined,
                  variant: WidgetsAppButtonVariant.secondary,
                ),
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: WidgetsAppButton(
                  label: l10n.inventoryAddStock,
                  onPressed: () => context.push(AppRoutePaths.stockAdjustment),
                  icon: Icons.add_box_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showWastageDialog(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final itemController = TextEditingController();
    final quantityController = TextEditingController();
    final saved = await showDialog<bool>(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text(l10n.inventoryLogWastage),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WidgetsAppTextField(
                  controller: itemController,
                  label: l10n.inventorySearchHint,
                  hintText: l10n.inventoryTruffleOil,
                ),
                SizedBox(height: CoreSpacing.sm(dialogContext)),
                WidgetsAppTextField(
                  controller: quantityController,
                  label: l10n.inventoryAdjustmentQuantity,
                  hintText: l10n.inventoryAdjustmentHint,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(l10n.actionCancel),
              ),
              WidgetsAppButton(
                label: l10n.actionSave,
                onPressed: () => Navigator.of(dialogContext).pop(true),
              ),
            ],
          ),
    );

    final item = itemController.text.trim();
    final quantity = quantityController.text.trim();
    itemController.dispose();
    quantityController.dispose();

    if (saved != true || !context.mounted) return;
    if (item.isEmpty || quantity.isEmpty) {
      UtilityMockFeedback.showError(context, l10n.inventoryAdjustmentHint);
      return;
    }

    ref
        .read(inventorySessionWastageProvider.notifier)
        .logWastage(
          ModelInventoryWastageLog(
            itemAr: item,
            itemEn: item,
            quantityAr: quantity,
            quantityEn: quantity,
            reasonAr: l10n.inventoryDamageSpoilage,
            reasonEn: l10n.inventoryDamageSpoilage,
            valueLostJod: 0,
            time: TimeOfDay.now().format(context),
            userAr: l10n.inventorySupplierName,
            userEn: l10n.inventorySupplierName,
          ),
        );
    UtilityDemoActions.complete(context, successMessage: l10n.inventoryLogWastage);
  }
}

class _FreshnessAlertBoard extends StatelessWidget {
  const _FreshnessAlertBoard({required this.alerts});

  final List<ModelInventoryAlert> alerts;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      accentColor: CoreColors.semanticError,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              WidgetsIconBubble(borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)), 
                icon: Icons.spa_outlined,
                color: CoreColors.semanticError,
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.inventoryLowStockAlerts,
                      style: CoreTypography.titleMedium(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    Text(
                      l10n.inventoryRequiredForDishes,
                      style: CoreTypography.caption(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              WidgetsSoftBadge(
                label: alerts.length.toString(),
                color: CoreColors.semanticError,
                icon: Icons.priority_high_outlined,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          if (alerts.isEmpty)
            Text(
              l10n.searchEmptyBody,
              style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
            )
          else
            for (final alert in alerts) ...[
              _FreshnessAlertCard(alert: alert),
              SizedBox(height: CoreSpacing.sm(context)),
            ],
        ],
      ),
    );
  }
}

class _FreshnessAlertCard extends StatelessWidget {
  const _FreshnessAlertCard({required this.alert});

  final ModelInventoryAlert alert;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final critical = (isAr ? alert.remainingAr : alert.remainingEn)
        .toLowerCase()
        .contains('out');
    final color = critical ? CoreColors.semanticError : CoreColors.brandOrange;

    return InkWell(
      onTap:
          () => context.push(
            '${AppRoutePaths.inventoryItem}?item=${Uri.encodeComponent(alert.nameEn)}',
          ),
      borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
          border: Border.all(color: color.withValues(alpha: 0.20)),
        ),
        child: Padding(
          padding: EdgeInsets.all(CoreSpacing.md(context)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetsIconBubble(borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)), 
                icon:
                    critical ? Icons.error_outline : Icons.inventory_2_outlined,
                color: color,
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isAr ? alert.nameAr : alert.nameEn,
                      style: CoreTypography.titleMedium(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    Text(
                      '${isAr ? alert.categoryAr : alert.categoryEn} • ${isAr ? alert.detailAr : alert.detailEn}',
                      style: CoreTypography.caption(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              WidgetsSoftBadge(
                label: isAr ? alert.remainingAr : alert.remainingEn,
                color: color,
                icon: Icons.scale_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DishImpactCard extends StatelessWidget {
  const _DishImpactCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      accentColor: CoreColors.brandOrange,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              WidgetsIconBubble(borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)), 
                icon: Icons.restaurant_menu_outlined,
                color: CoreColors.brandOrange,
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Text(
                  l10n.inventoryRequiredForDishes,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _ImpactLine(
            label: l10n.inventoryTruffleOil,
            dish: l10n.kitchenTruffleParmesanFries,
            color: CoreColors.semanticError,
          ),
          _ImpactLine(
            label: l10n.inventoryHeavyCream,
            dish: l10n.inventoryItemPremiumFillet,
            color: CoreColors.brandOrange,
          ),
          _ImpactLine(
            label: l10n.inventoryFreshBasil,
            dish: l10n.cartMargheritaPremium,
            color: CoreColors.semanticSuccess,
          ),
        ],
      ),
    );
  }
}

class _StorageZonesCard extends StatelessWidget {
  const _StorageZonesCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final rows = MockupCatalog.inventoryStorageStatuses;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              WidgetsIconBubble(borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)), 
                icon: Icons.thermostat_outlined,
                color: scheme.primary,
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Text(
                  l10n.inventoryStorageHealth,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          for (final row in rows) ...[
            _StorageZoneTile(row: row),
            SizedBox(height: CoreSpacing.sm(context)),
          ],
        ],
      ),
    );
  }
}

class _StorageZoneTile extends StatelessWidget {
  const _StorageZoneTile({required this.row});

  final ModelInventoryStorageStatus row;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final color =
        row.hasAlert ? CoreColors.semanticError : CoreColors.semanticSuccess;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
        border: Border.all(color: color.withValues(alpha: 0.18)),
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.sm(context)),
        child: Row(
          children: [
            Icon(
              row.hasAlert ? Icons.error_outline : Icons.check_circle_outline,
              color: color,
              size: CoreContentSizes.buttonIcon(context),
            ),
            SizedBox(width: CoreSpacing.sm(context)),
            Expanded(
              child: Text(
                isAr ? row.nameAr : row.nameEn,
                style: CoreTypography.bodyMedium(
                  context,
                  scheme.onSurface,
                ).copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            WidgetsSoftBadge(
              label: isAr ? row.statusAr : row.statusEn,
              color: color,
              icon:
                  row.hasAlert
                      ? Icons.warning_amber_rounded
                      : Icons.verified_outlined,
            ),
          ],
        ),
      ),
    );
  }
}

class _SupplierArrivalCard extends StatelessWidget {
  const _SupplierArrivalCard();

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
              WidgetsIconBubble(borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)), 
                icon: Icons.local_shipping_outlined,
                color: CoreColors.orderTypeTakeaway,
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Text(
                  l10n.inventoryPendingOrders,
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
              MockupCatalog.inventoryPendingOrdersJod,
              suffix: l10n.currencyJod,
            ),
            style: CoreTypography.headlineSmall(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            l10n.inventoryShipmentsToday,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsSoftBadge(
            label: l10n.inventorySupplierLeadTime,
            color: CoreColors.orderTypeTakeaway,
            icon: Icons.schedule_outlined,
          ),
        ],
      ),
    );
  }
}

class _IngredientLevelsBoard extends StatelessWidget {
  const _IngredientLevelsBoard({required this.levels});

  final List<ModelInventoryLevel> levels;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              WidgetsIconBubble(borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)), icon: Icons.kitchen_outlined, color: scheme.primary),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Text(
                  l10n.inventoryKeyLevels,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
              WidgetsAppButton(
                label: l10n.inventoryFullList,
                onPressed:
                    () => context.push(
                      '${AppRoutePaths.inventoryItem}?item=${Uri.encodeComponent(levels.first.nameEn)}',
                    ),
                variant: WidgetsAppButtonVariant.ghost,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          for (final level in levels) ...[
            _IngredientLevelTile(level: level),
            SizedBox(height: CoreSpacing.sm(context)),
          ],
        ],
      ),
    );
  }
}

class _IngredientLevelTile extends StatelessWidget {
  const _IngredientLevelTile({required this.level});

  final ModelInventoryLevel level;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final color = _levelColor(context, level.colorKey);

    return InkWell(
      onTap:
          () => context.push(
            '${AppRoutePaths.inventoryItem}?item=${Uri.encodeComponent(level.nameEn)}',
          ),
      borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
      child: DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
        border: Border.all(color: color.withValues(alpha: 0.16)),
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.sm(context)),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    isAr ? level.nameAr : level.nameEn,
                    style: CoreTypography.bodyMedium(
                      context,
                      scheme.onSurface,
                    ).copyWith(fontWeight: FontWeight.w800),
                  ),
                ),
                WidgetsSoftBadge(
                  label: l10n.inventoryLevelMeta(level.percent, level.capacity),
                  color: color,
                  icon: Icons.scale_outlined,
                ),
              ],
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            ClipRRect(
              borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
              child: LinearProgressIndicator(
                value: level.percent / 100,
                minHeight: CoreSpacing.xs(context),
                backgroundColor: scheme.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  Color _levelColor(BuildContext context, String key) {
    final scheme = Theme.of(context).colorScheme;
    return switch (key) {
      'secondary' => scheme.secondary,
      'error' => CoreColors.semanticError,
      'tertiary' => scheme.tertiary,
      _ => scheme.primary,
    };
  }
}

class _WastageBoard extends ConsumerWidget {
  const _WastageBoard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final logs = ref.watch(inventoryWastageLogsProvider);
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              WidgetsIconBubble(borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)), 
                icon: Icons.delete_sweep_outlined,
                color: CoreColors.semanticError,
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Text(
                  l10n.inventoryRecentWastage,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
              WidgetsAppButton(
                label: l10n.inventoryDownloadReport,
                onPressed: () async {
                  final csv = buildInventoryWastageCsv(logs);
                  await downloadTextFile(
                    'inventory-wastage-report.csv',
                    csv,
                    mimeType: 'text/csv',
                  );
                  if (!context.mounted) return;
                  UtilityDemoActions.complete(context, successMessage: l10n.inventoryDownloadReport,
                  );
                },
                icon: Icons.download_outlined,
                variant: WidgetsAppButtonVariant.ghost,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          for (final log in logs) ...[
            _WastageRow(log: log, isAr: isAr),
            SizedBox(height: CoreSpacing.sm(context)),
          ],
        ],
      ),
    );
  }
}

class _WastageRow extends StatelessWidget {
  const _WastageRow({required this.log, required this.isAr});

  final ModelInventoryWastageLog log;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: CoreColors.semanticError.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
        border: Border.all(
          color: CoreColors.semanticError.withValues(alpha: 0.14),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.sm(context)),
        child: Row(
          children: [
            WidgetsIconBubble(borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)), 
              icon: Icons.delete_sweep_outlined,
              color: CoreColors.semanticError,
            ),
            SizedBox(width: CoreSpacing.sm(context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isAr ? log.itemAr : log.itemEn,
                    style: CoreTypography.bodyMedium(
                      context,
                      scheme.onSurface,
                    ).copyWith(fontWeight: FontWeight.w900),
                  ),
                  Text(
                    '${isAr ? log.quantityAr : log.quantityEn} • ${log.time} • ${isAr ? log.userAr : log.userEn}',
                    style: CoreTypography.caption(
                      context,
                      scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            WidgetsSoftBadge(
              label: UtilityFormatJod.format(
                log.valueLostJod,
                suffix: l10n.currencyJod,
              ),
              color: CoreColors.semanticError,
              icon: Icons.payments_outlined,
            ),
          ],
        ),
      ),
    );
  }
}

class _ImpactLine extends StatelessWidget {
  const _ImpactLine({
    required this.label,
    required this.dish,
    required this.color,
  });

  final String label;
  final String dish;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      child: Row(
        children: [
          Icon(
            Icons.restaurant_outlined,
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
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  dish,
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
    );
  }
}


