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
  });

  final String? activePrepOrderId;
  final Set<int> checkedPrepIndexes;
  final List<ModelKitchenReadyOrder> readyOrders;
  final List<ModelKitchenReadyOrder> delayedOrders;
  final bool issueReported;

  int get preparingCount => activePrepOrderId != null ? 1 : 0;

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
    bool clearPrep = false,
  }) {
    return KitchenBoardState(
      activePrepOrderId:
          clearPrep ? null : (activePrepOrderId ?? this.activePrepOrderId),
      checkedPrepIndexes: checkedPrepIndexes ?? this.checkedPrepIndexes,
      readyOrders: readyOrders ?? this.readyOrders,
      delayedOrders: delayedOrders ?? this.delayedOrders,
      issueReported: issueReported ?? this.issueReported,
    );
  }

  factory KitchenBoardState.initial() {
    final catalog = MockupCatalog.kitchenReadyOrders;
    return KitchenBoardState(
      activePrepOrderId: '1086',
      checkedPrepIndexes: const {0, 1},
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
      noteEn:
          state.issueReported ? 'Issue reported during prep.' : null,
      itemsAr: [
        for (final item in items)
          ModelKitchenReadyItem(
            quantity: item.quantity,
            name: item.nameAr,
          ),
      ],
      itemsEn: [
        for (final item in items)
          ModelKitchenReadyItem(
            quantity: item.quantity,
            name: item.nameEn,
          ),
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
}

final kitchenBoardProvider =
    StateNotifierProvider<KitchenBoardNotifier, KitchenBoardState>(
      (ref) => KitchenBoardNotifier(),
    );
