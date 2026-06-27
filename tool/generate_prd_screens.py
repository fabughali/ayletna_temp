#!/usr/bin/env python3
"""Generate PRD screen Dart files (ui_design_prompt naming)."""
from __future__ import annotations

import os

ROOT = os.path.join(os.path.dirname(__file__), "..", "lib", "screens")

# folder, snake, ClassName, prd_name, l10n_title_key
SCREENS = [
    ("auth", "language_selection", "AuthLanguageSelectionScreen", "LanguageSelectionScreen", "screenLanguageSelection"),
    ("auth", "login", "AuthLoginScreen", "LoginScreen", "screenLogin"),
    ("auth", "otp_verification", "AuthOtpVerificationScreen", "OTPVerificationScreen", "screenOtpVerification"),
    ("auth", "register", "AuthRegisterScreen", "RegisterScreen", "screenRegister"),
    ("auth", "forgot_password", "AuthForgotPasswordScreen", "ForgotPasswordScreen", "screenForgotPassword"),
    ("auth", "role_selection", "AuthRoleSelectionScreen", "RoleSelectionScreen", "screenRoleSelection"),
    ("customer", "guest_browse", "CustomerGuestBrowseScreen", "GuestBrowseScreen", "screenGuestBrowse"),
    ("customer", "home", "CustomerHomeScreen", "HomeScreen", "screenHome"),
    ("customer", "category", "CustomerCategoryScreen", "CategoryScreen", "screenCategory"),
    ("customer", "product_detail", "CustomerProductDetailScreen", "ProductDetailScreen", "screenProductDetail"),
    ("customer", "cart", "CustomerCartScreen", "CartScreen", "screenCart"),
    ("customer", "order_type_selection", "CustomerOrderTypeSelectionScreen", "OrderTypeSelectionScreen", "screenOrderTypeSelection"),
    ("customer", "dine_in_table", "CustomerDineInTableScreen", "DineInTableScreen", "screenDineInTable"),
    ("customer", "takeaway_pickup", "CustomerTakeawayPickupScreen", "TakeawayPickupScreen", "screenTakeawayPickup"),
    ("customer", "delivery_address", "CustomerDeliveryAddressScreen", "DeliveryAddressScreen", "screenDeliveryAddress"),
    ("customer", "plated_delivery_info", "CustomerPlatedDeliveryInfoScreen", "PlatedDeliveryInfoScreen", "screenPlatedDeliveryInfo"),
    ("customer", "checkout", "CustomerCheckoutScreen", "CheckoutScreen", "screenCheckout"),
    ("customer", "tip_selection", "CustomerTipSelectionScreen", "TipSelectionScreen", "screenTipSelection"),
    ("customer", "payment", "CustomerPaymentScreen", "PaymentScreen", "screenPayment"),
    ("customer", "order_confirmation", "CustomerOrderConfirmationScreen", "OrderConfirmationScreen", "screenOrderConfirmation"),
    ("customer", "order_tracking", "CustomerOrderTrackingScreen", "OrderTrackingScreen", "screenOrderTracking"),
    ("customer", "order_history", "CustomerOrderHistoryScreen", "OrderHistoryScreen", "screenOrderHistory"),
    ("customer", "wallet", "CustomerWalletScreen", "WalletScreen", "screenWallet"),
    ("customer", "loyalty", "CustomerLoyaltyScreen", "LoyaltyScreen", "screenLoyalty"),
    ("customer", "rewards_catalog", "CustomerRewardsCatalogScreen", "RewardsCatalogScreen", "screenRewardsCatalog"),
    ("customer", "redemption_confirm", "CustomerRedemptionConfirmScreen", "RedemptionConfirmScreen", "screenRedemptionConfirm"),
    ("customer", "profile", "CustomerProfileScreen", "ProfileScreen", "screenProfile"),
    ("customer", "addresses", "CustomerAddressesScreen", "AddressesScreen", "screenAddresses"),
    ("customer", "map_picker", "CustomerMapPickerScreen", "MapPickerScreen", "screenMapPicker"),
    ("customer", "notifications", "CustomerNotificationsScreen", "NotificationsScreen", "screenNotifications"),
    ("customer", "plated_return_reminder", "CustomerPlatedReturnReminderScreen", "PlatedReturnReminderScreen", "screenPlatedReturnReminder"),
    ("customer", "offers", "CustomerOffersScreen", "OffersScreen", "screenOffers"),
    ("customer", "coupon_apply", "CustomerCouponApplyScreen", "CouponApplyScreen", "screenCouponApply"),
    ("customer", "combo_builder", "CustomerComboBuilderScreen", "ComboBuilderScreen", "screenComboBuilder"),
    ("kitchen", "dashboard", "KitchenDashboardScreen", "KitchenDashboardScreen", "screenKitchenDashboard"),
    ("kitchen", "order_prep", "KitchenOrderPrepScreen", "OrderPrepScreen", "screenOrderPrep"),
    ("inventory", "dashboard", "InventoryDashboardScreen", "InventoryDashboardScreen", "screenInventoryDashboard"),
    ("inventory", "item", "InventoryItemScreen", "InventoryItemScreen", "screenInventoryItem"),
    ("inventory", "stock_adjustment", "InventoryStockAdjustmentScreen", "StockAdjustmentScreen", "screenStockAdjustment"),
    ("delivery", "dashboard", "DeliveryDashboardScreen", "DeliveryDashboardScreen", "screenDeliveryDashboard"),
    ("delivery", "order", "DeliveryOrderScreen", "DeliveryOrderScreen", "screenDeliveryOrder"),
    ("delivery", "plated_return_task", "DeliveryPlatedReturnTaskScreen", "PlatedReturnTaskScreen", "screenPlatedReturnTask"),
    ("delivery", "plated_return_process", "DeliveryPlatedReturnProcessScreen", "PlatedReturnProcessScreen", "screenPlatedReturnProcess"),
    ("cashier", "order", "CashierOrderScreen", "CashierOrderScreen", "screenCashierOrder"),
    ("cashier", "tip_entry", "CashierTipEntryScreen", "CashierTipEntryScreen", "screenCashierTipEntry"),
    ("cashier", "deposit_refund", "CashierDepositRefundScreen", "CashierDepositRefundScreen", "screenCashierDepositRefund"),
    ("staff", "attendance", "StaffAttendanceScreen", "StaffAttendanceScreen", "screenStaffAttendance"),
    ("staff", "daily_tips", "StaffDailyTipsScreen", "StaffDailyTipsScreen", "screenStaffDailyTips"),
    ("staff", "tip_history", "StaffTipHistoryScreen", "StaffTipHistoryScreen", "screenStaffTipHistory"),
    ("admin", "dashboard", "AdminDashboardScreen", "AdminDashboardScreen", "screenAdminDashboard"),
    ("admin", "orders_management", "AdminOrdersManagementScreen", "OrdersManagementScreen", "screenOrdersManagement"),
    ("admin", "order_detail", "AdminOrderDetailScreen", "OrderDetailAdminScreen", "screenOrderDetailAdmin"),
    ("admin", "reports", "AdminReportsScreen", "ReportsScreen", "screenReports"),
    ("admin", "report_filter", "AdminReportFilterScreen", "ReportFilterScreen", "screenReportFilter"),
    ("admin", "financial_calculation", "AdminFinancialCalculationScreen", "FinancialCalculationScreen", "screenFinancialCalculation"),
    ("admin", "daily_tip_distribution", "AdminDailyTipDistributionScreen", "DailyTipDistributionScreen", "screenDailyTipDistribution"),
    ("admin", "plates_management", "AdminPlatesManagementScreen", "PlatesManagementScreen", "screenPlatesManagement"),
    ("admin", "plate_editor", "AdminPlateEditorScreen", "PlateEditorScreen", "screenPlateEditor"),
    ("admin", "deposit_config", "AdminDepositConfigScreen", "DepositConfigScreen", "screenDepositConfig"),
    ("admin", "user_management", "AdminUserManagementScreen", "UserManagementScreen", "screenUserManagement"),
    ("admin", "menu_management", "AdminMenuManagementScreen", "MenuManagementScreen", "screenMenuManagement"),
    ("admin", "product_editor", "AdminProductEditorScreen", "ProductEditorScreen", "screenProductEditor"),
    ("admin", "offers_management", "AdminOffersManagementScreen", "OffersManagementScreen", "screenOffersManagement"),
    ("admin", "loyalty_config", "AdminLoyaltyConfigScreen", "LoyaltyConfigScreen", "screenLoyaltyConfig"),
    ("admin", "owner_view_config", "AdminOwnerViewConfigScreen", "OwnerViewConfigScreen", "screenOwnerViewConfig"),
    ("admin", "pre_order", "AdminPreOrderScreen", "PreOrderScreen", "screenPreOrder"),
    ("admin", "settings", "AdminSettingsScreen", "SettingsScreen", "screenSettings"),
    ("admin", "audit_log", "AdminAuditLogScreen", "AuditLogScreen", "screenAuditLog"),
    ("admin", "staff_hours_report", "AdminStaffHoursReportScreen", "StaffHoursReportScreen", "screenStaffHoursReport"),
]

