import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_cart_customization_option.dart';
import 'package:ayletna_restaurant_app/data/models/model_admin_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_list_entry.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_category.dart';
import 'package:ayletna_restaurant_app/providers/marketing_campaign_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

int _catalogSeq = 5000;

class AdminCatalogState {
  const AdminCatalogState({
    this.deletedCategoryIds = const {},
    this.categoryOverrides = const {},
    this.addedCategories = const [],
    this.deletedAddonIds = const {},
    this.addonOverrides = const {},
    this.addedAddons = const [],
    this.relatedLinks = const {},
    this.deletedRelatedProductIds = const {},
    this.deletedComboIds = const {},
    this.comboOverrides = const {},
    this.addedCombos = const [],
    this.deletedDiscountIds = const {},
    this.discountOverrides = const {},
    this.addedDiscounts = const [],
    this.deletedOfferIds = const {},
    this.offerOverrides = const {},
    this.addedOffers = const [],
    this.deletedSubscriptionIds = const {},
    this.subscriptionOverrides = const {},
    this.addedSubscriptions = const [],
    this.addedPortionOptions = const [],
    this.productAddonAttachments = const {},
  });

  final Set<String> deletedCategoryIds;
  final Map<String, ModelMenuCategory> categoryOverrides;
  final List<ModelMenuCategory> addedCategories;
  final Set<String> deletedAddonIds;
  final Map<String, ModelMenuAddon> addonOverrides;
  final List<ModelMenuAddon> addedAddons;
  final Map<String, ModelRelatedProductLink> relatedLinks;
  final Set<String> deletedRelatedProductIds;

  /// When a product id is present, only these add-ons are offered (with overrides).
  /// Missing key = legacy fallback to full add-on library.
  final Map<String, List<ModelProductAddonAttachment>> productAddonAttachments;
  final Set<String> deletedComboIds;
  final Map<String, ModelCatalogCombo> comboOverrides;
  final List<ModelCatalogCombo> addedCombos;
  final Set<String> deletedDiscountIds;
  final Map<String, ModelCatalogDiscount> discountOverrides;
  final List<ModelCatalogDiscount> addedDiscounts;
  final Set<String> deletedOfferIds;
  final Map<String, ModelCatalogOffer> offerOverrides;
  final List<ModelCatalogOffer> addedOffers;
  final Set<String> deletedSubscriptionIds;
  final Map<String, ModelSubscriptionMeal> subscriptionOverrides;
  final List<ModelSubscriptionMeal> addedSubscriptions;
  final List<ModelCartCustomizationOption> addedPortionOptions;

  static List<ModelMenuAddon> get _seedAddons => [
    const ModelMenuAddon(
      id: 'addon_extra_garlic',
      key: 'extra_garlic',
      labelAr: 'زيادة ثوم',
      labelEn: 'Extra garlic',
      priceDeltaJod: 0.15,
    ),
    const ModelMenuAddon(
      id: 'addon_add_fries',
      key: 'add_fries',
      labelAr: 'إضافة بطاطا',
      labelEn: 'Add fries',
      priceDeltaJod: 0.50,
    ),
    const ModelMenuAddon(
      id: 'addon_extra_hummus',
      key: 'extra_hummus',
      labelAr: 'إضافة حمص',
      labelEn: 'Add hummus',
      priceDeltaJod: 0.10,
    ),
    ...MockupCatalog.cartAddonOptions.map(
      (o) => ModelMenuAddon(
        id: 'addon_${o.key}',
        key: o.key,
        labelAr: o.key,
        labelEn: o.key,
        priceDeltaJod: o.priceDeltaJod,
      ),
    ),
  ];

  List<ModelMenuCategory> get resolvedCategories {
    final base =
        MockupCatalog.categories
            .where((c) => !deletedCategoryIds.contains(c.id))
            .map((c) => categoryOverrides[c.id] ?? c)
            .toList();
    return [...base, ...addedCategories];
  }

  List<ModelMenuAddon> get resolvedAddons {
    final seen = <String>{};
    final merged = <ModelMenuAddon>[];
    for (final addon in [..._seedAddons, ...addedAddons]) {
      if (deletedAddonIds.contains(addon.id)) continue;
      final resolved = addonOverrides[addon.id] ?? addon;
      if (seen.add(resolved.key)) merged.add(resolved);
    }
    return merged;
  }

