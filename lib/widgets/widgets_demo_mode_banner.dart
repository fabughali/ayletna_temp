import 'package:ayletna_restaurant_app/core/app_config.dart';
import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:flutter/material.dart';

/// Persistent prototype banner for staff / ops routes using mock data.
class WidgetsDemoModeBanner extends StatelessWidget {
  const WidgetsDemoModeBanner({super.key});

  static bool showsForPath(String path) {
    if (!AppConfig.demoModeEnabled) return false;
    const exactPaths = {
      AppRoutePaths.cashier,
      AppRoutePaths.cashierTip,
      AppRoutePaths.cashierDepositRefund,
      AppRoutePaths.cashierOrderHistory,
      AppRoutePaths.kitchen,
      AppRoutePaths.kitchenPrep,
      AppRoutePaths.delivery,
      AppRoutePaths.deliveryOrder,
      AppRoutePaths.platedReturnTask,
      AppRoutePaths.platedReturnProcess,
      AppRoutePaths.inventory,
      AppRoutePaths.inventoryItem,
      AppRoutePaths.stockAdjustment,
      AppRoutePaths.staffAttendance,
      AppRoutePaths.staffTips,
      AppRoutePaths.staffTipHistory,
      AppRoutePaths.admin,
      AppRoutePaths.adminOrders,
      AppRoutePaths.adminOrderDetail,
      AppRoutePaths.adminReports,
      AppRoutePaths.adminReportFilter,
      AppRoutePaths.adminFinancial,
      AppRoutePaths.adminTipDistribution,
      AppRoutePaths.adminPlates,
      AppRoutePaths.adminPlateEditor,
      AppRoutePaths.adminDepositConfig,
      AppRoutePaths.adminUsers,
      AppRoutePaths.adminMenu,
      AppRoutePaths.adminProductEditor,
      AppRoutePaths.adminOffersMgmt,
      AppRoutePaths.adminLoyaltyConfig,
      AppRoutePaths.adminOwnerConfig,
      AppRoutePaths.adminPreOrder,
      AppRoutePaths.adminSettings,
      AppRoutePaths.adminAppIntegrations,
      AppRoutePaths.adminAudit,
      AppRoutePaths.adminStaffHours,
      AppRoutePaths.accountSettings,
    };
    return exactPaths.contains(path);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Material(
      color: CoreColors.brandGold.withValues(alpha: 0.14),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: CoreSpacing.md(context),
          vertical: CoreSpacing.sm(context),
        ),
        child: Row(
          children: [
            Icon(
              Icons.science_outlined,
              size: 18,
              color: theme.colorScheme.primary,
            ),
            SizedBox(width: CoreSpacing.sm(context)),
            Expanded(
              child: Text(
                l10n.demoModeBanner,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
