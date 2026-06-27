# Customer, Guest, and Auth UI/UX Completion Checklist

Date: 2026-06-16

Scope: active `auth/` screens, active `customer/` screens, and the shared guest experience after removing the separate guest screen.

References checked:

- `prd.md`
- `ui_design_prompt.txt`
- `mockup_logic_prompt.md`
- Taste Skill MCP: `design-taste-frontend`
- Context7 Flutter guidance: accessibility checks for tap target size, tap labels, and contrast
- Router/source scan: `lib/core/core_router.dart`, `lib/navigation/app_route_paths.dart`, `lib/utilities/utility_route_guard.dart`, `lib/widgets/widgets_app_drawer.dart`

Legend:

- `[x]` Done from source-level audit.
- `[~]` Done with note or live QA still recommended.
- `[ ]` Not done.

## Audit Criteria

Each screen was checked against:

- `[x]` Route is registered or intentionally redirected.
- `[x]` Role access is appropriate for customer/guest/auth behavior.
- `[x]` Main actions navigate, show feedback, open a dialog/bottom sheet, toggle state, or are disabled intentionally.
- `[x]` UI uses shared design primitives (`CoreTheme`, `CoreSpacing`, `CoreTypography`, `WidgetsScaffoldPage`, `WidgetsAppCard`, `WidgetsAppButton`) where appropriate.
- `[x]` No direct `withOpacity`, hardcoded hex colors, obvious placeholder copy, or silent primary CTAs found in active screens.
- `[x]` Mock business data is centralized in `lib/data/mockup/mockup_catalog.dart` and typed models where practical.
- `[~]` Accessibility source-level checks are covered by shared button/icon/text-field patterns, but live screen-reader/tap-target tests should be added to widget tests later.
- `[x]` Live Playwright visual pass completed against a clean `flutter build web` served locally from `build/web`.

## Active Screen Inventory

### Auth Screens

1. `auth_splash_screen.dart`
2. `auth_language_selection_screen.dart`
3. `auth_login_screen.dart`
4. `auth_otp_verification_screen.dart`
5. `auth_register_screen.dart`
6. `auth_forgot_password_screen.dart`
7. `auth_role_selection_screen.dart`
8. `auth_pending_approval_screen.dart`

### Customer Screens

1. `customer_home_screen.dart`
2. `customer_search_screen.dart`
3. `customer_category_screen.dart`
4. `customer_product_detail_screen.dart`
5. `customer_product_reviews_screen.dart`
6. `customer_cart_screen.dart`
7. `customer_order_confirmation_screen.dart`
8. `customer_order_tracking_screen.dart`
9. `customer_order_history_screen.dart`
10. `customer_rating_review_screen.dart`
11. `customer_terms_screen.dart`
12. `customer_support_screen.dart`
13. `customer_support_chat_screen.dart`
14. `customer_faq_screen.dart`
15. `customer_notifications_screen.dart`
16. `customer_profile_screen.dart`
17. `customer_edit_profile_screen.dart`
18. `customer_addresses_screen.dart`
19. `customer_map_picker_screen.dart`
20. `customer_loyalty_screen.dart`
21. `customer_rewards_catalog_screen.dart`
22. `customer_rewards_history_screen.dart`
23. `customer_payment_history_screen.dart`
24. `customer_redemption_confirm_screen.dart`
25. `customer_offers_screen.dart`
26. `customer_discounts_screen.dart`
27. `customer_combo_builder_screen.dart`
28. `customer_plated_return_reminder_screen.dart`

### Guest Screens

Guest no longer has separate screen files. Guest uses the shared customer surfaces with reduced navigation:

1. Home
2. Menu/category
3. Product detail/reviews
4. Cart
5. Rewards/loyalty
6. Offers/discounts/combo
7. Support/chat/FAQ
8. Terms

Guest is intentionally blocked from checkout completion, order history, profile, address management, redemption, notifications, rewards history, payment history, and plated-return reminder until signup/login.

## Auth Screen Checklist

| Screen | Status | Route | UI/UX and Logic Result |
|---|---:|---|---|
| Splash | [x] | `/` | Branded app entry, delayed navigation, no extra app chrome. Uses shared theme system and Arabic-first app setup. |
| Language selection | [x] | `/language` | Language choice is small/elegant, uses shared spacing/cards, navigates onward through auth flow. |
| Login | [x] | `/login` | Password label cleanup completed, forgot password is below field, guest entry sets guest role and routes to shared home, login routes to OTP. |
| OTP verification | [x] | `/otp` | 6-digit copy, countdown/resend behavior, LTR phone segment, and back-route behavior are implemented. Login OTP now routes to mock role chooser for auditing. |
| Register | [x] | `/register` | 3-step flow preserved, signup OTP is nested as step 2, terms checkbox and preference chips are consistent, customer signup completes to home. |
| Forgot password | [x] | `/forgot-password` | Reset entry has direct back-to-login/support paths and mock feedback behavior. |
| Mock role selection | [x] | `/role-selection` | Post-login mock-only chooser explains admin-assigned production roles and lets tester enter customer, owner, operator, cashier, kitchen, inventory, staff, and delivery surfaces. |
| Pending approval | [x] | `/pending-approval` | Operational-role pending state exists and keeps PRD approval logic visible. |

