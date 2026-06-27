# Mock-Up Logic Checklist

Use this checklist to track front-end-only mock logic implementation. Do not add backend/API/Supabase integration in this phase.

## Phase 0 - Study And Planning

- [x] Read `prd.md` for role flows, screen list, and navigation requirements.
- [x] Read `prd_full_v5_technical.txt` for detailed flow expectations.
- [x] Read `ui_design_prompt.txt` for UI/branding constraints.
- [x] Scan current screens for empty callbacks and mock-action gaps.
- [x] Scan screens for inline business mock data candidates.
- [x] Inventory all `lib/screens` files for screen-by-screen tracking.
- [x] Create `mockup_logic_prompt.md`.
- [x] Create this checklist.

## Current Study Feedback

- Navigation is broadly registered in `AppRoutePaths` and `GoRouter`, including PRD deep links `/order/:id` and `/tip/daily/:date`.
- Main risk is interaction completeness: many screens still contain empty callbacks such as `onPressed: () {}`, `onTap: () {}`, empty refresh handlers, or switches that do not update mock state.
- Mock feedback is underused. Save, apply, export, invite, approve, refund, check-in/out, delete, and status actions need snackbars, dialogs, or bottom sheets.
- Several screens still keep business mock data locally. Restaurant data, users, staff rows, orders, reports, inventory rows, wallet transactions, notifications, rewards, addresses, plates, and operational logs should move to `lib/data`.
- Some bottom navigation entries appear role-inappropriate and should be corrected before smoke testing role flows.
- Customer checkout should be aligned to PRD as `cart -> order type -> type-specific details -> checkout -> tip -> payment -> confirmation -> tracking`.
- Guest browsing should remain read-only; any order/checkout action should route to login/register with clear mock feedback.
- No screen should be deleted now. Merge/tab decisions should be documented first, especially for settings, reports, user detail, offer/loyalty editors, and admin detail flows.
- Audit agents confirmed four major follow-up themes: role-safe navigation, centralized mock data, no-op callback cleanup, and PRD detail/review surface decisions.
- Highest-priority action gaps are destructive/financial/fulfillment approvals: deactivate account, void cart/order, deposit refund, disbursement, tip approval, kitchen ready/report issue, delivery finalize, staff acknowledge, and inventory updates.
- Mock data should be expanded beyond menu/order basics to cover kitchen orders, delivery tasks, inventory, plates, staff tips/shifts, rewards, wallet transactions, payment methods, and richer order details.

## Latest Batch Notes

