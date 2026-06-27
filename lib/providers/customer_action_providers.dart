import 'package:ayletna_restaurant_app/data/models/model_customer_notification.dart';
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

final customerNotificationsDismissedProvider =
    StateNotifierProvider<CustomerNotificationsNotifier, Set<String>>(
      (ref) => CustomerNotificationsNotifier(),
    );

final visibleCustomerNotificationsProvider =
    Provider<List<ModelCustomerNotification>>((ref) {
      final dismissed = ref.watch(customerNotificationsDismissedProvider);
      return MockupCatalog.customerNotifications
          .where((notification) => !dismissed.contains(notification.id))
          .toList();
    });

/// Last placed order id — set after successful checkout.
final placedOrderIdProvider = StateProvider<String?>((ref) => null);

/// Active order id for tracking / status views.
final activeTrackingOrderIdProvider = StateProvider<String?>((ref) => null);

/// Selected reward for redemption confirm screen.
final selectedRewardIdProvider = StateProvider<String?>((ref) => null);

/// Order id context for post-delivery rating flow.
final ratingOrderIdProvider = StateProvider<String?>((ref) => null);
