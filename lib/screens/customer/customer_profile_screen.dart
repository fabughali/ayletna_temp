import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_saved_address.dart';
import 'package:ayletna_restaurant_app/data/repositories/repository_providers.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/rewards_admin_providers.dart';
import 'package:ayletna_restaurant_app/providers/session_providers.dart';
import 'package:ayletna_restaurant_app/providers/user_profile_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_async_state_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_avatar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_language_selector.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_phone_text.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_progress_bar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_switch.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_theme_mode_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [ProfileScreen].
class CustomerProfileScreen extends ConsumerWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return WidgetsScaffoldPage(
      title: l10n.screenSettings,
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(loyaltyPointsProvider);
          ref.invalidate(savedAddressesProvider);
          UtilityMockFeedback.showInfo(context, l10n.profileRefreshed);
        },
        child: ListView(
          children: [
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsPageHeader(
              title: l10n.profilePersonalProfile,
              subtitle: l10n.profileAccountSettings,
            ),
            const _ProfileSummaryCard(),
            SizedBox(height: CoreSpacing.lg(context)),
            const _LoyaltyStatusCard(),
            SizedBox(height: CoreSpacing.lg(context)),
            const _ContactCard(),
            SizedBox(height: CoreSpacing.lg(context)),
            const _PointsActivityCard(),
            SizedBox(height: CoreSpacing.lg(context)),
            const _PaymentHistoryCard(),
            SizedBox(height: CoreSpacing.lg(context)),
            const _SavedAddressesCard(),
            SizedBox(height: CoreSpacing.lg(context)),
            const WidgetsLanguagePreferencesSection(),
            SizedBox(height: CoreSpacing.lg(context)),
            const WidgetsThemeModeSelector(),
            SizedBox(height: CoreSpacing.lg(context)),
            const _NotificationPreferencesCard(),
            SizedBox(height: CoreSpacing.lg(context)),
            WidgetsAppButton(
              label: l10n.profileLogout,
              onPressed: () {
                ref.read(sessionProvider.notifier).signOut();
                context.go(AppRoutePaths.login);
              },
              variant: WidgetsAppButtonVariant.outline,
            ),
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsAppButton(
              label: l10n.profileDeactivateAccount,
              onPressed: () async {
                final confirmed = await UtilityMockFeedback.confirm(
                  context: context,
                  title: l10n.profileDeactivateAccount,
                  message: l10n.profileDeactivateConfirmBody,
                  confirmLabel: l10n.actionConfirm,
                  cancelLabel: l10n.actionCancel,
                  confirmVariant: WidgetsAppButtonVariant.danger,
                  icon: Icons.warning_amber_outlined,
                );

                if (confirmed && context.mounted) {
                  UtilityMockFeedback.showSuccess(
                    context,
                    l10n.profileDeactivatedMock,
                  );
                  ref.read(sessionProvider.notifier).signOut();
                  if (context.mounted) {
                    context.go(AppRoutePaths.login);
                  }
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

class _ProfileSummaryCard extends ConsumerWidget {
  const _ProfileSummaryCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final profile = ref.watch(userProfileProvider);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    void openPhotoSheet() {
      UtilityMockFeedback.showActionSheet(
        context: context,
        title: l10n.profileChangePhoto,
        message: l10n.profilePersonalProfile,
        actions: [
          MockSheetAction(
            label: l10n.actionSave,
            icon: Icons.photo_camera_outlined,
            onSelected: () {
              ref.read(userProfileProvider.notifier).setAvatarUrl(
                    'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&w=240&h=240&q=80',
                  );
              UtilityMockFeedback.showSuccess(
                context,
                l10n.profilePhotoUpdated,
              );
            },
          ),
        ],
      );
    }

    return WidgetsAppCard(
      accentColor: scheme.primary,
      child: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Semantics(
              button: true,
              label: l10n.profileChangePhoto,
              child: InkWell(
                borderRadius: BorderRadius.circular(
                  CoreSpacing.radiusCardOf(context),
                ),
                onTap: openPhotoSheet,
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    WidgetsAvatar(
                      icon: Icons.person,
                      imageUrl: profile.avatarUrl,
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
                          dimension:
                              CoreContentSizes.profileAvatarEditBadge(context),
                          child: Icon(
                            Icons.photo_camera_outlined,
                            color: scheme.onPrimary,
                            size: CoreContentSizes.profileAvatarEditIcon(
                              context,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: CoreSpacing.md(context)),
            Text(
              profile.displayName(isAr),
              textAlign: TextAlign.center,
              style: CoreTypography.titleMedium(
                context,
                scheme.onSurface,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
            Text(
              l10n.profileMemberSince,
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
      ),
    );
  }
}

class _LoyaltyStatusCard extends ConsumerWidget {
  const _LoyaltyStatusCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final pointsBalance = ref.watch(loyaltyPointsProvider).balance;
    final tierProgress = (pointsBalance / 1000).clamp(0.0, 1.0);

    return WidgetsAppCard(
      accentColor: scheme.primary,
      variant: WidgetsAppCardVariant.filled,
      child: Stack(
        children: [
          PositionedDirectional(
            top: -CoreSpacing.lg(context),
            end: -CoreSpacing.lg(context),
            child: Icon(
              Icons.military_tech,
              color: scheme.onPrimary.withValues(alpha: 0.10),
              size: CoreContentSizes.logoWelcome(context) * 1.35,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(CoreSpacing.lg(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WidgetsStatusPill(
                            label: l10n.profileEpicureanTier,
                            color: scheme.primary,
                            compact: true,
                          ),
                          SizedBox(height: CoreSpacing.sm(context)),
                          Text(
                            l10n.profileGoldStatus,
                            style: CoreTypography.headlineSmall(
                              context,
                              scheme.primary,
                            ).copyWith(fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          l10n.profileSavorPoints,
                          style: CoreTypography.caption(
                            context,
                            scheme.primary,
                          ),
                        ),
                        Text(
                          '$pointsBalance',
                          style: CoreTypography.titleMedium(
                            context,
                            scheme.primary,
                          ).copyWith(fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                WidgetsProgressBar(value: tierProgress, color: scheme.primary),
                SizedBox(height: CoreSpacing.md(context)),
                Text(
                  l10n.profileTierProgress,
                  style: CoreTypography.caption(context, scheme.primary),
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                WidgetsAppButton(
                  label: l10n.profileRewardsCatalog,
                  onPressed: () => context.push(AppRoutePaths.loyalty),
                  icon: Icons.arrow_forward,
                  variant: WidgetsAppButtonVariant.outline,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactCard extends ConsumerWidget {
  const _ContactCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final profile = ref.watch(userProfileProvider);

    return _SectionCard(
      title: l10n.profileContact,
      icon: Icons.contact_mail_outlined,
      iconColor: scheme.onSurfaceVariant,
      children: [
        _InfoLine(
          label: l10n.profilePhoneNumber,
          value: profile.phone,
          forceValueLtr: true,
        ),
        SizedBox(height: CoreSpacing.md(context)),
        _InfoLine(
          label: l10n.profileEmailAddress,
          value: profile.email,
        ),
      ],
    );
  }
}

class _PointsActivityCard extends ConsumerWidget {
  const _PointsActivityCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final transactions =
        ref.watch(loyaltyTransactionsProvider).take(3).toList();

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: CoreColors.brandOlive.withValues(alpha: 0.14),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(CoreSpacing.md(context)),
                  child: const Icon(
                    Icons.stars_rounded,
                    color: CoreColors.brandOlive,
                  ),
                ),
              ),
              SizedBox(width: CoreSpacing.md(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.profilePointsHistory,
                      style: CoreTypography.titleMedium(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    Text(
                      l10n.profilePointsHistorySubtitle,
                      style: CoreTypography.caption(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          if (transactions.isEmpty)
            Text(
              l10n.profileNoPointsActivity,
              style: CoreTypography.bodyMedium(
                context,
                scheme.onSurfaceVariant,
              ),
            )
          else
            for (final tx in transactions) ...[
              _PointsActivityTile(
                title: isArabic ? tx.titleAr : tx.titleEn,
                subtitle: l10n.profilePointsActivityLabel,
                points:
                    tx.pointsDelta >= 0
                        ? '+${tx.pointsDelta}'
                        : '${tx.pointsDelta}',
              ),
              if (tx != transactions.last)
                SizedBox(height: CoreSpacing.sm(context)),
            ],
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.profileViewAllPointsHistory,
            onPressed: () => context.push(AppRoutePaths.rewardsHistory),
            icon: Icons.history_outlined,
            variant: WidgetsAppButtonVariant.ghost,
          ),
        ],
      ),
    );
  }
}

class _PointsActivityTile extends StatelessWidget {
  const _PointsActivityTile({
    required this.title,
    required this.subtitle,
    required this.points,
  });

  final String title;
  final String subtitle;
  final String points;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: CoreColors.brandOlive.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
        border: Border.all(
          color: CoreColors.brandOlive.withValues(alpha: 0.18),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.md(context)),
        child: Row(
          children: [
            const Icon(
              Icons.card_giftcard_outlined,
              color: CoreColors.brandOlive,
            ),
            SizedBox(width: CoreSpacing.md(context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: CoreTypography.caption(
                      context,
                      scheme.onSurface,
                    ).copyWith(fontWeight: FontWeight.w900),
                  ),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: CoreTypography.caption(
                      context,
                      scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: CoreSpacing.sm(context)),
            Text(
              points,
              style: CoreTypography.caption(
                context,
                CoreColors.brandOlive,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentHistoryCard extends StatelessWidget {
  const _PaymentHistoryCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final orders =
        MockupCatalog.customerOrderHistory
            .where((order) => !order.isCancelled)
            .take(3)
            .toList();

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(CoreSpacing.md(context)),
                  child: Icon(
                    Icons.receipt_long_outlined,
                    color: scheme.primary,
                  ),
                ),
              ),
              SizedBox(width: CoreSpacing.md(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.profilePaymentHistory,
                      style: CoreTypography.titleMedium(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    Text(
                      l10n.profilePaymentHistorySubtitle,
                      style: CoreTypography.caption(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          for (final order in orders) ...[
            _PaymentHistoryTile(
              title: isArabic ? order.labelAr : order.labelEn,
              subtitle: isArabic ? order.dateAr : order.dateEn,
              amount: UtilityFormatJod.format(
                order.totalJod,
                suffix: l10n.currencyJod,
              ),
            ),
            if (order != orders.last) SizedBox(height: CoreSpacing.sm(context)),
          ],
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.profileViewAllPaymentHistory,
            onPressed: () => context.push(AppRoutePaths.paymentHistory),
            icon: Icons.history_outlined,
            variant: WidgetsAppButtonVariant.ghost,
          ),
        ],
      ),
    );
  }
}

class _PaymentHistoryTile extends StatelessWidget {
  const _PaymentHistoryTile({
    required this.title,
    required this.subtitle,
    required this.amount,
  });

  final String title;
  final String subtitle;
  final String amount;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
        border: Border.all(color: scheme.primary.withValues(alpha: 0.16)),
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.md(context)),
        child: Row(
          children: [
            Icon(Icons.check_circle_outline, color: scheme.primary),
            SizedBox(width: CoreSpacing.md(context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: CoreTypography.caption(
                      context,
                      scheme.onSurface,
                    ).copyWith(fontWeight: FontWeight.w900),
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
            SizedBox(width: CoreSpacing.sm(context)),
            Text(
              amount,
              style: CoreTypography.caption(
                context,
                scheme.primary,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }
}

class _SavedAddressesCard extends ConsumerWidget {
  const _SavedAddressesCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final addressesAsync = ref.watch(savedAddressesProvider);

    return _SectionCard(
      title: l10n.profileSavedAddresses,
      trailing: WidgetsAppButton(
        label: l10n.profileAddNew,
        onPressed:
            () => context.push('${AppRoutePaths.mapPicker}?return=profile'),
        icon: Icons.add,
        variant: WidgetsAppButtonVariant.outline,
      ),
      children: [
        addressesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error:
              (error, _) => WidgetsAsyncStateCard.error(
                title: l10n.profileSavedAddresses,
                message: error.toString(),
                actionLabel: l10n.actionSave,
                onAction: () => ref.invalidate(savedAddressesProvider),
              ),
          data: (addresses) {
            if (addresses.isEmpty) {
              return WidgetsAsyncStateCard.empty(
                title: l10n.profileSavedAddresses,
                message: l10n.addressesEmptyMessage,
                actionLabel: l10n.profileAddNew,
                onAction:
                    () => context.push(
                      '${AppRoutePaths.mapPicker}?return=profile',
                    ),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < addresses.length; i++) ...[
                  if (i > 0) SizedBox(height: CoreSpacing.md(context)),
                  _AddressTile(
                    icon: _profileAddressIcon(addresses[i].iconKey),
                    title: addresses[i].labelForLocale(isAr),
                    address: addresses[i].addressForLocale(isAr),
                    color:
                        addresses[i].isSelected
                            ? scheme.primary
                            : scheme.onSurfaceVariant,
                    isDefault: addresses[i].isSelected,
                    onDefaultChanged:
                        () => _setDefaultAddress(context, ref, addresses[i].id),
                    onDelete:
                        () => _confirmDelete(context, ref, addresses[i]),
                  ),
                ],
              ],
            );
          },
        ),
      ],
    );
  }

  Future<void> _setDefaultAddress(
    BuildContext context,
    WidgetRef ref,
    String id,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      await ref.read(repositoryAddressProvider).setDefaultAddress(id);
      ref.invalidate(savedAddressesProvider);
      if (!context.mounted) return;
      UtilityMockFeedback.showSuccess(context, l10n.actionSave);
    } catch (_) {
      if (!context.mounted) return;
      UtilityMockFeedback.showError(context, l10n.addressesDeleteFailed);
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    ModelSavedAddress address,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final title = address.labelForLocale(isAr);
    final confirmed = await UtilityMockFeedback.confirm(
      context: context,
      title: l10n.profileDeleteAddressTitle,
      message: '$title\n${l10n.profileDeleteAddressBody}',
      confirmLabel: l10n.addressesDelete,
      cancelLabel: l10n.actionCancel,
      confirmVariant: WidgetsAppButtonVariant.danger,
      icon: Icons.delete_outline,
    );

    if (!confirmed || !context.mounted) return;

    try {
      await ref.read(repositoryAddressProvider).deleteAddress(address.id);
      ref.invalidate(savedAddressesProvider);
      if (!context.mounted) return;
      UtilityMockFeedback.showSuccess(context, l10n.addressesDelete);
    } catch (_) {
      if (!context.mounted) return;
      UtilityMockFeedback.showError(context, l10n.addressesDeleteFailed);
    }
  }
}

IconData _profileAddressIcon(String key) {
  return switch (key) {
    'work' => Icons.work_outline,
    'gym' => Icons.location_on_outlined,
    _ => Icons.home_outlined,
  };
}

class _NotificationPreferencesCard extends ConsumerWidget {
  const _NotificationPreferencesCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final profile = ref.watch(userProfileProvider);

    return _SectionCard(
      title: l10n.profileNotificationPreferences,
      children: [
        _PreferenceSwitch(
          title: l10n.profileOrderStatusUpdates,
          subtitle: l10n.profileOrderStatusSubtitle,
          value: profile.orderAlerts,
          onChanged:
              (value) =>
                  ref.read(userProfileProvider.notifier).setOrderAlerts(value),
        ),
        _PreferenceSwitch(
          title: l10n.profileLoyaltyRewards,
          subtitle: l10n.profileLoyaltySubtitle,
          // Mock reuse of shiftAlerts until a dedicated loyaltyAlerts field exists.
          value: profile.shiftAlerts,
          onChanged:
              (value) =>
                  ref.read(userProfileProvider.notifier).setShiftAlerts(value),
        ),
        _PreferenceSwitch(
          title: l10n.profileMarketingOffers,
          subtitle: l10n.profileMarketingSubtitle,
          value: profile.marketing,
          onChanged:
              (value) =>
                  ref.read(userProfileProvider.notifier).setMarketing(value),
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.children,
    this.icon,
    this.trailing,
    this.iconColor,
  });

  final String title;
  final List<Widget> children;
  final IconData? icon;
  final Widget? trailing;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: title,
      leading: icon == null ? null : Icon(icon, color: iconColor),
      trailing: trailing,
      accentColor: iconColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
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

class _AddressTile extends StatelessWidget {
  const _AddressTile({
    required this.icon,
    required this.title,
    required this.address,
    required this.color,
    required this.isDefault,
    required this.onDefaultChanged,
    required this.onDelete,
  });

  final IconData icon;
  final String title;
  final String address;
  final Color color;
  final bool isDefault;
  final VoidCallback onDefaultChanged;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.md(context)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
              ),
              child: Padding(
                padding: EdgeInsets.all(CoreSpacing.sm(context)),
                child: Icon(icon, color: color),
              ),
            ),
            SizedBox(width: CoreSpacing.md(context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: CoreTypography.caption(
                      context,
                      scheme.onSurface,
                    ).copyWith(fontWeight: FontWeight.w900),
                  ),
                  Text(
                    address,
                    style: CoreTypography.caption(
                      context,
                      scheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: CoreSpacing.sm(context)),
                  InkWell(
                    borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
                    onTap: onDefaultChanged,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: isDefault,
                          onChanged: (_) => onDefaultChanged(),
                        ),
                        Text(
                          AppLocalizations.of(context)!.addressesDefault,
                          style: CoreTypography.caption(
                            context,
                            isDefault
                                ? scheme.primary
                                : scheme.onSurfaceVariant,
                          ).copyWith(fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            WidgetsIconButton(
              onPressed:
                  () =>
                      context.push('${AppRoutePaths.mapPicker}?return=profile'),
              icon: Icons.edit_outlined,
              tooltip: AppLocalizations.of(context)!.actionEdit,
              variant: WidgetsIconButtonVariant.tonal,
            ),
            SizedBox(width: CoreSpacing.xs(context)),
            WidgetsIconButton(
              onPressed: onDelete,
              icon: Icons.delete_outline,
              tooltip: AppLocalizations.of(context)!.addressesDelete,
              variant: WidgetsIconButtonVariant.tonal,
            ),
          ],
        ),
      ),
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
          WidgetsAppSwitch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
