# Screen Audit Master Prompt (Navigation + Action Cycles)

**Purpose:** Reusable Cursor prompt to audit **any screen scope** in the Ayletna Flutter app — same workflow as the customer audits (Chat 1 + Chat 2).

**Replace `ttffgg`** with your target scope (see §2).  
**Reference outputs (customer, done):**  
- `docs/customernavigationmapchecklist.md`  
- `docs/customeractioncycles.md`

**Authority:** `docs/prdv1.md` · `docs/promptv1.md` §3 (MCP) · `lib/navigation/app_route_paths.dart`

---

## 1. Quick copy-paste prompt (send this to Cursor)

```markdown
Audit all **ttffgg** screens in the Ayletna Restaurant app. Do this in two phases and use MCP + agents for everything.

## Phase A — Navigation map checklist
Study every screen in scope: app bar, drawer, buttons, cards, chips, toggles, sheets, dialogs.
For each control document: label → action (route, state change, dialog, external URI, mock feedback).

Deliver: `docs/ttffggnavigationmapchecklist.md`
Format like `docs/customernavigationmapchecklist.md` (legend, global nav, per-screen tables, flow diagram, QA checklist).

## Phase B — Action cycles (success / error / null / loading)
For every action from Phase A, classify outcomes:
- SUCCESS — goal achieved (nav + state + feedback)
- ERROR — validation/server failure + recovery
- NULL/EMPTY — missing input, empty lists, guest/disabled
- LOADING — async in progress
- MOCK — demo-only until backend

Deliver: `docs/ttffggactioncycles.md`
Format like `docs/customeractioncycles.md` (matrix, gaps, backend roadmap with target APIs).

## Phase C — Close empty cycles (implement)
If any action has NO outcome (silent no-op, pop-only sheet, toast-only with no state change):
- Fix in code using existing patterns (`Repository*`, Riverpod providers, `WidgetsAsyncStateCard`, `UtilityMockFeedback.showError`)
- Add widgets/screens only when necessary; match project conventions
- Run `flutter analyze lib/`

## MCP (mandatory — read tool schemas first)
- **filesystem:** `directory_tree`, `read_multiple_files`, `grep`/search on `lib/screens/ttffgg/`
- **memory:** store audit completion + scope metadata
- **context7:** only if unsure about Flutter/Riverpod/go_router API
- Launch **explore** subagent for parallel screen audit when scope > 10 files

## Scope resolution
Resolve "ttffgg" using §2 below. Include shared widgets used only by this scope (drawer, shells, sheets).

## Rules
- Do not commit unless asked
- Minimize diff; close cycles don't refactor unrelated code
- Guest = subset of customer routes + `AppRole.guest` drawer differences
- State which MCP tools and agents were used in the summary
```

---

## 2. Scope token `ttffgg` — pick one or define custom

Replace **`ttffgg`** in filenames and the prompt with the **slug** in the table (e.g. `admin` → `adminnavigationmapchecklist.md`).

| You say | Slug | Screen folder(s) | Route prefix / notes |
|---------|------|------------------|----------------------|
| **customer screens** | `customer` | `lib/screens/customer/` (30 files) | `/home`, `/cart`, `/profile`, … — see `AppRoutePaths` |
| **guest screens** | `guest` | Same customer UI; audit **guest-specific** behavior | `AppRole.guest` drawer, `/guest`, `/login` gates, no Orders/Profile in drawer |
| **auth screens** | `auth` | `lib/screens/auth/` | `/login`, `/otp`, `/register`, … |
| **admin screens** | `admin` | `lib/screens/admin/` (18 files) | `/admin*` — `operator`, `owner` roles |
| **cashier screens** | `cashier` | `lib/screens/cashier/` | `/cashier*` |
| **kitchen screens** | `kitchen` | `lib/screens/kitchen/` | `/kitchen*` |
| **delivery screens** | `delivery` | `lib/screens/delivery/` | `/delivery*` |
| **inventory screens** | `inventory` | `lib/screens/inventory/` | `/inventory*` |
| **staff screens** | `staff` | `lib/screens/staff/` | `/staff*` |
| **shared screens** | `shared` | `lib/screens/shared/` | e.g. `/account-settings` |
| **all ops** | `operations` | cashier + kitchen + delivery + inventory + staff | Demo banner routes |
| **entire app** | `app` | all `lib/screens/**` | Full 75-screen audit (multi-session) |

### Custom scope examples

