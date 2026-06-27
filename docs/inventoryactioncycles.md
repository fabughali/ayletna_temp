# Inventory Action Cycles — Success / Error / Null / Loading

> **Version:** 1.0.0 · **Generated:** 2026-06-19  
> **Companion:** [`inventorynavigationmapchecklist.md`](inventorynavigationmapchecklist.md) · **Authority:** `docs/prdv1.md` §8 (operations)

Every inventory action should form a **closed cycle**: user intent → validation → state change or navigation → feedback.

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
| Stock state | `inventory_session_providers.dart` | `inventoryStockProvider` — kg on hand, threshold, session audit rows |
| Wastage logs | `inventory_session_providers.dart` | `inventorySessionWastageProvider` + merged `inventoryWastageLogsProvider` |
| Audit history | `inventory_session_providers.dart` | `inventoryAuditHistoryProvider` |
| Search | `inventory_session_providers.dart` | `inventorySearchQueryProvider` |
| UI feedback | `widgets_async_state_card.dart` | (available for future empty states) |

---

## P0 — Stock Adjustments (CLOSED locally)

### Update inventory (item screen)

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Valid delta → confirm → `applyAdjustment` + audit row → stock/threshold update → success |
| **ERROR** | Empty/zero quantity → `showError` |
| **NULL** | Cancel confirm → no change |
| **Backend** | `POST /inventory/adjustments` `{ sku, deltaKg, reason, threshold? }` |

### Update inventory (stock adjustment screen)

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Qty validated → reason maps to signed delta → confirm → stock update → spoilage also logs wastage → navigate `/inventory` |
| **ERROR** | Missing/invalid quantity → error snackbar |
| **MOCK** | Batch/expiry/evidence not persisted |
| **Backend** | Same as item screen + evidence upload URLs |

---

## P1 — Wastage (CLOSED locally)

### Log wastage (dashboard dialog)

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Item + quantity filled → session wastage log → success snackbar → appears in wastage board |
| **ERROR** | Empty fields → error snackbar |
| **NULL** | Cancel dialog |
| **Backend** | `POST /inventory/wastage` |

### Download wastage report

| Outcome | Behavior |
|---------|----------|
| **MOCK** | `UtilityDemoActions.complete` animation |
| **Backend** | `GET /inventory/wastage/export.csv` |

---

## P2 — Search & Navigation (CLOSED locally)

### Ingredient search (dashboard)

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Query filters alerts + level tiles client-side |
| **EMPTY** | No matches → empty message on alert board |
| **Backend** | `GET /inventory/items?q=` |

### Alert card → item detail

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Navigates `/inventory-item` (Atlantic salmon mock detail) |
| **Backend** | Pass `sku` query param |

---

## P3 — Supplier & Evidence (MOSTLY MOCK)

### Contact supplier

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Phone URI launches → success snackbar |
| **ERROR** | Launch fails → info with supplier name |
| **Backend** | CRM contact record |

### Attach evidence (stock adjustment)

| Outcome | Behavior |
|---------|----------|
| **MOCK** | Success snackbar only |
| **Backend** | `POST /inventory/adjustments/{id}/attachments` |

---

## Remaining MOCK Cycles (Backend Roadmap)

| Screen | Action | Current | Target API |
|--------|--------|---------|------------|
| Dashboard | Storage zone alerts | Static mock | IoT sensor feed |
| Dashboard | Supplier arrival value | Static JOD | PO webhook |
| Dashboard | Dish impact lines | Static l10n | Recipe BOM engine |
| Item | Usage chart | Static bars | `GET /inventory/{sku}/usage` |
| Item | Reason dropdown | Fixed consumption | Reason enum from API |
| Adjustment | Item search field | Read-only salmon | SKU picker |
| All | Pull refresh | Snackbar only | Repo invalidate + loading |

---

## Screen Quick Matrix

| Screen | Closed locally? | Notes |
|--------|-----------------|-------|
| Inventory Dashboard | ✅ | Search, wastage log, nav |
| Inventory Item | ✅ | Live stock + adjust + audit |
| Stock Adjustment | ✅ | Reason-based delta + spoilage link |

---

## QA Verification Checklist

- [ ] Add 5 kg via stock adjustment → item screen shows +5 kg
- [ ] Spoilage 2 kg → stock decreases; wastage board gains entry
- [ ] Threshold update persists on item screen
- [ ] Search "basil" filters to Fresh Basil alert only
- [ ] Log wastage with empty fields → error
- [ ] Audit history prepends session adjustments
- [ ] Submit stock adjustment with empty qty → error, stay on screen
