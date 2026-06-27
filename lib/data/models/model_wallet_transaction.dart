/// Customer wallet transaction used by front-end mock flows.
class ModelWalletTransaction {
  const ModelWalletTransaction({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.metaAr,
    required this.metaEn,
    required this.amountLabelAr,
    required this.amountLabelEn,
    required this.detailAr,
    required this.detailEn,
    required this.iconKey,
    required this.colorKey,
    required this.isPositive,
  });

  final String id;
  final String titleAr;
  final String titleEn;
  final String metaAr;
  final String metaEn;
  final String amountLabelAr;
  final String amountLabelEn;
  final String detailAr;
  final String detailEn;
  final String iconKey;
  final String colorKey;
  final bool isPositive;
}
