/// Mock support ticket shown on the customer support screen.
class ModelSupportTicket {
  const ModelSupportTicket({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.bodyAr,
    required this.bodyEn,
    required this.statusAr,
    required this.statusEn,
    required this.updatedAr,
    required this.updatedEn,
  });

  final String id;
  final String titleAr;
  final String titleEn;
  final String bodyAr;
  final String bodyEn;
  final String statusAr;
  final String statusEn;
  final String updatedAr;
  final String updatedEn;
}
