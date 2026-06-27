import 'package:ayletna_restaurant_app/core/app_config.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';

/// Redirects collapsed checkout paths to `/cart` unless stepped routes are enabled.
String? redirectCollapsedCheckoutRoute(String path) {
  if (AppConfig.useSteppedCheckoutRoutes) {
    return null;
  }

  const collapsedPaths = {
    AppRoutePaths.orderType,
    AppRoutePaths.dineIn,
    AppRoutePaths.takeaway,
    AppRoutePaths.deliveryAddress,
    AppRoutePaths.platedInfo,
    AppRoutePaths.checkout,
    AppRoutePaths.tip,
    AppRoutePaths.payment,
  };

  if (collapsedPaths.contains(path)) {
    return AppRoutePaths.cart;
  }

  return null;
}
