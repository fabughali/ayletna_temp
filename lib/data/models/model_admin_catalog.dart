/// Menu addon / modifier managed by admin.
class ModelMenuAddon {
  const ModelMenuAddon({
    required this.id,
    required this.key,
    required this.labelAr,
    required this.labelEn,
    required this.priceDeltaJod,
    this.imageUrl,
  });

  final String id;
  final String key;
  final String labelAr;
  final String labelEn;
  final double priceDeltaJod;

  /// Single required image for add-on display.
  final String? imageUrl;

  ModelMenuAddon copyWith({
    String? id,
    String? key,
    String? labelAr,
    String? labelEn,
    double? priceDeltaJod,
    String? imageUrl,
  }) {
    return ModelMenuAddon(
      id: id ?? this.id,
      key: key ?? this.key,
      labelAr: labelAr ?? this.labelAr,
      labelEn: labelEn ?? this.labelEn,
      priceDeltaJod: priceDeltaJod ?? this.priceDeltaJod,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

/// Explicit related-product links for a menu item.
class ModelRelatedProductLink {
  const ModelRelatedProductLink({
    required this.productId,
    required this.relatedProductIds,
  });

  final String productId;
  final List<String> relatedProductIds;

  ModelRelatedProductLink copyWith({
    String? productId,
    List<String>? relatedProductIds,
  }) {
    return ModelRelatedProductLink(
      productId: productId ?? this.productId,
      relatedProductIds: relatedProductIds ?? this.relatedProductIds,
    );
  }
}

/// Per-product attachment of a global add-on with free/price override.
class ModelProductAddonAttachment {
  const ModelProductAddonAttachment({
    required this.addonId,
    this.isFree = false,
    this.priceOverrideJod,
  });

  final String addonId;
  final bool isFree;
  final double? priceOverrideJod;

  double resolvedPriceDelta(ModelMenuAddon addon) {
    if (isFree) return 0;
    return priceOverrideJod ?? addon.priceDeltaJod;
  }

  ModelProductAddonAttachment copyWith({
    String? addonId,
    bool? isFree,
    double? priceOverrideJod,
    bool clearPriceOverride = false,
  }) {
    return ModelProductAddonAttachment(
      addonId: addonId ?? this.addonId,
      isFree: isFree ?? this.isFree,
      priceOverrideJod:
          clearPriceOverride
              ? null
              : (priceOverrideJod ?? this.priceOverrideJod),
    );
  }
}

/// Combo bundle created by admin.
class ModelCatalogCombo {
  const ModelCatalogCombo({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.priceJod,
    this.subtitleAr,
    this.subtitleEn,
    this.itemIds = const [],
    this.discountPercent = 12,
    this.imageUrls = const [],
    this.isAvailable = true,
    this.isPopular = false,
    this.sortOrder = 0,
    this.activePeriodStart,
    this.activePeriodEnd,
    this.rewardPoints = 0,
    this.campaignId,
  });

  final String id;
  final String titleAr;
  final String titleEn;
  final String? subtitleAr;
  final String? subtitleEn;
  final double priceJod;
  final List<String> itemIds;
  final double discountPercent;

  /// One to five gallery images.
  final List<String> imageUrls;

  final bool isAvailable;
  final bool isPopular;
  final int sortOrder;
  final DateTime? activePeriodStart;
  final DateTime? activePeriodEnd;

  /// Loyalty points granted on purchase (not a catalog reward link).
  final int rewardPoints;
  final String? campaignId;

  String? get primaryImageUrl =>
      imageUrls.isNotEmpty ? imageUrls.first : null;

  ModelCatalogCombo copyWith({
    String? id,
    String? titleAr,
    String? titleEn,
    String? subtitleAr,
    String? subtitleEn,
    double? priceJod,
    List<String>? itemIds,
    double? discountPercent,
    List<String>? imageUrls,
    bool? isAvailable,
    bool? isPopular,
    int? sortOrder,
    DateTime? activePeriodStart,
    DateTime? activePeriodEnd,
    int? rewardPoints,
    String? campaignId,
    bool clearCampaignId = false,
  }) {
    return ModelCatalogCombo(
      id: id ?? this.id,
      titleAr: titleAr ?? this.titleAr,
      titleEn: titleEn ?? this.titleEn,
      subtitleAr: subtitleAr ?? this.subtitleAr,
      subtitleEn: subtitleEn ?? this.subtitleEn,
      priceJod: priceJod ?? this.priceJod,
      itemIds: itemIds ?? this.itemIds,
      discountPercent: discountPercent ?? this.discountPercent,
      imageUrls: imageUrls ?? this.imageUrls,
      isAvailable: isAvailable ?? this.isAvailable,
      isPopular: isPopular ?? this.isPopular,
      sortOrder: sortOrder ?? this.sortOrder,
      activePeriodStart: activePeriodStart ?? this.activePeriodStart,
      activePeriodEnd: activePeriodEnd ?? this.activePeriodEnd,
      rewardPoints: rewardPoints ?? this.rewardPoints,
      campaignId: clearCampaignId ? null : (campaignId ?? this.campaignId),
    );
  }
}

/// Discount applied to a single menu item.
class ModelCatalogDiscount {
  const ModelCatalogDiscount({
    required this.id,
    required this.menuItemId,
    required this.percentOff,
    this.labelAr,
    this.labelEn,
    this.active = true,
    this.rewardPoints = 0,
    this.campaignId,
  });

  final String id;
  final String menuItemId;
  final double percentOff;
  final String? labelAr;
  final String? labelEn;
  final bool active;
  final int rewardPoints;
  final String? campaignId;

  ModelCatalogDiscount copyWith({
    String? id,
    String? menuItemId,
    double? percentOff,
    String? labelAr,
    String? labelEn,
    bool? active,
    int? rewardPoints,
    String? campaignId,
    bool clearCampaignId = false,
  }) {
    return ModelCatalogDiscount(
      id: id ?? this.id,
      menuItemId: menuItemId ?? this.menuItemId,
      percentOff: percentOff ?? this.percentOff,
      labelAr: labelAr ?? this.labelAr,
      labelEn: labelEn ?? this.labelEn,
      active: active ?? this.active,
      rewardPoints: rewardPoints ?? this.rewardPoints,
      campaignId: clearCampaignId ? null : (campaignId ?? this.campaignId),
    );
  }
}

/// Home / offers-section promotion.
class ModelCatalogOffer {
  const ModelCatalogOffer({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    this.subtitleAr,
    this.subtitleEn,
    this.active = true,
    this.imageUrls = const [],
    this.badgeAr,
    this.badgeEn,
    this.promoCode,
    this.discountPercent,
    this.rewardPoints = 0,
    this.campaignId,
  });

  final String id;
  final String titleAr;
  final String titleEn;
  final String? subtitleAr;
  final String? subtitleEn;
  final bool active;

  /// One to five gallery images.
  final List<String> imageUrls;

  final String? badgeAr;
  final String? badgeEn;
  final String? promoCode;
  final double? discountPercent;

  /// Loyalty points granted on purchase (not a catalog reward link).
  final int rewardPoints;
  final String? campaignId;

  String? get primaryImageUrl =>
      imageUrls.isNotEmpty ? imageUrls.first : null;

  ModelCatalogOffer copyWith({
    String? id,
    String? titleAr,
    String? titleEn,
    String? subtitleAr,
    String? subtitleEn,
    bool? active,
    List<String>? imageUrls,
    String? badgeAr,
    String? badgeEn,
    String? promoCode,
    double? discountPercent,
    int? rewardPoints,
    String? campaignId,
    bool clearPromoCode = false,
    bool clearDiscountPercent = false,
    bool clearCampaignId = false,
  }) {
    return ModelCatalogOffer(
      id: id ?? this.id,
      titleAr: titleAr ?? this.titleAr,
      titleEn: titleEn ?? this.titleEn,
      subtitleAr: subtitleAr ?? this.subtitleAr,
      subtitleEn: subtitleEn ?? this.subtitleEn,
      active: active ?? this.active,
      imageUrls: imageUrls ?? this.imageUrls,
      badgeAr: badgeAr ?? this.badgeAr,
      badgeEn: badgeEn ?? this.badgeEn,
      promoCode: clearPromoCode ? null : (promoCode ?? this.promoCode),
      discountPercent:
          clearDiscountPercent
              ? null
              : (discountPercent ?? this.discountPercent),
      rewardPoints: rewardPoints ?? this.rewardPoints,
      campaignId: clearCampaignId ? null : (campaignId ?? this.campaignId),
    );
  }
}

/// Subscription meal plan with per-day menu assignments (weekly=7, monthly=30).
class ModelSubscriptionDayPlan {
  const ModelSubscriptionDayPlan({
    required this.dayIndex,
    this.menuItemIds = const [],
  });

  /// 1-based day within the billing period.
  final int dayIndex;
  final List<String> menuItemIds;

  ModelSubscriptionDayPlan copyWith({
    int? dayIndex,
    List<String>? menuItemIds,
  }) {
    return ModelSubscriptionDayPlan(
      dayIndex: dayIndex ?? this.dayIndex,
      menuItemIds: menuItemIds ?? this.menuItemIds,
    );
  }
}

/// Subscription meal plan for marketing + customer surfaces.
class ModelSubscriptionMeal {
  const ModelSubscriptionMeal({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.priceJod,
    this.menuItemId = '',
    this.billingPeriod = 'monthly',
    this.imageUrls = const [],
    this.isAvailable = true,
    this.sortOrder = 0,
    this.dayPlans = const [],
    this.freeDelivery = false,
    this.campaignId,
  });

  final String id;

  /// Legacy primary item id (first assigned meal when present).
  final String menuItemId;
  final String titleAr;
  final String titleEn;

  /// Subscription package price (what customer pays).
  final double priceJod;
  final String billingPeriod;

  /// One to five gallery images.
  final List<String> imageUrls;

  final bool isAvailable;
  final int sortOrder;
  final List<ModelSubscriptionDayPlan> dayPlans;
  final bool freeDelivery;
  final String? campaignId;

  String? get primaryImageUrl =>
      imageUrls.isNotEmpty ? imageUrls.first : null;

  int get periodDays => billingPeriod == 'weekly' ? 7 : 30;

  int get totalMealCount =>
      dayPlans.fold<int>(0, (sum, d) => sum + d.menuItemIds.length);

  int get coveredDayCount =>
      dayPlans.where((d) => d.menuItemIds.isNotEmpty).length;

  bool get hasUncoveredDays => coveredDayCount < periodDays;

  List<ModelSubscriptionDayPlan> normalizedDayPlans() {
    final byDay = <int, ModelSubscriptionDayPlan>{
      for (final d in dayPlans) d.dayIndex: d,
    };
    return [
      for (var day = 1; day <= periodDays; day++)
        byDay[day] ?? ModelSubscriptionDayPlan(dayIndex: day),
    ];
  }

  ModelSubscriptionMeal copyWith({
    String? id,
    String? menuItemId,
    String? titleAr,
    String? titleEn,
    double? priceJod,
    String? billingPeriod,
    List<String>? imageUrls,
    bool? isAvailable,
    int? sortOrder,
    List<ModelSubscriptionDayPlan>? dayPlans,
    bool? freeDelivery,
    String? campaignId,
    bool clearCampaignId = false,
  }) {
    return ModelSubscriptionMeal(
      id: id ?? this.id,
      menuItemId: menuItemId ?? this.menuItemId,
      titleAr: titleAr ?? this.titleAr,
      titleEn: titleEn ?? this.titleEn,
      priceJod: priceJod ?? this.priceJod,
      billingPeriod: billingPeriod ?? this.billingPeriod,
      imageUrls: imageUrls ?? this.imageUrls,
      isAvailable: isAvailable ?? this.isAvailable,
      sortOrder: sortOrder ?? this.sortOrder,
      dayPlans: dayPlans ?? this.dayPlans,
      freeDelivery: freeDelivery ?? this.freeDelivery,
      campaignId: clearCampaignId ? null : (campaignId ?? this.campaignId),
    );
  }
}
