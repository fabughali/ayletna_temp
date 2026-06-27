#!/usr/bin/env python3
"""Patch placeholder screens to use UtilityScreenBodies."""
from __future__ import annotations

import os
import re

ROOT = os.path.join(os.path.dirname(__file__), "..", "lib", "screens")

IMPORTS = """import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/utilities/utility_screen_bodies.dart';
"""

TEMPLATE = '''import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/utilities/utility_screen_bodies.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// PRD [{prd}].
class {cls} extends ConsumerWidget {{
  const {cls}({{super.key}});

  static const _route = {route};

  @override
  Widget build(BuildContext context, WidgetRef ref) {{
    final l10n = AppLocalizations.of(context)!;
    return WidgetsScaffoldPage(
      title: l10n.{title_key},
      child: WidgetsRefreshList(
        onRefresh: () async {{}},
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UtilityScreenBodies.forPath(context, ref, _route),
          ],
        ),
      ),
    );
  }}
}}
'''

# Manual route map for generated screens
ROUTE_MAP = {
    "customer_dine_in_table_screen.dart": ("CustomerDineInTableScreen", "DineInTableScreen", "screenDineInTable", "AppRoutePaths.dineIn"),
    "customer_takeaway_pickup_screen.dart": ("CustomerTakeawayPickupScreen", "TakeawayPickupScreen", "screenTakeawayPickup", "AppRoutePaths.takeaway"),
    "customer_delivery_address_screen.dart": ("CustomerDeliveryAddressScreen", "DeliveryAddressScreen", "screenDeliveryAddress", "AppRoutePaths.deliveryAddress"),
    "customer_plated_delivery_info_screen.dart": ("CustomerPlatedDeliveryInfoScreen", "PlatedDeliveryInfoScreen", "screenPlatedDeliveryInfo", "AppRoutePaths.platedInfo"),
    "customer_order_confirmation_screen.dart": ("CustomerOrderConfirmationScreen", "OrderConfirmationScreen", "screenOrderConfirmation", "AppRoutePaths.orderConfirmation"),
    "customer_order_history_screen.dart": ("CustomerOrderHistoryScreen", "OrderHistoryScreen", "screenOrderHistory", "AppRoutePaths.orderHistory"),
    "customer_wallet_screen.dart": ("CustomerWalletScreen", "WalletScreen", "screenWallet", "AppRoutePaths.wallet"),
    "customer_loyalty_screen.dart": ("CustomerLoyaltyScreen", "LoyaltyScreen", "screenLoyalty", "AppRoutePaths.loyalty"),
    "customer_rewards_catalog_screen.dart": ("CustomerRewardsCatalogScreen", "RewardsCatalogScreen", "screenRewardsCatalog", "AppRoutePaths.rewards"),
    "customer_redemption_confirm_screen.dart": ("CustomerRedemptionConfirmScreen", "RedemptionConfirmScreen", "screenRedemptionConfirm", "AppRoutePaths.redemption"),
    "customer_profile_screen.dart": ("CustomerProfileScreen", "ProfileScreen", "screenProfile", "AppRoutePaths.profile"),
    "customer_addresses_screen.dart": ("CustomerAddressesScreen", "AddressesScreen", "screenAddresses", "AppRoutePaths.addresses"),
    "customer_map_picker_screen.dart": ("CustomerMapPickerScreen", "MapPickerScreen", "screenMapPicker", "AppRoutePaths.mapPicker"),
    "customer_notifications_screen.dart": ("CustomerNotificationsScreen", "NotificationsScreen", "screenNotifications", "AppRoutePaths.notifications"),
    "customer_plated_return_reminder_screen.dart": ("CustomerPlatedReturnReminderScreen", "PlatedReturnReminderScreen", "screenPlatedReturnReminder", "AppRoutePaths.platedReturnReminder"),
    "customer_offers_screen.dart": ("CustomerOffersScreen", "OffersScreen", "screenOffers", "AppRoutePaths.offers"),
    "customer_coupon_apply_screen.dart": ("CustomerCouponApplyScreen", "CouponApplyScreen", "screenCouponApply", "AppRoutePaths.coupon"),
    "customer_combo_builder_screen.dart": ("CustomerComboBuilderScreen", "ComboBuilderScreen", "screenComboBuilder", "AppRoutePaths.combo"),
    "kitchen_order_prep_screen.dart": ("KitchenOrderPrepScreen", "OrderPrepScreen", "screenOrderPrep", "AppRoutePaths.kitchenPrep"),
    "inventory_dashboard_screen.dart": ("InventoryDashboardScreen", "InventoryDashboardScreen", "screenInventoryDashboard", "AppRoutePaths.inventory"),
    "inventory_item_screen.dart": ("InventoryItemScreen", "InventoryItemScreen", "screenInventoryItem", "AppRoutePaths.inventoryItem"),
    "inventory_stock_adjustment_screen.dart": ("InventoryStockAdjustmentScreen", "StockAdjustmentScreen", "screenStockAdjustment", "AppRoutePaths.stockAdjustment"),
    "delivery_order_screen.dart": ("DeliveryOrderScreen", "DeliveryOrderScreen", "screenDeliveryOrder", "AppRoutePaths.deliveryOrder"),
    "delivery_plated_return_task_screen.dart": ("DeliveryPlatedReturnTaskScreen", "PlatedReturnTaskScreen", "screenPlatedReturnTask", "AppRoutePaths.platedReturnTask"),
    "cashier_tip_entry_screen.dart": ("CashierTipEntryScreen", "CashierTipEntryScreen", "screenCashierTipEntry", "AppRoutePaths.cashierTip"),
    "cashier_deposit_refund_screen.dart": ("CashierDepositRefundScreen", "CashierDepositRefundScreen", "screenCashierDepositRefund", "AppRoutePaths.cashierDepositRefund"),
    "staff_daily_tips_screen.dart": ("StaffDailyTipsScreen", "StaffDailyTipsScreen", "screenStaffDailyTips", "AppRoutePaths.staffTips"),
    "staff_tip_history_screen.dart": ("StaffTipHistoryScreen", "StaffTipHistoryScreen", "screenStaffTipHistory", "AppRoutePaths.staffTipHistory"),
    "admin_orders_management_screen.dart": ("AdminOrdersManagementScreen", "OrdersManagementScreen", "screenOrdersManagement", "AppRoutePaths.adminOrders"),
    "admin_order_detail_screen.dart": ("AdminOrderDetailScreen", "OrderDetailAdminScreen", "screenOrderDetailAdmin", "AppRoutePaths.adminOrderDetail"),
    "admin_reports_screen.dart": ("AdminReportsScreen", "ReportsScreen", "screenReports", "AppRoutePaths.adminReports"),
    "admin_report_filter_screen.dart": ("AdminReportFilterScreen", "ReportFilterScreen", "screenReportFilter", "AppRoutePaths.adminReportFilter"),
    "admin_financial_calculation_screen.dart": ("AdminFinancialCalculationScreen", "FinancialCalculationScreen", "screenFinancialCalculation", "AppRoutePaths.adminFinancial"),
    "admin_daily_tip_distribution_screen.dart": ("AdminDailyTipDistributionScreen", "DailyTipDistributionScreen", "screenDailyTipDistribution", "AppRoutePaths.adminTipDistribution"),
    "admin_plates_management_screen.dart": ("AdminPlatesManagementScreen", "PlatesManagementScreen", "screenPlatesManagement", "AppRoutePaths.adminPlates"),
    "admin_plate_editor_screen.dart": ("AdminPlateEditorScreen", "PlateEditorScreen", "screenPlateEditor", "AppRoutePaths.adminPlateEditor"),
    "admin_deposit_config_screen.dart": ("AdminDepositConfigScreen", "DepositConfigScreen", "screenDepositConfig", "AppRoutePaths.adminDepositConfig"),
    "admin_user_management_screen.dart": ("AdminUserManagementScreen", "UserManagementScreen", "screenUserManagement", "AppRoutePaths.adminUsers"),
    "admin_menu_management_screen.dart": ("AdminMenuManagementScreen", "MenuManagementScreen", "screenMenuManagement", "AppRoutePaths.adminMenu"),
    "admin_product_editor_screen.dart": ("AdminProductEditorScreen", "ProductEditorScreen", "screenProductEditor", "AppRoutePaths.adminProductEditor"),
    "admin_offers_management_screen.dart": ("AdminOffersManagementScreen", "OffersManagementScreen", "screenOffersManagement", "AppRoutePaths.adminOffersMgmt"),
    "admin_loyalty_config_screen.dart": ("AdminLoyaltyConfigScreen", "LoyaltyConfigScreen", "screenLoyaltyConfig", "AppRoutePaths.adminLoyaltyConfig"),
    "admin_owner_view_config_screen.dart": ("AdminOwnerViewConfigScreen", "OwnerViewConfigScreen", "screenOwnerViewConfig", "AppRoutePaths.adminOwnerConfig"),
    "admin_pre_order_screen.dart": ("AdminPreOrderScreen", "PreOrderScreen", "screenPreOrder", "AppRoutePaths.adminPreOrder"),
    "admin_settings_screen.dart": ("AdminSettingsScreen", "SettingsScreen", "screenSettings", "AppRoutePaths.adminSettings"),
    "admin_audit_log_screen.dart": ("AdminAuditLogScreen", "AuditLogScreen", "screenAuditLog", "AppRoutePaths.adminAudit"),
    "admin_staff_hours_report_screen.dart": ("AdminStaffHoursReportScreen", "StaffHoursReportScreen", "screenStaffHoursReport", "AppRoutePaths.adminStaffHours"),
}

SKIP = {
    "auth_otp_verification_screen.dart",
    "customer_checkout_screen.dart",
}


def main() -> None:
    for dirpath, _, files in os.walk(ROOT):
        for f in files:
            if not f.endswith("_screen.dart") or f not in ROUTE_MAP:
                if f.endswith("_screen.dart"):
                    path = os.path.join(dirpath, f)
                    with open(path, encoding="utf-8") as fh:
                        if "screen" in fh.read() and "Desc" in fh.read() and f not in SKIP:
                            if f in ROUTE_MAP:
                                pass
                continue
            if f in SKIP:
                continue
            cls, prd, title, route = ROUTE_MAP[f]
            content = TEMPLATE.format(cls=cls, prd=prd, title_key=title, route=route)
            path = os.path.join(dirpath, f)
            with open(path, "w", encoding="utf-8") as out:
                out.write(content)
            print("patched", path)


if __name__ == "__main__":
    main()
