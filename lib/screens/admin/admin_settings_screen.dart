import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/admin_session_providers.dart';
import 'package:ayletna_restaurant_app/providers/app_branding_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_bubble.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_soft_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Which hub owns this settings screen (split per RBAC model).
enum AdminSettingsScope { appAdmin, operator }

/// PRD [SettingsScreen] — ops settings for operator; system links for app admin.
class AdminSettingsScreen extends ConsumerWidget {
  const AdminSettingsScreen({this.scope = AdminSettingsScope.operator, super.key});

  final AdminSettingsScope scope;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final settings = ref.watch(adminSettingsProvider);
    final isAppAdmin = scope == AdminSettingsScope.appAdmin;

    return WidgetsScaffoldPage(
      title: isAppAdmin ? l10n.hubAppAdmin : l10n.screenSettings,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
        WidgetsIconButton(
          onPressed: () => context.push(
            isAppAdmin ? AppRoutePaths.appAdmin : AppRoutePaths.operatorHub,
          ),
          icon: Icons.dashboard_outlined,
          tooltip: isAppAdmin ? l10n.hubAppAdmin : l10n.hubOperator,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          await Future<void>.delayed(const Duration(milliseconds: 300));
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 900;

            if (isAppAdmin) {
              return ListView(
                padding: EdgeInsetsDirectional.only(
                  top: CoreSpacing.md(context),
                  bottom: CoreSpacing.xxl(context),
                ),
                children: [
                  _SettingsHero(l10n: l10n, isAr: isAr, appAdmin: true),
                  SizedBox(height: CoreSpacing.lg(context)),
                  const _AppBrandingCard(),
                  SizedBox(height: CoreSpacing.lg(context)),
                  _AppAdminSystemCard(l10n: l10n, isAr: isAr),
                  SizedBox(height: CoreSpacing.lg(context)),
                  _SettingsShortcutsCard(
                    l10n: l10n,
                    isAr: isAr,
                    scope: AdminSettingsScope.appAdmin,
                  ),
                ],
              );
            }

            final operations = Column(
              children: [
                _BusinessHoursCard(
                  ordersOpen: settings.ordersOpen,
                  deliveryEnabled: settings.deliveryEnabled,
                  onOrdersChanged: (value) {
                    ref.read(adminSettingsProvider.notifier).setOrdersOpen(value);
                    UtilityMockFeedback.showInfo(context, l10n.settingsToggleSaved);
                  },
                  onDeliveryChanged: (value) {
                    ref
                        .read(adminSettingsProvider.notifier)
                        .setDeliveryEnabled(value);
                    UtilityMockFeedback.showInfo(context, l10n.settingsToggleSaved);
                  },
                  isAr: isAr,
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                _StationsAndRulesCard(isAr: isAr),
                SizedBox(height: CoreSpacing.lg(context)),
                _RolesAndPrivacyCard(
                  l10n: l10n,
                  isAr: isAr,
                  scope: AdminSettingsScope.operator,
                ),
              ],
            );
            final financeAndComms = Column(
              children: [
                _FeesTaxesCard(
                  taxIncluded: settings.taxIncluded,
                  onTaxChanged: (value) {
                    ref.read(adminSettingsProvider.notifier).setTaxIncluded(value);
                    UtilityMockFeedback.showInfo(context, l10n.settingsToggleSaved);
                  },
                  l10n: l10n,
                  isAr: isAr,
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                _ReceiptsNotificationsCard(
                  kitchenAlerts: settings.kitchenAlerts,
                  onKitchenAlertsChanged: (value) {
                    ref
                        .read(adminSettingsProvider.notifier)
                        .setKitchenAlerts(value);
                    UtilityMockFeedback.showInfo(context, l10n.settingsToggleSaved);
                  },
                  isAr: isAr,
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                _SettingsShortcutsCard(
                  l10n: l10n,
                  isAr: isAr,
                  scope: AdminSettingsScope.operator,
                ),
              ],
            );

            return ListView(
              padding: EdgeInsetsDirectional.only(
                top: CoreSpacing.md(context),
                bottom: CoreSpacing.xxl(context),
              ),
              children: [
                _SettingsHero(l10n: l10n, isAr: isAr),
                SizedBox(height: CoreSpacing.lg(context)),
                if (isWide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 5, child: operations),
                      SizedBox(width: CoreSpacing.lg(context)),
                      Expanded(flex: 5, child: financeAndComms),
                    ],
                  )
                else ...[
                  operations,
                  SizedBox(height: CoreSpacing.lg(context)),
                  financeAndComms,
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SettingsHero extends StatelessWidget {
  const _SettingsHero({
    required this.l10n,
    required this.isAr,
    this.appAdmin = false,
  });

  final AppLocalizations l10n;
  final bool isAr;
  final bool appAdmin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
        gradient: LinearGradient(
          colors: appAdmin
              ? [CoreColors.hubAdminAccent, CoreColors.hubAdminAccentDark]
              : [CoreColors.brandOlive, CoreColors.brandBrown],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetsSoftBadge(
            label: appAdmin
                ? l10n.hubAppAdmin
                : (l10n.settingsOpsBadge),
            color: CoreColors.surfaceLight,
            foreground: appAdmin ? CoreColors.hubAdminAccentDark : CoreColors.brandBrown,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            appAdmin
                ? l10n.settingsAppAdminHeroHeadline
                : l10n.settingsOpsHeroHeadline,
            style: CoreTypography.headlineSmall(
              context,
              CoreColors.surfaceLight,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.sm(context),
            children: [
              _HeroPill(
                label: l10n.settingsHeroNineSections,
                icon: Icons.grid_view_outlined,
              ),
              _HeroPill(
                label: l10n.settingsHeroUiOnly,
                icon: Icons.layers_outlined,
              ),
              _HeroPill(
                label: l10n.settingsHeroDrawerNav,
                icon: Icons.menu_open_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BusinessHoursCard extends StatelessWidget {
  const _BusinessHoursCard({
    required this.ordersOpen,
    required this.deliveryEnabled,
    required this.onOrdersChanged,
    required this.onDeliveryChanged,
    required this.isAr,
  });

  final bool ordersOpen;
  final bool deliveryEnabled;
  final ValueChanged<bool> onOrdersChanged;
  final ValueChanged<bool> onDeliveryChanged;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WidgetsAppCard(
      title: l10n.settingsBusinessHoursTitle,
      subtitle:
l10n.settingsBusinessHoursSubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.schedule_outlined,
        color: CoreColors.brandOlive,
      ),
      child: Column(
        children: [
          _SwitchLine(
            label: l10n.settingsAcceptingOrders,
            value: ordersOpen,
            onChanged: onOrdersChanged,
          ),
          _SwitchLine(
            label: l10n.settingsDeliveryEnabled,
            value: deliveryEnabled,
            onChanged: onDeliveryChanged,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          _SettingRow(
            label: l10n.settingsTodayHours,
            detail: l10n.settingsTodayHoursValue,
            color: CoreColors.brandOlive,
          ),
          _SettingRow(
            label: l10n.settingsPreOrdersLabel,
            detail: l10n.settingsPreOrdersDetail,
            color: CoreColors.orderTypePlated,
            route: AppRoutePaths.operatorPreOrders,
            actionLabel: l10n.commonOpen,
          ),
        ],
      ),
    );
  }
}

class _StationsAndRulesCard extends StatelessWidget {
  const _StationsAndRulesCard({required this.isAr});

  final bool isAr;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WidgetsAppCard(
      title: l10n.settingsStationsTitle,
      subtitle:
l10n.settingsStationsSubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.soup_kitchen_outlined,
        color: CoreColors.brandOrange,
      ),
      child: Column(
        children: [
          _SettingRow(
            label: l10n.settingsShawarmaStation,
            detail: l10n.settingsShawarmaPrepDetail,
            color: CoreColors.brandOrange,
          ),
          _SettingRow(
            label: l10n.settingsFryerStation,
            detail: l10n.settingsFryerLoadDetail,
            color: CoreColors.semanticError,
          ),
          _SettingRow(
            label: l10n.settingsLateTicketThreshold,
            detail: l10n.settingsLateTicketDetail,
            color: CoreColors.brandBrown,
          ),
        ],
      ),
    );
  }
}

class _AppAdminSystemCard extends StatelessWidget {
  const _AppAdminSystemCard({required this.l10n, required this.isAr});

  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: l10n.settingsSystemPlatformTitle,
subtitle: l10n.settingsSystemPlatformSubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.shield_outlined,
        color: CoreColors.hubAdminAccent,
      ),
      child: Column(
        children: [
          _SettingRow(
            label: l10n.rolePermissionsTitle,
            detail: l10n.rolePermissionsSubtitle,
            color: CoreColors.hubAdminAccent,
            route: AppRoutePaths.appAdminRoles,
            actionLabel: l10n.commonOpen,
          ),
          _SettingRow(
            label: l10n.userPermissionsTitle,
            detail: l10n.userPermissionsSubtitle,
            color: CoreColors.orderTypeDelivery,
            route: AppRoutePaths.appAdminUsers,
            actionLabel: l10n.commonOpen,
          ),
          _SettingRow(
            label: l10n.screenAppIntegrations,
            detail: l10n.settingsIntegrationsDetail,
            color: CoreColors.orderTypePlated,
            route: AppRoutePaths.appAdminIntegrations,
            actionLabel: l10n.commonOpen,
          ),
          _SettingRow(
            label: l10n.screenOwnerViewConfig,
            detail: l10n.settingsOwnerPrivacy,
            color: CoreColors.semanticDeposit,
            route: AppRoutePaths.appAdminOwnerConfig,
            actionLabel: l10n.commonOpen,
          ),
          _SettingRow(
            label: l10n.screenAuditLog,
            detail: l10n.settingsAuditTrailDetail,
            color: CoreColors.brandBrown,
            route: AppRoutePaths.appAdminAudit,
            actionLabel: l10n.commonOpen,
          ),
        ],
      ),
    );
  }
}

class _RolesAndPrivacyCard extends StatelessWidget {
  const _RolesAndPrivacyCard({
    required this.l10n,
    required this.isAr,
    required this.scope,
  });

  final AppLocalizations l10n;
  final bool isAr;
  final AdminSettingsScope scope;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: l10n.settingsStaffTitle,
      subtitle: l10n.settingsStaffCardSubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.groups_outlined,
        color: CoreColors.orderTypeDelivery,
      ),
      child: Column(
        children: [
          _SettingRow(
            label: l10n.screenStaffHoursReport,
            detail:
                l10n.settingsStaffHoursDetail,
            color: CoreColors.semanticTip,
            route: AppRoutePaths.operatorStaffHours,
            actionLabel: l10n.commonOpen,
          ),
          _SettingRow(
            label: l10n.settingsAttendanceHrLabel,
            detail: l10n.settingsAttendanceHrDetail,
            color: CoreColors.brandOlive,
            route: AppRoutePaths.operatorAttendance,
            actionLabel: l10n.commonOpen,
          ),
        ],
      ),
    );
  }
}

class _FeesTaxesCard extends StatelessWidget {
  const _FeesTaxesCard({
    required this.taxIncluded,
    required this.onTaxChanged,
    required this.l10n,
    required this.isAr,
  });

  final bool taxIncluded;
  final ValueChanged<bool> onTaxChanged;
  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: l10n.settingsFeesTaxesTitle,
      subtitle: l10n.settingsFeesTaxesCardSubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.receipt_long_outlined,
        color: CoreColors.semanticRevenue,
      ),
      child: Column(
        children: [
          _SwitchLine(
            label: l10n.checkoutTaxInclusive,
            value: taxIncluded,
            onChanged: onTaxChanged,
          ),
          _SettingRow(
            label: l10n.screenDepositConfig,
            detail: l10n.depositTrayConfiguration,
            color: CoreColors.semanticDeposit,
            route: AppRoutePaths.operatorDepositConfig,
            actionLabel: l10n.commonOpen,
          ),
          _SettingRow(
            label: l10n.settingsDeliveryFeesLabel,
            detail: l10n.settingsDeliveryFeesZoneMinimum,
            color: CoreColors.orderTypeDelivery,
          ),
          _SettingRow(
            label: l10n.settingsReceiptTemplateLabel,
            detail: l10n.settingsReceiptTemplateTerms,
            color: CoreColors.brandBrown,
          ),
        ],
      ),
    );
  }
}

class _ReceiptsNotificationsCard extends StatelessWidget {
  const _ReceiptsNotificationsCard({
    required this.kitchenAlerts,
    required this.onKitchenAlertsChanged,
    required this.isAr,
  });

