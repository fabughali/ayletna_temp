/// Customer notification row used by front-end mock flows.
class ModelCustomerNotification {
  const ModelCustomerNotification({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.bodyAr,
    required this.bodyEn,
    required this.timeAr,
    required this.timeEn,
    required this.iconKey,
    required this.colorKey,
    this.actionLabelsAr = const [],
    this.actionLabelsEn = const [],
    this.primaryActionIndexes = const {},
    this.isSubdued = false,
    this.actionRoutes = const [],
  });

  final String id;
  final String titleAr;
  final String titleEn;
  final String bodyAr;
  final String bodyEn;
  final String timeAr;
  final String timeEn;
  final String iconKey;
  final String colorKey;
  final List<String> actionLabelsAr;
  final List<String> actionLabelsEn;
  final Set<int> primaryActionIndexes;
  final bool isSubdued;
  /// Optional go_router paths per action button; null = mock-only feedback.
  final List<String?> actionRoutes;
}
