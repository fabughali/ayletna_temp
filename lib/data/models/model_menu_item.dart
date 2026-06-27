/// Menu product (UI phase).
class ModelMenuItem {
  const ModelMenuItem({
    required this.id,
    required this.categoryId,
    required this.nameAr,
    required this.nameEn,
    required this.priceJod,
    required this.descriptionAr,
    required this.descriptionEn,
    this.imageUrl,
  });

  final String id;
  final String categoryId;
  final String nameAr;
  final String nameEn;
  final double priceJod;
  final String descriptionAr;
  final String descriptionEn;
  final String? imageUrl;

  int get rewardPoints => (priceJod * 10).round();
}
