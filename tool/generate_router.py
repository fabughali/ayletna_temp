#!/usr/bin/env python3
"""Generate core_router.dart with all GoRoutes."""
from __future__ import annotations

import os

ROUTES = [
    ("AppRoutePaths.splash", "AuthSplashScreen", "screens/auth/auth_splash_screen.dart"),
    ("AppRoutePaths.language", "AuthLanguageSelectionScreen", "screens/auth/auth_language_selection_screen.dart"),
    ("AppRoutePaths.login", "AuthLoginScreen", "screens/auth/auth_login_screen.dart"),
    ("AppRoutePaths.otp", "AuthOtpVerificationScreen", "screens/auth/auth_otp_verification_screen.dart"),
    ("AppRoutePaths.register", "AuthRegisterScreen", "screens/auth/auth_register_screen.dart"),
    ("AppRoutePaths.forgotPassword", "AuthForgotPasswordScreen", "screens/auth/auth_forgot_password_screen.dart"),
    ("AppRoutePaths.roleSelection", "AuthRoleSelectionScreen", "screens/auth/auth_role_selection_screen.dart"),
    ("AppRoutePaths.guest", "CustomerGuestBrowseScreen", "screens/customer/customer_guest_browse_screen.dart"),
    ("AppRoutePaths.home", "CustomerHomeScreen", "screens/customer/customer_home_screen.dart"),
    ("AppRoutePaths.category", "CustomerCategoryScreen", "screens/customer/customer_category_screen.dart"),
    ("AppRoutePaths.productDetail", "CustomerProductDetailScreen", "screens/customer/customer_product_detail_screen.dart"),
    ("AppRoutePaths.cart", "CustomerCartScreen", "screens/customer/customer_cart_screen.dart"),
    ("AppRoutePaths.orderType", "CustomerOrderTypeSelectionScreen", "screens/customer/customer_order_type_selection_screen.dart"),
    ("AppRoutePaths.dineIn", "CustomerDineInTableScreen", "screens/customer/customer_dine_in_table_screen.dart"),
    ("AppRoutePaths.takeaway", "CustomerTakeawayPickupScreen", "screens/customer/customer_takeaway_pickup_screen.dart"),
    ("AppRoutePaths.deliveryAddress", "CustomerDeliveryAddressScreen", "screens/customer/customer_delivery_address_screen.dart"),
    ("AppRoutePaths.platedInfo", "CustomerPlatedDeliveryInfoScreen", "screens/customer/customer_plated_delivery_info_screen.dart"),
    ("AppRoutePaths.checkout", "CustomerCheckoutScreen", "screens/customer/customer_checkout_screen.dart"),
    ("AppRoutePaths.tip", "CustomerTipSelectionScreen", "screens/customer/customer_tip_selection_screen.dart"),
    ("AppRoutePaths.payment", "CustomerPaymentScreen", "screens/customer/customer_payment_screen.dart"),
    ("AppRoutePaths.orderConfirmation", "CustomerOrderConfirmationScreen", "screens/customer/customer_order_confirmation_screen.dart"),
    ("AppRoutePaths.orderTracking", "CustomerOrderTrackingScreen", "screens/customer/customer_order_tracking_screen.dart"),
    ("AppRoutePaths.orderHistory", "CustomerOrderHistoryScreen", "screens/customer/customer_order_history_screen.dart"),
    ("AppRoutePaths.wallet", "CustomerWalletScreen", "screens/customer/customer_wallet_screen.dart"),
    ("AppRoutePaths.loyalty", "CustomerLoyaltyScreen", "screens/customer/customer_loyalty_screen.dart"),
    ("AppRoutePaths.rewards", "CustomerRewardsCatalogScreen", "screens/customer/customer_rewards_catalog_screen.dart"),
    ("AppRoutePaths.redemption", "CustomerRedemptionConfirmScreen", "screens/customer/customer_redemption_confirm_screen.dart"),
    ("AppRoutePaths.profile", "CustomerProfileScreen", "screens/customer/customer_profile_screen.dart"),
    ("AppRoutePaths.addresses", "CustomerAddressesScreen", "screens/customer/customer_addresses_screen.dart"),
    ("AppRoutePaths.mapPicker", "CustomerMapPickerScreen", "screens/customer/customer_map_picker_screen.dart"),
    ("AppRoutePaths.notifications", "CustomerNotificationsScreen", "screens/customer/customer_notifications_screen.dart"),
    ("AppRoutePaths.platedReturnReminder", "CustomerPlatedReturnReminderScreen", "screens/customer/customer_plated_return_reminder_screen.dart"),
    ("AppRoutePaths.offers", "CustomerOffersScreen", "screens/customer/customer_offers_screen.dart"),
    ("AppRoutePaths.coupon", "CustomerCouponApplyScreen", "screens/customer/customer_coupon_apply_screen.dart"),
    ("AppRoutePaths.combo", "CustomerComboBuilderScreen", "screens/customer/customer_combo_builder_screen.dart"),
    ("AppRoutePaths.kitchen", "KitchenDashboardScreen", "screens/kitchen/kitchen_dashboard_screen.dart"),
    ("AppRoutePaths.kitchenPrep", "KitchenOrderPrepScreen", "screens/kitchen/kitchen_order_prep_screen.dart"),
    ("AppRoutePaths.inventory", "InventoryDashboardScreen", "screens/inventory/inventory_dashboard_screen.dart"),
    ("AppRoutePaths.inventoryItem", "InventoryItemScreen", "screens/inventory/inventory_item_screen.dart"),
    ("AppRoutePaths.stockAdjustment", "InventoryStockAdjustmentScreen", "screens/inventory/inventory_stock_adjustment_screen.dart"),
    ("AppRoutePaths.delivery", "DeliveryDashboardScreen", "screens/delivery/delivery_dashboard_screen.dart"),
    ("AppRoutePaths.deliveryOrder", "DeliveryOrderScreen", "screens/delivery/delivery_order_screen.dart"),
    ("AppRoutePaths.platedReturnTask", "DeliveryPlatedReturnTaskScreen", "screens/delivery/delivery_plated_return_task_screen.dart"),
    ("AppRoutePaths.platedReturnProcess", "DeliveryPlatedReturnProcessScreen", "screens/delivery/delivery_plated_return_process_screen.dart"),
    ("AppRoutePaths.cashier", "CashierOrderScreen", "screens/cashier/cashier_order_screen.dart"),
    ("AppRoutePaths.cashierTip", "CashierTipEntryScreen", "screens/cashier/cashier_tip_entry_screen.dart"),
    ("AppRoutePaths.cashierDepositRefund", "CashierDepositRefundScreen", "screens/cashier/cashier_deposit_refund_screen.dart"),
    ("AppRoutePaths.staffAttendance", "StaffAttendanceScreen", "screens/staff/staff_attendance_screen.dart"),
    ("AppRoutePaths.staffTips", "StaffDailyTipsScreen", "screens/staff/staff_daily_tips_screen.dart"),
    ("AppRoutePaths.staffTipHistory", "StaffTipHistoryScreen", "screens/staff/staff_tip_history_screen.dart"),
    ("AppRoutePaths.admin", "AdminDashboardScreen", "screens/admin/admin_dashboard_screen.dart"),
    ("AppRoutePaths.adminOrders", "AdminOrdersManagementScreen", "screens/admin/admin_orders_management_screen.dart"),
    ("AppRoutePaths.adminOrderDetail", "AdminOrderDetailScreen", "screens/admin/admin_order_detail_screen.dart"),
    ("AppRoutePaths.adminReports", "AdminReportsScreen", "screens/admin/admin_reports_screen.dart"),
    ("AppRoutePaths.adminReportFilter", "AdminReportFilterScreen", "screens/admin/admin_report_filter_screen.dart"),
    ("AppRoutePaths.adminFinancial", "AdminFinancialCalculationScreen", "screens/admin/admin_financial_calculation_screen.dart"),
    ("AppRoutePaths.adminTipDistribution", "AdminDailyTipDistributionScreen", "screens/admin/admin_daily_tip_distribution_screen.dart"),
    ("AppRoutePaths.adminPlates", "AdminPlatesManagementScreen", "screens/admin/admin_plates_management_screen.dart"),
    ("AppRoutePaths.adminPlateEditor", "AdminPlateEditorScreen", "screens/admin/admin_plate_editor_screen.dart"),
    ("AppRoutePaths.adminDepositConfig", "AdminDepositConfigScreen", "screens/admin/admin_deposit_config_screen.dart"),
    ("AppRoutePaths.adminUsers", "AdminUserManagementScreen", "screens/admin/admin_user_management_screen.dart"),
    ("AppRoutePaths.adminMenu", "AdminMenuManagementScreen", "screens/admin/admin_menu_management_screen.dart"),
    ("AppRoutePaths.adminProductEditor", "AdminProductEditorScreen", "screens/admin/admin_product_editor_screen.dart"),
    ("AppRoutePaths.adminOffersMgmt", "AdminOffersManagementScreen", "screens/admin/admin_offers_management_screen.dart"),
    ("AppRoutePaths.adminLoyaltyConfig", "AdminLoyaltyConfigScreen", "screens/admin/admin_loyalty_config_screen.dart"),
    ("AppRoutePaths.adminOwnerConfig", "AdminOwnerViewConfigScreen", "screens/admin/admin_owner_view_config_screen.dart"),
    ("AppRoutePaths.adminPreOrder", "AdminPreOrderScreen", "screens/admin/admin_pre_order_screen.dart"),
    ("AppRoutePaths.adminSettings", "AdminSettingsScreen", "screens/admin/admin_settings_screen.dart"),
    ("AppRoutePaths.adminAudit", "AdminAuditLogScreen", "screens/admin/admin_audit_log_screen.dart"),
    ("AppRoutePaths.adminStaffHours", "AdminStaffHoursReportScreen", "screens/admin/admin_staff_hours_report_screen.dart"),
]

