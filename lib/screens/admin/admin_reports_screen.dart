import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/admin_dashboard_providers.dart';
import 'package:ayletna_restaurant_app/providers/attendance_hr_providers.dart';
import 'package:ayletna_restaurant_app/providers/owner_view_config_providers.dart';
import 'package:ayletna_restaurant_app/data/models/model_owner_view_config.dart';
import 'package:ayletna_restaurant_app/utilities/utility_owner_view_mask.dart';
import 'package:ayletna_restaurant_app/utilities/utility_file_download.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_report_export.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_hero_metric.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_bubble.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_report_filter_sheet.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_read_only_hub_banner.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_soft_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [ReportsScreen].
class AdminReportsScreen extends ConsumerStatefulWidget {
  const AdminReportsScreen({this.readOnly = false, super.key});

  final bool readOnly;

  @override
  ConsumerState<AdminReportsScreen> createState() => _AdminReportsScreenState();
}

class _AdminReportsScreenState extends ConsumerState<AdminReportsScreen> {
  _ReportPeriod _period = _ReportPeriod.daily;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final ownerMask = widget.readOnly
        ? ref.watch(effectiveOwnerViewMaskProvider)
        : OwnerViewMask.none;

    return WidgetsScaffoldPage(
      title: l10n.screenReports,
      actions: [
        WidgetsIconButton(
          onPressed: () => WidgetsReportFilterSheet.show(context),
          icon: Icons.tune_outlined,
          tooltip: l10n.screenReportFilter,
        ),
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.operatorFinancial),
          icon: Icons.payments_outlined,
          tooltip: l10n.screenFinancialCalculation,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(attendanceHrProvider);
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 880;
            final scorecards = Column(
              children: [
                _ExecutiveScorecards(l10n: l10n, isAr: isAr, mask: ownerMask),
                SizedBox(height: CoreSpacing.lg(context)),
                _SalesTrendCard(l10n: l10n, isAr: isAr, mask: ownerMask),
              ],
            );
            final insights = Column(
              children: [
                _InsightQueueCard(l10n: l10n, isAr: isAr),
                SizedBox(height: CoreSpacing.lg(context)),
                _ReportModulesCard(l10n: l10n, isAr: isAr),
                SizedBox(height: CoreSpacing.lg(context)),
                _ExportCenterCard(
                  l10n: l10n,
                  isAr: isAr,
                  period: _period,
                  readOnly: widget.readOnly,
                ),
              ],
            );

            return ListView(
              padding: EdgeInsetsDirectional.only(
                top: CoreSpacing.md(context),
                bottom: CoreSpacing.xxl(context),
              ),
              children: [
                if (widget.readOnly) ...[
                  const WidgetsReadOnlyHubBanner(),
                  if (ownerMask.configId != null)
                    Padding(
                      padding: EdgeInsets.only(bottom: CoreSpacing.md(context)),
                      child: WidgetsAppCard(
                        child: ListTile(
                          leading: const Icon(Icons.visibility_outlined),
                          title: Text(l10n.ownerViewConfigApplied),
                          subtitle: Text(
                            ref
                                    .watch(
                                      ownerViewConfigByIdProvider(
                                        ownerMask.configId!,
                                      ),
                                    )
                                    ?.label(isAr) ??
                                ownerMask.configId!,
                          ),
                        ),
                      ),
                    ),
                ],
                _ReportsHero(l10n: l10n, isAr: isAr, mask: ownerMask),
                SizedBox(height: CoreSpacing.lg(context)),
                _PeriodSelector(
                  selected: _period,
                  onSelected: (period) => setState(() => _period = period),
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                if (isWide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 6, child: scorecards),
                      SizedBox(width: CoreSpacing.lg(context)),
                      Expanded(flex: 4, child: insights),
                    ],
                  )
                else ...[
                  scorecards,
                  SizedBox(height: CoreSpacing.lg(context)),
                  insights,
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

enum _ReportPeriod { daily, weekly, monthly }

class _ReportsHero extends StatelessWidget {
  const _ReportsHero({
    required this.l10n,
    required this.isAr,
    this.mask = OwnerViewMask.none,
  });

  final AppLocalizations l10n;
  final bool isAr;
  final OwnerViewMask mask;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
        gradient: const LinearGradient(
          colors: [CoreColors.brandOlive, CoreColors.brandBrown],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetsSoftBadge(
            label: l10n.reportsHubBadge,
            color: CoreColors.surfaceLight,
            foreground: CoreColors.brandBrown,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            l10n.reportsHubHeadline,
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
                label: l10n.reportsDailySales,
                value: UtilityOwnerViewMask.formatJod(
                  MockupCatalog.adminRevenueJod,
                  mask: mask,
                  sensitive: mask.netProfitOnly,
                  suffix: l10n.currencyJod,
                ),
                icon: Icons.payments_outlined,
              ),
              WidgetsHeroMetric(
                label: l10n.adminKpiOrders,
                value: mask.netProfitOnly
                    ? '—'
                    : '${MockupCatalog.adminTodayOrders}',
                icon: Icons.receipt_long_outlined,
              ),
              WidgetsHeroMetric(
                label: l10n.reportsTipTotals,
                value: UtilityOwnerViewMask.shouldHideStaffSection(mask)
                    ? '••••••'
                    : UtilityFormatJod.format(
                        MockupCatalog.adminTipPoolJod,
                        suffix: l10n.currencyJod,
                      ),
                icon: Icons.volunteer_activism_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PeriodSelector extends StatelessWidget {
  const _PeriodSelector({required this.selected, required this.onSelected});

  final _ReportPeriod selected;
  final ValueChanged<_ReportPeriod> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Wrap(
      spacing: CoreSpacing.sm(context),
      runSpacing: CoreSpacing.sm(context),
      children:
          _ReportPeriod.values.map((period) {
            final label = switch (period) {
              _ReportPeriod.daily => l10n.reportsDaily,
              _ReportPeriod.weekly => l10n.reportsWeekly,
              _ReportPeriod.monthly => l10n.reportsMonthly,
            };
            return ChoiceChip(
              label: Text(label),
              selected: selected == period,
              onSelected: (_) => onSelected(period),
              selectedColor: CoreColors.brandOlive.withValues(alpha: 0.18),
            );
          }).toList(),
    );
  }
}

class _ExecutiveScorecards extends StatelessWidget {
  const _ExecutiveScorecards({
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
      title: l10n.reportsOpsScorecardsTitle,
      subtitle: l10n.reportsOpsScorecardsSubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.query_stats_outlined,
        color: CoreColors.brandOlive,
      ),
      child: Column(
        children: [
          _ScoreRow(
            label: l10n.reportsAvgOrderLabel,
            value: UtilityFormatJod.format(
              MockupCatalog.cashierAverageOrderJod,
              suffix: l10n.currencyJod,
            ),
            detail: l10n.cashierAverageOrder('8.80'),
            color: CoreColors.semanticRevenue,
          ),
          _ScoreRow(
            label: l10n.reportsTrayReturnSuccess,
            value:
                '${MockupCatalog.deliveryReturnsSuccessRate.toStringAsFixed(1)}%',
            detail: l10n.reportsSustainabilityBody,
            color: CoreColors.orderTypePlated,
          ),
          if (!UtilityOwnerViewMask.shouldHideRawCostRow(mask))
            _ScoreRow(
              label: l10n.reportsWasteBreakageCost,
              value: UtilityFormatJod.format(
                MockupCatalog.adminLossBreakageJod,
                suffix: l10n.currencyJod,
              ),
              detail: l10n.reportsInventoryWastageBody,
              color: CoreColors.semanticError,
            ),
        ],
      ),
    );
  }
}

class _SalesTrendCard extends StatelessWidget {
  const _SalesTrendCard({
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
      title: l10n.reportsRevenueTrend,
      subtitle: l10n.reportsTrendSubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.show_chart_outlined,
        color: CoreColors.semanticRevenue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: CoreContentSizes.adminChartHeight(context),
            child: CustomPaint(
              painter: _RevenueTrendPainter(
                values: MockupCatalog.adminRevenueChart,
              ),
              child: const SizedBox.expand(),
            ),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _StatusStrip(
            label: l10n.reportsTodayPeakLabel,
            value: l10n.reportsTodayPeakValue,
            color: CoreColors.brandOrange,
          ),
        ],
      ),
    );
  }
}

class _InsightQueueCard extends StatelessWidget {
  const _InsightQueueCard({required this.l10n, required this.isAr});

  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: l10n.reportsDecisionsTitle,
      subtitle: l10n.reportsDecisionsSubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.lightbulb_outline,
        color: CoreColors.brandOrange,
      ),
      child: Column(
        children: [
          _InsightRow(
            label: l10n.reportsInsightShawarmaLabel,
            detail: l10n.reportsInsightShawarmaDetail,
            color: CoreColors.brandOrange,
          ),
          _InsightRow(
            label: l10n.reportsReviewFryerLabel,
            detail: l10n.reportsInventoryWastageBody,
            color: CoreColors.semanticError,
          ),
          _InsightRow(
            label: l10n.reportsApproveTipsLabel,
            detail: l10n.reportsStaffTipsBody,
            color: CoreColors.semanticTip,
          ),
        ],
      ),
    );
  }
}

