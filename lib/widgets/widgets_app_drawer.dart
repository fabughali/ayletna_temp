import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Role-aware drawer/list navigation for the redesigned app.
class WidgetsAppDrawer extends StatelessWidget {
  const WidgetsAppDrawer({
    required this.role,
    required this.currentPath,
    super.key,
  });

  final AppRole role;
  final String currentPath;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final destinations = _destinationsFor(l10n, role);
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
                      color: scheme.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(
                        CoreSpacing.radiusCard,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(CoreSpacing.md(context)),
                      child: Icon(
                        Icons.restaurant_menu_outlined,
                        color: scheme.primary,
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
                  if (role == AppRole.cashier) ...[
                    Text(
                      l10n.cashierDrawerIdentity(
                        MockupCatalog.cashierNumber,
                        Localizations.localeOf(context).languageCode == 'ar'
                            ? MockupCatalog.cashierNameAr
                            : MockupCatalog.cashierNameEn,
                      ),
                      style: CoreTypography.bodyMedium(
                        context,
                        scheme.primary,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
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
      if (destination.matches(currentPath)) {
        return destination.label;
      }
    }

    return switch (role) {
      AppRole.customer => l10n.screenHome,
      AppRole.guest => l10n.screenHome,
      AppRole.operator || AppRole.owner => l10n.screenAdminDashboard,
      AppRole.cashier => l10n.screenCashierOrder,
      AppRole.kitchen => l10n.screenKitchenDashboard,
      AppRole.delivery => l10n.screenDeliveryDashboard,
      AppRole.inventory => l10n.screenInventoryDashboard,
      AppRole.staff => l10n.screenStaffAttendance,
    };
  }

  static List<_DrawerDestination> _destinationsFor(
    AppLocalizations l10n,
    AppRole role,
  ) {
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
          label: l10n.guestMenuNav,
          activeRoutes: const [
            AppRoutePaths.category,
            AppRoutePaths.productDetail,
            AppRoutePaths.orderType,
            AppRoutePaths.dineIn,
            AppRoutePaths.takeaway,
            AppRoutePaths.deliveryAddress,
            AppRoutePaths.platedInfo,
            AppRoutePaths.combo,
          ],
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
          label: l10n.screenOrderHistory,
          activeRoutes: const [
            AppRoutePaths.orderHistory,
            AppRoutePaths.orderTracking,
            AppRoutePaths.ratingReview,
          ],
        ),
        _DrawerDestination(
          route: AppRoutePaths.rewards,
          icon: Icons.card_giftcard_outlined,
          label: l10n.screenRewardsCatalog,
          activeRoutes: const [
            AppRoutePaths.loyalty,
            AppRoutePaths.rewards,
            AppRoutePaths.redemption,
            AppRoutePaths.offers,
            AppRoutePaths.discounts,
          ],
        ),
        _DrawerDestination(
          route: AppRoutePaths.notifications,
          icon: Icons.notifications_outlined,
          label: l10n.screenNotifications,
        ),
        _DrawerDestination(
          route: AppRoutePaths.profile,
          icon: Icons.person_outline,
          label: l10n.screenProfile,
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
          ],
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
          activeRoutes: const [AppRoutePaths.support, AppRoutePaths.faq],
        ),
        _DrawerDestination(
          route: AppRoutePaths.login,
          icon: Icons.login_outlined,
          label: l10n.actionSignIn,
        ),
      ],
      AppRole.operator || AppRole.owner => [
        _DrawerDestination(
          route: AppRoutePaths.admin,
          icon: Icons.dashboard_customize_outlined,
          label: l10n.screenAdminDashboard,
        ),
        _DrawerDestination(
          route: AppRoutePaths.adminOrders,
          icon: Icons.receipt_long_outlined,
          label: l10n.screenOrdersManagement,
        ),
        _DrawerDestination(
          route: AppRoutePaths.adminMenu,
          icon: Icons.restaurant_outlined,
          label: l10n.screenMenuManagement,
        ),
        _DrawerDestination(
          route: AppRoutePaths.adminUsers,
          icon: Icons.groups_outlined,
          label: l10n.screenUserManagement,
        ),
        _DrawerDestination(
          route: AppRoutePaths.adminFinancial,
          icon: Icons.point_of_sale_outlined,
          label: l10n.screenFinancialCalculation,
        ),
        _DrawerDestination(
          route: AppRoutePaths.adminReports,
          icon: Icons.insights_outlined,
          label: l10n.screenReports,
        ),
        _DrawerDestination(
          route: AppRoutePaths.adminSettings,
          icon: Icons.tune_outlined,
          label: l10n.screenSettings,
        ),
        _DrawerDestination(
          route: AppRoutePaths.accountSettings,
          icon: Icons.person_outline,
          label: l10n.screenProfile,
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
          label: l10n.screenProfile,
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
          label: l10n.screenProfile,
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
          label: l10n.screenProfile,
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
        ),
        _DrawerDestination(
          route: AppRoutePaths.staffAttendance,
          icon: Icons.schedule_outlined,
          label: l10n.screenStaffAttendance,
        ),
        _DrawerDestination(
          route: AppRoutePaths.inventoryItem,
          icon: Icons.eco_outlined,
          label: l10n.screenInventoryItem,
        ),
        _DrawerDestination(
          route: AppRoutePaths.stockAdjustment,
          icon: Icons.edit_note_outlined,
          label: l10n.screenStockAdjustment,
        ),
        _DrawerDestination(
          route: AppRoutePaths.accountSettings,
          icon: Icons.person_outline,
          label: l10n.screenProfile,
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
          label: l10n.screenProfile,
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
  });

  final String route;
  final IconData icon;
  final String label;
  final List<String> activeRoutes;

  bool matches(String path) {
    return path == route || activeRoutes.contains(path);
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
          borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
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
