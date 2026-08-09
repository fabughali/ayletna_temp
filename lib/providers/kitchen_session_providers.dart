import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_kitchen_prep_item.dart';
import 'package:ayletna_restaurant_app/data/models/model_kitchen_ready_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Kitchen pass board: one active prep ticket + ready/delayed handover queues.
class KitchenBoardState {
  const KitchenBoardState({
    this.activePrepOrderId,
    this.checkedPrepIndexes = const {},
    required this.readyOrders,
    required this.delayedOrders,
    this.issueReported = false,
    this.prepStartedAt,
  });

  final String? activePrepOrderId;
  final Set<int> checkedPrepIndexes;
  final List<ModelKitchenReadyOrder> readyOrders;
  final List<ModelKitchenReadyOrder> delayedOrders;
  final bool issueReported;
  final DateTime? prepStartedAt;

  int get preparingCount => activePrepOrderId != null ? 1 : 0;

  Duration get elapsedPrepTime {
    if (prepStartedAt == null) return Duration.zero;
    return DateTime.now().difference(prepStartedAt!);
  }

  String get formattedElapsedTime {
    final d = elapsedPrepTime;
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Parse "mm:ss" strings from [ModelKitchenReadyOrder.readyTime] and compute average.
  String get averageReadyTimeLabel {
    final orders = [...readyOrders, ...delayedOrders];
    if (orders.isEmpty) return '0:00';
    final totalSeconds = orders.fold<int>(0, (sum, order) {
      final parts = order.readyTime.split(':');
      if (parts.length != 2) return sum;
      final mins = int.tryParse(parts[0]) ?? 0;
      final secs = int.tryParse(parts[1]) ?? 0;
      return sum + mins * 60 + secs;
    });
    final avgSeconds = totalSeconds ~/ orders.length;
    final avgMins = avgSeconds ~/ 60;
    final avgSecs = avgSeconds.remainder(60);
    return '$avgMins:${avgSecs.toString().padLeft(2, '0')}';
  }

  List<ModelKitchenPrepItem> get prepItems => MockupCatalog.kitchenPrepItems;

  bool get prepComplete =>
      activePrepOrderId != null &&
      checkedPrepIndexes.length == prepItems.length;

  KitchenBoardState copyWith({
    String? activePrepOrderId,
    Set<int>? checkedPrepIndexes,
    List<ModelKitchenReadyOrder>? readyOrders,
    List<ModelKitchenReadyOrder>? delayedOrders,
    bool? issueReported,
    DateTime? prepStartedAt,
    bool clearPrep = false,
    bool clearPrepStartedAt = false,
  }) {
    return KitchenBoardState(
      activePrepOrderId:
          clearPrep ? null : (activePrepOrderId ?? this.activePrepOrderId),
      checkedPrepIndexes: checkedPrepIndexes ?? this.checkedPrepIndexes,
      readyOrders: readyOrders ?? this.readyOrders,
      delayedOrders: delayedOrders ?? this.delayedOrders,
      issueReported: issueReported ?? this.issueReported,
      prepStartedAt: clearPrepStartedAt ? null : (prepStartedAt ?? this.prepStartedAt),
    );
  }

  factory KitchenBoardState.initial() {
    final catalog = MockupCatalog.kitchenReadyOrders;
    return KitchenBoardState(
      activePrepOrderId: '1086',
      checkedPrepIndexes: const {0, 1},
      prepStartedAt: DateTime.now().subtract(const Duration(minutes: 12, seconds: 49)),
      readyOrders: catalog.where((order) => !order.isDelayed).toList(),
      delayedOrders: catalog.where((order) => order.isDelayed).toList(),
    );
  }
}

class KitchenBoardNotifier extends StateNotifier<KitchenBoardState> {
  KitchenBoardNotifier() : super(KitchenBoardState.initial());

  void togglePrepItem(int index, bool checked) {
    if (state.activePrepOrderId == null) return;
    final indexes = {...state.checkedPrepIndexes};
    if (checked) {
      indexes.add(index);
    } else {
      indexes.remove(index);
    }
    state = state.copyWith(checkedPrepIndexes: indexes);
  }

  void reportIssue() {
    state = state.copyWith(issueReported: true);
  }

  bool markReady() {
    if (!state.prepComplete || state.activePrepOrderId == null) return false;

    final items = state.prepItems;
    final readyOrder = ModelKitchenReadyOrder(
      id: state.activePrepOrderId!,
      destinationAr: 'طاولة 14',
      destinationEn: 'Table 14',
      badgeAr: 'طبق',
      badgeEn: 'Plated',
      typeKey: 'plated',
      readyTime: '00:45',
      actionLabelAr: 'سلم للنادل',
      actionLabelEn: 'Handover to server',
      actionIcon: Icons.room_service_outlined,
      isDelayed: state.issueReported,
      noteAr: state.issueReported ? 'تم الإبلاغ عن مشكلة أثناء التحضير.' : null,
      noteEn: state.issueReported ? 'Issue reported during prep.' : null,
      itemsAr: [
        for (final item in items)
          ModelKitchenReadyItem(quantity: item.quantity, name: item.nameAr),
      ],
      itemsEn: [
        for (final item in items)
          ModelKitchenReadyItem(quantity: item.quantity, name: item.nameEn),
      ],
    );

    if (state.issueReported) {
      state = state.copyWith(
        delayedOrders: [readyOrder, ...state.delayedOrders],
        clearPrep: true,
        checkedPrepIndexes: const {},
        issueReported: false,
      );
    } else {
      state = state.copyWith(
        readyOrders: [readyOrder, ...state.readyOrders],
        clearPrep: true,
        checkedPrepIndexes: const {},
        issueReported: false,
      );
    }
    return true;
  }

  void handoverOrder(String orderId) {
    state = state.copyWith(
      readyOrders:
          state.readyOrders.where((order) => order.id != orderId).toList(),
      delayedOrders:
          state.delayedOrders.where((order) => order.id != orderId).toList(),
    );
  }

  /// Cashier POS handoff — ticket appears on kitchen board immediately.
  void receiveCashierTicket({
    required String orderId,
    required String destinationEn,
    required String destinationAr,
    required List<ModelKitchenReadyItem> itemsEn,
    required List<ModelKitchenReadyItem> itemsAr,
    required String typeKey,
  }) {
    final ticket = ModelKitchenReadyOrder(
      id: orderId,
      destinationAr: destinationAr,
      destinationEn: destinationEn,
      badgeAr: 'كاشير',
      badgeEn: 'POS',
      typeKey: typeKey,
      readyTime: '00:00',
      actionLabelAr: 'ابدأ التحضير',
      actionLabelEn: 'Start prep',
      actionIcon: Icons.soup_kitchen_outlined,
      itemsAr: itemsAr,
      itemsEn: itemsEn,
      noteAr: 'وارد من نقطة البيع',
      noteEn: 'Received from cashier POS',
    );

    // Always surface on the ready board so kitchen can see the handoff.
    if (state.activePrepOrderId == null) {
      state = state.copyWith(
        activePrepOrderId: orderId,
        checkedPrepIndexes: const {},
        prepStartedAt: DateTime.now(),
        readyOrders: [ticket, ...state.readyOrders],
      );
      return;
    }

    state = state.copyWith(readyOrders: [ticket, ...state.readyOrders]);
  }
}

final kitchenBoardProvider =
    StateNotifierProvider<KitchenBoardNotifier, KitchenBoardState>(
      (ref) => KitchenBoardNotifier(),
    );
