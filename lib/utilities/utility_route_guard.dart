import 'package:ayletna_restaurant_app/core/app_config.dart';
import 'package:ayletna_restaurant_app/core/core_color_scheme.dart';
import 'package:ayletna_restaurant_app/data/models/model_permission_rule.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/role_permissions_providers.dart';
import 'package:ayletna_restaurant_app/providers/session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_permission_route_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD §6.4 route protection (UI mock phase).
abstract final class UtilityRouteGuard {
  static const _publicPaths = {
    AppRoutePaths.splash,
    AppRoutePaths.language,
    AppRoutePaths.login,
    AppRoutePaths.otp,
    AppRoutePaths.register,
    AppRoutePaths.forgotPassword,
    AppRoutePaths.guest,
    AppRoutePaths.pendingApproval,
  };

  static String? redirect(Ref ref, GoRouterState state) {
    final session = ref.read(sessionProvider);
    final role = ref.read(appRoleProvider);
    final path = state.uri.path;

    if (session.isPendingApproval && path != AppRoutePaths.pendingApproval) {
      // Allow help surfaces while waiting — contact support / FAQ must not dead-end.
      if (path == AppRoutePaths.faq ||
          path == AppRoutePaths.support ||
          path == AppRoutePaths.supportChat ||
          path == AppRoutePaths.supportTickets) {
        return null;
      }
      return AppRoutePaths.pendingApproval;
    }

    if (_isPublic(path)) {
      if (session.isAuthenticated &&
          !session.isPendingApproval &&
          (path == AppRoutePaths.login || path == AppRoutePaths.register)) {
        return homeRouteForRole(role);
      }
      return null;
    }

    if (role == AppRole.guest && _isGuestAllowedPath(path)) {
      return null;
    }

    if (role == AppRole.guest && _isGuestSignupRequiredPath(path)) {
      return AppRoutePaths.register;
    }

    if (!session.isAuthenticated) {
      return AppRoutePaths.login;
    }

    final legacyRedirect = _legacyAdminRedirect(role, path);
    if (legacyRedirect != null) return legacyRedirect;

    if (!_roleMayAccess(ref, role, path)) {
      return homeRouteForRole(role);
    }

    if (!_capabilityMayAccess(ref, path)) {
      return homeRouteForRole(role);
    }

    return null;
  }

  /// RBAC capability check for hub routes (mock — uses [activeRbacUserIdProvider]).
  static bool _capabilityMayAccess(Ref ref, String path) {
    final capability = UtilityPermissionRouteMap.capabilityForPath(path);
    if (capability == null) return true;

    final userId = ref.read(activeRbacUserIdProvider);
    if (userId == null) return true;

    final effective = ref.read(effectivePermissionsProvider(userId));
    final access = effective[capability] ?? PermissionAccess.denied;
    return access == PermissionAccess.full ||
        access == PermissionAccess.readOnly;
  }

  static bool _approved(Ref ref, AppRole role) =>
      ref.read(sessionProvider).approvedRoles.contains(role);

  static String? _legacyAdminRedirect(AppRole role, String path) {
    if (!path.startsWith('/admin')) return null;
    return switch (role) {
      AppRole.admin => _mapLegacyToAppAdmin(path),
      AppRole.operator => _mapLegacyToOperator(path),
      AppRole.owner => _mapLegacyToOwner(path),
      AppRole.support => _mapLegacyToSupport(path),
      AppRole.marketing => _mapLegacyToMarketing(path),
      _ => AppRoutePaths.admin,
    };
  }

  static String _mapLegacyToAppAdmin(String path) => switch (path) {
        AppRoutePaths.admin => AppRoutePaths.appAdmin,
        AppRoutePaths.adminUsers => AppRoutePaths.appAdminUsers,
        AppRoutePaths.adminAudit => AppRoutePaths.appAdminAudit,
        AppRoutePaths.adminAppIntegrations => AppRoutePaths.appAdminIntegrations,
        AppRoutePaths.adminOwnerConfig => AppRoutePaths.appAdminOwnerConfig,
        AppRoutePaths.adminSettings => AppRoutePaths.appAdminSettings,
        _ => AppRoutePaths.appAdmin,
      };

  static String _mapLegacyToOperator(String path) => switch (path) {
        AppRoutePaths.admin => AppRoutePaths.operatorHub,
        AppRoutePaths.adminOrders => AppRoutePaths.operatorOrders,
        AppRoutePaths.adminOrderDetail => AppRoutePaths.operatorOrderDetail,
        AppRoutePaths.adminMenu => AppRoutePaths.operatorMenu,
        AppRoutePaths.adminProductEditor => AppRoutePaths.operatorProductEditor,
        AppRoutePaths.adminTipDistribution => AppRoutePaths.operatorTipDistribution,
        AppRoutePaths.adminPlates => AppRoutePaths.operatorPlates,
        AppRoutePaths.adminPlateEditor => AppRoutePaths.operatorPlateEditor,
        AppRoutePaths.adminDepositConfig => AppRoutePaths.operatorDepositConfig,
        AppRoutePaths.adminPreOrder => AppRoutePaths.operatorPreOrders,
        AppRoutePaths.adminAttendanceHr => AppRoutePaths.operatorAttendance,
        AppRoutePaths.adminStaffHours => AppRoutePaths.operatorStaffHours,
        AppRoutePaths.adminReports => AppRoutePaths.operatorReports,
        AppRoutePaths.adminReportFilter => AppRoutePaths.operatorReportFilter,
        AppRoutePaths.adminFinancial => AppRoutePaths.operatorFinancial,
        AppRoutePaths.adminSettings => AppRoutePaths.operatorSettings,
        _ => AppRoutePaths.operatorHub,
      };

