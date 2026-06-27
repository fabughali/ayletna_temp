import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_inventory_mock.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/inventory_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/utilities/utility_url_actions.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_avatar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_illustration_panel.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_list_item.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_progress_bar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [InventoryItemScreen].
class InventoryItemScreen extends ConsumerWidget {
  const InventoryItemScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return WidgetsScaffoldPage(
      title: l10n.inventoryItemAtlanticSalmon,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh:
            () async =>
                UtilityMockFeedback.showInfo(context, l10n.screenInventoryItem),
        child: ListView(
          children: [
            SizedBox(height: CoreSpacing.md(context)),
            _HeroSummary(l10n: l10n),
            SizedBox(height: CoreSpacing.lg(context)),
            _StockCard(l10n: l10n),
            SizedBox(height: CoreSpacing.lg(context)),
            _AdjustStockCard(l10n: l10n),
            SizedBox(height: CoreSpacing.lg(context)),
            _SupplierCard(l10n: l10n),
            SizedBox(height: CoreSpacing.lg(context)),
            _UsageChartCard(l10n: l10n),
            SizedBox(height: CoreSpacing.lg(context)),
            _HistoryAuditCard(l10n: l10n),
            SizedBox(height: CoreSpacing.xxl(context)),
          ],
        ),
      ),
    );
  }
}

