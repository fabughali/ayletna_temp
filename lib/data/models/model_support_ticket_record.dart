/// Support ticket lifecycle for customer ↔ admin workflows.
enum SupportTicketStatus {
  open,
  inProgress,
  waitingCustomer,
  resolved,
  closed,
}

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
      status == SupportTicketStatus.resolved &&
      customerRating == null;

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
      customerRating: clearRating ? null : (customerRating ?? this.customerRating),
      customerFeedback:
          clearFeedback ? null : (customerFeedback ?? this.customerFeedback),
      orderId: orderId ?? this.orderId,
    );
  }
}
