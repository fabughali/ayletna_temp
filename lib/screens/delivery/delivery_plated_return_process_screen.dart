import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/delivery_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_demo_actions.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_async_state_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_bubble.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_price_badge.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_soft_badge.dart';
import 'package:flutter/material.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_amount_line.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD PlatedReturnProcessScreen — condition assessment and refund clarity.
class DeliveryPlatedReturnProcessScreen extends ConsumerStatefulWidget {
  const DeliveryPlatedReturnProcessScreen({super.key});

  @override
  ConsumerState<DeliveryPlatedReturnProcessScreen> createState() =>
      _DeliveryPlatedReturnProcessScreenState();
}

class _DeliveryPlatedReturnProcessScreenState
    extends ConsumerState<DeliveryPlatedReturnProcessScreen> {
  bool _confirmed = false;
  bool _signatureAcknowledged = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final draft = ref.watch(deliveryActiveReturnProvider);

    return WidgetsScaffoldPage(
      title: _confirmed ? l10n.returnStep2Title : l10n.returnStep1Title,
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
              l10n.deliveryReturnProcessRefreshed,
            ),
        child: ListView(
          children: [
            if (draft == null)
              WidgetsAsyncStateCard.empty(
                title: l10n.screenPlatedReturnProcess,
                message: l10n.deliveryReturnTasks,
                actionLabel: l10n.screenPlatedReturnTask,
                onAction: () => context.go(AppRoutePaths.platedReturnTask),
              )
            else if (_confirmed)
              _ReturnSettlementStep(
                draft: draft,
                signatureAcknowledged: _signatureAcknowledged,
                onBack: () => setState(() => _confirmed = false),
                onFinalize: () => _finalizeReturn(draft),
                onClearSignature:
                    () => setState(() => _signatureAcknowledged = false),
                onAcknowledgeSignature:
                    () => setState(() => _signatureAcknowledged = true),
              )
            else
              _ReturnChecklistStep(
                draft: draft,
                onChanged:
                    (itemKey, missing) => ref
                        .read(deliveryActiveReturnProvider.notifier)
                        .setItemMissing(itemKey, missing),
                onContinue: () => setState(() => _confirmed = true),
              ),
            SizedBox(height: CoreSpacing.xxl(context)),
          ],
        ),
      ),
    );
  }

  Future<void> _finalizeReturn(DeliveryActiveReturnDraft draft) async {
    final l10n = AppLocalizations.of(context)!;
    if (!_signatureAcknowledged) {
      UtilityMockFeedback.showError(context, l10n.returnSignatureRequired);
      return;
    }

    final confirmed = await UtilityMockFeedback.confirm(
      context: context,
      title: l10n.returnFinalizeReturn,
      message: l10n.returnFinalizeDisclaimer,
      confirmLabel: l10n.returnFinalizeReturn,
      cancelLabel: MaterialLocalizations.of(context).cancelButtonLabel,
      icon: Icons.assignment_return_outlined,
    );
    if (!confirmed || !mounted) return;

    ref.read(deliveryReturnTasksProvider.notifier).removeTask(draft.taskId);
    ref
        .read(deliveryReturnStatsProvider.notifier)
        .recordRefund(draft.netRefundJod);
    ref.read(deliveryActiveReturnProvider.notifier).clear();

    UtilityDemoActions.complete(context, successMessage: l10n.returnFinalizeReturn);
    context.go(AppRoutePaths.delivery);
  }
}

enum _ReturnChecklistItem { bowls, plates }

class _ReturnChecklistStep extends StatelessWidget {
  const _ReturnChecklistStep({
    required this.draft,
    required this.onChanged,
    required this.onContinue,
  });

