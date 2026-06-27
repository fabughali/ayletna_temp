import 'package:ayletna_restaurant_app/data/models/model_create_address_request.dart';
import 'package:ayletna_restaurant_app/data/models/model_saved_address.dart';

abstract class RepositoryAddress {
  Future<List<ModelSavedAddress>> fetchSavedAddresses();
  Future<ModelSavedAddress> createAddress(ModelCreateAddressRequest request);
  Future<void> deleteAddress(String id);
  Future<void> setDefaultAddress(String id);
}
