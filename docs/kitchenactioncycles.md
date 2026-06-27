# Kitchen Action Cycles — Success / Error / Null / Loading

> **Version:** 1.0.0 · **Generated:** 2026-06-19  
> **Companion:** [`kitchennavigationmapchecklist.md`](kitchennavigationmapchecklist.md) · **Authority:** `docs/prdv1.md` §8.4

Every kitchen action should form a **closed cycle**: user intent → validation → state change or navigation → feedback.

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
| Pass board | `kitchen_session_providers.dart` | `kitchenBoardProvider` — active prep ticket, ready/delayed queues |
| Prep checklist | `kitchen_session_providers.dart` | `togglePrepItem`, `checkedPrepIndexes` shared across dashboard + prep |
| Mark ready | `kitchen_session_providers.dart` | `markReady()` — builds ready order, clears prep, routes to lane |
| Handover | `kitchen_session_providers.dart` | `handoverOrder(orderId)` — removes ticket from ready or delayed lane |
| Issue flag | `kitchen_session_providers.dart` | `reportIssue()` — next mark ready lands in delayed lane with note |
| UI feedback | `widgets_async_state_card.dart` | Empty state on prep when no active ticket |
| Feedback | `utility_mock_feedback.dart` | `showError`, `showWarning`, `confirm` dialogs |

---

## P0 — Prep Workflow (CLOSED locally)

### Toggle prep item

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Checkbox tap → `togglePrepItem` → dashboard ticket lines update |
| **NULL** | No active prep order → toggle ignored |
| **Backend** | Per-line prep acknowledgement on `order_items` |

### Report issue

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Confirm dialog → `reportIssue()` → warning snackbar |
| **NULL** | Cancel dialog → no change |
| **Backend** | `POST /orders/{id}/kitchen-issue` → operator alert |

### Mark as ready

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | All items checked → confirm → `markReady()` → order added to ready lane → clear prep → success → `/kitchen` |
| **SUCCESS (delayed)** | Issue reported → order added to delayed lane with prep note |
| **ERROR** | Incomplete checklist → `showError` with checked/total count |
| **NULL** | Cancel confirm → no change |
| **EMPTY** | No active prep → prep screen shows empty state + back CTA |
| **Backend** | `PATCH /orders/{id}` status `ready` + Realtime broadcast |

### Handover to server

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Tap handover → `handoverOrder(id)` → success snackbar → ticket removed from lane |
| **Backend** | `PATCH /orders/{id}` status `handed_over` or pickup queue |

---

## P1 — Pass Board (CLOSED locally)

### Lane counts

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Hero badges reflect `preparingCount`, `readyOrders.length`, `delayedOrders.length` |
| **EMPTY** | Lane with zero tickets shows `_EmptyLane` placeholder |
| **Backend** | Realtime subscription on branch order board |

### Pull-to-refresh

| Outcome | Behavior |
|---------|----------|
| **SUCCESS/MOCK** | Success snackbar; no remote reload yet |
| **Backend** | Invalidate kitchen queue provider from repo |

---

## Remaining MOCK Cycles (Backend Roadmap)

| Screen | Action | Current | Target API |
|--------|--------|---------|------------|
| Dashboard | Average ready time badge | Static copy | Rolling KPI from shift metrics |
| Prep | Timer badge | Static `12:49` | Elapsed since `prep_started_at` |
| Prep | Timeline stages | Static mock stages | Derived from order status timestamps |
| All | Pull refresh | Snackbar only | Repo fetch + loading state |
| Board | New incoming orders | Single seeded prep ticket | Realtime INSERT on `orders` |
| Handover | Server assignment | Local list removal | Notify waiter / update POS |

---

## Screen Quick Matrix

| Screen | Closed locally? | Notes |
|--------|-----------------|-------|
| Kitchen Dashboard | ✅ | Lanes, handover, synced prep preview, real nav |
| Order Prep | ✅ | Checklist, issue, mark ready, empty state |

---

## QA Verification Checklist

- [ ] Toggle item on prep → dashboard preparing ticket shows checked styling
- [ ] Mark ready with 2/5 checked → error with count message
- [ ] Mark ready with 5/5 → confirm → appears in ready lane on dashboard
- [ ] Report issue then mark ready → order in delayed lane with note
- [ ] After mark ready → prep screen empty; preparing lane empty
- [ ] Handover on ready ticket → ticket removed; count badge updates
- [ ] Handover on delayed ticket → same removal behavior
- [ ] Notifications opens `/notifications` from both screens
