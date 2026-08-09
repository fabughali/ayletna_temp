/// Mandatory audit trail event (§7.3 matrix).
enum AuditEventType {
  refund,
  orderCancel,
  priceChange,
  offerPublished,
}

class ModelAuditEvent {
  const ModelAuditEvent({
    required this.id,
    required this.type,
    required this.actorRoleKey,
    required this.summaryEn,
    required this.summaryAr,
    required this.recordedAt,
    this.entityId,
    this.beforeValue,
    this.afterValue,
  });

  final String id;
  final AuditEventType type;
  final String actorRoleKey;
  final String summaryEn;
  final String summaryAr;
  final DateTime recordedAt;
  final String? entityId;
  final String? beforeValue;
  final String? afterValue;
}
