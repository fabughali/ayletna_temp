import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LoyaltyOccasionKey { birthday, christmas, newYear, custom }

class LoyaltyOccasionReward {
  const LoyaltyOccasionReward({
    required this.id,
    required this.key,
    required this.titleEn,
    required this.titleAr,
    required this.rewardTitleEn,
    required this.rewardTitleAr,
    required this.pointsGrant,
    this.active = true,
  });

  final String id;
  final LoyaltyOccasionKey key;
  final String titleEn;
  final String titleAr;
  final String rewardTitleEn;
  final String rewardTitleAr;
  final int pointsGrant;
  final bool active;

  LoyaltyOccasionReward copyWith({
    String? id,
    LoyaltyOccasionKey? key,
    String? titleEn,
    String? titleAr,
    String? rewardTitleEn,
    String? rewardTitleAr,
    int? pointsGrant,
    bool? active,
  }) {
    return LoyaltyOccasionReward(
      id: id ?? this.id,
      key: key ?? this.key,
      titleEn: titleEn ?? this.titleEn,
      titleAr: titleAr ?? this.titleAr,
      rewardTitleEn: rewardTitleEn ?? this.rewardTitleEn,
      rewardTitleAr: rewardTitleAr ?? this.rewardTitleAr,
      pointsGrant: pointsGrant ?? this.pointsGrant,
      active: active ?? this.active,
    );
  }

  String title(bool isAr) => isAr ? titleAr : titleEn;
  String rewardTitle(bool isAr) => isAr ? rewardTitleAr : rewardTitleEn;
}

class LoyaltyOccasionNotifier
    extends StateNotifier<List<LoyaltyOccasionReward>> {
  LoyaltyOccasionNotifier()
    : super(const [
        LoyaltyOccasionReward(
          id: 'occ_birthday',
          key: LoyaltyOccasionKey.birthday,
          titleEn: 'Birthday',
          titleAr: 'عيد الميلاد',
          rewardTitleEn: 'Birthday dessert',
          rewardTitleAr: 'حلوى عيد الميلاد',
          pointsGrant: 50,
        ),
        LoyaltyOccasionReward(
          id: 'occ_christmas',
          key: LoyaltyOccasionKey.christmas,
          titleEn: 'Christmas',
          titleAr: 'عيد الميلاد المجيد',
          rewardTitleEn: 'Holiday treat',
          rewardTitleAr: 'هدية العيد',
          pointsGrant: 40,
        ),
        LoyaltyOccasionReward(
          id: 'occ_new_year',
          key: LoyaltyOccasionKey.newYear,
          titleEn: 'New Year',
          titleAr: 'رأس السنة',
          rewardTitleEn: 'New Year bonus',
          rewardTitleAr: 'مكافأة رأس السنة',
          pointsGrant: 60,
        ),
      ]);

  void upsert(LoyaltyOccasionReward occasion) {
    final index = state.indexWhere((o) => o.id == occasion.id);
    if (index == -1) {
      state = [...state, occasion];
      return;
    }
    final next = [...state]..[index] = occasion;
    state = next;
  }

  void setActive(String id, bool active) {
    state = [
      for (final o in state)
        if (o.id == id) o.copyWith(active: active) else o,
    ];
  }

  void remove(String id) {
    state = state.where((o) => o.id != id).toList();
  }
}

final loyaltyOccasionsProvider =
    StateNotifierProvider<LoyaltyOccasionNotifier, List<LoyaltyOccasionReward>>(
      (ref) => LoyaltyOccasionNotifier(),
    );

final activeLoyaltyOccasionsProvider = Provider<List<LoyaltyOccasionReward>>((
  ref,
) {
  return ref.watch(loyaltyOccasionsProvider).where((o) => o.active).toList();
});
