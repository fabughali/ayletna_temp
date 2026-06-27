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
  });

  final String id;
  final String labelAr;
  final String labelEn;
  final String addressAr;
  final String addressEn;
  final String iconKey;
  final bool isSelected;
  final bool canRemove;

  ModelSavedAddress copyWith({
    String? id,
    String? labelAr,
    String? labelEn,
    String? addressAr,
    String? addressEn,
    String? iconKey,
    bool? isSelected,
    bool? canRemove,
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
    );
  }
}
