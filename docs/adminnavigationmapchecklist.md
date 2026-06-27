# Admin Navigation Map Checklist

> **Version:** 1.0.0 · **Generated:** 2026-06-19  
> **Source audit:** `lib/screens/admin/` (20 screens) + `widgets_admin_growth_hub.dart`, `widgets_report_filter_sheet.dart`

Use this document to verify every tappable control on operator/owner admin screens.

---

## Legend

| Symbol | Meaning |
|--------|---------|
| ✅ | Real route navigation |
| 🔄 | In-place state change via provider |
| 📋 | Dialog, sheet, or confirmation |
| 🧪 | Mock/demo feedback only (export PDF, KPI refresh) |
| ⚙️ | `admin_session_providers.dart` |

**Roles:** `operator`, `owner` · Routes: `/admin*`

---

## Drawer Hub (`AppRole.operator` / `AppRole.owner`)

| Item | Route |
|------|-------|
| Dashboard | ✅ `/admin` |
| Orders | ✅ `/admin-orders` |
| Menu | ✅ `/admin-menu` |
| Users | ✅ `/admin-users` |
| Financial | ✅ `/admin-financial` |
| Reports | ✅ `/admin-reports` |
| Settings | ✅ `/admin-settings` |
| Profile | ✅ `/account-settings` |

**Sub-routes (not in drawer):** order detail, product/plate editors, deposit config, tip distribution, audit, pre-order, report filter, growth hub screens.

---

## P0 Screens — Closed Cycles

### Orders Management — `/admin-orders`
| Control | Action |
|---------|--------|
| Order card → Open detail | ✅ `/admin-order-detail` |
| Escalate | ⚙️ `escalateOrder` → warning; disabled if already escalated |
| Pull-to-refresh | 🧪 Success snackbar |
| Filter sheet options | 📋 Display only (P1) |

### Order Detail — `/admin-order-detail`
| Control | Action |
|---------|--------|
| Change status | ⚙️ Ready / Delivered → `updateOrderStatus` → success |
| Back to board | ✅ `/admin-orders` |
| Notifications | ✅ `/notifications` |
| Pull-to-refresh | ⚙️ Invalidates order providers + success |

### Pre-Order — `/admin-pre-order`
| Control | Action |
|---------|--------|
| Accept | ⚙️ `acceptPreOrder` → removes from queue |
| Adjust time | 📋 Confirm → `adjustPreOrderTime` |
| Empty queue | `WidgetsAsyncStateCard.empty` → orders board |

### Daily Tips — `/admin-tip-distribution`
| Control | Action |
|---------|--------|
| Recalculate pool | ⚙️ Updates pool JOD; disabled after approve |
| Approve all | 📋 Confirm → `approveAll` |
| Notifications | ✅ `/notifications` |

### User Management — `/admin-users`
| Control | Action |
|---------|--------|
| Invite staff | ⚙️ Appends session member |
| Manage permissions | 📋 Confirm → toggles active status |
| Search | ⚙️ Filters member list |
| Empty search | Empty state card |

### Deposit Config — `/admin-deposit-config`
| Control | Action |
|---------|--------|
| Return window / reminders | 🔄 `adminDepositConfigProvider` |
| Save | ⚙️ Persists session config + success |

### Menu Management — `/admin-menu`
| Control | Action |
|---------|--------|
| Item active toggle | ⚙️ `adminMenuProvider.setItemActive` |
| Bulk import | 📋 Confirm → `bulkImport` (+3 mock items) |
| Add item | ✅ `/admin-product-editor` |
| Notifications | ✅ `/notifications` |

### Product Editor — `/admin-product-editor`
| Control | Action |
|---------|--------|
| Save | 🧪 Success snackbar |
| Publish to menu | 📋 Confirm → `publishProduct` |
| Back to menu | ✅ `/admin-menu` |

### Plate Editor — `/admin-plate-editor`
| Control | Action |
|---------|--------|
| Deposit/delivery/restock toggles | 🔄 `adminPlateConfigProvider` |
| Save asset | ⚙️ `save()` + success |

### Settings — `/admin-settings`
| Control | Action |
|---------|--------|
| Orders open / delivery / tax / kitchen alerts | ⚙️ `adminSettingsProvider` (persisted) |
| Notifications | ✅ `/notifications` |

### Financial Calculation — `/admin-financial`
| Control | Action |
|---------|--------|
| Approve shift close | 📋 Confirm → `approveShiftClose`; disabled after approve |
| Open audit | ✅ `/admin-audit` |
| Notifications | ✅ `/notifications` |

### Audit Log — `/admin-audit`
| Control | Action |
|---------|--------|
| Export log | ⚙️ `recordAuditExport` + success |
| Request audit | 🧪 Success snackbar |
| Notifications | ✅ `/notifications` |

### Report Filter — `/admin-report-filter` + sheet
| Control | Action |
|---------|--------|
| Apply | ⚙️ `adminReportFilterProvider.apply` |
| Reset | ⚙️ `reset()` |

### Growth Hub — owner / loyalty / offers / staff hours
| Control | Action |
|---------|--------|
| Privacy / loyalty / offer toggles | Local UI → Save persists via `adminGrowthConfigProvider` |
| Save settings | ⚙️ `save()` + success |
| Open audit | ✅ `/admin-audit` |

---

## Display-Only Screens (Navigation OK)

| Screen | Route | Notes |
|--------|-------|-------|
| Dashboard | `/admin` | KPI cards; deep links to sub-routes |
| Reports | `/admin-reports` | Analytics; filter sheet wired |
| Plates Management | `/admin-plates` | Asset cards; edit via navigation |
| Staff Hours | `/admin-staff-hours` | Growth hub staff panel |

---

## QA Checklist

- [ ] Order status change on detail reflects on orders board
- [ ] Pre-order accept removes row from queue
- [ ] Tip approve disables recalculate/approve buttons
- [ ] Deposit save persists slider values across navigation
- [ ] Menu toggle survives screen leave/return
- [ ] Settings toggles persist via provider
- [ ] Shift close approve disables repeat
- [ ] Report filter apply updates shared provider
- [ ] Growth hub save persists toggles
- [ ] Notifications route works on wired admin screens
