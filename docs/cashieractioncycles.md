# Cashier Action Cycles — Success / Error / Null / Loading

> **Version:** 1.0.0 · **Generated:** 2026-06-19  
> **Companion:** [`cashiernavigationmapchecklist.md`](cashiernavigationmapchecklist.md) · **Authority:** `docs/prdv1.md` §8.3

Every cashier action should form a **closed cycle**: user intent → validation → state change or navigation → feedback.

---

## Cycle Legend

| Outcome | Meaning |
|---------|---------|
| **SUCCESS** | User goal achieved; state updated and/or navigated |
| **ERROR** | Validation failure; user sees error + recovery path |
| **NULL/EMPTY** | Missing input or empty data; blocked or guided with CTA |
| **LOADING** | Async in progress; controls disabled / spinner shown |
| **MOCK** | Local/demo behavior until backend wired |

---

## Infrastructure Added (v1.0.0)

| Layer | File | Purpose |
|-------|------|--------|
| Session orders | `cashier_session_providers.dart` | `cashierSessionOrdersProvider` — records completed POS tickets; `markRefunded` |
| Shift tips | `cashier_session_providers.dart` | `cashierShiftTipsProvider` — running tip total for shift |
| Postponed tickets | `cashier_postponed_orders_provider.dart` | Save/resume unpaid drafts |
| UI feedback | `widgets_async_state_card.dart` | Empty state on history when no matches |
| Feedback | `utility_mock_feedback.dart` | `showError`, `showWarning`, confirm dialogs |

---

## P0 — POS Order Funnel (CLOSED locally)

### Add item to cart

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Customization sheet → `cartProvider.add` |
| **NULL** | Dismiss sheet → no change |

### Send to kitchen

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Non-empty cart → `_kitchenSent = true` + success snackbar |
| **NULL/ERROR** | Empty cart → warning snackbar |
| **Backend** | `POST /orders/{id}/kitchen` or status `preparing` via Realtime |

### Confirm payment received

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Valid method + amounts → `_paymentReceivedConfirmed = true`; cash shows change dialog first |
| **ERROR** | No method selected → info snackbar (`cashierPaymentPending`) |
| **ERROR** | Split totals mismatch → info snackbar |
| **Backend** | `POST /orders/{id}/payments` partial capture |

### Complete payment (POS)

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Cart non-empty + payment confirmed → `recordOrder` on session provider → clear cart → reset tabs → success snackbar |
| **ERROR** | Empty cart → `showError` |
| **ERROR** | Payment not confirmed → `showError` (`cashierPaymentPending`) |
| **Backend** | `POST /orders` (cashier channel) → `{ orderId, totalJod, depositJod? }` + Realtime broadcast |

### Void order

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Confirm → clear cart → reset checkout → success snackbar |
| **NULL** | Cancel dialog → no change |

### Postpone order

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Reason selected + non-empty cart → `cashierPostponedOrdersProvider.addOrder` → clear cart → success snackbar |
| **NULL** | Cancel reason dialog |
| **ERROR** | Empty cart → warning snackbar |
| **Backend** | `POST /cashier/postponed-orders` persist draft JSON |

### Resume postponed order

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | History **Resume** → `cashierResumeDraftProvider` → POS loads cart/fields → removes from postponed list |
| **Backend** | `GET /cashier/postponed-orders/{id}` + delete on resume |

---

## P1 — Order History (CLOSED locally)

### Search + filter

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Query + chip filter client-side on session + mock transactions |
| **EMPTY** | No matches → `WidgetsAsyncStateCard.empty` + POS CTA |
| **Backend** | `GET /cashier/shift/orders?q=&type=` paginated |

### Refund from history

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Confirm → `markRefunded(orderId)` for session orders → success → navigate `/cashier-deposit-refund` |
| **NULL** | Already refunded → button disabled |
| **MOCK** | Mock catalog orders show UI refund but only session orders persist status change |
| **Backend** | `POST /orders/{id}/refund/init` → deposit refund workflow |

### View invoice / export

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Dialog with order summary; export runs demo complete animation |
| **MOCK** | No per-order PDF; static dialog content |
| **Backend** | `GET /orders/{id}/invoice` PDF/thermal |

### Load older transactions

| Outcome | Behavior |
|---------|----------|
| **MOCK** | Info snackbar only |
| **Backend** | `GET /cashier/shift/orders?cursor=` pagination |

---

## P2 — Tip Entry (CLOSED locally)

### Log tip

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Amount > 0 → `cashierShiftTipsProvider.logTip` → success snackbar → reset amount |
| **NULL** | Amount 0 → button disabled |
| **MOCK** | Staff assignment + shared pool toggle are local only |
| **Backend** | `POST /tips` `{ amountJod, staffId?, sharedPool }` → `tip_ledger` |

---

## P3 — Deposit Refund (MOSTLY MOCK UI)

### Item assessment

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Returned/damaged toggles update local `_damagedItems` |
| **SUCCESS** | Review → settlement view |
| **Backend** | `POST /deposits/{id}/assess` with damage flags |

### Confirm process refund

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Confirm → demo complete animation → navigate `/cashier-order-history` |
| **NULL** | Cancel confirm |
| **MOCK** | Wallet credit + terminal auth are static mock cards |
| **Backend** | `POST /deposits/{id}/refund` RPC `process_plated_return` + audit log |

---

## Remaining MOCK Cycles (Backend Roadmap)

| Screen | Action | Current | Target API |
|--------|--------|---------|------------|
| POS | Kitchen send | Local flag + snackbar | Realtime order status + KDS |
| POS | Print / e-ticket | Snackbar | ESC/POS + SMS/WhatsApp |
| POS | Promo apply | Local savings | `POST /promo/validate` |
| POS | Prior balance | Mock customer lookup | `GET /customers/by-phone` wallet |
| History | Pull refresh | Snackbar | `GET /cashier/shift/summary` |
| History | Mock transactions | Static catalog | Session-scoped API only |
| History | Export CSV | Demo animation | `GET /cashier/shift/export.csv` |
| Tip | Staff grid | Mock catalog | `GET /staff/on-shift` |
| Refund | Customer wallet | Static amounts | Live wallet from customer record |
| All | Notifications | Info snackbar | FCM + `/notifications` |

---

## Screen Quick Matrix

| Screen | Closed locally? | Notes |
|--------|-----------------|-------|
| Cashier POS | ✅ Core funnel | Payment gate + session record + postpone/resume |
| Order History | ✅ List + refund entry | Session merge; mock rows for demo |
| Tip Entry | ✅ Log tip | Shift total updates |
| Deposit Refund | ⚠️ UI flow only | Confirm navigates; no wallet RPC |

---

## QA Verification Checklist

- [ ] Pay with empty cart → error snackbar, no session record
- [ ] Pay without confirming received → error snackbar
- [ ] Successful pay → ticket in history with correct total/type
- [ ] Postpone → appears in history; resume restores cart on POS
- [ ] Refund session order → status chip changes; navigates to refund screen
- [ ] Tip log → shift tips card increments
- [ ] Filter refunds chip shows refunded orders only
- [ ] Search by order id filters list
