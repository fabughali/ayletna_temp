import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_admin_mock.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/admin_dashboard_providers.dart';
import 'package:ayletna_restaurant_app/providers/admin_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_avatar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_illustration_panel.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_list_item.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_metric_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [DailyTipDistributionScreen].
class AdminDailyTipDistributionScreen extends ConsumerWidget {
  const AdminDailyTipDistributionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    final tipState = ref.watch(adminTipDistributionProvider);
    final staffRows =
        tipState.showAllStaff
            ? MockupCatalog.adminTipDistributionRows
            : MockupCatalog.adminTipDistributionRows.take(5).toList();

    return WidgetsScaffoldPage(
      title: l10n.screenDailyTipDistribution,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(adminDashboardMetricsProvider);
        },
        child: ListView(
          children: [
            _SummaryGrid(l10n: l10n, poolJod: tipState.poolJod),
            SizedBox(height: CoreSpacing.lg(context)),
            _StaffBreakdownCard(
              l10n: l10n,
              approved: tipState.approved,
              showAllStaff: tipState.showAllStaff,
              staffRows: staffRows,
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            _CalculationCard(l10n: l10n),
            SizedBox(height: CoreSpacing.lg(context)),
            _ShareDistributionCard(l10n: l10n, poolJod: tipState.poolJod),
            SizedBox(height: CoreSpacing.xl(context)),
          ],
        ),
      ),
    );
  }
}

class _SummaryGrid extends StatelessWidget {
  const _SummaryGrid({required this.l10n, required this.poolJod});

  final AppLocalizations l10n;
  final double poolJod;

  @override
  Widget build(BuildContext context) {
    final averageRate = poolJod / MockupCatalog.dailyTipTotalHours;

    return Column(
      children: [
        WidgetsMetricCard(
          label: l10n.adminDailyTipPool,
          value: UtilityFormatJod.format(poolJod, suffix: l10n.currencyJod),
          subtitle: l10n.adminTipDeltaYesterday,
          icon: Icons.trending_up,
          accentColor: CoreColors.semanticTip,
        ),
        SizedBox(height: CoreSpacing.md(context)),
        WidgetsMetricCard(
          label: l10n.adminStaffDistribution,
          value: '14',
          subtitle: l10n.adminMembersScheduled,
          icon: Icons.groups_2_outlined,
          accentColor: CoreColors.brandBrown,
        ),
        SizedBox(height: CoreSpacing.md(context)),
        WidgetsMetricCard(
          label: l10n.adminTotalHoursLogged,
          value: '${MockupCatalog.dailyTipTotalHours.toStringAsFixed(1)} hrs',
          subtitle: l10n.adminAverageRate(
            UtilityFormatJod.format(averageRate, suffix: l10n.currencyJod),
          ),
          icon: Icons.schedule_outlined,
          accentColor: CoreColors.semanticRevenue,
        ),
      ],
    );
  }
}

class _StaffBreakdownCard extends ConsumerWidget {
  const _StaffBreakdownCard({
    required this.l10n,
    required this.approved,
    required this.showAllStaff,
    required this.staffRows,
  });

  final AppLocalizations l10n;
  final bool approved;
  final bool showAllStaff;
  final List<ModelAdminTipDistributionRow> staffRows;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WidgetsAppCard(
      title: l10n.adminStaffBreakdown,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: WidgetsAppButton(
                  label: l10n.adminRecalculatePool,
                  onPressed:
                      approved
                          ? null
                          : () {
                            ref
                                .read(adminTipDistributionProvider.notifier)
                                .recalculatePool();
                            UtilityMockFeedback.showSuccess(
                              context,
                              l10n.adminRecalculatePool,
                            );
                          },
                  variant: WidgetsAppButtonVariant.outline,
                ),
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: WidgetsAppButton(
                  label: l10n.adminApproveAllDistributions,
                  onPressed:
                      approved
                          ? null
                          : () async {
                            final tipState = ref.read(adminTipDistributionProvider);
                            if (tipState.poolJod <= 0) {
                              UtilityMockFeedback.showError(
                                context,
                                l10n.adminTipPoolEmpty,
                              );
                              return;
                            }
                            final confirmed = await UtilityMockFeedback.confirm(
                              context: context,
                              title: l10n.adminApproveAllDistributions,
                              message: l10n.adminStaffBreakdown,
                              confirmLabel: l10n.actionConfirm,
                              cancelLabel: l10n.actionCancel,
                              icon: Icons.verified_outlined,
                            );
                            if (!context.mounted || !confirmed) return;
                            ref
                                .read(adminTipDistributionProvider.notifier)
                                .approveAll();
                            UtilityMockFeedback.showSuccess(
                              context,
                              l10n.adminApproveAllDistributions,
                            );
                          },
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          ...staffRows.map((row) => _StaffRow(row: row, l10n: l10n)),
          if (MockupCatalog.adminTipDistributionRows.length > 5)
            WidgetsAppButton(
              label: showAllStaff ? l10n.adminShowLess : l10n.adminShowAllStaff,
              onPressed:
                  () =>
                      ref
                          .read(adminTipDistributionProvider.notifier)
                          .toggleShowAllStaff(),
              icon: showAllStaff ? Icons.expand_less : Icons.expand_more,
              variant: WidgetsAppButtonVariant.ghost,
            ),
        ],
      ),
    );
  }
}

