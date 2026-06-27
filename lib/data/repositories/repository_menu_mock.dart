import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_category.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/data/repositories/repository_menu.dart';

class RepositoryMenuMock implements RepositoryMenu {
  const RepositoryMenuMock();

  @override
  Future<List<ModelMenuCategory>> fetchCategories() async {
    return MockupCatalog.categories;
  }

  @override
  Future<List<ModelMenuItem>> fetchItems({String? categoryId}) async {
    if (categoryId == null) {
      return MockupCatalog.items;
    }
    return MockupCatalog.itemsForCategory(categoryId);
  }

  @override
  Future<ModelMenuItem?> fetchItemById(String id) async {
    return MockupCatalog.itemById(id);
  }

  @override
  ModelMenuItem? lookupItemById(String id) => MockupCatalog.itemById(id);
}