```text
ttffgg = "admin screens"           → slug: admin
ttffgg = "guest screens"            → slug: guest (customer files + role guards)
ttffgg = "cashier and kitchen"       → slug: cashier-kitchen (merge folders)
ttffgg = "auth + customer checkout"  → slug: auth-checkout (explicit file list in prompt)
```

**Custom scope rule:** If not in the table, agent MUST:
1. `directory_tree` on `lib/screens/`
2. List exact `.dart` files in the deliverable header
3. Cross-check against `docs/prdv1.md` §7 screen catalog

---

## 3. Phase A — Navigation checklist spec

### 3.1 Discovery (MCP)

```text
1. filesystem.directory_tree → lib/screens/{scope}/
2. read_multiple_files → all screen files in scope (batch)
3. grep: onPressed|onTap|context.go|context.push|AppRoutePaths|UtilityMockFeedback|showDialog|showModalBottomSheet
4. Read shared: widgets_app_drawer.dart, widgets_scaffold_page.dart, scope-specific sheets
5. Read: lib/navigation/app_route_paths.dart, lib/core/core_router.dart, utility_route_guard.dart
```

### 3.2 Document structure (`docs/{slug}navigationmapchecklist.md`)

```markdown
# {Scope Title} Navigation Map Checklist
> Version · date · source paths

## Legend
✅ route · 🔄 state · 📋 modal · 🧪 mock · 👤 role-specific · ⚙️ AppConfig

## Global navigation (scope-specific)
- Drawer / app bar / back / shared actions

## Config flags affecting navigation

## Screen-by-screen (one section per screen)
### N. Screen Name — `/route`
**File:** `...`
#### App bar | Buttons | Cards | Chips | Sheets
| Control | Action |

## Cross-screen flow summary (mermaid or ascii)
## QA verification checklist
## Production hardening notes
```

### 3.3 Per-control requirements

Every row MUST answer:
- **Control** — visible label / icon / widget name
- **Action** — `/route`, provider mutation, dialog, sheet, `tel:`, or mock snackbar
- **Role** — if guest vs customer vs operator differs

---

## 4. Phase B — Action cycles spec

### 4.1 Discovery (MCP + agent)

Launch **`explore`** subagent (readonly) with prompt:

```text
Audit lib/screens/{scope}/ for incomplete action cycles.
For each action: SUCCESS, ERROR, NULL/EMPTY, LOADING, MOCK-ONLY.
Classify gaps: EMPTY | MOCK | MISSING_ERROR | MISSING_EMPTY | MISSING_LOADING | COMPLETE.
Check lib/providers/ and lib/data/repositories/ for existing patterns.
Return structured report by screen.
```

Parent agent merges agent report with direct grep/read evidence.

### 4.2 Document structure (`docs/{slug}actioncycles.md`)

```markdown
# {Scope Title} Action Cycles
> Companion: {slug}navigationmapchecklist.md

## Cycle legend
## Infrastructure (repos/providers/widgets used or needed)
## P0 / P1 / P2 — grouped by business priority
### Action name
| Outcome | Behavior |
| Backend | Target API |

## Screen quick matrix (Closed locally? / Notes)
## Remaining MOCK cycles → backend roadmap
## QA verification checklist
```

### 4.3 Gap classification

| Gap | Meaning | Typical fix |
|-----|---------|-------------|
| **EMPTY** | Tap does nothing / silent no-op | Validation feedback or disabled state |
| **MOCK** | Snackbar only, no state change | Repository method + provider |
| **MISSING_ERROR** | No error UI on async fail | `WidgetsAsyncStateCard.error` + retry |
| **MISSING_EMPTY** | Empty list with no CTA | `WidgetsAsyncStateCard.empty` |
| **MISSING_LOADING** | Async with no spinner | Disable button + `CircularProgressIndicator` |
| **COMPLETE** | Closed cycle locally | Document only; note backend swap point |

---

## 5. Phase C — Implementation rules

Only implement when Phase B finds **non-closed** cycles.

### 5.1 Preferred patterns (already in codebase)

| Pattern | Location |
|---------|----------|
| Repository interface + mock | `lib/data/repositories/repository_*.dart` |
| Riverpod providers | `lib/providers/`, `repository_providers.dart` |
| Order placement | `order_placement_providers.dart`, `placeOrderProvider` |
| Address CRUD | `repository_address_mock.dart` |
| Empty/error UI | `widgets_async_state_card.dart` |
| Feedback | `utility_mock_feedback.dart` (success/info/warning/error/confirm) |
| Cart mutations | `cart_providers.dart` |
| Checkout draft | `checkout_draft_providers.dart` |

