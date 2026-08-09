/// Low stock alert used by inventory mock screens.
class ModelInventoryAlert {
  const ModelInventoryAlert({
    required this.categoryAr,
    required this.categoryEn,
    required this.nameAr,
    required this.nameEn,
    required this.remainingAr,
    required this.remainingEn,
    required this.detailAr,
    required this.detailEn,
  });

  final String categoryAr;
  final String categoryEn;
  final String nameAr;
  final String nameEn;
  final String remainingAr;
  final String remainingEn;
  final String detailAr;
  final String detailEn;
}

class ModelInventoryLevel {
  const ModelInventoryLevel({
    required this.nameAr,
    required this.nameEn,
    required this.percent,
    required this.capacity,
    required this.colorKey,
  });

  final String nameAr;
  final String nameEn;
  final int percent;
  final String capacity;
  final String colorKey;
}

class ModelInventoryStorageStatus {
  const ModelInventoryStorageStatus({
    required this.nameAr,
    required this.nameEn,
    required this.statusAr,
    required this.statusEn,
    this.hasAlert = false,
  });

  final String nameAr;
  final String nameEn;
  final String statusAr;
  final String statusEn;
  final bool hasAlert;
}

class ModelInventoryWastageLog {
  const ModelInventoryWastageLog({
    required this.itemAr,
    required this.itemEn,
    required this.quantityAr,
    required this.quantityEn,
    required this.reasonAr,
    required this.reasonEn,
    required this.valueLostJod,
    required this.time,
    required this.userAr,
    required this.userEn,
  });

  final String itemAr;
  final String itemEn;
  final String quantityAr;
  final String quantityEn;
  final String reasonAr;
  final String reasonEn;
  final double valueLostJod;
  final String time;
  final String userAr;
  final String userEn;
}

class ModelInventoryAuditRow {
  const ModelInventoryAuditRow({
    required this.dateAr,
    required this.dateEn,
    required this.typeAr,
    required this.typeEn,
    required this.userAr,
    required this.userEn,
    required this.amountAr,
    required this.amountEn,
    required this.balanceAr,
    required this.balanceEn,
    this.isNegative = false,
    this.evidenceKey,
  });

  final String dateAr;
  final String dateEn;
  final String typeAr;
  final String typeEn;
  final String userAr;
  final String userEn;
  final String amountAr;
  final String amountEn;
  final String balanceAr;
  final String balanceEn;
  final bool isNegative;
  final String? evidenceKey;
}
