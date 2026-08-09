import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/providers/admin_dashboard_providers.dart';
import 'package:ayletna_restaurant_app/providers/user_profile_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OwnerDashboardMetrics {
  const OwnerDashboardMetrics({
    required this.shareJod,
    required this.netRevenueJod,
    required this.todayRevenueJod,
    required this.todayOrders,
  });

  final double shareJod;
  final double netRevenueJod;
  final double todayRevenueJod;
  final int todayOrders;
}

final ownerDashboardMetricsProvider = Provider<OwnerDashboardMetrics>((ref) {
  final profile = ref.watch(userProfileProvider);
  final ops = ref.watch(adminDashboardMetricsProvider);
  final sharePercent = profile.ownershipPercentage ?? 0;
  final netRevenueJod = MockupCatalog.financialNetRevenueJod;

  return OwnerDashboardMetrics(
    shareJod: netRevenueJod * (sharePercent / 100),
    netRevenueJod: netRevenueJod,
    todayRevenueJod: ops.revenueTodayJod,
    todayOrders: MockupCatalog.adminTodayOrders,
  );
});
