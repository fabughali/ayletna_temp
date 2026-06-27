# Staff Action Cycles — Success / Error / Null / Loading

> **Version:** 1.0.0 · **Generated:** 2026-06-19  
> **Companion:** [`staffnavigationmapchecklist.md`](staffnavigationmapchecklist.md) · **Authority:** `docs/prdv1.md` §8.6

Every staff action should form a **closed cycle**: user intent → validation → state change or navigation → feedback.

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
| Session state | `staff_session_providers.dart` | `staffSessionProvider` — attendance + tip ack + history filter |
| Check-in/out | `staff_session_providers.dart` | `checkIn()`, `checkOut()` with duration + session history row |
| Tip acknowledgement | `staff_session_providers.dart` | `acknowledgeTips()`, `disputeTips()` |
| History filter | `staff_session_providers.dart` | `setTipHistoryRange()`, `applyCustomRange()`, `filteredTipHistory` |
| UI feedback | `widgets_async_state_card.dart` | Empty week sections when filter yields no rows |
| Feedback | `utility_mock_feedback.dart` | Confirm dialogs, success/warning/error snackbars |

---

## P0 — Attendance (CLOSED locally)

### Check-in

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Confirm → `checkIn()` → `isOnShift = true` → records `checkInAt` → success snackbar |
| **ERROR** | Already on shift → `showError` |
| **NULL** | Cancel confirm → no change |
| **Backend** | `POST /staff/attendance/check-in` with server timestamp + GPS |

### Check-out

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Confirm → `checkOut()` → computes duration → prepends session history row → success snackbar |
| **ERROR** | Not on shift → `showError` |
| **NULL** | Cancel confirm → no change |
| **Backend** | `POST /staff/attendance/check-out` → `total_hours` RPC |

---

## P1 — Daily Tips (CLOSED locally)

### Acknowledge receipt

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Confirm → `acknowledgeTips()` → hero/policy show verified state → buttons disabled |
| **NULL** | Cancel confirm; already acknowledged/disputed → button disabled |
| **Backend** | `POST /tip-distributions/{id}/acknowledge` |

### Dispute / request follow-up

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Confirm → `disputeTips()` → warning snackbar → dispute badge on hero |
| **NULL** | Cancel confirm; already resolved → buttons disabled |
| **Backend** | `POST /tip-distributions/{id}/dispute` → operator queue |

---

## P2 — Tip History (CLOSED locally)

### Range filter

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Chip tap → updates `tipHistoryRange` → week sections re-filter |
| **EMPTY** | Last month on "This Week" → `WidgetsAsyncStateCard.empty` |
| **Backend** | `GET /staff/tips/history?from=&to=` |

### Custom range apply

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Sheet Apply → `applyCustomRange()` → success snackbar |
| **MOCK** | No date picker; uses full baseline list |
| **Backend** | Date-range query params |

### Download tax statement

| Outcome | Behavior |
|---------|----------|
| **SUCCESS/MOCK** | Success snackbar only; no PDF |
| **Backend** | `GET /staff/tax-statement?year=` PDF |

### Pull-to-refresh (all staff screens)

| Outcome | Behavior |
|---------|----------|
| **SUCCESS/MOCK** | Success snackbar; no remote reload yet |
| **Backend** | Invalidate attendance + tip providers from repo |

---

## Remaining MOCK Cycles (Backend Roadmap)

| Screen | Action | Current | Target API |
|--------|--------|---------|------------|
| Attendance | GPS capture | Note text only | Device geolocation + audit |
| Attendance | Live duration ticker | Updates on rebuild only | Periodic timer / stream |
| Daily Tips | Shift payout cards | Static mock catalog | `GET /staff/tips/today` |
| Daily Tips | Transaction list | Static mock catalog | Realtime tip ledger |
| History | Summary KPI cards | Static l10n values | Aggregated API response |
| History | Tax PDF | Snackbar only | File download |
| All | Pull refresh | Snackbar only | Repo fetch + loading state |

---

## Screen Quick Matrix

| Screen | Closed locally? | Notes |
|--------|-----------------|-------|
| Staff Attendance | ✅ | Check-in/out, duration, session history row |
| Staff Daily Tips | ✅ | Acknowledge + dispute flows |
| Staff Tip History | ✅ | Range filter + empty states |

---

## QA Verification Checklist

- [ ] Check-in confirm → ACTIVE NOW badge + running duration in hero
- [ ] Check-out confirm → off-duty badge + check-in/out rows in shift details
- [ ] Check-out adds "Recorded Shift" to this-week history on tip history screen
- [ ] Acknowledge disables actions and shows verified badge
- [ ] Dispute shows follow-up badge and warning feedback
- [ ] Last month filter hides this-week mock rows
- [ ] Empty week section renders when no rows match filter
- [ ] Notifications opens `/notifications` from all staff screens