Auth closure notes:

- `[x]` Meets current mockup need for post-OTP role testing.
- `[x]` Aligns with PRD caveat that production roles are admin-assigned, not user-selected.
- `[x]` OTP keyboard navigation was live-tested and reached the mock role chooser.
- `[~]` Add Flutter accessibility widget tests later for OTP fields, language cards, and role cards.

## Customer Screen Checklist

| Screen | Status | Route | UI/UX and Logic Result |
|---|---:|---|---|
| Home | [x] | `/home` | Shared customer/guest storefront is active. Search, offers, combos, discounts, subscriptions, categories, popular items, and story sections are present. Plated CTAs now enter current cart/terms flow instead of removed legacy screens. |
| Search | [x] | `/search` | Search only navigates/filters after user input, handles empty and no-result states, and opens/adds menu items through current product/cart customization flow. |
| Menu/category | [x] | `/category` | Category switching filters locally without flash, category section matches home styling, item cards open detail or customization sheet. |
| Product detail | [x] | `/product-detail` | Product title in app bar, responsive gallery capped at 5 images, review preview and full reviews path, related products, remarks/configuration preserved in cart. |
| Product reviews | [x] | `/product-reviews` | Dedicated full review list reachable from product detail preview. |
| Cart | [x] | `/cart` | Single checkout surface now owns fulfillment, address selection, payment type, tip, promo, summary, guest signup gate, and authenticated mock confirmation. |
| Order confirmation | [x] | `/order-confirmation` | Final mock order confirmation route remains active after cart checkout and payment callback redirect. |
| Order tracking | [x] | `/order-tracking` and `/order/:id` | Active route and deep link exist, tracking/rating actions route to active screens. |
| Order history | [x] | `/order-history` | Active orders, status timeline, snackbar feedback, reorder, rating, and driver inline phone action are covered. |
| Rating review | [x] | `/rating-review` | Rating submission screen exists and is reachable from order flows. |
| Terms | [x] | `/terms` | Dedicated terms screen is reachable from cart and home learn-more flow. |
| Support | [x] | `/support` | Shared cart/drawer support route, no cart app-bar icon, responsive support action grid, ticket list and details bottom sheet. |
| Support chat | [x] | `/support-chat` | Active chat session with sender names, timestamps, sent/delivered/read states, no thumbnails, user cannot open ticket. |
| FAQ | [x] | `/faq` | One-line expandable FAQ cards keep screen compact. |
| Notifications | [x] | `/notifications` | Active customer route and app-bar action destination. |
| Profile | [x] | `/profile` | Profile image edit, rewards/points, payment history, saved addresses with default/delete/edit, logout/deactivate spacing. |
| Edit profile | [x] | `/edit-profile` | Active profile edit route. |
| Addresses | [x] | `/addresses` | Address list has add/edit/delete actions and returns toward profile/map flow. |
| Map picker | [x] | `/map-picker` | Constrained add-address form requires map and written address; fallback return is now cart, profile return is preserved. |
| Loyalty | [x] | `/loyalty` | Guest-aware zero points, points/stamp state, rewards catalog CTA. |
| Rewards catalog | [x] | `/rewards` | Guest-aware zero-balance teaser, signup-to-earn CTAs for guest, redemption for customer. |
| Rewards history | [x] | `/rewards-history` | Active profile points-history destination. Guest is blocked until signup. |
| Payment history | [x] | `/payment-history` | Active profile payment-history destination. Guest is blocked until signup. |
| Redemption confirm | [x] | `/redemption` | Active customer rewards redemption route. Guest is blocked until signup. |
| Offers | [x] | `/offers` | Home view-all and offer actions route to active screens/cart/combo with mock feedback. |
| Discounts | [x] | `/discounts` | Active discounted item browsing surface with add-to-cart flow. |
| Combo builder | [x] | `/combo` | Active combo customization surface, routes back to cart with mock feedback. |
| Plated return reminder | [x] | `/plated-return-reminder` | Still active from profile-related plated lifecycle. Guest is blocked. |

Customer closure notes:

- `[x]` Legacy customer files were removed and active customer folder is now 28 screens.
- `[x]` Old checkout/fulfillment/payment/tip/coupon/wallet/order-type routes redirect safely.
- `[x]` Cart is the only checkout surface.
- `[x]` Drawer and route guard support the current customer IA.
- `[~]` Drawer active-route lists still include some stale redirected paths for compatibility highlighting. This is acceptable but can be cleaned later.

## Guest Screen Checklist

| Shared Surface | Status | Guest Result |
|---|---:|---|
| Home | [x] | Guest opens the same storefront as customer. |
| Menu/category | [x] | Guest can browse categories and item cards. |
| Product detail/reviews | [x] | Guest can inspect item details and reviews. |
| Cart | [x] | Guest can add items and configure cart, but checkout CTA routes to signup. |
| Rewards/loyalty | [x] | Guest can preview rewards with zero points and signup-to-earn messaging. |
| Offers/discounts/combo | [x] | Guest can browse promotional surfaces and add items to cart. |
| Support/chat/FAQ | [x] | Guest can access support surfaces. |
| Terms | [x] | Guest can view terms. |
| Order history/profile/address/payment history/reward history/redemption | [x] | Guest is blocked and routed to signup where appropriate. |

