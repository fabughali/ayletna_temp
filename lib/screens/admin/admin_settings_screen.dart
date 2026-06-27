import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/admin_session_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [SettingsScreen].
class AdminSettingsScreen extends ConsumerWidget {
  const AdminSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final settings = ref.watch(adminSettingsProvider);

    return WidgetsScaffoldPage(
      title: l10n.screenSettings,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.admin),
          icon: Icons.dashboard_outlined,
          tooltip: l10n.screenAdminDashboard,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          await Future<void>.delayed(const Duration(milliseconds: 300));
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 900;
            final operations = Column(
              children: [
                _BusinessHoursCard(
                  ordersOpen: settings.ordersOpen,
                  deliveryEnabled: settings.deliveryEnabled,
                  onOrdersChanged:
                      (value) =>
                          ref
                              .read(adminSettingsProvider.notifier)
                              .setOrdersOpen(value),
                  onDeliveryChanged:
                      (value) =>
                          ref
                              .read(adminSettingsProvider.notifier)
                              .setDeliveryEnabled(value),
                  isAr: isAr,
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                _StationsAndRulesCard(isAr: isAr),
                SizedBox(height: CoreSpacing.lg(context)),
                _RolesAndPrivacyCard(l10n: l10n, isAr: isAr),
              ],
            );
            final financeAndComms = Column(
              children: [
                _FeesTaxesCard(
                  taxIncluded: settings.taxIncluded,
                  onTaxChanged:
                      (value) =>
                          ref
                              .read(adminSettingsProvider.notifier)
                              .setTaxIncluded(value),
                  l10n: l10n,
                  isAr: isAr,
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                _ReceiptsNotificationsCard(
                  kitchenAlerts: settings.kitchenAlerts,
                  onKitchenAlertsChanged:
                      (value) =>
                          ref
                              .read(adminSettingsProvider.notifier)
                              .setKitchenAlerts(value),
                  isAr: isAr,
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                _SettingsShortcutsCard(l10n: l10n, isAr: isAr),
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
  const _SettingsHero({required this.l10n, required this.isAr});

  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
        gradient: const LinearGradient(
          colors: [CoreColors.brandOlive, CoreColors.brandBrown],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SoftBadge(
            label: isAr ? 'مركز إعدادات الإدارة' : 'Admin Settings Hub',
            color: CoreColors.surfaceLight,
            foreground: CoreColors.brandBrown,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            isAr
                ? 'تحكم بساعات العمل، الأدوار، المحطات، قواعد الطلبات، مناطق التوصيل، الضرائب، الإيصالات، والتنبيهات.'
                : 'Control hours, roles, stations, order rules, delivery zones, taxes, receipts, and alerts.',
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
                label: isAr ? '٩ أقسام' : '9 sections',
                icon: Icons.grid_view_outlined,
              ),
              _HeroPill(
                label: isAr ? 'واجهة فقط' : 'UI only',
                icon: Icons.layers_outlined,
              ),
              _HeroPill(
                label: isAr ? 'درج تنقل' : 'Drawer navigation',
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
    return WidgetsAppCard(
      title: isAr ? 'ساعات العمل وقواعد الطلب' : 'Business Hours & Order Rules',
      subtitle:
          isAr
              ? 'حدد حالة الاستقبال والتحضير والطلبات المسبقة.'
              : 'Set service state, prep rules, and pre-order behavior.',
      leading: const _IconBubble(
        icon: Icons.schedule_outlined,
        color: CoreColors.brandOlive,
      ),
      child: Column(
        children: [
          _SwitchLine(
            label: isAr ? 'استقبال الطلبات مفتوح' : 'Accepting orders now',
            value: ordersOpen,
            onChanged: onOrdersChanged,
          ),
          _SwitchLine(
            label: isAr ? 'التوصيل متاح الآن' : 'Delivery enabled now',
            value: deliveryEnabled,
            onChanged: onDeliveryChanged,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          _SettingRow(
            label: isAr ? 'ساعات اليوم' : 'Today hours',
            detail: isAr ? '٨:٠٠ صباحاً - ١٢:٠٠ ليلاً' : '8:00 AM - 12:00 AM',
            color: CoreColors.brandOlive,
          ),
          _SettingRow(
            label: isAr ? 'الطلبات المسبقة' : 'Pre-orders',
            detail: isAr ? 'حتى ٣ أيام مقدماً' : 'Up to 3 days ahead',
            color: CoreColors.orderTypePlated,
            route: AppRoutePaths.adminPreOrder,
            actionLabel: isAr ? 'فتح' : 'Open',
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
    return WidgetsAppCard(
      title: isAr ? 'المحطات وقواعد التشغيل' : 'Stations & Operating Rules',
      subtitle:
          isAr
              ? 'اربط المنيو بمحطات المطبخ والتحضير.'
              : 'Route menu items to kitchen stations and prep rules.',
      leading: const _IconBubble(
        icon: Icons.soup_kitchen_outlined,
        color: CoreColors.brandOrange,
      ),
      child: Column(
        children: [
          _SettingRow(
            label: isAr ? 'محطة الشاورما' : 'Shawarma station',
            detail: isAr ? 'متوسط التحضير ٨ دقائق' : '8 min average prep',
            color: CoreColors.brandOrange,
          ),
          _SettingRow(
            label: isAr ? 'محطة المقالي' : 'Fryer station',
            detail: isAr ? 'حد ضغط ١٢ تذكرة' : 'Load limit 12 tickets',
            color: CoreColors.semanticError,
          ),
          _SettingRow(
            label: isAr ? 'حد قبول الطلب المتأخر' : 'Late-ticket threshold',
            detail: isAr ? '١٥ دقيقة قبل التصعيد' : 'Escalate after 15 minutes',
            color: CoreColors.brandBrown,
          ),
        ],
      ),
    );
  }
}

class _RolesAndPrivacyCard extends StatelessWidget {
  const _RolesAndPrivacyCard({required this.l10n, required this.isAr});

  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: isAr ? 'الأدوار والخصوصية' : 'Roles & Privacy',
      subtitle:
          isAr
              ? 'صلاحيات المالك والمشغل والطاقم.'
              : 'Owner, operator, and staff access controls.',
      leading: const _IconBubble(
        icon: Icons.admin_panel_settings_outlined,
        color: CoreColors.orderTypeDelivery,
      ),
      child: Column(
        children: [
          _SettingRow(
            label: isAr ? 'تكاملات التطبيق' : 'App integrations',
            detail:
                isAr
                    ? 'Supabase، SMS، WhatsApp، الدفع، AI'
                    : 'Supabase, SMS, WhatsApp, payments, AI',
            color: CoreColors.orderTypePlated,
            route: AppRoutePaths.adminAppIntegrations,
            actionLabel: isAr ? 'فتح' : 'Open',
          ),
          _SettingRow(
            label: isAr ? 'صلاحيات المستخدمين' : 'User roles',
            detail:
                isAr
                    ? 'مالك، مشغل، كاشير، مطبخ، توصيل'
                    : 'Owner, operator, cashier, kitchen, delivery',
            color: CoreColors.orderTypeDelivery,
            route: AppRoutePaths.adminUsers,
            actionLabel: isAr ? 'فتح' : 'Open',
          ),
          _SettingRow(
            label: l10n.screenOwnerViewConfig,
            detail: l10n.settingsOwnerPrivacy,
            color: CoreColors.semanticDeposit,
            route: AppRoutePaths.adminOwnerConfig,
            actionLabel: isAr ? 'فتح' : 'Open',
          ),
          _SettingRow(
            label: l10n.screenStaffHoursReport,
            detail:
                isAr ? 'ورديات وحضور وساعات' : 'Shifts, attendance, and hours',
            color: CoreColors.semanticTip,
            route: AppRoutePaths.adminStaffHours,
            actionLabel: isAr ? 'فتح' : 'Open',
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
      title: isAr ? 'الرسوم والضرائب' : 'Fees & Taxes',
      subtitle:
          isAr
              ? 'ضريبة المبيعات، التوصيل، العربون، والإيصالات.'
              : 'Sales tax, delivery fees, deposits, and receipts.',
      leading: const _IconBubble(
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
            route: AppRoutePaths.adminDepositConfig,
            actionLabel: isAr ? 'فتح' : 'Open',
          ),
          _SettingRow(
            label: isAr ? 'رسوم التوصيل' : 'Delivery fees',
            detail:
                isAr
                    ? 'حسب المنطقة والحد الأدنى'
                    : 'Zone-based fee and minimum order',
            color: CoreColors.orderTypeDelivery,
          ),
          _SettingRow(
            label: isAr ? 'نموذج الإيصال' : 'Receipt template',
            detail:
                isAr
                    ? 'الشعار، الضريبة، شروط الإرجاع'
                    : 'Logo, tax, and return terms',
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
    return WidgetsAppCard(
      title: isAr ? 'الإشعارات والتنبيهات' : 'Notifications & Alerts',
      subtitle:
          isAr
              ? 'تنبيهات المطبخ، السائقين، المخزون، والإرجاع.'
              : 'Kitchen, driver, inventory, and return alerts.',
      leading: const _IconBubble(
        icon: Icons.notifications_active_outlined,
        color: CoreColors.brandOrange,
      ),
      child: Column(
        children: [
          _SwitchLine(
            label:
                isAr
                    ? 'تنبيه تذاكر المطبخ المتأخرة'
                    : 'Late kitchen ticket alerts',
            value: kitchenAlerts,
            onChanged: onKitchenAlertsChanged,
          ),
          _SettingRow(
            label: isAr ? 'إشعار نقص المخزون' : 'Low stock alert',
            detail: isAr ? 'عند أقل من ١٥٪' : 'Below 15% threshold',
            color: CoreColors.brandOlive,
          ),
          _SettingRow(
            label: isAr ? 'تذكير إرجاع الصواني' : 'Tray return reminders',
            detail:
                isAr ? 'بعد ٦٠ دقيقة من التسليم' : '60 minutes after delivery',
            color: CoreColors.orderTypePlated,
          ),
        ],
      ),
    );
  }
}

class _SettingsShortcutsCard extends StatelessWidget {
  const _SettingsShortcutsCard({required this.l10n, required this.isAr});

  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: isAr ? 'اختصارات الإدارة' : 'Admin Shortcuts',
      subtitle:
          isAr
              ? 'انتقل للإعدادات المتخصصة بدون شريط سفلي.'
              : 'Jump to specialized settings without bottom navigation.',
      child: Wrap(
        spacing: CoreSpacing.sm(context),
        runSpacing: CoreSpacing.sm(context),
        children: [
          _ShortcutChip(
            label: isAr ? 'فهرس المنيو' : 'Menu catalog',
            icon: Icons.category_outlined,
            route: AppRoutePaths.adminMenuCatalog,
          ),
          _ShortcutChip(
            label: l10n.screenOffersManagement,
            icon: Icons.local_offer_outlined,
            route: AppRoutePaths.adminOffersMgmt,
          ),
          _ShortcutChip(
            label: l10n.screenAppIntegrations,
            icon: Icons.integration_instructions_outlined,
            route: AppRoutePaths.adminAppIntegrations,
          ),
          _ShortcutChip(
            label: l10n.screenLoyaltyConfig,
            icon: Icons.workspace_premium_outlined,
            route: AppRoutePaths.adminLoyaltyConfig,
          ),
          _ShortcutChip(
            label: l10n.screenDepositConfig,
            icon: Icons.payments_outlined,
            route: AppRoutePaths.adminDepositConfig,
          ),
          _ShortcutChip(
            label: l10n.screenOwnerViewConfig,
            icon: Icons.privacy_tip_outlined,
            route: AppRoutePaths.adminOwnerConfig,
          ),
          _ShortcutChip(
            label: isAr ? 'تذاكر الدعم' : 'Support tickets',
            icon: Icons.support_agent_outlined,
            route: AppRoutePaths.adminSupportTickets,
          ),
          _ShortcutChip(
            label: isAr ? 'الحضور والرواتب' : 'Attendance & payroll',
            icon: Icons.schedule_outlined,
            route: AppRoutePaths.adminAttendanceHr,
          ),
          _ShortcutChip(
            label: isAr ? 'إعداد المكافآت' : 'Rewards setup',
            icon: Icons.card_giftcard_outlined,
            route: AppRoutePaths.adminRewardsMgmt,
          ),
          _ShortcutChip(
            label: isAr ? 'مراجعة التقييمات' : 'Review moderation',
            icon: Icons.rate_review_outlined,
            route: AppRoutePaths.adminReviewsModeration,
          ),
          _ShortcutChip(
            label: l10n.screenReports,
            icon: Icons.analytics_outlined,
            route: AppRoutePaths.adminReports,
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
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
        border: Border.all(color: color.withValues(alpha: 0.16)),
      ),
      child: Row(
        children: [
          _IconBubble(icon: Icons.tune_outlined, color: color, compact: true),
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
      activeColor: CoreColors.brandOlive,
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
      avatar: Icon(icon, size: 18, color: CoreColors.brandOlive),
      label: Text(label),
      onPressed: () => context.push(route),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
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
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
        border: Border.all(
          color: CoreColors.surfaceLight.withValues(alpha: 0.28),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: CoreColors.surfaceLight, size: 18),
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

class _IconBubble extends StatelessWidget {
  const _IconBubble({
    required this.icon,
    required this.color,
    this.compact = false,
  });

  final IconData icon;
  final Color color;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final size = compact ? 36.0 : 42.0;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
      ),
      child: Icon(icon, color: color, size: compact ? 18 : 22),
    );
  }
}

class _SoftBadge extends StatelessWidget {
  const _SoftBadge({required this.label, required this.color, this.foreground});

  final String label;
  final Color color;
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: CoreSpacing.sm(context),
        vertical: CoreSpacing.xs(context),
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: foreground == null ? 0.12 : 1),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
      ),
      child: Text(
        label,
        style: CoreTypography.caption(
          context,
          foreground ?? color,
        ).copyWith(fontWeight: FontWeight.w900),
      ),
    );
  }
}