class _StaffRow extends StatelessWidget {
  const _StaffRow({required this.row, required this.l10n});

  final ModelAdminTipDistributionRow row;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return WidgetsListItem(
      title: row.name,
      subtitle: l10n.adminTipRowSubtitle(
        row.orderId,
        row.hours.toStringAsFixed(1),
      ),
      leading: WidgetsAvatar(initials: row.initials),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _RoleBadge(role: row.role),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            UtilityFormatJod.format(row.tipShareJod, suffix: l10n.currencyJod),
            style: CoreTypography.caption(
              context,
              Theme.of(context).colorScheme.primary,
            ).copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _RoleBadge extends StatelessWidget {
  const _RoleBadge({required this.role});

  final String role;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = switch (role) {
      'Dine-in' => scheme.secondary,
      'Plated' => scheme.primary,
      'Takeaway' => scheme.tertiary,
      _ => CoreColors.orderTypeDelivery,
    };

    return WidgetsStatusPill(label: role, color: color, compact: true);
  }
}

class _CalculationCard extends StatelessWidget {
  const _CalculationCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: l10n.adminCalculationLogic,
      accentColor: CoreColors.semanticTip,
      child: Column(
        children: [
          _CalcRow(label: l10n.adminNetSalesTips, value: 2112.67, l10n: l10n),
          _CalcRow(label: l10n.adminDirectServicePremium, value: 248.55, l10n: l10n),
          _CalcRow(label: l10n.adminCarryOver, value: 124.28, l10n: l10n),
          Divider(height: CoreSpacing.xl(context)),
          WidgetsListItem(
            title: l10n.adminCalculatedPointRate,
            trailing: WidgetsStatusPill(
              label: '${MockupCatalog.dailyTipPointRate.toStringAsFixed(2)}x',
              color: CoreColors.semanticTip,
              compact: true,
            ),
            dense: true,
          ),
        ],
      ),
    );
  }
}

class _CalcRow extends StatelessWidget {
  const _CalcRow({
    required this.label,
    required this.value,
    required this.l10n,
  });

  final String label;
  final double value;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsListItem(
      title: label,
      trailing: Text(
        UtilityFormatJod.format(value, suffix: l10n.currencyJod),
        style: CoreTypography.caption(
          context,
          scheme.onSurface,
        ).copyWith(fontWeight: FontWeight.w700),
      ),
      dense: true,
    );
  }
}

class _ShareDistributionCard extends StatelessWidget {
  const _ShareDistributionCard({required this.l10n, required this.poolJod});

  final AppLocalizations l10n;
  final double poolJod;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final roleTotals = <String, double>{};
    for (final row in MockupCatalog.adminTipDistributionRows) {
      roleTotals[row.role] = (roleTotals[row.role] ?? 0) + row.tipShareJod;
    }
    final maxTotal = roleTotals.values.fold<double>(
      0,
      (max, value) => value > max ? value : max,
    );
    final entries = roleTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    Color colorForRole(String role) => switch (role) {
      'Dine-in' => scheme.secondary,
      'Plated' => scheme.primary,
      'Takeaway' => scheme.tertiary,
      _ => CoreColors.orderTypeDelivery,
    };

    return WidgetsAppCard(
      title: l10n.adminShareDistribution,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetsIllustrationPanel(
            height: CoreContentSizes.adminChartHeight(context),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final entry in entries)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: CoreSpacing.xs(context),
                      ),
                      child: FractionallySizedBox(
                        heightFactor:
                            maxTotal == 0 ? 0.1 : entry.value / maxTotal,
                        alignment: Alignment.bottomCenter,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: colorForRole(entry.key),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(CoreSpacing.radiusInputOf(context)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            UtilityFormatJod.format(poolJod, suffix: l10n.currencyJod),
            style: CoreTypography.caption(
              context,
              scheme.onSurfaceVariant,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Wrap(
            spacing: CoreSpacing.md(context),
            runSpacing: CoreSpacing.xs(context),
            children: [
              for (final entry in entries)
                _LegendDot(
                  label: '${entry.key} · ${entry.value.toStringAsFixed(0)}',
                  color: colorForRole(entry.key),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.circle, size: CoreSpacing.sm(context), color: color),
        SizedBox(width: CoreSpacing.xs(context)),
        Text(
          label,
          style: CoreTypography.caption(
            context,
            Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
