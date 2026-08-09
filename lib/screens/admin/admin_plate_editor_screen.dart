import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_admin_mock.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/admin_plates_providers.dart';
import 'package:ayletna_restaurant_app/providers/admin_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
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

/// PRD [PlateEditorScreen].
class AdminPlateEditorScreen extends ConsumerWidget {
  const AdminPlateEditorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final asset = MockupCatalog.adminPlateAssets.first;
    final plateConfig = ref.watch(adminPlateConfigProvider);

    return WidgetsScaffoldPage(
      title: l10n.screenPlateEditor,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.operatorPlates),
          icon: Icons.inventory_2_outlined,
          tooltip: l10n.screenPlatesManagement,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          await Future<void>.delayed(const Duration(milliseconds: 300));
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 840;
            final identity = Column(
              children: [
                _AssetIdentityCard(asset: asset, l10n: l10n),
                SizedBox(height: CoreSpacing.lg(context)),
                _StockControlCard(asset: asset, l10n: l10n),
              ],
            );
            final policy = Column(
              children: [
                _DepositRulesCard(
                  asset: asset,
                  l10n: l10n,
                  requiresDeposit: plateConfig.requiresDeposit,
                  allowDelivery: plateConfig.allowDelivery,
                  autoRestock: plateConfig.autoRestock,
                  onRequiresDepositChanged:
                      (value) =>
                          ref
                              .read(adminPlateConfigProvider.notifier)
                              .setRequiresDeposit(value),
                  onAllowDeliveryChanged:
                      (value) =>
                          ref
                              .read(adminPlateConfigProvider.notifier)
                              .setAllowDelivery(value),
                  onAutoRestockChanged:
                      (value) =>
                          ref
                              .read(adminPlateConfigProvider.notifier)
                              .setAutoRestock(value),
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                _ConditionAndFeesCard(asset: asset, l10n: l10n),
                SizedBox(height: CoreSpacing.lg(context)),
                _SaveActionsCard(l10n: l10n),
              ],
            );
            return ListView(
              padding: EdgeInsetsDirectional.only(
                top: CoreSpacing.md(context),
                bottom: CoreSpacing.xxl(context),
              ),
              children: [
                _EditorHero(asset: asset, l10n: l10n, isAr: isAr),
                SizedBox(height: CoreSpacing.lg(context)),
                if (isWide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 5, child: identity),
                      SizedBox(width: CoreSpacing.lg(context)),
                      Expanded(flex: 5, child: policy),
                    ],
                  )
                else ...[
                  identity,
                  SizedBox(height: CoreSpacing.lg(context)),
                  policy,
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _EditorHero extends StatelessWidget {
  const _EditorHero({
    required this.asset,
    required this.l10n,
    required this.isAr,
  });

  final ModelAdminPlateAsset asset;
  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
        gradient: const LinearGradient(
          colors: [CoreColors.semanticDeposit, CoreColors.brandBrown],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetsSoftBadge(
            label: l10n.plateEditorBadge,
            color: CoreColors.surfaceLight,
            foreground: CoreColors.brandBrown,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            l10n.plateEditorHeadline,
            style: CoreTypography.headlineSmall(
              context,
              CoreColors.surfaceLight,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            '${isAr ? asset.titleAr : asset.titleEn} · ${asset.sku}',
            style: CoreTypography.bodyMedium(
              context,
              CoreColors.surfaceLight.withValues(alpha: 0.86),
            ),
          ),
        ],
      ),
    );
  }
}

class _AssetIdentityCard extends StatelessWidget {
  const _AssetIdentityCard({
    required this.asset,
    required this.l10n,
  });

