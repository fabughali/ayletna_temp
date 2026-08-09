/// Menu category (UI phase — mock / future Supabase).
class ModelMenuCategory {
  const ModelMenuCategory({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.iconKey,
    this.sortOrder = 0,
    this.descriptionAr,
    this.descriptionEn,
    this.mealType,
  });

  final String id;
  final String nameAr;
  final String nameEn;
  final String iconKey;
  final int sortOrder;
  final String? descriptionAr;
  final String? descriptionEn;
  final String? mealType;

  ModelMenuCategory copyWith({
    String? id,
    String? nameAr,
    String? nameEn,
    String? iconKey,
    int? sortOrder,
    String? descriptionAr,
    String? descriptionEn,
    String? mealType,
    bool clearDescriptionAr = false,
    bool clearDescriptionEn = false,
    bool clearMealType = false,
  }) {
    return ModelMenuCategory(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      iconKey: iconKey ?? this.iconKey,
      sortOrder: sortOrder ?? this.sortOrder,
      descriptionAr: clearDescriptionAr ? null : (descriptionAr ?? this.descriptionAr),
      descriptionEn: clearDescriptionEn ? null : (descriptionEn ?? this.descriptionEn),
      mealType: clearMealType ? null : (mealType ?? this.mealType),
    );
  }
}
