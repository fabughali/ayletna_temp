/// Saved customer delivery address used by front-end mock flows.
class ModelSavedAddress {
  const ModelSavedAddress({
    required this.id,
    required this.labelAr,
    required this.labelEn,
    required this.addressAr,
    required this.addressEn,
    required this.iconKey,
    this.isSelected = false,
    this.canRemove = true,
    this.contactName,
    this.phone,
    this.building,
    this.floor,
    this.accessCode,
    this.customerAccountId,
  });

  final String id;
  final String labelAr;
  final String labelEn;
  final String addressAr;
  final String addressEn;
  final String iconKey;
  final bool isSelected;
  final bool canRemove;
  final String? contactName;
  final String? phone;
  final String? building;
  final String? floor;
  final String? accessCode;

  /// Optional link to a customer account or loyalty profile.
  final String? customerAccountId;

  String addressForLocale(bool isAr) => isAr ? addressAr : addressEn;

  String labelForLocale(bool isAr) => isAr ? labelAr : labelEn;

  String displayLineForLocale(bool isAr) {
    final parts = <String>[
      labelForLocale(isAr),
      if (contactName != null && contactName!.isNotEmpty) contactName!,
      if (phone != null && phone!.isNotEmpty) phone!,
    ];
    return parts.join(' • ');
  }

  bool matchesSearch(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return true;
    return [
      labelAr,
      labelEn,
      addressAr,
      addressEn,
      contactName,
      phone,
      customerAccountId,
    ].any((field) => field?.toLowerCase().contains(q) ?? false);
  }

  ModelSavedAddress copyWith({
    String? id,
    String? labelAr,
    String? labelEn,
    String? addressAr,
    String? addressEn,
    String? iconKey,
    bool? isSelected,
    bool? canRemove,
    String? contactName,
    String? phone,
    String? building,
    String? floor,
    String? accessCode,
    String? customerAccountId,
  }) {
    return ModelSavedAddress(
      id: id ?? this.id,
      labelAr: labelAr ?? this.labelAr,
      labelEn: labelEn ?? this.labelEn,
      addressAr: addressAr ?? this.addressAr,
      addressEn: addressEn ?? this.addressEn,
      iconKey: iconKey ?? this.iconKey,
      isSelected: isSelected ?? this.isSelected,
      canRemove: canRemove ?? this.canRemove,
      contactName: contactName ?? this.contactName,
      phone: phone ?? this.phone,
      building: building ?? this.building,
      floor: floor ?? this.floor,
      accessCode: accessCode ?? this.accessCode,
      customerAccountId: customerAccountId ?? this.customerAccountId,
    );
  }
}