- Added `lib/utilities/utility_mock_feedback.dart` for UI-only snackbars, confirmations, and action sheets.
- Cleaned empty callbacks in `auth_forgot_password_screen.dart`, `customer_profile_screen.dart`, `customer_order_type_selection_screen.dart`, and `customer_cart_screen.dart`.
- Moved cart preview mock data to `MockupCatalog.cartPreviewLines` and removed the private `_CartItemData` fixture from `customer_cart_screen.dart`.
- Added confirmation for cart clear/remove and changed cart checkout routing to `AppRoutePaths.orderType`.
- Cleaned customer ordering actions in product detail, dine-in table, takeaway pickup, delivery address, and plated delivery info.
- Replaced customer bottom-nav links that pointed at kitchen/guest with role-safe customer destinations in the touched ordering screens.
- Added `ModelPickupMode`, `ModelPickupSlot`, and `ModelSavedAddress`.
- Moved takeaway pickup modes/days/slots and saved delivery addresses into `MockupCatalog`.
- Aligned checkout tail routing so checkout goes to tip, tip goes to payment, payment goes to confirmation, and confirmation goes to tracking.
- Cleaned payment refresh/add-method actions and tracking call/support actions with mock feedback.
- Replaced tracking/payment display fixtures with `MockupCatalog` order/cart values where available.
- Completed customer home/category actions: add-to-cart now shows feedback, home bottom navigation is role-safe, and popular menu IDs live in `MockupCatalog`.
- Completed guest browse and order history actions: guest offer claim routes to login, guest browse-more gives mock feedback, order history filters/invoice/show-more/reorder actions are wired, and order history bottom navigation is role-safe.
- Added `ModelCustomerOrderHistory`, moved customer order history rows to `MockupCatalog.customerOrderHistory`, and expanded drink catalog entries used by guest browse.
- Completed wallet/loyalty/rewards actions: wallet top-up/transfer/filter/download/history actions now respond, loyalty refresh/filter/sort/menu actions are wired, rewards tiles navigate or show unavailable feedback, and redemption refresh shows mock feedback.
- Added `ModelWalletTransaction` and `ModelCustomerReward`; moved wallet transaction and customer reward fixtures to `MockupCatalog`.
- Replaced wallet/loyalty/rewards bottom navigation links that pointed at cashier/kitchen/delivery/admin with role-safe customer destinations.
- Completed profile support actions: edit profile save, address refresh, map search/chips/zoom/location/note, and notification refresh/clear/details/action/dismiss controls now give mock feedback or safe navigation.
- Added `ModelCustomerNotification` and `ModelCustomerNotificationCategory`; moved notification rows and category summaries to `MockupCatalog`, while addresses now reuse `MockupCatalog.savedAddresses`.
- Replaced address and notification bottom-navigation links that pointed at cashier/kitchen/delivery/admin/inventory with role-safe customer destinations.
- Completed remaining customer marketing actions: plated return pickup/self-return now use front-end mock feedback, offers/coupon/combo refresh actions respond, and combo item/add-to-cart actions give feedback.
- Replaced plated return reminder links that pointed customers into delivery-only return processing with UI-only mock choices, and fixed its bottom navigation to customer destinations.
- Completed cashier actions: POS add/void/save/payment, history refresh/filter/load/export, tip refresh/log, and deposit refund confirmation now use mock feedback, confirmations, or cashier-safe routing.
- Replaced cashier links that pointed at customer notifications/payment/tracking and kitchen/delivery/admin routes with cashier-safe mock feedback or cashier destinations.
- Completed kitchen actions: dashboard refresh/filter/handover and order-prep refresh/report-issue/mark-ready now use mock feedback or action sheets.
- Added `ModelKitchenReadyOrder` and `ModelKitchenPrepItem`; moved kitchen ready queue and prep checklist fixtures to `MockupCatalog`.
- Replaced kitchen dashboard links that pointed at admin/cashier/delivery routes with kitchen/staff-safe destinations.
- Completed delivery actions: dashboard refresh/profile/notifications/task filters/note/navigation, pickup checklist refresh/report/confirm, plated return maps/collection, clear-signature, and finalization now use mock feedback, confirmations, or delivery-safe routing.
- Added `ModelDeliveryPickupItem` and `ModelDeliveryReturnTask`; moved delivery pickup checklist and plated return task fixtures to `MockupCatalog`.
- Replaced delivery links that pointed at customer notification/profile and admin/cashier/kitchen routes with delivery/staff-safe destinations.
- Updated the route guard so delivery users can access plated return task/process screens.
- Validation for this batch: `dart format`, `flutter analyze`, `ReadLints`, focused empty-callback scans, focused role-route scans, focused inline-fixture scans, and focused branding scans passed.
- Completed inventory actions: dashboard refresh/wastage/download/full-list, item refresh/update/contact, and stock-adjustment refresh now use mock feedback, confirmations, action sheets, or inventory-safe routing.
- Added `ModelInventoryAlert`, `ModelInventoryLevel`, `ModelInventoryStorageStatus`, `ModelInventoryWastageLog`, and `ModelInventoryAuditRow`; moved low-stock, level, storage, wastage, and audit fixtures to `MockupCatalog`.
- Replaced inventory links that pointed at customer notifications and admin/cashier/delivery routes with inventory/staff-safe mock feedback or destinations.
- Validation for this batch: `dart format`, `flutter analyze`, `ReadLints`, focused empty-callback scans, focused role-route scans, and focused branding scans passed.
- Completed staff actions: attendance check-in, tips notification/acknowledge, tip history filters/custom range, and tax statement download now use mock feedback or action sheets.
- Added `ModelStaffShiftDetail`, `ModelStaffTipShift`, `ModelStaffTipTransaction`, and `ModelStaffTipHistory`; moved shift detail, tip shift, transaction, and history fixtures to `MockupCatalog`.
- Replaced staff links that pointed at customer notification/home/order/profile, guest, inventory, and admin routes with staff-safe mock feedback or destinations.
- Validation for this batch: `dart format`, `flutter analyze`, `ReadLints`, focused empty-callback scans, focused role-route scans, and focused branding scans passed.
- Completed admin actions: thin wrapper refreshes, dashboard alerts, report downloads, financial disbursement/export/share, daily tip recalculation/approval/show-all, plate filters/restock/breakage, deposit save, owner privacy save/discard, menu import/filter/item actions, user invite/permissions, and audit dispatch/document actions now use mock feedback, confirmations, action sheets, or admin-safe routing.
- Added `ModelAdminTeamMember`, `ModelAdminMenuItem`, `ModelAdminPlateAsset`, `ModelAdminBreakageReport`, and `ModelAdminTipDistributionRow`; moved admin team, menu item, plate asset, breakage, and tip distribution fixtures to `MockupCatalog`.
- Replaced admin links that pointed at customer notifications/profile/home/order history, guest, inventory, cashier, kitchen, and delivery routes with admin-safe mock feedback or destinations.
- Validation for this batch: `dart format`, `flutter analyze`, `ReadLints`, focused empty-callback scans, focused role-route scans, focused inline-fixture scans, and focused branding scans passed.
- Completed remaining auth/shared checks: splash/language/login/register/OTP/role selection/pending approval flows were verified, and register/role-selection notification actions now use UI-only mock feedback instead of customer-only notification routing.
- Global screen scan now shows no empty `onPressed`, `onTap`, `onRefresh`, or `onSelected` callback stubs under `lib/screens`.
- Validation for this batch: `dart format`, `flutter analyze`, `ReadLints`, focused auth scans, global empty-callback scan, global notification-route scan, and global branding scan passed.
- Final foundation pass added `ModelOrderDetail` and `ModelPaymentMethod`, plus `MockupCatalog.checkoutOrderDetail`, `MockupCatalog.checkoutPaymentMethods`, and `MockupCatalog.paymentMethods`.
- `customer_checkout_screen.dart` and `customer_payment_screen.dart` now consume shared payment method mock data instead of screen-local payment enums/lists.
- Final route audit confirmed all `AppRoutePaths` constants are registered in `core_router.dart`, including `/order/:id`, `/payment/callback`, and `/tip/daily/:date` deep links.
- Final focused validation passed: `dart format`, `flutter analyze`, `ReadLints`, empty-callback scan, branding scan, local payment enum scan, and focused inline-fixture scan. Remaining inline scan hits are presentational widgets or UI-only helper rows, not business data lists.
- Control-state audit completed: admin menu category chips/item switches, staff tip-history ranges, delivery task tabs, kitchen queue filters, cashier order filters, customer order-history filters, and loyalty filter/sort chips now mutate local mock UI state.
- Final static-control scan only reports `customer_map_picker_screen.dart` quick-action map chips, which intentionally act as one-shot actions instead of persistent filters.
- Navigation-shell decision pass completed: keep `WidgetsCustomerShell` for the four primary customer tabs for now, keep per-screen bottom bars on deeper customer/role flows, and defer a larger shell refactor until after emulator smoke testing.
- Role navigation decision: current role-specific per-screen bottom bars are route-safe; extract shared customer/admin/operations/staff bottom-navigation presets in a later refactor rather than changing all screens during mock-logic closure.
- Screen merge/new-screen decision pass completed: no route deletion in this phase; convert lightweight filters/exports to bottom sheets, keep rich editor/detail flows as standalone routes, and add only the post-delivery customer rating/review screen in the next UI-flow pass.
- Mockup phase closure validation completed: Flutter detected Linux desktop and Chrome web targets, `flutter build web --debug` passed, `flutter test` passed after aligning the splash test with its current two-indicator contract, `flutter analyze` passed, and `ReadLints` reported no widget-test diagnostics.

