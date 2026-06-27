# Delivery Action Cycles — Success / Error / Null / Loading

> **Version:** 1.0.0 · **Generated:** 2026-06-19  
> **Companion:** [`deliverynavigationmapchecklist.md`](deliverynavigationmapchecklist.md) · **Authority:** `docs/prdv1.md` §8.4

Every delivery action should form a **closed cycle**: user intent → validation → state change or navigation → feedback.

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
| Shift earnings | `delivery_session_providers.dart` | `deliveryShiftEarningsProvider` — running total |
| Session runs | `delivery_session_providers.dart` | `deliverySessionRunsProvider` — completed pickups |
| Return queue | `delivery_session_providers.dart` | `deliveryReturnTasksProvider` — mutable task list |
| Active return | `delivery_session_providers.dart` | `deliveryActiveReturnProvider` — checklist + refund calc |
| Return stats | `delivery_session_providers.dart` | `deliveryReturnStatsProvider` — deposits refunded this shift |
| Order notes | `delivery_session_providers.dart` | `deliveryOrderNoteProvider` — driver note on active order |
| Task model | `model_delivery_return_task.dart` | Added `id` for task-scoped flows |
| UI feedback | `widgets_async_state_card.dart` | Empty states on return task/process |
| Maps | `utility_url_actions.dart` | External Google Maps launch |

---

## P0 — Pickup & Delivery (CLOSED locally)

### Confirm pickup

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | All items checked → record run + earnings → clear note → success → `/delivery` |
| **ERROR** | Not all items checked → `showError` (even if button somehow pressed) |
| **NULL** | Confirm button disabled until checklist complete |
| **Backend** | `PATCH /orders/{id}/delivery` status `picked_up` + COD amount |

### Report missing item

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Confirm → warning snackbar (escalation logged locally) |
| **NULL** | Cancel confirm → no change |
| **Backend** | `POST /orders/{id}/missing-items` → kitchen alert |

### Add driver note

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Dialog save → `deliveryOrderNoteProvider` → success snackbar; shown on dashboard card |
| **NULL** | Cancel dialog → no change |
| **Backend** | `PATCH /orders/{id}/driver-note` |

---

## P1 — Shift Tracking (CLOSED locally)

### View delivery history (dashboard)

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Dialog shows shift earnings + session completed count + session earnings + refunds |
| **MOCK** | Baseline completed count from `MockupCatalog.deliveryHistoryCompletedCount` |
| **Backend** | `GET /delivery/shift/summary` |

### Pull-to-refresh (dashboard / order / task)

| Outcome | Behavior |
|---------|----------|
| **SUCCESS/MOCK** | Success or info snackbar; no remote reload yet |
| **Backend** | Invalidate `deliveryShiftQueueProvider` from repo |

---

## P2 — Plated Returns (CLOSED locally)

### Open maps

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | `UtilityUrlActions.launchExternalUri` → Google Maps → success snackbar |
| **ERROR** | Launch fails → error snackbar |
| **Backend** | Deep link with lat/lng from task record |

### Confirm collection

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | `beginTask(task)` → success snackbar → `/plated-return-process` |
| **EMPTY** | No tasks → empty-state card on task screen |
| **Backend** | `PATCH /plated-returns/{taskId}` status `collecting` |

### Return checklist (collected / missing)

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Updates `missingItemKeys` on active draft |
| **NULL** | No draft → empty state + CTA to task list |

### Settlement summary

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Computes deposit − breakage from draft (`15 JOD − 2.5 × missing count`) |
| **Backend** | Server-side `process_plated_return` RPC |

### Signature acknowledgement

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Tap pad → `_signatureAcknowledged = true` |
| **ERROR** | Finalize without signature → error snackbar |
| **MOCK** | Tap-to-acknowledge (no canvas capture) |
| **Backend** | Upload signature blob |

### Finalize return

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Confirm → remove task from queue → record refund stat → clear draft → `/delivery` |
| **NULL** | Cancel confirm |
| **Backend** | `POST /plated-returns/{taskId}/finalize` |

---

## Remaining MOCK Cycles (Backend Roadmap)

| Screen | Action | Current | Target API |
|--------|--------|---------|------------|
| Dashboard | Pending kitchen card | Static Order #8845 | Realtime kitchen queue |
| Dashboard | Route map | Illustration only | Live driver GPS + route |
| Order | Notifications icon | Info snackbar | `/notifications` or role feed |
| Return Task | Notifications | Info snackbar | Push notifications |
| All | Pull refresh | Snackbar only | Repo fetch + loading state |
| Pickup | Item list | Static mock catalog | `GET /orders/{id}/pickup-lines` |
| Returns | Signature | Tap acknowledge | Canvas + upload |
| Returns | Wallet credit | Local refund math | Customer wallet RPC |

---

## Screen Quick Matrix

| Screen | Closed locally? | Notes |
|--------|-----------------|-------|
| Delivery Dashboard | ✅ | Notes, earnings, history dialog, real nav |
| Delivery Order | ✅ | Pickup gate + session record |
| Plated Return Task | ✅ | Maps + task-scoped process entry |
| Plated Return Process | ✅ | Dynamic refund + finalize removes task |

---

## QA Verification Checklist

- [ ] Pickup with incomplete checklist → blocked / error
- [ ] Pickup success → earnings increase; note cleared
- [ ] History dialog reflects session pickup count
- [ ] Maps button opens external app or shows error
- [ ] Each return task opens process with correct customer name
- [ ] Mark both items missing → net refund 10 JOD (15 − 5)
- [ ] Finalize without signature → error
- [ ] Finalize success → task removed from list; dashboard refunds stat updates
