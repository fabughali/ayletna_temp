/// Checklist line for a kitchen prep mock order.
class ModelKitchenPrepItem {
  const ModelKitchenPrepItem({
    required this.quantity,
    required this.nameAr,
    required this.nameEn,
    required this.specsAr,
    required this.specsEn,
    this.warningAr,
    this.warningEn,
  });

  final int quantity;
  final String nameAr;
  final String nameEn;
  final String specsAr;
  final String specsEn;
  final String? warningAr;
  final String? warningEn;
}
