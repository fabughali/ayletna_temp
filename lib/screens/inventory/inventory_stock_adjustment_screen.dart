import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_inventory_mock.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/inventory_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_demo_actions.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
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

/// PRD StockAdjustmentScreen — inventory delta, batch, expiry, and evidence.
class InventoryStockAdjustmentScreen extends ConsumerStatefulWidget {
  const InventoryStockAdjustmentScreen({super.key});

  @override
  ConsumerState<InventoryStockAdjustmentScreen> createState() =>
      _InventoryStockAdjustmentScreenState();
}

class _InventoryStockAdjustmentScreenState
    extends ConsumerState<InventoryStockAdjustmentScreen> {
  String _reason = 'arrival';
  final _quantityController = TextEditingController();
  final Set<String> _evidenceKeys = {};

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return WidgetsScaffoldPage(
      title: l10n.screenStockAdjustment,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.inventory),
          icon: Icons.inventory_2_outlined,
          tooltip: l10n.screenInventoryDashboard,
        ),
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
              l10n.screenStockAdjustment,
            ),
        child: ListView(
          children: [
            const _AdjustmentHero(),
            SizedBox(height: CoreSpacing.lg(context)),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 940;
                final form = _AdjustmentForm(
                  reason: _reason,
                  quantityController: _quantityController,
                  onReasonChanged: (reason) => setState(() => _reason = reason),
                );
                final side = Column(
                  children: [
                    const _SelectedItemCard(),
                    SizedBox(height: CoreSpacing.lg(context)),
                    _EvidenceCard(
                      attachedKeys: _evidenceKeys,
                      onAttach: (key) {
                        setState(() => _evidenceKeys.add(key));
                        UtilityMockFeedback.showSuccess(context, key);
                      },
                    ),
                    SizedBox(height: CoreSpacing.lg(context)),
                    _SubmitCard(
                      reason: _reason,
                      quantityController: _quantityController,
                      evidenceKey:
                          _evidenceKeys.isEmpty
                              ? null
                              : _evidenceKeys.join(','),
                    ),
                  ],
                );

                if (isWide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: form),
                      SizedBox(width: CoreSpacing.lg(context)),
                      Expanded(flex: 2, child: side),
                    ],
                  );
                }

                return Column(
                  children: [
                    form,
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

class _AdjustmentHero extends StatelessWidget {
  const _AdjustmentHero();

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
                icon: Icons.tune_outlined,
                color: scheme.primary,
                size: CoreContentSizes.emptyStateIcon(context), iconSize: CoreContentSizes.kpiIcon(context),
              ),
              SizedBox(width: CoreSpacing.md(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.screenStockAdjustment,
                      style: CoreTypography.headlineSmall(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    Text(
                      l10n.screenStockAdjustmentDesc,
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
                label: l10n.inventoryArrivalShipment,
                color: CoreColors.semanticSuccess,
                icon: Icons.local_shipping_outlined,
              ),
              WidgetsSoftBadge(
                label: l10n.inventoryDamageSpoilage,
                color: CoreColors.semanticError,
                icon: Icons.delete_sweep_outlined,
              ),
              WidgetsSoftBadge(
                label: l10n.inventoryCorrection,
                color: CoreColors.brandGold,
                icon: Icons.edit_note_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AdjustmentForm extends StatelessWidget {
  const _AdjustmentForm({
    required this.reason,
    required this.quantityController,
    required this.onReasonChanged,
  });

  final String reason;
  final TextEditingController quantityController;
  final ValueChanged<String> onReasonChanged;

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
              WidgetsIconBubble(borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)), 
                icon: Icons.inventory_outlined,
                color: scheme.primary,
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Text(
                  l10n.inventoryAdjustStock,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppTextField(
            label: l10n.inventorySearchHint,
            hintText: l10n.inventoryItemAtlanticSalmon,
            prefixIcon: Icons.search,
            readOnly: true,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppTextField(
            controller: quantityController,
            label: l10n.inventoryAdjustmentQuantity,
            hintText: l10n.inventoryAdjustmentHint,
            keyboardType: const TextInputType.numberWithOptions(
              signed: true,
              decimal: true,
            ),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            l10n.inventoryReasonAdjustment,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.sm(context),
            children: [
              _ReasonChip(
                id: 'consumption',
                label: l10n.inventoryConsumption,
                icon: Icons.restaurant_outlined,
                selected: reason == 'consumption',
                color: scheme.primary,
                onTap: onReasonChanged,
              ),
              _ReasonChip(
                id: 'spoilage',
                label: l10n.inventoryDamageSpoilage,
                icon: Icons.delete_sweep_outlined,
                selected: reason == 'spoilage',
                color: CoreColors.semanticError,
                onTap: onReasonChanged,
              ),
              _ReasonChip(
                id: 'correction',
                label: l10n.inventoryCorrection,
                icon: Icons.edit_note_outlined,
                selected: reason == 'correction',
                color: CoreColors.brandGold,
                onTap: onReasonChanged,
              ),
              _ReasonChip(
                id: 'arrival',
                label: l10n.inventoryArrivalShipment,
                icon: Icons.local_shipping_outlined,
                selected: reason == 'arrival',
                color: CoreColors.semanticSuccess,
                onTap: onReasonChanged,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppTextField(
            label: l10n.inventoryThresholdConfig,
            initialValue: '15.0 ${l10n.inventoryKg}',
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            l10n.inventoryLowStockTrigger,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Row(
            children: [
              Expanded(
                child: WidgetsAppTextField(
                  label: l10n.inventoryBatchLotLabel,
                  hintText: l10n.inventoryBatchLotHint,
                  prefixIcon: Icons.qr_code_2_outlined,
                ),
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: WidgetsAppTextField(
                  label: l10n.inventoryExpiryDateLabel,
                  hintText: l10n.inventoryExpiryDateHint,
                  prefixIcon: Icons.event_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SelectedItemCard extends ConsumerWidget {
  const _SelectedItemCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final stock = ref.watch(inventoryStockProvider);

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      accentColor: CoreColors.semanticSuccess,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              WidgetsIconBubble(borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)), 
                icon: Icons.set_meal_outlined,
                color: CoreColors.semanticSuccess,
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Text(
                  l10n.inventoryItemAtlanticSalmon,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
              WidgetsSoftBadge(
                label: l10n.inventoryInStock,
                color: CoreColors.semanticSuccess,
                icon: Icons.check_circle_outline,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            l10n.inventoryItemSku,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _DetailLine(
            label: l10n.inventoryCurrentStock,
            value: '${stock.stockKg.toStringAsFixed(1)} ${l10n.inventoryKg}',
          ),
          _DetailLine(
            label: l10n.inventorySafetyThreshold,
            value: '${stock.thresholdKg.toStringAsFixed(1)} ${l10n.inventoryKg}',
          ),
          _DetailLine(
            label: l10n.inventoryMainSupplier,
            value: l10n.inventorySupplierName,
          ),
        ],
      ),
    );
  }
}

class _EvidenceCard extends StatelessWidget {
  const _EvidenceCard({
    required this.attachedKeys,
    required this.onAttach,
  });

  final Set<String> attachedKeys;
  final ValueChanged<String> onAttach;

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
              WidgetsIconBubble(borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)), 
                icon: Icons.receipt_long_outlined,
                color: scheme.primary,
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Text(
                  l10n.inventoryEvidenceTitle,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _EvidenceButton(
            label: l10n.inventoryAttachSupplierReceipt,
            icon: Icons.receipt_long_outlined,
            attached: attachedKeys.contains('supplier_receipt'),
            onPressed: () => onAttach('supplier_receipt'),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          _EvidenceButton(
            label: l10n.inventoryAddShelfPhoto,
            icon: Icons.photo_camera_outlined,
            attached: attachedKeys.contains('shelf_photo'),
            onPressed: () => onAttach('shelf_photo'),
          ),
        ],
      ),
    );
  }
}

class _SubmitCard extends ConsumerWidget {
  const _SubmitCard({
    required this.reason,
    required this.quantityController,
    this.evidenceKey,
  });

  final String reason;
  final TextEditingController quantityController;
  final String? evidenceKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final reasonLabel = switch (reason) {
      'consumption' => l10n.inventoryConsumption,
      'spoilage' => l10n.inventoryDamageSpoilage,
      'correction' => l10n.inventoryCorrection,
      _ => l10n.inventoryArrivalShipment,
    };

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.dashboard,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WidgetsSoftBadge(
            label: reasonLabel,
            color: _reasonColor(context, reason),
            icon: Icons.edit_note_outlined,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            l10n.inventoryLowStockTrigger,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.inventoryUpdateInventory,
            onPressed: () => _confirmUpdate(context, ref),
            icon: Icons.check_circle_outline,
            fullWidth: true,
          ),
        ],
      ),
    );
  }

  Color _reasonColor(BuildContext context, String reason) {
    return switch (reason) {
      'spoilage' => CoreColors.semanticError,
      'correction' => CoreColors.brandGold,
      'arrival' => CoreColors.semanticSuccess,
      _ => Theme.of(context).colorScheme.primary,
    };
  }

  Future<void> _confirmUpdate(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final rawQty = double.tryParse(quantityController.text.trim());
    if (rawQty == null || rawQty == 0) {
      UtilityMockFeedback.showError(context, l10n.inventoryAdjustmentHint);
      return;
    }

    final deltaKg = switch (reason) {
      'consumption' || 'spoilage' => -rawQty.abs(),
      'correction' => rawQty,
      _ => rawQty.abs(),
    };

    final confirmed = await UtilityMockFeedback.confirm(
      context: context,
      title: l10n.inventoryUpdateInventory,
      message: l10n.inventoryLowStockTrigger,
      confirmLabel: l10n.actionConfirm,
      cancelLabel: l10n.actionCancel,
      icon: Icons.edit_note_outlined,
    );
    if (!confirmed || !context.mounted) return;

    final typeLabel = switch (reason) {
      'consumption' => l10n.inventoryConsumption,
      'spoilage' => l10n.inventoryDamageSpoilage,
      'correction' => l10n.inventoryCorrection,
      _ => l10n.inventoryArrivalShipment,
    };

    ref.read(inventoryStockProvider.notifier).applyAdjustment(
      deltaKg: deltaKg,
      auditRow: ModelInventoryAuditRow(
        dateAr: l10n.inventoryRecentHistoryAudit,
        dateEn: l10n.inventoryRecentHistoryAudit,
        typeAr: typeLabel,
        typeEn: typeLabel,
        userAr: l10n.inventorySupplierName,
        userEn: l10n.inventorySupplierName,
        amountAr: '${deltaKg > 0 ? '+' : ''}${deltaKg.toStringAsFixed(1)} ${l10n.inventoryKg}',
        amountEn: '${deltaKg > 0 ? '+' : ''}${deltaKg.toStringAsFixed(1)} ${l10n.inventoryKg}',
        balanceAr: l10n.inventoryCurrentStock,
        balanceEn: l10n.inventoryCurrentStock,
        isNegative: deltaKg < 0,
        evidenceKey: evidenceKey,
      ),
    );

    if (reason == 'spoilage') {
      ref.read(inventorySessionWastageProvider.notifier).logWastage(
        ModelInventoryWastageLog(
          itemAr: l10n.inventoryItemAtlanticSalmon,
          itemEn: l10n.inventoryItemAtlanticSalmon,
          quantityAr: rawQty.abs().toStringAsFixed(1),
          quantityEn: rawQty.abs().toStringAsFixed(1),
          reasonAr: l10n.inventoryDamageSpoilage,
          reasonEn: l10n.inventoryDamageSpoilage,
          valueLostJod: 0,
          time: TimeOfDay.now().format(context),
          userAr: l10n.inventorySupplierName,
          userEn: l10n.inventorySupplierName,
        ),
      );
    }

    quantityController.clear();
    if (!context.mounted) return;
    UtilityDemoActions.complete(context, successMessage: l10n.inventoryUpdateInventory);
    context.go(AppRoutePaths.inventory);
  }
}

class _ReasonChip extends StatelessWidget {
  const _ReasonChip({
    required this.id,
    required this.label,
    required this.icon,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  final String id;
  final String label;
  final IconData icon;
  final bool selected;
  final Color color;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final effectiveColor = selected ? color : scheme.onSurfaceVariant;

    return InkWell(
      onTap: () => onTap(id),
      borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: effectiveColor.withValues(alpha: selected ? 0.16 : 0.08),
          borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
          border: Border.all(color: effectiveColor.withValues(alpha: 0.24)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: CoreSpacing.md(context),
            vertical: CoreSpacing.sm(context),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: effectiveColor,
                size: CoreContentSizes.orderTypeIcon(context),
              ),
              SizedBox(width: CoreSpacing.xs(context)),
              Text(
                label,
                style: CoreTypography.caption(
                  context,
                  effectiveColor,
                ).copyWith(fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EvidenceButton extends StatelessWidget {
  const _EvidenceButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.attached = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool attached;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppButton(
      label: label,
      onPressed: onPressed,
      icon: attached ? Icons.check_circle_outline : icon,
      variant: WidgetsAppButtonVariant.outline,
      fullWidth: true,
    );
  }
}

class _DetailLine extends StatelessWidget {
  const _DetailLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: CoreTypography.bodyMedium(
                context,
                scheme.onSurfaceVariant,
              ),
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
    );
  }
}


