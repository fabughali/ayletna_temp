# UI/UX Redesign Checklist — Ayletna Restaurant App

Tracking planned improvements from the app review and ongoing cashier/checkout work.

**Legend:** `[x]` done · `[~]` in progress · `[ ]` pending

---

## Phase 1 — Customer shell & navigation

- [x] **Drawer-first customer navigation** — Home · Menu · Cart · Orders · Rewards · Profile · Support in `WidgetsAppDrawer`
- [x] **Customer shell passthrough** — `WidgetsCustomerShell` groups routes without bottom navigation
- [x] **Cart app-bar action** — visible on all customer screens including cart

## Phase 1 — Cart & checkout clarity

- [x] **Checkout progress strip** on cart — Basket → Fulfillment → Payment → Review
- [x] **Section anchors / scroll-to** — tap step to jump to fulfillment, payment, summary blocks
- [x] **Guest checkout CTA** — clearer sign-in prompt instead of snackbar-only success on proceed

## Phase 1 — Ops / prototype affordances

- [x] **Demo mode banner** — persistent banner on cashier, kitchen, delivery, inventory, staff, admin routes
- [x] **Replace snackbar-only primary actions** with banner + disabled state where actions are mock

## Phase 2 — Cashier POS maintainability

- [x] Tab 4 payment cards (Cash · Visa · Wallet · Split) with conditional fields
- [x] Tab 4 payment received gate before Tab 5
- [x] Tab 5 invoice layout aligned with left ticket sum table
- [x] Left ticket footer row order (rewards → items → subtotal → delivery → balance → total → payment)
- [x] **Extract shared ticket/invoice widgets** from `cashier_order_screen.dart` → `lib/widgets/`
- [x] **Split payment validation** — split fields must sum to amount payable
- [x] **Prior balance indicator** on payment tab summary bar

## Phase 2 — Shared invoice reuse

- [x] Reuse invoice/ticket sum layout on customer order confirmation
- [x] Reuse on customer order history detail
- [x] Reuse on admin order detail

## Phase 3 — Typography & visual polish

- [x] Add `google_fonts` + Noto Sans Arabic
- [x] Kitchen / delivery glanceability pass (status chips, timers, larger tap targets)
- [x] Customer home empty states and loading skeletons

## Phase 3 — Account & settings

- [x] `UserPersonalSettingsScreen` + `/account-settings` route
- [x] Verify drawer entry + l10n for all roles that use personal settings
- [x] Wire personal settings fields to session/profile provider (currently UI mock)

## Phase 4 — Structure & backend readiness

- [x] Feature-flag demo vs live API mode (`AppConfig.demoModeEnabled`)
- [x] Reduce `MockupCatalog` coupling in screens — repository layer + key customer/admin screens migrated
- [x] Un-collapse checkout routes (`/checkout`, `/payment`) — wired behind `AppConfig.useSteppedCheckoutRoutes`

---

## Implementation log

| Date | Item | Notes |
|------|------|-------|
| 2026-06-19 | Checklist created | This file |
| 2026-06-19 | Cashier payment & invoice | Tabs 4–5, left ticket footer (prior session) |
| 2026-06-19 | Profile provider + demo flag | UserProfile state, AppConfig, UtilityDemoActions |
| 2026-06-19 | Phase 4 repositories + checkout | Order/address repos, stepped checkout screens, router flag |

---

## Verify after changes

```bash
flutter gen-l10n
dart format lib/
flutter analyze lib/data/repositories/ lib/screens/customer/customer_checkout_screen.dart lib/screens/customer/customer_checkout_payment_screen.dart lib/screens/customer/customer_cart_screen.dart lib/screens/customer/customer_order_history_screen.dart lib/screens/customer/customer_order_confirmation_screen.dart lib/screens/admin/admin_order_detail_screen.dart lib/core/core_router.dart
```

Manual: hot restart → customer role → confirm bottom nav on 5 tabs; cart shows progress strip; cashier shows demo banner.
