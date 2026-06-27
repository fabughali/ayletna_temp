/// Plated return pickup task used by front-end mock flows.
class ModelDeliveryReturnTask {
  const ModelDeliveryReturnTask({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.addressAr,
    required this.addressEn,
    required this.statusAr,
    required this.statusEn,
    required this.itemSummaryAr,
    required this.itemSummaryEn,
    required this.iconKey,
    required this.colorKey,
    this.mapFilled = false,
  });

  final String id;

  final String nameAr;
  final String nameEn;
  final String addressAr;
  final String addressEn;
  final String statusAr;
  final String statusEn;
  final String itemSummaryAr;
  final String itemSummaryEn;
  final String iconKey;
  final String colorKey;
  final bool mapFilled;
}
