/// Cart line (UI phase).
class ModelCartLine {
  const ModelCartLine({
    required this.itemId,
    required this.nameAr,
    required this.nameEn,
    required this.unitPriceJod,
    required this.quantity,
    this.configurationKey,
    this.configurationAr,
    this.configurationEn,
    this.remarks,
  });

  final String itemId;
  final String nameAr;
  final String nameEn;
  final double unitPriceJod;
  final int quantity;
  final String? configurationKey;
  final String? configurationAr;
  final String? configurationEn;
  final String? remarks;

  String get cartKey =>
      configurationKey == null ? itemId : '$itemId::$configurationKey';
  double get lineTotalJod => unitPriceJod * quantity;

  ModelCartLine copyWith({
    int? quantity,
    double? unitPriceJod,
    String? configurationKey,
    String? configurationAr,
    String? configurationEn,
    String? remarks,
  }) {
    return ModelCartLine(
      itemId: itemId,
      nameAr: nameAr,
      nameEn: nameEn,
      unitPriceJod: unitPriceJod ?? this.unitPriceJod,
      quantity: quantity ?? this.quantity,
      configurationKey: configurationKey ?? this.configurationKey,
      configurationAr: configurationAr ?? this.configurationAr,
      configurationEn: configurationEn ?? this.configurationEn,
      remarks: remarks ?? this.remarks,
    );
  }
}