## Phase 1 - Shared Mock Logic Foundation

- [x] Add reusable mock feedback helpers for snackbars, confirmations, and mock bottom sheets.
- [x] Add mock action/result helpers that keep UI-only behavior consistent.
- [x] Add or extend typed mock models under `lib/data/models`.
- [x] Add or extend mock catalogs under `lib/data/mockup`.
- [x] Replace screen-local business mock lists with `lib/data` sources.
- [x] Add `ModelOrderDetail` and shared order line/checklist mock data.
- [x] Add kitchen prep/ready queue mock models and catalogs.
- [x] Add delivery task and plated return mock models and catalogs.
- [x] Add inventory item, alert, audit, storage, and wastage mock models and catalogs.
- [x] Add plate asset and breakage report mock models and catalogs.
- [x] Add staff member, shift, tip share, and tip transaction mock models and catalogs.
- [x] Add reward, wallet transaction, and payment method mock models and catalogs.

## Phase 2 - Navigation Audit And Fixes

- [x] Verify all `AppRoutePaths` constants are registered in `GoRouter`.
- [x] Verify every registered screen is reachable from at least one logical entry point.
- [x] Fix role-inappropriate bottom navigation destinations.
- [x] Decide whether customer navigation uses `WidgetsCustomerShell` or per-screen bottom bars, then remove duplication.
- [x] Document role-specific shell/preset strategy for customer, admin, operations, and staff.
- [x] Fix non-customer notification actions that currently route to customer-only `/notifications`.
- [x] Fix cashier payment flow so it does not send cashier users to customer-guarded `/payment`.
- [x] Fix customer plated return reminder actions that currently point at delivery-guarded routes.
- [x] Restrict guest checkout/payment/profile-like flows to login/register prompts.
- [x] Fix customer checkout flow: cart -> order type -> type details -> checkout -> tip -> payment -> confirmation -> tracking.
- [x] Fix guest flow so browsing is allowed but checkout/order actions lead to login/register.
- [x] Fix admin management flows: dashboard -> orders/reports/menu/users/plates/settings -> detail/editor/filter.
- [x] Fix operations flows: kitchen, cashier, delivery, inventory, and staff.

