import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/role_permissions_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_role_labels.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen B — user list with roles (detail on separate route).
class AppAdminUserPermissionsScreen extends ConsumerStatefulWidget {
  const AppAdminUserPermissionsScreen({this.initialRoleFilter, super.key});

  final AppRole? initialRoleFilter;

  @override
  ConsumerState<AppAdminUserPermissionsScreen> createState() =>
      _AppAdminUserPermissionsScreenState();
}

class _AppAdminUserPermissionsScreenState
    extends ConsumerState<AppAdminUserPermissionsScreen> {
  late String _query;
  AppRole? _roleFilter;
  String? _statusFilter;

  @override
  void initState() {
    super.initState();
    _query = '';
    _roleFilter = widget.initialRoleFilter;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final users = ref.watch(rbacUsersProvider).where((user) {
      final q = _query.trim().toLowerCase();
      final matchesQuery = q.isEmpty ||
          user.email.toLowerCase().contains(q) ||
          user.nameEn.toLowerCase().contains(q) ||
          user.nameAr.contains(_query.trim());
      final matchesRole =
          _roleFilter == null || user.assignedRoles.contains(_roleFilter);
      final matchesStatus =
          _statusFilter == null || user.status == _statusFilter;
      return matchesQuery && matchesRole && matchesStatus;
    });

    return WidgetsScaffoldPage(
      title: l10n.userPermissionsTitle,
      child: ListView(
        padding: EdgeInsetsDirectional.only(bottom: CoreSpacing.xxl(context)),
        children: [
          Text(
            l10n.userPermissionsSubtitle,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsAppTextField(
            label: l10n.menuSearchHint,
            prefixIcon: Icons.search,
            onChanged: (value) => setState(() => _query = value),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            l10n.filterByRole,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FilterChip(
                  label: Text(l10n.filterAll),
                  selected: _roleFilter == null,
                  onSelected: (_) => setState(() => _roleFilter = null),
                ),
                SizedBox(width: CoreSpacing.sm(context)),
                for (final role in AppRole.values)
                  if (role != AppRole.guest && role != AppRole.customer) ...[
                    FilterChip(
                      label: Text(roleLabel(l10n, role)),
                      selected: _roleFilter == role,
                      onSelected: (_) => setState(() => _roleFilter = role),
                    ),
                    SizedBox(width: CoreSpacing.sm(context)),
                  ],
              ],
            ),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            l10n.filterByStatus,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Wrap(
            spacing: CoreSpacing.sm(context),
            children: [
              FilterChip(
                label: Text(l10n.filterAll),
                selected: _statusFilter == null,
                onSelected: (_) => setState(() => _statusFilter = null),
              ),
              FilterChip(
                label: Text(l10n.rbacStatusActive),
                selected: _statusFilter == 'active',
                onSelected: (_) => setState(() => _statusFilter = 'active'),
              ),
              FilterChip(
                label: Text(l10n.rbacStatusPendingApproval),
                selected: _statusFilter == 'pending_approval',
                onSelected: (_) =>
                    setState(() => _statusFilter = 'pending_approval'),
              ),
              FilterChip(
                label: Text(l10n.rbacStatusSuspended),
                selected: _statusFilter == 'suspended',
                onSelected: (_) => setState(() => _statusFilter = 'suspended'),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          for (final user in users)
            Padding(
              padding: EdgeInsets.only(bottom: CoreSpacing.md(context)),
              child: WidgetsAppCard(
                child: ListTile(
                  title: Text(
                    user.displayName(isAr),
                    style: CoreTypography.bodyMedium(
                      context,
                      scheme.onSurface,
                    ).copyWith(fontWeight: FontWeight.w800),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: CoreSpacing.xs(context)),
                      Text(user.email),
                      SizedBox(height: CoreSpacing.sm(context)),
                      Wrap(
                        spacing: CoreSpacing.xs(context),
                        runSpacing: CoreSpacing.xs(context),
                        children: [
                          WidgetsStatusPill(
                            label: rbacUserStatusLabel(l10n, user.status),
                            color: _statusColor(scheme, user.status),
                          ),
                          for (final role in user.assignedRoles)
                            WidgetsStatusPill(label: roleLabel(l10n, role)),
                          if (user.ownershipPercentage != null)
                            WidgetsStatusPill(
                              label:
                                  '${l10n.ownershipPercentageLabel} ${user.ownershipPercentage!.toStringAsFixed(0)}%',
                            ),
                        ],
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push(AppRoutePaths.appAdminUserDetail(user.id)),
                ),
              ),
            ),
        ],
      ),
    );
  }

  static Color _statusColor(ColorScheme scheme, String status) => switch (status) {
        'pending_approval' => CoreColors.brandOrange,
        'suspended' => CoreColors.semanticError,
        _ => CoreColors.semanticSuccess,
      };
}
