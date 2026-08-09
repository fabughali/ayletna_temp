import 'package:ayletna_restaurant_app/data/models/model_support_ticket_record.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

int _ticketSeq = 2049;

class SupportTicketsState {
  const SupportTicketsState({this.tickets = const []});

  final List<ModelSupportTicketRecord> tickets;

  SupportTicketsState copyWith({List<ModelSupportTicketRecord>? tickets}) {
    return SupportTicketsState(tickets: tickets ?? this.tickets);
  }
}

class SupportTicketsNotifier extends StateNotifier<SupportTicketsState> {
  SupportTicketsNotifier()
    : super(
        SupportTicketsState(
          tickets: [
            ModelSupportTicketRecord(
              id: 'AYL-2048',
              titleAr: 'متابعة طلب التوصيل',
              titleEn: 'Delivery order follow-up',
              bodyAr: 'سؤال عن وقت وصول الطلب النشط.',
              bodyEn: 'Question about the active order arrival time.',
              status: SupportTicketStatus.inProgress,
              createdAt: DateTime.now().subtract(const Duration(hours: 2)),
              updatedAt: DateTime.now().subtract(const Duration(minutes: 12)),
              orderId: 'ORD-1001',
              priority: SupportTicketPriority.high,
              slaTargetMinutes: 120,
              customerPhone: '+962 79 123 4567',
              customerAddress: 'Amman · Abdoun · Bldg 12, Floor 3',
              messages: [
                SupportTicketMessage(
                  authorKey: 'customer',
                  bodyAr: 'متى يصل طلبي؟',
                  bodyEn: 'When will my order arrive?',
                  sentAt: DateTime.now().subtract(const Duration(hours: 2)),
                ),
                SupportTicketMessage(
                  authorKey: 'support',
                  bodyAr: 'السائق في الطريق — ETA 15 دقيقة.',
                  bodyEn: 'Driver is en route — ETA 15 minutes.',
                  sentAt: DateTime.now().subtract(const Duration(minutes: 12)),
                  isStaff: true,
                ),
              ],
            ),
            ModelSupportTicketRecord(
              id: 'AYL-2019',
              titleAr: 'استفسار عن نقاط الولاء',
              titleEn: 'Loyalty points question',
              bodyAr: 'تم توضيح طريقة احتساب النقاط للطلب السابق.',
              bodyEn:
                  'Explained how points were calculated for the last order.',
              status: SupportTicketStatus.resolved,
              createdAt: DateTime.now().subtract(const Duration(days: 1)),
              updatedAt: DateTime.now().subtract(const Duration(hours: 20)),
              messages: const [],
              priority: SupportTicketPriority.low,
              customerPhone: '+962 78 555 0192',
              customerAddress: 'Amman · Jabal Amman · 4th Circle',
            ),
            ModelSupportTicketRecord(
              id: 'AYL-2033',
              titleAr: 'تأخر في استرداد المبلغ',
              titleEn: 'Refund delay',
              bodyAr: 'العميل ينتظر استرداداً منذ أمس.',
              bodyEn: 'Customer waiting for refund since yesterday.',
              status: SupportTicketStatus.open,
              createdAt: DateTime.now().subtract(const Duration(hours: 5)),
              updatedAt: DateTime.now().subtract(const Duration(hours: 5)),
              priority: SupportTicketPriority.normal,
              slaTargetMinutes: 180,
              customerPhone: '+962 77 901 2233',
              customerAddress: 'Amman · Sweifieh · Villa 8',
              orderId: '4821',
              escalatedTo: 'operator',
            ),
          ],
        ),
      );

  ModelSupportTicketRecord? createTicket({
    required String titleAr,
    required String titleEn,
    required String bodyAr,
    required String bodyEn,
    String? orderId,
  }) {
    if (titleEn.trim().isEmpty || bodyEn.trim().isEmpty) {
      return null;
    }
    final now = DateTime.now();
    final id = 'AYL-${_ticketSeq++}';
    final ticket = ModelSupportTicketRecord(
      id: id,
      titleAr: titleAr.trim(),
      titleEn: titleEn.trim(),
      bodyAr: bodyAr.trim(),
      bodyEn: bodyEn.trim(),
      status: SupportTicketStatus.open,
      createdAt: now,
      updatedAt: now,
      orderId: orderId,
      messages: [
        SupportTicketMessage(
          authorKey: 'customer',
          bodyAr: bodyAr.trim(),
          bodyEn: bodyEn.trim(),
          sentAt: now,
        ),
      ],
    );
    state = state.copyWith(tickets: [ticket, ...state.tickets]);
    return ticket;
  }

