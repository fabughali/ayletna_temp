import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/admin_dashboard_providers.dart';
import 'package:ayletna_restaurant_app/providers/admin_session_providers.dart';
import 'package:ayletna_restaurant_app/providers/owner_view_config_providers.dart';
import 'package:ayletna_restaurant_app/data/models/model_owner_view_config.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_file_download.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/utilities/utility_report_export.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_hero_metric.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_bubble.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_read_only_hub_banner.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_amount_line.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_soft_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [FinancialCalculationScreen].
class AdminFinancialCalculationScreen extends ConsumerWidget {
  const AdminFinancialCalculationScreen({this.readOnly = false, super.key});

  final bool readOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final ownerMask = readOnly
        ? ref.watch(effectiveOwnerViewMaskProvider)
        : OwnerViewMask.none;

    return WidgetsScaffoldPage(
      title: l10n.screenFinancialCalculation,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.operatorReports),
          icon: Icons.analytics_outlined,
          tooltip: l10n.screenReports,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(adminDashboardMetricsProvider);
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 880;
            final closeColumn = Column(
              children: [
                _CashCloseCard(l10n: l10n, isAr: isAr, mask: ownerMask),
                if (!ownerMask.netProfitOnly) ...[
                  SizedBox(height: CoreSpacing.lg(context)),
                  _TenderReconciliationCard(l10n: l10n, isAr: isAr),
                  SizedBox(height: CoreSpacing.lg(context)),
                  _DepositRefundCard(l10n: l10n, isAr: isAr),
                ],
              ],
            );
            final splitColumn = Column(
              children: [
                if (!ownerMask.hideStaffSalaries && !ownerMask.netProfitOnly)
                  _TipAndVarianceCard(l10n: l10n, isAr: isAr),
                if (!ownerMask.hideStaffSalaries && !ownerMask.netProfitOnly)
                  SizedBox(height: CoreSpacing.lg(context)),
                _ProfitSplitCard(l10n: l10n, isAr: isAr, mask: ownerMask),
                SizedBox(height: CoreSpacing.lg(context)),
                _CloseActionsCard(l10n: l10n, isAr: isAr, readOnly: readOnly),
              ],
            );

