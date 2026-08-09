import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';

/// Menu product (UI phase).
class ModelMenuItem {
  const ModelMenuItem({
    required this.id,
    required this.categoryId,
    required this.nameAr,
    required this.nameEn,
    required this.priceJod,
    required this.descriptionAr,
    required this.descriptionEn,
    this.imageUrl,
    this.imageUrls = const [],
    this.isAvailable = true,
    this.isFeatured = false,
    this.prepStation = PrepStation.shawarma,
    this.tags = const [],
    this.sortOrder = 0,
    this.rewardId,
  });

  final String id;
  final String categoryId;
  final String nameAr;
  final String nameEn;
  final double priceJod;
  final String descriptionAr;
  final String descriptionEn;

  /// Legacy single-image field — kept for mock seed data compatibility.
  final String? imageUrl;

  /// Up to five gallery images (min one when publishing from admin).
  final List<String> imageUrls;

  final bool isAvailable;
  final bool isFeatured;
  final PrepStation prepStation;
  final List<String> tags;
  final int sortOrder;

  /// Optional single linked loyalty reward for this product.
  final String? rewardId;

  int get rewardPoints => (priceJod * 10).round();

  /// Resolves gallery URLs from [imageUrls] or falls back to [imageUrl].
  List<String> get resolvedImageUrls {
    if (imageUrls.isNotEmpty) {
      return imageUrls.take(5).toList();
    }
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return [imageUrl!];
    }
    return const [];
  }

  /// Primary thumbnail for cards and POS tiles.
  String? get primaryImageUrl =>
      resolvedImageUrls.isNotEmpty ? resolvedImageUrls.first : null;

  ModelMenuItem copyWith({
    String? id,
    String? categoryId,
    String? nameAr,
    String? nameEn,
    double? priceJod,
    String? descriptionAr,
    String? descriptionEn,
    String? imageUrl,
    List<String>? imageUrls,
    bool? isAvailable,
    bool? isFeatured,
    PrepStation? prepStation,
    List<String>? tags,
    int? sortOrder,
    String? rewardId,
    bool clearRewardId = false,
  }) {
    return ModelMenuItem(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      priceJod: priceJod ?? this.priceJod,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      imageUrl: imageUrl ?? this.imageUrl,
      imageUrls: imageUrls ?? this.imageUrls,
      isAvailable: isAvailable ?? this.isAvailable,
      isFeatured: isFeatured ?? this.isFeatured,
      prepStation: prepStation ?? this.prepStation,
      tags: tags ?? this.tags,
      sortOrder: sortOrder ?? this.sortOrder,
      rewardId: clearRewardId ? null : (rewardId ?? this.rewardId),
    );
  }
}

/// Prep station / kitchen station assignment for a menu item.
enum PrepStation {
  shawarma,
  fryer,
  coldPrep,
  drinks;

  String label(AppLocalizations l10n) {
    return switch (this) {
      PrepStation.shawarma => l10n.productEditorPrepStationShawarma,
      PrepStation.fryer => l10n.productEditorPrepStationFryer,
      PrepStation.coldPrep => l10n.productEditorPrepStationColdPrep,
      PrepStation.drinks => l10n.productEditorPrepStationDrinks,
    };
  }
}