class _ReportModulesCard extends StatelessWidget {
  const _ReportModulesCard({required this.l10n, required this.isAr});

  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: l10n.reportsModulesTitle,
      subtitle: l10n.reportsDetailedReports,
      leading: WidgetsIconBubble(
        icon: Icons.dashboard_customize_outlined,
        color: CoreColors.orderTypeDelivery,
      ),
      child: Column(
        children: [
          _ModuleRow(
            title: l10n.reportsSalesRevenue,
            body: l10n.reportsSalesRevenueBody,
            icon: Icons.receipt_long_outlined,
            color: CoreColors.semanticRevenue,
            route: AppRoutePaths.operatorFinancial,
          ),
          _ModuleRow(
            title: l10n.reportsStaffTips,
            body: l10n.reportsStaffTipsBody,
            icon: Icons.badge_outlined,
            color: CoreColors.semanticTip,
            route: AppRoutePaths.operatorTipDistribution,
          ),
          _ModuleRow(
            title: l10n.reportsInventoryWastage,
            body: l10n.reportsInventoryWastageBody,
            icon: Icons.inventory_outlined,
            color: CoreColors.brandOlive,
            route: AppRoutePaths.inventory,
          ),
          _ModuleRow(
            title: l10n.reportsPlatesDepositsTitle,
            body: l10n.reportsSustainabilityBody,
            icon: Icons.room_service_outlined,
            color: CoreColors.orderTypePlated,
            route: AppRoutePaths.operatorPlates,
          ),
        ],
      ),
    );
  }
}