Guest closure notes:

- `[x]` No separate guest screen files remain.
- `[x]` Guest navigation is reduced to Home, Menu, Cart, Rewards, and Support.
- `[x]` Guest cannot proceed to final checkout without signup.

## Redirected Legacy Routes Kept For Safety

These are no longer screen files, but old links still work:

- `/order-type` → `/cart`
- `/dine-in` → `/cart`
- `/takeaway` → `/cart`
- `/delivery-address` → `/cart`
- `/plated-info` → `/cart`
- `/checkout` → `/cart`
- `/tip` → `/cart`
- `/payment` → `/cart`
- `/coupon` → `/cart`
- `/wallet` → `/profile`
- `/payment/callback` → `/order-confirmation`

## Compliance Summary

### PRD

- `[x]` Customer ordering journey exists as a complete mock flow.
- `[x]` Guest can browse and add items but cannot complete checkout without signup.
- `[x]` Role-specific auth testing is available after login OTP as mock-only.
- `[x]` Customer support, order tracking, rewards, profile, addresses, and history are represented.
- `[~]` PRD still describes a multi-step checkout journey in some narrative sections, but the current mockup intentionally consolidates that journey into cart. The router preserves old paths with redirects.

### `ui_design_prompt.txt`

- `[x]` Uses role-aware `CoreTheme` and `CoreColors`.
- `[x]` Uses shared `CoreSpacing`, `CoreTypography`, `WidgetsScreenLayout`, `WidgetsScaffoldPage`, `WidgetsAppCard`, and `WidgetsAppButton`.
- `[x]` Arabic-first localization is preserved through ARB.
- `[x]` No per-screen hardcoded hex/opacity scan hits in active auth/customer screens.
- `[x]` Screen files remain in `lib/screens/auth` and `lib/screens/customer` with correct flat structure.
- `[x]` Live route-based Playwright visual QA completed for public auth routes and guest/shared customer routes.
- `[~]` Protected customer-only routes are source-verified; direct static-route forcing redirects when mock in-memory session is not selected through the role card.

### `mockup_logic_prompt.md`

- `[x]` Routes are registered or intentionally redirected.
- `[x]` Primary CTAs navigate or show feedback.
- `[x]` Destructive actions use confirmation dialogs where present.
- `[x]` Details/preview interactions use bottom sheets/dialogs where appropriate.
- `[x]` Filters, chips, quantities, tips, address selection, chat state, and role choice use local/Riverpod mock state.
- `[x]` Business mock data is centralized in `lib/data/mockup/mockup_catalog.dart` and typed models where practical.
- `[~]` Some screen-specific visual constants remain inside widgets/painters, which is allowed by the prompt.

## Live Visual QA

The debug `flutter run -d chrome` path previously ended with `the Dart compiler exited unexpectedly`. The app was rebuilt cleanly with:

- `flutter clean`
- `flutter pub get`
- `flutter gen-l10n`
- `flutter build web`

Then the release web build was served locally from `build/web` and checked with Playwright at `http://127.0.0.1:8787/`.

Screenshots captured:

- `qa-language.png`
- `qa-login.png`
- `qa-otp-login.png`
- `qa-register.png`
- `qa-guest-entry.png`
- `qa-guest-home.png`
- `qa-guest-menu.png`
- `qa-guest-product.png`
- `qa-guest-cart.png`
- `qa-guest-rewards.png`
- `qa-guest-support.png`
- `qa-guest-faq.png`
- `qa-guest-terms.png`
- `qa-mobile-language.png`
- `qa-mobile-guest-home.png`
- `qa-mobile-guest-cart.png`
- `qa-otp-keyboard-attempt.png`
- `qa-role-selection-session.png`
- `qa-customer-home-session.png`
- `qa-customer-cart-session.png`
- `qa-support-chat-session.png`

Live QA results:

- `[x]` Release web build compiles successfully.
- `[x]` Local static server opens the app successfully.
- `[x]` Browser console reported zero errors during the Playwright pass.
- `[x]` Public auth routes open successfully.
- `[x]` Guest entry redirects to shared home successfully.
- `[x]` Guest home/menu/product/cart/rewards/support/FAQ/terms routes open successfully.
- `[x]` Mobile viewport samples for language, guest home, and guest cart open successfully.
- `[x]` OTP keyboard navigation reaches `/role-selection`.
- `[~]` Flutter web canvas semantics are limited in Playwright; route screenshots are reliable, but fine-grained visual judgement still benefits from human review of captured screenshots.

## Final Completion Status

Source-level UI/UX status for customer, guest, and auth screens: **DONE**

Live Playwright route/visual QA status: **DONE**

Remaining optional manual QA: review the captured screenshots visually and, in a browser, click through role cards after OTP because Flutter web exposes limited semantic controls to Playwright.
