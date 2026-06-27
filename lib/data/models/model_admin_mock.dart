/// Admin team member row used by front-end mock flows.
class ModelAdminTeamMember {
  const ModelAdminTeamMember({
    required this.nameAr,
    required this.nameEn,
    required this.roleAr,
    required this.roleEn,
    required this.email,
    required this.shiftAr,
    required this.shiftEn,
    required this.colorKey,
    required this.iconKey,
    this.active = true,
  });

  final String nameAr;
  final String nameEn;
  final String roleAr;
  final String roleEn;
  final String email;
  final String shiftAr;
  final String shiftEn;
  final String colorKey;
  final String iconKey;
  final bool active;
}

class ModelAdminMenuItem {
  const ModelAdminMenuItem({
    required this.titleAr,
    required this.titleEn,
    required this.subtitleAr,
    required this.subtitleEn,
    required this.priceLabel,
    required this.typeKey,
    required this.stockKey,
    required this.iconKey,
    this.active = true,
  });

  final String titleAr;
  final String titleEn;
  final String subtitleAr;
  final String subtitleEn;
  final String priceLabel;
  final String typeKey;
  final String stockKey;
  final String iconKey;
  final bool active;
}

class ModelAdminPlateAsset {
  const ModelAdminPlateAsset({
    required this.titleAr,
    required this.titleEn,
    required this.sku,
    required this.badgeKey,
    required this.priceJod,
    required this.stock,
    required this.circulating,
    required this.painterKey,
  });

  final String titleAr;
  final String titleEn;
  final String sku;
  final String badgeKey;
  final double priceJod;
  final int stock;
  final int circulating;
  final String painterKey;
}

class ModelAdminBreakageReport {
  const ModelAdminBreakageReport({
    required this.titleAr,
    required this.titleEn,
    required this.metaAr,
    required this.metaEn,
    required this.lossJod,
    required this.timeAr,
    required this.timeEn,
  });

  final String titleAr;
  final String titleEn;
  final String metaAr;
  final String metaEn;
  final double lossJod;
  final String timeAr;
  final String timeEn;
}

class ModelAdminTipDistributionRow {
  const ModelAdminTipDistributionRow({
    required this.initials,
    required this.name,
    required this.orderId,
    required this.role,
    required this.hours,
    required this.tipShareJod,
  });

  final String initials;
  final String name;
  final String orderId;
  final String role;
  final double hours;
  final double tipShareJod;
}
