/// Reward item used by customer loyalty and rewards mock screens.
class ModelCustomerReward {
  const ModelCustomerReward({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.points,
    required this.categoryKey,
    required this.artKey,
    required this.colorKey,
    this.badgeAr,
    this.badgeEn,
    this.isPopular = false,
    this.isLocked = false,
    this.isSoldOut = false,
  });

  final String id;
  final String titleAr;
  final String titleEn;
  final String descriptionAr;
  final String descriptionEn;
  final int points;
  final String categoryKey;
  final String artKey;
  final String colorKey;
  final String? badgeAr;
  final String? badgeEn;
  final bool isPopular;
  final bool isLocked;
  final bool isSoldOut;
}