  static String _mapLegacyToOwner(String path) => switch (path) {
        AppRoutePaths.admin => AppRoutePaths.ownerHub,
        AppRoutePaths.adminReports => AppRoutePaths.ownerReports,
        AppRoutePaths.adminFinancial => AppRoutePaths.ownerFinancial,
        AppRoutePaths.adminAudit => AppRoutePaths.ownerAudit,
        _ => AppRoutePaths.ownerHub,
      };

  static String _mapLegacyToSupport(String path) => switch (path) {
        AppRoutePaths.adminSupportTickets => AppRoutePaths.supportDeskTickets,
        AppRoutePaths.adminReviewsModeration => AppRoutePaths.supportDeskReviews,
        _ => AppRoutePaths.supportDesk,
      };

  static String _mapLegacyToMarketing(String path) => switch (path) {
        AppRoutePaths.adminOffersMgmt => AppRoutePaths.marketingOffers,
        AppRoutePaths.adminMenuCatalog => AppRoutePaths.marketingCatalog,
        AppRoutePaths.adminLoyaltyConfig => AppRoutePaths.marketingLoyalty,
        AppRoutePaths.adminRewardsMgmt => AppRoutePaths.marketingRewards,
        _ => AppRoutePaths.marketingHub,
      };

  static bool _isPublic(String path) =>
      _publicPaths.contains(path) || path == AppRoutePaths.paymentCallback;

  static bool _roleMayAccess(Ref ref, AppRole role, String path) {
    if (path == AppRoutePaths.notifications) {
      // Shared inbox: customer marketing + ops shift alerts (screen branches by role).
      return true;
    }
    if (path == AppRoutePaths.support ||
        path == AppRoutePaths.supportChat ||
        path == AppRoutePaths.supportTickets ||
        path == AppRoutePaths.faq ||
        path == AppRoutePaths.blog) {
      return true;
    }
    if (path == AppRoutePaths.accountSettings ||
        path == AppRoutePaths.editProfile) {
      return role != AppRole.guest;
    }
    if (path == AppRoutePaths.roleSelection) {
      if (AppConfig.forcePostOtpRoleSelection) {
        return ref.read(sessionProvider).isAuthenticated &&
            ref.read(sessionProvider).approvedRoles.length >= 2;
      }
      return _approved(ref, role) &&
          ref.read(sessionProvider).approvedRoles.length >= 2;
    }
    if (path.startsWith('/tip/daily/')) {
      return _approved(ref, role) &&
          (role == AppRole.admin ||
              role == AppRole.operator ||
              role == AppRole.owner ||
              role == AppRole.staff);
    }
    if (path.startsWith('/order/')) {
      return role == AppRole.customer ||
          role == AppRole.guest ||
          (role == AppRole.operator && _approved(ref, role));
    }

    if (path.startsWith('/app-admin')) {
      return role == AppRole.admin && _approved(ref, role);
    }
    if (path.startsWith('/operator')) {
      return role == AppRole.operator && _approved(ref, role);
    }
    if (path.startsWith('/owner')) {
      return role == AppRole.owner && _approved(ref, role);
    }
    if (path.startsWith('/support-desk')) {
      return role == AppRole.support && _approved(ref, role);
    }
    if (path.startsWith('/marketing')) {
      return role == AppRole.marketing && _approved(ref, role);
    }

    if (path.startsWith('/admin')) {
      return (role == AppRole.operator || role == AppRole.owner) &&
          _approved(ref, role);
    }

    if (path == AppRoutePaths.kitchen || path == AppRoutePaths.kitchenPrep) {
      return _approved(ref, role) &&
          (role == AppRole.kitchen || role == AppRole.operator);
    }
    if (path.startsWith('/cashier') || path == AppRoutePaths.cashier) {
      return _approved(ref, role) &&
          (role == AppRole.cashier || role == AppRole.operator);
    }
    if (path.startsWith('/delivery') ||
        path == AppRoutePaths.delivery ||
        path == AppRoutePaths.platedReturnTask ||
        path == AppRoutePaths.platedReturnProcess) {
      return _approved(ref, role) &&
          (role == AppRole.delivery || role == AppRole.operator);
    }
    if (path == AppRoutePaths.inventory ||
        path == AppRoutePaths.inventoryItem ||
        path == AppRoutePaths.stockAdjustment) {
      return _approved(ref, role) &&
          (role == AppRole.inventory || role == AppRole.operator);
    }
    if (path == AppRoutePaths.staffAttendance ||
        path == AppRoutePaths.staffTips ||
        path == AppRoutePaths.staffTipHistory) {
      return _approved(ref, role) &&
          (role == AppRole.staff ||
              role == AppRole.kitchen ||
              role == AppRole.delivery ||
              role == AppRole.cashier ||
              role == AppRole.inventory ||
              role == AppRole.operator);
    }
    if (_isCustomerPath(path)) {
      return role == AppRole.customer || role == AppRole.guest;
    }
    return false;
  }

