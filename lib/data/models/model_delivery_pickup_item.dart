/// Delivery pickup checklist line used by front-end mock flows.
class ModelDeliveryPickupItem {
  const ModelDeliveryPickupItem({
    required this.titleAr,
    required this.titleEn,
    required this.subtitleAr,
    required this.subtitleEn,
    required this.quantity,
  });

  final String titleAr;
  final String titleEn;
  final String subtitleAr;
  final String subtitleEn;
  final int quantity;
}
