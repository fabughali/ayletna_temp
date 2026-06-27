# Ayletna Branding Migration Checklist

Use this checklist before and during the branding refactor. A screen is complete only when it uses the unified `Widgets*` component system for buttons, icon buttons, cards, navigation, status pills, headers, action bars, fields, amount rows, and repeated list items where applicable.

## Acceptance For Each Screen

- [ ] Uses `WidgetsScreenLayout` for screen body max width and padding.
- [ ] Uses shared button/icon button patterns; no local ad-hoc button styling.
- [ ] Uses `WidgetsAppCard`, `WidgetsMetricCard`, or `WidgetsChoiceCard` instead of one-off card shells.
- [ ] Uses `WidgetsStatusPill` for status, role, tier, order-type, and selected-state labels.
- [ ] Uses shared navigation/app bar/action bar widgets where applicable.
- [ ] Uses `WidgetsAmountLine` / `WidgetsFinancialSummary` for money/deposit/tip/refund summaries where applicable.
- [ ] Uses `WidgetsInfoBanner` for success/warning/info/policy/deposit notices.
- [ ] Uses `WidgetsIllustrationPanel` for CustomPaint/map/food/chart visual panels where applicable.
- [ ] Preserves PRD role, route, and workflow behavior; no visual migration changes product flow.
- [ ] Order-type UI uses icon + text + `CoreColors.orderType*`; never color alone.
- [ ] Tip, deposit, refund, and revenue lines remain visually separated and never merge into one total.
- [ ] Brand Gold / Orange surfaces use accessible foreground contrast per PRD §14.5.
- [ ] Has no raw colors, local typography overrides, ad-hoc breakpoints, hardcoded visible text, or legacy prototype branding.
- [ ] Passes `dart format`, `flutter analyze`, targeted lints, and relevant tests.

## Auth Screens

- [x] `lib/screens/auth/auth_forgot_password_screen.dart`
- [x] `lib/screens/auth/auth_language_selection_screen.dart`
- [x] `lib/screens/auth/auth_login_screen.dart`
- [x] `lib/screens/auth/auth_otp_verification_screen.dart`
- [x] `lib/screens/auth/auth_pending_approval_screen.dart`
- [x] `lib/screens/auth/auth_register_screen.dart`
- [x] `lib/screens/auth/auth_role_selection_screen.dart`
- [x] `lib/screens/auth/auth_splash_screen.dart`

## Customer Screens

- [x] `lib/screens/customer/customer_addresses_screen.dart`
- [x] `lib/screens/customer/customer_cart_screen.dart`
- [x] `lib/screens/customer/customer_category_screen.dart`
- [x] `lib/screens/customer/customer_checkout_screen.dart`
- [x] `lib/screens/customer/customer_combo_builder_screen.dart`
- [x] `lib/screens/customer/customer_coupon_apply_screen.dart`
- [x] `lib/screens/customer/customer_delivery_address_screen.dart`
- [x] `lib/screens/customer/customer_dine_in_table_screen.dart`
- [x] `lib/screens/customer/customer_edit_profile_screen.dart`
- [x] `lib/screens/customer/customer_guest_browse_screen.dart`
- [x] `lib/screens/customer/customer_home_screen.dart`
- [x] `lib/screens/customer/customer_loyalty_screen.dart`
- [x] `lib/screens/customer/customer_map_picker_screen.dart`
- [x] `lib/screens/customer/customer_notifications_screen.dart`
- [x] `lib/screens/customer/customer_offers_screen.dart`
- [x] `lib/screens/customer/customer_order_confirmation_screen.dart`
- [x] `lib/screens/customer/customer_order_history_screen.dart`
- [x] `lib/screens/customer/customer_order_tracking_screen.dart`
- [x] `lib/screens/customer/customer_order_type_selection_screen.dart`
- [x] `lib/screens/customer/customer_payment_screen.dart`
- [x] `lib/screens/customer/customer_plated_delivery_info_screen.dart`
- [x] `lib/screens/customer/customer_plated_return_reminder_screen.dart`
- [x] `lib/screens/customer/customer_profile_screen.dart`
- [x] `lib/screens/customer/customer_product_detail_screen.dart`
- [x] `lib/screens/customer/customer_redemption_confirm_screen.dart`
- [x] `lib/screens/customer/customer_rewards_catalog_screen.dart`
- [x] `lib/screens/customer/customer_takeaway_pickup_screen.dart`
- [x] `lib/screens/customer/customer_tip_selection_screen.dart`
- [x] `lib/screens/customer/customer_wallet_screen.dart`

## Kitchen Screens

- [x] `lib/screens/kitchen/kitchen_dashboard_screen.dart`
- [x] `lib/screens/kitchen/kitchen_order_prep_screen.dart`

## Delivery Screens

- [x] `lib/screens/delivery/delivery_dashboard_screen.dart`
- [x] `lib/screens/delivery/delivery_order_screen.dart`
- [x] `lib/screens/delivery/delivery_plated_return_process_screen.dart`
- [x] `lib/screens/delivery/delivery_plated_return_task_screen.dart`

