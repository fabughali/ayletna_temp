import 'package:ayletna_restaurant_app/data/models/model_customer_reward.dart';
import 'package:ayletna_restaurant_app/data/models/model_cart_line.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartNotifier extends StateNotifier<List<ModelCartLine>> {
  CartNotifier() : super(const []);

  void addItem(ModelMenuItem item) {
    _upsertLine(MockupCatalog.lineFromItem(item));
  }

  void addConfiguredItem({
    required ModelMenuItem item,
    required int quantity,
    required double unitPriceJod,
    String? configurationKey,
    String? configurationAr,
    String? configurationEn,
    String? remarks,
  }) {
    _upsertLine(
      ModelCartLine(
        itemId: item.id,
        nameAr: item.nameAr,
        nameEn: item.nameEn,
        unitPriceJod: unitPriceJod,
        quantity: quantity,
        configurationKey: configurationKey,
        configurationAr: configurationAr,
        configurationEn: configurationEn,
        remarks: remarks,
      ),
    );
  }

  void _upsertLine(ModelCartLine line) {
    final idx = state.indexWhere((l) => l.cartKey == line.cartKey);
    if (idx >= 0) {
      final updated = [...state];
      updated[idx] = updated[idx].copyWith(
        quantity: updated[idx].quantity + line.quantity,
        unitPriceJod: line.unitPriceJod,
        configurationKey: line.configurationKey,
        configurationAr: line.configurationAr,
        configurationEn: line.configurationEn,
        remarks: line.remarks,
      );
      state = updated;
    } else {
      state = [...state, line];
    }
  }

  void setQuantity(String lineKey, int quantity) {
    if (quantity <= 0) {
      removeItem(lineKey);
      return;
    }
    state = [
      for (final line in state)
        if (line.cartKey == lineKey || line.itemId == lineKey)
          line.copyWith(quantity: quantity)
        else
          line,
    ];
  }

  void removeItem(String lineKey) {
    state =
        state
            .where((line) => line.cartKey != lineKey && line.itemId != lineKey)
            .toList();
  }

  void addRewardLine(ModelCustomerReward reward) {
    _upsertLine(
      ModelCartLine(
        itemId: 'reward_${reward.id}',
        nameAr: reward.titleAr,
        nameEn: reward.titleEn,
        unitPriceJod: 0,
        quantity: 1,
        configurationKey: 'loyalty_reward',
        configurationAr: 'مكافأة ولاء · ${reward.points} نقطة',
        configurationEn: 'Loyalty reward · ${reward.points} pts',
      ),
    );
  }

  void clear() => state = [];

  void replaceAll(List<ModelCartLine> lines) => state = [...lines];

  double get subtotalJod =>
      state.fold(0, (sum, line) => sum + line.lineTotalJod);
}

final cartProvider = StateNotifierProvider<CartNotifier, List<ModelCartLine>>((
  ref,
) {
  return CartNotifier();
});

final cartSubtotalProvider = Provider<double>((ref) {
  final lines = ref.watch(cartProvider);
  return lines.fold(0.0, (sum, line) => sum + line.lineTotalJod);
});
