/// Staff shift detail row used by front-end mock flows.
class ModelStaffShiftDetail {
  const ModelStaffShiftDetail({
    required this.eyebrowAr,
    required this.eyebrowEn,
    required this.valueAr,
    required this.valueEn,
    required this.iconKey,
    required this.colorKey,
  });

  final String eyebrowAr;
  final String eyebrowEn;
  final String valueAr;
  final String valueEn;
  final String iconKey;
  final String colorKey;
}

class ModelStaffTipShift {
  const ModelStaffTipShift({
    required this.titleAr,
    required this.titleEn,
    required this.timeAr,
    required this.timeEn,
    required this.amountLabelAr,
    required this.amountLabelEn,
    required this.iconKey,
  });

  final String titleAr;
  final String titleEn;
  final String timeAr;
  final String timeEn;
  final String amountLabelAr;
  final String amountLabelEn;
  final String iconKey;
}

class ModelStaffTipTransaction {
  const ModelStaffTipTransaction({
    required this.tagAr,
    required this.tagEn,
    required this.metaAr,
    required this.metaEn,
    required this.amountLabelAr,
    required this.amountLabelEn,
    required this.timeAr,
    required this.timeEn,
    required this.iconKey,
    required this.colorKey,
  });

  final String tagAr;
  final String tagEn;
  final String metaAr;
  final String metaEn;
  final String amountLabelAr;
  final String amountLabelEn;
  final String timeAr;
  final String timeEn;
  final String iconKey;
  final String colorKey;
}

class ModelStaffTipHistory {
  const ModelStaffTipHistory({
    required this.weekKey,
    required this.dateAr,
    required this.dateEn,
    required this.titleAr,
    required this.titleEn,
    required this.timeAr,
    required this.timeEn,
    required this.hoursAr,
    required this.hoursEn,
    required this.tipsAr,
    required this.tipsEn,
    required this.colorKey,
    this.badgeAr,
    this.badgeEn,
  });

  final String weekKey;
  final String dateAr;
  final String dateEn;
  final String titleAr;
  final String titleEn;
  final String timeAr;
  final String timeEn;
  final String hoursAr;
  final String hoursEn;
  final String tipsAr;
  final String tipsEn;
  final String colorKey;
  final String? badgeAr;
  final String? badgeEn;
}
