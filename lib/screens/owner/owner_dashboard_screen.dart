import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/admin_dashboard_providers.dart';
import 'package:ayletna_restaurant_app/providers/owner_dashboard_providers.dart';
import 'package:ayletna_restaurant_app/providers/user_profile_providers.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_audit_log_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_financial_calculation_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_reports_screen.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_metric_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OwnerDashboardScreen extends ConsumerWidget {
  const OwnerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final profile = ref.watch(userProfileProvider);
    final metrics = ref.watch(ownerDashboardMetricsProvider);
    final sharePercent = profile.ownershipPercentage ?? 0;

    return WidgetsScaffoldPage(
      title: l10n.hubOwner,
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(ownerDashboardMetricsProvider);
          ref.invalidate(adminDashboardMetricsProvider);
        },
        child: ListView(
          padding: EdgeInsetsDirectional.only(bottom: CoreSpacing.xxl(context)),
          children: [
            Text(
              l10n.hubOwnerPerformanceSummary,
              style: CoreTypography.titleMedium(
                context,
                Theme.of(context).colorScheme.onSurface,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
            SizedBox(height: CoreSpacing.md(context)),
            Row(
              children: [
                Expanded(
                  child: WidgetsMetricCard(
                    label: l10n.hubOwnerShare,
                    value: UtilityFormatJod.format(metrics.shareJod),
                    subtitle: l10n.hubOwnerSharePercent(
                      sharePercent.toStringAsFixed(0),
                    ),
                    icon: Icons.pie_chart_outline,
                    accentColor: CoreColors.brandBrown,
                  ),
                ),
                SizedBox(width: CoreSpacing.sm(context)),
                Expanded(
                  child: WidgetsMetricCard(
                    label: l10n.hubNetRevenue,
                    value: UtilityFormatJod.format(metrics.netRevenueJod),
                    icon: Icons.trending_up_outlined,
                    accentColor: CoreColors.brandBrown,
                  ),
                ),
              ],
            ),
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsMetricCard(
              label: l10n.hubTodayRevenue,
              value: UtilityFormatJod.format(metrics.todayRevenueJod),
              subtitle: l10n.hubTodayOrders('${metrics.todayOrders}'),
              icon: Icons.receipt_long_outlined,
              accentColor: CoreColors.brandBrown,
            ),
            SizedBox(height: CoreSpacing.xl(context)),
            WidgetsAppCard(
              child: ListTile(
                leading: const Icon(Icons.insights_outlined),
                title: Text(l10n.screenReports),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(AppRoutePaths.ownerReports),
              ),
            ),
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsAppCard(
              child: ListTile(
                leading: const Icon(Icons.account_balance_outlined),
                title: Text(l10n.screenFinancialCalculation),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(AppRoutePaths.ownerFinancial),
              ),
            ),
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsAppCard(
              child: ListTile(
                leading: const Icon(Icons.history_outlined),
                title: Text(l10n.screenAuditLog),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(AppRoutePaths.ownerAudit),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OwnerReportsScreen extends StatelessWidget {
  const OwnerReportsScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const AdminReportsScreen(readOnly: true);
}

class OwnerFinancialScreen extends StatelessWidget {
  const OwnerFinancialScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const AdminFinancialCalculationScreen(readOnly: true);
}

class OwnerAuditScreen extends StatelessWidget {
  const OwnerAuditScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const AdminAuditLogScreen(readOnly: true);
}