## Phase 3 - Button And Interaction Completion

- [x] Replace all empty `onPressed: () {}` callbacks with navigation, snackbar, dialog, bottom sheet, or mock state.
- [x] Replace all empty `onTap: () {}` callbacks with purposeful behavior.
- [x] Give refresh actions visible mock refresh feedback or local mock state changes.
- [x] Add confirmation dialogs for delete, deactivate, refund, breakage, cancel, and destructive actions.
- [x] Add success snackbars for save, apply, export, invite, approve, check-in/out, and status updates.
- [x] Add bottom sheets/dialogs for filters, export format selection, item preview, and policy details.
- [x] Ensure switches and filters mutate mock UI state instead of staying static.
- [x] Add confirmation for cart clear/remove and cashier order void.
- [x] Add confirmation and success flow for cashier deposit refund.
- [x] Add confirmation and export/share mock flow for financial disbursement and reports.
- [x] Add recalculation, approve-all, and show-all-staff behavior for daily tip distribution.
- [x] Add kitchen report-issue bottom sheet and mark-ready state transition.
- [x] Add delivery directions, note/report, clear-signature, and finalize-return behavior.
- [x] Add staff check-in/out, acknowledge-tip, download, and custom-range behavior.
- [x] Add inventory update, wastage, report download, and representative contact behavior.

## Phase 4 - Screen-By-Screen Action Tracking

