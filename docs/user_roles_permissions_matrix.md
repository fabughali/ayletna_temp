# Ayletna — User Types, Roles & Permissions Matrix

| Field | Value |
|-------|-------|
| **Purpose** | Full RBAC roadmap and capability tables for Owner · Operator · App Admin · Support · Marketing · ops roles |
| **Status** | **Implemented (UI mock)** — five hubs live; legacy `/admin*` redirects remain; production RBAC persistence deferred to backend |
| **Updated** | 2026-08-01 |
| **Product context** | Single location · one login with multi-role switch · Marketing+Operator dual-approve offers · Support refund/cancel + escalate · subscriptions content-only until payments · audit every refund/price change/published offer |

This document is self-contained for permissions work. Screen routes and financial constants match the live Flutter app hubs: `/app-admin`, `/operator`, `/owner`, `/support-desk`, `/marketing`.

---

## Legend

| Symbol | Meaning |
|--------|---------|
| ✅ | Full access (view + act) |
| 👁 | Read-only |
| 🔶 | Limited / subset |
| ⏳ | Requires approval before active |
| ❌ | No access |
| — | Not applicable |

---

## 1. Role model overview

### 1.1 Management & specialist roles (distinct)

These are **not** interchangeable. Each has its own workspace, default permissions, and screen set.

| Tier | `AppRole` (target) | Who they are | Primary job |
|------|-------------------|--------------|-------------|
| **Owner** | `owner` | Restaurant owner or **shareholder** (holds an **ownership %**) | Monitor performance, finance, profit share, audit — **no day-to-day ops** |
| **Operator** | `operator` | Person who **runs the restaurant** | Daily ops: orders, menu (operational), tips, deposits, inventory oversight, HR, financial close |
| **App Admin** | `admin` | **Application administrator** | Users, roles, permissions, app settings, core integrations, audit, owner visibility rules |
| **Support** | `support` | **Customer support** staff | Tickets, live chat, review/rating moderation, feedback, FAQ — **no menu/pricing edits** |
| **Marketing** | `marketing` | **Marketing & growth** staff | Offers, combos, subscription meals, campaigns, loyalty/rewards content, social & blog integrations |

```text
                         ┌─────────────────┐
                         │   App Admin     │  ← platform / RBAC / users
                         └────────┬────────┘
                                  │ creates & assigns roles
         ┌────────────────────────┼────────────────────────┐
         ▼                        ▼                        ▼
   ┌──────────┐            ┌────────────┐           ┌─────────────┐
   │  Owner   │            │  Operator  │           │  Specialist │
   │ (share %)│            │ (runs ops) │           │  roles      │
   └──────────┘            └─────┬──────┘           │ Support     │
                                  │                 │ Marketing   │
                                  ▼                 └─────────────┘
                            ┌───────────┐
                            │  Employee │  cashier · kitchen · delivery · inventory · staff
                            │  roles    │
                            └───────────┘
```

**Naming note:** Legacy `/admin*` paths redirect to hub prefixes in §11.1–11.5. Canonical routes use `/app-admin`, `/operator`, `/owner`, `/support-desk`, `/marketing`.

### 1.2 All user types (`AppRole`)

| # | User type | `AppRole` | Category |
|---|-----------|-----------|----------|
| 1 | Customer | `customer` | Public |
| 2 | Guest | `guest` | Public (session only) |
| 3 | **Owner** | `owner` | Management — shareholder |
| 4 | **Operator** | `operator` | Management — restaurant manager |
| 5 | **App Admin** | `admin` | Management — app/platform |
| 6 | **Support** | `support` | Back-office — customer care |
| 7 | **Marketing** | `marketing` | Back-office — growth & campaigns |
| 8 | Cashier | `cashier` | Operations |
| 9 | Kitchen | `kitchen` | Operations |
| 10 | Delivery | `delivery` | Operations |
| 11 | Inventory | `inventory` | Operations |
| 12 | Staff | `staff` | Operations |

### 1.3 Owner-specific profile fields (target)

| Field | Description |
|-------|-------------|
| `ownership_percentage` | Shareholder stake (0–100). Sum across owners may equal 100% for the legal entity. |
| `owner_view_config_id` | Which masked report layout this owner sees (set by app admin). |

### 1.4 Multi-role policy (confirmed)

