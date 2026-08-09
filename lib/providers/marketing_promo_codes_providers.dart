import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MarketingPromoCodeCategory {
  discount,
  addPoints,
  freeMeal,
  inviteFriends,
}

class MarketingPromoCode {
  const MarketingPromoCode({
    required this.id,
    required this.code,
    required this.category,
    this.active = true,
  });

  final String id;
  final String code;
  final MarketingPromoCodeCategory category;
  final bool active;

  MarketingPromoCode copyWith({
    String? code,
    MarketingPromoCodeCategory? category,
    bool? active,
  }) {
    return MarketingPromoCode(
      id: id,
      code: code ?? this.code,
      category: category ?? this.category,
      active: active ?? this.active,
    );
  }
}

class MarketingPromoCodesNotifier
    extends StateNotifier<List<MarketingPromoCode>> {
  MarketingPromoCodesNotifier()
    : super(const [
        MarketingPromoCode(
          id: 'promo-1',
          code: 'FRIENDS10',
          category: MarketingPromoCodeCategory.inviteFriends,
        ),
        MarketingPromoCode(
          id: 'promo-2',
          code: 'POINTS50',
          category: MarketingPromoCodeCategory.addPoints,
        ),
      ]);

  void add(MarketingPromoCode code) {
    if (code.code.trim().isEmpty) return;
    state = [code, ...state];
  }

  void update(MarketingPromoCode code) {
    state = [
      for (final item in state)
        if (item.id == code.id) code else item,
    ];
  }

  void remove(String id) {
    state = state.where((e) => e.id != id).toList();
  }
}

final marketingPromoCodesProvider = StateNotifierProvider<
  MarketingPromoCodesNotifier,
  List<MarketingPromoCode>
>((ref) => MarketingPromoCodesNotifier());
