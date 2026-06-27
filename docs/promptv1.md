# Ayletna Implementation Master Prompt v1
## Ayletna Restaurant · مطعم عيلتنا

**Purpose:** Single instruction set for AI agents and developers implementing or extending the Flutter app. Combines product requirements, UI/UX rules, and front-end mock logic into one workflow.

**Last updated:** 2026-06-19  
**Audience:** Cursor agents with MCP tools enabled — **use MCP proactively** (see §3).

---

## 1. Document hierarchy (conflict resolution)

When documents disagree, follow this order:

| Priority | Document | Authority |
|----------|----------|-----------|
| **1** | **`docs/prdv1.md`** | **What** to build: screens, flows, roles, finance, acceptance criteria, as-built status |
| **2** | **`color_list_chat_gpt.txt`** | **All hex values** (brand, roles, order types, financial semantics) |
| **3** | **`docs/promptv1.md`** (this file) | **How** to implement UI + mock logic — must not contradict 1 or 2 |
| **4** | **`.cursor/rules`** | Riverpod, Material 3, `RefreshIndicator`, no `.withOpacity()` |
| **5** | **Cursor MCP servers** (§3) | **How** to investigate, verify, integrate, and test — never overrides 1–4 |

**Rules:**

- If this prompt disagrees with **`prdv1.md`** on product behavior → follow **`prdv1.md`** and update this file.
- If a screen’s colors disagree with **`color_list_chat_gpt.txt`** → follow **`color_list`** and fix the screen.
- For full screen catalog, backend schema, RPC list, and financial formulas → read **`docs/prdv1.md`** §7–§10; do not guess.

**Companion docs (reference only):**

| File | Use |
|------|-----|
| `docs/UI_UX_REDESIGN_CHECKLIST.md` | Redesign sprint tracking |
| `docs/mockup_logic_checklist.md` | Per-screen mock wiring progress |
| `docs/uiux_redesign_checklist.md` | Historical redesign log |

---

## 2. Current implementation phase

### 2.1 What exists today

| Area | Status |
|------|--------|
| 75 screens under `lib/screens/` | ✅ UI complete |
| `CoreTheme`, `CoreColors`, shared `Widgets*` | ✅ |
| AR/EN via `app_ar.arb` / `app_en.arb` | ✅ |
| `go_router` + `UtilityRouteGuard` | ✅ |
| `MockupCatalog` + typed models in `lib/data/models/` | ✅ |
| Repository interfaces + mock impls (menu, order, address, profile) | 🔄 partial |
| Supabase, live payments, maps, FCM | ⏳ planned (spec in prdv1 §10–§13) |

### 2.2 Scope for mock-phase work

- **Do:** UI-only behavior, mock data, navigation, Riverpod local state, repository mock providers.
- **Do not:** Add Supabase, REST APIs, persistence, or production payment wiring unless explicitly requested for backend phase.
- **Prefer:** Thin repositories over direct `MockupCatalog` in screens (pattern in `lib/data/repositories/`).

### 2.3 Runtime flags (`lib/core/app_config.dart`)

| Flag | Default | Effect |
|------|---------|--------|
| `demoModeEnabled` | `true` | Demo banner on ops/admin routes; use `UtilityDemoActions` / `WidgetsMockActionButton` |
| `useSteppedCheckoutRoutes` | `false` | `false` = unified `/cart` checkout; `true` = `/checkout` → `/payment` stepped flow |

---

## 3. Cursor MCP servers (mandatory for agents)

> **Agents working in Cursor MUST use installed MCP servers** before guessing, before large codebase searches, and before backend or library integration work. Read each tool’s schema under the MCP descriptors folder before calling. If a tool fails auth, call `mcp_auth` for that server once, then retry.

### 3.1 Core principle

| Do | Don't |
|----|-------|
| Use MCP to **read**, **search**, **verify**, and **apply** changes with evidence | Rely on memory or training data for API shapes, schema, or file paths |
| Batch independent MCP reads in parallel | Skip MCP because a task “seems simple” |
| State in the batch summary **which MCP tools were used** | Claim work is done without running analyze/test when shell MCP is available |

