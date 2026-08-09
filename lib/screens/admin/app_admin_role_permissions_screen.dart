import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_permission_rule.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/role_permissions_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_permission_matrix.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_role_picker_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen A — generic roles & default rules.
class AppAdminRolePermissionsScreen extends ConsumerStatefulWidget {
  const AppAdminRolePermissionsScreen({this.initialRole, super.key});

  final AppRole? initialRole;

  @override
  ConsumerState<AppAdminRolePermissionsScreen> createState() =>
      _AppAdminRolePermissionsScreenState();
}

class _AppAdminRolePermissionsScreenState
    extends ConsumerState<AppAdminRolePermissionsScreen> {
  late AppRole _selected;
  bool _dirty = false;

  static const _roleDefaultAccessOptions = [
    PermissionAccess.full,
    PermissionAccess.readOnly,
    PermissionAccess.denied,
  ];

  @override
  void initState() {
    super.initState();
    _selected = widget.initialRole ?? AppRole.operator;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final roleDefaults = ref.watch(rolePermissionsProvider);
    final keys = PermissionCatalog.keysForRole(_selected);
    final usersWithRole =
        ref
            .watch(rbacUsersProvider)
            .where((u) => u.assignedRoles.contains(_selected))
            .length;

    return WidgetsScaffoldPage(
      title: l10n.rolePermissionsTitle,
      child: ListView(
        padding: EdgeInsetsDirectional.only(bottom: CoreSpacing.xxl(context)),
        children: [
          Text(
            l10n.rolePermissionsSubtitle,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsRolePickerField(
            selected: _selected,
            onSelected: (role) => setState(() {
              _selected = role;
              _dirty = false;
            }),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          InkWell(
            onTap:
                () => context.push(
                  '${AppRoutePaths.appAdminUsers}?role=${_selected.name}',
                ),
            child: Text(
              l10n.rbacUsersWithRoleLink(usersWithRole),
              style: CoreTypography.caption(context, scheme.primary).copyWith(
                fontWeight: FontWeight.w800,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsPermissionMatrix(
            keys: keys,
            accessOptions: _roleDefaultAccessOptions,
            accessForKey:
                (key) =>
                    roleDefaults[_selected]?[key] ?? PermissionAccess.denied,
            onChanged: (key, access) {
              ref
                  .read(rolePermissionsProvider.notifier)
                  .setAccess(_selected, key, access);
              setState(() => _dirty = true);
            },
          ),
          SizedBox(height: CoreSpacing.xl(context)),
          Row(
            children: [
              Expanded(
                child: WidgetsAppButton(
                  label: l10n.actionSave,
                  onPressed: () {
                    final allDenied = keys.every(
                      (key) =>
                          roleDefaults[_selected]?[key] ==
                          PermissionAccess.denied,
                    );
                    if (allDenied) {
                      UtilityMockFeedback.showWarning(
                        context,
                        l10n.rbacAllPermissionsDenied,
                      );
                      return;
                    }
                    if (!_dirty) {
                      UtilityMockFeedback.showInfo(
                        context,
                        l10n.rbacNoPendingChanges,
                      );
                      return;
                    }
                    setState(() => _dirty = false);
                    UtilityMockFeedback.showSuccess(
                      context,
                      l10n.rbacRoleDefaultsSaved,
                    );
                  },
                ),
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: WidgetsAppButton(
                  label: l10n.rbacResetDefaults,
                  variant: WidgetsAppButtonVariant.outline,
                  onPressed: () async {
                    final confirmed = await UtilityMockFeedback.confirm(
                      context: context,
                      title: l10n.rbacResetConfirmTitle,
                      message: l10n.rbacResetConfirmMessage,
                      confirmLabel: l10n.rbacResetDefaults,
                      cancelLabel: l10n.actionCancel,
                      icon: Icons.restart_alt,
                    );
                    if (!context.mounted || !confirmed) return;
                    ref
                        .read(rolePermissionsProvider.notifier)
                        .resetRole(_selected);
                    setState(() => _dirty = false);
                    UtilityMockFeedback.showSuccess(
                      context,
                      l10n.rbacResetDefaultsSuccess,
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.userPermissionsTitle,
            variant: WidgetsAppButtonVariant.outline,
            onPressed: () => context.push(AppRoutePaths.appAdminUsers),
          ),
        ],
      ),
    );
  }
}