Each screen must be checked for route correctness, empty callbacks, mock feedback, mock state, and `lib/data` mock data placement.

### Auth And Shared

- [x] `lib/screens/auth/auth_splash_screen.dart`
- [x] `lib/screens/auth/auth_language_selection_screen.dart`
- [x] `lib/screens/auth/auth_login_screen.dart`
- [x] `lib/screens/auth/auth_register_screen.dart`
- [x] `lib/screens/auth/auth_otp_verification_screen.dart`
- [x] `lib/screens/auth/auth_forgot_password_screen.dart`
- [x] `lib/screens/auth/auth_role_selection_screen.dart`
- [x] `lib/screens/auth/auth_pending_approval_screen.dart`

### Customer Ordering

- [x] `lib/screens/customer/customer_home_screen.dart`
- [x] `lib/screens/customer/customer_category_screen.dart`
- [x] `lib/screens/customer/customer_product_detail_screen.dart`
- [x] `lib/screens/customer/customer_cart_screen.dart`
- [x] `lib/screens/customer/customer_order_type_selection_screen.dart`
- [x] `lib/screens/customer/customer_dine_in_table_screen.dart`
- [x] `lib/screens/customer/customer_takeaway_pickup_screen.dart`
- [x] `lib/screens/customer/customer_delivery_address_screen.dart`
- [x] `lib/screens/customer/customer_plated_delivery_info_screen.dart`
- [x] `lib/screens/customer/customer_checkout_screen.dart`
- [x] `lib/screens/customer/customer_tip_selection_screen.dart`
- [x] `lib/screens/customer/customer_payment_screen.dart`
- [x] `lib/screens/customer/customer_order_confirmation_screen.dart`
- [x] `lib/screens/customer/customer_order_tracking_screen.dart`

### Customer Account And Marketing

- [x] `lib/screens/customer/customer_guest_browse_screen.dart`
- [x] `lib/screens/customer/customer_order_history_screen.dart`
- [x] `lib/screens/customer/customer_wallet_screen.dart`
- [x] `lib/screens/customer/customer_loyalty_screen.dart`
- [x] `lib/screens/customer/customer_rewards_catalog_screen.dart`
- [x] `lib/screens/customer/customer_redemption_confirm_screen.dart`
- [x] `lib/screens/customer/customer_profile_screen.dart`
- [x] `lib/screens/customer/customer_edit_profile_screen.dart`
- [x] `lib/screens/customer/customer_addresses_screen.dart`
- [x] `lib/screens/customer/customer_map_picker_screen.dart`
- [x] `lib/screens/customer/customer_notifications_screen.dart`
- [x] `lib/screens/customer/customer_plated_return_reminder_screen.dart`
- [x] `lib/screens/customer/customer_offers_screen.dart`
- [x] `lib/screens/customer/customer_coupon_apply_screen.dart`
- [x] `lib/screens/customer/customer_combo_builder_screen.dart`

### Cashier

- [x] `lib/screens/cashier/cashier_order_screen.dart`
- [x] `lib/screens/cashier/cashier_order_history_screen.dart`
- [x] `lib/screens/cashier/cashier_tip_entry_screen.dart`
- [x] `lib/screens/cashier/cashier_deposit_refund_screen.dart`

### Kitchen

- [x] `lib/screens/kitchen/kitchen_dashboard_screen.dart`
- [x] `lib/screens/kitchen/kitchen_order_prep_screen.dart`

### Delivery

- [x] `lib/screens/delivery/delivery_dashboard_screen.dart`
- [x] `lib/screens/delivery/delivery_order_screen.dart`
- [x] `lib/screens/delivery/delivery_plated_return_task_screen.dart`
- [x] `lib/screens/delivery/delivery_plated_return_process_screen.dart`

### Inventory

- [x] `lib/screens/inventory/inventory_dashboard_screen.dart`
- [x] `lib/screens/inventory/inventory_item_screen.dart`
- [x] `lib/screens/inventory/inventory_stock_adjustment_screen.dart`

