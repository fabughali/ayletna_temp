# Customer Action Cycles — Success / Error / Null / Loading

> **Version:** 1.0.0 · **Generated:** 2026-06-19  
> **Companion:** [`customernavigationmapchecklist.md`](customernavigationmapchecklist.md) (where actions go) · this doc (what happens in each outcome)

Every customer action should form a **closed cycle**: user intent → validation → state change or navigation → feedback. This document maps that matrix and the backend endpoints needed to replace mock layers.

---

## Cycle Legend

| Outcome | Meaning |
|---------|---------|
| **SUCCESS** | User goal achieved; state updated and/or navigated |
| **ERROR** | Validation or server failure; user sees error + recovery path |
| **NULL/EMPTY** | Missing input or empty data; blocked or guided with CTA |
| **LOADING** | Async in progress; controls disabled / spinner shown |
| **MOCK** | Local/demo behavior until backend wired (see roadmap) |

---

## Infrastructure Added (v1.0.0)

| Layer | File | Purpose |
|-------|------|--------|
| Order placement | `repository_order.dart` + `repository_order_mock.dart` | `placeOrder`, `buildReorderLines`, `fetchOrderDetailById` |
| Address CRUD | `repository_address.dart` + `repository_address_mock.dart` | `createAddress`, `deleteAddress`, `setDefaultAddress` |
| Providers | `order_placement_providers.dart` | `placeOrderProvider`, `checkoutOrderDetailProvider` (uses `placedOrderIdProvider`) |
| Providers | `customer_action_providers.dart` | Notifications dismiss/clear, tracking order id, reward id |
| UI feedback | `widgets_async_state_card.dart` | Reusable empty/error panels + retry |
| Feedback | `utility_mock_feedback.dart` | Added `showError` |

---

## P0 — Order Funnel (NOW CLOSED locally)

### Place order (Payment screen / legacy cart)

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | `placeOrderProvider.submit()` → mock repo validates → stores order → clears cart + checkout draft → sets `placedOrderIdProvider` → navigate `/order-confirmation` + success snackbar |
| **ERROR** | Empty cart → `OrderPlacementException(cart_empty)` → error banner + snackbar |
| **ERROR** | Delivery/plated without address → `address_required` → error message |
| **LOADING** | Submit disables button + shows `CircularProgressIndicator` |
| **NULL/Guest** | Redirect `/login` |
| **Backend** | `POST /orders` body: `{ lines, fulfillment, addressId, paymentType, tipJod, promoCode? }` → `{ orderId, reference, totalJod }` |

### Order confirmation

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Loads `checkoutOrderDetailProvider` from last placed order id |
| **LOADING** | Spinner while fetching |
| **ERROR** | Raw error text (retry: re-place order) |
| **Backend** | `GET /orders/{orderId}` |

### Reorder (Order history)

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | `buildReorderLines(orderId)` → `cartProvider.replaceAll` → success snackbar → `/cart` |
| **ERROR** | Error snackbar |
| **Backend** | `POST /orders/{orderId}/reorder` → cart lines |

### View order status

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Sets `activeTrackingOrderIdProvider` → `/order-tracking` |
| **Backend** | `GET /orders/{orderId}/tracking` + websocket poll |

---

## P1 — Addresses (NOW CLOSED locally)

### Map picker — Save address

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | `repositoryAddress.createAddress` → invalidate `savedAddressesProvider` → success → return route |
| **ERROR** | Empty fields → validation exception → error snackbar |
| **NULL** | Save disabled until map selected + fields filled |
| **LOADING** | Save disabled while `_isSaving` |
| **Backend** | `POST /addresses` + geocode lat/lng |

### Addresses screen — Delete

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Confirm → `deleteAddress` → refresh list → success snackbar |
| **ERROR** | Cannot remove / not found → error snackbar |
| **EMPTY** | Empty-state card + Add address CTA |
| **LOADING/ERROR** | Provider `.when()` spinner / retry panel |
| **Backend** | `DELETE /addresses/{id}` |

---

## P2 — Cart & Menu Actions

### Search bar submit

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Non-empty query → `/search?q=` |
| **NULL** | Empty query → **warning snackbar** (searchEmptyBody) |

### Cart — Edit customization

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Opens full `showWidgetsCartCustomizationSheet` with `replaceLineKey` → updates cart line |
| **NULL** | Missing menu item falls back to line metadata |

### Combo builder — Proceed

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Adds all slot items to cart (combo pricing) → success → `/cart` |
| **Backend** | `POST /cart/bundle` with slot ids |

### Cart — Proceed (stepped vs legacy)

| Outcome | Behavior |
|---------|----------|
| **SUCCESS stepped** | Sync draft → `/checkout` → `/payment` → place order |
| **SUCCESS legacy** | Direct `/order-confirmation` *(still needs placeOrder on legacy path — wire in Phase 2)* |
| **NULL/Guest** | `/login` |
| **NULL** | Missing address when required → picker dialog / disabled proceed |

