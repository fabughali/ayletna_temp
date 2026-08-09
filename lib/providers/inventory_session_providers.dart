import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_inventory_mock.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Active ingredient stock tracked in the mock session (Atlantic salmon SKU).
class InventoryStockState {
  const InventoryStockState({
    required this.stockKg,
    required this.thresholdKg,
    this.sessionAuditRows = const [],
  });

  final double stockKg;
  final double thresholdKg;
  final List<ModelInventoryAuditRow> sessionAuditRows;

  double get fillRatio =>
      (stockKg / (thresholdKg * 3)).clamp(0.0, 1.0).toDouble();

  InventoryStockState copyWith({
    double? stockKg,
    double? thresholdKg,
    List<ModelInventoryAuditRow>? sessionAuditRows,
  }) {
    return InventoryStockState(
      stockKg: stockKg ?? this.stockKg,
      thresholdKg: thresholdKg ?? this.thresholdKg,
      sessionAuditRows: sessionAuditRows ?? this.sessionAuditRows,
    );
  }
}

class InventoryStockNotifier extends StateNotifier<InventoryStockState> {
  InventoryStockNotifier()
    : super(const InventoryStockState(stockKg: 42.5, thresholdKg: 15.0));

  void applyAdjustment({
    required double deltaKg,
    required ModelInventoryAuditRow auditRow,
  }) {
    if (deltaKg == 0) return;
    state = state.copyWith(
      stockKg: (state.stockKg + deltaKg).clamp(0, double.infinity),
      sessionAuditRows: [auditRow, ...state.sessionAuditRows],
    );
  }

  void updateThreshold(double thresholdKg) {
    if (thresholdKg <= 0) return;
    state = state.copyWith(thresholdKg: thresholdKg);
  }
}

final inventoryStockProvider =
    StateNotifierProvider<InventoryStockNotifier, InventoryStockState>(
      (ref) => InventoryStockNotifier(),
    );

/// Wastage entries logged during the current session (prepended to mock logs).
class InventoryWastageLogsNotifier
    extends StateNotifier<List<ModelInventoryWastageLog>> {
  InventoryWastageLogsNotifier() : super(const []);

  void logWastage(ModelInventoryWastageLog entry) {
    state = [entry, ...state];
  }
}

final inventorySessionWastageProvider = StateNotifierProvider<
  InventoryWastageLogsNotifier,
  List<ModelInventoryWastageLog>
>((ref) => InventoryWastageLogsNotifier());

/// Combined wastage list: session first, then catalog baseline.
final inventoryWastageLogsProvider = Provider<List<ModelInventoryWastageLog>>((
  ref,
) {
  final session = ref.watch(inventorySessionWastageProvider);
  return [...session, ...MockupCatalog.inventoryWastageLogs];
});

/// Combined audit history for the active item screen.
final inventoryAuditHistoryProvider = Provider<List<ModelInventoryAuditRow>>((
  ref,
) {
  final stock = ref.watch(inventoryStockProvider);
  return [...stock.sessionAuditRows, ...MockupCatalog.inventoryAuditRows];
});

/// Dashboard ingredient search query.
final inventorySearchQueryProvider = StateProvider<String>((ref) => '');