            return ListView(
              padding: EdgeInsetsDirectional.only(
                top: CoreSpacing.md(context),
                bottom: CoreSpacing.xxl(context),
              ),
              children: [
                if (readOnly) const WidgetsReadOnlyHubBanner(),
                _FinanceHero(l10n: l10n, isAr: isAr),
                SizedBox(height: CoreSpacing.lg(context)),
                if (isWide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 5, child: closeColumn),
                      SizedBox(width: CoreSpacing.lg(context)),
                      Expanded(flex: 5, child: splitColumn),
                    ],
                  )
                else ...[
                  closeColumn,
                  SizedBox(height: CoreSpacing.lg(context)),
                  splitColumn,
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _FinanceHero extends StatelessWidget {
  const _FinanceHero({required this.l10n, required this.isAr});

  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
        gradient: const LinearGradient(
          colors: [CoreColors.semanticRevenue, CoreColors.brandBrown],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetsSoftBadge(
            label:
                l10n.financialCloseBadge,
            color: CoreColors.surfaceLight,
            foreground: CoreColors.brandBrown,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
l10n.financialCloseHeroHeadline,
            style: CoreTypography.headlineSmall(
              context,
              CoreColors.surfaceLight,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.sm(context),
            children: [
              WidgetsHeroMetric(
                label: l10n.financialCloseShiftRevenue,
                value: UtilityFormatJod.format(
                  MockupCatalog.cashierShiftRevenueJod,
                  suffix: l10n.currencyJod,
                ),
                icon: Icons.point_of_sale_outlined,
              ),
              WidgetsHeroMetric(
                label: l10n.financialCloseOrdersCount,
                value: '${MockupCatalog.cashierShiftOrdersCount}',
                icon: Icons.receipt_long_outlined,
              ),
              WidgetsHeroMetric(
                label: l10n.financialCloseDistributableNet,
                value: UtilityFormatJod.format(
                  MockupCatalog.financialNetRevenueJod,
                  suffix: l10n.currencyJod,
                ),
                icon: Icons.account_balance_wallet_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CashCloseCard extends StatelessWidget {
  const _CashCloseCard({
    required this.l10n,
    required this.isAr,
    this.mask = OwnerViewMask.none,
  });

  final AppLocalizations l10n;
  final bool isAr;
  final OwnerViewMask mask;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: l10n.financialCloseSummaryTitle,
      subtitle:
l10n.financialCloseSummarySubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.fact_check_outlined,
        color: CoreColors.semanticRevenue,
      ),
      child: Column(
        children: [
          if (!mask.netProfitOnly) ...[
            WidgetsAmountLine(
              label: l10n.financialGrossRevenue,
              value: UtilityFormatJod.format(MockupCatalog.financialGrossRevenueJod, suffix: l10n.currencyJod),
              valueColor: CoreColors.semanticRevenue,
              strong: true,
            ),
            if (!mask.hideRawCosts)
              WidgetsAmountLine(
                label: l10n.financialOperationalExpenses,
                value: UtilityFormatJod.format(-MockupCatalog.financialOperationalExpensesJod, suffix: l10n.currencyJod),
                valueColor: CoreColors.semanticError,
                strong: true,
              ),
          ],
          WidgetsAmountLine(
            label: l10n.financialNetRevenue,
            value: UtilityFormatJod.format(mask.netProfitOnly ? 0 : MockupCatalog.financialNetRevenueJod, suffix: l10n.currencyJod),
            valueOverride: mask.netProfitOnly ? '••••••' : null,
            valueColor: CoreColors.brandOlive,
            strong: true,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _StatusStrip(
            label: l10n.financialCloseStatusLabel,
            value: l10n.financialCloseStatusReady,
            color: CoreColors.semanticSuccess,
          ),
        ],
      ),
    );
  }
}

class _TenderReconciliationCard extends StatelessWidget {
  const _TenderReconciliationCard({required this.l10n, required this.isAr});

  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    final cash = MockupCatalog.financialGrossRevenueJod * 0.34;
    final card = MockupCatalog.financialGrossRevenueJod * 0.52;
    final wallet = MockupCatalog.financialGrossRevenueJod * 0.14;
    return WidgetsAppCard(
      title: l10n.financialCloseTenderTitle,
      subtitle:
l10n.financialCloseTenderSubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.payments_outlined,
        color: CoreColors.orderTypeDelivery,
      ),
      child: Column(
        children: [
          _TenderRow(
            label: l10n.financialCloseCash,
            amount: cash,
            expected: cash,
            color: CoreColors.brandBrown,
            l10n: l10n,
          ),
          _TenderRow(
            label: l10n.financialCloseCards,
            amount: card,
            expected: card,
            color: CoreColors.orderTypeDelivery,
            l10n: l10n,
          ),
          _TenderRow(
            label: l10n.financialCloseWallet,
            amount: wallet,
            expected: wallet,
            color: CoreColors.brandOlive,
            l10n: l10n,
          ),
        ],
      ),
    );
  }
}

class _DepositRefundCard extends StatelessWidget {
  const _DepositRefundCard({required this.l10n, required this.isAr});

  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: l10n.financialCloseDepositsTitle,
      subtitle: l10n.financialCloseDepositsExcludedSubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.room_service_outlined,
        color: CoreColors.semanticDeposit,
      ),
      child: Column(
        children: [
          WidgetsAmountLine(
            label: l10n.financialEscrowDeposits,
            value: UtilityFormatJod.format(MockupCatalog.financialEscrowDepositsJod, suffix: l10n.currencyJod),
            valueColor: CoreColors.semanticDeposit,
            strong: true,
          ),
          WidgetsAmountLine(
            label: l10n.financialCloseRefundsToday,
            value: UtilityFormatJod.format(-MockupCatalog.checkoutPlatedDepositJod * 6, suffix: l10n.currencyJod),
            valueColor: CoreColors.semanticError,
            strong: true,
          ),
          WidgetsAmountLine(
            label: l10n.financialCloseBreakageFees,
            value: UtilityFormatJod.format(MockupCatalog.adminLossBreakageJod, suffix: l10n.currencyJod),
            valueColor: CoreColors.brandOrange,
            strong: true,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.financialCloseReviewTrayReturns,
            onPressed: () => context.push(AppRoutePaths.operatorPlates),
            icon: Icons.inventory_2_outlined,
            variant: WidgetsAppButtonVariant.outline,
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}

class _TipAndVarianceCard extends StatelessWidget {
  const _TipAndVarianceCard({required this.l10n, required this.isAr});

  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: l10n.financialCloseTipsTitle,
      subtitle: l10n.financialCloseTipsSeparateSubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.volunteer_activism_outlined,
        color: CoreColors.semanticTip,
      ),
      child: Column(
        children: [
          WidgetsAmountLine(
            label: l10n.financialTotalTipsExcluded,
            value: UtilityFormatJod.format(MockupCatalog.financialTotalTipsJod, suffix: l10n.currencyJod),
            valueColor: CoreColors.semanticTip,
            strong: true,
          ),
          WidgetsAmountLine(
            label: l10n.financialCloseCurrentTips,
            value: UtilityFormatJod.format(MockupCatalog.cashierShiftTipsJod, suffix: l10n.currencyJod),
            valueColor: CoreColors.semanticTip,
            strong: true,
          ),
          _StatusStrip(
            label: l10n.financialCloseVariance,
            value: UtilityFormatJod.format(0, suffix: l10n.currencyJod),
            color: CoreColors.semanticSuccess,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.adminTipDistributeAction,
            onPressed: () => context.push(AppRoutePaths.operatorTipDistribution),
            icon: Icons.payments_outlined,
            variant: WidgetsAppButtonVariant.secondary,
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}

class _ProfitSplitCard extends StatelessWidget {
  const _ProfitSplitCard({
    required this.l10n,
    required this.isAr,
    this.mask = OwnerViewMask.none,
  });

  final AppLocalizations l10n;
  final bool isAr;
  final OwnerViewMask mask;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: l10n.financialCloseSplitTitle,
      subtitle: l10n.financialCloseSplitAfterCostsSubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.pie_chart_outline,
        color: CoreColors.brandOlive,
      ),
      child: Column(
        children: [
          _SplitRow(
            label: l10n.financialOwnerShare,
            rate: MockupCatalog.financialOwnerShareRate,
            amount: MockupCatalog.financialOwnerShareJod,
            amountOverride: mask.netProfitOnly ? '••••••' : null,
            color: CoreColors.brandOlive,
            l10n: l10n,
          ),
          if (!mask.netProfitOnly)
            _SplitRow(
              label: l10n.financialOperatorShare,
              rate: MockupCatalog.financialOperatorShareRate,
              amount: MockupCatalog.financialOperatorShareJod,
              color: CoreColors.orderTypeDelivery,
              l10n: l10n,
            ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            l10n.financialWhyBody,
            style: CoreTypography.caption(
              context,
              Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _CloseActionsCard extends ConsumerWidget {
  const _CloseActionsCard({
    required this.l10n,
    required this.isAr,
    this.readOnly = false,
  });

  final AppLocalizations l10n;
  final bool isAr;
  final bool readOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final approved = ref.watch(adminFinancialProvider).shiftCloseApproved;
    if (readOnly) {
      return WidgetsAppCard(
        title: l10n.financialCloseApproveTitle,
        subtitle: l10n.financialCloseOwnerViewOnly,
        child: Text(
          approved
              ? l10n.financialCloseApprovedReadOnly
              : l10n.financialCloseAwaitingApproval,
          style: CoreTypography.bodyMedium(
            context,
            Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }
    return WidgetsAppCard(
      title: l10n.financialCloseApproveTitle,
      subtitle: l10n.financialCloseApproveUiOnlySubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WidgetsAppButton(
            label: l10n.financialCloseApproveShift,
            onPressed:
                approved
                    ? null
                    : () async {
                      final confirmed = await UtilityMockFeedback.confirm(
                        context: context,
                        title: l10n.financialCloseApproveConfirmTitle,
                        message: l10n.financialCloseApproveMockMessage,
                        confirmLabel: l10n.actionConfirm,
                        cancelLabel: l10n.actionCancel,
                        icon: Icons.fact_check_outlined,
                      );
                      if (!context.mounted || !confirmed) return;
                      ref
                          .read(adminFinancialProvider.notifier)
                          .approveShiftClose();
                      UtilityMockFeedback.showSuccess(
                        context,
                        l10n.financialCloseApprovedSuccess,
                      );
                    },
            icon: Icons.check_circle_outline,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppButton(
            label: l10n.financialPdfReport,
            onPressed: () async {
              final html = buildFinancialCloseHtml(
                shiftCloseApproved: approved,
                isAr: isAr,
              );
              await downloadTextFile(
                'ayletna-shift-close.html',
                html,
                mimeType: 'text/html',
              );
              if (!context.mounted) return;
              UtilityMockFeedback.showSuccess(
                context,
                l10n.financialCloseReportDownloaded,
              );
            },
            icon: Icons.description_outlined,
            variant: WidgetsAppButtonVariant.outline,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppButton(
            label: l10n.ownerRequestAudit,
            onPressed: () => context.push(AppRoutePaths.operatorReports),
            icon: Icons.history_edu_outlined,
            variant: WidgetsAppButtonVariant.outline,
          ),
        ],
      ),
    );
  }
}

class _TenderRow extends StatelessWidget {
  const _TenderRow({
    required this.label,
    required this.amount,
    required this.expected,
    required this.color,
    required this.l10n,
  });

  final String label;
  final double amount;
  final double expected;
  final Color color;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final variance = amount - expected;
    return Container(
      margin: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
      ),
      child: Column(
        children: [
          WidgetsAmountLine(
            label: label,
            value: UtilityFormatJod.format(amount, suffix: l10n.currencyJod),
            valueColor: color,
            compact: true,
            strong: true,
          ),
          _StatusStrip(
            label: l10n.financialCloseVarianceLabel,
            value: UtilityFormatJod.format(variance, suffix: l10n.currencyJod),
            color:
                variance == 0
                    ? CoreColors.semanticSuccess
                    : CoreColors.semanticError,
          ),
        ],
      ),
    );
  }
}

class _SplitRow extends StatelessWidget {
  const _SplitRow({
    required this.label,
    required this.rate,
    required this.amount,
    required this.color,
    required this.l10n,
    this.amountOverride,
  });

  final String label;
  final double rate;
  final double amount;
  final Color color;
  final AppLocalizations l10n;
  final String? amountOverride;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: CoreSpacing.md(context)),
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
        border: Border.all(color: color.withValues(alpha: 0.18)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: CoreTypography.titleMedium(
                    context,
                    Theme.of(context).colorScheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
              WidgetsSoftBadge(label: '${(rate * 100).round()}%', color: color),
            ],
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          ClipRRect(
            borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
            child: LinearProgressIndicator(
              value: rate,
              minHeight: 10,
              backgroundColor: color.withValues(alpha: 0.12),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Text(
              amountOverride ??
                  UtilityFormatJod.format(amount, suffix: l10n.currencyJod),
              style: CoreTypography.titleMedium(
                context,
                color,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusStrip extends StatelessWidget {
  const _StatusStrip({
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
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
      ),
      child: Row(
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
          WidgetsSoftBadge(label: value, color: color),
        ],
      ),
    );
  }
}
