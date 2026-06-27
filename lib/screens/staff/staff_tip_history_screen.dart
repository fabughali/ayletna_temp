import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_staff_mock.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/staff_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_file_download.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/utilities/utility_report_export.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_async_state_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD StaffTipHistoryScreen — payout and shift history.
class StaffTipHistoryScreen extends ConsumerWidget {
  const StaffTipHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final session = ref.watch(staffSessionProvider);
    final thisWeekRows = session.tipHistoryForWeek('this');
    final lastWeekRows = session.tipHistoryForWeek('last');

    return WidgetsScaffoldPage(
      title: l10n.screenStaffTipHistory,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.staffTips),
          icon: Icons.payments_outlined,
          tooltip: l10n.screenStaffDailyTips,
        ),
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(staffSessionProvider);
        },
        child: ListView(
          children: [
            const _HistoryHero(),
            SizedBox(height: CoreSpacing.lg(context)),
            _RangeRow(
              selectedRange: session.tipHistoryRange,
              onSelected:
                  (range) =>
                      ref.read(staffSessionProvider.notifier).setTipHistoryRange(
                        range,
                      ),
              onCustomApply:
                  () =>
                      ref.read(staffSessionProvider.notifier).applyCustomRange(),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            const _SummaryCards(),
            SizedBox(height: CoreSpacing.lg(context)),
            _WeekSection(
              title: l10n.staffThisWeek,
              rows: thisWeekRows,
              emptyMessage: l10n.staffThisWeek,
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            _WeekSection(
              title: l10n.staffLastWeek,
              rows: lastWeekRows,
              emptyMessage: l10n.staffLastWeek,
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            WidgetsAppButton(
              label: l10n.staffDownloadTaxStatement,
              onPressed: () async {
                final rows = session.filteredTipHistory;
                final csv = buildStaffTipStatementCsv(rows);
                await downloadTextFile(
                  'staff-tip-statement.csv',
                  csv,
                  mimeType: 'text/csv',
                );
                if (!context.mounted) return;
                UtilityMockFeedback.showSuccess(
                  context,
                  l10n.staffDownloadTaxStatement,
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

class _HistoryHero extends StatelessWidget {
  const _HistoryHero();
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.dashboard,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _IconBubble(
            icon: Icons.history_outlined,
            color: scheme.primary,
            large: true,
          ),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.staffPerformanceSummary,
                  style: CoreTypography.headlineSmall(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  l10n.screenStaffTipHistoryDesc,
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          _SoftBadge(
            label: l10n.staffNoLatesPeriod,
            color: CoreColors.semanticSuccess,
            icon: Icons.verified_outlined,
          ),
        ],
      ),
    );
  }
}

class _SummaryCards extends StatelessWidget {
  const _SummaryCards();
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return LayoutBuilder(
      builder: (context, constraints) {
        final cards = [
          _SummaryCard(
            title: l10n.staffTotalHours,
            value: l10n.staffTotalHoursValue,
            footnote: l10n.staffHoursDelta,
            color: CoreColors.semanticSuccess,
            icon: Icons.schedule_outlined,
          ),
          _SummaryCard(
            title: l10n.staffTotalTips,
            value: l10n.staffTotalTipsValue,
            footnote: l10n.staffAvgTripRate,
            color: CoreColors.brandOrange,
            icon: Icons.payments_outlined,
          ),
          _SummaryCard(
            title: l10n.staffShiftsCompleted,
            value: l10n.staffShiftsCompletedValue,
            footnote: l10n.staffNoLatesPeriod,
            color: Theme.of(context).colorScheme.primary,
            icon: Icons.assignment_turned_in_outlined,
          ),
        ];
        if (constraints.maxWidth >= 820) {
          return Row(
            children: [
              for (var i = 0; i < cards.length; i++) ...[
                Expanded(child: cards[i]),
                if (i != cards.length - 1)
                  SizedBox(width: CoreSpacing.md(context)),
              ],
            ],
          );
        }
        return Column(
          children: [
            for (final card in cards) ...[
              card,
              SizedBox(height: CoreSpacing.sm(context)),
            ],
          ],
        );
      },
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.value,
    required this.footnote,
    required this.color,
    required this.icon,
  });
  final String title;
  final String value;
  final String footnote;
  final Color color;
  final IconData icon;
  @override
  Widget build(BuildContext context) => WidgetsAppCard(
    variant: WidgetsAppCardVariant.food,
    padding: EdgeInsets.all(CoreSpacing.md(context)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _IconBubble(icon: icon, color: color),
        SizedBox(height: CoreSpacing.md(context)),
        Text(
          title,
          style: CoreTypography.caption(
            context,
            Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: CoreSpacing.xs(context)),
        Text(
          value,
          style: CoreTypography.titleMedium(
            context,
            Theme.of(context).colorScheme.onSurface,
          ).copyWith(fontWeight: FontWeight.w900),
        ),
        SizedBox(height: CoreSpacing.xs(context)),
        Text(footnote, style: CoreTypography.caption(context, color)),
      ],
    ),
  );
}

class _RangeRow extends StatelessWidget {
  const _RangeRow({
    required this.selectedRange,
    required this.onSelected,
    required this.onCustomApply,
  });

  final String selectedRange;
  final ValueChanged<String> onSelected;
  final VoidCallback onCustomApply;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final filters = [
      ('thisMonth', l10n.staffThisMonth, Icons.calendar_month_outlined),
      ('lastMonth', l10n.staffLastMonth, Icons.history_outlined),
      ('custom', l10n.staffCustomRange, Icons.date_range_outlined),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final filter in filters) ...[
            _RangeChip(
              id: filter.$1,
              label: filter.$2,
              icon: filter.$3,
              selected: selectedRange == filter.$1,
              onTap: () {
                onSelected(filter.$1);
                if (filter.$1 == 'custom') _showRangeSheet(context);
              },
            ),
            SizedBox(width: CoreSpacing.sm(context)),
          ],
        ],
      ),
    );
  }

  void _showRangeSheet(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    UtilityMockFeedback.showActionSheet(
      context: context,
      title: l10n.staffCustomRange,
      message: l10n.staffPerformanceSummary,
      actions: [
        MockSheetAction(
          label: l10n.actionApply,
          icon: Icons.date_range_outlined,
          onSelected: () {
            onCustomApply();
            UtilityMockFeedback.showSuccess(context, l10n.staffCustomRange);
          },
        ),
      ],
    );
  }
}