  final ModelAdminPlateAsset asset;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: l10n.plateEditorAssetIdentityTitle,
      subtitle: l10n.plateEditorAssetIdentitySubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.qr_code_2_outlined,
        color: CoreColors.orderTypePlated,
      ),
      child: Column(
        children: [
          WidgetsAppTextField(
            label: l10n.plateEditorAssetNameAr,
            initialValue: asset.titleAr,
            prefixIcon: Icons.language_outlined,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppTextField(
            label: l10n.plateEditorAssetNameEn,
            initialValue: asset.titleEn,
            prefixIcon: Icons.abc_outlined,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppTextField(
            label: l10n.plateEditorAssetSku,
            initialValue: asset.sku,
            prefixIcon: Icons.tag_outlined,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppTextField(
            label: l10n.plateEditorReplacementValue,
            initialValue: UtilityFormatJod.format(
              asset.priceJod,
              suffix: l10n.currencyJod,
            ),
            prefixIcon: Icons.payments_outlined,
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}

class _StockControlCard extends ConsumerWidget {
  const _StockControlCard({
    required this.asset,
    required this.l10n,
  });

  final ModelAdminPlateAsset asset;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plates = ref.watch(adminPlatesProvider);
    return WidgetsAppCard(
      title: l10n.plateEditorStockTitle,
      subtitle: l10n.plateEditorStockSubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.inventory_2_outlined,
        color: CoreColors.brandOlive,
      ),
      child: Column(
        children: [
          _CountRow(label: l10n.platesInStock, value: plates.stockUnits),
          _CountRow(label: l10n.platesCirculating, value: asset.circulating),
          _CountRow(
            label: l10n.platesReplacementsPending,
            value: plates.restockRequestCount,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.platesOrderNow,
            onPressed: () {
              final next = ref
                  .read(adminPlatesProvider.notifier)
                  .requestRestock(units: 20);
              UtilityMockFeedback.showSuccess(
                context,
                '${l10n.platesOrderNow} · $next',
              );
            },
            icon: Icons.shopping_cart_checkout_outlined,
            variant: WidgetsAppButtonVariant.outline,
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}

class _DepositRulesCard extends StatelessWidget {
  const _DepositRulesCard({
    required this.asset,
    required this.l10n,
    required this.requiresDeposit,
    required this.allowDelivery,
    required this.autoRestock,
    required this.onRequiresDepositChanged,
    required this.onAllowDeliveryChanged,
    required this.onAutoRestockChanged,
  });

  final ModelAdminPlateAsset asset;
  final AppLocalizations l10n;
  final bool requiresDeposit;
  final bool allowDelivery;
  final bool autoRestock;
  final ValueChanged<bool> onRequiresDepositChanged;
  final ValueChanged<bool> onAllowDeliveryChanged;
  final ValueChanged<bool> onAutoRestockChanged;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: l10n.depositTrayConfiguration,
      subtitle: l10n.plateEditorDepositRulesSubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.account_balance_wallet_outlined,
        color: CoreColors.semanticDeposit,
      ),
      child: Column(
        children: [
          _SwitchLine(
            label: l10n.plateEditorRequiresDeposit,
            value: requiresDeposit,
            onChanged: onRequiresDepositChanged,
          ),
          _SwitchLine(
            label: l10n.plateEditorAvailableDelivery,
            value: allowDelivery,
            onChanged: onAllowDeliveryChanged,
          ),
          _SwitchLine(
            label: l10n.platesAutoRestockLevel,
            value: autoRestock,
            onChanged: onAutoRestockChanged,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          _PolicyLine(
            label: l10n.depositGlobalAmountLabel,
            value: UtilityFormatJod.format(
              MockupCatalog.checkoutPlatedDepositJod,
              suffix: l10n.currencyJod,
            ),
          ),
        ],
      ),
    );
  }
}

class _ConditionAndFeesCard extends StatelessWidget {
  const _ConditionAndFeesCard({
    required this.asset,
    required this.l10n,
  });

  final ModelAdminPlateAsset asset;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: l10n.plateEditorConditionFeesTitle,
      subtitle: l10n.plateEditorConditionFeesSubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.fact_check_outlined,
        color: CoreColors.semanticError,
      ),
      child: Column(
        children: [
          _FeeRow(
            label: l10n.plateEditorFeeFullBreakage,
            value: UtilityFormatJod.format(
              asset.priceJod,
              suffix: l10n.currencyJod,
            ),
            color: CoreColors.semanticError,
          ),
          _FeeRow(
            label: l10n.plateEditorFeeScratch,
            value: UtilityFormatJod.format(
              asset.priceJod * 0.25,
              suffix: l10n.currencyJod,
            ),
            color: CoreColors.brandOrange,
          ),
          _FeeRow(
            label: l10n.plateEditorFeeMissing,
            value: UtilityFormatJod.format(
              asset.priceJod,
              suffix: l10n.currencyJod,
            ),
            color: CoreColors.semanticDeposit,
          ),
        ],
      ),
    );
  }
}

class _SaveActionsCard extends ConsumerWidget {
  const _SaveActionsCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WidgetsAppCard(
      title: l10n.plateEditorSaveTitle,
      subtitle: l10n.plateEditorSaveSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WidgetsAppButton(
            label: l10n.actionSave,
            onPressed: () {
              ref.read(adminPlateConfigProvider.notifier).save();
              UtilityMockFeedback.showSuccess(
                context,
                l10n.plateEditorSavedSuccess,
              );
            },
            icon: Icons.save_outlined,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppButton(
            label: l10n.plateEditorBackToPlates,
            onPressed: () => context.push(AppRoutePaths.operatorPlates),
            icon: Icons.arrow_back,
            variant: WidgetsAppButtonVariant.outline,
          ),
        ],
      ),
    );
  }
}

class _CountRow extends StatelessWidget {
  const _CountRow({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          WidgetsSoftBadge(label: '$value', color: CoreColors.brandOlive),
        ],
      ),
    );
  }
}

class _SwitchLine extends StatelessWidget {
  const _SwitchLine({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        label,
        style: CoreTypography.titleMedium(
          context,
          Theme.of(context).colorScheme.onSurface,
        ).copyWith(fontWeight: FontWeight.w800),
      ),
      value: value,
      activeThumbColor: CoreColors.brandOlive,
      onChanged: onChanged,
    );
  }
}

class _PolicyLine extends StatelessWidget {
  const _PolicyLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
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
        Text(
          value,
          style: CoreTypography.titleMedium(
            context,
            Theme.of(context).colorScheme.onSurface,
          ).copyWith(fontWeight: FontWeight.w900),
        ),
      ],
    );
  }
}

class _FeeRow extends StatelessWidget {
  const _FeeRow({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
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
          Expanded(child: Text(label)),
          Text(
            value,
            style: CoreTypography.titleMedium(
              context,
              color,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}



