# Ayletna Restaurant · مطعم عيلتنا

Order like family. Run like a pro. **Ayletna** turns a beloved Jordanian kitchen into a complete digital hospitality experience — bilingual, beautiful, and built for every seat in the house.

From the first scroll through falafel and shawarma to the last plated tray return, Ayletna connects guests, cashiers, kitchen, delivery, support, marketing, and owners in one warm, olive-and-gold branded world.

---

## Why Ayletna stands out

- **Four real order channels** — dine-in, takeaway, delivery, and plated service with deposit & return  
- **Arabic-first & English-ready** — true RTL/LTR with polished Material 3 UI  
- **Full restaurant OS** — customer app, POS, kitchen board, inventory, delivery runs, tips, loyalty, and admin command centers  
- **Financial clarity** — food revenue, tips, and plate deposits stay cleanly separated  
- **Role-aware journeys** — guest, customer, cashier, kitchen, inventory, delivery, staff, support, marketing, operator, owner, and app admin  

---

## What you can do

### For guests & customers
Browse rich menu cards, build combos, claim offers, stepped checkout, track orders, earn loyalty points, redeem rewards, manage addresses, chat with support, and read published blog content.

### For the floor & kitchen
Run a fast cashier POS, send tickets to the kitchen pass, print or e-ticket receipts, settle plated deposits, prep orders, adjust stock with evidence, and complete delivery pickups plus plated returns.

### For the business
Moderate reviews, manage menus and promotions, co-approve marketing offers, run FAQ and ticket desks, schedule campaigns, configure loyalty growth, and monitor owner-level dashboards with permission-aware views.

---

## Built with craft

| Layer | Stack |
|-------|--------|
| App | Flutter (Android · iOS · Web) |
| State | Riverpod (in-memory mock providers today) |
| Navigation | go_router · drawer-first (no bottom nav) |
| Design | Material 3 · shared widget system · `UtilitySizer` |
| Locales | Arabic (RTL) · English (LTR) via ARB |
| Data | Mock repositories — ready for Supabase switch |

**Status:** UI mock complete; frontend action cycles closed (provider smoke S1–S5). Backend (Supabase Auth, orders, payments, RLS) is the remaining work.

---

## Canonical docs

| Document | Purpose |
|----------|---------|
| [`docs/prdv1.md`](docs/prdv1.md) | Product requirements (screens, roles, finance, backend targets) |
| [`docs/development_rules.md`](docs/development_rules.md) | How to implement Flutter UI & mock logic |
| [`docs/user_roles_permissions_matrix.md`](docs/user_roles_permissions_matrix.md) | RBAC capability matrix |
| [`DESIGN.md`](DESIGN.md) | Visual design system |
| [`PRODUCT.md`](PRODUCT.md) | Short product brief for design agents |
| [`AGENTS.md`](AGENTS.md) | Condensed agent operating brief |
| `color_list_chat_gpt.txt` | Hex color source of truth |

---

## Explore

- **GitHub:** https://github.com/fabughali/ayletna_temp  
- **Live demo:** https://fabughali.github.io/ayletna_temp/  

Welcome to the table. **Ayletna is ready when you are.**
