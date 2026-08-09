import 'package:ayletna_restaurant_app/core/core_color_scheme.dart';
import 'package:ayletna_restaurant_app/data/models/model_audit_event.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

int _auditSeq = 9000;

class AuditLogNotifier extends StateNotifier<List<ModelAuditEvent>> {
  AuditLogNotifier() : super(const []);

  ModelAuditEvent append({
    required AuditEventType type,
    required AppRole actorRole,
    required String summaryEn,
    required String summaryAr,
    String? entityId,
    String? beforeValue,
    String? afterValue,
  }) {
    final event = ModelAuditEvent(
      id: 'AUD-${++_auditSeq}',
      type: type,
      actorRoleKey: actorRole.name,
      summaryEn: summaryEn,
      summaryAr: summaryAr,
      recordedAt: DateTime.now(),
      entityId: entityId,
      beforeValue: beforeValue,
      afterValue: afterValue,
    );
    state = [event, ...state];
    return event;
  }
}

final auditLogProvider =
    StateNotifierProvider<AuditLogNotifier, List<ModelAuditEvent>>(
      (ref) => AuditLogNotifier(),
    );

void recordAuditEvent(
  WidgetRef ref, {
  required AuditEventType type,
  required AppRole actorRole,
  required String summaryEn,
  required String summaryAr,
  String? entityId,
  String? beforeValue,
  String? afterValue,
}) {
  ref
      .read(auditLogProvider.notifier)
      .append(
        type: type,
        actorRole: actorRole,
        summaryEn: summaryEn,
        summaryAr: summaryAr,
        entityId: entityId,
        beforeValue: beforeValue,
        afterValue: afterValue,
      );
}