  final DeliveryActiveReturnDraft draft;
  final void Function(String itemKey, bool missing) onChanged;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ProcessHero(
          value: 0.5,
          title: l10n.returnStep1Title,
          subtitle: l10n.screenPlatedReturnProcessSubtitle,
        ),
        SizedBox(height: CoreSpacing.lg(context)),
        _ReturnOrderCard(draft: draft),
        SizedBox(height: CoreSpacing.lg(context)),
        WidgetsAppCard(
          variant: WidgetsAppCardVariant.form,
          padding: EdgeInsets.all(CoreSpacing.lg(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  WidgetsIconBubble(borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)), 
                    icon: Icons.fact_check_outlined,
                    color: scheme.primary,
                  ),
                  SizedBox(width: CoreSpacing.sm(context)),
                  Expanded(
                    child: Text(
                      l10n.returnExpectedCeramicItems,
                      style: CoreTypography.titleMedium(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
              SizedBox(height: CoreSpacing.md(context)),
              _ConditionItemCard(
                itemKey: _ReturnChecklistItem.bowls.name,
                title: l10n.returnDeepBowls,
                subtitle: l10n.returnDeepBowlsMeta,
                deposit: l10n.returnTrayDeposit,
                icon: Icons.soup_kitchen_outlined,
                missing: draft.missingItemKeys.contains(
                  _ReturnChecklistItem.bowls.name,
                ),
                onChanged: onChanged,
              ),
              SizedBox(height: CoreSpacing.sm(context)),
              _ConditionItemCard(
                itemKey: _ReturnChecklistItem.plates.name,
                title: l10n.returnMainPlates,
                subtitle: l10n.returnMainPlatesMeta,
                deposit: l10n.returnPlatterDeposit,
                icon: Icons.dinner_dining_outlined,
                missing: draft.missingItemKeys.contains(
                  _ReturnChecklistItem.plates.name,
                ),
                onChanged: onChanged,
              ),
            ],
          ),
        ),
        SizedBox(height: CoreSpacing.lg(context)),
        _WarningPanel(message: l10n.returnMissingWarning),
        SizedBox(height: CoreSpacing.lg(context)),
        WidgetsAppButton(
          label: l10n.returnContinueStep2,
          onPressed: onContinue,
          icon: Icons.chevron_right,
          iconAlignment: IconAlignment.end,
          variant: WidgetsAppButtonVariant.secondary,
          fullWidth: true,
        ),
      ],
    );
  }
}

class _ReturnSettlementStep extends StatelessWidget {
  const _ReturnSettlementStep({
    required this.draft,
    required this.signatureAcknowledged,
    required this.onBack,
    required this.onFinalize,
    required this.onClearSignature,
    required this.onAcknowledgeSignature,
  });