  List<ModelCartCustomizationOption> get resolvedPortions {
    final seen = <String>{};
    final merged = <ModelCartCustomizationOption>[];
    for (final option in [
      ...MockupCatalog.cartPortionOptions,
      ...addedPortionOptions,
    ]) {
      if (seen.add(option.key)) merged.add(option);
    }
    return merged;
  }

  List<ModelRelatedProductLink> get resolvedRelatedLinks {
    return relatedLinks.values
        .where((link) => !deletedRelatedProductIds.contains(link.productId))
        .toList();
  }

  List<ModelCatalogCombo> get resolvedCombos {
    final seeded = MockupCatalog.comboHighlights.map(
      (entry) => ModelCatalogCombo(
        id: entry.id,
        titleAr: entry.titleAr,
        titleEn: entry.titleEn,
        subtitleAr: entry.subtitleAr,
        subtitleEn: entry.subtitleEn,
        priceJod: 18.5,
        itemIds: const [],
        discountPercent: 12,
        imageUrls: [MockupCatalog.promoImageUrlFor(entry.id)],
        isAvailable: true,
        rewardPoints: 80,
        campaignId: 'camp-1',
      ),
    );
    return [
      ...seeded
          .where((c) => !deletedComboIds.contains(c.id))
          .map((c) => _comboWithPromoImages(comboOverrides[c.id] ?? c)),
      ...addedCombos.map(_comboWithPromoImages),
    ];
  }

  List<ModelCatalogDiscount> get resolvedDiscounts {
    final seeded = MockupCatalog.discountedMenuItemIds.map(
      (id) => ModelCatalogDiscount(
        id: 'disc_$id',
        menuItemId: id,
        percentOff: 10,
        active: true,
        rewardPoints: 40,
        campaignId: 'camp-1',
      ),
    );
    return [
      ...seeded
          .where((d) => !deletedDiscountIds.contains(d.id))
          .map((d) => discountOverrides[d.id] ?? d),
      ...addedDiscounts,
    ];
  }

  List<ModelCatalogOffer> get resolvedOffers {
    final seeded = MockupCatalog.offers.asMap().entries.map(
      (entry) => ModelCatalogOffer(
        id: entry.value.id,
        titleAr: entry.value.titleAr,
        titleEn: entry.value.titleEn,
        subtitleAr: entry.value.subtitleAr,
        subtitleEn: entry.value.subtitleEn,
        imageUrls: [MockupCatalog.promoImageUrlFor(entry.value.id)],
        active: true,
        discountPercent: entry.key == 0 ? 10 : null,
        rewardPoints: entry.key == 0 ? 50 : 100,
        campaignId: 'camp-1',
      ),
    );
    return [
      ...seeded
          .where((o) => !deletedOfferIds.contains(o.id))
          .map((o) => _offerWithPromoImages(offerOverrides[o.id] ?? o)),
      ...addedOffers.map(_offerWithPromoImages),
    ];
  }

  List<ModelSubscriptionMeal> get resolvedSubscriptions {
    final seeded = MockupCatalog.subscriptionMenuItemIds.map((id) {
      final item = MockupCatalog.itemById(id);
      final ids = MockupCatalog.subscriptionMenuItemIds;
      return ModelSubscriptionMeal(
        id: 'sub_$id',
        menuItemId: id,
        titleAr: item?.nameAr ?? id,
        titleEn: item?.nameEn ?? id,
        priceJod: ((item?.priceJod ?? 0) * 20).clamp(15, 99),
        billingPeriod: 'monthly',
        isAvailable: true,
        campaignId: 'camp-1',
        freeDelivery: true,
        imageUrls: [MockupCatalog.promoImageUrlFor(id)],
        dayPlans: [
          for (var day = 1; day <= 30; day++)
            ModelSubscriptionDayPlan(
              dayIndex: day,
              menuItemIds: [ids[(day - 1) % ids.length]],
            ),
        ],
      );
    });
    return [
      ...seeded
          .where((s) => !deletedSubscriptionIds.contains(s.id))
          .map((s) => subscriptionOverrides[s.id] ?? s),
      ...addedSubscriptions,
    ];
  }

