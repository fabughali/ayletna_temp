/// Notification category summary used by front-end mock flows.
class ModelCustomerNotificationCategory {
  const ModelCustomerNotificationCategory({
    required this.id,
    required this.labelAr,
    required this.labelEn,
    required this.count,
    required this.iconKey,
    required this.colorKey,
    this.isSelected = false,
  });

  final String id;
  final String labelAr;
  final String labelEn;
  final int count;
  final String iconKey;
  final String colorKey;
  final bool isSelected;
}
