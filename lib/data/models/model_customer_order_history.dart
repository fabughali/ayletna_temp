/// Customer order history row used by front-end mock flows.
class ModelCustomerOrderHistory {
  const ModelCustomerOrderHistory({
    required this.id,
    required this.labelAr,
    required this.labelEn,
    required this.dateAr,
    required this.dateEn,
    required this.totalJod,
    required this.itemsAr,
    required this.itemsEn,
    this.isCancelled = false,
    this.isActive = false,
    this.currentStepIndex = 0,
    this.driverPhone,
    this.metaAr,
    this.metaEn,
  });

  final String id;
  final String labelAr;
  final String labelEn;
  final String dateAr;
  final String dateEn;
  final double totalJod;
  final List<String> itemsAr;
  final List<String> itemsEn;
  final bool isCancelled;
  final bool isActive;
  final int currentStepIndex;
  final String? driverPhone;
  final String? metaAr;
  final String? metaEn;
}