  AdminCatalogState copyWith({
    Set<String>? deletedCategoryIds,
    Map<String, ModelMenuCategory>? categoryOverrides,
    List<ModelMenuCategory>? addedCategories,
    Set<String>? deletedAddonIds,
    Map<String, ModelMenuAddon>? addonOverrides,
    List<ModelMenuAddon>? addedAddons,
    Map<String, ModelRelatedProductLink>? relatedLinks,
    Set<String>? deletedRelatedProductIds,
    Set<String>? deletedComboIds,
    Map<String, ModelCatalogCombo>? comboOverrides,
    List<ModelCatalogCombo>? addedCombos,
    Set<String>? deletedDiscountIds,
    Map<String, ModelCatalogDiscount>? discountOverrides,
    List<ModelCatalogDiscount>? addedDiscounts,
    Set<String>? deletedOfferIds,
    Map<String, ModelCatalogOffer>? offerOverrides,
    List<ModelCatalogOffer>? addedOffers,
    Set<String>? deletedSubscriptionIds,
    Map<String, ModelSubscriptionMeal>? subscriptionOverrides,
    List<ModelSubscriptionMeal>? addedSubscriptions,
    List<ModelCartCustomizationOption>? addedPortionOptions,
    Map<String, List<ModelProductAddonAttachment>>? productAddonAttachments,
  }) {
    return AdminCatalogState(
      deletedCategoryIds: deletedCategoryIds ?? this.deletedCategoryIds,
      categoryOverrides: categoryOverrides ?? this.categoryOverrides,
      addedCategories: addedCategories ?? this.addedCategories,
      deletedAddonIds: deletedAddonIds ?? this.deletedAddonIds,
      addonOverrides: addonOverrides ?? this.addonOverrides,
      addedAddons: addedAddons ?? this.addedAddons,
      relatedLinks: relatedLinks ?? this.relatedLinks,
      deletedRelatedProductIds:
          deletedRelatedProductIds ?? this.deletedRelatedProductIds,
      productAddonAttachments:
          productAddonAttachments ?? this.productAddonAttachments,
      deletedComboIds: deletedComboIds ?? this.deletedComboIds,
      comboOverrides: comboOverrides ?? this.comboOverrides,
      addedCombos: addedCombos ?? this.addedCombos,
      deletedDiscountIds: deletedDiscountIds ?? this.deletedDiscountIds,
      discountOverrides: discountOverrides ?? this.discountOverrides,
      addedDiscounts: addedDiscounts ?? this.addedDiscounts,
      deletedOfferIds: deletedOfferIds ?? this.deletedOfferIds,
      offerOverrides: offerOverrides ?? this.offerOverrides,
      addedOffers: addedOffers ?? this.addedOffers,
      deletedSubscriptionIds:
          deletedSubscriptionIds ?? this.deletedSubscriptionIds,
      subscriptionOverrides:
          subscriptionOverrides ?? this.subscriptionOverrides,
      addedSubscriptions: addedSubscriptions ?? this.addedSubscriptions,
      addedPortionOptions: addedPortionOptions ?? this.addedPortionOptions,
    );
  }
}

class AdminCatalogNotifier extends StateNotifier<AdminCatalogState> {
  AdminCatalogNotifier() : super(const AdminCatalogState());

  bool addCategory(ModelMenuCategory category) {
    if (category.nameEn.trim().isEmpty) return false;
    state = state.copyWith(
      addedCategories: [...state.addedCategories, category],
    );
    return true;
  }

  bool updateCategory(ModelMenuCategory category) {
    final isSeed = MockupCatalog.categories.any((c) => c.id == category.id);
    if (isSeed) {
      state = state.copyWith(
        categoryOverrides: {...state.categoryOverrides, category.id: category},
      );
      return true;
    }
    final index = state.addedCategories.indexWhere((c) => c.id == category.id);
    if (index == -1) return false;
    final next = [...state.addedCategories]..[index] = category;
    state = state.copyWith(addedCategories: next);
    return true;
  }

  void deleteCategory(String id) {
    if (state.addedCategories.any((c) => c.id == id)) {
      state = state.copyWith(
        addedCategories:
            state.addedCategories.where((c) => c.id != id).toList(),
      );
      return;
    }
    state = state.copyWith(
      deletedCategoryIds: {...state.deletedCategoryIds, id},
    );
  }

  bool addAddon(ModelMenuAddon addon) {
    if (addon.key.trim().isEmpty) return false;
    state = state.copyWith(addedAddons: [...state.addedAddons, addon]);
    return true;
  }

  bool updateAddon(ModelMenuAddon addon) {
    final isSeed = AdminCatalogState._seedAddons.any((a) => a.id == addon.id);
    if (isSeed) {
      state = state.copyWith(
        addonOverrides: {...state.addonOverrides, addon.id: addon},
      );
      return true;
    }
    final index = state.addedAddons.indexWhere((a) => a.id == addon.id);
    if (index == -1) return false;
    final next = [...state.addedAddons]..[index] = addon;
    state = state.copyWith(addedAddons: next);
    return true;
  }

