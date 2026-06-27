/// Payment method option used by checkout and payment mock screens.
class ModelPaymentMethod {
  const ModelPaymentMethod({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.subtitleAr,
    required this.subtitleEn,
    required this.iconKey,
    required this.colorKey,
    this.balanceJod,
  });

  final String id;
  final String titleAr;
  final String titleEn;
  final String subtitleAr;
  final String subtitleEn;
  final String iconKey;
  final String colorKey;
  final double? balanceJod;
}
