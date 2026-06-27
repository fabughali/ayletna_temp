import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_customer_reward.dart';
import 'package:ayletna_restaurant_app/providers/customer_action_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RewardsCatalogState {
  const RewardsCatalogState({this.rewards = const [], this.pointsPerJod = 1.5});

  final List<ModelCustomerReward> rewards;
  final double pointsPerJod;

  RewardsCatalogState copyWith({
    List<ModelCustomerReward>? rewards,
    double? pointsPerJod,
  }) {
    return RewardsCatalogState(
      rewards: rewards ?? this.rewards,
      pointsPerJod: pointsPerJod ?? this.pointsPerJod,
    );
  }
}

class RewardsCatalogNotifier extends StateNotifier<RewardsCatalogState> {
  RewardsCatalogNotifier()
    : super(
        RewardsCatalogState(rewards: List<ModelCustomerReward>.from(
          MockupCatalog.customerRewards,
        )),
      );

  bool addReward(ModelCustomerReward reward) {
    if (reward.titleEn.trim().isEmpty || reward.points <= 0) return false;
    state = state.copyWith(rewards: [...state.rewards, reward]);
    return true;
  }

  bool updateReward(ModelCustomerReward reward) {
    final index = state.rewards.indexWhere((r) => r.id == reward.id);
    if (index == -1) return false;
    final next = [...state.rewards]..[index] = reward;
    state = state.copyWith(rewards: next);
    return true;
  }

  bool removeReward(String id) {
    state = state.copyWith(
      rewards: state.rewards.where((r) => r.id != id).toList(),
    );
    return true;
  }

  void setPointsPerJod(double value) {
    state = state.copyWith(pointsPerJod: value);
  }
}

final rewardsCatalogProvider =
    StateNotifierProvider<RewardsCatalogNotifier, RewardsCatalogState>(
      (ref) => RewardsCatalogNotifier(),
    );

final activeRewardsProvider = Provider<List<ModelCustomerReward>>((ref) {
  return ref
      .watch(rewardsCatalogProvider)
      .rewards
      .where((r) => !r.isSoldOut)
      .toList();
});

final selectedRewardProvider = Provider<ModelCustomerReward?>((ref) {
  final id = ref.watch(selectedRewardIdProvider);
  if (id == null) return null;
  for (final reward in ref.watch(activeRewardsProvider)) {
    if (reward.id == id) return reward;
  }
  return null;
});

class LoyaltyPointsState {
  const LoyaltyPointsState({
    this.balance = 420,
    this.transactions = const [],
  });

  final int balance;
  final List<LoyaltyTransactionRecord> transactions;

  LoyaltyPointsState copyWith({
    int? balance,
    List<LoyaltyTransactionRecord>? transactions,
  }) {
    return LoyaltyPointsState(
      balance: balance ?? this.balance,
      transactions: transactions ?? this.transactions,
    );
  }
}

class LoyaltyTransactionRecord {
  const LoyaltyTransactionRecord({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.pointsDelta,
    required this.occurredAt,
  });

  final String id;
  final String titleEn;
  final String titleAr;
  final int pointsDelta;
  final DateTime occurredAt;
}

int _loyaltyTxSeq = 1;

class LoyaltyPointsNotifier extends StateNotifier<LoyaltyPointsState> {
  LoyaltyPointsNotifier() : super(const LoyaltyPointsState());

  void _appendTransaction({
    required String titleEn,
    required String titleAr,
    required int pointsDelta,
  }) {
    final tx = LoyaltyTransactionRecord(
      id: 'ltx_${_loyaltyTxSeq++}',
      titleEn: titleEn,
      titleAr: titleAr,
      pointsDelta: pointsDelta,
      occurredAt: DateTime.now(),
    );
    state = state.copyWith(transactions: [tx, ...state.transactions]);
  }

  bool redeem(int points, {String? rewardTitleEn, String? rewardTitleAr}) {
    if (points <= 0 || points > state.balance) return false;
    state = state.copyWith(balance: state.balance - points);
    _appendTransaction(
      titleEn: rewardTitleEn ?? 'Reward redeemed',
      titleAr: rewardTitleAr ?? 'استبدال مكافأة',
      pointsDelta: -points,
    );
    return true;
  }

  void addPoints(int points, {String? titleEn, String? titleAr}) {
    if (points <= 0) return;
    state = state.copyWith(balance: state.balance + points);
    _appendTransaction(
      titleEn: titleEn ?? 'Points earned',
      titleAr: titleAr ?? 'نقاط مكتسبة',
      pointsDelta: points,
    );
  }
}

final loyaltyPointsProvider =
    StateNotifierProvider<LoyaltyPointsNotifier, LoyaltyPointsState>(
      (ref) => LoyaltyPointsNotifier(),
    );

final loyaltyTransactionsProvider = Provider<List<LoyaltyTransactionRecord>>((ref) {
  return ref.watch(loyaltyPointsProvider).transactions;
});