  bool addPortionOption(ModelCartCustomizationOption option) {
    if (option.key.trim().isEmpty) return false;
    final exists = state.resolvedPortions.any((o) => o.key == option.key);
    if (exists) return false;
    state = state.copyWith(
      addedPortionOptions: [...state.addedPortionOptions, option],
    );
    return true;
  }

  void deleteAddon(String id) {
    if (state.addedAddons.any((a) => a.id == id)) {
      state = state.copyWith(
        addedAddons: state.addedAddons.where((a) => a.id != id).toList(),
      );
      return;
    }
    state = state.copyWith(deletedAddonIds: {...state.deletedAddonIds, id});
  }

  bool upsertRelatedLink(ModelRelatedProductLink link) {
    if (link.productId.trim().isEmpty) return false;
    state = state.copyWith(
      relatedLinks: {...state.relatedLinks, link.productId: link},
      deletedRelatedProductIds: {...state.deletedRelatedProductIds}
        ..remove(link.productId),
    );
    return true;
  }

  void deleteRelatedLink(String productId) {
    state = state.copyWith(
      deletedRelatedProductIds: {...state.deletedRelatedProductIds, productId},
    );
  }

  void setProductAddonAttachments(
    String productId,
    List<ModelProductAddonAttachment> attachments,
  ) {
    if (productId.trim().isEmpty) return;
    state = state.copyWith(
      productAddonAttachments: {
        ...state.productAddonAttachments,
        productId: List<ModelProductAddonAttachment>.unmodifiable(attachments),
      },
    );
  }

  bool addCombo(ModelCatalogCombo combo) {
    if (combo.titleEn.trim().isEmpty) return false;
    state = state.copyWith(addedCombos: [...state.addedCombos, combo]);
    return true;
  }

  bool updateCombo(ModelCatalogCombo combo) {
    final isSeed = MockupCatalog.comboHighlights.any((c) => c.id == combo.id);
    if (isSeed) {
      state = state.copyWith(
        comboOverrides: {...state.comboOverrides, combo.id: combo},
      );
      return true;
    }
    final index = state.addedCombos.indexWhere((c) => c.id == combo.id);
    if (index == -1) return false;
    final next = [...state.addedCombos]..[index] = combo;
    state = state.copyWith(addedCombos: next);
    return true;
  }

  void deleteCombo(String id) {
    if (state.addedCombos.any((c) => c.id == id)) {
      state = state.copyWith(
        addedCombos: state.addedCombos.where((c) => c.id != id).toList(),
      );
      return;
    }
    state = state.copyWith(deletedComboIds: {...state.deletedComboIds, id});
  }

  bool addDiscount(ModelCatalogDiscount discount) {
    if (discount.menuItemId.trim().isEmpty) return false;
    state = state.copyWith(addedDiscounts: [...state.addedDiscounts, discount]);
    return true;
  }

  bool updateDiscount(ModelCatalogDiscount discount) {
    final isSeed = discount.id.startsWith('disc_');
    if (isSeed && !state.addedDiscounts.any((d) => d.id == discount.id)) {
      state = state.copyWith(
        discountOverrides: {...state.discountOverrides, discount.id: discount},
      );
      return true;
    }
    final index = state.addedDiscounts.indexWhere((d) => d.id == discount.id);
    if (index == -1) return false;
    final next = [...state.addedDiscounts]..[index] = discount;
    state = state.copyWith(addedDiscounts: next);
    return true;
  }

  void deleteDiscount(String id) {
    if (state.addedDiscounts.any((d) => d.id == id)) {
      state = state.copyWith(
        addedDiscounts: state.addedDiscounts.where((d) => d.id != id).toList(),
      );
      return;
    }
    state = state.copyWith(
      deletedDiscountIds: {...state.deletedDiscountIds, id},
    );
  }

  bool addOffer(ModelCatalogOffer offer) {
    if (offer.titleEn.trim().isEmpty) return false;
    state = state.copyWith(addedOffers: [...state.addedOffers, offer]);
    return true;
  }

  bool updateOffer(ModelCatalogOffer offer) {
    final isSeed = MockupCatalog.offers.any((o) => o.id == offer.id);
    if (isSeed) {
      state = state.copyWith(
        offerOverrides: {...state.offerOverrides, offer.id: offer},
      );
      return true;
    }
    final index = state.addedOffers.indexWhere((o) => o.id == offer.id);
    if (index == -1) return false;
    final next = [...state.addedOffers]..[index] = offer;
    state = state.copyWith(addedOffers: next);
    return true;
  }