  final DeliveryActiveReturnDraft draft;
  final bool signatureAcknowledged;
  final VoidCallback onBack;
  final VoidCallback onFinalize;
  final VoidCallback onClearSignature;
  final VoidCallback onAcknowledgeSignature;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ProcessHero(
          value: 1,
          title: l10n.returnConfirmation,
          subtitle: l10n.returnVerificationBody,
        ),
        SizedBox(height: CoreSpacing.lg(context)),
        _SettlementSummaryCard(draft: draft),
        SizedBox(height: CoreSpacing.lg(context)),
        _SignatureCard(
          acknowledged: signatureAcknowledged,
          onClear: onClearSignature,
          onAcknowledge: onAcknowledgeSignature,
        ),
        SizedBox(height: CoreSpacing.md(context)),
        Row(
          children: [
            Expanded(
              child: WidgetsAppButton(
                label: l10n.prepBack,
                onPressed: onBack,
                icon: Icons.arrow_back,
                variant: WidgetsAppButtonVariant.outline,
              ),
            ),
            SizedBox(width: CoreSpacing.sm(context)),
            Expanded(
              child: WidgetsAppButton(
                label: l10n.returnFinalizeReturn,
                onPressed: onFinalize,
                icon: Icons.check,
              ),
            ),
          ],
        ),
        SizedBox(height: CoreSpacing.md(context)),
        Text(
          l10n.returnFinalizeDisclaimer,
          textAlign: TextAlign.center,
          style: CoreTypography.caption(context, scheme.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _ProcessHero extends StatelessWidget {
  const _ProcessHero({
    required this.value,
    required this.title,
    required this.subtitle,
  });

  final double value;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
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
                icon: Icons.assignment_return_outlined,
                color: scheme.primary,
                size: CoreContentSizes.emptyStateIcon(context), iconSize: CoreContentSizes.kpiIcon(context),
              ),
              SizedBox(width: CoreSpacing.md(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: CoreTypography.headlineSmall(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    Text(
                      subtitle,
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
          ClipRRect(
            borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
            child: LinearProgressIndicator(
              value: value,
              minHeight: CoreSpacing.xs(context),
              backgroundColor: scheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(scheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReturnOrderCard extends StatelessWidget {
  const _ReturnOrderCard({required this.draft});

  final DeliveryActiveReturnDraft draft;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final customerName = isAr ? draft.customerNameAr : draft.customerNameEn;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      accentColor: CoreColors.semanticSuccess,
      child: Row(
        children: [
          WidgetsIconBubble(borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)), 
            icon: Icons.receipt_long_outlined,
            color: CoreColors.semanticSuccess,
          ),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customerName,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  l10n.returnOrderMeta,
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          WidgetsSoftBadge(
            label: l10n.returnActiveReturn,
            color: CoreColors.semanticSuccess,
            icon: Icons.inventory_2_outlined,
          ),
        ],
      ),
    );
  }
}

class _ConditionItemCard extends StatelessWidget {
  const _ConditionItemCard({
    required this.itemKey,
    required this.title,
    required this.subtitle,
    required this.deposit,
    required this.icon,
    required this.missing,
    required this.onChanged,
  });

  final String itemKey;
  final String title;
  final String subtitle;
  final String deposit;
  final IconData icon;
  final bool missing;
  final void Function(String itemKey, bool missing) onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final color =
        missing ? CoreColors.semanticError : CoreColors.semanticSuccess;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
        border: Border.all(color: color.withValues(alpha: 0.20)),
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.md(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                WidgetsSoftBadge(
                  label: deposit,
                  color: color,
                  icon: Icons.savings_outlined,
                ),
              ],
            ),
            SizedBox(height: CoreSpacing.md(context)),
            Row(
              children: [
                Expanded(
                  child: _ConditionButton(
                    label: l10n.returnCollected,
                    selected: !missing,
                    color: CoreColors.semanticSuccess,
                    icon: Icons.check_circle_outline,
                    onTap: () => onChanged(itemKey, false),
                  ),
                ),
                SizedBox(width: CoreSpacing.sm(context)),
                Expanded(
                  child: _ConditionButton(
                    label: l10n.returnMissing,
                    selected: missing,
                    color: CoreColors.semanticError,
                    icon: Icons.error_outline,
                    onTap: () => onChanged(itemKey, true),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ConditionButton extends StatelessWidget {
  const _ConditionButton({
    required this.label,
    required this.selected,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.withValues(alpha: selected ? 0.16 : 0.04),
          borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
          border: Border.all(
            color: color.withValues(alpha: selected ? 0.32 : 0.12),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(CoreSpacing.sm(context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: selected ? color : scheme.onSurfaceVariant,
                size: CoreContentSizes.orderTypeIcon(context),
              ),
              SizedBox(width: CoreSpacing.xs(context)),
              Flexible(
                child: Text(
                  label,
                  style: CoreTypography.caption(
                    context,
                    selected ? color : scheme.onSurfaceVariant,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettlementSummaryCard extends StatelessWidget {
  const _SettlementSummaryCard({required this.draft});

  final DeliveryActiveReturnDraft draft;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final breakageLabel =
        draft.missingCount == 0
            ? l10n.returnWaived
            : '${l10n.returnBreakageTwoItems} (${draft.missingCount})';

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              WidgetsIconBubble(borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)), 
                icon: Icons.account_balance_wallet_outlined,
                color: CoreColors.semanticSuccess,
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Text(
                  l10n.returnRefundSummary,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
              WidgetsPriceBadge(
                priceLabel: UtilityFormatJod.format(
                  draft.netRefundJod,
                  suffix: l10n.currencyJod,
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAmountLine(
            label: l10n.returnOriginalDeposit,
            value: UtilityFormatJod.format(
              DeliveryActiveReturnDraft.originalDepositJod,
              suffix: l10n.currencyJod,
            ),
            valueColor: scheme.onSurface,
          ),
          WidgetsAmountLine(
            label: breakageLabel,
            value:
                draft.missingCount == 0
                    ? l10n.returnWaived
                    : '- ${UtilityFormatJod.format(draft.breakageTotalJod, suffix: l10n.currencyJod)}',
            valueColor: CoreColors.semanticError,
          ),
          WidgetsAmountLine(
            label: l10n.returnProcessingFee,
            value: l10n.returnWaived,
            valueColor: CoreColors.semanticSuccess,
          ),
          Divider(
            height: CoreSpacing.lg(context),
            color: scheme.outlineVariant,
          ),
          WidgetsAmountLine(
            label: l10n.returnFinalRefund,
            value: UtilityFormatJod.format(
              draft.netRefundJod,
              suffix: l10n.currencyJod,
            ),
            valueColor: CoreColors.semanticSuccess,
            strong: true,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _WarningPanel(message: l10n.returnReadyInstantCredit, success: true),
        ],
      ),
    );
  }
}

class _SignatureCard extends StatelessWidget {
  const _SignatureCard({
    required this.acknowledged,
    required this.onClear,
    required this.onAcknowledge,
  });

  final bool acknowledged;
  final VoidCallback onClear;
  final VoidCallback onAcknowledge;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              WidgetsIconBubble(borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)), 
                icon: Icons.draw_outlined,
                color: CoreColors.brandBrown,
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Text(
                  l10n.returnSignToConfirm,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          InkWell(
            onTap: onAcknowledge,
            borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color:
                    acknowledged
                        ? CoreColors.semanticSuccess.withValues(alpha: 0.08)
                        : scheme.surfaceContainerHighest.withValues(alpha: 0.36),
                borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
                border: Border.all(
                  color:
                      acknowledged
                          ? CoreColors.semanticSuccess
                          : scheme.outlineVariant,
                ),
              ),
              child: SizedBox(
                height: CoreContentSizes.heroImageHeight(context) * 0.58,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      acknowledged
                          ? Icons.check_circle_outline
                          : Icons.gesture_outlined,
                      color:
                          acknowledged
                              ? CoreColors.semanticSuccess
                              : CoreColors.brandBrown,
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    Text(
                      acknowledged
                          ? l10n.returnCollected
                          : l10n.returnSignatureRequired,
                      style: CoreTypography.caption(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: WidgetsAppButton(
              label: l10n.returnClearSignature,
              onPressed: acknowledged ? onClear : null,
              icon: Icons.clear,
              variant: WidgetsAppButtonVariant.ghost,
            ),
          ),
        ],
      ),
    );
  }
}

class _WarningPanel extends StatelessWidget {
  const _WarningPanel({required this.message, this.success = false});

  final String message;
  final bool success;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color =
        success ? CoreColors.semanticSuccess : CoreColors.semanticError;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
        border: Border.all(color: color.withValues(alpha: 0.20)),
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.md(context)),
        child: Row(
          children: [
            Icon(
              success ? Icons.check_circle_outline : Icons.info_outline,
              color: color,
              size: CoreContentSizes.buttonIcon(context),
            ),
            SizedBox(width: CoreSpacing.sm(context)),
            Expanded(
              child: Text(
                message,
                style: CoreTypography.bodyMedium(context, scheme.onSurface),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