class _RangeChip extends StatelessWidget {
  const _RangeChip({
    required this.id,
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });
  final String id;
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final color =
        selected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurfaceVariant;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.withValues(alpha: selected ? 0.16 : 0.08),
          borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
          border: Border.all(color: color.withValues(alpha: 0.24)),
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
                color: color,
                size: CoreContentSizes.orderTypeIcon(context),
              ),
              SizedBox(width: CoreSpacing.xs(context)),
              Text(
                label,
                style: CoreTypography.caption(
                  context,
                  color,
                ).copyWith(fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WeekSection extends StatelessWidget {
  const _WeekSection({
    required this.title,
    required this.rows,
    required this.emptyMessage,
  });

  final String title;
  final List<ModelStaffTipHistory> rows;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) => WidgetsAppCard(
    variant: WidgetsAppCardVariant.form,
    padding: EdgeInsets.all(CoreSpacing.lg(context)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: CoreTypography.titleMedium(
            context,
            Theme.of(context).colorScheme.onSurface,
          ).copyWith(fontWeight: FontWeight.w900),
        ),
        SizedBox(height: CoreSpacing.md(context)),
        if (rows.isEmpty)
          WidgetsAsyncStateCard.empty(
            title: emptyMessage,
            message: title,
          )
        else
          for (final row in rows) ...[
            _ShiftHistoryRow(row: row),
            SizedBox(height: CoreSpacing.sm(context)),
          ],
      ],
    ),
  );
}

class _ShiftHistoryRow extends StatelessWidget {
  const _ShiftHistoryRow({required this.row});
  final ModelStaffTipHistory row;
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final color = switch (row.colorKey) {
      'delivery' => CoreColors.orderTypeDelivery,
      'plated' => CoreColors.orderTypePlated,
      'orange' => CoreColors.brandOrange,
      _ => CoreColors.semanticSuccess,
    };
    final badge = isAr ? row.badgeAr : row.badgeEn;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
        border: Border.all(color: color.withValues(alpha: 0.16)),
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.sm(context)),
        child: Row(
          children: [
            _SoftBadge(
              label: isAr ? row.dateAr : row.dateEn,
              color: color,
              icon: Icons.calendar_today_outlined,
            ),
            SizedBox(width: CoreSpacing.sm(context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isAr ? row.titleAr : row.titleEn,
                    style: CoreTypography.bodyMedium(
                      context,
                      scheme.onSurface,
                    ).copyWith(fontWeight: FontWeight.w900),
                  ),
                  Text(
                    '${isAr ? row.timeAr : row.timeEn} • ${isAr ? row.hoursAr : row.hoursEn}',
                    style: CoreTypography.caption(
                      context,
                      scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  isAr ? row.tipsAr : row.tipsEn,
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                if (badge != null) ...[
                  SizedBox(height: CoreSpacing.xs(context)),
                  _SoftBadge(
                    label: badge,
                    color: CoreColors.brandOrange,
                    icon: Icons.star_outline,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SoftBadge extends StatelessWidget {
  const _SoftBadge({
    required this.label,
    required this.color,
    required this.icon,
  });
  final String label;
  final Color color;
  final IconData icon;
  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
      border: Border.all(color: color.withValues(alpha: 0.24)),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: CoreSpacing.sm(context),
        vertical: CoreSpacing.xs(context),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: CoreContentSizes.orderTypeIcon(context),
            color: color,
          ),
          SizedBox(width: CoreSpacing.xs(context)),
          Text(
            label,
            style: CoreTypography.caption(
              context,
              color,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    ),
  );
}

class _IconBubble extends StatelessWidget {
  const _IconBubble({
    required this.icon,
    required this.color,
    this.large = false,
  });
  final IconData icon;
  final Color color;
  final bool large;
  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
    ),
    child: Padding(
      padding: EdgeInsets.all(CoreSpacing.sm(context)),
      child: Icon(
        icon,
        color: color,
        size:
            large
                ? CoreContentSizes.logoCard(context) * 0.52
                : CoreContentSizes.orderTypeIcon(context),
      ),
    ),
  );
}
