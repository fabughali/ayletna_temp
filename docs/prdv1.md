# Product Requirements Document (PRD)
## Ayletna Restaurant · مطعم عيلتنا

| Field | Value |
|-------|-------|
| **Document ID** | PRD-v1.0.0 |
| **Status** | Living specification — UI mockup implemented; backend integration planned |
| **Last updated** | 2026-06-19 |
| **Scope** | Full product — single branch (Jordan, JOD) |
| **Platforms** | Android · iOS · Web (admin + customer) |
| **Repository** | `ayletna_restaurant_app` (Flutter monorepo) |

---

## Table of contents

1. [Executive summary & vision](#1-executive-summary--vision)
2. [Product scope & constraints](#2-product-scope--constraints)
3. [Implementation status (as-built)](#3-implementation-status-as-built)
4. [Personas, roles & permissions](#4-personas-roles--permissions)
5. [User journeys](#5-user-journeys)
6. [Navigation & information architecture](#6-navigation--information-architecture)
7. [Screen catalog](#7-screen-catalog)
8. [Feature specifications by domain](#8-feature-specifications-by-domain)
9. [Data models & financial rules](#9-data-models--financial-rules)
10. [Backend architecture (Supabase)](#10-backend-architecture-supabase)
11. [Client architecture (Flutter)](#11-client-architecture-flutter)
12. [State management (Riverpod)](#12-state-management-riverpod)
13. [External integrations](#13-external-integrations)
14. [Design system & localization](#14-design-system--localization)
15. [Non-functional requirements](#15-non-functional-requirements)
16. [Acceptance criteria](#16-acceptance-criteria)
17. [Risks & mitigations](#17-risks--mitigations)
18. [Deployment & operations](#18-deployment--operations)
19. [Roadmap & definition of done](#19-roadmap--definition-of-done)
20. [Appendices](#20-appendices)

---

## 1. Executive summary & vision

### 1.1 Vision

Build an integrated digital platform for **Ayletna Restaurant (مطعم عيلتنا)** that unifies a flexible customer ordering experience with precise operational and financial controls for staff and management. The platform supports four order channels (dine-in, takeaway, standard delivery, plated delivery with deposit and return), and enforces strict financial separation between **food revenue**, **tips**, and **plate deposits** per the operating agreement.

### 1.2 Strategic goals

| # | Goal | Success metric |
|---|------|----------------|
| 1 | Unified multi-channel ordering | All four order types completable without financial errors |
| 2 | Financial governance automation | Monthly reports match canonical formula ± 0.01 JOD |
| 3 | Operational sync | Cashier ↔ kitchen ↔ delivery updates under 3 seconds (production) |
| 4 | Data & recipe protection | Zero unauthorized access to recipe costs |
| 5 | Scalability readiness | Schema supports future `branch_id` (disabled in v1) |

### 1.3 Target audiences

- **Customers & guests** — browse, order, pay, track, loyalty.
- **Operations** — cashier, kitchen, inventory, delivery.
- **Management** — operator (admin), owner (read-heavy + configurable views).
- **Staff** — attendance, daily tip transparency.

### 1.4 Value proposition

- Faster orders, less waste, plated-asset protection via deposits.
- Tips distributed by worked hours, isolated from profit distribution.
- Modular Flutter codebase ready for Supabase backend wiring.

---

## 2. Product scope & constraints

### 2.1 In scope — v1.0

| Domain | Details |
|--------|---------|
| **Platforms** | Flutter: Android, iOS; Web for admin and customer demo |
| **Languages** | Arabic (RTL, default) · English (LTR) via ARB |
| **Design** | Material 3, light/dark, role-aware themes, responsive layout |
| **Orders** | dine-in, takeaway, delivery, plated delivery |
| **Finance** | Revenue/tip/deposit isolation; 50/50 surplus split; owner minimum; operator fixed salary |
| **Tips** | Electronic + cash; daily distribution by hours |
| **Attendance** | Server-timestamped check-in/out |
| **Payments** | Gateway adapter (provider TBD) + licensed wallet + cash |
| **Maps** | Google Maps (address, geocoding, delivery zones) |
| **Notifications** | FCM (production target) |
| **Branch** | Single branch (`branch_id` NULL or constant in v1) |

### 2.2 Out of scope — v1.0

- Multi-branch admin UI (schema-ready only).
- Complex table reservation / live table state.
- Full external ERP integration.
- AI demand forecasting.

### 2.3 Operating assumptions

- Stable internet at restaurant; offline queue for delivery staff (production).
- Operator supplies menu, plate replacement costs, deposit defaults before UAT.
- Payment gateway and wallet merchant accounts provided by owner/operator.
- Delivery currently free; service area by radius (default 3–5 km).

### 2.4 Canonical financial constants

| Constant | Value | Notes |
|----------|-------|-------|
| Currency | **JOD** | All monetary fields |
| Owner monthly minimum | **300 JOD** | Before 50/50 surplus split |
| Operator fixed salary | **450 JOD** | Monthly, outside variable split |
| Surplus split | **50% operator / 50% owner** | After minimum and capital repayment |
| Default plate deposit | **10 JOD** | Operator-configurable |
| Plated return reminder | **60 minutes** | Configurable 30–60 min |

### 2.5 Money flow (canonical)

```text
[Total cash/electronic collected]
├── Food sales revenue          → profit calculation ✅
├── Tips                        → tip_ledger 🎁 (isolated)
└── Plate deposits              → temporary liability 🔒 (not profit)
```

---

## 3. Implementation status (as-built)

> This section describes **what exists in the repository today** (June 2026). Production backend items are specified in later sections as targets.

### 3.1 Phase summary

| Phase | Status | Notes |
|-------|--------|-------|
| UI shell & 75 screens | ✅ Complete | All role folders under `lib/screens/` |
| Design system (`CoreTheme`, widgets) | ✅ Complete | Material 3, role themes, shared widgets |
| Localization (AR/EN) | ✅ Complete | `app_ar.arb`, `app_en.arb` |
| Routing & guards | ✅ Complete | `go_router`, `UtilityRouteGuard` |
| Mock data layer | ✅ Complete | `MockupCatalog` |
| Repository abstraction (start) | 🔄 In progress | Menu, order, address, user profile |
| Supabase backend | ⏳ Planned | Schema, RLS, RPC defined in §10 |
| Live payments / maps / FCM | ⏳ Planned | Adapter interfaces specified in §13 |

### 3.2 Runtime feature flags (`lib/core/app_config.dart`)

| Flag | Default | Purpose |
|------|---------|---------|
| `demoModeEnabled` | `true` | Shows demo banner on ops/admin routes; mock actions non-destructive |
| `useSteppedCheckoutRoutes` | `false` | When `false`, `/checkout`, `/payment`, `/tip` redirect to unified `/cart`; when `true`, stepped checkout screens are used |

### 3.3 Demo / prototype behavior

- Ops primary actions use `UtilityDemoActions` and `WidgetsMockActionButton` — info banners instead of fake financial success.
- `WidgetsDemoModeBanner` on cashier, kitchen, delivery, inventory, staff, and admin routes.
- Session and roles are UI-mock via `appRoleProvider` / `sessionProvider` until Supabase Auth is wired.

### 3.4 Deliberate UX decisions (current build)

| Decision | Rationale |
|----------|-----------|
| **Drawer-first navigation** | No bottom navigation bar on any role; `WidgetsAppDrawer` is primary nav |
| **Unified cart checkout** | Fulfillment, payment, tip, promo on one cart screen by default |
| **Guest = shared customer home** | No separate guest browse screen; `/guest` sets role and redirects to `/home` |
| **Coupon merged into cart** | `/coupon` redirects to `/cart`; promo apply inline |
| **Wallet merged into profile/payment** | No standalone wallet hub screen in primary nav |
| **Shared invoice widget** | `WidgetsOrderInvoiceBlock` reused on cashier, customer confirmation, order history, admin detail |
| **Personal settings screen** | `UserPersonalSettingsScreen` at `/account-settings` for all operational roles |

---

## 4. Personas, roles & permissions

### 4.1 Role matrix

| Role | Identifier (`AppRole`) | Primary capabilities |
|------|------------------------|----------------------|
| Operator | `operator` | Full control; financial formulas; users; reports; deposits/plates; tip approval |
| Owner | `owner` | Configurable reports; revenue monitoring; audit; no day-to-day ops edits |
| Cashier | `cashier` | POS; order types; tables; discounts; cash tips; deposit refunds |
| Customer | `customer` | Menu; order; pay; track; loyalty; electronic tip |
| Guest | `guest` | Browse menu/prices; sign-in required to checkout |
| Delivery | `delivery` | Deliver; collect deposit; plate returns; attendance |
| Kitchen | `kitchen` | Prep queue; status updates |
| Inventory | `inventory` | Stock; adjustments; attendance |
| Staff | `staff` | Attendance; daily tip view |

### 4.2 Registration & approval

| Role at registration | Behavior |
|----------------------|----------|
| `customer` | Active after OTP |
| `guest` | No registration; browse only |
| `cashier`, `kitchen`, `delivery`, `inventory` | `pending_approval` until operator approves |
| `operator`, `owner` | **No self-registration** — created by operator only |

**Security rules (production):**

1. Source of truth: `profiles.role` + `profiles.status` in Supabase — not client-side role picker after login.
2. `RoleSelectionScreen` only when user has **multiple approved roles** (session context switch).
3. Role changes post-login: operator-only via user management + `audit_logs`.
4. RLS uses `auth.uid()` and DB role — never trust client claims alone.

### 4.3 Account statuses (`profiles.status`)

| Status | Description |
|--------|-------------|
| `active` | Full access per role |
| `pending_approval` | Awaiting operator approval |
| `suspended` | Login blocked |
| `rejected` | Operational role request denied |

### 4.4 Sensitive data isolation

| Data | operator | owner | cashier | kitchen | delivery | customer |
|------|----------|-------|---------|---------|----------|----------|
| `recipe_cost`, secret ingredients | R/W | per `owner_view_config` | ❌ | ❌ | ❌ | ❌ |
| `tip_ledger` (after distributed) | read | summary | own share | own share | own share | ❌ |
| `deposit_amount` on order | R/W pre-close | read | read/update by state | ❌ | read/return update | own order |
| Monthly distribution report | full | customized | ❌ | ❌ | ❌ | ❌ |

---

## 5. User journeys

### 5.1 Customer — order to delivery

```mermaid
flowchart TD
  A[Launch / Guest or Login] --> B[Home / Menu browse]
  B --> C[Product detail + customization]
  C --> D[Cart]
  D --> E{Fulfillment type}
  E --> E1[Dine-in: table]
  E --> E2[Takeaway]
  E --> E3[Delivery: address]
  E --> E4[Plated: deposit consent + address]
  E1 & E2 & E3 & E4 --> F[Payment + tip]
  F --> G[Confirmation + tracking]
  G --> H{Plated?}
  H -->|Yes| I[Return reminder + deposit settlement]
  H -->|No| J[Rating + loyalty]
```

**Step detail:**

1. Language selection → guest browse or auth.
2. Add items; optional promo on cart.
3. Choose fulfillment (inline on cart in current UI).
4. Tip selection (0 / preset / custom on cart or stepped `/payment` when flag enabled).
5. Pay: cash, card (gateway), or licensed wallet.
6. Track: `new → preparing → ready → on_the_way → delivered/completed`.
7. **Plated:** collect food price + deposit → reminder after 60 min → damage deduction → refund balance.

### 5.2 Operator — daily & monthly close

1. Admin dashboard — live KPIs and attention queue.
2. Orders, deposits, plates, offers management.
3. **End of day:** approve `DailyTipDistributionScreen` → RPC `distribute_tips`.
4. **End of month:** `FinancialCalculationScreen` → RPC profit (tips/deposits excluded from revenue).
5. Export PDF/Excel + archive.

### 5.3 Kitchen & delivery

- **Kitchen:** realtime order feed with **order-type color/icon** (not role theme color); prep → ready.
- **Delivery:** accept → collect (price + deposit if plated) → deliver → return task → `PlatedReturnProcessScreen`.

### 5.4 Staff — attendance & tips

1. Check-in (server time) → hour counter.
2. Check-out → `total_hours` computed.
3. Notification of tip share → acknowledge or dispute to operator.

---

## 6. Navigation & information architecture

### 6.1 Global auth flow

```text
Splash → (session?) → Home[role] | Login
Login → OTP? → Home | RoleSelection (multi-role only)
Register → OTP → customer: Home | staff: PendingApproval
Guest entry (/guest) → sets guest role → /home
```

### 6.2 Customer navigation (drawer-first)

**No bottom navigation bar.** Primary navigation via `WidgetsAppDrawer`:

| Drawer item | Route | Active route groups |
|-------------|-------|---------------------|
| Home | `/home` | `/home`, `/search` |
| Menu | `/category` | category, product, combo, legacy order-type paths |
| Cart | `/cart` | cart, checkout, payment, confirmation (when stepped) |
| Orders | `/order-history` | history, tracking, rating |
| Rewards | `/rewards` | loyalty, rewards, redemption, offers, discounts |
| Notifications | `/notifications` | — |
| Profile | `/profile` | profile, account-settings, addresses, payment history |
| Support | `/support` | support, support-chat, faq |

**Guest drawer:** Home, Menu, Cart, Rewards, Notifications, Support, Sign in — no Orders or Profile.

**App bar:** Menu icon (drawer) on shell routes; back arrow on deeper stacks. Cart icon with badge on customer screens (`WidgetsCartIconButton`).

**Customer shell:** `ShellRoute` wraps primary customer routes; `WidgetsCustomerShell` is a **passthrough** (no chrome).

### 6.3 Checkout navigation modes

**Mode A — Unified cart (default, `useSteppedCheckoutRoutes = false`):**

```text
/cart  (fulfillment + address + payment + tip + summary + proceed)
  → /order-confirmation → /order-tracking
```

Legacy paths redirect to cart: `/order-type`, `/dine-in`, `/takeaway`, `/delivery-address`, `/plated-info`, `/checkout`, `/tip`, `/payment`, `/coupon`.

**Mode B — Stepped checkout (`useSteppedCheckoutRoutes = true`):**

```text
/cart → /checkout (fulfillment + address) → /payment (method + tip) → /order-confirmation
```

State shared via `checkoutDraftProvider`.

### 6.4 Operations & admin navigation

All ops roles use **drawer navigation** via `WidgetsScaffoldPage` — no bottom bars.

| Role | Drawer hub routes |
|------|-------------------|
| Cashier | `/cashier`, order history, tip entry, deposit refund, account settings |
| Kitchen | `/kitchen`, prep |
| Delivery | `/delivery`, order detail, plated return task/process |
| Inventory | `/inventory`, item detail, stock adjustment |
| Staff | attendance, daily tips, tip history, account settings |
| Operator/Owner | `/admin` hub + orders, menu, users, finance, reports, settings, audit |

### 6.5 Route protection (`UtilityRouteGuard`)

| Path prefix | Allowed roles |
|-------------|---------------|
| `/admin*` | `operator`, `owner` |
| `/kitchen*` | `kitchen`, `operator` |
| `/cashier*` | `cashier`, `operator` |
| `/delivery*`, plated return | `delivery`, `operator` |
| `/inventory*` | `inventory`, `operator` |
| `/staff-*` | all operational roles + `operator` |
| Customer paths (§7) | `customer`, `guest` (subset for guest) |
| `/account-settings` | authenticated non-guest |

**Deep links (required for production):**

- `ayletna://order/{id}` → `/order/{id}`
- `ayletna://payment/callback` → `/payment/callback`
- `ayletna://tip/daily/{date}` → `/tip/daily/{date}`

---

## 7. Screen catalog

> **Convention:** PRD name → file `lib/screens/<role>/<role>_<snake>_screen.dart` → class `<Role><Name>Screen`.  
> **Total implemented:** 75 screen files + shared settings.

### 7.1 Authentication & shared

| # | PRD name | Route | File | Status |
|---|----------|-------|------|--------|
| 1 | SplashScreen | `/` | `auth_splash_screen.dart` | UI ✅ |
| 2 | LanguageSelectionScreen | `/language` | `auth_language_selection_screen.dart` | UI ✅ |
| 3 | LoginScreen | `/login` | `auth_login_screen.dart` | UI ✅ |
| 4 | OTPVerificationScreen | `/otp` | `auth_otp_verification_screen.dart` | UI ✅ |
| 5 | RegisterScreen | `/register` | `auth_register_screen.dart` | UI ✅ |
| 6 | ForgotPasswordScreen | `/forgot-password` | `auth_forgot_password_screen.dart` | UI ✅ |
| 7 | RoleSelectionScreen | `/role-selection` | `auth_role_selection_screen.dart` | UI ✅ |
| 8 | PendingApprovalScreen | `/pending-approval` | `auth_pending_approval_screen.dart` | UI ✅ |
| — | UserPersonalSettingsScreen | `/account-settings` | `user_personal_settings_screen.dart` | UI ✅ (all roles) |

**Removed / merged:** `GuestBrowseScreen` → guest uses `CustomerHomeScreen`.

### 7.2 Customer & ordering

| # | PRD name | Route | File | Notes |
|---|----------|-------|------|-------|
| 9 | HomeScreen | `/home` | `customer_home_screen.dart` | Storefront, search entry, categories |
| 10 | SearchScreen | `/search` | `customer_search_screen.dart` | Menu item search |
| 11 | CategoryScreen | `/category` | `customer_category_screen.dart` | |
| 12 | ProductDetailScreen | `/product-detail` | `customer_product_detail_screen.dart` | Customization sheet |
| 13 | ProductReviewsScreen | `/product-reviews` | `customer_product_reviews_screen.dart` | |
| 14 | CartScreen | `/cart` | `customer_cart_screen.dart` | Unified checkout (default) |
| 15 | CheckoutScreen | `/checkout` | `customer_checkout_screen.dart` | Stepped mode only |
| 16 | PaymentScreen (checkout) | `/payment` | `customer_checkout_payment_screen.dart` | Stepped mode only |
| 17 | OrderConfirmationScreen | `/order-confirmation` | `customer_order_confirmation_screen.dart` | Shared invoice block |
| 18 | OrderTrackingScreen | `/order-tracking` | `customer_order_tracking_screen.dart` | |
| 19 | OrderHistoryScreen | `/order-history` | `customer_order_history_screen.dart` | |
| 20 | RatingReviewScreen | `/rating-review` | `customer_rating_review_screen.dart` | |
| 21 | LoyaltyScreen | `/loyalty` | `customer_loyalty_screen.dart` | |
| 22 | RewardsCatalogScreen | `/rewards` | `customer_rewards_catalog_screen.dart` | |
| 23 | RedemptionConfirmScreen | `/redemption` | `customer_redemption_confirm_screen.dart` | |
| 24 | ProfileScreen | `/profile` | `customer_profile_screen.dart` | |
| 25 | EditProfileScreen | `/edit-profile` | `customer_edit_profile_screen.dart` | |
| 26 | AddressesScreen | `/addresses` | `customer_addresses_screen.dart` | |
| 27 | MapPickerScreen | `/map-picker` | `customer_map_picker_screen.dart` | |
| 28 | NotificationsScreen | `/notifications` | `customer_notifications_screen.dart` | |
| 29 | PlatedReturnReminderScreen | `/plated-return-reminder` | `customer_plated_return_reminder_screen.dart` | |
| 30 | OffersScreen | `/offers` | `customer_offers_screen.dart` | |
| 31 | DiscountsScreen | `/discounts` | `customer_discounts_screen.dart` | |
| 32 | ComboBuilderScreen | `/combo` | `customer_combo_builder_screen.dart` | |
| 33 | SupportScreen | `/support` | `customer_support_screen.dart` | |
| 34 | SupportChatScreen | `/support-chat` | `customer_support_chat_screen.dart` | |
| 35 | FAQScreen | `/faq` | `customer_faq_screen.dart` | |
| 36 | TermsScreen | `/terms` | `customer_terms_screen.dart` | |
| 37 | PaymentHistoryScreen | `/payment-history` | `customer_payment_history_screen.dart` | |
| 38 | RewardsHistoryScreen | `/rewards-history` | `customer_rewards_history_screen.dart` | |

**Collapsed / redirect-only routes:** `/order-type`, `/dine-in`, `/takeaway`, `/delivery-address`, `/plated-info`, `/tip`, `/coupon` → cart or stepped checkout per flag.

**Removed / merged:** standalone `WalletScreen`, `CouponApplyScreen` — behavior in profile/cart.

### 7.3 Operations

| # | PRD name | Route | File |
|---|----------|-------|------|
| 39 | KitchenDashboardScreen | `/kitchen` | `kitchen_dashboard_screen.dart` |
| 40 | OrderPrepScreen | `/kitchen-prep` | `kitchen_order_prep_screen.dart` |
| 41 | InventoryDashboardScreen | `/inventory` | `inventory_dashboard_screen.dart` |
| 42 | InventoryItemScreen | `/inventory-item` | `inventory_item_screen.dart` |
| 43 | StockAdjustmentScreen | `/stock-adjustment` | `inventory_stock_adjustment_screen.dart` |
| 44 | DeliveryDashboardScreen | `/delivery` | `delivery_dashboard_screen.dart` |
| 45 | DeliveryOrderScreen | `/delivery-order` | `delivery_order_screen.dart` |
| 46 | PlatedReturnTaskScreen | `/plated-return-task` | `delivery_plated_return_task_screen.dart` |
| 47 | PlatedReturnProcessScreen | `/plated-return-process` | `delivery_plated_return_process_screen.dart` |
| 48 | CashierOrderScreen | `/cashier` | `cashier_order_screen.dart` |
| 49 | CashierOrderHistoryScreen | `/cashier-order-history` | `cashier_order_history_screen.dart` |
| 50 | CashierTipEntryScreen | `/cashier-tip` | `cashier_tip_entry_screen.dart` |
| 51 | CashierDepositRefundScreen | `/cashier-deposit-refund` | `cashier_deposit_refund_screen.dart` |

### 7.4 Staff

| # | PRD name | Route | File |
|---|----------|-------|------|
| 52 | StaffAttendanceScreen | `/staff-attendance` | `staff_attendance_screen.dart` |
| 53 | StaffDailyTipsScreen | `/staff-tips` | `staff_daily_tips_screen.dart` |
| 54 | StaffTipHistoryScreen | `/staff-tip-history` | `staff_tip_history_screen.dart` |

### 7.5 Admin

| # | PRD name | Route | File |
|---|----------|-------|------|
| 55 | AdminDashboardScreen | `/admin` | `admin_dashboard_screen.dart` |
| 56 | OrdersManagementScreen | `/admin-orders` | `admin_orders_management_screen.dart` |
| 57 | OrderDetailAdminScreen | `/admin-order-detail` | `admin_order_detail_screen.dart` |
| 58 | ReportsScreen | `/admin-reports` | `admin_reports_screen.dart` |
| 59 | ReportFilterScreen | `/admin-report-filter` | `admin_report_filter_screen.dart` |
| 60 | FinancialCalculationScreen | `/admin-financial` | `admin_financial_calculation_screen.dart` |
| 61 | DailyTipDistributionScreen | `/admin-tip-distribution` | `admin_daily_tip_distribution_screen.dart` |
| 62 | PlatesManagementScreen | `/admin-plates` | `admin_plates_management_screen.dart` |
| 63 | PlateEditorScreen | `/admin-plate-editor` | `admin_plate_editor_screen.dart` |
| 64 | DepositConfigScreen | `/admin-deposit-config` | `admin_deposit_config_screen.dart` |
| 65 | UserManagementScreen | `/admin-users` | `admin_user_management_screen.dart` |
| 66 | MenuManagementScreen | `/admin-menu` | `admin_menu_management_screen.dart` |
| 67 | ProductEditorScreen | `/admin-product-editor` | `admin_product_editor_screen.dart` |
| 68 | OffersManagementScreen | `/admin-offers-mgmt` | `admin_offers_management_screen.dart` |
| 69 | LoyaltyConfigScreen | `/admin-loyalty-config` | `admin_loyalty_config_screen.dart` |
| 70 | OwnerViewConfigScreen | `/admin-owner-config` | `admin_owner_view_config_screen.dart` |
| 71 | PreOrderScreen | `/admin-pre-order` | `admin_pre_order_screen.dart` |
| 72 | SettingsScreen | `/admin-settings` | `admin_settings_screen.dart` |
| 73 | AuditLogScreen | `/admin-audit` | `admin_audit_log_screen.dart` |
| 74 | StaffHoursReportScreen | `/admin-staff-hours` | `admin_staff_hours_report_screen.dart` |

---

## 8. Feature specifications by domain

### 8.1 Customer storefront

| Requirement | Current UI | Production target |
|-------------|------------|-------------------|
| Home hero, categories, offers, combos | ✅ `CustomerHomeScreen` + `menu_providers` | Live menu from Supabase |
| Search by item name | ✅ `/search` | Full-text / indexed search |
| Product customization | ✅ sheet on detail/cart | Persist modifiers per line |
| Food media placeholders | ✅ `WidgetsFoodMediaPanel` | CDN images from `products.image_url` |
| Loading skeletons | ✅ `WidgetsHomeLoadingSkeleton` | Same with real latency |
| Pull-to-refresh | ✅ `WidgetsRefreshList` | Invalidates repository providers |

### 8.2 Cart & checkout

| Requirement | Current UI | Production target |
|-------------|------------|-------------------|
| Line items, qty, remove confirm | ✅ | Sync cart to server pre-checkout |
| Fulfillment type chips | ✅ dine-in, takeaway, delivery, group delivery, plated | Validate per product eligibility |
| Address picker | ✅ `savedAddressesProvider` | User addresses table + map picker geocode |
| Payment method | ✅ cash, card (+ wallet in stepped screen) | Gateway + wallet adapters |
| Tip presets | ✅ 0 / 0.5 / 1 / 2 JOD | Configurable presets |
| Promo code | ✅ inline on cart | Server-validated coupon |
| Checkout progress strip | ✅ Basket → Fulfillment → Payment → Review | Same |
| Guest checkout block | ✅ sign-in CTA, no fake success | Auth gate before payment |
| Invoice preview | ✅ shared `WidgetsOrderInvoiceBlock` | PDF/email receipt |

### 8.3 Cashier POS

| Requirement | Current UI | Production target |
|-------------|------------|-------------------|
| Multi-tab ticket flow (items → fulfillment → payment → invoice) | ✅ | Realtime order sync |
| Payment tabs: Cash, Visa, Wallet, Split | ✅ | Split must sum to payable |
| Payment received gate before invoice tab | ✅ | |
| Prior balance on payment summary | ✅ | Customer wallet / house account |
| Postponed orders | ✅ provider | Persist to DB |
| Virtual keypad | ✅ `virtual_keypad` package | |
| Shift order history | ✅ | Linked to cashier session |
| Cash tip entry | ✅ | Writes to `tip_ledger` |
| Deposit refund | ✅ | RPC + audit |

### 8.4 Kitchen & delivery

| Requirement | Current UI | Production target |
|-------------|------------|-------------------|
| Prep / ready / delayed lanes | ✅ | Supabase Realtime on `orders` |
| Order-type chips (color independent of role theme) | ✅ `WidgetsOrderTypeChip` | |
| Glanceability timers | ✅ `WidgetsOpsGlanceChip` | |
| Delivery collect price + deposit | ✅ | |
| Plated return task + damage process | ✅ | `process_plated_return` RPC |
| 60-minute return reminder | ✅ customer notification screen | FCM + cron |

### 8.5 Admin & finance

| Requirement | Current UI | Production target |
|-------------|------------|-------------------|
| Live ops dashboard | ✅ | Real KPIs |
| Order management + detail with invoice | ✅ repository providers | |
| Monthly profit calculation UI | ✅ | `calculate_monthly_profit_distribution` RPC |
| Daily tip distribution approval | ✅ | `distribute_tips` RPC |
| Plate asset catalog + editor | ✅ | |
| Deposit config | ✅ | `app_settings` |
| User management + approval | ✅ | `approve_staff_registration` |
| Menu/product CRUD | ✅ | |
| Audit log | ✅ | DB triggers |
| Owner view field masking | ✅ | `owner_view_config` |
| Reports + filters | ✅ | Export PDF/Excel |

### 8.6 Staff attendance & tips

| Requirement | Current UI | Production target |
|-------------|------------|-------------------|
| Check-in / check-out | ✅ | Server timestamps only |
| Daily tip share display | ✅ | From `tip_distributions` |
| Tip history | ✅ | |
| Acknowledge / dispute | UI mock | Workflow + operator override + audit |

### 8.7 Account & profile

| Requirement | Current UI | Production target |
|-------------|------------|-------------------|
| Profile summary | ✅ | `profiles` + preferences |
| Personal settings (notifications toggles) | ✅ `userProfileProvider` | Persist to DB |
| Edit profile, addresses | ✅ UI | Supabase update |
| Payment / rewards history | ✅ | Transaction tables |
| Logout / session refresh | ✅ UI | Supabase signOut |

---

## 9. Data models & financial rules

### 9.1 Order types & statuses

```dart
enum OrderType { dineIn, takeaway, delivery, platedDelivery }

enum OrderStatus {
  newOrder, preparing, ready, onTheWay,
  delivered, completed, cancelled,
}

enum DepositStatus {
  pending, collected, refunded, partiallyRefunded, deducted,
}
```

### 9.2 Order entity (production)

```dart
class Order {
  final String id;
  final String? branchId;       // NULL in v1
  final String customerId;
  final OrderType type;
  final String? tableNumber;
  final OrderStatus status;
  final double subtotal;
  final double deliveryFee;
  final double discountAmount;
  final double totalAmount;     // food only — excludes tip & deposit
  final double? tipAmount;      // separate field
  final double? depositAmount;  // separate field
  final DepositStatus? depositStatus;
  final List<OrderItem> items;
  final List<PlateDamage>? damages;
  final String? invoiceNumber;  // dine-in call number
}
```

**Rule:** Never add tip or deposit into `total_amount`.

### 9.3 Tips

```dart
class DailyTipLedger {
  final String id;
  final DateTime date;
  final double cashAmount;
  final double digitalAmount;
  final LedgerStatus status; // open | distributed | closed
}

class EmployeeTipDistribution {
  final String ledgerId;
  final String employeeId;
  final double workedHours;
  final double tipShare;
  final bool isAcknowledged;
}
```

**Daily distribution formula:**

```text
employee_share = (employee_hours / sum_present_hours) × daily_tip_total
```

Executed only via RPC `distribute_tips(ledger_id)` after operator approval.

### 9.4 Attendance

```dart
class AttendanceLog {
  final String id;
  final String employeeId;
  final DateTime checkInTime;   // server timestamp
  final DateTime? checkOutTime;
  final double totalHours;      // computed on check-out
}
```

### 9.5 Plates & damage

```dart
class Plate {
  final String id;
  final String nameAr;
  final String nameEn;
  final double replacementCost;
  final bool isActive;
}

class PlateDamage {
  final String plateId;
  final int quantity;
  final double deductionAmount;
}
```

**Refund formula:**

```text
refund_to_customer = deposit_collected - SUM(quantity × replacement_cost)
restaurant_recovery = deducted amount (asset, not revenue)
```

### 9.6 Monthly profit (canonical)

```text
computed_revenue = SUM(orders.total_amount) WHERE status IN (delivered, completed)

net_before_split = computed_revenue - operating_expenses - capital_repayment

IF net_before_split < 300 JOD (owner minimum):
    owner_variable = net_before_split
    operator_variable = 0
ELSE:
    owner_variable = 300 + 50% × (net_before_split - 300)
    operator_variable = 50% × (net_before_split - 300)

operator_fixed_salary = 450 JOD  // separate line item, not in 50/50 pool
```

### 9.7 Reference scenario (acceptance test)

| Line | JOD |
|------|-----|
| Food revenue (month) | 10,000 |
| Tips (isolated) | 500 |
| Deposits held | 300 |
| Expenses + capital | 6,500 |
| Net before split | 3,500 |
| Owner: minimum + 50% surplus | 1,000 + 1,250 = **2,250** |
| Operator: 50% surplus + fixed salary | 1,250 + **450** = **1,700** |

### 9.8 Client models (implemented)

Located in `lib/data/models/` — includes `ModelMenuItem`, `ModelCartLine`, `ModelOrderDetail`, `ModelOrderSummary`, `ModelCustomerOrderHistory`, `ModelSavedAddress`, `ModelUserProfile`, kitchen/delivery/inventory mocks, etc.

---

## 10. Backend architecture (Supabase)

> **Status:** Specified for production; not yet connected in the Flutter app.

### 10.1 Core tables (v1, single branch)

| Table | Key fields | Notes |
|-------|------------|-------|
| `profiles` | `role`, `status`, `full_name`, `phone`, `branch_id` | FK `auth.users` |
| `products` | `name_ar`, `name_en`, `price`, `recipe_cost` 🔒 | |
| `categories` | `name_ar`, `sort_order` | |
| `orders` | `order_type`, `table_number`, `total_amount`, `tip_amount`, `deposit_amount`, `deposit_status`, `status` | |
| `order_items` | `order_id`, `product_id`, `qty`, `price_at_order` | |
| `plates` | `replacement_cost`, `is_active` | |
| `plate_damages` | `order_id`, `plate_id`, `quantity`, `deduction_amount` | |
| `attendance` | `employee_id`, check-in/out, `total_hours` | server time |
| `tip_ledger` | `date`, cash/digital amounts, `status` | |
| `tip_distributions` | `ledger_id`, `employee_id`, hours, share | immutable after distribute |
| `payments` | `order_id`, gateway, `component` (food/tip/deposit) | |
| `wallet_transactions` | licensed wallet events | |
| `audit_logs` | immutable change log | |
| `owner_view_config` | field visibility per owner | |
| `app_settings` | deposit default, return delay, delivery radius | |

**Postgres enums:** `user_role`, `order_type`, `order_status`, `deposit_status`, `ledger_status`, `profile_status`.

### 10.2 Required RPC functions

| Function | Purpose |
|----------|---------|
| `get_revenue_for_profit_calculation(start, end)` | Food revenue only |
| `calculate_monthly_profit_distribution(period)` | Apply 300 / 50-50 / capital rules |
| `distribute_tips(ledger_id)` | Proportional by attendance hours |
| `process_plated_return(order_id, damages jsonb)` | Damage deduction + deposit status |
| `schedule_plated_return_reminder(order_id, delay_min)` | Cron / Edge Function |
| `approve_staff_registration(profile_id)` | Activate pending staff |

### 10.3 RLS summary

- **profiles:** self read; operator full; role change operator-only.
- **orders:** customer own; cashier/kitchen/delivery/operator by branch assignment.
- **tips:** staff see own share; operator manages until `distributed`; then immutable.
- **products.recipe_cost:** operator only; owner per config; denied elsewhere.
- **audit_logs:** insert via trigger; read operator/owner; no updates/deletes.

### 10.4 Realtime channels

| Channel | Subscribers | Events |
|---------|-------------|--------|
| `orders:branch={id}` | kitchen, cashier, operator | INSERT, status UPDATE |
| `orders:assigned={delivery_id}` | delivery | UPDATE |
| `tip_ledger:date={today}` | operator | total UPDATE |

### 10.5 Immutability rules

1. `tip_ledger.status = distributed` → block amount edits.
2. `tip_distributions` → no update after `is_acknowledged = true` except operator override RPC + audit.
3. Completed orders → no edit to `total_amount`, `tip_amount`, `deposit_amount` without operator cancel flow + audit.

---

## 11. Client architecture (Flutter)

### 11.1 Technology stack

| Component | Technology | Version (approx.) |
|-----------|------------|-------------------|
| Framework | Flutter stable | SDK ^3.7 |
| State | flutter_riverpod | ^2.6 |
| Routing | go_router | ^14.8 |
| Localization | flutter gen-l10n | AR + EN |
| Fonts | google_fonts + Noto Sans Arabic | ^6.3 |
| Keypad | virtual_keypad | cashier POS |
| Backend (target) | Supabase | Auth, Postgres, RLS, Realtime |
| Notifications (target) | FCM | |
| Maps (target) | Google Maps Platform | |

### 11.2 Repository layout (current)

```text
lib/
├── core/                    # theme, colors, router, typography, app_config
├── data/
│   ├── mockup/              # MockupCatalog (transition layer)
│   ├── models/              # Model* classes
│   └── repositories/        # abstract + mock implementations
├── l10n/                    # app_ar.arb, app_en.arb
├── navigation/              # AppRoutePaths, checkout redirects
├── providers/               # Riverpod providers (cart, menu, session, checkout draft…)
├── screens/
│   ├── auth/
│   ├── customer/
│   ├── cashier/
│   ├── kitchen/
│   ├── delivery/
│   ├── inventory/
│   ├── staff/
│   ├── admin/
│   └── shared/
├── utilities/               # route guard, formatters, demo actions, mock feedback
├── widgets/                 # Widgets* shared components (~70 files)
└── main.dart
```

### 11.3 Target architecture (post-backend)

Migrate toward feature-first clean architecture:

```text
lib/features/<feature>/
  data/       repositories, DTOs, Supabase datasources
  domain/     entities, use cases
  presentation/ screens, widgets, @riverpod notifiers
```

**Migration rule:** Move screens without renaming public widget classes; swap `MockupCatalog` → repository implementations per domain.

### 11.4 Repository layer (implemented)

| Repository | Provider | Mock source |
|------------|----------|-------------|
| `RepositoryMenu` | `repositoryMenuProvider` | `RepositoryMenuMock` |
| `RepositoryOrder` | `repositoryOrderProvider` | `RepositoryOrderMock` |
| `RepositoryAddress` | `repositoryAddressProvider` | `RepositoryAddressMock` |
| `UserProfileRepository` | `userProfileRepositoryProvider` | local mock |

**Derived providers:** `customerOrderHistoryProvider`, `checkoutOrderDetailProvider`, `savedAddressesProvider`, `adminOrderDetailProvider`, `menuCategoriesProvider`, `menuItemsProvider`.

### 11.5 Shared widgets (key)

| Widget | Purpose |
|--------|---------|
| `WidgetsScaffoldPage` | AppBar + drawer + demo banner + layout |
| `WidgetsAppDrawer` | Role-aware navigation |
| `WidgetsScreenLayout` | Responsive max-width wrapper |
| `WidgetsCheckoutStepStrip` | Checkout progress |
| `WidgetsOrderInvoiceBlock` | Shared receipt layout |
| `WidgetsOrderTicketSum` | Cashier ticket totals |
| `WidgetsDemoModeBanner` | Prototype indicator |
| `WidgetsMockActionButton` | Non-destructive demo actions |
| `WidgetsFoodCard`, `WidgetsFoodHero` | Storefront presentation |
| `WidgetsOpsGlanceChip` | Kitchen/delivery status |

### 11.6 Quality principles

1. **Financial isolation** in UI labels and totals.
2. **Financial writes** via RPC in production — never client-side profit math as source of truth.
3. **Realtime** for kitchen/cashier order boards.
4. **No hardcoded colors** in screens — use `CoreTheme` / `CoreColors`.
5. **No `.withOpacity()`** — use `Color.withValues(alpha: ...)`.
6. **Errors on financial flows** — `SelectableText.rich` red inline, not snackbar-only.

---

## 12. State management (Riverpod)

### 12.1 Conventions

- Prefer `@riverpod` codegen for new notifiers (target); current code uses `StateNotifierProvider` / `FutureProvider` patterns.
- `AsyncValue` for list/detail screens fed by repositories.
- `ref.invalidate()` after successful writes.
- Cancel subscriptions in `dispose` where streaming.

### 12.2 Implemented providers

| Provider | Responsibility |
|----------|----------------|
| `appRoleProvider` | Current UI role (mock → Supabase profile) |
| `appLocaleProvider` | ar/en locale |
| `sessionProvider` | Auth session + pending approval |
| `goRouterProvider` | Router with guard redirect |
| `cartProvider` | Local cart lines |
| `checkoutDraftProvider` | Stepped checkout state |
| `menuCategoriesProvider` / `menuItemsProvider` | Menu data |
| `userProfileProvider` | Notification prefs, profile fields |
| `cashierPostponedOrdersProvider` | POS postponed tickets |

### 12.3 Target providers (production)

| Provider | Responsibility |
|----------|----------------|
| `authNotifier` | Supabase session + profile sync |
| `orderCreateNotifier` | Create order + payment initiation |
| `platedReturnNotifier` | Damage capture → RPC |
| `tipDistributionNotifier` | Preview + approve daily ledger |
| `attendanceNotifier` | Check-in/out |

---

## 13. External integrations

### 13.1 Payment gateway (adapter pattern)

```dart
abstract class PaymentGateway {
  Future<PaymentResult> initiatePayment(PaymentRequest request);
  Future<PaymentResult> initiateSplitPayment({
    required double foodAmount,
    required double tipAmount,
    double? depositAmount,
    required PaymentMethod method,
    required Map<String, String> metadata,
  });
  Future<PaymentStatus> checkStatus(String transactionId);
  Future<void> refund(String transactionId, double amount);
  bool get supportsSplitPayment;
}
```

Provider selection (MyFatoorah / HyperPay / Checkout.com) deferred; mock gateway for dev/staging.

**Failure handling:** cancel pending order + inline error UI.

### 13.2 Licensed wallet (v1 mandatory)

| Item | Requirement |
|------|-------------|
| Integration | Deep link primary + SDK if available |
| Callback | `/payment/callback` |
| Webhook | Edge Function → `wallet_transactions` + order payment status |
| Metadata | `order_id`, `order_type`, `has_deposit`, `tip_amount` |
| Amount split | Pass tip/deposit as metadata even if single charge |

### 13.3 Google Maps

- Map picker lat/lng on `MapPickerScreen`
- Geocoding on invoices
- Delivery polygon validation (reject out-of-zone)
- Future: multi-stop routing for drivers

### 13.4 FCM notification matrix

| Type | Recipient | Priority |
|------|-----------|----------|
| `new_order_alert` | kitchen, cashier | Critical |
| `plated_delivery_alert` | delivery | High |
| `plated_return_reminder` | delivery, customer | Medium |
| `tip_received` | staff | Low |
| `order_status_update` | customer | High |

### 13.5 Optional services

| Service | Use |
|---------|-----|
| SendGrid / SES | PDF invoices, password reset email |
| SMS (Unifonic) | OTP, plate return SMS |
| WhatsApp Business | Friendly return reminders |

---

## 14. Design system & localization

### 14.1 Color system

**Source file:** `color_list_chat_gpt.txt` (hex source of truth).

| Category | Tokens |
|----------|--------|
| Brand | Falafel Gold `#C98A42`, Deep Brown `#4A3325`, Olive `#6E6A35` |
| Order types | dine-in `#00897B`, takeaway `#F9A825`, delivery `#1976D2`, plated `#7B1FA2` |
| Financial semantics | tip `#6E6A35`, deposit `#5D4037`, revenue `#C98A42` |
| PWA | theme `#C98A42`, background `#F9F6F0` |

Order-type colors are **independent** of role theme colors on ops screens.

### 14.2 Typography

- `CoreTypography` + `CoreFonts` (Noto Sans Arabic via `google_fonts` for Arabic script coverage).
- Responsive type scales via `CoreContentSizes`.

### 14.3 UI implementation rules

Documented in `ui_design_prompt.txt`:

- Theme-only styling — no per-screen color overrides.
- `WidgetsScreenLayout` wraps all page bodies.
- Naming: `widgets_<name>.dart` → class `Widgets<Name>`.
- Screens: `<role>_<snake>_screen.dart` → `<Role><Name>Screen`.
- Stitch exports are layout reference only — never copy Tailwind HTML or Stitch colors.

### 14.4 Localization

- Default locale: **Arabic (RTL)**.
- English via system locale or in-app switch (`appLocaleProvider`).
- All user-visible strings in ARB files — no hardcoded UI copy in widgets.
- Currency suffix via `l10n.currencyJod` + `UtilityFormatJod`.

---

## 15. Non-functional requirements

### 15.1 Performance

| Metric | Target |
|--------|--------|
| Local UI interaction | < 100 ms |
| Home screen load | < 2 s |
| Frame rate | 60 FPS |
| Order sync (production) | < 3 s |
| Android APK size | < 60 MB |

### 15.2 Security

- TLS 1.3; Supabase Auth (email + phone OTP).
- RLS on all sensitive tables.
- Attendance timestamps from server only.
- Secrets via `--dart-define` / CI — never committed.
- `audit_logs` on financial mutations.

### 15.3 Compatibility

| Platform | Minimum |
|----------|---------|
| Android | API 24 (recommended 26+) |
| iOS | 14+ |
| Web | Latest Chrome, Safari, Firefox (last 2 versions) |

### 15.4 Offline-first (production)

- Queue orders, attendance, cash tips locally with **idempotency keys**.
- On conflict: **server wins** for financial fields.

### 15.5 Accessibility

- TalkBack / VoiceOver support.
- WCAG 2.1 AA contrast.
- Text scaling to 200%.
- Order-type badges: icon + label + color (not color alone).
- Brand Gold buttons: dark text `#4A3325` on gold — not white microtext.

### 15.6 Availability

- Target 99.5% uptime.
- Daily Supabase backups; PITR for financial data.

---

## 16. Acceptance criteria

### 16.1 Plated delivery

- [ ] Plated order shows deposit (default 10 JOD) and blocks completion without consent.
- [ ] Driver sees **food price + deposit** to collect.
- [ ] Return reminder fires after 60 minutes (configurable).
- [ ] Damage entry deducts `replacement_cost` and computes refund automatically.
- [ ] `deposit_status` and `plate_damages` consistent with RPC.

### 16.2 Tips & attendance

- [ ] Tip presets 1 / 2 / 5 JOD + custom entry.
- [ ] Check-in/out uses server time; no post-checkout edit without operator + audit.
- [ ] Daily tip distribution matches formula ± 0.01 JOD.
- [ ] No edits to `tip_ledger` after `distributed`.

### 16.3 Finance

- [ ] Monthly report excludes tips and deposits from revenue.
- [ ] Owner minimum 300 JOD applied correctly on low-net months.
- [ ] Operator fixed salary 450 JOD shown as separate line.

### 16.4 Auth & roles

- [ ] Customer registration active after OTP.
- [ ] Staff roles pending until operator approval.
- [ ] No self-registration for operator/owner.
- [ ] Role selection only for multi-role accounts.

### 16.5 Payments

- [ ] `PaymentGateway` injectable; mock for dev.
- [ ] Wallet deep link + webhook updates order.
- [ ] Payment failure cancels pending order.

### 16.6 UI / UX (current sprint baseline)

- [x] Drawer navigation on all roles — no bottom nav bars.
- [x] Customer home reachable as primary landing for customer/guest.
- [x] Cart checkout strip + section scroll anchors.
- [x] Shared invoice on confirmation, history, admin detail, cashier.
- [x] Demo mode banner on ops routes.
- [x] AR/EN localization wired.
- [ ] All screens use `CoreTheme` only — zero rogue hex in `screens/`.
- [ ] Order-type colors distinct from role chrome on kitchen/cashier.

### 16.7 Gherkin reference scenarios

```gherkin
Scenario: Plated cycle with damage
  Given deposit 10 JOD and plate replacement_cost 2 JOD
  When driver records 2 broken plates
  Then deduction = 4 JOD and refund = 6 JOD

Scenario: Tip distribution
  Given total tips 100 JOD and hours 8+6+4
  Then shares are 44.44, 33.33, 22.22 (±0.01)

Scenario: Revenue isolation
  Given food 10000, tips 500, deposits 300
  When monthly profit RPC runs
  Then computed revenue = 10000 only
```

---

## 17. Risks & mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| Plate damage disputes | Trust loss | Approved price list; optional photos; operator override + audit |
| Deposit/tip leakage | Cash gap | Daily reconciliation; refund alerts; operator-only completion cancel |
| Attendance fraud | Unfair tips | Server timestamps; anomaly report (>24h shifts) |
| Unreturned plates | Asset loss | Push reminders; block plated orders for repeat offenders |
| Profit formula error | Owner/operator conflict | Single RPC source; monthly PDF breakdown |
| Payment gateway delay | Launch slip | Mock adapter + split API ready day one |
| Wallet callback failure | Stuck orders | Webhook + polling; 15-minute payment expiry |

---

## 18. Deployment & operations

### 18.1 Environments

| Env | Supabase | Flutter build |
|-----|----------|---------------|
| dev | dev project | debug + mock payments |
| staging | staging | profile + test gateway |
| prod | production | release + prod keys |

### 18.2 Mobile

- **Android:** Play Console, App Bundle, ProGuard.
- **iOS:** TestFlight → App Store; privacy policy + Maps usage strings.

### 18.3 Web

```bash
flutter build web --release --base-href /{repo-name}/
```

Static deploy to GitHub Pages or CDN; admin + customer demo.

### 18.4 Supabase ops

- Migrations in `supabase/migrations/`; RLS review on every PR.
- Edge Functions: wallet webhooks, plate reminders.
- Daily backup; quarterly restore drill.

### 18.5 CI (recommended)

```yaml
on: [push, pull_request]
jobs:
  analyze_test:
    steps:
      - run: flutter gen-l10n
      - run: flutter analyze
      - run: flutter test
```

### 18.6 Secrets management

| Secret | Storage |
|--------|---------|
| `SUPABASE_URL`, `SUPABASE_ANON_KEY` | dart-define / CI |
| `GOOGLE_MAPS_API_KEY` | referrer / bundle restricted |
| Gateway & wallet keys | Supabase Vault / CI only |

### 18.7 Monitoring

- Supabase Logs + Advisors.
- Sentry or Crashlytics for crashes.
- Alert on payment webhook failures > 5/hour.

---

## 19. Roadmap & definition of done

### 19.1 Completed — UI mockup phase (2026 Q2)

- [x] 75 screens across 8 role groups
- [x] Drawer-first navigation redesign
- [x] Cashier POS tabs 4–5 + shared invoice widgets
- [x] Customer cart unified checkout + progress strip
- [x] Repository interfaces for menu, orders, addresses, profile
- [x] Demo mode + mock action safety
- [x] Google Fonts / Noto Arabic typography
- [x] Route guards + deep link path constants

### 19.2 Next — backend integration phase

| Sprint focus | Deliverables |
|--------------|--------------|
| Auth | Supabase Auth, profiles, pending approval, real session |
| Menu & cart | Live products/categories; cart persistence |
| Orders | Create order RPC; realtime kitchen/cashier boards |
| Payments | Gateway + wallet adapters; callback handler |
| Tips & attendance | Ledger RPCs; staff flows wired |
| Plated returns | `process_plated_return`; FCM reminders |
| Admin finance | Monthly/daily RPCs hooked to admin screens |
| Hardening | RLS tests, offline queue, E2E critical paths |

**Estimated duration post-UI:** 8–10 weeks with 2 Flutter + 1 backend engineer.

### 19.3 Definition of done — production v1

- [ ] All §16 acceptance criteria pass on staging.
- [ ] RLS migrations reviewed and penetration-tested.
- [ ] No secrets in git; `flutter analyze` clean.
- [ ] Critical RPC test coverage ≥ 80%.
- [ ] Operator handbook (Arabic PDF).
- [ ] App Store / Play / web URLs live.
- [ ] `demoModeEnabled = false` in production build flavor.

---

## 20. Appendices

### 20.1 Glossary

| Term | Definition |
|------|------------|
| Order type | dine-in · takeaway · delivery · plated delivery |
| Deposit (عربون) | Temporary plate liability — not revenue |
| Tip (بقشيش) | Isolated from profit distribution |
| Distributable profit | Net subject to 50/50 after owner minimum |
| RLS | Row Level Security in Postgres |
| Split payment | Separate food / tip / deposit components |

### 20.2 Pre-launch checklist

- [ ] Payment gateway selected; split payments enabled
- [ ] Wallet contract + production webhook
- [ ] Google Maps API quotas configured
- [ ] FCM + APNs certificates
- [ ] Menu, plate catalog, deposit defaults loaded
- [ ] Jordan privacy policy published
- [ ] Staff training day (cashier, driver, operator)

### 20.3 Companion documents

| Document | Purpose |
|----------|---------|
| `color_list_chat_gpt.txt` | Hex color source of truth |
| `ui_design_prompt.txt` | UI implementation rules and naming |
| `docs/UI_UX_REDESIGN_CHECKLIST.md` | Redesign sprint tracking (internal) |
| `.cursor/rules` | IDE coding standards (Riverpod, M3, lists) |

### 20.4 Placeholders (update before launch)

| Field | Current value |
|-------|---------------|
| Legal business name | Ayletna Restaurant / مطعم عيلتنا |
| Public marketing URL | _TBD_ |
| App store links | _TBD_ |
| Payment gateway vendor | _TBD_ (adapter ready) |

### 20.5 Document history

| Version | Date | Summary |
|---------|------|---------|
| **1.0.0** | 2026-06-19 | Initial PRD v1: as-built UI state, drawer navigation, repository layer, backend spec, financial rules, complete screen catalog |

---

**End of document — Ayletna Restaurant PRD v1.0.0**