  bool updateTicketDetails(String ticketId, {
    String? customerPhone,
    String? customerAddress,
    int? slaTargetMinutes,
    SupportTicketPriority? priority,
  }) {
    final index = state.tickets.indexWhere((t) => t.id == ticketId);
    if (index == -1) return false;
    final updated = state.tickets[index].copyWith(
      customerPhone: customerPhone,
      customerAddress: customerAddress,
      slaTargetMinutes: slaTargetMinutes,
      priority: priority,
    );
    final next = [...state.tickets]..[index] = updated;
    state = state.copyWith(tickets: next);
    return true;
  }

  bool updateStatus(String ticketId, SupportTicketStatus status) {
    final index = state.tickets.indexWhere((t) => t.id == ticketId);
    if (index == -1) return false;
    final updated = state.tickets[index].copyWith(
      status: status,
      updatedAt: DateTime.now(),
    );
    final next = [...state.tickets]..[index] = updated;
    state = state.copyWith(tickets: next);
    return true;
  }

  bool addStaffReply({
    required String ticketId,
    required String bodyAr,
    required String bodyEn,
    SupportTicketStatus? nextStatus,
  }) {
    if (bodyEn.trim().isEmpty) return false;
    final index = state.tickets.indexWhere((t) => t.id == ticketId);
    if (index == -1) return false;
    final now = DateTime.now();
    final ticket = state.tickets[index];
    final updated = ticket.copyWith(
      status: nextStatus ?? SupportTicketStatus.waitingCustomer,
      updatedAt: now,
      messages: [
        ...ticket.messages,
        SupportTicketMessage(
          authorKey: 'support',
          bodyAr: bodyAr.trim(),
          bodyEn: bodyEn.trim(),
          sentAt: now,
          isStaff: true,
        ),
      ],
    );
    final next = [...state.tickets]..[index] = updated;
    state = state.copyWith(tickets: next);
    return true;
  }

  bool submitCustomerFeedback({
    required String ticketId,
    required int rating,
    String? feedback,
  }) {
    if (rating < 1 || rating > 5) return false;
    final index = state.tickets.indexWhere((t) => t.id == ticketId);
    if (index == -1) return false;
    final ticket = state.tickets[index];
    if (!ticket.canCustomerRate) return false;
    final updated = ticket.copyWith(
      customerRating: rating,
      customerFeedback: feedback?.trim(),
      status: SupportTicketStatus.closed,
      updatedAt: DateTime.now(),
    );
    final next = [...state.tickets]..[index] = updated;
    state = state.copyWith(tickets: next);
    return true;
  }

  bool requestFollowUp(String ticketId) {
    return _appendCustomerMessage(
      ticketId,
      bodyAr: 'طلب متابعة إضافية',
      bodyEn: 'Requested additional follow-up',
      nextStatus: SupportTicketStatus.inProgress,
    );
  }

  bool markUrgent(String ticketId) {
    final index = state.tickets.indexWhere((t) => t.id == ticketId);
    if (index == -1) return false;
    final ticket = state.tickets[index];
    if (ticket.status == SupportTicketStatus.closed) return false;
    final updated = ticket.copyWith(
      status: SupportTicketStatus.inProgress,
      updatedAt: DateTime.now(),
      titleEn: '${ticket.titleEn} [URGENT]',
      titleAr: '${ticket.titleAr} [عاجل]',
    );
    final next = [...state.tickets]..[index] = updated;
    state = state.copyWith(tickets: next);
    return true;
  }

  bool cancelTicket(String ticketId) {
    final index = state.tickets.indexWhere((t) => t.id == ticketId);
    if (index == -1) return false;
    final ticket = state.tickets[index];
    if (ticket.status == SupportTicketStatus.closed) return false;
    final updated = ticket.copyWith(
      status: SupportTicketStatus.closed,
      updatedAt: DateTime.now(),
    );
    final next = [...state.tickets]..[index] = updated;
    state = state.copyWith(tickets: next);
    return true;
  }

  bool addCustomerReply({
    required String ticketId,
    required String bodyAr,
    required String bodyEn,
  }) {
    return _appendCustomerMessage(
      ticketId,
      bodyAr: bodyAr,
      bodyEn: bodyEn,
      nextStatus: SupportTicketStatus.inProgress,
    );
  }