class _ExportCenterCard extends ConsumerWidget {
  const _ExportCenterCard({
    required this.l10n,
    required this.isAr,
    required this.period,
    this.readOnly = false,
  });

  final AppLocalizations l10n;
  final bool isAr;
  final _ReportPeriod period;
  final bool readOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metrics = ref.watch(adminDashboardMetricsProvider);
    final hr = ref.watch(attendanceHrProvider);

    return WidgetsAppCard(
      title: l10n.reportsExportTitle,
      subtitle: l10n.reportsExportSubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.ios_share_outlined,
        color: CoreColors.brandBrown,
      ),
      child: readOnly
          ? Text(
              l10n.reportsExportOperatorOnly,
              style: CoreTypography.caption(
                context,
                Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WidgetsAppButton(
            label: l10n.reportsDownloadPdf,
            onPressed: () async {
              final html = buildReportsPrintableHtml(
                metrics: metrics,
                hr: hr,
                isAr: isAr,
              );
              await downloadTextFile(
                'ayletna-report-${period.name}.html',
                html,
                mimeType: 'text/html',
              );
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.financialCloseReportDownloaded),
                ),
              );
            },
            icon: Icons.picture_as_pdf_outlined,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppButton(
            label: l10n.reportsExportCsv,
            onPressed: () async {
              final csv = buildReportsCsv(metrics: metrics, hr: hr);
              await downloadTextFile(
                'ayletna-report-${period.name}.csv',
                csv,
                mimeType: 'text/csv',
              );
              if (!context.mounted) return;
              UtilityMockFeedback.showSuccess(context, l10n.reportsExportCsv);
            },
            icon: Icons.table_chart_outlined,
            variant: WidgetsAppButtonVariant.outline,
          ),
        ],
      ),
    );
  }
}