### 5.2 Implementation checklist

- [ ] Extend repository interface (not screen → MockupCatalog directly)
- [ ] Add/adjust provider; invalidate on success
- [ ] Wire screen: loading disables control, error shows recovery, empty shows CTA
- [ ] Guest/role guards where applicable (`appRoleProvider`, `UtilityRouteGuard`)
- [ ] `flutter analyze lib/` clean
- [ ] Update both markdown deliverables with "CLOSED locally" notes

### 5.3 Do NOT

- Add Supabase/REST unless user explicitly requests backend phase
- Create commits unless asked
- Over-engineer helpers for one-off cases
- Duplicate customer audit docs when scope is guest (extend guest section or separate `guest*` files)

---

## 6. MCP + agent playbook (this task type)

| Step | Tool | Action |
|------|------|--------|
| 1 | filesystem `directory_tree` | List scope screen files |
| 2 | filesystem `read_multiple_files` | Batch-read screens + drawer/scaffold |
| 3 | grep / codebase search | `onPressed`, `onTap`, routes, mock feedback |
| 4 | Task `explore` subagent | Parallel gap audit (scope ≥ 8 screens) |
| 5 | memory `create_entities` | Record deliverable paths + completion date |
| 6 | filesystem `write_file` | Write both markdown deliverables |
| 7 | shell | `flutter analyze lib/` after code changes |
| 8 | playwright (optional) | Smoke-test critical flows on web build |

**Summary rule:** Final response MUST list MCP tools used and whether explore agent was launched.

---

## 7. Output file naming

| Scope slug | Navigation checklist | Action cycles |
|------------|---------------------|---------------|
| `customer` | `customernavigationmapchecklist.md` | `customeractioncycles.md` |
| `admin` | `adminnavigationmapchecklist.md` | `adminactioncycles.md` |
| `guest` | `guestnavigationmapchecklist.md` | `guestactioncycles.md` |
| `cashier` | `cashiernavigationmapchecklist.md` | `cashieractioncycles.md` |
| `{custom}` | `{custom}navigationmapchecklist.md` | `{custom}actioncycles.md` |

All files live in **`docs/`**.

---

## 8. Example prompts (ready to send)

### 8.1 Admin screens

```text
Run the Screen Audit Master Prompt (docs/prompt_screen_audit_ttffgg.md) for ttffgg = admin screens.
Phases A + B + C. Deliver adminnavigationmapchecklist.md and adminactioncycles.md.
Use MCP filesystem + explore agent. Fix any empty admin action cycles you find.
```

### 8.2 Guest screens

```text
Run the Screen Audit Master Prompt for ttffgg = guest screens.
Guest uses customer UI with AppRole.guest — document drawer differences, login gates, checkout blocks.
Deliver guestnavigationmapchecklist.md and guestactioncycles.md.
Do not duplicate full customer doc; focus on guest deltas + shared controls guest touches.
```

### 8.3 Kitchen + delivery only

```text
Run the Screen Audit Master Prompt for ttffgg = kitchen and delivery screens.
Slug: kitchen-delivery. Merge both folders into one checklist + action cycles doc pair.
```

### 8.4 Documentation only (no code)

```text
Run Phases A + B only (no Phase C) for ttffgg = inventory screens.
I will review docs before you implement fixes.
```

---

## 9. Acceptance criteria (you review)

**Phase A done when:**
- Every screen in scope has a section
- Every button/card/chip/toggle has a destination or stated mock action
- Global nav (drawer, app bar) documented
- QA checklist at bottom

**Phase B done when:**
- Every Phase A action has SUCCESS/ERROR/NULL/LOADING/MOCK row
- Backend roadmap lists target APIs for each MOCK item
- Priority tiers (P0/P1/…) assigned

**Phase C done when:**
- No action classified as EMPTY without justification
- `flutter analyze lib/` passes
- Docs updated to mark closed cycles

---

## 10. Relation to other docs

| Doc | Relationship |
|-----|--------------|
| `docs/prdv1.md` | Screen catalog, roles, routes — source of truth for scope |
| `docs/promptv1.md` | General implementation + MCP §3 |
| `docs/customernavigationmapchecklist.md` | **Template** for Phase A (customer done) |
| `docs/customeractioncycles.md` | **Template** for Phase B (customer done) |
| `docs/UI_UX_REDESIGN_CHECKLIST.md` | Optional cross-link after audit |

---

*Prompt version 1.0.0 · 2026-06-19 · Derived from customer navigation + action-cycle audit sessions.*
