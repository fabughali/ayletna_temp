import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/utilities/utility_role_labels.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_role_chip_selector.dart';
import 'package:flutter/material.dart';

/// Grouped role picker for RBAC Screen A (all assignable roles).
class WidgetsRolePickerField extends StatelessWidget {
  const WidgetsRolePickerField({
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final AppRole selected;
  final ValueChanged<AppRole> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    Widget section(String title, List<AppRole> roles) {
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
                ChoiceChip(
                  label: Text(roleLabel(l10n, role)),
                  selected: selected == role,
                  onSelected: (_) => onSelected(role),
                ),
            ],
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        section(l10n.rbacRoleGroupManagementSpecialist, [
          ...WidgetsRoleChipSelector.managementRoles,
          ...WidgetsRoleChipSelector.specialistRoles,
        ]),
        SizedBox(height: CoreSpacing.md(context)),
        section(l10n.rbacRoleGroupOperations, WidgetsRoleChipSelector.opsRoles),
      ],
    );
  }
}
