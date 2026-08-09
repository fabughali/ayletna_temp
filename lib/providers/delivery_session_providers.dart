import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_delivery_return_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Completed delivery run recorded in the current driver shift.
class DeliveryCompletedRun {
  const DeliveryCompletedRun({
    required this.orderId,
    required this.totalJod,
    required this.completedAt,
  });

  final String orderId;
  final double totalJod;
  final DateTime completedAt;
}

/// In-progress plated return assessment tied to a pickup task.
class DeliveryActiveReturnDraft {
  const DeliveryActiveReturnDraft({
    required this.taskId,
    required this.customerNameEn,
    required this.customerNameAr,
    this.missingItemKeys = const {},
  });

  final String taskId;
  final String customerNameEn;
  final String customerNameAr;
  final Set<String> missingItemKeys;

  static const originalDepositJod = 15.0;
  static const breakagePerItemJod = 2.5;

  int get missingCount => missingItemKeys.length;

  double get breakageTotalJod => missingCount * breakagePerItemJod;

  double get netRefundJod =>
      (originalDepositJod - breakageTotalJod).clamp(0, double.infinity);
}

/// Running shift earnings (mock baseline + session deliveries).
class DeliveryShiftEarningsNotifier extends StateNotifier<double> {
  DeliveryShiftEarningsNotifier()
    : super(MockupCatalog.deliveryShiftEarningsJod);

  void recordDelivery(double totalJod) {
    if (totalJod <= 0) return;
    state = state + totalJod;
  }
}

final deliveryShiftEarningsProvider =
    StateNotifierProvider<DeliveryShiftEarningsNotifier, double>(
      (ref) => DeliveryShiftEarningsNotifier(),
    );

/// Deliveries completed in the current session.
class DeliverySessionRunsNotifier
    extends StateNotifier<List<DeliveryCompletedRun>> {
  DeliverySessionRunsNotifier() : super(const []);

  void recordPickup({required String orderId, required double totalJod}) {
    state = [
      DeliveryCompletedRun(
        orderId: orderId,
        totalJod: totalJod,
        completedAt: DateTime.now(),
      ),
      ...state,
    ];
  }
}

final deliverySessionRunsProvider = StateNotifierProvider<
  DeliverySessionRunsNotifier,
  List<DeliveryCompletedRun>
>((ref) => DeliverySessionRunsNotifier());

/// Mutable plated return queue for the active shift.
class DeliveryReturnTasksNotifier
    extends StateNotifier<List<ModelDeliveryReturnTask>> {
  DeliveryReturnTasksNotifier()
    : super(List.of(MockupCatalog.deliveryReturnTasks));

  void removeTask(String taskId) {
    state = state.where((task) => task.id != taskId).toList();
  }
}

final deliveryReturnTasksProvider = StateNotifierProvider<
  DeliveryReturnTasksNotifier,
  List<ModelDeliveryReturnTask>
>((ref) => DeliveryReturnTasksNotifier());

/// Selected return task + checklist state for the process screen.
class DeliveryActiveReturnNotifier
    extends StateNotifier<DeliveryActiveReturnDraft?> {
  DeliveryActiveReturnNotifier() : super(null);

  void beginTask(ModelDeliveryReturnTask task) {
    state = DeliveryActiveReturnDraft(
      taskId: task.id,
      customerNameEn: task.nameEn,
      customerNameAr: task.nameAr,
    );
  }

  void setItemMissing(String itemKey, bool missing) {
    final draft = state;
    if (draft == null) return;
    final keys = {...draft.missingItemKeys};
    if (missing) {
      keys.add(itemKey);
    } else {
      keys.remove(itemKey);
    }
    state = DeliveryActiveReturnDraft(
      taskId: draft.taskId,
      customerNameEn: draft.customerNameEn,
      customerNameAr: draft.customerNameAr,
      missingItemKeys: keys,
    );
  }

  void clear() => state = null;
}

final deliveryActiveReturnProvider = StateNotifierProvider<
  DeliveryActiveReturnNotifier,
  DeliveryActiveReturnDraft?
>((ref) => DeliveryActiveReturnNotifier());

/// Deposits refunded after finalized return assessments this shift.
class DeliveryReturnStatsNotifier extends StateNotifier<double> {
  DeliveryReturnStatsNotifier() : super(0);

  void recordRefund(double netRefundJod) {
    if (netRefundJod <= 0) return;
    state = state + netRefundJod;
  }
}

final deliveryReturnStatsProvider =
    StateNotifierProvider<DeliveryReturnStatsNotifier, double>(
      (ref) => DeliveryReturnStatsNotifier(),
    );

/// Driver note for the active delivery order card.
final deliveryOrderNoteProvider = StateProvider<String>((ref) => '');

/// Orders flagged for missing items during active delivery runs.
class DeliveryMissingItemFlagsNotifier extends StateNotifier<Set<String>> {
  DeliveryMissingItemFlagsNotifier() : super(const {});

  void reportMissing(String orderId) {
    if (orderId.trim().isEmpty) return;
    state = {...state, orderId};
  }

  bool isFlagged(String orderId) => state.contains(orderId);
}

final deliveryMissingItemFlagsProvider = StateNotifierProvider<
  DeliveryMissingItemFlagsNotifier,
  Set<String>
>((ref) => DeliveryMissingItemFlagsNotifier());