- **One login per person** — app admin assigns **multiple roles** to the same account.
- On assign → **default permission bundle** for that role (§3).
- App admin may **add / remove / modify / postpone** any rule per user.
- **2+ roles** → **Switch role** in Account Settings (§10); active workspace + drawer refresh.
- Roles are **separate workspaces** unless explicitly assigned together.
- **Single location** — one kitchen / cashier set; no multi-branch in v1.

---

## 2. Who can assign which roles

| Actor | Can assign |
|-------|------------|
| **App admin** | All roles including `admin`, `operator`, `owner`, `support`, `marketing`, and all employee roles |
| **Operator** | ❌ Cannot assign management roles; may recommend employee roles (future workflow) |
| **Owner** | ❌ No role assignment |
| **Self-registration** | `customer` only (after OTP). `guest` is session-only. |

| Registration type | Customer | Guest | **Admin** | **Operator** | **Owner** | **Support** | **Marketing** | Cashier | Kitchen | Delivery | Inventory | Staff |
|-------------------|:--------:|:-----:|:---------:|:------------:|:---------:|:-----------:|:-------------:|:-------:|:-------:|:--------:|:---------:|:-----:|
| Customer account | ✅ | — | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Employee account | ❌ | — | ❌ | ❌ | ❌ | ⏳ | ⏳ | ⏳ | ⏳ | ⏳ | ⏳ | ⏳ |
| Management / specialist (app admin–created) | ❌ | — | ⏳ | ⏳ | ⏳ | ⏳ | ⏳ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Guest session | — | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |

**Approval:** Employee roles → `pending_approval` until **app admin** or **operator** (with `perm.admin.users.write`) approves.

---

## 3. Permission matrix by role

**Columns** = `AppRole`. **Rows** = capabilities (permission keys for RBAC UI).

### 3.1 Customer & ordering

| Capability | Guest | Customer | Admin | Operator | Owner | **Support** | **Marketing** | Cashier | Kitchen | Delivery | Inventory | Staff |
|------------|:-----:|:--------:|:-----:|:--------:|:-----:|:-----------:|:-------------:|:-------:|:-------:|:--------:|:---------:|:-----:|
| Home / menu browse | 🔶 | ✅ | ❌ | ❌* | ❌ | 👁 | 👁 | ❌ | ❌ | ❌ | ❌ | ❌ |
| Search, product detail, offers/combos/subscriptions | 🔶 | ✅ | ❌ | ❌* | ❌ | 👁 | 👁 | ❌ | ❌ | ❌ | ❌ | ❌ |
| Cart & checkout | 🔶 | ✅ | ❌ | ❌* | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Order tracking & history | ❌ | ✅ | ❌ | 👁 | 👁 | 👁 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Loyalty & rewards redeem | 🔶 | ✅ | ❌ | ❌* | ❌ | ❌ | 👁 | ❌ | ❌ | ❌ | ❌ | ❌ |
| Profile, addresses, wallet | ❌ | ✅ | ✅ | ✅* | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Customer support / FAQ / chat (as customer) | 🔶 | ✅ | ✅ | ✅ | ✅ | ✅ | 👁 | ✅ | ✅ | ✅ | ✅ | ✅ |

\*Only if **customer** role is explicitly assigned.

### 3.2 Operations (restaurant floor)

| Capability | Guest | Customer | Admin | Operator | Owner | **Support** | **Marketing** | Cashier | Kitchen | Delivery | Inventory | Staff |
|------------|:-----:|:--------:|:-----:|:--------:|:-----:|:-----------:|:-------------:|:-------:|:-------:|:--------:|:---------:|:-----:|
| Cashier POS | ❌ | ❌ | ❌* | ✅* | ❌ | ❌ | ❌ | ✅ | ❌ | ❌ | ❌ | ❌ |
| Cashier history / tip entry / deposit refund | ❌ | ❌ | ❌* | ✅* | ❌ | ❌ | ❌ | ✅ | ❌ | ❌ | ❌ | ❌ |
| Kitchen dashboard & prep | ❌ | ❌ | ❌* | ✅* | ❌ | ❌ | ❌ | ❌ | ✅ | ❌ | ❌ | ❌ |
| Delivery & plated return | ❌ | ❌ | ❌* | ✅* | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ | ❌ | ❌ |
| Inventory & stock adjustment | ❌ | ❌ | ❌* | ✅* | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ | ❌ |
| Staff attendance | ❌ | ❌ | ❌ | ✅* | ❌ | ❌ | ❌ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Staff daily tips & history | ❌ | ❌ | ❌ | ✅ | 👁 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ |
| Daily tip deep link | ❌ | ❌ | ✅ | ✅ | 👁 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ |

\*Only when that **ops role is assigned** (no automatic inheritance).

### 3.3 App administration (`admin` role)

Platform, users, security, and configuration of the app itself.

| Capability | **Admin** | Operator | Owner |
|------------|:---------:|:--------:|:-----:|
| User management & role assignment | ✅ | ❌ | ❌ |
| Permission / rule overrides per user | ✅ | ❌ | ❌ |
| Staff registration approval | ✅ | 👁* | ❌ |
| Audit log (full) | ✅ | 👁 | 👁 |
| App integrations (payment, SMS, etc.) | ✅ | ❌ | ❌ |
| System settings (`/admin-settings` — system tab) | ✅ | ❌ | ❌ |
| Owner view config (what owners can see) | ✅ | ❌ | ❌ |
| RBAC defaults editor (role → permissions) | ✅ | ❌ | ❌ |
| Demo mode / feature flags | ✅ | ❌ | ❌ |

\*Operator may approve staff if app admin grants `perm.admin.users.write`.

### 3.4 Restaurant management (`operator` role)

Runs the business — uses **operator hub** screens (§11.2). When the **operator role is assigned**, user may **view and edit** support tickets and marketing campaigns (confirmed 2026-06-19). **Co-approves** campaign publish with Marketing.

| Capability | Admin | Operator | Owner | Support | Marketing |
|------------|:-----:|:--------:|:-----:|:-------:|:---------:|
| Operations dashboard (live KPIs, queues) | 👁 | ✅ | 👁 | 👁 | 👁 |
| Orders management & order detail | 👁 | ✅ | 👁 | 👁 | ❌ |
| Menu & product CRUD (operational menu) | 👁 | ✅ | ❌ | ❌ | ✅* |
| Pre-orders | 👁 | ✅ | 👁 | ❌ | ❌ |
| Daily tip distribution **approval** | 👁 | ✅ | 👁 | ❌ | ❌ |
| Plates catalog & deposit defaults (operational) | 👁 | ✅ | 👁 | ❌ | ❌ |
| Attendance HR & staff hours report | 👁 | ✅ | 👁 | ❌ | ❌ |
| Operational reports & export | 👁 | ✅ | 👁 | 👁 | 👁 |
| **Monthly financial close** (profit RPC) | 👁 | ✅ | 👁 | ❌ | ❌ |
| Support tickets (view + edit) | 👁 | ✅ | 👁 | ✅ | ❌ |
| Review / rating moderation | 👁 | 👁 | ❌ | ✅ | ❌ |
| Offers / combos / subscriptions CRUD | 👁 | ✅** | ❌ | ❌ | ✅ |
| Promotions & campaign management | 👁 | ✅** | ❌ | ❌ | ✅ |
| Campaign **publish approval** (co-sign) | 👁 | ✅ | ❌ | ❌ | ✅ |
| Loyalty & rewards program content | 👁 | 👁 | 👁 | ❌ | ✅ |
| Social media & blog integrations | 👁 | 👁 | ❌ | ❌ | ✅ |

\*Marketing **publishes menu prices** (base product prices); Operator retains full menu CRUD.  
\*\*Operator edits campaigns when role assigned; publish requires **dual approval** with Marketing (§7.3).

### 3.5 Owner / shareholder portal (`owner` role)

Financial visibility tied to **ownership %** — uses **owner hub** screens (§11.3).

| Capability | **Admin** | **Operator** | **Owner** |
|------------|:---------:|:------------:|:---------:|
| Owner dashboard (revenue, share, KPIs) | 👁 | ❌ | ✅ |
| View own ownership percentage | ✅ | ❌ | ✅ |
| Monthly profit & distribution reports | 👁 | 👁 | ✅* |
| Financial calculation results | 👁 | 👁 | ✅* |
| Tip ledger summary | 👁 | ✅ | 👁* |
| Deposit & plated asset status | 👁 | ✅ | 👁* |
| Audit log | ✅ | 👁 | 👁* |
| Export reports (PDF/Excel) | 👁 | ✅ | ✅* |