  static bool _isCustomerPath(String path) {
    const customer = {
      AppRoutePaths.home,
      AppRoutePaths.search,
      AppRoutePaths.category,
      AppRoutePaths.favorites,
      AppRoutePaths.productDetail,
      AppRoutePaths.productReviews,
      AppRoutePaths.cart,
      AppRoutePaths.support,
      AppRoutePaths.supportChat,
      AppRoutePaths.supportTickets,
      AppRoutePaths.faq,
      AppRoutePaths.blog,
      AppRoutePaths.terms,
      AppRoutePaths.orderType,
      AppRoutePaths.dineIn,
      AppRoutePaths.takeaway,
      AppRoutePaths.deliveryAddress,
      AppRoutePaths.platedInfo,
      AppRoutePaths.checkout,
      AppRoutePaths.tip,
      AppRoutePaths.payment,
      AppRoutePaths.checkoutReview,
      AppRoutePaths.orderConfirmation,
      AppRoutePaths.orderTracking,
      AppRoutePaths.orderHistory,
      AppRoutePaths.ratingReview,
      AppRoutePaths.wallet,
      AppRoutePaths.loyalty,
      AppRoutePaths.rewards,
      AppRoutePaths.rewardsHistory,
      AppRoutePaths.paymentHistory,
      AppRoutePaths.redemption,
      AppRoutePaths.profile,
      AppRoutePaths.editProfile,
      AppRoutePaths.addresses,
      AppRoutePaths.mapPicker,
      // notifications allowed for all roles via early _roleMayAccess check
      AppRoutePaths.platedReturnReminder,
      AppRoutePaths.offers,
      AppRoutePaths.discounts,
      AppRoutePaths.coupon,
      AppRoutePaths.combo,
      AppRoutePaths.combos,
      AppRoutePaths.subscriptions,
    };
    if (path.startsWith('/order/')) {
      return true;
    }
    if (_isPromoDetailPath(path)) {
      return true;
    }
    return customer.contains(path);
  }

  static bool _isPromoDetailPath(String path) {
    if (path.startsWith('/offers/') && path.length > '/offers/'.length) {
      return true;
    }
    if (path.startsWith('/combo/') && path.length > '/combo/'.length) {
      return true;
    }
    if (path.startsWith('/subscriptions/') &&
        path.length > '/subscriptions/'.length) {
      return true;
    }
    return false;
  }

  static bool _isGuestAllowedPath(String path) {
    const guest = {
      AppRoutePaths.home,
      AppRoutePaths.search,
      AppRoutePaths.category,
      AppRoutePaths.favorites,
      AppRoutePaths.productDetail,
      AppRoutePaths.productReviews,
      AppRoutePaths.cart,
      AppRoutePaths.support,
      AppRoutePaths.supportChat,
      AppRoutePaths.supportTickets,
      AppRoutePaths.faq,
      AppRoutePaths.blog,
      AppRoutePaths.loyalty,
      AppRoutePaths.rewards,
      AppRoutePaths.offers,
      AppRoutePaths.discounts,
      AppRoutePaths.combo,
      AppRoutePaths.combos,
      AppRoutePaths.subscriptions,
      AppRoutePaths.terms,
      AppRoutePaths.notifications,
    };
    if (_isPromoDetailPath(path)) {
      return true;
    }
    return guest.contains(path);
  }

  static bool _isGuestSignupRequiredPath(String path) {
    const signupRequired = {
      AppRoutePaths.orderType,
      AppRoutePaths.dineIn,
      AppRoutePaths.takeaway,
      AppRoutePaths.deliveryAddress,
      AppRoutePaths.platedInfo,
      AppRoutePaths.checkout,
      AppRoutePaths.tip,
      AppRoutePaths.payment,
      AppRoutePaths.checkoutReview,
      AppRoutePaths.orderConfirmation,
      AppRoutePaths.orderTracking,
      AppRoutePaths.orderHistory,
      AppRoutePaths.ratingReview,
      AppRoutePaths.wallet,
      AppRoutePaths.rewardsHistory,
      AppRoutePaths.paymentHistory,
      AppRoutePaths.redemption,
      AppRoutePaths.profile,
      AppRoutePaths.editProfile,
      AppRoutePaths.addresses,
      AppRoutePaths.mapPicker,
      AppRoutePaths.notifications,
      AppRoutePaths.platedReturnReminder,
    };
    return signupRequired.contains(path) || path.startsWith('/order/');
  }
}