### 3.2 MCP playbook by task type

#### A. Understand product & repo structure

| MCP server | When to use | Key tools |
|------------|-------------|-----------|
| **filesystem** | Map folders, read multiple files, directory trees | `directory_tree`, `read_text_file`, `read_multiple_files`, `search_files` |
| **memory** | Persist decisions across long sessions (architecture, conventions) | `create_entities`, `add_observations`, `search_nodes`, `read_graph` |
| **github** | PRs, issues, CI failures, repo metadata | `search_*`, `list_*`, PR review tools — use `get_me` first |
| **sequential-thinking** | Complex multi-step planning (finance flows, migration order) | Structured reasoning tools |

**Ayletna defaults:** Start with **filesystem** `directory_tree` on `lib/` or target screen folder; cross-check screen list against **`docs/prdv1.md` §7**.

#### B. Flutter / Dart / UI libraries

| MCP server | When to use | Key tools |
|------------|-------------|-----------|
| **context7** | Current docs for Flutter, Riverpod, go_router, google_fonts, Material 3 | `resolve-library-id` → `query-docs` |
| **taste-skill** | UI polish, anti-generic patterns, design-system alignment | Follow server tools for taste checks on customer-facing screens |

**Use context7 for:** Riverpod `AsyncNotifier` patterns, `go_router` `ShellRoute` redirects, `google_fonts` Arabic setup — not for Ayletna business rules (those are in **`prdv1.md`**).

#### C. Backend phase — Supabase

| MCP server | When to use | Key tools |
|------------|-------------|-----------|
| **supabase** | Schema, migrations, RLS, logs, edge functions, client keys | `list_tables`, `list_migrations`, `apply_migration`, `execute_sql`, `get_logs`, `get_advisors`, `get_project_url`, `get_publishable_keys`, `search_docs` |

**Supabase rules (from server instructions):**

1. **`list_tables`** before any schema change.
2. Debug with **`get_logs`** + **`get_advisors`** before altering production data.
3. Prefer **local Supabase CLI + migrations** when shell access exists; use **`apply_migration`** carefully on remote.
4. Align all schema/RPC with **`docs/prdv1.md` §10** (orders, tips, deposits, RLS, immutability).

#### D. Verify UI in browser

| MCP server | When to use | Key tools |
|------------|-------------|-----------|
| **playwright** | Web build smoke tests, drawer nav, cart flow, role routes | `browser_navigate`, `browser_snapshot`, `browser_click`, `browser_take_screenshot` |
| **browsermcp** | Alternative browser automation if Playwright unavailable | `browser_navigate`, `browser_snapshot`, `browser_click` |
| **TestSprite** | Automated test generation / runs when configured | Per TestSprite tool descriptors |

**Manual QA targets:** customer drawer (no bottom nav), unified cart checkout, demo banner on ops routes, RTL Arabic home.

#### E. Design assets

| MCP server | When to use | Key tools |
|------------|-------------|-----------|
| **figma** | Official design files if owner provides Figma links | `get_figma_data`, `download_figma_images` |

Figma is **layout reference only** — colors still come from **`color_list_chat_gpt.txt`**.

#### F. Task breakdown & project management

| MCP server | When to use | Key tools |
|------------|-------------|-----------|
| **task-master-ai** | Split backend sprint from **`docs/prdv1.md`** | `parse_prd` (point input at prdv1), `get_tasks`, `next_task`, `set_task_status` |
| **linear** | Sync engineering tasks if team uses Linear | `save_issue`, `list_issues`, `get_issue` |

For Task Master: copy or symlink `docs/prdv1.md` to `.taskmaster/docs/prd.txt` before `parse_prd`.

#### G. Git operations

| MCP server | When to use |
|------------|-------------|
| **GitKraken** (eamodio.gitlens) | Branch/status when git CLI constraints apply |
| **github** | PR create/review, check runs |

