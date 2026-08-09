import 'package:ayletna_restaurant_app/data/models/model_customer_notification.dart';
import 'package:ayletna_restaurant_app/data/models/model_customer_notification_category.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerNotificationsNotifier extends StateNotifier<Set<String>> {
  CustomerNotificationsNotifier() : super(const {});

  void dismiss(String id) => state = {...state, id};

  void clearAll() {
    state = {
      for (final notification in MockupCatalog.customerNotifications)
        notification.id,
    };
  }

  void reset() => state = const {};
}

class CustomerInjectedNotificationsNotifier
    extends StateNotifier<List<ModelCustomerNotification>> {
  CustomerInjectedNotificationsNotifier() : super(const []);

  void prepend(ModelCustomerNotification notification) {
    state = [notification, ...state.where((n) => n.id != notification.id)];
  }
}

final customerNotificationsDismissedProvider =
    StateNotifierProvider<CustomerNotificationsNotifier, Set<String>>(
      (ref) => CustomerNotificationsNotifier(),
    );

final customerInjectedNotificationsProvider = StateNotifierProvider<
  CustomerInjectedNotificationsNotifier,
  List<ModelCustomerNotification>
>((ref) => CustomerInjectedNotificationsNotifier());

final visibleCustomerNotificationsProvider =
    Provider<List<ModelCustomerNotification>>((ref) {
      final dismissed = ref.watch(customerNotificationsDismissedProvider);
      final injected = ref.watch(customerInjectedNotificationsProvider);
      final seeded = MockupCatalog.customerNotifications;
      return [
        ...injected,
        ...seeded,
      ].where((notification) => !dismissed.contains(notification.id)).toList();
    });

final customerNotificationCategoriesProvider =
    Provider<List<ModelCustomerNotificationCategory>>(
      (ref) => MockupCatalog.customerNotificationCategories,
    );

/// Selected notifications category chip (`all` / `orders` / …).
final selectedCustomerNotificationCategoryProvider = StateProvider<String>(
  (ref) => 'all',
);

bool customerNotificationMatchesCategory(
  ModelCustomerNotification notification,
  String categoryId,
) {
  return switch (categoryId) {
    'all' => true,
    'orders' =>
      notification.iconKey == 'delivery' ||
          notification.iconKey == 'restaurant',
    'sustainability' => notification.iconKey == 'eco',
    'account' =>
      notification.iconKey == 'admin' ||
          notification.iconKey == 'payments' ||
          notification.iconKey == 'campaign' ||
          notification.iconKey == 'inventory',
    _ => true,
  };
}

/// Last placed order id — set after successful checkout.
final placedOrderIdProvider = StateProvider<String?>((ref) => null);

/// Active order id for tracking / status views.
final activeTrackingOrderIdProvider = StateProvider<String?>((ref) => null);

/// Selected reward for redemption confirm screen.
final selectedRewardIdProvider = StateProvider<String?>((ref) => null);

/// Order id context for post-delivery rating flow.
final ratingOrderIdProvider = StateProvider<String?>((ref) => null);

/// Customer plated-return reminder status (in-memory mock).
enum PlatedReturnPlan { none, pickupScheduled, selfReturnLogged }

final platedReturnPlanProvider = StateProvider<PlatedReturnPlan>(
  (ref) => PlatedReturnPlan.none,
);

/// Favorite menu item ids (in-memory mock — survives while app session lives).
class FavoriteMenuIdsNotifier extends StateNotifier<Set<String>> {
  FavoriteMenuIdsNotifier() : super(const {});

  bool isFavorite(String id) => state.contains(id);

  /// Returns `true` when the item is now favorited.
  bool toggle(String id) {
    if (state.contains(id)) {
      state = {...state}..remove(id);
      return false;
    }
    state = {...state, id};
    return true;
  }

  void clearAll() => state = const {};
}

final favoriteMenuIdsProvider =
    StateNotifierProvider<FavoriteMenuIdsNotifier, Set<String>>(
      (ref) => FavoriteMenuIdsNotifier(),
    );

/// Resolved favorite menu items for the customer Favorites screen.
final favoriteMenuItemsProvider = Provider<List<ModelMenuItem>>((ref) {
  final ids = ref.watch(favoriteMenuIdsProvider);
  return [
    for (final id in ids)
      if (MockupCatalog.itemById(id) case final item?) item,
  ];
});
