import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/admin_dashboard_providers.dart';
import 'package:ayletna_restaurant_app/providers/attendance_hr_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_file_download.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_report_export.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_report_filter_sheet.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [ReportsScreen].
class AdminReportsScreen extends ConsumerStatefulWidget {
  const AdminReportsScreen({super.key});

  @override
  ConsumerState<AdminReportsScreen> createState() => _AdminReportsScreenState();
}

class _AdminReportsScreenState extends ConsumerState<AdminReportsScreen> {
  _ReportPeriod _period = _ReportPeriod.daily;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return WidgetsScaffoldPage(
      title: l10n.screenReports,
      actions: [
        WidgetsIconButton(
          onPressed: () => WidgetsReportFilterSheet.show(context),
          icon: Icons.tune_outlined,
          tooltip: l10n.screenReportFilter,
        ),
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.adminFinancial),
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
                _ExecutiveScorecards(l10n: l10n, isAr: isAr),
                SizedBox(height: CoreSpacing.lg(context)),
                _SalesTrendCard(l10n: l10n, isAr: isAr),
              ],
            );
            final insights = Column(
              children: [
                _InsightQueueCard(l10n: l10n, isAr: isAr),
                SizedBox(height: CoreSpacing.lg(context)),
                _ReportModulesCard(l10n: l10n, isAr: isAr),
                SizedBox(height: CoreSpacing.lg(context)),
                _ExportCenterCard(l10n: l10n, isAr: isAr, period: _period),
              ],
            );

            return ListView(
              padding: EdgeInsetsDirectional.only(
                top: CoreSpacing.md(context),
                bottom: CoreSpacing.xxl(context),
              ),
              children: [
                _ReportsHero(l10n: l10n, isAr: isAr),
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
  const _ReportsHero({required this.l10n, required this.isAr});

  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
        gradient: const LinearGradient(
          colors: [CoreColors.brandOlive, CoreColors.brandBrown],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SoftBadge(
            label: isAr ? 'مركز تحليلات المطعم' : 'Restaurant Analytics Hub',
            color: CoreColors.surfaceLight,
            foreground: CoreColors.brandBrown,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            isAr
                ? 'اربط المبيعات، القنوات، البقشيش، الهدر، والصواني بقرارات تشغيل واضحة.'
                : 'Connect sales, channels, tips, waste, and trays to clear operating decisions.',
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
                label: l10n.reportsDailySales,
                value: UtilityFormatJod.format(
                  MockupCatalog.adminRevenueJod,
                  suffix: l10n.currencyJod,
                ),
                icon: Icons.payments_outlined,
              ),
              _HeroMetric(
                label: l10n.adminKpiOrders,
                value: '${MockupCatalog.adminTodayOrders}',
                icon: Icons.receipt_long_outlined,
              ),
              _HeroMetric(
                label: l10n.reportsTipTotals,
                value: UtilityFormatJod.format(
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
  const _ExecutiveScorecards({required this.l10n, required this.isAr});

  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: isAr ? 'مؤشرات تشغيلية' : 'Operating Scorecards',
      subtitle:
          isAr
              ? 'أرقام تقود قرارات اليوم، لا ملفات تصدير فقط.'
              : 'Numbers that drive today, not just export files.',
      leading: const _IconBubble(
        icon: Icons.query_stats_outlined,
        color: CoreColors.brandOlive,
      ),
      child: Column(
        children: [
          _ScoreRow(
            label: isAr ? 'متوسط الطلب' : 'Average order',
            value: UtilityFormatJod.format(
              MockupCatalog.cashierAverageOrderJod,
              suffix: l10n.currencyJod,
            ),
            detail: l10n.cashierAverageOrder('8.80'),
            color: CoreColors.semanticRevenue,
          ),
          _ScoreRow(
            label: isAr ? 'إرجاع الصواني' : 'Tray return success',
            value:
                '${MockupCatalog.deliveryReturnsSuccessRate.toStringAsFixed(1)}%',
            detail: l10n.reportsSustainabilityBody,
            color: CoreColors.orderTypePlated,
          ),
          _ScoreRow(
            label: isAr ? 'تكلفة الهدر والكسر' : 'Waste & breakage cost',
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
  const _SalesTrendCard({required this.l10n, required this.isAr});

  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: l10n.reportsRevenueTrend,
      subtitle:
          isAr
              ? 'اتجاه الطلبات خلال آخر ساعات الخدمة.'
              : 'Order trend across recent service hours.',
      leading: const _IconBubble(
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
            label: isAr ? 'ذروة اليوم' : 'Today peak',
            value:
                isAr ? 'الغداء والتوصيل المسائي' : 'Lunch and evening delivery',
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
      title: isAr ? 'قرارات مقترحة' : 'Recommended Decisions',
      subtitle:
          isAr
              ? 'تحليلات مرتبطة بتشغيل المطعم.'
              : 'Analytics connected to restaurant operations.',
      leading: const _IconBubble(
        icon: Icons.lightbulb_outline,
        color: CoreColors.brandOrange,
      ),
      child: Column(
        children: [
          _InsightRow(
            label:
                isAr
                    ? 'زِد تحضير الشاورما قبل الغداء'
                    : 'Increase shawarma prep before lunch',
            detail:
                isAr
                    ? 'مبيعات القناة أعلى من المتوسط بـ ١٢٪.'
                    : 'Channel sales are 12% above baseline.',
            color: CoreColors.brandOrange,
          ),
          _InsightRow(
            label: isAr ? 'راجع هدر المقالي' : 'Review fryer wastage',
            detail: l10n.reportsInventoryWastageBody,
            color: CoreColors.semanticError,
          ),
          _InsightRow(
            label: isAr ? 'اعتمد توزيع البقشيش' : 'Approve tip distribution',
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
      title: isAr ? 'وحدات التحليل' : 'Analytics Modules',
      subtitle: l10n.reportsDetailedReports,
      leading: const _IconBubble(
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
            route: AppRoutePaths.adminFinancial,
          ),
          _ModuleRow(
            title: l10n.reportsStaffTips,
            body: l10n.reportsStaffTipsBody,
            icon: Icons.badge_outlined,
            color: CoreColors.semanticTip,
            route: AppRoutePaths.adminTipDistribution,
          ),
          _ModuleRow(
            title: l10n.reportsInventoryWastage,
            body: l10n.reportsInventoryWastageBody,
            icon: Icons.inventory_outlined,
            color: CoreColors.brandOlive,
            route: AppRoutePaths.inventory,
          ),
          _ModuleRow(
            title: isAr ? 'الصواني والعربون' : 'Plates & deposits',
            body: l10n.reportsSustainabilityBody,
            icon: Icons.room_service_outlined,
            color: CoreColors.orderTypePlated,
            route: AppRoutePaths.adminPlates,
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
  });

  final AppLocalizations l10n;
  final bool isAr;
  final _ReportPeriod period;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metrics = ref.watch(adminDashboardMetricsProvider);
    final hr = ref.watch(attendanceHrProvider);

    return WidgetsAppCard(
      title: isAr ? 'تصدير ومشاركة' : 'Export & Share',
      subtitle:
          isAr
              ? 'التصدير أصبح نتيجة ثانوية، وليس مركز الشاشة.'
              : 'Exports are now an outcome, not the whole screen.',
      leading: const _IconBubble(
        icon: Icons.ios_share_outlined,
        color: CoreColors.brandBrown,
      ),
      child: Column(
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
                  content: Text(
                    isAr
                        ? 'تم تنزيل التقرير — اطبع كـ PDF من المتصفح'
                        : 'Report downloaded — print to PDF from browser',
                  ),
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
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
      ),
      child: Row(
        children: [
          _IconBubble(
            icon: Icons.trending_up_outlined,
            color: color,
            compact: true,
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
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
        border: Border.all(color: color.withValues(alpha: 0.16)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _IconBubble(
            icon: Icons.insights_outlined,
            color: color,
            compact: true,
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
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
      ),
      child: Row(
        children: [
          _IconBubble(icon: icon, color: color),
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
      width: 184,
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
  const _IconBubble({
    required this.icon,
    required this.color,
    this.compact = false,
  });

  final IconData icon;
  final Color color;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final size = compact ? 36.0 : 42.0;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
      ),
      child: Icon(icon, color: color, size: compact ? 18 : 22),
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