  final bool kitchenAlerts;
  final ValueChanged<bool> onKitchenAlertsChanged;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WidgetsAppCard(
      title: l10n.settingsNotificationsTitle,
      subtitle: l10n.settingsNotificationsCardSubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.notifications_active_outlined,
        color: CoreColors.brandOrange,
      ),
      child: Column(
        children: [
          _SwitchLine(
            label: l10n.settingsLateKitchenTicketAlerts,
            value: kitchenAlerts,
            onChanged: onKitchenAlertsChanged,
          ),
          _SettingRow(
            label: l10n.settingsLowStockAlert,
            detail: l10n.settingsLowStockDetail,
            color: CoreColors.brandOlive,
          ),
          _SettingRow(
            label: l10n.settingsTrayReturnReminders,
            detail:
                l10n.settingsTrayReturnDetail,
            color: CoreColors.orderTypePlated,
          ),
        ],
      ),
    );
  }
}

class _SettingsShortcutsCard extends StatelessWidget {
  const _SettingsShortcutsCard({
    required this.l10n,
    required this.isAr,
    required this.scope,
  });

  final AppLocalizations l10n;
  final bool isAr;
  final AdminSettingsScope scope;

  @override
  Widget build(BuildContext context) {
    final isAppAdmin = scope == AdminSettingsScope.appAdmin;

    return WidgetsAppCard(
      title: isAppAdmin
          ? l10n.settingsAppAdminShortcuts
          : l10n.settingsOpsShortcuts,
      subtitle: l10n.settingsShortcutsJumpSubtitle,
      child: Wrap(
        spacing: CoreSpacing.sm(context),
        runSpacing: CoreSpacing.sm(context),
        children: isAppAdmin
            ? [
                _ShortcutChip(
                  label: l10n.rolePermissionsTitle,
                  icon: Icons.admin_panel_settings_outlined,
                  route: AppRoutePaths.appAdminRoles,
                ),
                _ShortcutChip(
                  label: l10n.userPermissionsTitle,
                  icon: Icons.groups_outlined,
                  route: AppRoutePaths.appAdminUsers,
                ),
                _ShortcutChip(
                  label: l10n.screenAppIntegrations,
                  icon: Icons.integration_instructions_outlined,
                  route: AppRoutePaths.appAdminIntegrations,
                ),
                _ShortcutChip(
                  label: l10n.screenOwnerViewConfig,
                  icon: Icons.privacy_tip_outlined,
                  route: AppRoutePaths.appAdminOwnerConfig,
                ),
                _ShortcutChip(
                  label: l10n.screenAuditLog,
                  icon: Icons.history_outlined,
                  route: AppRoutePaths.appAdminAudit,
                ),
              ]
            : [
                _ShortcutChip(
                  label: l10n.screenDepositConfig,
                  icon: Icons.payments_outlined,
                  route: AppRoutePaths.operatorDepositConfig,
                ),
                _ShortcutChip(
                  label: l10n.settingsAttendancePayrollShortcut,
                  icon: Icons.schedule_outlined,
                  route: AppRoutePaths.operatorAttendance,
                ),
                _ShortcutChip(
                  label: l10n.screenPlatesManagement,
                  icon: Icons.room_service_outlined,
                  route: AppRoutePaths.operatorPlates,
                ),
                _ShortcutChip(
                  label: l10n.settingsPreOrdersLabel,
                  icon: Icons.event_note_outlined,
                  route: AppRoutePaths.operatorPreOrders,
                ),
                _ShortcutChip(
                  label: l10n.screenReports,
                  icon: Icons.analytics_outlined,
                  route: AppRoutePaths.operatorReports,
                ),
              ],
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  const _SettingRow({
    required this.label,
    required this.detail,
    required this.color,
    this.route,
    this.actionLabel,
  });

  final String label;
  final String detail;
  final Color color;
  final String? route;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
        border: Border.all(color: color.withValues(alpha: 0.16)),
      ),
      child: Row(
        children: [
          WidgetsIconBubble(icon: Icons.tune_outlined, color: color, size: UtilitySizer.of(context, 36), iconSize: CoreContentSizes.orderTypeIcon(context)),
          SizedBox(width: CoreSpacing.sm(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: CoreTypography.titleMedium(
                    context,
                    Theme.of(context).colorScheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  detail,
                  style: CoreTypography.caption(
                    context,
                    Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (route != null)
            WidgetsAppButton(
              label: actionLabel ?? 'Open',
              onPressed: () => context.push(route!),
              variant: WidgetsAppButtonVariant.ghost,
            ),
        ],
      ),
    );
  }
}

class _SwitchLine extends StatelessWidget {
  const _SwitchLine({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        label,
        style: CoreTypography.titleMedium(
          context,
          Theme.of(context).colorScheme.onSurface,
        ).copyWith(fontWeight: FontWeight.w800),
      ),
      value: value,
      activeThumbColor: CoreColors.brandOlive,
      onChanged: onChanged,
    );
  }
}

class _ShortcutChip extends StatelessWidget {
  const _ShortcutChip({
    required this.label,
    required this.icon,
    required this.route,
  });

  final String label;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon, size: CoreContentSizes.orderTypeIcon(context), color: CoreColors.brandOlive),
      label: Text(label),
      onPressed: () => context.push(route),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.22),
        ),
      ),
    );
  }
}