def main() -> None:
    imports = {}
    for _, cls, path in ROUTES:
        imports[cls] = path

    lines = [
        "import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';",
        "import 'package:flutter/material.dart';",
        "import 'package:flutter_riverpod/flutter_riverpod.dart';",
        "import 'package:go_router/go_router.dart';",
    ]
    for cls in sorted(imports):
        lines.append(
            f"import 'package:ayletna_restaurant_app/{imports[cls]}';"
        )

    lines += [
        "",
        "final goRouterProvider = Provider<GoRouter>((ref) {",
        "  return GoRouter(",
        "    initialLocation: AppRoutePaths.splash,",
        "    routes: [",
    ]
    for path_const, cls, _ in ROUTES:
        route_path = path_const.split(".")[1]
        # convert camelCase to kebab for path value - use AppRoutePaths const value
        lines.append(f"      GoRoute(")
        lines.append(f"        path: {path_const},")
        lines.append(f"        builder: (_, __) => const {cls}(),")
        lines.append(f"      ),")
    lines += [
        "    ],",
        "  );",
        "});",
        "",
        "/// PRD §6 navigation entry.",
        "abstract final class CoreRouter {",
        "  static GoRouter router(WidgetRef ref) => ref.read(goRouterProvider);",
        "}",
        "",
    ]

    out = os.path.join(os.path.dirname(__file__), "..", "lib", "core", "core_router.dart")
    with open(out, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))
    print("wrote", out)


if __name__ == "__main__":
    main()
