import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/utilities/utility_role_labels.dart';
import 'package:flutter/material.dart';

/// Multi-role assignment chips for RBAC Screen B detail.
class WidgetsRoleChipSelector extends StatelessWidget {
  const WidgetsRoleChipSelector({
    required this.selectedRoles,
    required this.onRoleToggled,
    this.excludePublicRoles = true,
    super.key,
  });

  final Set<AppRole> selectedRoles;
  final void Function(AppRole role, bool selected) onRoleToggled;
  final bool excludePublicRoles;

  static const managementRoles = [
    AppRole.admin,
    AppRole.operator,
    AppRole.owner,
  ];

  static const specialistRoles = [AppRole.support, AppRole.marketing];

  static const opsRoles = [
    AppRole.cashier,
    AppRole.kitchen,
    AppRole.delivery,
    AppRole.inventory,
    AppRole.staff,
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _RoleGroup(
          title: l10n.rbacRoleGroupManagement,
          roles: managementRoles,
          selectedRoles: selectedRoles,
          onRoleToggled: onRoleToggled,
          l10n: l10n,
        ),
        SizedBox(height: CoreSpacing.md(context)),
        _RoleGroup(
          title: l10n.rbacRoleGroupSpecialist,
          roles: specialistRoles,
          selectedRoles: selectedRoles,
          onRoleToggled: onRoleToggled,
          l10n: l10n,
        ),
        SizedBox(height: CoreSpacing.md(context)),
        _RoleGroup(
          title: l10n.rbacRoleGroupOperations,
          roles: opsRoles,
          selectedRoles: selectedRoles,
          onRoleToggled: onRoleToggled,
          l10n: l10n,
        ),
      ],
    );
  }
}

class _RoleGroup extends StatelessWidget {
  const _RoleGroup({
    required this.title,
    required this.roles,
    required this.selectedRoles,
    required this.onRoleToggled,
    required this.l10n,
  });

  final String title;
  final List<AppRole> roles;
  final Set<AppRole> selectedRoles;
  final void Function(AppRole role, bool selected) onRoleToggled;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: CoreTypography.caption(
            context,
            scheme.onSurfaceVariant,
          ).copyWith(fontWeight: FontWeight.w800),
        ),
        SizedBox(height: CoreSpacing.sm(context)),
        Wrap(
          spacing: CoreSpacing.sm(context),
          runSpacing: CoreSpacing.sm(context),
          children: [
            for (final role in roles)
              FilterChip(
                label: Text(roleLabel(l10n, role)),
                selected: selectedRoles.contains(role),
                onSelected: (selected) => onRoleToggled(role, selected),
              ),
          ],
        ),
      ],
    );
  }
}
