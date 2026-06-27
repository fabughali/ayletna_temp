/// Takeaway pickup mode used by front-end mock flows.
class ModelPickupMode {
  const ModelPickupMode({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.subtitleAr,
    required this.subtitleEn,
    required this.iconKey,
    this.isSelected = false,
  });

  final String id;
  final String titleAr;
  final String titleEn;
  final String subtitleAr;
  final String subtitleEn;
  final String iconKey;
  final bool isSelected;
}
