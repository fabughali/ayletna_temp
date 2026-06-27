import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_create_address_request.dart';
import 'package:ayletna_restaurant_app/data/models/model_saved_address.dart';
import 'package:ayletna_restaurant_app/data/repositories/repository_address.dart';

class RepositoryAddressMock implements RepositoryAddress {
  RepositoryAddressMock._() {
    _addresses = [...MockupCatalog.savedAddresses];
  }

  static final RepositoryAddressMock instance = RepositoryAddressMock._();

  late List<ModelSavedAddress> _addresses;
  var _nextId = 100;

  @override
  Future<List<ModelSavedAddress>> fetchSavedAddresses() async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    return [..._addresses];
  }

  @override
  Future<ModelSavedAddress> createAddress(
    ModelCreateAddressRequest request,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));

    final label = request.label.trim();
    final line = request.addressLine.trim();
    if (label.isEmpty || line.isEmpty) {
      throw const AddressValidationException('fields_required');
    }

    final id = 'addr_${_nextId++}';
    var created = ModelSavedAddress(
      id: id,
      labelAr: label,
      labelEn: label,
      addressAr: line,
      addressEn: line,
      iconKey: request.iconKey,
      isSelected: request.setAsDefault || _addresses.isEmpty,
      canRemove: true,
    );

    if (created.isSelected) {
      _addresses = [
        for (final address in _addresses)
          address.copyWith(isSelected: false),
      ];
    }

    _addresses = [..._addresses, created];
    return created;
  }

  @override
  Future<void> deleteAddress(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 180));
    final index = _addresses.indexWhere((address) => address.id == id);
    if (index < 0) {
      throw const AddressValidationException('not_found');
    }
    if (!_addresses[index].canRemove) {
      throw const AddressValidationException('cannot_remove');
    }

    final wasDefault = _addresses[index].isSelected;
    _addresses = [..._addresses]..removeAt(index);

    if (wasDefault && _addresses.isNotEmpty) {
      _addresses[0] = _addresses[0].copyWith(isSelected: true);
    }
  }

  @override
  Future<void> setDefaultAddress(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    if (!_addresses.any((address) => address.id == id)) {
      throw const AddressValidationException('not_found');
    }
    _addresses = [
      for (final address in _addresses)
        address.copyWith(isSelected: address.id == id),
    ];
  }
}

class AddressValidationException implements Exception {
  const AddressValidationException(this.messageKey);

  final String messageKey;

  @override
  String toString() => 'AddressValidationException($messageKey)';
}
