import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/attendance_hr_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_file_download.dart';
import 'package:ayletna_restaurant_app/utilities/utility_report_export.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_filter_chip.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// HR attendance report with delay fees, absence, and overtime pay rules.
class AdminAttendanceHrScreen extends ConsumerWidget {
  const AdminAttendanceHrScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final hrState = ref.watch(attendanceHrProvider);
    final rows = ref.watch(attendanceHrReportProvider);
    final rules = hrState.rules;

    return WidgetsScaffoldPage(
      title: isAr ? 'تقرير الحضور والرواتب' : 'Attendance & Payroll',
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.staffAttendance),
          icon: Icons.fingerprint_outlined,
          tooltip: isAr ? 'حضور الموظفين' : 'Staff attendance',
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(attendanceHrProvider);
          ref.invalidate(attendanceHrReportProvider);
        },
        child: ListView(
          children: [
            SizedBox(height: CoreSpacing.md(context)),
            _RulesHero(isAr: isAr, rules: rules),
            SizedBox(height: CoreSpacing.lg(context)),
            Wrap(
              spacing: CoreSpacing.sm(context),
              children: [
                WidgetsFilterChip(
                  label: isAr ? 'يومي' : 'Daily',
                  selected: hrState.period == 'daily',
                  onSelected:
                      (_) =>
                          ref.read(attendanceHrProvider.notifier).setPeriod('daily'),
                ),
                WidgetsFilterChip(
                  label: isAr ? 'شهري' : 'Monthly',
                  selected: hrState.period == 'monthly',
                  onSelected:
                      (_) =>
                          ref.read(attendanceHrProvider.notifier).setPeriod('monthly'),
                ),
              ],
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            WidgetsAppCard(
              title: isAr ? 'إجمالي المستحق' : 'Total payable',
              child: Text(
                UtilityFormatJod.format(
                  hrState.totalPayableJod,
                  suffix: l10n.currencyJod,
                ),
                style: CoreTypography.headlineSmall(
                  context,
                  CoreColors.semanticRevenue,
                ).copyWith(fontWeight: FontWeight.w900),
              ),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            for (final row in rows) ...[
              _PayrollRow(row: row, isAr: isAr, l10n: l10n),
              SizedBox(height: CoreSpacing.md(context)),
            ],
            SizedBox(height: CoreSpacing.lg(context)),
            WidgetsAppButton(
              label: isAr ? 'تصدير CSV' : 'Export CSV',
              onPressed: () async {
                final csv = buildHrPayrollCsv(hr: hrState, rows: rows);
                await downloadTextFile(
                  'attendance-payroll-${hrState.period}.csv',
                  csv,
                  mimeType: 'text/csv',
                );
              },
              icon: Icons.download_outlined,
              variant: WidgetsAppButtonVariant.outline,
              fullWidth: true,
            ),
            SizedBox(height: CoreSpacing.xxl(context)),
          ],
        ),
      ),
    );
  }
}

class _RulesHero extends StatelessWidget {
  const _RulesHero({required this.isAr, required this.rules});

  final bool isAr;
  final AttendancePayRuleConfig rules;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isAr ? 'قواعد الرواتب' : 'Payroll rules',
            style: CoreTypography.titleMedium(
              context,
              Theme.of(context).colorScheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _RuleLine(
            isAr
                ? 'في الوقت (≤ ${rules.onTimeGraceMinutes} د) → 100% من الراتب'
                : 'On time (≤ ${rules.onTimeGraceMinutes} min) → 100% salary',
          ),
          _RuleLine(
            isAr
                ? 'تأخير > ${rules.onTimeGraceMinutes} د → خصم ${rules.delayFeeJod} ${isAr ? 'د.أ' : 'JOD'}'
                : 'Late > ${rules.onTimeGraceMinutes} min → ${rules.delayFeeJod} JOD delay fee',
          ),
          _RuleLine(
            isAr
                ? 'تأخير > ${rules.onTimeGraceMinutes + 15} د → خصم ×2'
                : 'Late > ${rules.onTimeGraceMinutes + 15} min → fee ×2',
          ),
          _RuleLine(
            isAr
                ? 'تأخير > ${rules.absenceAfterMinutes} د → غياب (0% حتى مع الحضور)'
                : 'Late > ${rules.absenceAfterMinutes} min → absence (0% even if present)',
          ),
          _RuleLine(
            isAr
                ? 'عمل > ${rules.overtimeThresholdMinutes} د إضافية → ${rules.overtimeMultiplier}× للساعات الإضافية'
                : 'Work > ${rules.overtimeThresholdMinutes} min beyond schedule → ${rules.overtimeMultiplier}× extra hours pay',
          ),
        ],
      ),
    );
  }
}

