import 'package:ayletna_restaurant_app/data/models/model_admin_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_list_entry.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:ayletna_restaurant_app/providers/cart_providers.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Whether an offer id should open the combo builder instead of cart apply.
bool isComboOfferId(String offerId) {
  return offerId == 'o2' || offerId.contains('combo');
}

/// Applies an offer by adding a discounted menu item or combo-priced line to cart.
/// Returns false when nothing could be applied.
bool applyOfferToCart(WidgetRef ref, ModelListEntry offer) {
  if (isComboOfferId(offer.id)) return false;

  final combos = ref.read(visibleCombosProvider);
  for (final combo in combos) {
    if (combo.id == offer.id) {
      ref.read(cartProvider.notifier).addConfiguredItem(
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

  final discounts = ref.read(visibleDiscountsProvider);
  if (discounts.isEmpty) return false;

  final discount = discounts.first;
  final item = ref.read(menuItemByIdProvider(discount.menuItemId));
  if (item == null) return false;

  final discountedPrice =
      item.priceJod * (1 - discount.percentOff.clamp(0, 100) / 100);
  ref.read(cartProvider.notifier).addConfiguredItem(
    item: item,
    quantity: 1,
    unitPriceJod: discountedPrice,
    configurationKey: 'offer_${offer.id}',
    configurationAr: '${offer.titleAr} (${discount.percentOff.toStringAsFixed(0)}% خصم)',
    configurationEn: '${offer.titleEn} (${discount.percentOff.toStringAsFixed(0)}% off)',
  );
  return true;
}

/// Featured hero claim — uses first combo or first discount in catalog.
bool applyFeaturedOfferToCart(WidgetRef ref) {
  final combos = ref.read(visibleCombosProvider);
  if (combos.isNotEmpty) {
    final combo = combos.first;
    ref.read(cartProvider.notifier).addConfiguredItem(
      item: _syntheticComboItem(combo),
      quantity: 1,
      unitPriceJod: combo.priceJod,
      configurationKey: 'combo_${combo.id}',
      configurationAr: combo.titleAr,
      configurationEn: combo.titleEn,
    );
    return true;
  }
  final offers = ref.read(visibleOfferEntriesProvider);
  if (offers.isEmpty) return false;
  return applyOfferToCart(ref, offers.first);
}

ModelMenuItem _syntheticComboItem(ModelCatalogCombo combo) {
  return ModelMenuItem(
    id: 'combo_${combo.id}',
    categoryId: 'combos',
    nameAr: combo.titleAr,
    nameEn: combo.titleEn,
    descriptionAr: combo.subtitleEn ?? combo.titleAr,
    descriptionEn: combo.subtitleEn ?? combo.titleEn,
    priceJod: combo.priceJod,
    imageUrl: '',
  );
}
