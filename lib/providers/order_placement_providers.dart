import 'package:ayletna_restaurant_app/data/models/model_cart_line.dart';
import 'package:ayletna_restaurant_app/data/models/model_place_order_request.dart';
import 'package:ayletna_restaurant_app/data/models/model_place_order_result.dart';
import 'package:ayletna_restaurant_app/data/repositories/repository_providers.dart';
import 'package:ayletna_restaurant_app/providers/cart_providers.dart';
import 'package:ayletna_restaurant_app/providers/checkout_draft_providers.dart';
import 'package:ayletna_restaurant_app/providers/customer_action_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef PlaceOrderState = AsyncValue<ModelPlaceOrderResult?>;

class PlaceOrderNotifier extends StateNotifier<PlaceOrderState> {
  PlaceOrderNotifier(this.ref) : super(const AsyncData(null));

  final Ref ref;

  Future<ModelPlaceOrderResult?> submit() async {
    if (state is AsyncLoading) return null;

    state = const AsyncLoading();
    try {
      final lines = ref.read(cartProvider);
      final draft = ref.read(checkoutDraftProvider);
      final result = await ref
          .read(repositoryOrderProvider)
          .placeOrder(ModelPlaceOrderRequest(lines: lines, draft: draft));

      ref.read(placedOrderIdProvider.notifier).state = result.orderId;
      ref.read(activeTrackingOrderIdProvider.notifier).state = result.orderId;
      ref.read(cartProvider.notifier).clear();
      ref.read(checkoutDraftProvider.notifier).reset();
      ref.invalidate(customerOrderHistoryProvider);

      state = AsyncData(result);
      return result;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return null;
    }
  }

  void reset() => state = const AsyncData(null);
}

final placeOrderProvider =
    StateNotifierProvider<PlaceOrderNotifier, PlaceOrderState>(
      (ref) => PlaceOrderNotifier(ref),
    );

final checkoutOrderDetailProvider = FutureProvider((ref) async {
  final orderId = ref.watch(placedOrderIdProvider);
  final repo = ref.read(repositoryOrderProvider);
  if (orderId != null) {
    return repo.fetchOrderDetailById(orderId);
  }
  return repo.fetchCheckoutOrderDetail();
});

final ratingOrderDetailProvider = FutureProvider((ref) async {
  final orderId =
      ref.watch(ratingOrderIdProvider) ?? ref.watch(placedOrderIdProvider);
  final repo = ref.read(repositoryOrderProvider);
  if (orderId != null) {
    return repo.fetchOrderDetailById(orderId);
  }
  return repo.fetchCheckoutOrderDetail();
});

final reorderLinesProvider = FutureProvider.family<List<ModelCartLine>, String>(
  (ref, orderId) async {
    return ref.read(repositoryOrderProvider).buildReorderLines(orderId);
  },
);