\*Visibility filtered by **`owner_view_config`** (masking set by app admin). Default: read-only.

### 3.7 Support (`support` role)

Customer care — uses **support hub** screens (§11.4). Confirmed v1 scope (2026-06-19).

| Capability | Admin | Operator | **Support** |
|------------|:-----:|:--------:|:-----------:|
| Support hub dashboard (open tickets, SLA queue) | 👁 | 👁 | ✅ |
| **SLA timers** (breach warnings on tickets/chat) | 👁 | 👁 | ✅ |
| **Shift handover** (open queue summary + notes) | 👁 | 👁 | ✅ |
| **Agent performance reports** (resolved count, response time) | 👁 | 👁 | ✅ |
| Support tickets (create, assign, resolve, escalate) | 👁 | ✅ | ✅ |
| Live chat / conversation queue | 👁 | 👁 | ✅ |
| **Customer PII on every ticket** (phone, address — full visibility) | 👁 | 👁 | ✅ |
| Customer order lookup + **refund / cancel order** | 👁 | ✅ | ✅ |
| Escalate to Operator / Cashier (complex cases) | 👁 | ✅ | ✅ |
| Review & rating moderation (approve / reject / flag) | 👁 | 👁 | ✅ |
| Product review feedback & customer comments | 👁 | 👁 | ✅ |
| FAQ content (customer-facing answers) | 👁 | 👁 | ✅ |
| Post-resolution customer notifications | 👁 | 👁 | ✅ |
| Menu / pricing / offer edits | 👁 | 👁 | ❌ |
| Tip ledger / financial close | 👁 | ✅ | ❌ |

**Drawer (target):** Dashboard · Tickets · Live chat · Reviews · FAQ · Profile

**Audit (mandatory):** every refund and order cancellation initiated by support (§7.3).

### 3.8 Marketing (`marketing` role)

Growth & campaigns — uses **marketing hub** screens (§11.5). Confirmed v1 launch scope (2026-06-19).

| Capability | Admin | Operator | **Marketing** |
|------------|:-----:|:--------:|:-------------:|
| Marketing hub dashboard (campaigns, performance) | 👁 | 👁 | ✅ |
| Offers CRUD | 👁 | ✅ | ✅ |
| Combos CRUD | 👁 | ✅ | ✅ |
| Subscription meals — **content only** (no billing until payment provider) | 👁 | ✅ | ✅ |
| Promotions & discounts management | 👁 | ✅ | ✅ |
| Catalog media for campaigns (hero images, copy) | 👁 | 👁 | ✅ |
| Loyalty program rules & rewards catalog | 👁 | 👁 | ✅ |
| Rewards management (earn / redeem campaigns) | 👁 | 👁 | ✅ |
| **Push campaigns** (required v1 launch) | 👁 | 👁 | ✅ |
| **Social media integrations** (required v1 launch) | 👁 | 👁 | ✅ |
| **Blog / content posts** (required v1 launch) | 👁 | 👁 | ✅ |
| **Campaign calendar** (required v1 launch) | 👁 | 👁 | ✅ |
| **Menu pricing — publish base product prices** | 👁 | ✅ | ✅ |
| Campaign **publish** (requires Operator co-approval) | 👁 | ✅ | ✅ |
| Support tickets & chat | 👁 | ✅ | ❌ |
| Financial close | 👁 | ✅ | ❌ |

**Drawer (target):** Dashboard · Offers · Combos · Subscriptions · Promotions · Loyalty · Rewards · Calendar · Push · Social · Blog · Profile

**Audit (mandatory):** every price change and every published offer (§7.3).

### 3.9 Account & session (all roles)

| Capability | Guest | Customer | Admin | Operator | Owner | Support | Marketing | Ops roles |
|------------|:-----:|:--------:|:-----:|:--------:|:-----:|:-------:|:---------:|:---------:|
| Account settings | ❌ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Switch role (2+ assigned) | ❌ | ✅* | ✅* | ✅* | ✅* | ✅* | ✅* | ✅* |
| Notifications | 🔶 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |

\*Only when admin has assigned **2+ roles**. Switch available from **Account Settings** (§10).

**Cashier POS catalog (recommended — §9):** Subscription meals are **not** sold on cashier POS (offers + combos only).

