class FaqEntry {
  const FaqEntry({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.bodyAr,
    required this.bodyEn,
    this.published = true,
    this.sortOrder = 0,
  });

  final String id;
  final String titleAr;
  final String titleEn;
  final String bodyAr;
  final String bodyEn;
  final bool published;
  final int sortOrder;

  String title(bool isAr) => isAr ? titleAr : titleEn;
  String body(bool isAr) => isAr ? bodyAr : bodyEn;

  FaqEntry copyWith({
    String? id,
    String? titleAr,
    String? titleEn,
    String? bodyAr,
    String? bodyEn,
    bool? published,
    int? sortOrder,
  }) {
    return FaqEntry(
      id: id ?? this.id,
      titleAr: titleAr ?? this.titleAr,
      titleEn: titleEn ?? this.titleEn,
      bodyAr: bodyAr ?? this.bodyAr,
      bodyEn: bodyEn ?? this.bodyEn,
      published: published ?? this.published,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}
