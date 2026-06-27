import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/repositories/user_profile_repository.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/session_providers.dart';
import 'package:ayletna_restaurant_app/providers/user_profile_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_avatar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_phone_text.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Personal account settings for staff and admin roles (profile, contact, alerts).
class UserPersonalSettingsScreen extends ConsumerWidget {
  const UserPersonalSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final role = ref.watch(appRoleProvider);
    final profile = ref.watch(userProfileProvider);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final scheme = Theme.of(context).colorScheme;
    final roleLabel = _roleLabel(l10n, role);
    final subtitle =
        role == AppRole.cashier && profile.employeeId != null
            ? l10n.cashierDrawerIdentity(
              profile.employeeId!,
              profile.displayName(isAr),
            )
            : l10n.settingsEmployeeSince;

    return WidgetsScaffoldPage(
      title: l10n.screenAccountSettings,
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.read(userProfileRepositoryProvider).reset();
          UtilityMockFeedback.showInfo(context, l10n.screenProfile);
        },
        child: ListView(
          children: [
            SizedBox(height: CoreSpacing.md(context)),
            Text(
              l10n.profileAccountSettings,
              style: CoreTypography.caption(context, scheme.onSurfaceVariant),
            ),
            Text(
              l10n.profilePersonalProfile,
              style: CoreTypography.headlineSmall(context, scheme.onSurface),
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            Text(
              l10n.settingsPersonalSubtitle,
              style: CoreTypography.bodyMedium(
                context,
                scheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            _ProfileSummaryCard(
              displayName: profile.displayName(isAr),
              subtitle: subtitle,
              roleLabel: roleLabel,
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            _ContactCard(phone: profile.phone, email: profile.email),
            SizedBox(height: CoreSpacing.lg(context)),
            const _NotificationPreferencesCard(),
            if (role == AppRole.operator || role == AppRole.owner) ...[
              SizedBox(height: CoreSpacing.lg(context)),
              _BusinessSettingsCard(l10n: l10n),
            ],
            SizedBox(height: CoreSpacing.lg(context)),
            WidgetsAppButton(
              label: l10n.profileLogout,
              onPressed: () {
                ref.read(userProfileRepositoryProvider).reset();
                ref.read(sessionProvider.notifier).signOut();
                context.go(AppRoutePaths.login);
              },
              variant: WidgetsAppButtonVariant.outline,
            ),
            SizedBox(height: CoreSpacing.xxl(context)),
          ],
        ),
      ),
    );
  }

  static String _roleLabel(AppLocalizations l10n, AppRole role) {
    return switch (role) {
      AppRole.cashier => l10n.roleCashier,
      AppRole.kitchen => l10n.roleKitchen,
      AppRole.delivery => l10n.roleDelivery,
      AppRole.inventory => l10n.roleInventory,
      AppRole.staff => l10n.roleStaff,
      AppRole.operator => l10n.roleOperator,
      AppRole.owner => l10n.roleOwner,
      AppRole.customer => l10n.roleCustomer,
      AppRole.guest => l10n.roleCustomer,
    };
  }
}

class _ProfileSummaryCard extends StatelessWidget {
  const _ProfileSummaryCard({
    required this.displayName,
    required this.subtitle,
    required this.roleLabel,
  });

  final String displayName;
  final String subtitle;
  final String roleLabel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    void openPhotoSheet() {
      UtilityMockFeedback.showActionSheet(
        context: context,
        title: l10n.profileChangePhoto,
        message: l10n.profilePersonalProfile,
        actions: [
          MockSheetAction(
            label: l10n.actionSave,
            icon: Icons.photo_camera_outlined,
            onSelected:
                () =>
                    UtilityMockFeedback.showInfo(context, l10n.demoModeBanner),
          ),
        ],
      );
    }

    return WidgetsAppCard(
      accentColor: scheme.primary,
      child: Column(
        children: [
          Semantics(
            button: true,
            label: l10n.profileChangePhoto,
            child: InkWell(
              borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
              onTap: openPhotoSheet,
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  WidgetsAvatar(
                    icon: Icons.person,
                    color: scheme.primary,
                    radius: CoreContentSizes.profileAvatarRadius(context),
                  ),
                  Material(
                    color: scheme.primary,
                    shape: const CircleBorder(),
                    elevation: 2,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: openPhotoSheet,
                      child: SizedBox.square(
                        dimension: 34,
                        child: Icon(
                          Icons.photo_camera_outlined,
                          color: scheme.onPrimary,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsStatusPill(
            label: roleLabel,
            color: scheme.primary,
            compact: true,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            displayName,
            textAlign: TextAlign.center,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsAppButton(
            label: l10n.profileEditDetails,
            onPressed: () => context.push(AppRoutePaths.editProfile),
            icon: Icons.edit_outlined,
          ),
        ],
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({required this.phone, required this.email});

  final String phone;
  final String email;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      title: l10n.profileContact,
      leading: Icon(
        Icons.contact_mail_outlined,
        color: scheme.onSurfaceVariant,
      ),
      accentColor: scheme.onSurfaceVariant,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _InfoLine(
            label: l10n.profilePhoneNumber,
            value: phone,
            forceValueLtr: true,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _InfoLine(label: l10n.profileEmailAddress, value: email),
        ],
      ),
    );
  }
}

class _NotificationPreferencesCard extends ConsumerWidget {
  const _NotificationPreferencesCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final profile = ref.watch(userProfileProvider);
    final repo = ref.read(userProfileRepositoryProvider);

    return WidgetsAppCard(
      title: l10n.profileNotificationPreferences,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _PreferenceSwitch(
            title: l10n.profileOrderStatusUpdates,
            subtitle: l10n.settingsStaffOrderAlertsSubtitle,
            value: profile.orderAlerts,
            onChanged: repo.setOrderAlerts,
          ),
          _PreferenceSwitch(
            title: l10n.settingsStaffShiftAlerts,
            subtitle: l10n.settingsStaffShiftAlertsSubtitle,
            value: profile.shiftAlerts,
            onChanged: repo.setShiftAlerts,
          ),
          _PreferenceSwitch(
            title: l10n.profileMarketingOffers,
            subtitle: l10n.profileMarketingSubtitle,
            value: profile.marketing,
            onChanged: repo.setMarketing,
          ),
        ],
      ),
    );
  }
}

class _BusinessSettingsCard extends StatelessWidget {
  const _BusinessSettingsCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      title: l10n.screenSettings,
      leading: Icon(Icons.tune_outlined, color: scheme.primary),
      accentColor: scheme.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.settingsBusinessSettingsHint,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.screenSettings,
            onPressed: () => context.push(AppRoutePaths.adminSettings),
            icon: Icons.arrow_forward,
            variant: WidgetsAppButtonVariant.outline,
          ),
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({
    required this.label,
    required this.value,
    this.forceValueLtr = false,
  });

  final String label;
  final String value;
  final bool forceValueLtr;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: CoreTypography.caption(
            context,
            scheme.onSurfaceVariant,
          ).copyWith(fontWeight: FontWeight.w900),
        ),
        if (forceValueLtr)
          WidgetsPhoneText(
            phone: value,
            style: CoreTypography.bodyMedium(context, scheme.onSurface),
          )
        else
          Text(
            value,
            style: CoreTypography.bodyMedium(context, scheme.onSurface),
          ),
      ],
    );
  }
}

class _PreferenceSwitch extends StatelessWidget {
  const _PreferenceSwitch({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(bottom: CoreSpacing.md(context)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w800),
                ),
                Text(
                  subtitle,
                  style: CoreTypography.caption(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