class _ScoreRow extends StatelessWidget {
  const _ScoreRow({
    required this.label,
    required this.value,
    required this.detail,
    required this.color,
  });

  final String label;
  final String value;
  final String detail;
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
          WidgetsIconBubble(
            icon: Icons.trending_up_outlined,
            color: color,
            size: UtilitySizer.of(context, 36), iconSize: CoreContentSizes.orderTypeIcon(context),
          ),
          SizedBox(width: CoreSpacing.sm(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: CoreTypography.titleMedium(
                    context,
                    Theme.of(context).colorScheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  detail,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.caption(
                    context,
                    Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: CoreSpacing.sm(context)),
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

class _InsightRow extends StatelessWidget {
  const _InsightRow({
    required this.label,
    required this.detail,
    required this.color,
  });

  final String label;
  final String detail;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
        border: Border.all(color: color.withValues(alpha: 0.16)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetsIconBubble(
            icon: Icons.insights_outlined,
            color: color,
            size: UtilitySizer.of(context, 36), iconSize: CoreContentSizes.orderTypeIcon(context),
          ),
          SizedBox(width: CoreSpacing.sm(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: CoreTypography.titleMedium(
                    context,
                    Theme.of(context).colorScheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  detail,
                  style: CoreTypography.caption(
                    context,
                    Theme.of(context).colorScheme.onSurfaceVariant,
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

class _ModuleRow extends StatelessWidget {
  const _ModuleRow({
    required this.title,
    required this.body,
    required this.icon,
    required this.color,
    required this.route,
  });

  final String title;
  final String body;
  final IconData icon;
  final Color color;
  final String route;

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
          WidgetsIconBubble(icon: icon, color: color),
          SizedBox(width: CoreSpacing.sm(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: CoreTypography.titleMedium(
                    context,
                    Theme.of(context).colorScheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.caption(
                    context,
                    Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          WidgetsAppButton(
            label: 'Open',
            onPressed: () => context.push(route),
            variant: WidgetsAppButtonVariant.ghost,
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

class _RevenueTrendPainter extends CustomPainter {
  const _RevenueTrendPainter({required this.values});

  final List<double> values;

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint =
        Paint()
          ..color = CoreColors.brandBrown.withValues(alpha: 0.08)
          ..strokeWidth = 1;
    for (var index = 1; index < 4; index++) {
      final y = size.height * index / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final barWidth = size.width / (values.length * 2);
    var x = barWidth * 0.5;
    for (var index = 0; index < values.length; index++) {
      final value = values[index];
      final color =
          index == values.length - 1
              ? CoreColors.semanticRevenue
              : CoreColors.brandOlive.withValues(alpha: 0.52);
      final rect = Rect.fromLTWH(
        x,
        size.height - (size.height * value),
        barWidth,
        size.height * value,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(barWidth / 2)),
        Paint()..color = color,
      );
      x += barWidth * 2;
    }
  }

  @override
  bool shouldRepaint(covariant _RevenueTrendPainter oldDelegate) {
    return oldDelegate.values != values;
  }
}
