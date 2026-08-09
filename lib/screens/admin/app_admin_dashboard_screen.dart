import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/audit_log_providers.dart';
import 'package:ayletna_restaurant_app/providers/role_permissions_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_metric_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppAdminDashboardScreen extends ConsumerWidget {
  const AppAdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final users = ref.watch(rbacUsersProvider);
    final roleCount = users.expand((user) => user.assignedRoles).toSet().length;
    final today = DateTime.now();
    final auditToday =
        ref.watch(auditLogProvider).where((event) {
          final recorded = event.recordedAt;
          return recorded.year == today.year &&
              recorded.month == today.month &&
              recorded.day == today.day;
        }).length;

    return WidgetsScaffoldPage(
      title: l10n.hubAppAdmin,
      child: ListView(
        padding: EdgeInsetsDirectional.only(bottom: CoreSpacing.xxl(context)),
        children: [
          Text(
            l10n.hubNavigateHint,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Row(
            children: [
              Expanded(
                child: WidgetsMetricCard(
                  label: l10n.userPermissionsTitle,
                  value: '${users.length}',
                  icon: Icons.groups_outlined,
                  accentColor: CoreColors.hubAdminAccentDark,
                  compact: true,
                ),
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: WidgetsMetricCard(
                  label: l10n.rolePermissionsTitle,
                  value: '$roleCount',
                  icon: Icons.admin_panel_settings_outlined,
                  accentColor: CoreColors.hubAdminAccentDark,
                  compact: true,
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsMetricCard(
            label: l10n.auditLogTodayEvents,
            value: '$auditToday',
            icon: Icons.history_outlined,
            accentColor: CoreColors.hubAdminAccentDark,
            compact: true,
          ),
          SizedBox(height: CoreSpacing.xl(context)),
          _HubGrid(
            tiles: [
              _HubTile(
                l10n.rolePermissionsTitle,
                Icons.admin_panel_settings_outlined,
                AppRoutePaths.appAdminRoles,
              ),
              _HubTile(
                l10n.userPermissionsTitle,
                Icons.groups_outlined,
                AppRoutePaths.appAdminUsers,
              ),
              _HubTile(
                l10n.screenAuditLog,
                Icons.history_outlined,
                AppRoutePaths.appAdminAudit,
              ),
              _HubTile(
                l10n.screenAppIntegrations,
                Icons.extension_outlined,
                AppRoutePaths.appAdminIntegrations,
              ),
              _HubTile(
                l10n.screenOwnerViewConfig,
                Icons.visibility_outlined,
                AppRoutePaths.appAdminOwnerConfig,
              ),
              _HubTile(
                l10n.screenSettings,
                Icons.tune_outlined,
                AppRoutePaths.appAdminSettings,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HubGrid extends StatelessWidget {
  const _HubGrid({required this.tiles});
  final List<_HubTile> tiles;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tiles.length,
      separatorBuilder: (_, __) => SizedBox(height: CoreSpacing.md(context)),
      itemBuilder: (context, index) {
        final tile = tiles[index];
        return WidgetsAppCard(
          child: ListTile(
            leading: Icon(tile.icon, color: CoreColors.hubAdminAccentDark),
            title: Text(
              tile.label,
              style: CoreTypography.bodyMedium(
                context,
                Theme.of(context).colorScheme.onSurface,
              ).copyWith(fontWeight: FontWeight.w800),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(tile.route),
          ),
        );
      },
    );
  }
}

class _HubTile {
  const _HubTile(this.label, this.icon, this.route);
  final String label;
  final IconData icon;
  final String route;
}
