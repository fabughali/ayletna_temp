import 'package:ayletna_restaurant_app/data/models/model_support_ticket_record.dart';
import 'package:ayletna_restaurant_app/providers/reviews_admin_providers.dart';
import 'package:ayletna_restaurant_app/providers/support_chat_queue_providers.dart';
import 'package:ayletna_restaurant_app/providers/support_session_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SupportDashboardMetrics {
  const SupportDashboardMetrics({
    required this.openTickets,
    required this.inProgressTickets,
    required this.chatQueueCount,
    required this.pendingReviews,
    required this.avgWaitMinutes,
    required this.slaAtRisk,
    required this.slaBreached,
    required this.resolvedToday,
    required this.avgResponseMinutes,
  });

  final int openTickets;
  final int inProgressTickets;
  final int chatQueueCount;
  final int pendingReviews;
  final int avgWaitMinutes;
  final int slaAtRisk;
  final int slaBreached;
  final int resolvedToday;
  final int avgResponseMinutes;
}

final supportDashboardMetricsProvider = Provider<SupportDashboardMetrics>((
  ref,
) {
  final tickets = ref.watch(supportTicketsProvider).tickets;
  final reviews = ref.watch(reviewsModerationProvider).pendingReviews;
  final chatQueue = ref.watch(supportChatQueueProvider);
  final now = DateTime.now();

  final open =
      tickets.where((t) => t.status == SupportTicketStatus.open).length;
  final inProgress =
      tickets.where((t) => t.status == SupportTicketStatus.inProgress).length;

  var atRisk = 0;
  var breached = 0;
  for (final ticket in tickets) {
    final sla = ticket.slaState(now: now);
    if (sla == SupportSlaState.atRisk) atRisk++;
    if (sla == SupportSlaState.breached) breached++;
  }

  final resolvedToday =
      tickets.where((t) {
        if (t.status != SupportTicketStatus.resolved &&
            t.status != SupportTicketStatus.closed) {
          return false;
        }
        return t.updatedAt.isAfter(now.subtract(const Duration(hours: 24)));
      }).length;

  return SupportDashboardMetrics(
    openTickets: open,
    inProgressTickets: inProgress,
    chatQueueCount: chatQueue.length,
    pendingReviews: reviews.length,
    avgWaitMinutes: 11,
    slaAtRisk: atRisk,
    slaBreached: breached,
    resolvedToday: resolvedToday,
    avgResponseMinutes: 18,
  );
});

final supportOpenTicketsSummaryProvider = Provider<String>((ref) {
  final tickets = ref.watch(supportTicketsProvider).tickets;
  final open = tickets.where(
    (t) =>
        t.status == SupportTicketStatus.open ||
        t.status == SupportTicketStatus.inProgress,
  );
  if (open.isEmpty) return '';
  return open.map((t) => t.id).join(', ');
});

/// Tickets escalated to Operator or Cashier — operator hub inbox (O3).
final supportEscalatedTicketsProvider =
    Provider<List<ModelSupportTicketRecord>>((ref) {
  return ref
      .watch(supportTicketsProvider)
      .tickets
      .where((t) => t.escalatedTo != null)
      .toList();
});
