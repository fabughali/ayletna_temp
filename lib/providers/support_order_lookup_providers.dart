import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_order_summary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Order row enriched for support lookup (PII + actions).
class SupportOrderLookupRow {
  const SupportOrderLookupRow({
    required this.order,
    required this.customerPhone,
    required this.customerAddress,
    this.cancelled = false,
    this.refundedJod,
  });

  final ModelOrderSummary order;
  final String customerPhone;
  final String customerAddress;
  final bool cancelled;
  final double? refundedJod;

  SupportOrderLookupRow copyWith({
    bool? cancelled,
    double? refundedJod,
    bool clearRefund = false,
  }) {
    return SupportOrderLookupRow(
      order: order,
      customerPhone: customerPhone,
      customerAddress: customerAddress,
      cancelled: cancelled ?? this.cancelled,
      refundedJod: clearRefund ? null : (refundedJod ?? this.refundedJod),
    );
  }
}

class SupportOrderLookupNotifier
    extends StateNotifier<List<SupportOrderLookupRow>> {
  SupportOrderLookupNotifier() : super(_seedRows());

  static List<SupportOrderLookupRow> _seedRows() {
    final orders = [
      ...MockupCatalog.activeOrders,
      ...MockupCatalog.orderHistory,
    ];
    return [
      for (var i = 0; i < orders.length; i++)
        SupportOrderLookupRow(
          order: orders[i],
          customerPhone: '+962 79 ${100 + i}${200 + i} ${3000 + i}',
          customerAddress: 'Amman · District ${i + 1} · Street ${10 + i}',
        ),
    ];
  }

  bool cancelOrder(String orderId) {
    final index = state.indexWhere((r) => r.order.id == orderId);
    if (index == -1) return false;
    if (state[index].cancelled) return false;
    final next = [...state]..[index] = state[index].copyWith(cancelled: true);
    state = next;
    return true;
  }

  bool refundOrder(String orderId, double amountJod) {
    final index = state.indexWhere((r) => r.order.id == orderId);
    if (index == -1) return false;
    if (amountJod <= 0) return false;
    final next = [...state]
      ..[index] = state[index].copyWith(refundedJod: amountJod);
    state = next;
    return true;
  }
}

final supportOrderLookupRowsProvider = StateNotifierProvider<
  SupportOrderLookupNotifier,
  List<SupportOrderLookupRow>
>((ref) => SupportOrderLookupNotifier());

final supportOrderLookupQueryProvider = StateProvider<String>((ref) => '');

final supportOrderLookupResultsProvider = Provider<List<SupportOrderLookupRow>>(
  (ref) {
    final query =
        ref.watch(supportOrderLookupQueryProvider).trim().toLowerCase();
    final all = ref.watch(supportOrderLookupRowsProvider);
    if (query.isEmpty) return all.take(8).toList();
    return all
        .where(
          (row) =>
              row.order.id.toLowerCase().contains(query) ||
              row.order.customerLabel.toLowerCase().contains(query) ||
              row.customerPhone.contains(query),
        )
        .toList();
  },
);
