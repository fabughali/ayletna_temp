/// Support ticket lifecycle for customer ↔ admin workflows.
enum SupportTicketStatus { open, inProgress, waitingCustomer, resolved, closed }

enum SupportTicketPriority { low, normal, high }

extension SupportTicketPriorityLabels on SupportTicketPriority {
  String labelEn() => switch (this) {
    SupportTicketPriority.low => 'Low',
    SupportTicketPriority.normal => 'Normal',
    SupportTicketPriority.high => 'High',
  };

  String labelAr() => switch (this) {
    SupportTicketPriority.low => 'منخفض',
    SupportTicketPriority.normal => 'عادي',
    SupportTicketPriority.high => 'عاجل',
  };
}

enum SupportSlaState { onTrack, atRisk, breached }

class SupportTicketMessage {
  const SupportTicketMessage({
    required this.authorKey,
    required this.bodyAr,
    required this.bodyEn,
    required this.sentAt,
    this.isStaff = false,
  });

  final String authorKey;
  final String bodyAr;
  final String bodyEn;
  final DateTime sentAt;
  final bool isStaff;
}

class ModelSupportTicketRecord {
  const ModelSupportTicketRecord({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.bodyAr,
    required this.bodyEn,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.messages = const [],
    this.customerRating,
    this.customerFeedback,
    this.orderId,
    this.priority = SupportTicketPriority.normal,
    this.slaTargetMinutes = 240,
    this.customerPhone,
    this.customerAddress,
    this.escalatedTo,
  });

  final String id;
  final String titleAr;
  final String titleEn;
  final String bodyAr;
  final String bodyEn;
  final SupportTicketStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<SupportTicketMessage> messages;
  final int? customerRating;
  final String? customerFeedback;
  final String? orderId;
  final SupportTicketPriority priority;
  final int slaTargetMinutes;
  final String? customerPhone;
  final String? customerAddress;

  /// `operator` or `cashier` when escalated.
  final String? escalatedTo;

  SupportSlaState slaState({DateTime? now}) {
    if (status == SupportTicketStatus.resolved ||
        status == SupportTicketStatus.closed) {
      return SupportSlaState.onTrack;
    }
    final elapsed = (now ?? DateTime.now()).difference(createdAt).inMinutes;
    if (elapsed >= slaTargetMinutes) return SupportSlaState.breached;
    if (elapsed >= (slaTargetMinutes * 0.75).round()) {
      return SupportSlaState.atRisk;
    }
    return SupportSlaState.onTrack;
  }

  String priorityLabelEn() => priority.labelEn();

  String priorityLabelAr() => priority.labelAr();

  String statusLabelEn() => switch (status) {
    SupportTicketStatus.open => 'Open',
    SupportTicketStatus.inProgress => 'In progress',
    SupportTicketStatus.waitingCustomer => 'Waiting for you',
    SupportTicketStatus.resolved => 'Resolved',
    SupportTicketStatus.closed => 'Closed',
  };

  String statusLabelAr() => switch (status) {
    SupportTicketStatus.open => 'مفتوحة',
    SupportTicketStatus.inProgress => 'قيد المتابعة',
    SupportTicketStatus.waitingCustomer => 'بانتظار ردك',
    SupportTicketStatus.resolved => 'تم الحل',
    SupportTicketStatus.closed => 'مغلقة',
  };

  bool get canCustomerRate =>
      status == SupportTicketStatus.resolved && customerRating == null;

  ModelSupportTicketRecord copyWith({
    String? id,
    String? titleAr,
    String? titleEn,
    String? bodyAr,
    String? bodyEn,
    SupportTicketStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<SupportTicketMessage>? messages,
    int? customerRating,
    String? customerFeedback,
    String? orderId,
    SupportTicketPriority? priority,
    int? slaTargetMinutes,
    String? customerPhone,
    String? customerAddress,
    String? escalatedTo,
    bool clearEscalation = false,
    bool clearRating = false,
    bool clearFeedback = false,
  }) {
    return ModelSupportTicketRecord(
      id: id ?? this.id,
      titleAr: titleAr ?? this.titleAr,
      titleEn: titleEn ?? this.titleEn,
      bodyAr: bodyAr ?? this.bodyAr,
      bodyEn: bodyEn ?? this.bodyEn,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      messages: messages ?? this.messages,
      customerRating:
          clearRating ? null : (customerRating ?? this.customerRating),
      customerFeedback:
          clearFeedback ? null : (customerFeedback ?? this.customerFeedback),
      orderId: orderId ?? this.orderId,
      priority: priority ?? this.priority,
      slaTargetMinutes: slaTargetMinutes ?? this.slaTargetMinutes,
      customerPhone: customerPhone ?? this.customerPhone,
      customerAddress: customerAddress ?? this.customerAddress,
      escalatedTo: clearEscalation ? null : (escalatedTo ?? this.escalatedTo),
    );
  }
}
