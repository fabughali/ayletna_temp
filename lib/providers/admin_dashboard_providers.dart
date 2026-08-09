import 'package:ayletna_restaurant_app/core/core_color_scheme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_order_summary.dart';
import 'package:ayletna_restaurant_app/data/models/model_support_ticket_record.dart';
import 'package:ayletna_restaurant_app/providers/admin_plates_providers.dart';
import 'package:ayletna_restaurant_app/providers/admin_session_providers.dart';
import 'package:ayletna_restaurant_app/providers/support_session_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminDashboardMetrics {
  const AdminDashboardMetrics({
    required this.activeOrderCount,
    required this.dineInCount,
    required this.takeawayCount,
    required this.deliveryCount,
    required this.platedCount,
    required this.revenueTodayJod,
    required this.tipsPoolJod,
    required this.breakageLossJod,
    required this.urgentAlerts,
    required this.grillLoadPercent,
    required this.coldPrepLoadPercent,
    required this.liveOrders,
  });

  final int activeOrderCount;
  final int dineInCount;
  final int takeawayCount;
  final int deliveryCount;
  final int platedCount;
  final double revenueTodayJod;
  final double tipsPoolJod;
  final double breakageLossJod;
  final int urgentAlerts;
  final int grillLoadPercent;
  final int coldPrepLoadPercent;
  final List<ModelOrderSummary> liveOrders;
}

final adminDashboardMetricsProvider = Provider<AdminDashboardMetrics>((ref) {
  final orders = ref.watch(adminActiveOrdersProvider);
  final tickets = ref.watch(supportTicketsProvider).tickets;
  final plates = ref.watch(adminPlatesProvider);

  int countType(OrderType type) =>
      orders.where((order) => order.orderType == type).length;

  final revenueFromOrders = orders.fold<double>(
    0,
    (sum, order) => sum + order.totalJod,
  );
  final revenueTodayJod =
      revenueFromOrders > 0 ? revenueFromOrders : MockupCatalog.adminRevenueJod;

  final tipsFromOrders = orders.fold<double>(
    0,
    (sum, order) => sum + order.totalJod * 0.08,
  );
  final tipsPoolJod =
      tipsFromOrders > 0 ? tipsFromOrders : MockupCatalog.adminTipPoolJod;

  final openTickets =
      tickets
          .where(
            (ticket) =>
                ticket.status == SupportTicketStatus.open ||
                ticket.status == SupportTicketStatus.inProgress,
          )
          .length;
  final stockAlerts = MockupCatalog.inventoryAlerts.length;
  final urgentAlerts = openTickets + (stockAlerts >= 3 ? 2 : 0);

  final loadBase = orders.length.clamp(0, 8);
  final grillLoadPercent = (35 + loadBase * 8).clamp(0, 100);
  final coldPrepLoadPercent = (28 + loadBase * 6).clamp(0, 100);

  final breakageLossJod =
      plates.totalBreakageLossJod > 0
          ? plates.totalBreakageLossJod
          : MockupCatalog.adminLossBreakageJod;

  return AdminDashboardMetrics(
    activeOrderCount: orders.length,
    dineInCount: countType(OrderType.dineIn),
    takeawayCount: countType(OrderType.takeaway),
    deliveryCount: countType(OrderType.delivery),
    platedCount: countType(OrderType.platedDelivery),
    revenueTodayJod: revenueTodayJod,
    tipsPoolJod: tipsPoolJod,
    breakageLossJod: breakageLossJod,
    urgentAlerts: urgentAlerts,
    grillLoadPercent: grillLoadPercent,
    coldPrepLoadPercent: coldPrepLoadPercent,
    liveOrders: orders,
  );
});

/// Operator hub metrics ([adminDashboardMetricsProvider] is ops-only).
final operatorDashboardMetricsProvider = adminDashboardMetricsProvider;