## Cashier Screens

- [x] `lib/screens/cashier/cashier_deposit_refund_screen.dart`
- [x] `lib/screens/cashier/cashier_order_history_screen.dart`
- [x] `lib/screens/cashier/cashier_order_screen.dart`
- [x] `lib/screens/cashier/cashier_tip_entry_screen.dart`

## Inventory Screens

- [x] `lib/screens/inventory/inventory_dashboard_screen.dart`
- [x] `lib/screens/inventory/inventory_item_screen.dart`
- [x] `lib/screens/inventory/inventory_stock_adjustment_screen.dart`

## Staff Screens

- [x] `lib/screens/staff/staff_attendance_screen.dart`
- [x] `lib/screens/staff/staff_daily_tips_screen.dart`
- [x] `lib/screens/staff/staff_tip_history_screen.dart`

## Admin Screens

- [x] `lib/screens/admin/admin_audit_log_screen.dart`
- [x] `lib/screens/admin/admin_dashboard_screen.dart`
- [x] `lib/screens/admin/admin_daily_tip_distribution_screen.dart`
- [x] `lib/screens/admin/admin_deposit_config_screen.dart`
- [x] `lib/screens/admin/admin_financial_calculation_screen.dart`
- [x] `lib/screens/admin/admin_loyalty_config_screen.dart`
- [x] `lib/screens/admin/admin_menu_management_screen.dart`
- [x] `lib/screens/admin/admin_offers_management_screen.dart`
- [x] `lib/screens/admin/admin_order_detail_screen.dart`
- [x] `lib/screens/admin/admin_orders_management_screen.dart`
- [x] `lib/screens/admin/admin_owner_view_config_screen.dart`
- [x] `lib/screens/admin/admin_plate_editor_screen.dart`
- [x] `lib/screens/admin/admin_plates_management_screen.dart`
- [x] `lib/screens/admin/admin_pre_order_screen.dart`
- [x] `lib/screens/admin/admin_product_editor_screen.dart`
- [x] `lib/screens/admin/admin_report_filter_screen.dart`
- [x] `lib/screens/admin/admin_reports_screen.dart`
- [x] `lib/screens/admin/admin_settings_screen.dart`
- [x] `lib/screens/admin/admin_staff_hours_report_screen.dart`
- [x] `lib/screens/admin/admin_user_management_screen.dart`

## Shared UI Surfaces

- [x] `lib/widgets/widgets_customization_sheet.dart`
- [x] `lib/widgets/widgets_product_preview_sheet.dart`
- [x] `lib/widgets/widgets_customer_shell.dart`
- [x] `lib/widgets/widgets_order_type_selector.dart`
- [x] `lib/widgets/widgets_tip_selector.dart`

## Shared Widget Foundation

- [x] `lib/widgets/widgets_app_button.dart`
- [x] `lib/widgets/widgets_icon_button.dart`
- [x] `lib/widgets/widgets_app_card.dart`
- [x] `lib/widgets/widgets_metric_card.dart`
- [x] `lib/widgets/widgets_choice_card.dart`
- [x] `lib/widgets/widgets_app_bar.dart`
- [x] `lib/widgets/widgets_bottom_navigation.dart`
- [x] `lib/widgets/widgets_action_bar.dart`
- [x] `lib/widgets/widgets_page_header.dart`
- [x] `lib/widgets/widgets_status_pill.dart`
- [x] `lib/widgets/widgets_info_banner.dart`
- [x] `lib/widgets/widgets_step_progress.dart`
- [x] `lib/widgets/widgets_list_item.dart`
- [x] `lib/widgets/widgets_amount_line.dart`
- [x] `lib/widgets/widgets_financial_summary.dart`
- [x] `lib/widgets/widgets_app_text_field.dart`
- [x] `lib/widgets/widgets_filter_chip.dart`
- [x] `lib/widgets/widgets_quantity_stepper.dart`
- [x] `lib/widgets/widgets_illustration_panel.dart`
- [x] `lib/widgets/widgets_progress_bar.dart`
- [x] `lib/widgets/widgets_avatar.dart`

## Branding Audit Follow-up

- [x] `lib/utilities/utility_screen_bodies.dart` `_MapPlaceholderBody` replaces raw `Card`.
- [x] `lib/utilities/utility_screen_bodies.dart` `_BalanceCard` replaces raw `Card`.
- [x] `lib/utilities/utility_screen_bodies.dart` `_ProfileForm` replaces raw `TextField`.
- [x] `lib/widgets/widgets_product_preview_sheet.dart` replaces raw `TextButton`.
- [x] `lib/widgets/widgets_menu_item_card.dart` replaces raw `Card` / `CircleAvatar`.
- [x] `lib/widgets/widgets_order_card.dart` replaces raw `Card`.
- [x] `lib/widgets/widgets_plate_counter.dart` replaces raw `IconButton`.
- [x] `lib/widgets/widgets_role_card.dart` replaces raw `Card` / `CircleAvatar`.
- [x] `lib/widgets/widgets_nav_tile.dart` replaces raw `Card` / `ListTile`.