---

## 4. Cross-role workspace access (target)

User may open a workspace **only if that role is assigned**.

| Workspace | Default home route (target) | Typical assignees |
|-----------|----------------------------|-------------------|
| App admin | `/app-admin` | `admin` |
| Operator | `/operator` | `operator` |
| Owner | `/owner` | `owner` (+ `ownership_percentage`) |
| **Support** | `/support-desk` | `support` |
| **Marketing** | `/marketing` | `marketing` |
| Cashier | `/cashier` | `cashier`, optionally `operator` |
| Kitchen | `/kitchen` | `kitchen`, optionally `operator` |
| Delivery | `/delivery` | `delivery`, optionally `operator` |
| Inventory | `/inventory` | `inventory`, optionally `operator` |
| Staff | `/staff-attendance` | all ops roles + `staff` |
| Customer | `/home` | `customer` |

**App admin** does **not** automatically inherit other management or specialist workspaces unless those roles are also assigned.

---

## 5. Sensitive data (RLS target)

| Data domain | Admin | Operator | Owner | **Support** | **Marketing** | Cashier | Ops staff | Customer |
|-------------|:-----:|:--------:|:-----:|:-----------:|:-------------:|:-------:|:---------:|:--------:|
| Recipe cost & secrets | ✅ R/W | ✅ R/W | 👁 config | ❌ | ❌ | ❌ | ❌ | ❌ |
| User roles & permission overrides | ✅ R/W | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| `ownership_percentage` | ✅ R/W | 👁 | 👁 own | ❌ | ❌ | ❌ | ❌ | ❌ |
| Customer PII in tickets/chat | ✅ | 👁 | ❌ | ✅ R/W (full on every ticket) | ❌ | ❌ | ❌ | own |
| Published reviews & ratings | ✅ | 👁 | 👁 | ✅ R/W | 👁 | ❌ | ❌ | own |
| Menu base prices (published) | ✅ R/W | ✅ R/W | 👁 | ❌ | ✅ R/W | ❌ | ❌ | ❌ |
| Campaign pricing & promo rules | ✅ | 👁 | 👁 | ❌ | ✅ R/W | ❌ | ❌ | ❌ |
| Tip ledger (full) | ✅ | ✅ | 👁 summary | ❌ | ❌ | ❌ | own share | ❌ |
| Deposit on order | ✅ | ✅ R/W | 👁 | 👁 | ❌ | read/update | delivery: return | own |
| Monthly profit distribution | ✅ | ✅ run | 👁 prorated by % | ❌ | ❌ | ❌ | ❌ | ❌ |

---

## 6. Account status gates

| Status | Effect |
|--------|--------|
| `active` | Permissions from §3 |
| `pending_approval` | `/pending-approval` only |
| `suspended` | Login blocked |
| `rejected` | Employee role denied |

---

## 7. RBAC lifecycle (app admin)

```text
App admin assigns role(s)
        ↓
Default permissions from role_permissions (§3)
        ↓
Effective = UNION(role defaults) + user overrides
        ↓
App admin: GRANT | REVOKE | MODIFY | POSTPONE any rule
        ↓
audit_logs (actor = admin user id)
```

### 7.1 Permission key namespaces

```
perm.customer.*
perm.cashier.* / perm.kitchen.* / perm.delivery.* / perm.inventory.*
perm.staff.*

perm.operator.*          # restaurant management (§3.4)
perm.owner.*             # shareholder portal (§3.5)
perm.support.*           # tickets, chat, reviews, FAQ, refunds, SLA (§3.7)
perm.marketing.*         # offers, combos, subscriptions, campaigns, menu pricing (§3.8)
perm.app_admin.*         # platform (§3.3)
```

### 7.2 DB tables (target)

| Table | Purpose |
|-------|---------|
| `profiles` | incl. `ownership_percentage` for owners |
| `user_roles` | assigned roles |
| `role_permissions` | defaults from §3 |
| `user_permission_overrides` | incl. `postponed_until` |
| `owner_view_config` | field masks per owner tier |
| `audit_logs` | all admin actions + §7.3 mandatory events |

### 7.3 Mandatory audit events (confirmed v1)

Every row below **must** write an `audit_logs` entry (actor user id, action type, entity id, before/after snapshot, timestamp).

