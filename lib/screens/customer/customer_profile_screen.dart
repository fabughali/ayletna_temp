import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/rewards_admin_providers.dart';
import 'package:ayletna_restaurant_app/providers/session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_avatar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_phone_text.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_progress_bar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [ProfileScreen].
class CustomerProfileScreen extends ConsumerWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsScaffoldPage(
      title: l10n.screenProfile,
      child: WidgetsRefreshList(
        onRefresh: () async {
          UtilityMockFeedback.showInfo(context, l10n.comingSoon);
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
            SizedBox(height: CoreSpacing.lg(context)),
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
                  message: l10n.comingSoon,
                  confirmLabel: l10n.actionConfirm,
                  cancelLabel: l10n.actionCancel,
                  confirmVariant: WidgetsAppButtonVariant.danger,
                  icon: Icons.warning_amber_outlined,
                );

                if (confirmed && context.mounted) {
                  UtilityMockFeedback.showWarning(context, l10n.comingSoon);
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

class _ProfileSummaryCard extends StatelessWidget {
  const _ProfileSummaryCard();

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
                () => UtilityMockFeedback.showSuccess(
                  context,
                  l10n.profilePhotoUpdated,
                ),
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
            Text(
              l10n.profileMemberName,
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

class _ContactCard extends StatelessWidget {
  const _ContactCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return _SectionCard(
      title: l10n.profileContact,
      icon: Icons.contact_mail_outlined,
      iconColor: scheme.onSurfaceVariant,
      children: [
        _InfoLine(
          label: l10n.profilePhoneNumber,
          value: l10n.profilePhoneValue,
          forceValueLtr: true,
        ),
        SizedBox(height: CoreSpacing.md(context)),
        _InfoLine(
          label: l10n.profileEmailAddress,
          value: l10n.profileEmailValue,
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
    final transactions = ref.watch(loyaltyTransactionsProvider).take(3).toList();

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
              isArabic
                  ? 'لا توجد حركات نقاط بعد.'
                  : 'No points activity yet.',
              style: CoreTypography.bodyMedium(
                context,
                scheme.onSurfaceVariant,
              ),
            )
          else
            for (final tx in transactions) ...[
              _PointsActivityTile(
                title: isArabic ? tx.titleAr : tx.titleEn,
                subtitle: isArabic ? 'حركة نقاط' : 'Points activity',
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
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
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
                  borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
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
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
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

class _SavedAddressesCard extends StatefulWidget {
  const _SavedAddressesCard();

  @override
  State<_SavedAddressesCard> createState() => _SavedAddressesCardState();
}

class _SavedAddressesCardState extends State<_SavedAddressesCard> {
  var _defaultAddressId = 'home';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

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
        _AddressTile(
          icon: Icons.home,
          title: l10n.profileHomeAddressTitle,
          address: l10n.profileHomeAddress,
          color: scheme.primary,
          isDefault: _defaultAddressId == 'home',
          onDefaultChanged: () => setState(() => _defaultAddressId = 'home'),
          onDelete: () => _confirmDelete(context, l10n.profileHomeAddressTitle),
        ),
        SizedBox(height: CoreSpacing.md(context)),
        _AddressTile(
          icon: Icons.work_outline,
          title: l10n.profileOfficeAddressTitle,
          address: l10n.profileOfficeAddress,
          color: scheme.onSurfaceVariant,
          isDefault: _defaultAddressId == 'office',
          onDefaultChanged: () => setState(() => _defaultAddressId = 'office'),
          onDelete:
              () => _confirmDelete(context, l10n.profileOfficeAddressTitle),
        ),
      ],
    );
  }

  Future<void> _confirmDelete(BuildContext context, String title) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await UtilityMockFeedback.confirm(
      context: context,
      title: l10n.profileDeleteAddressTitle,
      message: '$title\n${l10n.profileDeleteAddressBody}',
      confirmLabel: l10n.addressesDelete,
      cancelLabel: l10n.actionCancel,
      confirmVariant: WidgetsAppButtonVariant.danger,
      icon: Icons.delete_outline,
    );

    if (confirmed && context.mounted) {
      UtilityMockFeedback.showWarning(context, l10n.addressesDelete);
    }
  }
}

class _NotificationPreferencesCard extends StatefulWidget {
  const _NotificationPreferencesCard();

  @override
  State<_NotificationPreferencesCard> createState() =>
      _NotificationPreferencesCardState();
}

class _NotificationPreferencesCardState
    extends State<_NotificationPreferencesCard> {
  bool _orders = true;
  bool _loyalty = true;
  bool _marketing = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return _SectionCard(
      title: l10n.profileNotificationPreferences,
      children: [
        _PreferenceSwitch(
          title: l10n.profileOrderStatusUpdates,
          subtitle: l10n.profileOrderStatusSubtitle,
          value: _orders,
          onChanged: (value) => setState(() => _orders = value),
        ),
        _PreferenceSwitch(
          title: l10n.profileLoyaltyRewards,
          subtitle: l10n.profileLoyaltySubtitle,
          value: _loyalty,
          onChanged: (value) => setState(() => _loyalty = value),
        ),
        _PreferenceSwitch(
          title: l10n.profileMarketingOffers,
          subtitle: l10n.profileMarketingSubtitle,
          value: _marketing,
          onChanged: (value) => setState(() => _marketing = value),
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
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
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
                borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
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
                    borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
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
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
