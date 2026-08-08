import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_admin_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:ayletna_restaurant_app/providers/cart_promo_providers.dart';
import 'package:ayletna_restaurant_app/providers/cart_providers.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Whether an offer id should open the combo builder instead of cart apply.
bool isComboOfferId(String offerId) {
  return offerId == 'o2' || offerId.contains('combo');
}

/// Applies an offer by adding a discounted menu item or combo-priced line to cart.
/// Prefers the offer's own [ModelCatalogOffer.discountPercent] / [ModelCatalogOffer.promoCode].
/// Returns false when nothing could be applied.
bool applyOfferToCart(WidgetRef ref, ModelCatalogOffer offer) {
  if (isComboOfferId(offer.id)) return false;

  final combos = ref.read(visibleCombosProvider);
  for (final combo in combos) {
    if (combo.id == offer.id) {
      ref
          .read(cartProvider.notifier)
          .addConfiguredItem(
            item: _syntheticComboItem(combo),
            quantity: 1,
            unitPriceJod: combo.priceJod,
            configurationKey: 'combo_${combo.id}',
            configurationAr: combo.titleAr,
            configurationEn: combo.titleEn,
          );
      return true;
    }
  }

  final offerPercent = offer.discountPercent;
  final discounts = ref.read(visibleDiscountsProvider);

  ModelMenuItem? item;
  double? percentOff;

  if (offerPercent != null && offerPercent > 0) {
    percentOff = offerPercent.clamp(0, 100);
    if (discounts.isNotEmpty) {
      item = ref.read(menuItemByIdProvider(discounts.first.menuItemId));
    }
    item ??= _firstAvailableMenuItem();
  } else if (discounts.isNotEmpty) {
    final discount = discounts.first;
    percentOff = discount.percentOff;
    item = ref.read(menuItemByIdProvider(discount.menuItemId));
  }

  if (item != null && percentOff != null) {
    final discountedPrice =
        item.priceJod * (1 - percentOff.clamp(0, 100) / 100);
    final pctLabel = percentOff.toStringAsFixed(0);
    ref
        .read(cartProvider.notifier)
        .addConfiguredItem(
          item: item,
          quantity: 1,
          unitPriceJod: discountedPrice,
          configurationKey: 'offer_${offer.id}',
          configurationAr: '${offer.titleAr} ($pctLabel% خصم)',
          configurationEn: '${offer.titleEn} ($pctLabel% off)',
        );

    final promo = offer.promoCode?.trim();
    if (promo != null && promo.isNotEmpty) {
      // Code shown on checkout; percent already applied on the line.
      ref.read(cartPromoProvider.notifier).markAppliedCode(promo);
    }
    return true;
  }

  final promo = offer.promoCode?.trim();
  if (promo != null && promo.isNotEmpty) {
    final cart = ref.read(cartProvider);
    final subtotal =
        cart.fold<double>(0, (sum, line) => sum + line.lineTotalJod);
    if (subtotal <= 0) return false;
    return ref.read(cartPromoProvider.notifier).applyCode(promo, subtotal);
  }

  return false;
}

ModelMenuItem? _firstAvailableMenuItem() {
  for (final candidate in MockupCatalog.items) {
    if (candidate.isAvailable) return candidate;
  }
  return MockupCatalog.items.isNotEmpty ? MockupCatalog.items.first : null;
}

/// Featured hero claim — uses first combo or first discount in catalog.
bool applyFeaturedOfferToCart(WidgetRef ref) {
  final combos = ref.read(visibleCombosProvider);
  if (combos.isNotEmpty) {
    final combo = combos.first;
    ref
        .read(cartProvider.notifier)
        .addConfiguredItem(
          item: _syntheticComboItem(combo),
          quantity: 1,
          unitPriceJod: combo.priceJod,
          configurationKey: 'combo_${combo.id}',
          configurationAr: combo.titleAr,
          configurationEn: combo.titleEn,
        );
    return true;
  }
  final offers = ref.read(visibleOffersProvider);
  if (offers.isEmpty) return false;
  return applyOfferToCart(ref, offers.first);
}

/// Maps a catalog combo to a cart-ready menu item snapshot.
ModelMenuItem catalogComboMenuItem(ModelCatalogCombo combo) {
  return ModelMenuItem(
    id: 'combo_${combo.id}',
    categoryId: 'combos',
    nameAr: combo.titleAr,
    nameEn: combo.titleEn,
    descriptionAr: combo.subtitleAr ?? combo.titleAr,
    descriptionEn: combo.subtitleEn ?? combo.titleEn,
    priceJod: combo.priceJod,
    imageUrls: combo.imageUrls,
    imageUrl: combo.primaryImageUrl,
  );
}

void addComboToCart(WidgetRef ref, ModelCatalogCombo combo) {
  ref
      .read(cartProvider.notifier)
      .addConfiguredItem(
        item: catalogComboMenuItem(combo),
        quantity: 1,
        unitPriceJod: combo.priceJod,
        configurationKey: 'combo_${combo.id}',
        configurationAr: combo.titleAr,
        configurationEn: combo.titleEn,
      );
}

ModelMenuItem _syntheticComboItem(ModelCatalogCombo combo) =>
    catalogComboMenuItem(combo);