Follow user rules: **do not commit** unless explicitly asked.

#### H. Low relevance for Ayletna Flutter (use only if user asks)

| Server | Notes |
|--------|-------|
| **shadcn**, **magicui** | React/web component registries — not for this Flutter app |
| **email**, **notion** | External productivity — not implementation |
| **cursor-guide** | Cursor product help only |

### 3.3 Required MCP workflow (every batch)

1. **filesystem** — read target screen(s), router, guard, related widgets/models.
2. **memory** — `search_nodes` for prior Ayletna decisions; `add_observations` after non-obvious choices.
3. **context7** — if the batch touches an unfamiliar Flutter/Riverpod/go_router API.
4. **supabase** — if the batch touches schema, auth, RLS, or RPC (backend phase).
5. **playwright** or **browsermcp** — after customer/ops UI changes (when web run is available).
6. **github** — if the batch is for PR review or CI diagnosis.

### 3.4 MCP + shell

When the agent has shell access **and** MCP:

- Run `dart format`, `flutter analyze`, `flutter gen-l10n` via shell (not MCP).
- Use **supabase** MCP for remote project inspection; use **supabase CLI** locally for migration authoring when possible.
- Do not use browser MCP to bypass missing filesystem access — prefer fixing the environment.

### 3.5 Documenting MCP usage (required in batch output)

Include in every handoff:

```text
MCP used: filesystem (read X, tree lib/screens/customer); context7 (go_router redirects); playwright (cart flow screenshot)
MCP not used: supabase (mock phase — no schema changes)
```

---

## 4. Mandatory pre-flight (every batch)

Before editing any screen or route:

1. **MCP filesystem:** `directory_tree` or read target files — do not assume paths.
2. Read the target screen and its route in `lib/core/core_router.dart`.
3. Confirm path in `lib/navigation/app_route_paths.dart`.
4. Confirm role access in `lib/utilities/utility_route_guard.dart`.
5. Read **`docs/prdv1.md`** section for that screen (§7 catalog + §8 domain spec).
6. **MCP memory:** `search_nodes` for prior conventions on this screen/area.
7. Inspect sibling screens in the same `lib/screens/<role>/` folder for patterns.
8. List every button, icon button, card tap, switch, filter, form submit, refresh, and destructive action.
9. Check for inline mock data → move business data to `lib/data/` (catalog or repository).
10. Verify actions match the screen’s PRD purpose — no silent no-ops.
11. **MCP context7** if implementing unfamiliar Flutter/Riverpod/go_router APIs.

---

## 5. Product essentials (from prdv1)

### 5.1 Roles (`AppRole`)

| Role | Key access |
|------|------------|
| `customer` | Order, pay, track, loyalty |
| `guest` | Browse only; sign-in required for checkout/profile/orders |
| `operator` | Full admin + ops |
| `owner` | Reports, audit; limited ops edits |
| `cashier` | POS, tips, deposit refunds |
| `kitchen` | Prep queue, status |
| `delivery` | Deliver, collect deposit, plate returns |
| `inventory` | Stock, adjustments |
| `staff` | Attendance, tip share |

**Registration:** `customer` → active after OTP; ops roles → `pending_approval`; **no** self-registration for `operator` / `owner`. `RoleSelectionScreen` only for multiple approved roles.

### 5.2 Order types & financial isolation

Four order types: **dine-in**, **takeaway**, **delivery**, **plated delivery**.

**Never** mix into food `total_amount`:

- Tips → separate field / `tip_ledger`
- Plate deposits → separate field / temporary liability

Show **food + tip + deposit** as separate lines in checkout, POS, and invoices (`WidgetsOrderInvoiceBlock`, `WidgetsFinancialSummary`).

### 5.3 Canonical constants (JOD)

| Constant | Value |
|----------|-------|
| Owner monthly minimum | 300 JOD |
| Operator fixed salary | 450 JOD (outside 50/50 split) |
| Surplus split | 50% operator / 50% owner after minimum |
| Default plate deposit | 10 JOD |
| Return reminder delay | 60 min |

