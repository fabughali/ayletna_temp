import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_admin_mock.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/providers/admin_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_async_state_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_avatar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_metric_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// PRD [UserManagementScreen].
class AdminUserManagementScreen extends ConsumerWidget {
  const AdminUserManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final members = ref.watch(adminUsersProvider).filteredMembers;
    final activeCount = members.where((m) => m.active).length;

    return WidgetsScaffoldPage(
      title: l10n.staffPortalTitle,
      actions: [
        WidgetsAvatar(icon: Icons.person_outline, color: scheme.primary),
        SizedBox(width: CoreSpacing.md(context)),
      ],
      child: ListView(
        padding: EdgeInsetsDirectional.only(bottom: CoreSpacing.xxl(context)),
        children: [
          Text(
            l10n.userManagementTitle,
            style: CoreTypography.headlineSmall(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            l10n.userManagementSubtitle,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsAppTextField(
            label: l10n.menuSearchHint,
            prefixIcon: Icons.search,
            onChanged:
                (value) =>
                    ref.read(adminUsersProvider.notifier).setSearchQuery(value),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsAppButton(
            label: l10n.userAddNewStaff,
            onPressed: () => _showInviteTeamDialog(context, ref, l10n, isAr),
            icon: Icons.group_add_outlined,
            fullWidth: true,
          ),
          SizedBox(height: CoreSpacing.xl(context)),
          WidgetsMetricCard(
            label: l10n.userActiveStaff,
            value: '$activeCount',
            icon: Icons.groups_outlined,
            accentColor: CoreColors.semanticSuccess,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsMetricCard(
            label: l10n.userRolesDefined,
            value: l10n.userRolesDefinedCount,
            icon: Icons.admin_panel_settings_outlined,
            accentColor: CoreColors.orderTypeDelivery,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsMetricCard(
            label: l10n.userCurrentShift,
            value: l10n.userCurrentShiftCount,
            icon: Icons.schedule_outlined,
            accentColor: CoreColors.brandOrange,
          ),
          SizedBox(height: CoreSpacing.xl(context)),
          if (members.isEmpty)
            WidgetsAsyncStateCard.empty(
              title: l10n.userManagementTitle,
              message: l10n.userManagementSubtitle,
              actionLabel: l10n.userAddNewStaff,
              onAction: () => _showInviteTeamDialog(context, ref, l10n, isAr),
            )
          else
            for (final member in members) ...[
              _TeamMemberCard(member: member),
              SizedBox(height: CoreSpacing.md(context)),
            ],
          _InviteTeamMemberCard(isAr: isAr),
        ],
      ),
    );
  }
}

Future<void> _showInviteTeamDialog(
  BuildContext context,
  WidgetRef ref,
  AppLocalizations l10n,
  bool isAr,
) async {
  final nameEn = TextEditingController();
  final nameAr = TextEditingController();
  final email = TextEditingController();
  final roleEn = TextEditingController(text: 'Staff');
  final roleAr = TextEditingController(text: isAr ? 'موظف' : 'Staff');
  final invited = await showDialog<bool>(
    context: context,
    builder:
        (dialogContext) => AlertDialog(
          title: Text(l10n.userInviteNewTeamMember),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WidgetsAppTextField(
                  controller: nameEn,
                  label: isAr ? 'الاسم (EN)' : 'Name (EN)',
                ),
                SizedBox(height: CoreSpacing.sm(context)),
                WidgetsAppTextField(
                  controller: nameAr,
                  label: isAr ? 'الاسم (AR)' : 'Name (AR)',
                ),
                SizedBox(height: CoreSpacing.sm(context)),
                WidgetsAppTextField(
                  controller: email,
                  label: l10n.profileEmailAddress,
                  prefixIcon: Icons.email_outlined,
                ),
                SizedBox(height: CoreSpacing.sm(context)),
                WidgetsAppTextField(
                  controller: roleEn,
                  label: isAr ? 'الدور (EN)' : 'Role (EN)',
                ),
                SizedBox(height: CoreSpacing.sm(context)),
                WidgetsAppTextField(
                  controller: roleAr,
                  label: isAr ? 'الدور (AR)' : 'Role (AR)',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(isAr ? 'إلغاء' : 'Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(l10n.actionConfirm),
            ),
          ],
        ),
  );
  if (invited != true) {
    nameEn.dispose();
    nameAr.dispose();
    email.dispose();
    roleEn.dispose();
    roleAr.dispose();
    return;
  }
  final notifier = ref.read(adminUsersProvider.notifier);
  if (notifier.hasMemberEmail(email.text)) {
    nameEn.dispose();
    nameAr.dispose();
    email.dispose();
    roleEn.dispose();
    roleAr.dispose();
    if (!context.mounted) return;
    UtilityMockFeedback.showWarning(
      context,
      isAr ? 'البريد مسجل مسبقاً' : 'Email already on team',
    );
    return;
  }
  notifier.inviteMember(
    nameEn: nameEn.text.trim().isEmpty ? 'Team Member' : nameEn.text.trim(),
    nameAr: nameAr.text.trim().isEmpty ? 'عضو فريق' : nameAr.text.trim(),
    roleEn: roleEn.text.trim(),
    roleAr: roleAr.text.trim(),
    email: email.text.trim(),
  );
  nameEn.dispose();
  nameAr.dispose();
  email.dispose();
  roleEn.dispose();
  roleAr.dispose();
  if (!context.mounted) return;
  UtilityMockFeedback.showSuccess(context, l10n.userInviteNewTeamMember);
}

class _TeamMemberCard extends ConsumerWidget {
  const _TeamMemberCard({required this.member});

  final ModelAdminTeamMember member;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final color = _memberColor(scheme, member.colorKey);

    return WidgetsAppCard(
      accentColor: color,
      child: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WidgetsAvatar(icon: _memberIcon(member.iconKey), color: color),
                SizedBox(width: CoreSpacing.md(context)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              isAr ? member.nameAr : member.nameEn,
                              style: CoreTypography.bodyMedium(
                                context,
                                scheme.onSurface,
                              ).copyWith(fontWeight: FontWeight.w900),
                            ),
                          ),
                          WidgetsStatusPill(
                            label:
                                member.active
                                    ? l10n.userActive.toUpperCase()
                                    : l10n.userInactive.toUpperCase(),
                            color:
                                member.active
                                    ? CoreColors.semanticSuccess
                                    : scheme.onSurfaceVariant,
                            compact: true,
                          ),
                        ],
                      ),
                      Text(
                        (isAr ? member.roleAr : member.roleEn).toUpperCase(),
                        style: CoreTypography.caption(
                          context,
                          scheme.onSurfaceVariant,
                        ).copyWith(
                          letterSpacing: 1.1,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: CoreSpacing.md(context)),
                      _MemberMeta(
                        icon: Icons.mail_outline,
                        label: member.email,
                      ),
                      SizedBox(height: CoreSpacing.xs(context)),
                      _MemberMeta(
                        icon: Icons.schedule_outlined,
                        label: isAr ? member.shiftAr : member.shiftEn,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: CoreSpacing.md(context)),
            Row(
              children: [
                Expanded(
                  child: WidgetsAppButton(
                    label: l10n.userManagePermissions,
                    onPressed: () async {
                      final confirmed = await UtilityMockFeedback.confirm(
                        context: context,
                        title: l10n.userManagePermissions,
                        message: member.email,
                        confirmLabel: l10n.actionConfirm,
                        cancelLabel: l10n.actionCancel,
                        icon: Icons.admin_panel_settings_outlined,
                      );
                      if (!context.mounted || !confirmed) return;
                      ref
                          .read(adminUsersProvider.notifier)
                          .toggleActive(member.email, !member.active);
                      UtilityMockFeedback.showSuccess(
                        context,
                        l10n.userManagePermissions,
                      );
                    },
                    variant: WidgetsAppButtonVariant.outline,
                  ),
                ),
                SizedBox(width: CoreSpacing.sm(context)),
                WidgetsIconButton(
                  onPressed: () async {
                    await UtilityMockFeedback.showActionSheet(
                      context: context,
                      title: isAr ? member.nameAr : member.nameEn,
                      message: isAr ? member.roleAr : member.roleEn,
                      actions: [
                        MockSheetAction(
                          label:
                              member.active
                                  ? l10n.userInactive
                                  : l10n.userActive,
                          icon:
                              member.active
                                  ? Icons.person_off_outlined
                                  : Icons.person_outline,
                          onSelected: () async {
                            final nextActive = !member.active;
                            final confirmed = await UtilityMockFeedback.confirm(
                              context: context,
                              title: l10n.userManagePermissions,
                              message: member.email,
                              confirmLabel: l10n.actionConfirm,
                              cancelLabel: l10n.actionCancel,
                              icon: Icons.admin_panel_settings_outlined,
                            );
                            if (!context.mounted || !confirmed) return;
                            ref
                                .read(adminUsersProvider.notifier)
                                .toggleActive(member.email, nextActive);
                            UtilityMockFeedback.showSuccess(
                              context,
                              nextActive ? l10n.userActive : l10n.userInactive,
                            );
                          },
                        ),
                      ],
                    );
                  },
                  icon: Icons.more_vert,
                  tooltip: l10n.screenSettings,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _memberColor(ColorScheme scheme, String key) {
    return switch (key) {
      'success' => CoreColors.semanticSuccess,
      'orange' => CoreColors.brandOrange,
      'delivery' => CoreColors.orderTypeDelivery,
      'plated' => CoreColors.orderTypePlated,
      'tip' => CoreColors.semanticTip,
      _ => scheme.primary,
    };
  }

  IconData _memberIcon(String key) {
    return switch (key) {
      'cashier' => Icons.point_of_sale_outlined,
      'delivery' => Icons.delivery_dining_outlined,
      'team' => Icons.groups_2_outlined,
      _ => Icons.restaurant_menu_outlined,
    };
  }
}

class _MemberMeta extends StatelessWidget {
  const _MemberMeta({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(
          icon,
          size: CoreContentSizes.orderTypeIcon(context),
          color: scheme.onSurfaceVariant,
        ),
        SizedBox(width: CoreSpacing.xs(context)),
        Expanded(
          child: Text(
            label,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}

class _InviteTeamMemberCard extends ConsumerWidget {
  const _InviteTeamMemberCard({required this.isAr});

  final bool isAr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      onTap: () => _showInviteTeamDialog(context, ref, l10n, isAr),
      variant: WidgetsAppCardVariant.filled,
      accentColor: scheme.onSurfaceVariant,
      child: Column(
        children: [
          WidgetsAvatar(icon: Icons.add, color: scheme.onSurfaceVariant),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            l10n.userInviteNewTeamMember,
            textAlign: TextAlign.center,
            style: CoreTypography.bodyMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
