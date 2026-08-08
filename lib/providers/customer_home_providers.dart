import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_admin_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_blog_post.dart';
import 'package:ayletna_restaurant_app/data/models/model_list_entry.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:ayletna_restaurant_app/providers/marketing_blog_providers.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Home promo story cards (mock catalog slice).
final homePromoCardsProvider = Provider<List<ModelListEntry>>(
  (ref) => MockupCatalog.homePromoCards,
);

/// Featured menu items (isFeatured == true, sorted by sortOrder).
final homeFeaturedMenuItemsProvider = Provider<List<ModelMenuItem>>((ref) {
  final items =
      ref.watch(menuAllItemsProvider).valueOrNull ?? MockupCatalog.items;
  final featured =
      items.where((item) => item.isFeatured && item.isAvailable).toList();
  featured.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
  return featured;
});

/// Hero featured item on customer home.
final homeFeaturedMenuItemProvider = Provider<ModelMenuItem>((ref) {
  final featured = ref.watch(homeFeaturedMenuItemsProvider);
  if (featured.isNotEmpty) return featured.first;
  final items =
      ref.watch(menuAllItemsProvider).valueOrNull ?? MockupCatalog.items;
  final firstAvailable = items.where((item) => item.isAvailable).toList();
  return firstAvailable.isNotEmpty ? firstAvailable.first : items.first;
});

/// Home storefront rails — capped slices for scannable sections.
final homeOffersProvider = Provider<List<ModelCatalogOffer>>((ref) {
  return ref.watch(visibleOffersProvider).take(4).toList();
});

final homeCombosProvider = Provider<List<ModelCatalogCombo>>((ref) {
  return ref.watch(visibleCombosProvider).take(4).toList();
});

final homeSubscriptionsProvider = Provider<List<ModelSubscriptionMeal>>((ref) {
  return ref.watch(visibleSubscriptionsProvider).take(4).toList();
});

final homeDiscountItemsProvider = Provider<List<ModelMenuItem>>((ref) {
  final ids = ref.watch(visibleDiscountItemIdsProvider);
  return [
    for (final id in ids.take(4))
      if (MockupCatalog.itemById(id) case final item?) item,
  ];
});

/// Latest three published blog posts for the home rail.
final homeLatestBlogPostsProvider = Provider<List<BlogPost>>((ref) {
  return ref.watch(publishedBlogPostsProvider).take(3).toList();
});
