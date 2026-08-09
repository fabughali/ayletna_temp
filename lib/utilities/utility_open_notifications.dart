import 'package:ayletna_restaurant_app/core/core_color_scheme.dart';

/// True when the signed-in role should see customer-facing notification copy.
bool isCustomerNotificationsAudience(AppRole role) =>
    role == AppRole.customer || role == AppRole.guest;
