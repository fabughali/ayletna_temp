/// Generic list row for notifications, offers, audit, etc.
class ModelListEntry {
  const ModelListEntry({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    this.subtitleAr,
    this.subtitleEn,
    this.imageUrl,
  });

  final String id;
  final String titleAr;
  final String titleEn;
  final String? subtitleAr;
  final String? subtitleEn;

  /// Optional hero/thumbnail for offers, combos, and promos.
  final String? imageUrl;
}
