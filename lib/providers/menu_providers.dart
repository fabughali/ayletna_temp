import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/data/repositories/repository_providers.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:ayletna_restaurant_app/providers/admin_session_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<ModelMenuItem> _mergeVisibleMenuItems(Ref ref) {
  final catalog = ref.watch(adminCatalogProvider);
  final menuState = ref.watch(adminMenuProvider);
  final categoryIds = catalog.resolvedCategories.map((c) => c.id).toSet();

  final base =
      MockupCatalog.items
          .where((item) => categoryIds.contains(item.categoryId))
          .where((item) => menuState.activeOverrides[item.nameEn] ?? true)
          .where((item) => menuState.isSeedProductPublished(item.id))
          .map((item) => menuState.catalogItemOverrides[item.id] ?? item)
          .toList();

  final adminAdded =
      menuState.addedMenuItems
          .where((item) => menuState.publishedProductIds.contains(item.id))
          .toList();

  return [...adminAdded, ...base];
}

final menuCategoriesProvider = FutureProvider((ref) async {
  return ref.watch(visibleCategoriesProvider);
});

final selectedCategoryIdProvider = StateProvider<String>((ref) {
  return 'shawarma';
});

final menuItemsProvider = FutureProvider((ref) async {
  final catId = ref.watch(selectedCategoryIdProvider);
  return _mergeVisibleMenuItems(ref)
      .where((item) => item.categoryId == catId)
      .toList();
});

final menuAllItemsProvider = FutureProvider((ref) async {
  return _mergeVisibleMenuItems(ref);
});

final selectedMenuItemIdProvider = StateProvider<String?>((ref) => null);

final selectedMenuItemProvider = Provider<ModelMenuItem?>((ref) {
  final id = ref.watch(selectedMenuItemIdProvider);
  if (id == null) return null;

  final adminItems = ref.watch(adminMenuProvider).addedMenuItems;
  for (final item in adminItems) {
    if (item.id == id) return item;
  }

  final override = ref.watch(adminMenuProvider).catalogItemOverrides[id];
  if (override != null) return override;

  return ref.read(repositoryMenuProvider).lookupItemById(id);
});

final menuItemByIdProvider = Provider.family<ModelMenuItem?, String>((ref, id) {
  return ref.watch(menuAllItemsProvider).maybeWhen(
    data: (items) {
      for (final item in items) {
        if (item.id == id) return item;
      }
      return MockupCatalog.itemById(id);
    },
    orElse: () => MockupCatalog.itemById(id),
  );
});