| Event | Typical actor | Notes |
|-------|---------------|-------|
| **Refund issued** | Support, Operator, Cashier | Amount, order id, reason |
| **Order cancelled** (by staff) | Support, Operator | Order id, reason |
| **Menu / base price change** | Marketing, Operator | Product id, old price, new price |
| **Offer / campaign published** | Marketing (+ Operator co-approval) | Campaign id, publish timestamp |

See `docs/prdv1.md` §4.1a (audit events) and `audit_log_providers.dart` for mock audit writes on refund / price change / published offer.

---

## 8. Confirmed product decisions

| # | Decision |
|---|----------|
| 1 | Management tiers: **Owner**, **Operator**, **App Admin** — plus specialists **Support** and **Marketing**. |
| 2 | **Single location** — one kitchen / cashier set (no multi-branch v1). |
| 3 | **Support** owns tickets, chat, reviews, FAQ; **full PII** on tickets; **refunds & cancel orders**; SLA / shift handover / agent metrics in v1; escalates to Operator/Cashier when needed. |
| 4 | **Marketing** publishes **menu prices**; owns offers, combos, subscriptions (content only until payment wired), promotions, loyalty, push, social, blog, calendar — all **required at launch**. |
| 5 | **Dual approval:** Marketing + Operator must co-approve before campaign/offer publish. |
| 6 | **Operator overlap:** when role assigned, Operator may **view and edit** support tickets and marketing campaigns (not redirect-only). |
| 7 | **One login**, multiple roles per account; **Switch role** in Account Settings (§10). |
| 8 | Subscriptions **excluded** from cashier POS (offers + combos only); subscription **billing** deferred until payment provider. |
| 9 | Operator does **not** assign management roles; app admin does. |
| 10 | **Audit:** every refund, every price change, every published offer (§7.3). |

---

## 9. Cashier POS catalog

| Section | Include? |
|---------|:--------:|
| Offers | ✅ |
| Combos | ✅ |
| Menu by category | ✅ |
| Subscriptions | ❌ |

---

## 10. Account Settings — Switch role

**When:** user has **2+ assigned roles** (from app admin).  
**Where:** `/account-settings` → **Switch role** button.

**Behavior (confirmed):**

1. Show list of **only assigned** roles (`session.approvedRoles`).
2. User picks a role → update active `appRoleProvider`.
3. **Hot-restart effect:** `context.go(homeRouteForRole(role))` — navigation stack cleared, lands on that role's **hub home**, theme and drawer refresh for the new role.

| Role | Home after switch |
|------|-------------------|
| `admin` | `/app-admin` |
| `operator` | `/operator` |
| `owner` | `/owner` |
| `support` | `/support-desk` |
| `marketing` | `/marketing` |
| Ops roles | `/cashier`, `/kitchen`, etc. |
| `customer` | `/home` |

---

## 11. Screens & routes by management tier

Maps existing files under `lib/screens/admin/` to **target** ownership. Implementation will split routes and drawers.

### 11.1 App Admin hub (`AppRole.admin`)

| Target route | Screen (current file) | Notes |
|--------------|----------------------|-------|
| `/app-admin` | *new hub* | Replaces generic `/admin` for app admin home |
| `/app-admin/roles` | *new `app_admin_role_permissions_screen.dart`* | **Screen A** — generic roles & default rules |
| `/app-admin/users` | *new `app_admin_user_permissions_screen.dart`* | **Screen B** — user list, assigned roles, inherited + override rules |
| `/app-admin/users/:userId` | same (detail) | Per-user role assign + override editor |
| `/app-admin/audit` | `admin_audit_log_screen.dart` | Full audit |
| `/app-admin/integrations` | `admin_app_integrations_screen.dart` | Payment, SMS, etc. |
| `/app-admin/settings` | `admin_settings_screen.dart` | **System** section only |
| `/app-admin/owner-config` | `admin_owner_view_config_screen.dart` | Mask fields for owner role |

**Drawer (target):** **Roles & rules** · **Users & permissions** · Audit · Integrations · Owner visibility · System settings · Profile

#### RBAC admin UI (two screens — confirmed)