class _HeroPill extends StatelessWidget {
  const _HeroPill({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: CoreSpacing.md(context),
        vertical: CoreSpacing.sm(context),
      ),
      decoration: BoxDecoration(
        color: CoreColors.surfaceLight.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
        border: Border.all(
          color: CoreColors.surfaceLight.withValues(alpha: 0.28),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: CoreColors.surfaceLight, size: CoreContentSizes.orderTypeIcon(context)),
          SizedBox(width: CoreSpacing.xs(context)),
          Text(
            label,
            style: CoreTypography.caption(
              context,
              CoreColors.surfaceLight,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class _AppBrandingCard extends ConsumerStatefulWidget {
  const _AppBrandingCard();

  @override
  ConsumerState<_AppBrandingCard> createState() => _AppBrandingCardState();
}

class _AppBrandingCardState extends ConsumerState<_AppBrandingCard> {
  late final TextEditingController _nameEn;
  late final TextEditingController _nameAr;
  late final TextEditingController _sloganEn;
  late final TextEditingController _sloganAr;
  late final TextEditingController _logoUrl;

  @override
  void initState() {
    super.initState();
    final b = ref.read(appBrandingProvider);
    _nameEn = TextEditingController(text: b.nameEn);
    _nameAr = TextEditingController(text: b.nameAr);
    _sloganEn = TextEditingController(text: b.sloganEn);
    _sloganAr = TextEditingController(text: b.sloganAr);
    _logoUrl = TextEditingController(text: b.logoUrl ?? '');
  }

  @override
  void dispose() {
    _nameEn.dispose();
    _nameAr.dispose();
    _sloganEn.dispose();
    _sloganAr.dispose();
    _logoUrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WidgetsAppCard(
      title: l10n.brandingSettingsTitle,
      subtitle: l10n.brandingSettingsSubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.branding_watermark_outlined,
        color: CoreColors.hubAdminAccent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WidgetsAppTextField(
            controller: _nameEn,
            label: l10n.brandingNameEn,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppTextField(
            controller: _nameAr,
            label: l10n.brandingNameAr,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppTextField(
            controller: _sloganEn,
            label: l10n.brandingSloganEn,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppTextField(
            controller: _sloganAr,
            label: l10n.brandingSloganAr,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppTextField(
            controller: _logoUrl,
            label: l10n.brandingLogoUrl,
            hintText: l10n.brandingLogoUrlHint,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Row(
            children: [
              Expanded(
                child: WidgetsAppButton(
                  label: l10n.brandingSave,
                  onPressed: () {
                    final url = _logoUrl.text.trim();
                    ref.read(appBrandingProvider.notifier).update(
                          AppBrandingConfig(
                            nameEn: _nameEn.text.trim().isEmpty
                                ? 'Ayletna Restaurant'
                                : _nameEn.text.trim(),
                            nameAr: _nameAr.text.trim().isEmpty
                                ? 'مطعم عيلتنا'
                                : _nameAr.text.trim(),
                            sloganEn: _sloganEn.text.trim().isEmpty
                                ? 'Premium Levantine Cuisine'
                                : _sloganEn.text.trim(),
                            sloganAr: _sloganAr.text.trim().isEmpty
                                ? 'مأكولات شامية فاخرة'
                                : _sloganAr.text.trim(),
                            logoUrl: url.isEmpty ? null : url,
                          ),
                        );
                    UtilityMockFeedback.showSuccess(
                      context,
                      l10n.brandingSaved,
                    );
                  },
                ),
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: WidgetsAppButton(
                  label: l10n.brandingReset,
                  variant: WidgetsAppButtonVariant.outline,
                  onPressed: () {
                    ref.read(appBrandingProvider.notifier).resetDefaults();
                    final b = ref.read(appBrandingProvider);
                    setState(() {
                      _nameEn.text = b.nameEn;
                      _nameAr.text = b.nameAr;
                      _sloganEn.text = b.sloganEn;
                      _sloganAr.text = b.sloganAr;
                      _logoUrl.text = b.logoUrl ?? '';
                    });
                    UtilityMockFeedback.showSuccess(
                      context,
                      l10n.brandingSaved,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
