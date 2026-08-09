import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/rewards_admin_providers.dart';
import 'package:ayletna_restaurant_app/providers/user_profile_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_role_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Role-aware drawer/list navigation for the redesigned app.
class WidgetsAppDrawer extends ConsumerWidget {
  const WidgetsAppDrawer({
    required this.role,
    required this.currentPath,
    super.key,
  });

  final AppRole role;
  final String currentPath;

  /// True when [path] is a primary drawer destination for [role] (menu icon).
  /// Nested routes listed only as `activeRoutes` are treated as sub-screens (back).
  static bool isPrimaryDestination({
    required AppRole role,
    required String path,
    required AppLocalizations l10n,
    required bool isAr,
  }) {
    for (final destination in _destinationsFor(l10n, role, isAr: isAr)) {
      if (!destination.isHeader && destination.route == path) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final brightness = Theme.of(context).brightness;
    final hubTint = CoreColorScheme.hubAccentFor(role, brightness);
    final destinations = _destinationsFor(l10n, role, isAr: isAr);
    final activeLabel = _activeLabel(l10n, role, currentPath, destinations);

    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: EdgeInsets.all(CoreSpacing.lg(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: hubTint.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(
                        CoreSpacing.radiusCardOf(context),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(CoreSpacing.md(context)),
                      child: Icon(
                        Icons.restaurant_menu_outlined,
                        color: hubTint,
                        size: CoreContentSizes.orderTypeIcon(context),
                      ),
                    ),
                  ),
                  SizedBox(height: CoreSpacing.md(context)),
                  Text(
                    l10n.appTitle,
                    style: CoreTypography.headlineSmall(
                      context,
                      scheme.onSurface,
                    ).copyWith(fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: CoreSpacing.xs(context)),
                  if (role != AppRole.guest) ...[
                    _DrawerUserIdentity(role: role, isAr: isAr),
                    SizedBox(height: CoreSpacing.sm(context)),
                  ],
                  Text(
                    activeLabel,
                    style: CoreTypography.caption(
                      context,
                      scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: scheme.outline.withValues(alpha: 0.45)),
            for (final destination in destinations)
              if (destination.isHeader)
                _DrawerSectionHeader(label: destination.label)
              else
                _DrawerDestinationTile(
                  destination: destination,
                  selected: destination.matches(currentPath),
                ),
          ],
        ),
      ),
    );
  }

  static String _activeLabel(
    AppLocalizations l10n,
    AppRole role,
    String currentPath,
    List<_DrawerDestination> destinations,
  ) {
    for (final destination in destinations) {
      if (!destination.isHeader && destination.matches(currentPath)) {
        return destination.label;
      }
    }

    return switch (role) {
      AppRole.customer => l10n.screenHome,
      AppRole.guest => l10n.screenHome,
      AppRole.admin => l10n.hubAppAdmin,
      AppRole.operator => l10n.hubOperator,
      AppRole.owner => l10n.hubOwner,
      AppRole.support => l10n.hubSupportDesk,
      AppRole.marketing => l10n.hubMarketing,
      AppRole.cashier => l10n.screenCashierOrder,
      AppRole.kitchen => l10n.screenKitchenDashboard,
      AppRole.delivery => l10n.screenDeliveryDashboard,
      AppRole.inventory => l10n.screenInventoryDashboard,
      AppRole.staff => l10n.screenStaffAttendance,
    };
  }