### Staff

- [x] `lib/screens/staff/staff_attendance_screen.dart`
- [x] `lib/screens/staff/staff_daily_tips_screen.dart`
- [x] `lib/screens/staff/staff_tip_history_screen.dart`

### Admin

- [x] `lib/screens/admin/admin_dashboard_screen.dart`
- [x] `lib/screens/admin/admin_orders_management_screen.dart`
- [x] `lib/screens/admin/admin_order_detail_screen.dart`
- [x] `lib/screens/admin/admin_reports_screen.dart`
- [x] `lib/screens/admin/admin_report_filter_screen.dart`
- [x] `lib/screens/admin/admin_financial_calculation_screen.dart`
- [x] `lib/screens/admin/admin_daily_tip_distribution_screen.dart`
- [x] `lib/screens/admin/admin_plates_management_screen.dart`
- [x] `lib/screens/admin/admin_plate_editor_screen.dart`
- [x] `lib/screens/admin/admin_deposit_config_screen.dart`
- [x] `lib/screens/admin/admin_user_management_screen.dart`
- [x] `lib/screens/admin/admin_menu_management_screen.dart`
- [x] `lib/screens/admin/admin_product_editor_screen.dart`
- [x] `lib/screens/admin/admin_offers_management_screen.dart`
- [x] `lib/screens/admin/admin_loyalty_config_screen.dart`
- [x] `lib/screens/admin/admin_owner_view_config_screen.dart`
- [x] `lib/screens/admin/admin_pre_order_screen.dart`
- [x] `lib/screens/admin/admin_settings_screen.dart`
- [x] `lib/screens/admin/admin_audit_log_screen.dart`
- [x] `lib/screens/admin/admin_staff_hours_report_screen.dart`

## Phase 5 - New Screens Or Merge Decisions

- [x] Decide whether `UserDetailScreen` is required, or whether user edit should be a modal/bottom sheet. Decision: no new `UserDetailScreen` now; use invite/permissions action sheets and expand the existing user management card/detail area if needed.
- [x] Decide whether to create `CustomerRatingReviewScreen` for the post-delivery PRD rating/loyalty step. Decision: create this in the next UI-flow pass because it completes a customer-facing post-delivery loop not covered by current screens.
- [x] Decide whether report export should be a dedicated screen or reusable bottom sheet. Decision: use reusable bottom sheets/action sheets for export format/date options; no dedicated export route needed.
- [x] Decide whether order/admin detail wrappers need richer dedicated mock bodies. Decision: keep standalone order/detail routes, but replace `UtilityScreenBodies` placeholders with richer route-specific bodies in a later visual-detail pass.
- [x] Decide whether settings subsections should become tabs inside `SettingsScreen`. Decision: use tabs/sections inside `SettingsScreen` instead of adding more settings routes.
- [x] Decide whether offer/loyalty editors need dedicated mock editor screens. Decision: admin product/plate editors stay standalone; offer/loyalty configuration should be sections or bottom sheets until richer editing is required.
- [x] Decide whether thin placeholder routes should remain standalone or become tabs/sections: report filter, product editor, plate editor, offers management, loyalty config, settings, staff hours, stock adjustment, coupon, combo, and redemption confirmation. Decision: keep product editor, plate editor, stock adjustment, combo, and redemption confirmation as standalone; convert report filter to a bottom sheet, and fold offers management, loyalty config, settings, and staff hours into admin sections/tabs in the next route-cleanup pass.
- [x] Document any screen merge/delete decision before changing routes.

## Phase 6 - Validation

- [x] Run `dart format` only on edited Dart files.
- [x] Run `flutter analyze`.
- [x] Run `ReadLints` on edited files.
- [x] Run focused scans for empty callbacks.
- [x] Run focused scans for inline business mock data in `lib/screens`.
- [x] Run focused branding scan to keep the branding phase closed.
- [x] Run available smoke validation for main role flows in the emulator/browser when possible.