  bool _appendCustomerMessage(
    String ticketId, {
    required String bodyAr,
    required String bodyEn,
    required SupportTicketStatus nextStatus,
  }) {
    if (bodyEn.trim().isEmpty) return false;
    final index = state.tickets.indexWhere((t) => t.id == ticketId);
    if (index == -1) return false;
    final ticket = state.tickets[index];
    if (ticket.status == SupportTicketStatus.closed) return false;
    final now = DateTime.now();
    final updated = ticket.copyWith(
      status: nextStatus,
      updatedAt: now,
      messages: [
        ...ticket.messages,
        SupportTicketMessage(
          authorKey: 'customer',
          bodyAr: bodyAr.trim(),
          bodyEn: bodyEn.trim(),
          sentAt: now,
        ),
      ],
    );
    final next = [...state.tickets]..[index] = updated;
    state = state.copyWith(tickets: next);
    return true;
  }

  ModelSupportTicketRecord? ticketById(String id) {
    for (final ticket in state.tickets) {
      if (ticket.id == id) return ticket;
    }
    return null;
  }

  void refreshQueue() {
    final now = DateTime.now();
    state = state.copyWith(
      tickets: [
        for (final ticket in state.tickets)
          if (ticket.status == SupportTicketStatus.inProgress ||
              ticket.status == SupportTicketStatus.open)
            ticket.copyWith(updatedAt: now)
          else
            ticket,
      ],
    );
  }

  bool escalateTicket(String ticketId, String target) {
    final index = state.tickets.indexWhere((t) => t.id == ticketId);
    if (index == -1) return false;
    final ticket = state.tickets[index];
    final updated = ticket.copyWith(
      escalatedTo: target,
      status: SupportTicketStatus.inProgress,
      updatedAt: DateTime.now(),
    );
    final next = [...state.tickets]..[index] = updated;
    state = state.copyWith(tickets: next);
    return true;
  }

  bool acknowledgeEscalation(String ticketId) {
    final index = state.tickets.indexWhere((t) => t.id == ticketId);
    if (index == -1) return false;
    final ticket = state.tickets[index];
    if (ticket.escalatedTo == null) return false;
    final updated = ticket.copyWith(
      clearEscalation: true,
      updatedAt: DateTime.now(),
    );
    final next = [...state.tickets]..[index] = updated;
    state = state.copyWith(tickets: next);
    return true;
  }
}

final supportTicketsProvider =
    StateNotifierProvider<SupportTicketsNotifier, SupportTicketsState>(
      (ref) => SupportTicketsNotifier(),
    );

final supportTicketByIdProvider =
    Provider.family<ModelSupportTicketRecord?, String>((ref, id) {
      for (final ticket in ref.watch(supportTicketsProvider).tickets) {
        if (ticket.id == id) return ticket;
      }
      return null;
    });

class SupportChatMessage {
  const SupportChatMessage({
    required this.text,
    required this.fromAgent,
    required this.sentAt,
  });

  final String text;
  final bool fromAgent;
  final DateTime sentAt;
}

class SupportChatState {
  const SupportChatState({this.messages = const [], this.linkedTicketId});

  final List<SupportChatMessage> messages;
  final String? linkedTicketId;

  SupportChatState copyWith({
    List<SupportChatMessage>? messages,
    String? linkedTicketId,
    bool clearLinkedTicket = false,
  }) {
    return SupportChatState(
      messages: messages ?? this.messages,
      linkedTicketId:
          clearLinkedTicket ? null : (linkedTicketId ?? this.linkedTicketId),
    );
  }
}

class SupportChatNotifier extends StateNotifier<SupportChatState> {
  SupportChatNotifier() : super(const SupportChatState());

  void sendCustomerMessage(String text, {required bool isAr}) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    final now = DateTime.now();
    state = state.copyWith(
      messages: [
        ...state.messages,
        SupportChatMessage(text: trimmed, fromAgent: false, sentAt: now),
        SupportChatMessage(
          text:
              isAr
                  ? 'شكراً — سيرد فريق الدعم قريباً.'
                  : 'Thanks — a support agent will reply shortly.',
          fromAgent: true,
          sentAt: now.add(const Duration(milliseconds: 400)),
        ),
      ],
    );
  }

  void linkTicket(String ticketId) {
    state = state.copyWith(linkedTicketId: ticketId, messages: const []);
  }
}

final supportChatProvider =
    StateNotifierProvider<SupportChatNotifier, SupportChatState>(
      (ref) => SupportChatNotifier(),
    );