  static List<_DrawerDestination> _destinationsFor(
    AppLocalizations l10n,
    AppRole role, {
    required bool isAr,
  }) {
    return switch (role) {
      AppRole.customer => [
        _DrawerDestination(
          route: AppRoutePaths.home,
          icon: Icons.home_outlined,
          label: l10n.screenHome,
          activeRoutes: const [AppRoutePaths.home, AppRoutePaths.search],
        ),
        _DrawerDestination(
          route: AppRoutePaths.category,
          icon: Icons.restaurant_menu_outlined,
          label: l10n.screenMenu,
          activeRoutes: const [
            AppRoutePaths.category,
            AppRoutePaths.productDetail,
            AppRoutePaths.orderType,
            AppRoutePaths.dineIn,
            AppRoutePaths.takeaway,
            AppRoutePaths.deliveryAddress,
            AppRoutePaths.platedInfo,
            AppRoutePaths.combo,
            AppRoutePaths.combos,
            AppRoutePaths.offers,
            AppRoutePaths.discounts,
          ],
        ),
        _DrawerDestination(
          route: AppRoutePaths.favorites,
          icon: Icons.favorite_border,
          label: l10n.screenFavorites,
        ),
        _DrawerDestination(
          route: AppRoutePaths.blog,
          icon: Icons.article_outlined,
          label: l10n.drawerBlog,
          activeRoutes: const [AppRoutePaths.blog],
        ),
        _DrawerDestination(
          route: AppRoutePaths.cart,
          icon: Icons.shopping_cart_outlined,
          label: l10n.screenCart,
          activeRoutes: const [
            AppRoutePaths.cart,
            AppRoutePaths.checkout,
            AppRoutePaths.payment,
            AppRoutePaths.tip,
            AppRoutePaths.orderConfirmation,
          ],
        ),
        _DrawerDestination(
          route: AppRoutePaths.orderHistory,
          icon: Icons.receipt_long_outlined,
          label: l10n.drawerOrders,
          activeRoutes: const [
            AppRoutePaths.orderHistory,
            AppRoutePaths.orderTracking,
            AppRoutePaths.ratingReview,
          ],
        ),
        _DrawerDestination(
          route: AppRoutePaths.notifications,
          icon: Icons.notifications_outlined,
          label: l10n.screenNotifications,
        ),
        _DrawerDestination(
          route: AppRoutePaths.support,
          icon: Icons.support_agent_outlined,
          label: l10n.screenSupport,
          activeRoutes: const [
            AppRoutePaths.support,
            AppRoutePaths.supportChat,
            AppRoutePaths.faq,
          ],
        ),
        _DrawerDestination(
          route: AppRoutePaths.profile,
          icon: Icons.settings_outlined,
          label: l10n.screenSettings,
          activeRoutes: const [
            AppRoutePaths.profile,
            AppRoutePaths.accountSettings,
            AppRoutePaths.editProfile,
            AppRoutePaths.addresses,
            AppRoutePaths.mapPicker,
            AppRoutePaths.wallet,
            AppRoutePaths.platedReturnReminder,
            AppRoutePaths.paymentHistory,
            AppRoutePaths.rewardsHistory,
            AppRoutePaths.loyalty,
            AppRoutePaths.rewards,
            AppRoutePaths.redemption,
          ],
        ),
      ],
      AppRole.guest => [
        _DrawerDestination(
          route: AppRoutePaths.home,
          icon: Icons.home_outlined,
          label: l10n.screenHome,
          activeRoutes: const [AppRoutePaths.home, AppRoutePaths.search],
        ),
        _DrawerDestination(
          route: AppRoutePaths.category,
          icon: Icons.restaurant_menu_outlined,
          label: l10n.guestMenuNav,
          activeRoutes: const [
            AppRoutePaths.category,
            AppRoutePaths.productDetail,
          ],
        ),
        _DrawerDestination(
          route: AppRoutePaths.favorites,
          icon: Icons.favorite_border,
          label: l10n.screenFavorites,
        ),
        _DrawerDestination(
          route: AppRoutePaths.cart,
          icon: Icons.shopping_cart_outlined,
          label: l10n.screenCart,
          activeRoutes: const [
            AppRoutePaths.cart,
            AppRoutePaths.checkout,
            AppRoutePaths.payment,
            AppRoutePaths.tip,
          ],
        ),
        _DrawerDestination(
          route: AppRoutePaths.rewards,
          icon: Icons.card_giftcard_outlined,
          label: l10n.screenRewardsCatalog,
          activeRoutes: const [
            AppRoutePaths.loyalty,
            AppRoutePaths.rewards,
            AppRoutePaths.offers,
            AppRoutePaths.discounts,
            AppRoutePaths.combo,
          ],
        ),
        _DrawerDestination(
          route: AppRoutePaths.notifications,
          icon: Icons.notifications_outlined,
          label: l10n.screenNotifications,
        ),
        _DrawerDestination(
          route: AppRoutePaths.support,
          icon: Icons.support_agent_outlined,
          label: l10n.screenSupport,
          activeRoutes: const [
            AppRoutePaths.support,
            AppRoutePaths.supportChat,
            AppRoutePaths.faq,
            AppRoutePaths.blog,
          ],
        ),
        _DrawerDestination(
          route: AppRoutePaths.login,
          icon: Icons.login_outlined,
          label: l10n.actionSignIn,
        ),
      ],
      AppRole.admin => [
        _DrawerDestination(
          route: AppRoutePaths.appAdmin,
          icon: Icons.dashboard_customize_outlined,
          label: l10n.hubAppAdmin,
        ),
        _DrawerDestination(
          route: AppRoutePaths.appAdminRoles,
          icon: Icons.admin_panel_settings_outlined,
          label: l10n.rolePermissionsTitle,
        ),
        _DrawerDestination(
          route: AppRoutePaths.appAdminUsers,
          icon: Icons.groups_outlined,
          label: l10n.userPermissionsTitle,
        ),
        _DrawerDestination(
          route: AppRoutePaths.appAdminAudit,
          icon: Icons.history_outlined,
          label: l10n.screenAuditLog,
        ),
        _DrawerDestination(
          route: AppRoutePaths.appAdminIntegrations,
          icon: Icons.extension_outlined,
          label: l10n.screenAppIntegrations,
        ),
        _DrawerDestination(
          route: AppRoutePaths.appAdminOwnerConfig,
          icon: Icons.visibility_outlined,
          label: l10n.screenOwnerViewConfig,
        ),
        _DrawerDestination(
          route: AppRoutePaths.appAdminSettings,
          icon: Icons.tune_outlined,
          label: l10n.drawerBusinessSettings,
        ),
        _DrawerDestination(
          route: AppRoutePaths.accountSettings,
          icon: Icons.person_outline,
          label: l10n.screenSettings,
          activeRoutes: const [
            AppRoutePaths.accountSettings,
            AppRoutePaths.editProfile,
          ],
        ),
      ],
      AppRole.operator => [
        _DrawerDestination.header(l10n.drawerGroupHub),
        _DrawerDestination(
          route: AppRoutePaths.operatorHub,
          icon: Icons.dashboard_customize_outlined,
          label: l10n.hubOperator,
        ),
        _DrawerDestination.header(l10n.drawerGroupOrders),
        _DrawerDestination(
          route: AppRoutePaths.operatorOrders,
          icon: Icons.receipt_long_outlined,
          label: l10n.screenOrdersManagement,
        ),
        _DrawerDestination(
          route: AppRoutePaths.operatorPreOrders,
          icon: Icons.event_available_outlined,
          label: l10n.screenPreOrder,
        ),
        _DrawerDestination.header(l10n.drawerGroupMenu),
        _DrawerDestination(
          route: AppRoutePaths.operatorMenu,
          icon: Icons.restaurant_outlined,
          label: l10n.screenMenuManagement,
          activeRoutes: const [
            AppRoutePaths.operatorMenu,
            AppRoutePaths.operatorProductEditor,
          ],
        ),
        _DrawerDestination(
          route: AppRoutePaths.operatorPlates,
          icon: Icons.dinner_dining_outlined,
          label: l10n.screenPlatesManagement,
          activeRoutes: const [
            AppRoutePaths.operatorPlates,
            AppRoutePaths.operatorPlateEditor,
          ],
        ),
        _DrawerDestination.header(l10n.drawerGroupPeople),
        _DrawerDestination(
          route: AppRoutePaths.operatorAttendance,
          icon: Icons.badge_outlined,
          label: l10n.screenStaffAttendance,
        ),
        _DrawerDestination(
          route: AppRoutePaths.operatorStaffHours,
          icon: Icons.schedule_outlined,
          label: l10n.screenStaffHoursReport,
        ),
        _DrawerDestination.header(l10n.drawerGroupMoney),
        _DrawerDestination(
          route: AppRoutePaths.operatorTipDistribution,
          icon: Icons.volunteer_activism_outlined,
          label: l10n.screenDailyTipDistribution,
        ),
        _DrawerDestination(
          route: AppRoutePaths.operatorDepositConfig,
          icon: Icons.account_balance_wallet_outlined,
          label: l10n.screenDepositConfig,
        ),
        _DrawerDestination(
          route: AppRoutePaths.operatorReports,
          icon: Icons.insights_outlined,
          label: l10n.screenReports,
        ),
        _DrawerDestination(
          route: AppRoutePaths.operatorReportFilter,
          icon: Icons.filter_alt_outlined,
          label: l10n.screenReportFilter,
        ),
        _DrawerDestination(
          route: AppRoutePaths.operatorFinancial,
          icon: Icons.point_of_sale_outlined,
          label: l10n.screenFinancialCalculation,
        ),
        _DrawerDestination.header(l10n.drawerGroupSettings),
        _DrawerDestination(
          route: AppRoutePaths.operatorSettings,
          icon: Icons.tune_outlined,
          label: l10n.drawerBusinessSettings,
        ),
        _DrawerDestination(
          route: AppRoutePaths.accountSettings,
          icon: Icons.person_outline,
          label: l10n.screenSettings,
          activeRoutes: const [
            AppRoutePaths.accountSettings,
            AppRoutePaths.editProfile,
          ],
        ),
      ],
      AppRole.owner => [
        _DrawerDestination(
          route: AppRoutePaths.ownerHub,
          icon: Icons.dashboard_customize_outlined,
          label: l10n.hubOwner,
        ),
        _DrawerDestination(
          route: AppRoutePaths.ownerReports,
          icon: Icons.insights_outlined,
          label: l10n.screenReports,
        ),
        _DrawerDestination(
          route: AppRoutePaths.ownerFinancial,
          icon: Icons.account_balance_outlined,
          label: l10n.screenFinancialCalculation,
        ),
        _DrawerDestination(
          route: AppRoutePaths.ownerAudit,
          icon: Icons.history_outlined,
          label: l10n.screenAuditLog,
        ),
        _DrawerDestination(
          route: AppRoutePaths.accountSettings,
          icon: Icons.person_outline,
          label: l10n.screenSettings,
          activeRoutes: const [
            AppRoutePaths.accountSettings,
            AppRoutePaths.editProfile,
          ],
        ),
      ],
      AppRole.support => [
        _DrawerDestination(
          route: AppRoutePaths.supportDesk,
          icon: Icons.support_agent_outlined,
          label: l10n.hubSupportDesk,
        ),
        _DrawerDestination(
          route: AppRoutePaths.supportDeskTickets,
          icon: Icons.confirmation_number_outlined,
          label: l10n.supportTicketsTitle,
        ),
        _DrawerDestination(
          route: AppRoutePaths.supportDeskChat,
          icon: Icons.chat_outlined,
          label: l10n.supportChatQueueTitle,
        ),
        _DrawerDestination(
          route: AppRoutePaths.supportDeskOrderLookup,
          icon: Icons.search_outlined,
          label: l10n.supportOrderLookupTitle,
        ),
        _DrawerDestination(
          route: AppRoutePaths.supportDeskReviews,
          icon: Icons.rate_review_outlined,
          label: l10n.adminReviewAction,
        ),
        _DrawerDestination(
          route: AppRoutePaths.supportDeskFaq,
          icon: Icons.help_outline,
          label: l10n.screenFaq,
        ),
        _DrawerDestination(
          route: AppRoutePaths.accountSettings,
          icon: Icons.person_outline,
          label: l10n.screenSettings,
          activeRoutes: const [
            AppRoutePaths.accountSettings,
            AppRoutePaths.editProfile,
          ],
        ),
      ],
      AppRole.marketing => [
        _DrawerDestination.header(l10n.drawerGroupHub),
        _DrawerDestination(
          route: AppRoutePaths.marketingHub,
          icon: Icons.home_outlined,
          label: l10n.screenHome,
        ),
        _DrawerDestination.header(l10n.drawerGroupPromotions),
        _DrawerDestination(
          route: AppRoutePaths.marketingOffers,
          icon: Icons.local_offer_outlined,
          label: l10n.marketingTabOffers,
        ),
        _DrawerDestination(
          route: AppRoutePaths.marketingDiscounts,
          icon: Icons.discount_outlined,
          label: l10n.marketingTabDiscounts,
        ),
        _DrawerDestination(
          route: AppRoutePaths.marketingCombos,
          icon: Icons.lunch_dining_outlined,
          label: l10n.marketingTabCombos,
        ),
        _DrawerDestination(
          route: AppRoutePaths.marketingSubscriptions,
          icon: Icons.event_repeat_outlined,
          label: l10n.marketingTabSubscriptions,
        ),
        _DrawerDestination(
          route: AppRoutePaths.marketingCalendar,
          icon: Icons.calendar_month_outlined,
          label: l10n.marketingTabCampaign,
        ),
        _DrawerDestination.header(l10n.drawerGroupCatalog),
        _DrawerDestination(
          route: AppRoutePaths.marketingCategories,
          icon: Icons.category_outlined,
          label: l10n.menuCatalogTabCategories,
        ),
        _DrawerDestination(
          route: AppRoutePaths.marketingProducts,
          icon: Icons.restaurant_menu_outlined,
          label: l10n.menuCatalogTabProducts,
        ),
        _DrawerDestination(
          route: AppRoutePaths.marketingAddons,
          icon: Icons.extension_outlined,
          label: l10n.screenAddonsManagement,
        ),
        _DrawerDestination.header(l10n.drawerGroupLoyalty),
        _DrawerDestination(
          route: AppRoutePaths.marketingRewards,
          icon: Icons.card_giftcard_outlined,
          label: l10n.screenRewardsCatalog,
        ),
        _DrawerDestination(
          route: AppRoutePaths.marketingLoyalty,
          icon: Icons.cake_outlined,
          label: l10n.marketingTabLoyalty,
        ),
        _DrawerDestination.header(l10n.drawerGroupContent),
        _DrawerDestination(
          route: AppRoutePaths.marketingPushCampaigns,
          icon: Icons.notifications_active_outlined,
          label: l10n.marketingPushCampaignsTitle,
        ),
        _DrawerDestination(
          route: AppRoutePaths.marketingSocial,
          icon: Icons.share_outlined,
          label: l10n.marketingTabSocial,
        ),
        _DrawerDestination(
          route: AppRoutePaths.marketingBlog,
          icon: Icons.article_outlined,
          label: l10n.marketingTabBlog,
        ),
        _DrawerDestination.header(l10n.drawerGroupSettings),
        _DrawerDestination(
          route: AppRoutePaths.accountSettings,
          icon: Icons.person_outline,
          label: l10n.screenSettings,
          activeRoutes: const [
            AppRoutePaths.accountSettings,
            AppRoutePaths.editProfile,
          ],
        ),
      ],
      AppRole.cashier => [
        _DrawerDestination(
          route: AppRoutePaths.cashier,
          icon: Icons.point_of_sale_outlined,
          label: l10n.screenCashierOrder,
        ),
        _DrawerDestination(
          route: AppRoutePaths.staffAttendance,
          icon: Icons.schedule_outlined,
          label: l10n.screenStaffAttendance,
        ),
        _DrawerDestination(
          route: AppRoutePaths.cashierOrderHistory,
          icon: Icons.receipt_long_outlined,
          label: l10n.screenCashierOrderHistory,
        ),
        _DrawerDestination(
          route: AppRoutePaths.cashierTip,
          icon: Icons.volunteer_activism_outlined,
          label: l10n.screenCashierTipEntry,
        ),
        _DrawerDestination(
          route: AppRoutePaths.cashierDepositRefund,
          icon: Icons.assignment_return_outlined,
          label: l10n.screenCashierDepositRefund,
        ),
        _DrawerDestination(
          route: AppRoutePaths.accountSettings,
          icon: Icons.person_outline,
          label: l10n.screenSettings,
          activeRoutes: const [
            AppRoutePaths.accountSettings,
            AppRoutePaths.editProfile,
          ],
        ),
      ],
      AppRole.kitchen => [
        _DrawerDestination(
          route: AppRoutePaths.kitchen,
          icon: Icons.soup_kitchen_outlined,
          label: l10n.screenKitchenDashboard,
        ),
        _DrawerDestination(
          route: AppRoutePaths.staffAttendance,
          icon: Icons.schedule_outlined,
          label: l10n.screenStaffAttendance,
        ),
        _DrawerDestination(
          route: AppRoutePaths.kitchenPrep,
          icon: Icons.checklist_rtl_outlined,
          label: l10n.screenOrderPrep,
        ),
        _DrawerDestination(
          route: AppRoutePaths.accountSettings,
          icon: Icons.person_outline,
          label: l10n.screenSettings,
          activeRoutes: const [
            AppRoutePaths.accountSettings,
            AppRoutePaths.editProfile,
          ],
        ),
      ],
      AppRole.delivery => [
        _DrawerDestination(
          route: AppRoutePaths.delivery,
          icon: Icons.route_outlined,
          label: l10n.screenDeliveryDashboard,
        ),
        _DrawerDestination(
          route: AppRoutePaths.staffAttendance,
          icon: Icons.schedule_outlined,
          label: l10n.screenStaffAttendance,
        ),
        _DrawerDestination(
          route: AppRoutePaths.deliveryOrder,
          icon: Icons.delivery_dining_outlined,
          label: l10n.screenDeliveryOrder,
        ),
        _DrawerDestination(
          route: AppRoutePaths.platedReturnTask,
          icon: Icons.assignment_return_outlined,
          label: l10n.screenPlatedReturnTask,
        ),
        _DrawerDestination(
          route: AppRoutePaths.accountSettings,
          icon: Icons.person_outline,
          label: l10n.screenSettings,
          activeRoutes: const [
            AppRoutePaths.accountSettings,
            AppRoutePaths.editProfile,
          ],
        ),
      ],
      AppRole.inventory => [
        _DrawerDestination(
          route: AppRoutePaths.inventory,
          icon: Icons.inventory_2_outlined,
          label: l10n.screenInventoryDashboard,
          activeRoutes: const [
            AppRoutePaths.inventory,
            AppRoutePaths.inventoryItem,
          ],
        ),
        _DrawerDestination(
          route: AppRoutePaths.staffAttendance,
          icon: Icons.schedule_outlined,
          label: l10n.screenStaffAttendance,
        ),
        _DrawerDestination(
          route: AppRoutePaths.stockAdjustment,
          icon: Icons.edit_note_outlined,
          label: l10n.screenStockAdjustment,
        ),
        _DrawerDestination(
          route: AppRoutePaths.accountSettings,
          icon: Icons.person_outline,
          label: l10n.screenSettings,
          activeRoutes: const [
            AppRoutePaths.accountSettings,
            AppRoutePaths.editProfile,
          ],
        ),
      ],
      AppRole.staff => [
        _DrawerDestination(
          route: AppRoutePaths.staffAttendance,
          icon: Icons.schedule_outlined,
          label: l10n.screenStaffAttendance,
        ),
        _DrawerDestination(
          route: AppRoutePaths.staffTips,
          icon: Icons.volunteer_activism_outlined,
          label: l10n.screenStaffDailyTips,
        ),
        _DrawerDestination(
          route: AppRoutePaths.staffTipHistory,
          icon: Icons.history_outlined,
          label: l10n.screenStaffTipHistory,
        ),
        _DrawerDestination(
          route: AppRoutePaths.accountSettings,
          icon: Icons.person_outline,
          label: l10n.screenSettings,
          activeRoutes: const [
            AppRoutePaths.accountSettings,
            AppRoutePaths.editProfile,
          ],
        ),
      ],
    };
  }
}

