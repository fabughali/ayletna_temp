import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_customer_reward.dart';
import 'package:ayletna_restaurant_app/providers/customer_action_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RewardsCatalogState {
  const RewardsCatalogState({
    this.rewards = const [],
    this.pointsPerJod = 1.5,
    this.tiers = const [
      LoyaltyPointsTier(
        id: 'tier_starter',
        minPoints: 0,
        maxPoints: 99,
        earnPerJod: 1.0,
        redeemFactor: 1.0,
      ),
      LoyaltyPointsTier(
        id: 'tier_regular',
        minPoints: 100,
        maxPoints: 299,
        earnPerJod: 1.5,
        redeemFactor: 0.9,
      ),
      LoyaltyPointsTier(
        id: 'tier_gold',
        minPoints: 300,
        maxPoints: null,
        earnPerJod: 2.0,
        redeemFactor: 0.8,
      ),
    ],
  });

  final List<ModelCustomerReward> rewards;

  /// Legacy single rate — kept as fallback; prefer [earnRateForBalance].
  final double pointsPerJod;
  final List<LoyaltyPointsTier> tiers;

  double earnRateForBalance(int balance) {
    for (final tier in tiers) {
      if (tier.contains(balance)) return tier.earnPerJod;
    }
    return pointsPerJod;
  }

  double redeemFactorForBalance(int balance) {
    for (final tier in tiers) {
      if (tier.contains(balance)) return tier.redeemFactor;
    }
    return 1.0;
  }

  RewardsCatalogState copyWith({
    List<ModelCustomerReward>? rewards,
    double? pointsPerJod,
    List<LoyaltyPointsTier>? tiers,
  }) {
    return RewardsCatalogState(
      rewards: rewards ?? this.rewards,
      pointsPerJod: pointsPerJod ?? this.pointsPerJod,
      tiers: tiers ?? this.tiers,
    );
  }
}

class LoyaltyPointsTier {
  const LoyaltyPointsTier({
    required this.id,
    required this.minPoints,
    required this.maxPoints,
    required this.earnPerJod,
    required this.redeemFactor,
  });

  final String id;
  final int minPoints;
  final int? maxPoints;
  final double earnPerJod;

  /// Multiplier on catalog reward points cost (lower = cheaper redeem).
  final double redeemFactor;

  bool contains(int balance) {
    if (balance < minPoints) return false;
    if (maxPoints == null) return true;
    return balance <= maxPoints!;
  }

  LoyaltyPointsTier copyWith({
    String? id,
    int? minPoints,
    int? maxPoints,
    bool clearMax = false,
    double? earnPerJod,
    double? redeemFactor,
  }) {
    return LoyaltyPointsTier(
      id: id ?? this.id,
      minPoints: minPoints ?? this.minPoints,
      maxPoints: clearMax ? null : (maxPoints ?? this.maxPoints),
      earnPerJod: earnPerJod ?? this.earnPerJod,
      redeemFactor: redeemFactor ?? this.redeemFactor,
    );
  }
}

class RewardsCatalogNotifier extends StateNotifier<RewardsCatalogState> {
  RewardsCatalogNotifier()
    : super(
        RewardsCatalogState(
          rewards: List<ModelCustomerReward>.from(
            MockupCatalog.customerRewards,
          ),
        ),
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

  void upsertTier(LoyaltyPointsTier tier) {
    final index = state.tiers.indexWhere((t) => t.id == tier.id);
    if (index == -1) {
      state = state.copyWith(tiers: [...state.tiers, tier]);
      return;
    }
    final next = [...state.tiers]..[index] = tier;
    state = state.copyWith(tiers: next);
  }

  void removeTier(String id) {
    if (state.tiers.length <= 1) return;
    state = state.copyWith(
      tiers: state.tiers.where((t) => t.id != id).toList(),
    );
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
  const LoyaltyPointsState({this.balance = 420, this.transactions = const []});

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

final loyaltyTransactionsProvider = Provider<List<LoyaltyTransactionRecord>>((
  ref,
) {
  return ref.watch(loyaltyPointsProvider).transactions;
});
