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
          order.copyWith(statusKey: 'refunded')
        else
          order,
    ];
  }

  void markReceiptPrinted(String orderId) {
    state = [
      for (final order in state)
        if (order.id == orderId)
          order.copyWith(receiptPrinted: true)
        else
          order,
    ];
  }

  void markElectronicTicketSent(String orderId) {
    state = [
      for (final order in state)
        if (order.id == orderId)
          order.copyWith(electronicTicketSent: true)
        else
          order,
    ];
  }

  /// Marks the newest session ticket when print/e-ticket fires after payment.
  bool markLatestReceiptPrinted() {
    if (state.isEmpty) return false;
    markReceiptPrinted(state.first.id);
    return true;
  }

  bool markLatestElectronicTicketSent() {
    if (state.isEmpty) return false;
    markElectronicTicketSent(state.first.id);
    return true;
  }
}

final cashierSessionOrdersProvider = StateNotifierProvider<
  CashierSessionOrdersNotifier,
  List<ModelOrderSummary>
>((ref) => CashierSessionOrdersNotifier());

OrderType cashierFulfillmentToOrderType(String fulfillmentKey) {
  return switch (fulfillmentKey) {
    'takeaway' => OrderType.takeaway,
    'delivery' => OrderType.delivery,
    'groupDelivery' => OrderType.delivery,
    'plated' => OrderType.platedDelivery,
    _ => OrderType.dineIn,
  };
}