  void deleteOffer(String id) {
    if (state.addedOffers.any((o) => o.id == id)) {
      state = state.copyWith(
        addedOffers: state.addedOffers.where((o) => o.id != id).toList(),
      );
      return;
    }
    state = state.copyWith(deletedOfferIds: {...state.deletedOfferIds, id});
  }

  ModelCatalogOffer? offerById(String id) {
    for (final offer in state.resolvedOffers) {
      if (offer.id == id) return offer;
    }
    return null;
  }

  bool setOfferActive(String id, {required bool active}) {
    final offer = offerById(id);
    if (offer == null) return false;
    return updateOffer(offer.copyWith(active: active));
  }

  bool addSubscription(ModelSubscriptionMeal meal) {
    if (meal.titleEn.trim().isEmpty && meal.titleAr.trim().isEmpty) {
      return false;
    }
    state = state.copyWith(
      addedSubscriptions: [...state.addedSubscriptions, meal],
    );
    return true;
  }

  bool updateSubscription(ModelSubscriptionMeal meal) {
    final isSeed = meal.id.startsWith('sub_');
    if (isSeed && !state.addedSubscriptions.any((s) => s.id == meal.id)) {
      state = state.copyWith(
        subscriptionOverrides: {...state.subscriptionOverrides, meal.id: meal},
      );
      return true;
    }
    final index = state.addedSubscriptions.indexWhere((s) => s.id == meal.id);
    if (index == -1) return false;
    final next = [...state.addedSubscriptions]..[index] = meal;
    state = state.copyWith(addedSubscriptions: next);
    return true;
  }

  void deleteSubscription(String id) {
    if (state.addedSubscriptions.any((s) => s.id == id)) {
      state = state.copyWith(
        addedSubscriptions:
            state.addedSubscriptions.where((s) => s.id != id).toList(),
      );
      return;
    }
    state = state.copyWith(
      deletedSubscriptionIds: {...state.deletedSubscriptionIds, id},
    );
  }
}

final adminCatalogProvider =
    StateNotifierProvider<AdminCatalogNotifier, AdminCatalogState>(
      (ref) => AdminCatalogNotifier(),
    );

final visibleCategoriesProvider = Provider<List<ModelMenuCategory>>((ref) {
  return ref.watch(adminCatalogProvider).resolvedCategories;
});

final visibleAddonsProvider = Provider<List<ModelMenuAddon>>((ref) {
  return ref.watch(adminCatalogProvider).resolvedAddons;
});

final visiblePortionOptionsProvider =
    Provider<List<ModelCartCustomizationOption>>((ref) {
      return ref.watch(adminCatalogProvider).resolvedPortions;
    });

final visibleCombosProvider = Provider<List<ModelCatalogCombo>>((ref) {
  final campaigns = ref.watch(marketingCampaignEventsProvider);
  return ref
      .watch(adminCatalogProvider)
      .resolvedCombos
      .where((c) => c.isAvailable)
      .where(
        (c) => campaignCoversCombo(
          campaigns: campaigns,
          comboId: c.id,
          campaignId: c.campaignId,
        ),
      )
      .toList();
});

final visibleComboEntriesProvider = Provider<List<ModelListEntry>>((ref) {
  return ref
      .watch(visibleCombosProvider)
      .map(
        (c) => ModelListEntry(
          id: c.id,
          titleAr: c.titleAr,
          titleEn: c.titleEn,
          subtitleAr: c.subtitleAr,
          subtitleEn: c.subtitleEn,
          imageUrl: c.primaryImageUrl,
        ),
      )
      .toList();
});

final visibleOffersProvider = Provider<List<ModelCatalogOffer>>((ref) {
  final campaigns = ref.watch(marketingCampaignEventsProvider);
  return ref
      .watch(adminCatalogProvider)
      .resolvedOffers
      .where((o) => o.active)
      .where(
        (o) => campaignCoversOffer(
          campaigns: campaigns,
          offerId: o.id,
          campaignId: o.campaignId,
        ),
      )
      .toList();
});

final visibleOfferEntriesProvider = Provider<List<ModelListEntry>>((ref) {
  return ref
      .watch(visibleOffersProvider)
      .map(
        (o) => ModelListEntry(
          id: o.id,
          titleAr: o.titleAr,
          titleEn: o.titleEn,
          subtitleAr: o.subtitleAr,
          subtitleEn: o.subtitleEn,
          imageUrl: o.primaryImageUrl,
        ),
      )
      .toList();
});

