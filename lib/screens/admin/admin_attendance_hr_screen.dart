import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/attendance_hr_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_file_download.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
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
  const AdminAttendanceHrScreen({this.staffHoursReport = false, super.key});

  /// When true, shows staff-hours report title (PRD `/operator/staff-hours` route).
  final bool staffHoursReport;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final hrState = ref.watch(attendanceHrProvider);
    final rows = ref.watch(attendanceHrReportProvider);
    final rules = hrState.rules;

    return WidgetsScaffoldPage(
      title: staffHoursReport ? l10n.screenStaffHoursReport : l10n.hrAttendancePayrollTitle,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.staffAttendance),
          icon: Icons.fingerprint_outlined,
          tooltip: l10n.hrStaffAttendanceTooltip,
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
            _RulesHero(l10n: l10n, isAr: isAr, rules: rules),
            SizedBox(height: CoreSpacing.lg(context)),
            Wrap(
              spacing: CoreSpacing.sm(context),
              children: [
                WidgetsFilterChip(
                  label: l10n.hrPeriodDaily,
                  selected: hrState.period == 'daily',
                  onSelected:
                      (_) =>
                          ref.read(attendanceHrProvider.notifier).setPeriod('daily'),
                ),
                WidgetsFilterChip(
                  label: l10n.hrPeriodMonthly,
                  selected: hrState.period == 'monthly',
                  onSelected:
                      (_) =>
                          ref.read(attendanceHrProvider.notifier).setPeriod('monthly'),
                ),
              ],
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            WidgetsAppCard(
              title: l10n.hrTotalPayable,
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
              label: l10n.hrExportCsv,
              onPressed: () async {
                final csv = buildHrPayrollCsv(hr: hrState, rows: rows);
                await downloadTextFile(
                  'attendance-payroll-${hrState.period}.csv',
                  csv,
                  mimeType: 'text/csv',
                );
                if (context.mounted) {
                  UtilityMockFeedback.showInfo(context, l10n.hrExportCsvSuccess);
                }
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
  const _RulesHero({required this.l10n, required this.isAr, required this.rules});

  final AppLocalizations l10n;
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
            l10n.hrPayrollRulesTitle,
            style: CoreTypography.titleMedium(
              context,
              Theme.of(context).colorScheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _RuleLine(
            l10n.hrPayrollOnTimeRule(rules.onTimeGraceMinutes),
          ),
          _RuleLine(
            l10n.hrPayrollDelayRule(
              rules.onTimeGraceMinutes,
              rules.delayFeeJod.toString(),
              l10n.currencyJod,
            ),
          ),
          _RuleLine(
            l10n.hrPayrollDelayDoubleRule(rules.onTimeGraceMinutes + 15),
          ),
          _RuleLine(
            l10n.hrPayrollAbsenceRule(rules.absenceAfterMinutes),
          ),
          _RuleLine(
            l10n.hrPayrollOvertimeRule(
              rules.overtimeThresholdMinutes,
              rules.overtimeMultiplier.toString(),
            ),
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
          Icon(Icons.check_circle_outline, size: CoreContentSizes.chipIcon(context), color: CoreColors.brandOlive),
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
                label: _outcomeLabel(result.outcome),
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
                label: l10n.hrDelayLabel,
                value: '${result.delayMinutes} ${l10n.hrMinutesShort}',
              ),
              SizedBox(width: CoreSpacing.lg(context)),
              _Metric(
                label: l10n.hrOvertimeLabel,
                value: '${result.overtimeHours.toStringAsFixed(1)} ${l10n.hrHoursShort}',
              ),
              SizedBox(width: CoreSpacing.lg(context)),
              _Metric(
                label: l10n.hrPercentLabel,
                value: '${result.salaryPercent.round()}%',
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            '${l10n.hrPayableLabel}: ${UtilityFormatJod.format(result.payableJod, suffix: l10n.currencyJod)}',
            style: CoreTypography.bodyMedium(
              context,
              CoreColors.semanticRevenue,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }

  String _outcomeLabel(AttendancePayOutcome outcome) => switch (outcome) {
    AttendancePayOutcome.fullPay => l10n.hrOutcomeFullPay,
    AttendancePayOutcome.delayFee => l10n.hrOutcomeDelayFee,
    AttendancePayOutcome.delayFeeDouble => l10n.hrOutcomeDelayFeeDouble,
    AttendancePayOutcome.absence => l10n.hrOutcomeAbsence,
    AttendancePayOutcome.overtime => l10n.hrOutcomeOvertime,
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
