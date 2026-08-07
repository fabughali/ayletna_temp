import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/repositories/user_profile_repository.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/session_providers.dart';
import 'package:ayletna_restaurant_app/providers/role_permissions_providers.dart';
import 'package:ayletna_restaurant_app/providers/user_profile_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/utilities/utility_profile_photo.dart';
import 'package:ayletna_restaurant_app/utilities/utility_role_labels.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_role_switcher.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_avatar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_settings_row.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_phone_text.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_switch.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_theme_mode_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Personal account settings — same chrome as customer Settings for every role.
class UserPersonalSettingsScreen extends ConsumerWidget {
  const UserPersonalSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final role = ref.watch(appRoleProvider);
    final profile = ref.watch(userProfileProvider);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final scheme = Theme.of(context).colorScheme;
    final selectedCode = Localizations.localeOf(context).languageCode;

    return WidgetsScaffoldPage(
      title: l10n.screenSettings,
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.read(userProfileRepositoryProvider).reset();
          UtilityMockFeedback.showInfo(context, l10n.settingsProfileRefreshed);
        },
        child: ListView(
          children: [
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsPageHeader(
              title: l10n.profilePersonalProfile,
              subtitle: '${l10n.screenSettings} · ${roleLabel(l10n, role)}',
            ),
            _ProfileHeaderCard(
              displayName: profile.displayName(isAr),
              email: profile.email,
              phone: profile.phone,
              avatarUrl: profile.avatarUrl,
              l10n: l10n,
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            WidgetsSettingsRow(
              title: l10n.screenLanguageSelection,
              subtitle:
                  selectedCode == 'ar'
                      ? l10n.languageArabic
                      : l10n.languageEnglish,
              icon: Icons.language_outlined,
              trailing: const Icon(Icons.chevron_right),
              onTap:
                  () => UtilityMockFeedback.showActionSheet(
                    context: context,
                    title: l10n.screenLanguageSelection,
                    message: l10n.selectLanguageSubtitle,
                    actions: [
                      MockSheetAction(
                        label: l10n.languageEnglish,
                        onSelected:
                            () =>
                                ref
                                    .read(appLocaleProvider.notifier)
                                    .state = const Locale('en'),
                      ),
                      MockSheetAction(
                        label: l10n.languageArabic,
                        onSelected:
                            () =>
                                ref
                                    .read(appLocaleProvider.notifier)
                                    .state = const Locale('ar'),
                      ),
                    ],
                  ),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            const WidgetsThemeModeSelector(),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsSettingsRow(
              title: l10n.profileOrderStatusUpdates,
              subtitle: l10n.profileOrderStatusSubtitle,
              icon: Icons.local_shipping_outlined,
              trailing: WidgetsAppSwitch(
                value: profile.orderAlerts,
                onChanged:
                    (value) =>
                        ref
                            .read(userProfileRepositoryProvider)
                            .setOrderAlerts(value),
              ),
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsSettingsRow(
              title: l10n.settingsStaffShiftAlerts,
              subtitle: l10n.settingsStaffShiftAlertsSubtitle,
              icon: Icons.schedule_outlined,
              trailing: WidgetsAppSwitch(
                value: profile.shiftAlerts,
                onChanged:
                    (value) =>
                        ref
                            .read(userProfileRepositoryProvider)
                            .setShiftAlerts(value),
              ),
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsSettingsRow(
              title: l10n.profileMarketingOffers,
              subtitle: l10n.profileMarketingSubtitle,
              icon: Icons.campaign_outlined,
              trailing: WidgetsAppSwitch(
                value: profile.marketing,
                onChanged:
                    (value) =>
                        ref
                            .read(userProfileRepositoryProvider)
                            .setMarketing(value),
              ),
            ),
            if (ref.watch(sessionProvider).approvedRoles.length >= 2) ...[
              SizedBox(height: CoreSpacing.lg(context)),
              WidgetsAppCard(
                accentColor: scheme.primary,
                padding: EdgeInsets.all(CoreSpacing.lg(context)),
                child: const WidgetsRoleSwitcher(),
              ),
            ],
            if (role == AppRole.operator || role == AppRole.admin) ...[
              SizedBox(height: CoreSpacing.lg(context)),
              _BusinessSettingsCard(l10n: l10n, role: role),
            ],
            if (role == AppRole.owner) ...[
              SizedBox(height: CoreSpacing.lg(context)),
              _OwnerShareCard(profileEmail: profile.email),
            ],
            SizedBox(height: CoreSpacing.xl(context)),
            WidgetsAppButton(
              label: l10n.profileLogout,
              onPressed: () {
                ref.read(userProfileRepositoryProvider).reset();
                ref.read(sessionProvider.notifier).signOut();
                context.go(AppRoutePaths.login);
              },
              variant: WidgetsAppButtonVariant.outline,
              icon: Icons.logout,
            ),
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsAppButton(
              label: l10n.profileDeactivateAccount,
              onPressed: () async {
                final confirmed = await UtilityMockFeedback.confirm(
                  context: context,
                  title: l10n.profileDeactivateAccount,
                  message: l10n.profileDeactivateNotAvailable,
                  confirmLabel: l10n.actionConfirm,
                  cancelLabel: l10n.actionCancel,
                  confirmVariant: WidgetsAppButtonVariant.danger,
                  icon: Icons.warning_amber_outlined,
                );
                if (confirmed && context.mounted) {
                  UtilityMockFeedback.showWarning(
                    context,
                    l10n.profileDeactivateNotAvailable,
                  );
                }
              },
              variant: WidgetsAppButtonVariant.danger,
            ),
            SizedBox(height: CoreSpacing.xxl(context)),
          ],
        ),
      ),
    );
  }
}

class _OwnerShareCard extends ConsumerWidget {
  const _OwnerShareCard({required this.profileEmail});