### 5.4 As-built UX decisions (do not regress)

| Decision | Implementation |
|----------|----------------|
| **Drawer-first navigation** | `WidgetsAppDrawer` — **no bottom navigation bar on any role** |
| **Customer home** | `/home` is primary landing for customer and guest |
| **Guest flow** | `/guest` sets role → `/home`; no separate guest browse screen |
| **Unified cart checkout** | Default: fulfillment + payment + tip + promo on `CustomerCartScreen` |
| **Stepped checkout** | Optional via `useSteppedCheckoutRoutes` |
| **Coupon** | Inline on cart; `/coupon` redirects to `/cart` |
| **Wallet** | Balance in profile/payment flows; no standalone wallet hub in drawer |
| **Shared invoice** | `WidgetsOrderInvoiceBlock` on cashier, confirmation, history, admin detail |
| **Account settings** | `UserPersonalSettingsScreen` at `/account-settings` for all ops roles |
| **Checkout progress** | `WidgetsCheckoutStepStrip`: Basket → Fulfillment → Payment → Review |

---

## 6. Navigation rules

### 6.1 Global patterns

- **Primary nav:** `WidgetsAppDrawer` via `WidgetsScaffoldPage` — not bottom bars.
- **App bar:** Menu icon (drawer) on shell routes; back arrow when `context.canPop()` on deeper stacks.
- **Customer cart:** `WidgetsCartIconButton` in app bar (with badge) — always visible including on `/cart`.
- **Customer shell:** `ShellRoute` + `WidgetsCustomerShell` is passthrough only (no chrome).

### 6.2 Customer drawer destinations

Home · Menu · Cart · Orders · Rewards · Notifications · Profile · Support  
**Guest drawer:** same minus Orders/Profile; includes Sign in.

### 6.3 Checkout routing

**Default (`useSteppedCheckoutRoutes = false`):**

```text
/cart → /order-confirmation → /order-tracking
```

Redirects to cart: `/order-type`, `/dine-in`, `/takeaway`, `/delivery-address`, `/plated-info`, `/checkout`, `/tip`, `/payment`, `/coupon`.

**Stepped mode (`useSteppedCheckoutRoutes = true`):**

```text
/cart → /checkout → /payment → /order-confirmation
```

State: `checkoutDraftProvider`.

### 6.4 Navigation implementation rules

- Every primary CTA navigates to the PRD-expected screen **or** shows explicit front-end feedback.
- No button silently does nothing unless disabled with visible reason.
- `context.pop()` for back within stack; `context.go(...)` for fixed workflow roots.
- Deep links must keep working: `/order/:id`, `/payment/callback`, `/tip/daily/:date`.
- Guest checkout paths → sign-in/register CTA — **no fake payment success snackbar**.

---

## 7. UI/UX implementation

### 7.1 Bootstrap order (if core missing)

1. `lib/utilities/utility_responsive_breakpoints.dart`
2. `lib/core/core_colors.dart` ← `color_list_chat_gpt.txt`
3. `lib/core/core_color_scheme.dart` — `AppRole`, `OrderType`, `buildCoreColorScheme`
4. `lib/core/core_spacing.dart`, `core_typography.dart`, `core_content_sizes.dart`, `core_fonts.dart`
5. `lib/core/core_theme_extensions.dart`, `core_theme.dart`
6. `lib/widgets/widgets_screen_layout.dart`, `widgets_scaffold_page.dart`
7. Wire `main.dart`: `ProviderScope`, `CoreTheme.themeFor`, Arabic default locale

### 7.2 Folder structure (`lib/`)