ModelCatalogCombo _comboWithPromoImages(ModelCatalogCombo combo) {
  if (combo.imageUrls.isNotEmpty) return combo;
  return combo.copyWith(imageUrls: [MockupCatalog.promoImageUrlFor(combo.id)]);
}

ModelCatalogOffer _offerWithPromoImages(ModelCatalogOffer offer) {
  if (offer.imageUrls.isNotEmpty) return offer;
  return offer.copyWith(imageUrls: [MockupCatalog.promoImageUrlFor(offer.id)]);
}

final visibleDiscountsProvider = Provider<List<ModelCatalogDiscount>>((ref) {
  final campaigns = ref.watch(marketingCampaignEventsProvider);
  return ref
      .watch(adminCatalogProvider)
      .resolvedDiscounts
      .where(
        (d) => campaignCoversDiscount(
          campaigns: campaigns,
          discountId: d.id,
          campaignId: d.campaignId,
        ),
      )
      .toList();
});

final visibleDiscountItemIdsProvider = Provider<List<String>>((ref) {
  return ref.watch(visibleDiscountsProvider).map((d) => d.menuItemId).toList();
});

final visibleSubscriptionsProvider = Provider<List<ModelSubscriptionMeal>>((
  ref,
) {
  final campaigns = ref.watch(marketingCampaignEventsProvider);
  return ref
      .watch(adminCatalogProvider)
      .resolvedSubscriptions
      .where((s) => s.isAvailable)
      .where(
        (s) => campaignCoversSubscription(
          campaigns: campaigns,
          subscriptionId: s.id,
          campaignId: s.campaignId,
        ),
      )
      .toList();
});

final visibleSubscriptionItemIdsProvider = Provider<List<String>>((ref) {
  return ref
      .watch(visibleSubscriptionsProvider)
      .map((s) => s.menuItemId)
      .toList();
});

final catalogOfferByIdProvider = Provider.family<ModelCatalogOffer?, String>((
  ref,
  id,
) {
  for (final offer in ref.watch(visibleOffersProvider)) {
    if (offer.id == id) return offer;
  }
  return null;
});

final catalogComboByIdProvider = Provider.family<ModelCatalogCombo?, String>((
  ref,
  id,
) {
  for (final combo in ref.watch(visibleCombosProvider)) {
    if (combo.id == id) return combo;
  }
  return null;
});

final catalogSubscriptionByIdProvider =
    Provider.family<ModelSubscriptionMeal?, String>((ref, id) {
      for (final meal in ref.watch(visibleSubscriptionsProvider)) {
        if (meal.id == id) return meal;
      }
      return null;
    });

final relatedProductsForItemProvider = Provider.family<List<String>, String>((
  ref,
  productId,
) {
  final link = ref.watch(adminCatalogProvider).relatedLinks[productId];
  if (link != null &&
      !ref
          .watch(adminCatalogProvider)
          .deletedRelatedProductIds
          .contains(productId)) {
    return link.relatedProductIds;
  }
  return const [];
});

/// Resolved add-ons for a product (attachments + price overrides).
/// Missing attachment map → full library at catalog prices (legacy).
final productAddonsForItemProvider =
    Provider.family<List<ResolvedProductAddon>, String>((ref, productId) {
      final catalog = ref.watch(adminCatalogProvider);
      final library = catalog.resolvedAddons;
      final attachments = catalog.productAddonAttachments[productId];
      if (attachments == null) {
        return [
          for (final addon in library)
            ResolvedProductAddon(
              addon: addon,
              priceDeltaJod: addon.priceDeltaJod,
            ),
        ];
      }
      final byId = {for (final addon in library) addon.id: addon};
      final resolved = <ResolvedProductAddon>[];
      for (final attachment in attachments) {
        final addon = byId[attachment.addonId];
        if (addon == null) continue;
        resolved.add(
          ResolvedProductAddon(
            addon: addon,
            priceDeltaJod: attachment.resolvedPriceDelta(addon),
          ),
        );
      }
      return resolved;
    });

String nextCatalogId(String prefix) => '${prefix}_${_catalogSeq++}';

/// Customer/admin display pair: catalog add-on + effective price delta.
class ResolvedProductAddon {
  const ResolvedProductAddon({
    required this.addon,
    required this.priceDeltaJod,
  });

  final ModelMenuAddon addon;
  final double priceDeltaJod;
}