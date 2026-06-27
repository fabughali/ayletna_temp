/// Menu addon / modifier managed by admin.
class ModelMenuAddon {
  const ModelMenuAddon({
    required this.id,
    required this.key,
    required this.labelAr,
    required this.labelEn,
    required this.priceDeltaJod,
  });

  final String id;
  final String key;
  final String labelAr;
  final String labelEn;
  final double priceDeltaJod;

  ModelMenuAddon copyWith({
    String? id,
    String? key,
    String? labelAr,
    String? labelEn,
    double? priceDeltaJod,
  }) {
    return ModelMenuAddon(
      id: id ?? this.id,
      key: key ?? this.key,
      labelAr: labelAr ?? this.labelAr,
      labelEn: labelEn ?? this.labelEn,
      priceDeltaJod: priceDeltaJod ?? this.priceDeltaJod,
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
  });

  final String id;
  final String titleAr;
  final String titleEn;
  final String? subtitleAr;
  final String? subtitleEn;
  final double priceJod;
  final List<String> itemIds;
  final double discountPercent;

  ModelCatalogCombo copyWith({
    String? id,
    String? titleAr,
    String? titleEn,
    String? subtitleAr,
    String? subtitleEn,
    double? priceJod,
    List<String>? itemIds,
    double? discountPercent,
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
  });

  final String id;
  final String menuItemId;
  final double percentOff;
  final String? labelAr;
  final String? labelEn;

  ModelCatalogDiscount copyWith({
    String? id,
    String? menuItemId,
    double? percentOff,
    String? labelAr,
    String? labelEn,
  }) {
    return ModelCatalogDiscount(
      id: id ?? this.id,
      menuItemId: menuItemId ?? this.menuItemId,
      percentOff: percentOff ?? this.percentOff,
      labelAr: labelAr ?? this.labelAr,
      labelEn: labelEn ?? this.labelEn,
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
  });

  final String id;
  final String titleAr;
  final String titleEn;
  final String? subtitleAr;
  final String? subtitleEn;
  final bool active;

  ModelCatalogOffer copyWith({
    String? id,
    String? titleAr,
    String? titleEn,
    String? subtitleAr,
    String? subtitleEn,
    bool? active,
  }) {
    return ModelCatalogOffer(
      id: id ?? this.id,
      titleAr: titleAr ?? this.titleAr,
      titleEn: titleEn ?? this.titleEn,
      subtitleAr: subtitleAr ?? this.subtitleAr,
      subtitleEn: subtitleEn ?? this.subtitleEn,
      active: active ?? this.active,
    );
  }
}

/// Subscription meal plan tied to a menu item.
class ModelSubscriptionMeal {
  const ModelSubscriptionMeal({
    required this.id,
    required this.menuItemId,
    required this.titleAr,
    required this.titleEn,
    required this.priceJod,
    this.billingPeriod = 'monthly',
  });

  final String id;
  final String menuItemId;
  final String titleAr;
  final String titleEn;
  final double priceJod;
  final String billingPeriod;

  ModelSubscriptionMeal copyWith({
    String? id,
    String? menuItemId,
    String? titleAr,
    String? titleEn,
    double? priceJod,
    String? billingPeriod,
  }) {
    return ModelSubscriptionMeal(
      id: id ?? this.id,
      menuItemId: menuItemId ?? this.menuItemId,
      titleAr: titleAr ?? this.titleAr,
      titleEn: titleEn ?? this.titleEn,
      priceJod: priceJod ?? this.priceJod,
      billingPeriod: billingPeriod ?? this.billingPeriod,
    );
  }
}