```text
lib/
├── core/                 # Design tokens, router, app_config
├── data/
│   ├── mockup/           # MockupCatalog (transition)
│   ├── models/           # Model*
│   └── repositories/     # Abstract + mock + repository_providers
├── l10n/
├── navigation/           # AppRoutePaths, checkout redirects
├── providers/            # Riverpod
├── screens/<role>/       # auth, customer, kitchen, delivery, cashier, inventory, staff, admin, shared
├── utilities/
├── widgets/              # Widgets* — flat, no subfolders
└── main.dart
```

### 7.3 Design tokens

Implement from **`color_list_chat_gpt.txt`** only — no raw hex in screens.

| Category | Notes |
|----------|-------|
| Brand | Falafel Gold `#C98A42`, Brown `#4A3325`, Olive `#6E6A35` |
| Order types | dine-in `#00897B`, takeaway `#F9A825`, delivery `#1976D2`, plated `#7B1FA2` — **independent of role theme** |
| Financial semantics | tip `#6E6A35`, deposit `#5D4037`, revenue `#C98A42` |
| Surfaces | Light bg `#F9F6F0`; dark bg `#121212` |

**Order-type display:** always **icon + label + color** — never color alone.

**Opacity:** use `Color.withValues(alpha: …)` or `CoreColors` extensions — **not** `.withOpacity()`.

**Typography:** `CoreTypography` + Noto Sans Arabic via `google_fonts` for Arabic coverage.

### 7.4 Responsive bands (`UtilityResponsiveBreakpoints`)

| Band | Width |
|------|-------|
| Mobile | ≤ 479 |
| Tablet | 480–991 |
| Web | > 991 |

Every screen body wrapped in **`WidgetsScreenLayout`**. Kitchen/cashier: tablet landscape density. Admin: web grid on wide bands.

### 7.5 Naming conventions

| Layer | Pattern | Example |
|-------|---------|---------|
| Core | `core_<name>.dart` → `Core<Name>` | `core_theme.dart` → `CoreTheme` |
| Widgets | `widgets_<name>.dart` → `Widgets<Name>` | `widgets_app_button.dart` → `WidgetsAppButton` |
| Screens | `<role>_<snake>_screen.dart` → `<Role><Name>Screen` | `customer_home_screen.dart` → `CustomerHomeScreen` |
| Utilities | `utility_<name>.dart` | `utility_route_guard.dart` |

**Class name must match filename (PascalCase).** No subfolders under `core/`, `widgets/`, `utilities/`.

Screens with state: **`ConsumerWidget`** or **`ConsumerStatefulWidget`**. Read role/locale from providers — do not hardcode theme.

### 7.6 Unified component system

Use shared widgets before creating screen-local variants:

| Component | File | Use |
|-----------|------|-----|
| Page shell | `widgets_scaffold_page.dart` | AppBar + drawer + demo banner + layout |
| Drawer | `widgets_app_drawer.dart` | Role-aware nav |
| Layout | `widgets_screen_layout.dart` | Max-width + padding |
| Button | `widgets_app_button.dart` | All CTAs |
| Icon button | `widgets_icon_button.dart` | App bar actions |
| Card | `widgets_app_card.dart` | Default content shell |
| Metric / choice / list | `widgets_metric_card.dart`, `widgets_choice_card.dart`, `widgets_list_item.dart` | Compose inside cards |
| Finance | `widgets_amount_line.dart`, `widgets_financial_summary.dart`, `widgets_order_invoice_block.dart` | Checkout, POS, reports |
| Checkout strip | `widgets_checkout_step_strip.dart` | Cart progress |
| Status | `widgets_status_pill.dart`, `widgets_ops_glance_chip.dart` | Ops glanceability |
| Feedback | `widgets_info_banner.dart`, `widgets_error_message.dart` | Info vs financial errors |
| Refresh | `widgets_refresh_list.dart` | All scrollable lists |
| Demo | `widgets_demo_mode_banner.dart`, `widgets_mock_action_button.dart` | Ops prototype safety |
| Food UI | `widgets_food_card.dart`, `widgets_food_media_panel.dart`, `widgets_food_hero.dart` | Storefront |
| Loading | `widgets_home_loading_skeleton.dart`, `widgets_loading_indicator.dart` | Skeleton states |

