# PRODUCT.md — Ayletna Restaurant (مطعم عيلتنا)

| Field | Value |
|-------|-------|
| **Updated** | 2026-08-01 |
| **Phase** | UI/UX mock complete · frontend cycles closed · backend planned |
| **Demo** | https://fabughali.github.io/ayletna_temp/ |
| **Repo** | https://github.com/fabughali/ayletna_temp |

Self-contained product brief for design/ops agents. Full field catalogs, screen lists, and Supabase schema targets live in `docs/prdv1.md` (product source of truth). Implementation rules live in `docs/development_rules.md`.

---

## Product

Integrated digital platform for **Ayletna Restaurant** (Jordan, **JOD**): customer ordering plus ops/financial controls. Four order channels — **dine-in**, **takeaway**, **delivery**, **plated delivery** (deposit + return). Strict separation of **food revenue**, **tips**, and **plate deposits**.

Canonical money constants: owner monthly minimum **300 JOD**; operator fixed salary **450 JOD**; surplus split **50/50** after minimum; default plate deposit **10 JOD**; plated return reminder **60 minutes**.

## Platforms & languages

- Flutter: Android, iOS, Web
- Arabic (RTL, default) + English (LTR) via ARB — never hardcode UI strings

## Current implementation

**Interactive UI mock only.** Riverpod + in-memory providers / mock repositories. No Supabase, HTTP, or persistence across restarts.

**Cycle PASS bar:** action mutates shared state visible on another screen/role. Snackbar alone = FAIL.

**Verified cycles (provider smoke):** cart→order (S1), offer visibility (S2), blog/push→customer (S3), support accept→ticket (S4), cashier→kitchen (S5) — `test/frontend_cycle_smoke_test.dart`.

**Flags (`lib/core/app_config.dart`):** `demoModeEnabled = false` · `useSteppedCheckoutRoutes = true`.

## Personas / roles

| Role | Job |
|------|-----|
| Guest / Customer | Browse, cart, stepped checkout, track, loyalty, support, blog |
| Cashier | POS, tips, deposits, send to kitchen |
| Kitchen | Prep board, ready / handover |
| Inventory | Stock, adjustments, alerts |
| Delivery | Runs, plated returns |
| Staff | Attendance, tip transparency |
| Support | Tickets, chat queue, FAQ, refund/cancel, SLA |
| Marketing | Offers (co-approval), blog, push, social, calendar; menu price publish |
| Operator | Daily ops, catalogs, campaign approve, reports |
| App Admin | Users, RBAC, integrations |
| Owner | Read-heavy dashboard + configurable views |

**Multi-role:** one login; switch active role from Account Settings. Support refunds/cancels with escalate path. Marketing + Operator dual-approve offers. Subscriptions = content only until payments. Single location in v1.

## Navigation rules

- Drawer-first — **no bottom navigation**
- All screens use `WidgetsScaffoldPage`
- Pre-auth: no app bar, drawer, or profile avatar
- Primary drawer destinations → menu icon; sub-routes → back
- Hubs: `/app-admin`, `/operator`, `/owner`, `/support-desk`, `/marketing`

## Critical product rules

- Plated purple `#7B1FA2` locked for plated order semantics
- Guests must not get fake payment success
- Tips/deposits never mix into revenue totals
- One brand (falafel gold `#C98A42`) / one widget kit for all roles
- Profile, tracking, confirmation read live providers — not static fake identity
- Audit (mock): every refund, price change, published/approved offer

## Visual system (summary)

Primary `#C98A42` · on-primary `#4A3325` · secondary olive `#6E6A35` · cream bg `#F9F6F0` · dark `#121212`. Full palette, anti-patterns, and Stitch notes: `DESIGN.md`.

## Backend roadmap (remaining work)

Replace mock wiring in `lib/data/repositories/repository_providers.dart` + add `*Supabase` repository classes. Prioritize auth/profiles, menu, orders (realtime boards), payments, tips/attendance, plated returns, finance RPCs, RLS. Do not add HTTP clients inside screens. Schema targets are in `docs/prdv1.md` §10.
