import 'package:ayletna_restaurant_app/data/models/model_cashier_postponed_order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cashierPostponedOrdersProvider = StateNotifierProvider<
  CashierPostponedOrdersNotifier,
  List<ModelCashierPostponedOrder>
>((ref) => CashierPostponedOrdersNotifier());

/// Draft loaded when cashier resumes a postponed order from history.
final cashierResumeDraftProvider = StateProvider<ModelCashierPostponedOrder?>(
  (ref) => null,
);

class CashierPostponedOrdersNotifier
    extends StateNotifier<List<ModelCashierPostponedOrder>> {
  CashierPostponedOrdersNotifier() : super(const []);

  void addOrder(ModelCashierPostponedOrder order) {
    state = [order, ...state];
  }

  void removeOrder(String id) {
    state = state.where((order) => order.id != id).toList();
  }
}