| Screen | Route | What app admin manages |
|--------|-------|------------------------|
| **A — Roles & generic rules** | `/app-admin/roles` | Each `AppRole` and its **default permission bundle** (capability keys from §3). Edits apply as role defaults for all users with that role (unless user has an override). |
| **B — Users, roles & effective rules** | `/app-admin/users` | **List of users** with assigned role(s). Per user: **inherited rules** (union of role defaults) + **user-specific overrides** (grant / revoke / modify / postpone). Also: invite, approve, suspend, ownership %. |

**Effective permissions** = `UNION(all assigned role defaults)` + `user_permission_overrides`.

Legacy `admin_user_management_screen.dart` → replaced by or redirected to Screen B.

### 11.2 Operator hub (`AppRole.operator`)

| Target route | Screen (current file) | Notes |
|--------------|----------------------|-------|
| `/operator` | `admin_dashboard_screen.dart` | Live ops KPIs |
| `/operator/orders` | `admin_orders_management_screen.dart` | |
| `/operator/order-detail` | `admin_order_detail_screen.dart` | |
| `/operator/menu` | `admin_menu_management_screen.dart` | |
| `/operator/product-editor` | `admin_product_editor_screen.dart` | |
| `/operator/tips/distribute` | `admin_daily_tip_distribution_screen.dart` | Approve & RPC |
| `/operator/plates` | `admin_plates_management_screen.dart` | |
| `/operator/plate-editor` | `admin_plate_editor_screen.dart` | |
| `/operator/deposit-config` | `admin_deposit_config_screen.dart` | Operational defaults |
| `/operator/pre-orders` | `admin_pre_order_screen.dart` | |
| `/operator/attendance` | `admin_attendance_hr_screen.dart` | |
| `/operator/staff-hours` | `admin_staff_hours_report_screen.dart` | |
| `/operator/reports` | `admin_reports_screen.dart` | |
| `/operator/report-filter` | `admin_report_filter_screen.dart` | |
| `/operator/financial-close` | `admin_financial_calculation_screen.dart` | Operator runs month-end |

**Moved to Support (§11.4):** `admin_support_tickets_screen.dart`, `admin_reviews_moderation_screen.dart`  
**Moved to Marketing (§11.5):** `admin_promotions_management_screen.dart`, `admin_offers_management_screen.dart`, `admin_menu_catalog_screen.dart`, `admin_loyalty_config_screen.dart`, `admin_rewards_management_screen.dart`

**Drawer (target):** Dashboard · Orders · Menu · Tips · Plates · Staff HR · Reports · Financial close · Profile  
**Plus** any **assigned** ops or specialist roles via Switch role.

### 11.3 Owner hub (`AppRole.owner`)

| Target route | Screen (current / new) | Notes |
|--------------|------------------------|-------|
| `/owner` | *new `owner_dashboard_screen.dart`* | Share %, revenue, profit summary |
| `/owner/reports` | `admin_reports_screen.dart` | **Read-only**, filtered by `owner_view_config` |
| `/owner/financial` | `admin_financial_calculation_screen.dart` | **Read-only** results |
| `/owner/audit` | `admin_audit_log_screen.dart` | **Read-only** subset |
| `/owner/profile` | `user_personal_settings_screen.dart` | Shows ownership % |

**Drawer (target):** Dashboard · Reports · Financial · Audit · Profile  
**No** menu editing, user management, or ops screens by default.

### 11.4 Support hub (`AppRole.support`)

| Target route | Screen (current / new) | Notes |
|--------------|------------------------|-------|
| `/support` | *new `support_dashboard_screen.dart`* | Open tickets, chat queue, SLA |
| `/support/tickets` | `admin_support_tickets_screen.dart` | Full ticket CRUD |
| `/support/chat` | *new or reuse* `customer_support_chat_screen.dart` pattern | Agent live chat queue |
| `/support/reviews` | `admin_reviews_moderation_screen.dart` | Approve / reject / flag ratings |
| `/support/faq` | `customer_faq_screen.dart` (admin edit mode) or *new FAQ editor* | Customer-facing FAQ content |
| `/support/orders` | *new read-only lookup* | Order context for tickets |

**Drawer (target):** Dashboard · Tickets · Live chat · Reviews · FAQ · Profile

**Implemented (UI mock):** 6 hub screens. **v1 enhancements (done in mock):** SLA + shift handover + agent metrics on dashboard; refund/cancel on order lookup; full PII on tickets.

### 11.5 Marketing hub (`AppRole.marketing`)

