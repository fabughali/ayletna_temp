import 'package:ayletna_restaurant_app/core/core_color_scheme.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/navigation/checkout_route_redirect.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/session_providers.dart';
import 'package:ayletna_restaurant_app/screens/auth/auth_pending_approval_screen.dart';
import 'package:ayletna_restaurant_app/utilities/utility_route_guard.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_customer_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_app_integrations_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_audit_log_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_daily_tip_distribution_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_dashboard_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_deposit_config_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_financial_calculation_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_loyalty_config_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_menu_catalog_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_menu_management_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_offers_management_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_order_detail_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_orders_management_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_owner_view_config_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_plate_editor_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_plates_management_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_pre_order_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_product_editor_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_report_filter_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_reports_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_settings_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_attendance_hr_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_reviews_moderation_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_rewards_management_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_support_tickets_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_user_management_screen.dart';
import 'package:ayletna_restaurant_app/screens/auth/auth_forgot_password_screen.dart';
import 'package:ayletna_restaurant_app/screens/auth/auth_language_selection_screen.dart';
import 'package:ayletna_restaurant_app/screens/auth/auth_login_screen.dart';
import 'package:ayletna_restaurant_app/screens/auth/auth_otp_verification_screen.dart';
import 'package:ayletna_restaurant_app/screens/auth/auth_register_screen.dart';
import 'package:ayletna_restaurant_app/screens/auth/auth_role_selection_screen.dart';
import 'package:ayletna_restaurant_app/screens/auth/auth_splash_screen.dart';
import 'package:ayletna_restaurant_app/screens/cashier/cashier_deposit_refund_screen.dart';
import 'package:ayletna_restaurant_app/screens/cashier/cashier_order_screen.dart';
import 'package:ayletna_restaurant_app/screens/cashier/cashier_order_history_screen.dart';
import 'package:ayletna_restaurant_app/screens/cashier/cashier_tip_entry_screen.dart';
import 'package:ayletna_restaurant_app/screens/shared/user_personal_settings_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_addresses_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_cart_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_checkout_payment_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_checkout_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_category_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_combo_builder_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_discounts_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_edit_profile_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_faq_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_home_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_loyalty_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_map_picker_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_notifications_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_offers_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_order_confirmation_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_order_history_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_order_tracking_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_payment_history_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_plated_return_reminder_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_product_detail_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_product_reviews_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_profile_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_rating_review_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_redemption_confirm_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_rewards_catalog_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_rewards_history_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_search_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_support_chat_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_support_screen.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_terms_screen.dart';
import 'package:ayletna_restaurant_app/screens/delivery/delivery_dashboard_screen.dart';
import 'package:ayletna_restaurant_app/screens/delivery/delivery_order_screen.dart';
import 'package:ayletna_restaurant_app/screens/delivery/delivery_plated_return_process_screen.dart';
import 'package:ayletna_restaurant_app/screens/delivery/delivery_plated_return_task_screen.dart';
import 'package:ayletna_restaurant_app/screens/inventory/inventory_dashboard_screen.dart';
import 'package:ayletna_restaurant_app/screens/inventory/inventory_item_screen.dart';
import 'package:ayletna_restaurant_app/screens/inventory/inventory_stock_adjustment_screen.dart';
import 'package:ayletna_restaurant_app/screens/kitchen/kitchen_dashboard_screen.dart';
import 'package:ayletna_restaurant_app/screens/kitchen/kitchen_order_prep_screen.dart';
import 'package:ayletna_restaurant_app/screens/staff/staff_attendance_screen.dart';
import 'package:ayletna_restaurant_app/screens/staff/staff_daily_tips_screen.dart';
import 'package:ayletna_restaurant_app/screens/staff/staff_tip_history_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref.listen(sessionProvider, (_, __) => refresh.value++);
  ref.listen(appRoleProvider, (_, __) => refresh.value++);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: AppRoutePaths.splash,
    refreshListenable: refresh,
    redirect: (context, state) => UtilityRouteGuard.redirect(ref, state),
    routes: [
      GoRoute(
        path: AppRoutePaths.splash,
        builder: (_, __) => const AuthSplashScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.pendingApproval,
        builder: (_, __) => const AuthPendingApprovalScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.language,
        builder: (_, __) => const AuthLanguageSelectionScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.login,
        builder: (_, __) => const AuthLoginScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.otp,
        builder:
            (_, state) => AuthOtpVerificationScreen(
              source: state.uri.queryParameters['source'] ?? 'login',
            ),
      ),
      GoRoute(
        path: AppRoutePaths.register,
        builder:
            (_, state) => AuthRegisterScreen(
              initialStep: int.tryParse(
                state.uri.queryParameters['step'] ?? '',
              ),
            ),
      ),
      GoRoute(
        path: AppRoutePaths.forgotPassword,
        builder: (_, __) => const AuthForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.roleSelection,
        builder: (_, __) => const AuthRoleSelectionScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.guest,
        builder:
            (context, _) => Consumer(
              builder: (context, ref, _) {
                ref.read(appRoleProvider.notifier).state = AppRole.guest;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (context.mounted) context.go(AppRoutePaths.home);
                });
                return const SizedBox.shrink();
              },
            ),
      ),
      ShellRoute(
        builder: (_, __, child) => WidgetsCustomerShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutePaths.home,
            builder: (_, __) => const CustomerHomeScreen(),
          ),
          GoRoute(
            path: AppRoutePaths.search,
            builder:
                (_, state) => CustomerSearchScreen(
                  initialQuery: state.uri.queryParameters['q'] ?? '',
                ),
          ),
          GoRoute(
            path: AppRoutePaths.cart,
            builder: (_, __) => const CustomerCartScreen(),
          ),
          GoRoute(
            path: AppRoutePaths.support,
            builder: (_, __) => const CustomerSupportScreen(),
          ),
          GoRoute(
            path: AppRoutePaths.supportChat,
            builder: (_, __) => const CustomerSupportChatScreen(),
          ),
          GoRoute(
            path: AppRoutePaths.faq,
            builder: (_, __) => const CustomerFaqScreen(),
          ),
          GoRoute(
            path: AppRoutePaths.notifications,
            builder: (_, __) => const CustomerNotificationsScreen(),
          ),
          GoRoute(
            path: AppRoutePaths.profile,
            builder: (_, __) => const CustomerProfileScreen(),
          ),
          GoRoute(
            path: AppRoutePaths.orderHistory,
            builder: (_, __) => const CustomerOrderHistoryScreen(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutePaths.category,
        builder: (_, __) => const CustomerCategoryScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.productDetail,
        builder: (_, __) => const CustomerProductDetailScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.productReviews,
        builder: (_, __) => const CustomerProductReviewsScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.terms,
        builder: (_, __) => const CustomerTermsScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.orderType,
        redirect:
            (_, __) => redirectCollapsedCheckoutRoute(AppRoutePaths.orderType),
      ),
      GoRoute(
        path: AppRoutePaths.dineIn,
        redirect:
            (_, __) => redirectCollapsedCheckoutRoute(AppRoutePaths.dineIn),
      ),
      GoRoute(
        path: AppRoutePaths.takeaway,
        redirect:
            (_, __) => redirectCollapsedCheckoutRoute(AppRoutePaths.takeaway),
      ),
      GoRoute(
        path: AppRoutePaths.deliveryAddress,
        redirect:
            (_, __) =>
                redirectCollapsedCheckoutRoute(AppRoutePaths.deliveryAddress),
      ),
      GoRoute(
        path: AppRoutePaths.platedInfo,
        redirect:
            (_, __) => redirectCollapsedCheckoutRoute(AppRoutePaths.platedInfo),
      ),
      GoRoute(
        path: AppRoutePaths.checkout,
        redirect:
            (_, __) => redirectCollapsedCheckoutRoute(AppRoutePaths.checkout),
        builder: (_, __) => const CustomerCheckoutScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.tip,
        redirect: (_, __) => redirectCollapsedCheckoutRoute(AppRoutePaths.tip),
      ),
      GoRoute(
        path: AppRoutePaths.payment,
        redirect:
            (_, __) => redirectCollapsedCheckoutRoute(AppRoutePaths.payment),
        builder: (_, __) => const CustomerCheckoutPaymentScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.orderConfirmation,
        builder: (_, __) => const CustomerOrderConfirmationScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.orderTracking,
        builder: (_, __) => const CustomerOrderTrackingScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.ratingReview,
        builder: (_, __) => const CustomerRatingReviewScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.wallet,
        redirect: (_, __) => AppRoutePaths.profile,
      ),
      GoRoute(
        path: AppRoutePaths.loyalty,
        builder: (_, __) => const CustomerLoyaltyScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.rewards,
        builder: (_, __) => const CustomerRewardsCatalogScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.rewardsHistory,
        builder: (_, __) => const CustomerRewardsHistoryScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.paymentHistory,
        builder: (_, __) => const CustomerPaymentHistoryScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.redemption,
        builder: (_, __) => const CustomerRedemptionConfirmScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.addresses,
        builder: (_, __) => const CustomerAddressesScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.editProfile,
        builder: (_, __) => const CustomerEditProfileScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.accountSettings,
        builder: (_, __) => const UserPersonalSettingsScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.mapPicker,
        builder:
            (_, state) => CustomerMapPickerScreen(
              returnRoute:
                  state.uri.queryParameters['return'] == 'profile'
                      ? AppRoutePaths.profile
                      : AppRoutePaths.cart,
            ),
      ),
      GoRoute(
        path: AppRoutePaths.platedReturnReminder,
        builder: (_, __) => const CustomerPlatedReturnReminderScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.offers,
        builder: (_, __) => const CustomerOffersScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.discounts,
        builder: (_, __) => const CustomerDiscountsScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.coupon,
        redirect: (_, __) => AppRoutePaths.cart,
      ),
      GoRoute(
        path: AppRoutePaths.combo,
        builder: (_, __) => const CustomerComboBuilderScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.kitchen,
        builder: (_, __) => const KitchenDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.kitchenPrep,
        builder: (_, __) => const KitchenOrderPrepScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.inventory,
        builder: (_, __) => const InventoryDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.inventoryItem,
        builder: (_, __) => const InventoryItemScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.stockAdjustment,
        builder: (_, __) => const InventoryStockAdjustmentScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.delivery,
        builder: (_, __) => const DeliveryDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.deliveryOrder,
        builder: (_, __) => const DeliveryOrderScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.platedReturnTask,
        builder: (_, __) => const DeliveryPlatedReturnTaskScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.platedReturnProcess,
        builder: (_, __) => const DeliveryPlatedReturnProcessScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.cashier,
        builder: (_, __) => const CashierOrderScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.cashierTip,
        builder: (_, __) => const CashierTipEntryScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.cashierDepositRefund,
        builder: (_, __) => const CashierDepositRefundScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.cashierOrderHistory,
        builder: (_, __) => const CashierOrderHistoryScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.staffAttendance,
        builder: (_, __) => const StaffAttendanceScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.staffTips,
        builder: (_, __) => const StaffDailyTipsScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.staffTipHistory,
        builder: (_, __) => const StaffTipHistoryScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.admin,
        builder: (_, __) => const AdminDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.adminOrders,
        builder: (_, __) => const AdminOrdersManagementScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.adminOrderDetail,
        builder:
            (_, state) => AdminOrderDetailScreen(
              orderId: state.uri.queryParameters['id'],
            ),
      ),
      GoRoute(
        path: AppRoutePaths.adminReports,
        builder: (_, __) => const AdminReportsScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.adminReportFilter,
        builder: (_, __) => const AdminReportFilterScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.adminFinancial,
        builder: (_, __) => const AdminFinancialCalculationScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.adminTipDistribution,
        builder: (_, __) => const AdminDailyTipDistributionScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.adminPlates,
        builder: (_, __) => const AdminPlatesManagementScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.adminPlateEditor,
        builder: (_, __) => const AdminPlateEditorScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.adminDepositConfig,
        builder: (_, __) => const AdminDepositConfigScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.adminUsers,
        builder: (_, __) => const AdminUserManagementScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.adminMenu,
        builder: (_, __) => const AdminMenuManagementScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.adminProductEditor,
        builder: (_, state) => AdminProductEditorScreen(
          createMode: state.uri.queryParameters['mode'] == 'create',
          productId: state.uri.queryParameters['id'],
        ),
      ),
      GoRoute(
        path: AppRoutePaths.adminMenuCatalog,
        builder: (_, __) => const AdminMenuCatalogScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.adminOffersMgmt,
        builder: (_, __) => const AdminOffersManagementScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.adminLoyaltyConfig,
        builder: (_, __) => const AdminLoyaltyConfigScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.adminOwnerConfig,
        builder: (_, __) => const AdminOwnerViewConfigScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.adminPreOrder,
        builder: (_, __) => const AdminPreOrderScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.adminSettings,
        builder: (_, __) => const AdminSettingsScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.adminAppIntegrations,
        builder: (_, __) => const AdminAppIntegrationsScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.adminAudit,
        builder: (_, __) => const AdminAuditLogScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.adminStaffHours,
        builder: (_, __) => const AdminAttendanceHrScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.adminAttendanceHr,
        builder: (_, __) => const AdminAttendanceHrScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.adminSupportTickets,
        builder: (_, __) => const AdminSupportTicketsScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.adminRewardsMgmt,
        builder: (_, __) => const AdminRewardsManagementScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.adminReviewsModeration,
        builder: (_, __) => const AdminReviewsModerationScreen(),
      ),
      GoRoute(
        path: '/order/:id',
        builder:
            (_, state) => CustomerOrderTrackingScreen(
              orderId: state.pathParameters['id'],
            ),
      ),
      GoRoute(
        path: AppRoutePaths.paymentCallback,
        redirect: (_, __) => AppRoutePaths.orderConfirmation,
      ),
      GoRoute(
        path: '/tip/daily/:date',
        builder: (_, __) => const AdminDailyTipDistributionScreen(),
      ),
    ],
  );
});

/// PRD §6 navigation entry.
abstract final class CoreRouter {
  static GoRouter router(WidgetRef ref) => ref.read(goRouterProvider);
}