---

## P3 — Notifications (PARTIALLY CLOSED)

| Action | SUCCESS | ERROR | NULL | Backend |
|--------|---------|-------|------|---------|
| Dismiss (×) | Removes from visible list via `customerNotificationsDismissedProvider` | — | — | `PATCH /notifications/{id}` read |
| Clear all | Confirm → dismiss all ids | Cancel → no-op | Empty list shows empty-state | `DELETE /notifications` |
| Action button w/ route | Deep link (tracking, plated return, order history) | — | No route → info snackbar | Route from push payload |
| Pull refresh | Resets dismissed + success toast | — | — | `GET /notifications` |
| Staff/admin actions (tips, stock) | Info snackbar (MOCK) | — | — | Role-gated APIs |

---

## P4 — Profile & Account

### Edit profile — Save

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Validates non-empty + email `@` → `userProfileProvider.updateProfile` → success → pop |
| **ERROR** | Empty fields or invalid email → error snackbar |
| **Backend** | `PATCH /users/me` |

### Profile — Logout

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | `sessionProvider.signOut` → `/login` |

### Profile — Notification toggles

| Outcome | Behavior |
|---------|----------|
| **MOCK** | Local setState only on profile screen |
| **Backend** | Wire to `userProfileProvider` + `PATCH /users/me/preferences` |

### Profile — Address delete (inline card)

| Outcome | Behavior |
|---------|----------|
| **MOCK** | Confirm → warning only (addresses screen now uses real delete) |

---

## Remaining MOCK Cycles (Backend Roadmap)

| Screen | Action | Current | Target API |
|--------|--------|---------|------------|
| Cart | Apply promo | Local flag + toast | `POST /promo/validate` |
| Offers | Claim offer | Toast + navigate | `POST /offers/{id}/claim` |
| Loyalty | Redeem | Navigate only | `POST /loyalty/redeem` + pass `rewardId` |
| Redemption confirm | Confirm | Toast → cart | `POST /loyalty/redeem/confirm` |
| Rating review | Submit | Toast → loyalty | `POST /orders/{id}/reviews` |
| Support chat | Send message | Info toast | WebSocket chat API |
| Support tickets | Follow-up actions | Success toast | `PATCH /tickets/{id}` |
| Order history | View invoice | Same mock detail for all orders | `GET /orders/{id}/invoice` per order |
| Order history | Filter chips | Mock action sheet | Query param filters |
| Payment history | List | Static mock | `GET /payments` |
| Rewards history | List | Static mock | `GET /loyalty/ledger` |
| Product reviews | List | Static 12 reviews | `GET /products/{id}/reviews` |
| Plated return | Schedule pickup | Action sheet toast | `POST /plated-returns/schedule` |
| Home/Category | Menu load error | Raw text | `WidgetsAsyncStateCard.error` + retry |
| Category | Empty category grid | Blank grid | Empty-state card |

---

## Screen Quick Matrix

| Screen | Closed locally? | Notes |
|--------|-----------------|-------|
| Home | Partial | Nav + cart add OK; menu error UX pending |
| Search | Yes | Empty query warning added |
| Category | Partial | Empty grid UX pending |
| Product detail | Yes | Add to cart + dialog cycle complete |
| Cart | Yes | Edit customization wired; promo mock |
| Checkout steps | Yes | Draft sync + validation |
| Payment | **Yes** | Full place-order cycle |
| Order confirmation | Yes | Uses placed order id |
| Order tracking | Partial | Support CTA fixed; live status mock |
| Order history | **Yes** | Reorder + tracking nav + empty/error |
| Notifications | **Yes** | Dismiss/clear/deeplink |
| Addresses | **Yes** | Provider + CRUD |
| Map picker | **Yes** | Persist + validation |
| Edit profile | **Yes** | Form validation + profile provider |
| Combo builder | **Yes** | Adds to cart |
| FAQ / Terms | Yes | Read-only cycles complete |
| Support (call/WA/chat) | Partial | External links OK; chat mock |
| Loyalty/Rewards | Partial | Nav OK; redeem API pending |

---

## QA Verification Checklist

- [ ] Guest checkout always redirects to login
- [ ] Empty cart cannot place order (error shown)
- [ ] Delivery without address cannot place order
- [ ] Successful payment clears cart and shows correct order on confirmation
- [ ] Reorder populates cart with lines
- [ ] Active order "View status" opens tracking
- [ ] Notification dismiss removes card; clear all empties list
- [ ] Notification "Track Map" opens order tracking
- [ ] Add address from map appears in addresses list
- [ ] Delete address removes from list
- [ ] Edit profile empty save shows error; valid save updates profile
- [ ] Combo proceed adds items to cart
- [ ] Cart edit opens customization and updates line
- [ ] Empty search shows warning

---

*Audited with MCP filesystem + explore agent; cycles closed in code where noted above.*
