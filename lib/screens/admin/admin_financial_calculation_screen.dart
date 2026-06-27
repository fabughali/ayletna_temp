import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/admin_dashboard_providers.dart';
import 'package:ayletna_restaurant_app/providers/admin_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_file_download.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/utilities/utility_report_export.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [FinancialCalculationScreen].
class AdminFinancialCalculationScreen extends ConsumerWidget {
  const AdminFinancialCalculationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return WidgetsScaffoldPage(
      title: l10n.screenFinancialCalculation,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.adminReports),
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
                _CashCloseCard(l10n: l10n, isAr: isAr),
                SizedBox(height: CoreSpacing.lg(context)),
                _TenderReconciliationCard(l10n: l10n, isAr: isAr),
                SizedBox(height: CoreSpacing.lg(context)),
                _DepositRefundCard(l10n: l10n, isAr: isAr),
              ],
            );
            final splitColumn = Column(
              children: [
                _TipAndVarianceCard(l10n: l10n, isAr: isAr),
                SizedBox(height: CoreSpacing.lg(context)),
                _ProfitSplitCard(l10n: l10n, isAr: isAr),
                SizedBox(height: CoreSpacing.lg(context)),
                _CloseActionsCard(l10n: l10n, isAr: isAr),
              ],
            );

            return ListView(
              padding: EdgeInsetsDirectional.only(
                top: CoreSpacing.md(context),
                bottom: CoreSpacing.xxl(context),
              ),
              children: [
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
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
        gradient: const LinearGradient(
          colors: [CoreColors.semanticRevenue, CoreColors.brandBrown],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SoftBadge(
            label:
                isAr ? 'إغلاق كاش وتقسيم أرباح' : 'Cash Close & Profit Split',
            color: CoreColors.surfaceLight,
            foreground: CoreColors.brandBrown,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            isAr
                ? 'راجع الوردية، النقد، البطاقات، العربون، البقشيش، ثم اعتمد صافي الربح.'
                : 'Reconcile shift revenue, cash, cards, deposits, tips, then approve net profit.',
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
              _HeroMetric(
                label: isAr ? 'إيراد الوردية' : 'Shift revenue',
                value: UtilityFormatJod.format(
                  MockupCatalog.cashierShiftRevenueJod,
                  suffix: l10n.currencyJod,
                ),
                icon: Icons.point_of_sale_outlined,
              ),
              _HeroMetric(
                label: isAr ? 'طلبات' : 'Orders',
                value: '${MockupCatalog.cashierShiftOrdersCount}',
                icon: Icons.receipt_long_outlined,
              ),
              _HeroMetric(
                label: isAr ? 'صافي قابل للتوزيع' : 'Distributable net',
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
  const _CashCloseCard({required this.l10n, required this.isAr});

  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: isAr ? 'ملخص إغلاق الوردية' : 'Shift Close Summary',
      subtitle:
          isAr
              ? 'القراءة العملية قبل اعتماد الإغلاق.'
              : 'Operational numbers before approving the close.',
      leading: const _IconBubble(
        icon: Icons.fact_check_outlined,
        color: CoreColors.semanticRevenue,
      ),
      child: Column(
        children: [
          _AmountLine(
            label: l10n.financialGrossRevenue,
            value: MockupCatalog.financialGrossRevenueJod,
            color: CoreColors.semanticRevenue,
          ),
          _AmountLine(
            label: l10n.financialOperationalExpenses,
            value: -MockupCatalog.financialOperationalExpensesJod,
            color: CoreColors.semanticError,
          ),
          _AmountLine(
            label: l10n.financialNetRevenue,
            value: MockupCatalog.financialNetRevenueJod,
            color: CoreColors.brandOlive,
            strong: true,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _StatusStrip(
            label: isAr ? 'الحالة' : 'Status',
            value: isAr ? 'جاهز للإغلاق' : 'Ready to close',
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
      title: isAr ? 'مطابقة طرق الدفع' : 'Tender Reconciliation',
      subtitle:
          isAr
              ? 'النقد والبطاقات والمحفظة يجب أن تطابق سجل الكاشير.'
              : 'Cash, card, and wallet must match the cashier ledger.',
      leading: const _IconBubble(
        icon: Icons.payments_outlined,
        color: CoreColors.orderTypeDelivery,
      ),
      child: Column(
        children: [
          _TenderRow(
            label: isAr ? 'نقد' : 'Cash',
            amount: cash,
            expected: cash,
            color: CoreColors.brandBrown,
            l10n: l10n,
          ),
          _TenderRow(
            label: isAr ? 'بطاقات' : 'Cards',
            amount: card,
            expected: card,
            color: CoreColors.orderTypeDelivery,
            l10n: l10n,
          ),
          _TenderRow(
            label: isAr ? 'محفظة' : 'Wallet',
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
      title: isAr ? 'العربون والمرتجعات' : 'Deposits & Refunds',
      subtitle:
          isAr
              ? 'العربون أموال مشروطة، لا تدخل تقسيم الربح.'
              : 'Deposits are conditional funds and excluded from profit split.',
      leading: const _IconBubble(
        icon: Icons.room_service_outlined,
        color: CoreColors.semanticDeposit,
      ),
      child: Column(
        children: [
          _AmountLine(
            label: l10n.financialEscrowDeposits,
            value: MockupCatalog.financialEscrowDepositsJod,
            color: CoreColors.semanticDeposit,
          ),
          _AmountLine(
            label: isAr ? 'استردادات اليوم' : 'Refunds today',
            value: -MockupCatalog.checkoutPlatedDepositJod * 6,
            color: CoreColors.semanticError,
          ),
          _AmountLine(
            label: isAr ? 'رسوم كسر محتملة' : 'Potential breakage fees',
            value: MockupCatalog.adminLossBreakageJod,
            color: CoreColors.brandOrange,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: isAr ? 'راجع إرجاع الصواني' : 'Review tray returns',
            onPressed: () => context.push(AppRoutePaths.adminPlates),
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
      title: isAr ? 'البقشيش والفروقات' : 'Tips & Variance',
      subtitle:
          isAr
              ? 'البقشيش منفصل عن الإيراد ويذهب للطاقم.'
              : 'Tips stay separate from revenue and go to staff.',
      leading: const _IconBubble(
        icon: Icons.volunteer_activism_outlined,
        color: CoreColors.semanticTip,
      ),
      child: Column(
        children: [
          _AmountLine(
            label: l10n.financialTotalTipsExcluded,
            value: MockupCatalog.financialTotalTipsJod,
            color: CoreColors.semanticTip,
          ),
          _AmountLine(
            label: isAr ? 'بقشيش الوردية الحالية' : 'Current shift tips',
            value: MockupCatalog.cashierShiftTipsJod,
            color: CoreColors.semanticTip,
          ),
          _StatusStrip(
            label: isAr ? 'فرق المطابقة' : 'Reconciliation variance',
            value: UtilityFormatJod.format(0, suffix: l10n.currencyJod),
            color: CoreColors.semanticSuccess,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.adminTipDistributeAction,
            onPressed: () => context.push(AppRoutePaths.adminTipDistribution),
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
  const _ProfitSplitCard({required this.l10n, required this.isAr});

  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: isAr ? 'تقسيم صافي الربح' : 'Net Profit Split',
      subtitle:
          isAr
              ? 'بعد استثناء البقشيش والعربون والمصاريف.'
              : 'After excluding tips, deposits, and operating expenses.',
      leading: const _IconBubble(
        icon: Icons.pie_chart_outline,
        color: CoreColors.brandOlive,
      ),
      child: Column(
        children: [
          _SplitRow(
            label: l10n.financialOwnerShare,
            rate: MockupCatalog.financialOwnerShareRate,
            amount: MockupCatalog.financialOwnerShareJod,
            color: CoreColors.brandOlive,
            l10n: l10n,
          ),
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
  const _CloseActionsCard({required this.l10n, required this.isAr});

  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final approved = ref.watch(adminFinancialProvider).shiftCloseApproved;
    return WidgetsAppCard(
      title: isAr ? 'اعتماد الإغلاق' : 'Approve Close',
      subtitle:
          isAr
              ? 'إجراءات الواجهة فقط، بدون تحويلات فعلية.'
              : 'UI-only actions, no real transfers.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WidgetsAppButton(
            label: isAr ? 'اعتماد إغلاق الوردية' : 'Approve shift close',
            onPressed:
                approved
                    ? null
                    : () async {
                      final confirmed = await UtilityMockFeedback.confirm(
                        context: context,
                        title: isAr ? 'اعتماد الإغلاق' : 'Approve close',
                        message:
                            isAr
                                ? 'سيتم تسجيل اعتماد وهمي لهذه الوردية.'
                                : 'A mock approval will be logged for this shift.',
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
                        isAr ? 'تم اعتماد الإغلاق' : 'Shift close approved',
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
                isAr
                    ? 'تم تنزيل التقرير — اطبع كـ PDF من المتصفح'
                    : 'Report downloaded — print to PDF from browser',
              );
            },
            icon: Icons.description_outlined,
            variant: WidgetsAppButtonVariant.outline,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppButton(
            label: l10n.ownerRequestAudit,
            onPressed: () => context.push(AppRoutePaths.adminAudit),
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
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
      ),
      child: Column(
        children: [
          _AmountLine(label: label, value: amount, color: color, compact: true),
          _StatusStrip(
            label: 'Variance',
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
  });

  final String label;
  final double rate;
  final double amount;
  final Color color;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: CoreSpacing.md(context)),
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
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
              _SoftBadge(label: '${(rate * 100).round()}%', color: color),
            ],
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          ClipRRect(
            borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
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

class _AmountLine extends StatelessWidget {
  const _AmountLine({
    required this.label,
    required this.value,
    required this.color,
    this.strong = false,
    this.compact = false,
  });

  final String label;
  final double value;
  final Color color;
  final bool strong;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.only(
        bottom: compact ? CoreSpacing.xs(context) : CoreSpacing.sm(context),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: CoreTypography.bodyMedium(
                context,
                Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Text(
            UtilityFormatJod.format(value, suffix: l10n.currencyJod),
            style: (strong
                    ? CoreTypography.headlineSmall(context, color)
                    : CoreTypography.titleMedium(context, color))
                .copyWith(fontWeight: FontWeight.w900),
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
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
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
          _SoftBadge(label: value, color: color),
        ],
      ),
    );
  }
}

class _HeroMetric extends StatelessWidget {
  const _HeroMetric({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      decoration: BoxDecoration(
        color: CoreColors.surfaceLight.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
        border: Border.all(
          color: CoreColors.surfaceLight.withValues(alpha: 0.30),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: CoreColors.surfaceLight),
          SizedBox(width: CoreSpacing.sm(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.titleMedium(
                    context,
                    CoreColors.surfaceLight,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.caption(
                    context,
                    CoreColors.surfaceLight.withValues(alpha: 0.84),
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

class _IconBubble extends StatelessWidget {
  const _IconBubble({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
      ),
      child: Icon(icon, color: color, size: 22),
    );
  }
}

class _SoftBadge extends StatelessWidget {
  const _SoftBadge({required this.label, required this.color, this.foreground});

  final String label;
  final Color color;
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: CoreSpacing.sm(context),
        vertical: CoreSpacing.xs(context),
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: foreground == null ? 0.12 : 1),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
      ),
      child: Text(
        label,
        style: CoreTypography.caption(
          context,
          foreground ?? color,
        ).copyWith(fontWeight: FontWeight.w900),
      ),
    );
  }
}