**Do not** create per-screen card/button/chip styles. **Do not** use deleted `WidgetsBottomNavigation` — navigation is drawer-based.

### 7.7 Card / button unification

- Default shell: **`WidgetsAppCard`** — compose with list items, pills, metrics inside.
- All buttons: **`WidgetsAppButton`** or global theme — no local `FilledButton.styleFrom` in screens.
- Icon actions: **`WidgetsIconButton`**.

### 7.8 RTL & localization

- Default locale: **Arabic (`ar`)**, RTL.
- Use `PaddingDirectional`, `start`/`end` — not hardcoded left/right.
- All user-visible strings in **ARB** — `AppLocalizations`.
- Currency: **`UtilityFormatJod`** + `l10n.currencyJod`.

### 7.9 Per-screen UI workflow

1. Read **`docs/prdv1.md`** §7–§8 for screen behavior and route.
2. Inspect existing screen in `lib/screens/<role>/`.
3. Reuse `Widgets*` from §7.6.
4. Implement with `CoreTheme`, `CoreSpacing`, `CoreTypography`, ARB strings.
5. If a pattern repeats twice → extract to `lib/widgets/`.
6. Run UI acceptance checklist (§10).

### 7.10 Branding

- Product name: **Ayletna Restaurant** / **مطعم عيلتنا**.
- Logo: `assets/images/logo_falafel.png` via `WidgetsLogoIcon`.
- Splash: cream `#F9F6F0`, falafel logo, gold loader — not purple “culinary logic” theme.
- No legacy prototype names, colors, or taglines.

### 7.11 PRD screen → file mapping (reference)

Full catalog: **`docs/prdv1.md` §7**. Examples:

| PRD name | File | Class |
|----------|------|-------|
| `HomeScreen` | `customer_home_screen.dart` | `CustomerHomeScreen` |
| `CartScreen` | `customer_cart_screen.dart` | `CustomerCartScreen` |
| `SearchScreen` | `customer_search_screen.dart` | `CustomerSearchScreen` |
| `CashierOrderScreen` | `cashier_order_screen.dart` | `CashierOrderScreen` |
| `KitchenDashboardScreen` | `kitchen_dashboard_screen.dart` | `KitchenDashboardScreen` |
| `AdminDashboardScreen` | `admin_dashboard_screen.dart` | `AdminDashboardScreen` |
| `UserPersonalSettingsScreen` | `user_personal_settings_screen.dart` | `UserPersonalSettingsScreen` |

**Removed / merged:** `GuestBrowseScreen` → guest uses `CustomerHomeScreen`. Standalone coupon/wallet hubs merged into cart/profile.

---

## 8. Mock logic implementation

### 8.1 Mock data rules

- Business mock data lives in **`lib/data/`** — prefer `MockupCatalog` or typed **`Model*`** classes.
- Migrate screens to **`repository_providers.dart`** where interfaces exist (menu, order, address, profile).
- Localized labels stay in **ARB**, not in mock data.
- Screens may keep visual-only constants (chart ratios, painter coords, animation values).
- Move to data layer: users, orders, payments, inventory, plates, addresses, rewards, notifications, ops logs.

### 8.2 Action behavior matrix

For each interactive control, pick **one**:

| Behavior | When |
|----------|------|
| Navigate | Primary flow CTAs |
| `UtilityMockFeedback.showInfo/Success/confirm` | Customer save/apply/refresh (non-financial) |
| `UtilityDemoActions` + `WidgetsMockActionButton` | Ops/admin when `demoModeEnabled` — **no fake financial success** |
| Confirmation dialog | Delete, void, refund, breakage, irreversible |
| Bottom sheet / dialog | Filters, export, previews |
| Riverpod toggle | Switches, filters, qty, selected chips, workflow steps |
| Disabled + explanation | Unavailable actions |

### 8.3 Financial & destructive actions

