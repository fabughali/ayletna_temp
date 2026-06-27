# Admin Action Cycles — Success / Error / Null / Loading

> **Version:** 1.0.0 · **Generated:** 2026-06-19  
> **Companion:** [`adminnavigationmapchecklist.md`](adminnavigationmapchecklist.md) · **Authority:** `docs/prdv1.md` §8.5

---

## Infrastructure Added (v1.0.0)

| Provider | Purpose |
|----------|---------|
| `adminOrdersProvider` | Status updates, pre-order accept, escalation, active/pre-order lists |
| `adminSettingsProvider` | Branch settings toggles |
| `adminDepositConfigProvider` | Return window + reminders |
| `adminTipDistributionProvider` | Pool recalc + approve all |
| `adminUsersProvider` | Invite, search, active toggle |
| `adminMenuProvider` | Item active, bulk import, publish |
| `adminPlateConfigProvider` | Plate asset flags + save |
| `adminGrowthConfigProvider` | Owner privacy, loyalty, offers |
| `adminReportFilterProvider` | Shared report filter state |
| `adminFinancialProvider` | Shift close approve + audit export timestamp |

---

## P0 — Operations (CLOSED locally)

### Update order status
| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Action sheet → `updateOrderStatus` → success; hero badge updates |
| **Backend** | `PATCH /orders/{id}` status |

### Accept pre-order
| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | `acceptPreOrder` → row removed from pre-order queue |
| **EMPTY** | Empty state + CTA to orders board |

### Approve tip distribution
| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Confirm → `approveAll` → buttons disabled |
| **NULL** | Cancel confirm |

### Invite / manage staff
| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Invite appends member; permissions confirm toggles active |
| **EMPTY** | No search matches → empty card |

### Save deposit / plate / growth config
| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Provider `save()` + success snackbar |
| **Backend** | `app_settings` / plate catalog RPC |

### Menu item toggle / publish
| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Toggle persists in `adminMenuProvider`; publish adds product id set |
| **Backend** | Menu CRUD API |

### Approve shift close
| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Confirm → `approveShiftClose`; button disabled |
| **Backend** | Shift close RPC |

### Apply report filter
| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | `adminReportFilterProvider.apply` with period/channel/modules |
| **Backend** | Reports query params |

---

## P1 — Remaining MOCK

| Action | Current | Target |
|--------|---------|--------|
| Dashboard KPI refresh | Static catalog | Realtime aggregates |
| Reports PDF/CSV export | Success snackbar | File generation |
| Order detail guest contact | Info snackbar | `tel:` / messaging |
| Order board filter chips | Empty no-op | Client filter provider |
| Audit filter chips | Snackbar | Filter timeline |
| Product editor media/variants | Info snackbar | CRUD APIs |

---

## Screen Quick Matrix

| Screen | Closed locally? |
|--------|-----------------|
| Orders Management | ✅ |
| Order Detail | ✅ |
| Pre-Order | ✅ |
| Daily Tip Distribution | ✅ |
| User Management | ✅ |
| Deposit Config | ✅ |
| Menu Management | ✅ |
| Product Editor | ✅ (publish) |
| Plate Editor | ✅ |
| Settings | ✅ |
| Financial Calculation | ✅ |
| Audit Log | ✅ (export marker) |
| Report Filter | ✅ |
| Growth Hub (4 screens) | ✅ (save) |
| Dashboard / Reports / Plates Mgmt | Display + nav |

---

## QA Verification Checklist

- [ ] Change order to Ready → visible on board
- [ ] Escalate once → button disabled on second tap
- [ ] Accept pre-order → count drops in hero
- [ ] Approve tips → pool buttons disabled
- [ ] Invite user → appears at top of list
- [ ] Deposit save → values retained after pop/push
- [ ] Menu toggle off → card shows inactive
- [ ] Publish product → id in published set
- [ ] Report filter apply → `appliedAt` set on provider
- [ ] Growth hub save → success after toggle changes