TEMPLATE = '''import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// PRD [{prd}].
class {cls} extends ConsumerWidget {{
  const {cls}({{super.key}});

  @override
  Widget build(BuildContext context, WidgetRef ref) {{
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return WidgetsScaffoldPage(
      title: l10n.{title_key},
      child: WidgetsRefreshList(
        onRefresh: () async {{}},
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Text(
              l10n.{desc_key},
              style: CoreTypography.bodyMedium(
                context,
                theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }}
}}
'''

SKIP = {
    "auth_language_selection",
    "auth_login",
    "auth_otp_verification",
    "auth_register",
    "auth_forgot_password",
    "auth_role_selection",
    "customer_home",
    "customer_guest_browse",
    "customer_order_type_selection",
    "customer_tip_selection",
    "customer_checkout",
    "customer_payment",
    "customer_order_tracking",
    "kitchen_dashboard",
    "delivery_plated_return_process",
    "delivery_dashboard",
    "cashier_order",
    "staff_attendance",
    "admin_dashboard",
}


def main() -> None:
    for folder, snake, cls, prd, title_key in SCREENS:
        key = f"{folder}_{snake}"
        if key in SKIP:
            continue
        path = os.path.join(ROOT, folder, f"{folder}_{snake}_screen.dart")
        os.makedirs(os.path.dirname(path), exist_ok=True)
        desc_key = f"{title_key}Desc"
        content = TEMPLATE.format(
            prd=prd,
            cls=cls,
            title_key=title_key,
            desc_key=desc_key,
        )
        with open(path, "w", encoding="utf-8") as f:
            f.write(content)
        print("wrote", path)


if __name__ == "__main__":
    main()