| Target route | Screen (current / new) | Notes |
|--------------|------------------------|-------|
| `/marketing` | *new `marketing_dashboard_screen.dart`* | Campaign KPIs, scheduled promos |
| `/marketing/offers` | `admin_offers_management_screen.dart` | |
| `/marketing/combos` | `admin_promotions_management_screen.dart` | Combo section |
| `/marketing/subscriptions` | `admin_promotions_management_screen.dart` | Subscription meals section |
| `/marketing/promotions` | `admin_promotions_management_screen.dart` | Discounts & promos |
| `/marketing/catalog` | `admin_menu_catalog_screen.dart` | Campaign imagery & copy |
| `/marketing/loyalty` | `admin_loyalty_config_screen.dart` | Program rules |
| `/marketing/rewards` | `admin_rewards_management_screen.dart` | Rewards catalog |
| `/marketing/social` | `marketing_dashboard_screen.dart` (`MarketingSocialIntegrationsScreen`) | Meta, Instagram, etc. |
| `/marketing/blog` | *new `marketing_blog_screen.dart`* | Posts / CMS links |

**Drawer (target):** Dashboard · Offers · Combos · Subscriptions · Promotions · Loyalty · Rewards · Social & blog · Profile

**Implemented (UI mock):** 10 hub screens (+ promotions tabs). **v1 enhancements (done in mock):** menu price publish; dual Operator approval on publish; subscription content-only until payment provider. Push, social, blog, calendar required at launch.

### 11.6 Shared / legacy routes

| Route | Status |
|-------|--------|
| `/admin`, `/admin-*` | **Redirect-only** → canonical hub per `AppRole` (see `prdv1.md` §7.5) |
| `/account-settings` | Unchanged — all authenticated roles + Switch role when 2+ approved |

### 11.7 Employee & customer screens (unchanged)

| Area | Folder | Roles |
|------|--------|-------|
| Auth | `lib/screens/auth/` | All |
| Customer | `lib/screens/customer/` | `customer`, `guest` (subset) |
| Cashier | `lib/screens/cashier/` | `cashier` (+ assigned) |
| Kitchen | `lib/screens/kitchen/` | `kitchen` (+ assigned) |
| Delivery | `lib/screens/delivery/` | `delivery` (+ assigned) |
| Inventory | `lib/screens/inventory/` | `inventory` (+ assigned) |
| Staff | `lib/screens/staff/` | `staff` + ops roles with attendance |

---

## 12. Migration gap (resolved — UI mock, 2026-06-28)

| Item | Was (pre–five-hub) | Now (as-built) |
|------|-------------------|----------------|
| `AppRole` enum | `operator`, `owner` only for management | `admin`, `operator`, `owner`, `support`, `marketing` + ops roles |
| Management UI | Single `/admin*` for operator **and** owner | Five hubs: `/app-admin`, `/operator`, `/owner`, `/support-desk`, `/marketing` |
| Route guard | `/admin*` → operator OR owner | Hub prefixes per role; `/admin*` **redirect-only** via `UtilityRouteGuard._legacyAdminRedirect` |
| Operator ops access | Operator opens all ops routes | Operator + **assigned** ops roles (kitchen, cashier, delivery, inventory, staff) |
| Support / marketing screens | Under shared `/admin-*` | Dedicated hubs §11.4–11.5 |
| User management | `admin_user_management_screen.dart` | `/app-admin/users` + `/app-admin/users/:id` (Screens B) |
| l10n | `roleOperator`, `roleOwner` | `roleAdmin`, `roleSupport`, `roleMarketing` added |
| Theme | `CoreTheme.themeFor(operator/owner)` | Palettes for admin, support, marketing |

**Still deferred (Phase 11 — backend):**

- Persist RBAC rules/overrides in Supabase (Screens A & B are UI mock).
- Replace demo session role picker with `profiles.role` + `approved_roles` from Auth.
- Enforce capability map server-side (RLS / edge functions).

**Product authority:** `docs/prdv1.md` §4, §6, §7. **Implementation rules:** `docs/development_rules.md`. Backend persistence of RBAC remains the next phase (`docs/prdv1.md` §19.2).

---

*Last updated: 2026-08-01 — five-hub UI mock complete; broken checklist links removed; backend scope in `docs/prdv1.md` §19.2.*
