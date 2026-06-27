import 'package:ayletna_restaurant_app/core/core_color_scheme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_order_summary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Running cash-tip total for the active cashier shift (mock baseline + session logs).
class CashierShiftTipsNotifier extends StateNotifier<double> {
  CashierShiftTipsNotifier() : super(MockupCatalog.cashierShiftTipsJod);

  void logTip(double amountJod) {
    if (amountJod <= 0) return;
    state = state + amountJod;
  }
}

final cashierShiftTipsProvider =
    StateNotifierProvider<CashierShiftTipsNotifier, double>(
      (ref) => CashierShiftTipsNotifier(),
    );

/// POS tickets completed in the current session (prepended to mock shift history).
class CashierSessionOrdersNotifier
    extends StateNotifier<List<ModelOrderSummary>> {
  CashierSessionOrdersNotifier() : super(const []);

  void recordOrder(ModelOrderSummary order) {
    state = [order, ...state];
  }

  void markRefunded(String orderId) {
    state = [
      for (final order in state)
        if (order.id == orderId)
          ModelOrderSummary(
            id: order.id,
            orderType: order.orderType,
            customerLabel: order.customerLabel,
            totalJod: order.totalJod,
            depositJod: order.depositJod,
            statusKey: 'refunded',
            isPlated: order.isPlated,
          )
        else
          order,
    ];
  }
}

final cashierSessionOrdersProvider =
    StateNotifierProvider<CashierSessionOrdersNotifier, List<ModelOrderSummary>>(
      (ref) => CashierSessionOrdersNotifier(),
    );

OrderType cashierFulfillmentToOrderType(String fulfillmentKey) {
  return switch (fulfillmentKey) {
    'takeaway' => OrderType.takeaway,
    'delivery' => OrderType.delivery,
    'groupDelivery' => OrderType.delivery,
    'plated' => OrderType.platedDelivery,
    _ => OrderType.dineIn,
  };
}