class _RuleLine extends StatelessWidget {
  const _RuleLine(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: CoreSpacing.xs(context)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_outline, size: 16, color: CoreColors.brandOlive),
          SizedBox(width: CoreSpacing.sm(context)),
          Expanded(
            child: Text(
              text,
              style: CoreTypography.caption(
                context,
                Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PayrollRow extends StatelessWidget {
  const _PayrollRow({
    required this.row,
    required this.isAr,
    required this.l10n,
  });

  final AttendanceHrReportRow row;
  final bool isAr;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final result = row.result;
    final record = row.record;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  isAr ? record.employeeNameAr : record.employeeNameEn,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
              WidgetsStatusPill(
                label: _outcomeLabel(result.outcome, isAr),
                color: _outcomeColor(result.outcome),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            record.roleEn,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Row(
            children: [
              _Metric(
                label: isAr ? 'التأخير' : 'Delay',
                value: '${result.delayMinutes} ${isAr ? 'د' : 'min'}',
              ),
              SizedBox(width: CoreSpacing.lg(context)),
              _Metric(
                label: isAr ? 'إضافي' : 'Overtime',
                value: '${result.overtimeHours.toStringAsFixed(1)} ${isAr ? 'س' : 'h'}',
              ),
              SizedBox(width: CoreSpacing.lg(context)),
              _Metric(
                label: isAr ? 'النسبة' : 'Percent',
                value: '${result.salaryPercent.round()}%',
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            '${isAr ? 'المستحق' : 'Payable'}: ${UtilityFormatJod.format(result.payableJod, suffix: l10n.currencyJod)}',
            style: CoreTypography.bodyMedium(
              context,
              CoreColors.semanticRevenue,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }

  String _outcomeLabel(AttendancePayOutcome outcome, bool isAr) => switch (outcome) {
    AttendancePayOutcome.fullPay => isAr ? 'كامل' : 'Full pay',
    AttendancePayOutcome.delayFee => isAr ? 'خصم تأخير' : 'Delay fee',
    AttendancePayOutcome.delayFeeDouble => isAr ? 'خصم ×2' : 'Fee ×2',
    AttendancePayOutcome.absence => isAr ? 'غياب' : 'Absence',
    AttendancePayOutcome.overtime => isAr ? 'إضافي' : 'Overtime',
  };

  Color _outcomeColor(AttendancePayOutcome outcome) => switch (outcome) {
    AttendancePayOutcome.fullPay => CoreColors.semanticSuccess,
    AttendancePayOutcome.delayFee => CoreColors.brandGold,
    AttendancePayOutcome.delayFeeDouble => CoreColors.brandOrange,
    AttendancePayOutcome.absence => CoreColors.semanticError,
    AttendancePayOutcome.overtime => CoreColors.orderTypeDelivery,
  };
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: CoreTypography.caption(context, Theme.of(context).colorScheme.onSurfaceVariant)),
        Text(value, style: CoreTypography.caption(context, Theme.of(context).colorScheme.onSurface).copyWith(fontWeight: FontWeight.w900)),
      ],
    );
  }
}