- **Financial errors:** `WidgetsErrorMessage` / red `SelectableText.rich` — not snackbar-only.
- **Destructive:** always confirm via `UtilityMockFeedback.confirm` or equivalent dialog.
- **Ops demo:** banner + info feedback; disable or label mock actions clearly.
- **Guest:** block checkout with sign-in CTA; route to `/login` or `/register`.

### 8.4 Refresh & async lists

- Use **`WidgetsRefreshList`** on scrollable screens.
- `onRefresh`: invalidate relevant `FutureProvider` (e.g. `customerOrderHistoryProvider`) or show mock feedback on legacy screens.
- Loading: `CircularProgressIndicator` or domain skeleton (e.g. `WidgetsHomeLoadingSkeleton`).
- Errors: inline `SelectableText.rich` or `WidgetsErrorMessage`.

### 8.5 Tabs & workflow steps

- In-screen tabs OK when they reduce duplication **without** breaking PRD routes (e.g. cashier POS ticket tabs).
- Do not delete PRD screens; merge only when routes stay clear and documented in prdv1.
- Customer checkout steps: prefer unified cart + `WidgetsCheckoutStepStrip` unless stepped flag enabled.

### 8.6 Do not merge / delete without PRD update

Keep separate routes/files unless **`prdv1.md`** explicitly documents merge:

- Admin detail vs management screens
- Report filter vs reports hub
- Plate editor vs plates management
- Stepped checkout screens (behind flag)

---

## 9. State management (Riverpod)

### 9.1 Conventions

- `FutureProvider` / `StateNotifierProvider` for mock phase; `@riverpod` codegen for new production notifiers.
- `AsyncValue.when` for repository-fed screens.
- `ref.invalidate(provider)` after mock refresh writes.
- Key providers: `appRoleProvider`, `sessionProvider`, `cartProvider`, `checkoutDraftProvider`, `menuCategoriesProvider`, `menuItemsProvider`, `userProfileProvider`, repository providers in `repository_providers.dart`.

### 9.2 UI-only rule

No Supabase or HTTP calls inside widgets. Screens watch providers; providers call repositories.

---

## 10. Acceptance checklist (verify before merge)

### 10.1 Product & navigation

- [ ] Matches **`docs/prdv1.md`** screen purpose and route
- [ ] Route registered in `core_router.dart` and `app_route_paths.dart`
- [ ] Role guard correct in `utility_route_guard.dart`
- [ ] Drawer destinations role-appropriate; **no bottom nav bar added**
- [ ] Guest blocked from authenticated-only flows with clear CTA
- [ ] Deep links still work

### 10.2 UI & theme

- [ ] No `Color(0xFF…)` in `lib/screens/`
- [ ] No `.withOpacity()` in widgets
- [ ] `WidgetsScreenLayout` on screen body
- [ ] Order-type colors ≠ role primary on kitchen/cashier cards
- [ ] Tip / deposit / food revenue visually separated in money views
- [ ] Icon + label + color on order-type chips
- [ ] Arabic default RTL; money in JOD via l10n
- [ ] Ayletna branding only — no legacy prototype names

### 10.3 Mock logic

- [ ] No empty `onPressed: () {}` on primary actions
- [ ] Business data not duplicated inline in screen — in `lib/data/`
- [ ] Destructive/financial actions confirmed or use demo-safe pattern
- [ ] Ops routes respect `demoModeEnabled` banner behavior
- [ ] Financial errors use `WidgetsErrorMessage`, not snackbar-only

### 10.4 Code quality

- [ ] Filename ↔ class name match
- [ ] `dart format` on edited files
- [ ] `flutter analyze` clean on edited paths
- [ ] `flutter gen-l10n` if ARB changed

### 10.5 MCP & verification

- [ ] Target files read via **filesystem** MCP (or equivalent) before edit
- [ ] Relevant prior decisions checked in **memory** MCP
- [ ] **context7** used for any non-trivial Flutter/Riverpod/go_router API
- [ ] **playwright** / **browsermcp** smoke test after significant customer/ops UI change (when web run available)
- [ ] Batch summary lists MCP tools used (§11)