class _DrawerDestination {
  const _DrawerDestination({
    required this.route,
    required this.icon,
    required this.label,
    this.activeRoutes = const [],
  }) : isHeader = false;

  const _DrawerDestination.header(this.label)
    : route = '',
      icon = Icons.label_outline,
      activeRoutes = const [],
      isHeader = true;

  final String route;
  final IconData icon;
  final String label;
  final List<String> activeRoutes;
  final bool isHeader;

  bool matches(String path) {
    if (isHeader) return false;
    return path == route || activeRoutes.contains(path);
  }
}

class _DrawerSectionHeader extends StatelessWidget {
  const _DrawerSectionHeader({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        CoreSpacing.lg(context),
        CoreSpacing.md(context),
        CoreSpacing.lg(context),
        CoreSpacing.xs(context),
      ),
      child: Text(
        label.toUpperCase(),
        style: CoreTypography.caption(
          context,
          scheme.onSurfaceVariant,
        ).copyWith(fontWeight: FontWeight.w800, letterSpacing: 0.6),
      ),
    );
  }
}

class _DrawerUserIdentity extends ConsumerWidget {
  const _DrawerUserIdentity({required this.role, required this.isAr});

  final AppRole role;
  final bool isAr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final profile = ref.watch(userProfileProvider);
    final name = profile.displayName(isAr);
    final points = ref.watch(loyaltyPointsProvider).balance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: CoreTypography.titleMedium(
            context,
            scheme.primary,
          ).copyWith(fontWeight: FontWeight.w900),
        ),
        SizedBox(height: CoreSpacing.xs(context)),
        Text(
          roleLabel(l10n, role),
          style: CoreTypography.caption(
            context,
            scheme.onSurfaceVariant,
          ).copyWith(fontWeight: FontWeight.w700),
        ),
        if (role == AppRole.customer) ...[
          SizedBox(height: CoreSpacing.sm(context)),
          Row(
            children: [
              Icon(
                Icons.stars_rounded,
                size: CoreContentSizes.chipIcon(context),
                color: CoreColors.brandGold,
              ),
              SizedBox(width: CoreSpacing.xs(context)),
              Text(
                '$points ${l10n.homePointsLabel}',
                style: CoreTypography.caption(
                  context,
                  scheme.onSurfaceVariant,
                ).copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: CoreColors.brandGold.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(
                    CoreContentSizes.pillRadius(context),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: CoreSpacing.sm(context),
                    vertical: CoreSpacing.xs(context),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.emoji_events_outlined,
                        size: CoreContentSizes.badgeIcon(context),
                        color: CoreColors.brandBrown,
                      ),
                      SizedBox(width: CoreSpacing.xs(context)),
                      Text(
                        l10n.loyaltyGoldMember,
                        style: CoreTypography.caption(
                          context,
                          CoreColors.brandBrown,
                        ).copyWith(fontWeight: FontWeight.w800, height: 1.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
        if (role == AppRole.cashier && profile.employeeId != null) ...[
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            l10n.cashierDrawerIdentity(profile.employeeId!, name),
            style: CoreTypography.caption(
              context,
              scheme.onSurfaceVariant,
            ).copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ],
    );
  }
}

class _DrawerDestinationTile extends StatelessWidget {
  const _DrawerDestinationTile({
    required this.destination,
    required this.selected,
  });

  final _DrawerDestination destination;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: CoreSpacing.sm(context)),
      child: ListTile(
        selected: selected,
        selectedTileColor: scheme.primary.withValues(alpha: 0.10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
        ),
        leading: Icon(
          destination.icon,
          color: selected ? scheme.primary : scheme.onSurfaceVariant,
        ),
        title: Text(
          destination.label,
          style: CoreTypography.bodyMedium(
            context,
            selected ? scheme.primary : scheme.onSurface,
          ).copyWith(fontWeight: selected ? FontWeight.w800 : FontWeight.w600),
        ),
        onTap: () {
          Navigator.of(context).pop();
          if (!selected) {
            context.go(destination.route);
          }
        },
      ),
    );
  }
}
