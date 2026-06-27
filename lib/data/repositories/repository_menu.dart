import 'package:ayletna_restaurant_app/data/models/model_menu_category.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';

/// Menu data access (UI phase — mock; Supabase later).
abstract class RepositoryMenu {
  Future<List<ModelMenuCategory>> fetchCategories();
  Future<List<ModelMenuItem>> fetchItems({String? categoryId});
  Future<ModelMenuItem?> fetchItemById(String id);

  /// In-memory mock lookup; network implementations should return null.
  ModelMenuItem? lookupItemById(String id) => null;
}