---

## 11. Output requirements (per batch)

Deliver a short summary containing:

1. **Screens changed** (paths)
2. **Routes verified** (added/redirect/guard)
3. **Actions completed** (button → behavior mapping)
4. **Mock data** moved/created (`lib/data/…`)
5. **Widgets** extracted or reused
6. **prdv1.md updates** if product behavior changed
7. **MCP tools used** (see §3.5) — which servers, which operations, what was skipped and why
8. **Commands run:** `dart format`, `flutter analyze`, `flutter gen-l10n` (if needed)

---

## 12. AI / developer handoff format

When analyzing a task, provide:

1. **Reusable components** — paths + class names (existing first)
2. **MCP plan** — which servers to call before coding (filesystem, context7, supabase, playwright, etc.)
3. **Open questions** — prdv1 / design / responsive ambiguities
4. **Options** — ≥2 choices with pros/cons + recommendation
5. **Implementation plan** — files to create/edit, providers, routes
6. **Confirmations:**
   - Aligns with `docs/prdv1.md` + naming rules
   - Styling via core/theme APIs only
   - Drawer navigation; no bottom bar
   - Order-type colors distinct from role theme
   - RTL / l10n / JOD considered
   - Mock vs demo-safe ops behavior correct
   - MCP used where applicable (§3)

---

## 13. Strict rules (never / always)

**Never:**

- Hardcode colors, spacing, typography, or breakpoints in screens
- Add Supabase/API in mock-phase tasks unless explicitly in backend sprint
- Use bottom navigation bars for role navigation
- Show fake payment/order success to guests
- Self-assign `operator` / `owner` at registration
- Duplicate widgets without checking `lib/widgets/` first — use **filesystem** MCP to search
- Reference retired external prototype assets or Stitch HTML as source of truth
- Guess library APIs when **context7** is available
- Apply Supabase migrations without **list_tables** / **get_advisors** review

**Always:**

- Read **`docs/prdv1.md`** + **`color_list_chat_gpt.txt`** before implementing
- **Use Cursor MCP servers proactively** (§3) — filesystem, memory, context7 at minimum
- Use `ConsumerWidget` when reading providers
- Support light + dark via `CoreTheme.themeFor(AppRole, brightness, width:)`
- Wrap lists in `WidgetsRefreshList`
- Prefer private widget classes over large `_buildX()` methods
- Keep food / tip / deposit as separate financial lines in UI
- Document MCP usage in batch output (§11)

---

## 14. prdv1.md quick index

| Topic | prdv1 section |
|-------|---------------|
| As-built status & flags | §3 |
| Roles & registration | §4 |
| User journeys | §5 |
| Navigation & drawer | §6 |
| Full screen catalog (75+) | §7 |
| Feature specs (customer, cashier, admin…) | §8 |
| Data models & profit formulas | §9 |
| Supabase schema, RLS, RPC | §10 |
| Flutter architecture & repos | §11 |
| Riverpod providers | §12 |
| Payment gateway & wallet | §13 |
| Design system summary | §14 |
| NFRs | §15 |
| Acceptance criteria | §16 |
| Roadmap & DoD | §19 |

---

## 15. Document history

| Version | Date | Summary |
|---------|------|---------|
| **1.1.0** | 2026-06-19 | Added §3 Cursor MCP servers — mandatory agent tooling playbook (filesystem, memory, context7, supabase, playwright, github, task-master, etc.) |
| **1.0.0** | 2026-06-19 | Unified prompt from `prdv1.md` + `mockup_logic_prompt.md` + `ui_design_prompt.txt`; drawer-first nav; demo mode; repository layer; unified cart checkout |

---

**End of prompt — Ayletna Implementation Master Prompt v1.1.0**

*Product authority: `docs/prdv1.md`. Hex authority: `color_list_chat_gpt.txt`. Implementation authority: this file. Tooling authority: Cursor MCP servers (§3).*
