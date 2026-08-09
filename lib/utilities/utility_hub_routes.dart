import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';

/// Resolves hub home + settings routes from the active URL prefix (shared screens).
abstract final class UtilityHubRoutes {
  static String hubRouteForPath(String path, {bool readOnlyOwner = false}) {
    if (readOnlyOwner || path.startsWith('/owner')) {
      return AppRoutePaths.ownerHub;
    }
    if (path.startsWith('/app-admin')) return AppRoutePaths.appAdmin;
    if (path.startsWith('/operator')) return AppRoutePaths.operatorHub;
    if (path.startsWith('/support-desk')) return AppRoutePaths.supportDesk;
    if (path.startsWith('/marketing')) return AppRoutePaths.marketingHub;
    return AppRoutePaths.operatorHub;
  }

  static String settingsRouteForPath(String path, {bool readOnlyOwner = false}) {
    if (readOnlyOwner || path.startsWith('/owner')) {
      return AppRoutePaths.accountSettings;
    }
    if (path.startsWith('/app-admin')) return AppRoutePaths.appAdminSettings;
    if (path.startsWith('/operator')) return AppRoutePaths.operatorSettings;
    if (path.startsWith('/support-desk') || path.startsWith('/marketing')) {
      return AppRoutePaths.accountSettings;
    }
    return AppRoutePaths.operatorSettings;
  }

  static bool showSettingsForPath(String path, {bool readOnlyOwner = false}) {
    if (readOnlyOwner) return true;
    return !path.startsWith('/support-desk');
  }
}