class _HeroSummary extends StatelessWidget {
  const _HeroSummary({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsIllustrationPanel(
      height: CoreContentSizes.categoryHeroHeight(context) * 0.58,
      backgroundColor: scheme.inverseSurface,
      badge: WidgetsStatusPill(
        label: l10n.inventoryItemSupplyBadge,
        color: CoreColors.orderTypePlated,
        icon: Icons.verified_outlined,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _SalmonPainter(
                color: scheme.onPrimary.withValues(alpha: 0.18),
                accent: CoreColors.orderTypePlated,
              ),
            ),
          ),
          PositionedDirectional(
            start: CoreSpacing.lg(context),
            end: CoreSpacing.lg(context),
            bottom: CoreSpacing.lg(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.inventoryItemPremiumFillet,
                  style: CoreTypography.headlineSmall(
                    context,
                    scheme.onPrimary,
                  ),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  l10n.inventoryItemSku,
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.onPrimary.withValues(alpha: 0.90),
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

class _StockCard extends ConsumerWidget {
  const _StockCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final stock = ref.watch(inventoryStockProvider);

    return WidgetsAppCard(
      title: l10n.inventoryCurrentStock,
      trailing: WidgetsStatusPill(
        label:
            stock.stockKg <= stock.thresholdKg
                ? l10n.inventoryLowStockAlerts
                : l10n.inventoryHealthyInventory,
        color:
            stock.stockKg <= stock.thresholdKg
                ? CoreColors.semanticError
                : CoreColors.semanticSuccess,
        icon:
            stock.stockKg <= stock.thresholdKg
                ? Icons.warning_amber_rounded
                : Icons.check_circle_outline,
      ),
      accentColor: CoreColors.brandBrown,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${stock.stockKg.toStringAsFixed(1)} ${l10n.inventoryKg}',
            style: CoreTypography.headlineLarge(
              context,
              CoreColors.brandBrown,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsListItem(
            title: l10n.inventorySafetyThreshold,
            trailing: Text(
              '${stock.thresholdKg.toStringAsFixed(1)} ${l10n.inventoryKg}',
              style: CoreTypography.titleMedium(context, scheme.onSurface),
            ),
            dense: true,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsProgressBar(
            value: stock.fillRatio,
            color:
                stock.stockKg <= stock.thresholdKg
                    ? CoreColors.semanticError
                    : CoreColors.semanticSuccess,
          ),
        ],
      ),
    );
  }
}

class _AdjustStockCard extends ConsumerStatefulWidget {
  const _AdjustStockCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  ConsumerState<_AdjustStockCard> createState() => _AdjustStockCardState();
}

class _AdjustStockCardState extends ConsumerState<_AdjustStockCard> {
  final _quantityController = TextEditingController();
  final _thresholdController = TextEditingController(text: '15.0');

  @override
  void dispose() {
    _quantityController.dispose();
    _thresholdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      title: l10n.inventoryAdjustStock,
      leading: Icon(Icons.edit_note_outlined, color: scheme.primary),
      variant: WidgetsAppCardVariant.filled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetsAppTextField(
            controller: _quantityController,
            label: l10n.inventoryAdjustmentQuantity,
            hintText: l10n.inventoryAdjustmentHint,
            keyboardType: const TextInputType.numberWithOptions(
              signed: true,
              decimal: true,
            ),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppTextField(
            label: l10n.inventoryReasonAdjustment,
            initialValue: l10n.inventoryConsumption,
            readOnly: true,
            suffixIcon: const Icon(Icons.expand_more),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppTextField(
            controller: _thresholdController,
            label: l10n.inventoryThresholdConfig,
            hintText: '15.0 ${l10n.inventoryKg}',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            l10n.inventoryLowStockTrigger,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsAppButton(
            label: l10n.inventoryUpdateInventory,
            onPressed: _submitAdjustment,
            fullWidth: true,
          ),
        ],
      ),
    );
  }

  Future<void> _submitAdjustment() async {
    final l10n = widget.l10n;
    final delta = double.tryParse(_quantityController.text.trim());
    final threshold = double.tryParse(_thresholdController.text.trim());
    if (delta == null || delta == 0) {
      UtilityMockFeedback.showError(context, l10n.inventoryAdjustmentHint);
      return;
    }

    final confirmed = await UtilityMockFeedback.confirm(
      context: context,
      title: l10n.inventoryUpdateInventory,
      message: l10n.inventoryLowStockTrigger,
      confirmLabel: l10n.actionConfirm,
      cancelLabel: l10n.actionCancel,
      icon: Icons.edit_note_outlined,
    );
    if (!confirmed || !mounted) return;

    if (threshold != null && threshold > 0) {
      ref.read(inventoryStockProvider.notifier).updateThreshold(threshold);
    }

    ref.read(inventoryStockProvider.notifier).applyAdjustment(
      deltaKg: delta,
      auditRow: ModelInventoryAuditRow(
        dateAr: l10n.inventoryRecentHistoryAudit,
        dateEn: l10n.inventoryRecentHistoryAudit,
        typeAr: l10n.inventoryConsumption,
        typeEn: l10n.inventoryConsumption,
        userAr: l10n.inventorySupplierName,
        userEn: l10n.inventorySupplierName,
        amountAr: '${delta > 0 ? '+' : ''}${delta.toStringAsFixed(1)} ${l10n.inventoryKg}',
        amountEn: '${delta > 0 ? '+' : ''}${delta.toStringAsFixed(1)} ${l10n.inventoryKg}',
        balanceAr: l10n.inventoryCurrentStock,
        balanceEn: l10n.inventoryCurrentStock,
        isNegative: delta < 0,
      ),
    );

    _quantityController.clear();
    UtilityMockFeedback.showSuccess(context, l10n.inventoryUpdateInventory);
  }
}

class _SupplierCard extends StatelessWidget {
  const _SupplierCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      title: l10n.inventoryMainSupplier,
      accentColor: scheme.secondary,
      child: Column(
        children: [
          WidgetsListItem(
            title: l10n.inventorySupplierName,
            subtitle: l10n.inventorySupplierLeadTime,
            leading: WidgetsAvatar(
              icon: Icons.local_shipping_outlined,
              color: scheme.secondary,
            ),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.inventoryContactRepresentative,
            onPressed: () async {
              final uri = Uri.parse('tel:+962790000000');
              final launched = await UtilityUrlActions.launchExternalUri(uri);
              if (!context.mounted) return;
              if (launched) {
                UtilityMockFeedback.showSuccess(
                  context,
                  l10n.inventoryContactRepresentative,
                );
              } else {
                UtilityMockFeedback.showInfo(context, l10n.inventorySupplierName);
              }
            },
            icon: Icons.call_outlined,
            variant: WidgetsAppButtonVariant.ghost,
          ),
        ],
      ),
    );
  }
}

class _UsageChartCard extends StatelessWidget {
  const _UsageChartCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      title: l10n.inventoryLastSevenDaysUsage,
      trailing: WidgetsStatusPill(
        label: l10n.inventoryInStock,
        color: scheme.secondary,
        compact: true,
      ),
      child: WidgetsIllustrationPanel(
        child: CustomPaint(
          painter: _UsageBarsPainter(
            bar: scheme.secondary,
            track: scheme.secondaryContainer.withValues(alpha: 0.46),
            grid: scheme.outlineVariant,
          ),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class _HistoryAuditCard extends ConsumerWidget {
  const _HistoryAuditCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final rows = ref.watch(inventoryAuditHistoryProvider);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return WidgetsAppCard(
      title: l10n.inventoryRecentHistoryAudit,
      variant: WidgetsAppCardVariant.filled,
      child: Column(
        children: [
          for (final row in rows) ...[
            WidgetsListItem(
              title: isAr ? row.dateAr : row.dateEn,
              subtitle:
                  '${isAr ? row.userAr : row.userEn} - ${isAr ? row.balanceAr : row.balanceEn}',
              leading: Icon(
                row.isNegative
                    ? Icons.remove_circle_outline
                    : Icons.add_circle_outline,
                color: row.isNegative ? scheme.error : scheme.secondary,
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  WidgetsStatusPill(
                    label: isAr ? row.typeAr : row.typeEn,
                    color: scheme.primary,
                    compact: true,
                  ),
                  SizedBox(height: CoreSpacing.xs(context)),
                  Text(
                    isAr ? row.amountAr : row.amountEn,
                    style: CoreTypography.caption(
                      context,
                      row.isNegative ? scheme.error : scheme.secondary,
                    ).copyWith(fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
            SizedBox(height: CoreSpacing.sm(context)),
          ],
        ],
      ),
    );
  }
}

class _UsageBarsPainter extends CustomPainter {
  const _UsageBarsPainter({
    required this.bar,
    required this.track,
    required this.grid,
  });

  final Color bar;
  final Color track;
  final Color grid;

  @override
  void paint(Canvas canvas, Size size) {
    final values = [0.65, 0.60, 0.50, 0.75, 0.45, 0.35, 0.25];
    final trackPaint = Paint()..color = track;
    final barPaint = Paint()..color = bar;
    final gridPaint =
        Paint()
          ..color = grid
          ..strokeWidth = 1;
    final slot = size.width / values.length;
    final width = slot * 0.62;

    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width, size.height),
      gridPaint,
    );

    for (var i = 0; i < values.length; i++) {
      final left = i * slot + (slot - width) / 2;
      final trackRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(left, 0, width, size.height),
        Radius.circular(width),
      );
      final barHeight = size.height * values[i];
      final barRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(left, size.height - barHeight, width, barHeight),
        Radius.circular(width),
      );
      canvas.drawRRect(trackRect, trackPaint);
      canvas.drawRRect(barRect, barPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _UsageBarsPainter oldDelegate) {
    return oldDelegate.bar != bar ||
        oldDelegate.track != track ||
        oldDelegate.grid != grid;
  }
}

class _SalmonPainter extends CustomPainter {
  const _SalmonPainter({required this.color, required this.accent});

  final Color color;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final platePaint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;
    final salmonPaint =
        Paint()
          ..color = accent.withValues(alpha: 0.70)
          ..style = PaintingStyle.fill;
    final linePaint =
        Paint()
          ..color = color.withValues(alpha: 0.86)
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

    final center = Offset(size.width * 0.62, size.height * 0.42);
    canvas.drawOval(
      Rect.fromCenter(
        center: center,
        width: size.width * 0.44,
        height: size.height * 0.32,
      ),
      platePaint,
    );
    final salmon = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center,
        width: size.width * 0.34,
        height: size.height * 0.16,
      ),
      const Radius.circular(CoreSpacing.radiusCard),
    );
    canvas.drawRRect(salmon, salmonPaint);
    for (var i = 0; i < 5; i++) {
      final dx = center.dx - size.width * 0.14 + i * size.width * 0.07;
      canvas.drawLine(
        Offset(dx, center.dy - size.height * 0.07),
        Offset(dx + size.width * 0.03, center.dy + size.height * 0.07),
        linePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SalmonPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.accent != accent;
  }
}
