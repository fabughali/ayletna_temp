import 'package:ayletna_restaurant_app/core/core_color_scheme.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/session_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD §6.4 route protection (UI phase).
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

    if (!_roleMayAccess(role, path)) {
      return homeRouteForRole(role);
    }

    return null;
  }

  static bool _isPublic(String path) =>
      _publicPaths.contains(path) || path == AppRoutePaths.paymentCallback;

  static bool _roleMayAccess(AppRole role, String path) {
    if (path == AppRoutePaths.support ||
        path == AppRoutePaths.supportChat ||
        path == AppRoutePaths.faq) {
      return true;
    }
    if (path == AppRoutePaths.accountSettings ||
        path == AppRoutePaths.editProfile) {
      return role != AppRole.guest;
    }
    if (path.startsWith('/tip/daily/')) {
      return role == AppRole.operator ||
          role == AppRole.owner ||
          role == AppRole.staff;
    }
    if (path.startsWith('/order/')) {
      return role == AppRole.customer ||
          role == AppRole.guest ||
          role == AppRole.operator;
    }
    if (path.startsWith('/admin')) {
      return role == AppRole.operator || role == AppRole.owner;
    }
    if (path == AppRoutePaths.kitchen || path == AppRoutePaths.kitchenPrep) {
      return role == AppRole.kitchen || role == AppRole.operator;
    }
    if (path.startsWith('/cashier') || path == AppRoutePaths.cashier) {
      return role == AppRole.cashier || role == AppRole.operator;
    }
    if (path.startsWith('/delivery') ||
        path == AppRoutePaths.delivery ||
        path == AppRoutePaths.platedReturnTask ||
        path == AppRoutePaths.platedReturnProcess) {
      return role == AppRole.delivery || role == AppRole.operator;
    }
    if (path == AppRoutePaths.inventory ||
        path == AppRoutePaths.inventoryItem ||
        path == AppRoutePaths.stockAdjustment) {
      return role == AppRole.inventory || role == AppRole.operator;
    }
    if (path == AppRoutePaths.staffAttendance ||
        path == AppRoutePaths.staffTips ||
        path == AppRoutePaths.staffTipHistory) {
      return role == AppRole.staff ||
          role == AppRole.operator ||
          role == AppRole.kitchen ||
          role == AppRole.delivery ||
          role == AppRole.cashier ||
          role == AppRole.inventory;
    }
    if (_isCustomerPath(path)) {
      return role == AppRole.customer || role == AppRole.guest;
    }
    return true;
  }

  static bool _isCustomerPath(String path) {
    const customer = {
      AppRoutePaths.home,
      AppRoutePaths.search,
      AppRoutePaths.category,
      AppRoutePaths.productDetail,
      AppRoutePaths.productReviews,
      AppRoutePaths.cart,
      AppRoutePaths.supportChat,
      AppRoutePaths.faq,
      AppRoutePaths.terms,
      AppRoutePaths.orderType,
      AppRoutePaths.dineIn,
      AppRoutePaths.takeaway,
      AppRoutePaths.deliveryAddress,
      AppRoutePaths.platedInfo,
      AppRoutePaths.checkout,
      AppRoutePaths.tip,
      AppRoutePaths.payment,
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
      AppRoutePaths.notifications,
      AppRoutePaths.platedReturnReminder,
      AppRoutePaths.offers,
      AppRoutePaths.discounts,
      AppRoutePaths.coupon,
      AppRoutePaths.combo,
    };
    if (path.startsWith('/order/')) {
      return true;
    }
    return customer.contains(path);
  }

  static bool _isGuestAllowedPath(String path) {
    const guest = {
      AppRoutePaths.home,
      AppRoutePaths.search,
      AppRoutePaths.category,
      AppRoutePaths.productDetail,
      AppRoutePaths.productReviews,
      AppRoutePaths.cart,
      AppRoutePaths.support,
      AppRoutePaths.supportChat,
      AppRoutePaths.faq,
      AppRoutePaths.loyalty,
      AppRoutePaths.rewards,
      AppRoutePaths.offers,
      AppRoutePaths.discounts,
      AppRoutePaths.combo,
      AppRoutePaths.terms,
    };
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
