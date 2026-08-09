import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';

/// Maps hub routes to RBAC capability keys (matrix §3) for route guard checks.
abstract final class UtilityPermissionRouteMap {
  static const _prefixRules = [
    (AppRoutePaths.appAdminUsers, 'perm.admin.users'),
    (AppRoutePaths.appAdminRoles, 'perm.admin.rbac_defaults'),
    (AppRoutePaths.appAdminAudit, 'perm.admin.audit'),
    (AppRoutePaths.appAdminIntegrations, 'perm.admin.integrations'),
    (AppRoutePaths.appAdminOwnerConfig, 'perm.admin.owner_view_config'),
    (AppRoutePaths.appAdminSettings, 'perm.admin.system_settings'),
    (AppRoutePaths.appAdmin, 'perm.admin.users'),
    (AppRoutePaths.operatorOrders, 'perm.operator.orders'),
    (AppRoutePaths.operatorOrderDetail, 'perm.operator.orders'),
    (AppRoutePaths.operatorMenu, 'perm.operator.menu'),
    (AppRoutePaths.operatorProductEditor, 'perm.operator.menu'),
    (AppRoutePaths.operatorTipDistribution, 'perm.operator.tips'),
    (AppRoutePaths.operatorPlates, 'perm.operator.plates'),
    (AppRoutePaths.operatorPlateEditor, 'perm.operator.plates'),
    (AppRoutePaths.operatorDepositConfig, 'perm.operator.plates'),
    (AppRoutePaths.operatorPreOrders, 'perm.operator.orders'),
    (AppRoutePaths.operatorAttendance, 'perm.operator.hr'),
    (AppRoutePaths.operatorStaffHours, 'perm.operator.hr'),
    (AppRoutePaths.operatorReports, 'perm.operator.reports'),
    (AppRoutePaths.operatorReportFilter, 'perm.operator.reports'),
    (AppRoutePaths.operatorFinancial, 'perm.operator.financial_close'),
    (AppRoutePaths.operatorSettings, 'perm.operator.dashboard'),
    (AppRoutePaths.operatorHub, 'perm.operator.dashboard'),
    (AppRoutePaths.ownerReports, 'perm.owner.reports'),
    (AppRoutePaths.ownerFinancial, 'perm.owner.financial'),
    (AppRoutePaths.ownerAudit, 'perm.owner.dashboard'),
    (AppRoutePaths.ownerHub, 'perm.owner.dashboard'),
    (AppRoutePaths.supportDeskTickets, 'perm.support.tickets'),
    (AppRoutePaths.supportDeskChat, 'perm.support.chat'),
    (AppRoutePaths.supportDeskOrderLookup, 'perm.support.tickets'),
    (AppRoutePaths.supportDeskReviews, 'perm.support.reviews'),
    (AppRoutePaths.supportDeskFaq, 'perm.support.faq'),
    (AppRoutePaths.supportDesk, 'perm.support.tickets'),
    (AppRoutePaths.marketingOffers, 'perm.marketing.offers'),
    (AppRoutePaths.marketingDiscounts, 'perm.marketing.promotions'),
    (AppRoutePaths.marketingPromotions, 'perm.marketing.promotions'),
    (AppRoutePaths.marketingCatalog, 'perm.marketing.offers'),
    (AppRoutePaths.marketingCategories, 'perm.marketing.offers'),
    (AppRoutePaths.marketingProducts, 'perm.marketing.offers'),
    (AppRoutePaths.marketingAddons, 'perm.marketing.offers'),
    (AppRoutePaths.marketingLoyalty, 'perm.marketing.loyalty'),
    (AppRoutePaths.marketingRewards, 'perm.marketing.offers'),
    (AppRoutePaths.marketingCombos, 'perm.marketing.combos'),
    (AppRoutePaths.marketingSubscriptions, 'perm.marketing.subscriptions'),
    (AppRoutePaths.marketingCalendar, 'perm.marketing.promotions'),
    (AppRoutePaths.marketingSocial, 'perm.marketing.social'),
    (AppRoutePaths.marketingBlog, 'perm.marketing.social'),
    (AppRoutePaths.marketingHub, 'perm.marketing.offers'),
  ];

  static String? capabilityForPath(String path) {
    for (final (prefix, key) in _prefixRules) {
      if (path == prefix || path.startsWith('$prefix/')) return key;
    }
    if (path.startsWith('/app-admin/users/')) return 'perm.admin.users';
    return null;
  }
}
