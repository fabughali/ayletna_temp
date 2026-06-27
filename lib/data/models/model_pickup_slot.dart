/// Takeaway pickup day/slot option used by front-end mock flows.
class ModelPickupSlot {
  const ModelPickupSlot({
    required this.id,
    required this.labelAr,
    required this.labelEn,
    this.isSelected = false,
    this.isDisabled = false,
    this.trailingAr,
    this.trailingEn,
  });

  final String id;
  final String labelAr;
  final String labelEn;
  final bool isSelected;
  final bool isDisabled;
  final String? trailingAr;
  final String? trailingEn;
}