  final String profileEmail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final profile = ref.watch(userProfileProvider);
    double? share = profile.ownershipPercentage;

    if (share == null) {
      final users = ref.watch(rbacUsersProvider);
      for (final user in users) {
        if (user.email == profileEmail) {
          share = user.ownershipPercentage;
          break;
        }
      }
    }
    share ??= 35;

    return WidgetsAppCard(
      title: l10n.ownershipPercentageLabel,
      accentColor: scheme.primary,
      child: Text(
        l10n.ownershipShareValue('${share.round()}'),
        style: CoreTypography.headlineSmall(
          context,
          scheme.primary,
        ).copyWith(fontWeight: FontWeight.w900),
      ),
    );
  }
}

class _ProfileHeaderCard extends ConsumerWidget {
  const _ProfileHeaderCard({
    required this.displayName,
    required this.email,
    required this.phone,
    required this.avatarUrl,
    required this.l10n,
  });

  final String displayName;
  final String email;
  final String phone;
  final String? avatarUrl;
  final AppLocalizations l10n;

  Future<void> _openPhotoSheet(BuildContext context, WidgetRef ref) {
    return UtilityProfilePhoto.presentPicker(
      context,
      hasExistingPhoto: avatarUrl != null && avatarUrl!.isNotEmpty,
      onAvatarChanged:
          (url) => ref.read(userProfileRepositoryProvider).setAvatarUrl(url),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final badgeSize = CoreContentSizes.profileAvatarEditBadge(context);
    final badgeIconSize = CoreContentSizes.profileAvatarEditIcon(context);

    return WidgetsAppCard(
      accentColor: scheme.primary,
      padding: EdgeInsets.all(CoreSpacing.xl(context)),
      child: Column(
        children: [
          Semantics(
            button: true,
            label: l10n.profileChangePhoto,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () => _openPhotoSheet(context, ref),
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  WidgetsAvatar(
                    icon: Icons.person,
                    imageUrl: avatarUrl,
                    color: scheme.primary,
                    radius: CoreContentSizes.profileAvatarRadius(context),
                  ),
                  Material(
                    color: scheme.primary,
                    shape: const CircleBorder(),
                    elevation: 2,
                    child: SizedBox.square(
                      dimension: badgeSize,
                      child: Icon(
                        Icons.photo_camera_outlined,
                        color: scheme.onPrimary,
                        size: badgeIconSize,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            displayName,
            textAlign: TextAlign.center,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          Text(
            email,
            textAlign: TextAlign.center,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          WidgetsPhoneText(
            phone: phone,
            textAlign: TextAlign.center,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
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

class _BusinessSettingsCard extends StatelessWidget {
  const _BusinessSettingsCard({required this.l10n, required this.role});

  final AppLocalizations l10n;
  final AppRole role;

  String get _settingsRoute => switch (role) {
    AppRole.admin => AppRoutePaths.appAdminSettings,
    AppRole.operator => AppRoutePaths.operatorSettings,
    _ => AppRoutePaths.operatorSettings,
  };

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      title: l10n.drawerBusinessSettings,
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
            label: l10n.drawerBusinessSettings,
            onPressed: () => context.push(_settingsRoute),
            icon: Icons.arrow_forward,
            variant: WidgetsAppButtonVariant.outline,
          ),
        ],
      ),
    );
  }
}
