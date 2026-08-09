import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_permission_rule.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/role_permissions_providers.dart';
import 'package:ayletna_restaurant_app/providers/session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/utilities/utility_role_labels.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_effective_permissions_summary.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_permission_matrix.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_role_chip_selector.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen B detail — assigned roles, inherited rules, overrides, effective.
class AppAdminUserDetailPermissionsScreen extends ConsumerWidget {
  const AppAdminUserDetailPermissionsScreen({required this.userId, super.key});

  final String userId;

  static const _overrideAccessOptions = [
    PermissionAccess.full,
    PermissionAccess.readOnly,
    PermissionAccess.denied,
    PermissionAccess.postponed,
  ];

  static AppRole? _primaryRoleForKey(String key, Set<AppRole> assignedRoles) {
    for (final role in assignedRoles) {
      if (PermissionCatalog.keysForRole(role).contains(key)) return role;
    }
    return assignedRoles.isEmpty ? null : assignedRoles.first;
  }

  static Future<void> _applyOverride(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n, {
    required String userId,
    required String key,
    required PermissionAccess access,
  }) async {
    if (access == PermissionAccess.postponed) {
      final now = DateTime.now();
      final until = await showDatePicker(
        context: context,
        helpText: l10n.rbacSelectPostponeDate,
        initialDate: now.add(const Duration(days: 7)),
        firstDate: now,
        lastDate: now.add(const Duration(days: 365)),
      );
      if (!context.mounted) return;
      if (until == null) {
        UtilityMockFeedback.showWarning(context, l10n.rbacPostponeDateRequired);
        return;
      }
      ref
          .read(userPermissionOverridesProvider.notifier)
          .setOverride(
            userId,
            PermissionRule(key: key, access: access, postponedUntil: until),
          );
      UtilityMockFeedback.showSuccess(context, l10n.actionSave);
      return;
    }

    ref
        .read(userPermissionOverridesProvider.notifier)
        .setOverride(userId, PermissionRule(key: key, access: access));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final users = ref.watch(rbacUsersProvider);
    RbacUserRecord? user;
    for (final row in users) {
      if (row.id == userId) {
        user = row;
        break;
      }
    }

    if (user == null) {
      return WidgetsScaffoldPage(
        title: l10n.userPermissionsTitle,
        child: Center(child: Text(l10n.rbacUserNotFound)),
      );
    }

    final selectedUser = user;
    final roleDefaults = ref.watch(rolePermissionsProvider);
    final overrides = ref.watch(userPermissionOverridesProvider)[userId] ?? {};
    final effective = ref.watch(effectivePermissionsProvider(userId));

    final inheritedKeys = <String>{};
    for (final role in selectedUser.assignedRoles) {
      inheritedKeys.addAll(PermissionCatalog.keysForRole(role));
    }
    final inheritedList = inheritedKeys.toList()..sort();

    PermissionAccess inheritedAccess(String key) {
      for (final role in selectedUser.assignedRoles) {
        final access = roleDefaults[role]?[key];
        if (access == PermissionAccess.full) return PermissionAccess.full;
        if (access == PermissionAccess.readOnly) {
          return PermissionAccess.readOnly;
        }
      }
      return PermissionAccess.denied;
    }

    return WidgetsScaffoldPage(
      title: selectedUser.displayName(isAr),
      child: ListView(
        padding: EdgeInsetsDirectional.only(bottom: CoreSpacing.xxl(context)),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  selectedUser.email,
                  style: CoreTypography.caption(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              ),
              WidgetsStatusPill(
                label: rbacUserStatusLabel(l10n, selectedUser.status),
                color: _statusColor(scheme, selectedUser.status),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Text(
            l10n.rbacAccountActions,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.sm(context),
            children: [
              if (selectedUser.status == 'pending_approval') ...[
                ActionChip(
                  avatar: Icon(Icons.check, size: CoreContentSizes.orderTypeIcon(context)),
                  label: Text(l10n.rbacApprove),
                  onPressed: () {
                    ref
                        .read(rbacUsersProvider.notifier)
                        .updateStatus(userId, 'active');
                    UtilityMockFeedback.showSuccess(
                      context,
                      l10n.rbacApprovedMessage,
                    );
                  },
                ),
                ActionChip(
                  avatar: Icon(Icons.close, size: CoreContentSizes.orderTypeIcon(context)),
                  label: Text(l10n.rbacReject),
                  onPressed: () {
                    ref
                        .read(rbacUsersProvider.notifier)
                        .updateStatus(userId, 'suspended');
                    UtilityMockFeedback.showInfo(
                      context,
                      l10n.rbacRejectedMessage,
                    );
                  },
                ),
              ],
              if (selectedUser.status == 'active')
                ActionChip(
                  avatar: Icon(Icons.pause_circle_outline, size: CoreContentSizes.orderTypeIcon(context)),
                  label: Text(l10n.rbacSuspend),
                  onPressed: () {
                    ref
                        .read(rbacUsersProvider.notifier)
                        .updateStatus(userId, 'suspended');
                    UtilityMockFeedback.showInfo(
                      context,
                      l10n.rbacSuspendedMessage,
                    );
                  },
                ),
              if (selectedUser.status == 'suspended')
                ActionChip(
                  avatar: Icon(Icons.play_circle_outline, size: CoreContentSizes.orderTypeIcon(context)),
                  label: Text(l10n.rbacActivate),
                  onPressed: () {
                    ref
                        .read(rbacUsersProvider.notifier)
                        .updateStatus(userId, 'active');
                    UtilityMockFeedback.showSuccess(
                      context,
                      l10n.rbacActivatedMessage,
                    );
                  },
                ),
              ActionChip(
                avatar: Icon(Icons.person_add_outlined, size: CoreContentSizes.orderTypeIcon(context)),
                label: Text(l10n.rbacInvite),
                onPressed:
                    () => UtilityMockFeedback.showInfo(
                      context,
                      l10n.rbacInviteMockMessage,
                    ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.xl(context)),
          Text(
            l10n.rbacAssignedRoles,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsRoleChipSelector(
            selectedRoles: selectedUser.assignedRoles,
            onRoleToggled: (role, selected) {
              final next = Set<AppRole>.from(selectedUser.assignedRoles);
              if (selected) {
                next.add(role);
              } else {
                next.remove(role);
              }
              ref.read(rbacUsersProvider.notifier).assignRoles(userId, next);
              final session = ref.read(sessionProvider);
              if (session.userId == userId) {
                ref.read(sessionProvider.notifier).syncApprovedRoles(next);
                final active = ref.read(appRoleProvider);
                if (!ref.read(sessionProvider).approvedRoles.contains(active)) {
                  final fallback =
                      ref.read(sessionProvider).approvedRoles.isEmpty
                          ? AppRole.customer
                          : ref.read(sessionProvider).approvedRoles.first;
                  ref.read(appRoleProvider.notifier).state = fallback;
                }
              }
              UtilityMockFeedback.showSuccess(context, l10n.actionSave);
            },
          ),
          if (selectedUser.assignedRoles.contains(AppRole.owner)) ...[
            SizedBox(height: CoreSpacing.lg(context)),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${l10n.ownershipPercentageLabel}: ${selectedUser.ownershipPercentage?.toStringAsFixed(0) ?? '—'}%',
                    style: CoreTypography.bodyMedium(context, scheme.onSurface),
                  ),
                ),
                IconButton(
                  tooltip: l10n.actionEdit,
                  onPressed:
                      () => _editOwnership(context, ref, selectedUser, l10n),
                  icon: const Icon(Icons.edit_outlined),
                ),
              ],
            ),
          ],
          SizedBox(height: CoreSpacing.xl(context)),
          Text(
            l10n.inheritedRulesTitle,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsPermissionMatrix(
            keys: inheritedList,
            readOnly: true,
            accessForKey: inheritedAccess,
            onKeyTap: (key) {
              final role = _primaryRoleForKey(key, selectedUser.assignedRoles);
              if (role == null) return;
              context.push('${AppRoutePaths.appAdminRoles}?role=${role.name}');
            },
          ),
          SizedBox(height: CoreSpacing.xl(context)),
          Text(
            l10n.userOverridesTitle,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsPermissionMatrix(
            keys: inheritedList,
            accessOptions: _overrideAccessOptions,
            accessForKey:
                (key) => overrides[key]?.access ?? inheritedAccess(key),
            postponedUntilForKey: (key) => overrides[key]?.postponedUntil,
            onChanged:
                (key, access) => _applyOverride(
                  context,
                  ref,
                  l10n,
                  userId: userId,
                  key: key,
                  access: access,
                ),
          ),
          SizedBox(height: CoreSpacing.xl(context)),
          Text(
            l10n.effectivePermissionsTitle,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsEffectivePermissionsSummary(effective: effective),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsPermissionMatrix(
            keys: inheritedList,
            readOnly: true,
            accessForKey: (key) => effective[key] ?? PermissionAccess.denied,
            postponedUntilForKey: (key) {
              final override = overrides[key];
              if (override?.access == PermissionAccess.postponed) {
                return override?.postponedUntil;
              }
              return null;
            },
          ),
          SizedBox(height: CoreSpacing.xl(context)),
          WidgetsAppButton(
            label: l10n.rolePermissionsTitle,
            variant: WidgetsAppButtonVariant.outline,
            onPressed: () => context.push(AppRoutePaths.appAdminRoles),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppButton(
            label: l10n.actionSave,
            onPressed:
                () => UtilityMockFeedback.showSuccess(context, l10n.actionSave),
          ),
        ],
      ),
    );
  }

  static Color _statusColor(ColorScheme scheme, String status) =>
      switch (status) {
        'pending_approval' => CoreColors.brandOrange,
        'suspended' => CoreColors.semanticError,
        _ => CoreColors.semanticSuccess,
      };

  Future<void> _editOwnership(
    BuildContext context,
    WidgetRef ref,
    RbacUserRecord user,
    AppLocalizations l10n,
  ) async {
    final controller = TextEditingController(
      text: user.ownershipPercentage?.toStringAsFixed(0) ?? '',
    );
    final value = await showDialog<double>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(l10n.rbacOwnershipPercent),
            content: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                suffixText: '%',
                hintText: l10n.rbacOwnershipHint,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.actionCancel),
              ),
              TextButton(
                onPressed: () {
                  final parsed = double.tryParse(controller.text.trim());
                  Navigator.pop(context, parsed);
                },
                child: Text(l10n.actionSave),
              ),
            ],
          ),
    );
    if (value != null && context.mounted) {
      ref.read(rbacUsersProvider.notifier).updateOwnership(user.id, value);
    }
    controller.dispose();
  }
}
