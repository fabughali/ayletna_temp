# Ayletna Restaurant — Development Rules

| Field | Value |
|-------|-------|
| **Version** | 2.0.0 |
| **Updated** | 2026-08-01 |
| **Scope** | How to implement Flutter UI + in-memory mock logic for Ayletna |
| **Product authority** | `docs/prdv1.md` wins on product behavior conflicts |

This file is self-contained for implementation. Hex values are included here so day-to-day coding does not require opening other docs.

---

## 1. Document hierarchy (conflict resolution)

| Priority | Source | Authority |
|----------|--------|-----------|
| **1** | `docs/prdv1.md` | **What** to build: screens, flows, roles, finance, acceptance |
| **2** | Hex tokens in this file §4 · `color_list_chat_gpt.txt` · `lib/core/core_colors.dart` | **All colors** — never invent hex in screens |
| **3** | This file (`docs/development_rules.md`) | **How** to implement UI + mock logic |
| **4** | `docs/user_roles_permissions_matrix.md` | RBAC capability keys and hub matrices |
| **5** | `.cursor/rules/stitch-redesign.mdc` | Visual refresh ≤25% when matching Stitch |
| **6** | Cursor MCP servers | Investigation / verification only — never overrides 1–5 |

**Conflict rules:**
- Product behavior conflict → follow `docs/prdv1.md` and update this file if needed.
- Screen colors conflict → follow hex tokens / `CoreColors`.
- Stitch mockup conflicts with PRD chrome (auth: no app bar/drawer) → follow PRD.
- Figma / Stitch is layout reference only; tokens still come from §4.

---

## 2. Product & business rules

### 2.1 Canonical financial constants (JOD)

| Constant | Value | Notes |
|----------|-------|-------|
| Currency | **JOD** | All monetary fields |
| Owner monthly minimum | **300 JOD** | Before 50/50 surplus split |
| Operator fixed salary | **450 JOD** | Monthly, outside variable split |
| Surplus split | **50% operator / 50% owner** | After minimum and capital repayment |
| Default plate deposit | **10 JOD** | Operator-configurable |
| Plated return reminder | **60 minutes** | Configurable 30–60 min |

### 2.2 Money flow

```
[Total cash/electronic collected]
├── Food sales revenue          → profit calculation
├── Tips                        → tip_ledger (isolated)
└── Plate deposits              → temporary liability (not profit)
```

**Cardinal rule:** Never add tip or deposit into order `total_amount`. Show food + tip + deposit as separate lines in checkout, POS, and invoices.

### 2.3 Order types & statuses

Four order types: **dine-in**, **takeaway**, **delivery**, **plated delivery**.

```dart
enum OrderType { dineIn, takeaway, delivery, platedDelivery }
enum OrderStatus { newOrder, preparing, ready, onTheWay, delivered, completed, cancelled }
enum DepositStatus { pending, collected, refunded, partiallyRefunded, deducted }
```

### 2.4 Monthly profit formula

```
computed_revenue = SUM(orders.total_amount) WHERE status IN (delivered, completed)
net_before_split = computed_revenue - operating_expenses - capital_repayment

IF net_before_split < 300 JOD (owner minimum):
    owner_variable = net_before_split
    operator_variable = 0
ELSE:
    owner_variable = 300 + 50% × (net_before_split - 300)
    operator_variable = 50% × (net_before_split - 300)

operator_fixed_salary = 450 JOD (separate line item, not in 50/50 pool)
```

### 2.5 Tip distribution

```
employee_share = (employee_hours / sum_present_hours) × daily_tip_total
```

### 2.6 Plate deposit refund

```
refund_to_customer = deposit_collected - SUM(quantity × replacement_cost)
restaurant_recovery = deducted amount (asset, not revenue)
```

### 2.7 Roles & registration

| Role | Registration behavior |
|------|----------------------|
| `customer` | Active after OTP |
| `guest` | No registration; browse only |
| `cashier`, `kitchen`, `delivery`, `inventory`, `staff` | `pending_approval` until operator/app admin approves |
| `operator`, `owner` | Demo self-reg UI exists; production: created by app admin only |
| `admin`, `support`, `marketing` | **No self-registration** — assigned by app admin only |

### 2.8 Immutability

1. `tip_ledger.status = distributed` → block amount edits.
2. Tip distributions → no update after acknowledge except operator override + audit.
3. Completed orders → no edit to totals without operator cancel flow + audit.

### 2.9 Feature flags (`lib/core/app_config.dart`)

| Flag | Default | Purpose |
|------|---------|---------|
| `demoModeEnabled` | `false` | Demo banner + non-destructive ops when true |
| `useSteppedCheckoutRoutes` | `true` | `/cart` → `/checkout` → `/payment` |

---

## 3. Architecture (as-built)

```
Screens (~103) → Providers (Riverpod, in-memory) → Repository interfaces
                                                    ↓
                                         Mock implementations (today)
                                         Supabase implementations (planned)
```

- **Zero** network API clients wired (no supabase/http/dio/firebase in app code paths).
- Switch point: `lib/data/repositories/repository_providers.dart` (~20 lines) + new `*Supabase` classes.
- Screens never call HTTP. Providers call repositories only.
- State is lost on restart (mock phase).

### Cycle PASS bar

An interactive action **PASS**es only if it mutates shared state another screen or role can see. Snackbar alone = **FAIL**. Honest copy only (no “published externally” if only in-app mock).

Verified smoke: `flutter test test/frontend_cycle_smoke_test.dart` (S1–S5).

| ID | Intent |
|----|--------|
| S1 | Cart placeOrder clears cart; sets placed + tracking ids |
| S2 | Offer inactive hidden from `visibleOffersProvider`; active visible |
| S3 | Blog publish + push schedule reach customer surfaces |
| S4 | Support accept shrinks queue; creates/links ticket thread |
| S5 | Cashier ticket appears on `kitchenBoardProvider` |

---

## 4. Design tokens & visual rules

### 4.1 Brand colors

| Token | Hex | Usage |
|-------|-----|-------|
| Falafel Gold (primary) | `#C98A42` | CTAs, brand accents, revenue highlights |
| Deep Brown (on-primary) | `#4A3325` | Text on gold buttons |
| Olive Green (secondary) | `#6E6A35` | Tips, loyalty, secondary actions |
| Warm Orange (accent) | `#D88A52` | Promos, warmth |
| Cream (background light) | `#F9F6F0` | App background |
| Dark surface | `#121212` | Dark mode background |
| White (surface) | `#FFFFFF` | Cards, sheets |
| Espresso (text primary) | `#2B211A` | Headlines, body |
| Taupe (text secondary) | `#6D5C4D` | Captions, metadata |
| Error | `#C62828` | Errors, destructive |
| Success | `#27AE60` | Success states |

**One brand primary for all roles** (falafel gold). Role hubs may tint drawer/app bar only — they do not get separate UI kits or rainbow primaries.

### 4.2 Order-type colors (independent of role chrome)

| Type | Hex |
|------|-----|
| Dine-in | `#00897B` |
| Takeaway | `#F9A825` |
| Delivery | `#1976D2` |
| Plated delivery | `#7B1FA2` (**PRD-locked**) |

Chips must show **icon + label + color** — never color alone.

### 4.3 Financial semantic colors

| Line | Color | Rule |
|------|-------|------|
| Food revenue | Gold `#C98A42` | Profit-eligible |
| Tips | Olive `#6E6A35` | Isolated from revenue |
| Deposits | Brown `#5D4037` | Temporary liability |

### 4.4 Hub identity accents (drawer / app bar tint only)

| Hub | Accent |
|-----|--------|
| App Admin | `#37474F` |
| Operator | `#2C3E50` |
| Owner | `#6A4E23` |
| Support | `#1565C0` |
| Marketing | `#8E24AA` |

### 4.5 Typography & layout

- Arabic: Noto Sans Arabic · English: system / Noto Sans · Currency: JOD via `UtilityFormatJod` + l10n
- 8px grid; mobile margins 16px
- Responsive bands: Mobile ≤479 · Tablet 480–991 · Web >991
- Kitchen/cashier: tablet landscape density · Admin: web grid on wide bands

### 4.6 UtilitySizer (mandatory sizing)

| Constant | Value |
|----------|-------|
| Design width | **390** |
| Min scale | **0.70** |
| Max scale | **1.18** |

- All spacing / radii / content sizes go through `UtilitySizer` / `CoreSpacing` / `CoreContentSizes` / `CoreTypography`.
- **Never** literal `fontSize: n`, bare `SizedBox(height: n)`, raw `EdgeInsets` px, or `Icon(size: n)` in screens/widgets outside core.
- **Never** `Color(0x…)` outside `lib/core/`.
- **Never** `.withOpacity()` — use `Color.withValues(alpha: …)`.

### 4.7 Anti-patterns (NEVER)

- Bottom navigation bar
- Purple/neon AI gradient aesthetic
- Pure black `#000000` backgrounds
- Fake payment success for guests
- Mixing tips/deposits into revenue totals
- Invented ratings (no hash/`4.8` fakes)
- English-only UI strings (ARB EN+AR)
- Per-role parallel design systems

---

## 5. Navigation & routing

### 5.1 Global

- Primary nav: `WidgetsAppDrawer` via `WidgetsScaffoldPage` — **no bottom nav**
- App bar: menu on drawer primary routes; back when `context.canPop()` on deeper stacks
- Customer/guest: scaffold auto-injects `WidgetsCartIconButton` (badge) including on `/cart`
- Pre-auth (splash/login/register/OTP/language/pending): `showAppBar: false`, `showDrawer: false` — no avatar
- Customer shell: passthrough only (no chrome)

### 5.2 Customer drawer

Home · Menu · Cart · Orders · Rewards · Notifications · Profile · Support · Blog (published)  
Guest: same minus Orders/Profile; includes Sign in. Pin Home / Cart / Orders / Offers; group the rest.

### 5.3 Checkout

**Default (`useSteppedCheckoutRoutes = true`):**
```
/cart → /checkout → /payment → /order-confirmation → /order-tracking
```
State: `checkoutDraftProvider`. Strip: Basket → Fulfillment → Payment → Review.

**Unified (`false`):** `/cart` → confirmation → tracking. Redirects to cart: `/order-type`, `/dine-in`, `/takeaway`, `/delivery-address`, `/plated-info`, `/checkout`, `/tip`, `/payment`, `/coupon`.

- Delivery place-order requires `selectedAddressId`; takeaway/dine-in do not.
- Guest checkout → sign-in CTA — **no fake success**.

### 5.4 Route protection (summary)

| Prefix | Allowed |
|--------|---------|
| `/app-admin` | `admin` approved |
| `/operator` | `operator` approved |
| `/owner` | `owner` approved |
| `/support-desk` | `support` approved |
| `/marketing` | `marketing` approved |
| `/admin*` | redirect-only → hub |
| `/kitchen*` | kitchen, operator |
| `/cashier*` | cashier, operator |
| `/delivery*` | delivery, operator |
| `/inventory*` | inventory, operator |
| `/staff-*` | staff + ops roles |
| Customer paths | customer, guest (subset) |
| `/support`, `/support-chat`, `/faq` | all including guest / pending |
| `/notifications` | all roles (ops see shift inbox branch) |
| `/role-selection` | users with 2+ approved roles |

### 5.5 Hub homes

| Role | Hub |
|------|-----|
| App Admin | `/app-admin` |
| Operator | `/operator` |
| Owner | `/owner` |
| Support | `/support-desk` |
| Marketing | `/marketing` |

---

## 6. UI implementation

### 6.1 Naming

| Layer | Pattern |
|-------|---------|
| Core | `core_<name>.dart` → `Core<Name>` |
| Widgets | `widgets_<name>.dart` → `Widgets<Name>` (generic names only — no `widgets_auth_*` / `widgets_customer_*` shells) |
| Screens | `<role>_<snake>_screen.dart` → `<Role><Name>Screen` |
| Utilities | `utility_<name>.dart` |

Class name must match filename. No subfolders under `core/`, `widgets/`, `utilities/`.

### 6.2 Folder structure

```
lib/
├── core/                 # tokens, router, app_config
├── data/mockup|models|repositories/
├── l10n/
├── navigation/
├── providers/
├── screens/<role>/
├── utilities/
├── widgets/              # flat
└── main.dart
```

### 6.3 Shared widgets (use first)

`WidgetsScaffoldPage` · `WidgetsAppDrawer` · `WidgetsScreenLayout` · `WidgetsAppButton` · `WidgetsIconButton` · `WidgetsAppCard` · `WidgetsListItem` · `WidgetsChoiceCard` · `WidgetsMetricCard` · `WidgetsFoodCard` / catalog cards · `WidgetsFoodMediaPanel` · `WidgetsFinancialSummary` · `WidgetsOrderInvoiceBlock` · `WidgetsAmountLine` · `WidgetsCheckoutStepStrip` · `WidgetsStatusPill` · `WidgetsOpsGlanceChip` · `WidgetsRefreshList` · `WidgetsAsyncStateCard` · `WidgetsCartIconButton` · `WidgetsLogoIcon` · Semantics on primary CTAs.

**Do not** create per-screen button/card kits. Card glow: food/elevated merchandising only — keep ops dashboard cards quieter.

### 6.4 Screen workflow

1. Read `docs/prdv1.md` §7–§8 for the screen.
2. Edit existing route file in place unless PRD says NEW.
3. Reuse `Widgets*` · `Core*` · ARB.
4. If a pattern repeats twice → extract to `lib/widgets/`.
5. Prefer `ListView.builder` / lazy lists for long collections.
6. `dart format` · `flutter analyze` · `flutter gen-l10n` if ARB changed.

### 6.5 RTL & l10n

- Default locale **Arabic (`ar`)**, RTL.
- `PaddingDirectional` / start-end — not left/right.
- All user-visible strings in **ARB** (`app_en.arb` + `app_ar.arb`).
- Brand: **Ayletna Restaurant** / **مطعم عيلتنا** · logo `assets/images/logo_falafel.png`.

### 6.6 Stitch visual refresh (when matching mockups)

- ~90% of the app exists — refresh, do not rewrite.
- **≤25% deviation**: keep layout, flows, providers; adjust spacing/hierarchy/tokens.
- Prefer Stitch hierarchy unless PRD / this file is more accurate.
- Override Stitch when it breaks auth chrome rules or product fields.
- English-only in Stitch prompts; implement EN+AR in Flutter.

---

## 7. Mock logic

### 7.1 Data

- Business mocks in `lib/data/` (`MockupCatalog`, `Model*`).
- Prefer repository providers over direct catalog reads in screens.
- Localized labels stay in ARB.

### 7.2 Action matrix

| Behavior | When |
|----------|------|
| Navigate | Primary flow CTAs |
| Mutate provider/repository + optional ack snackbar | Saves, toggles, CRUD that another screen sees |
| `UtilityDemoActions` + mock button | Ops when `demoModeEnabled` — no fake financial success |
| Confirm dialog | Delete, void, refund, breakage |
| Disabled + explanation | Unavailable |

### 7.3 Financial & destructive

- Financial errors: inline `WidgetsErrorMessage` / red selectable text — not snackbar-only.
- Destructive: always confirm.
- Guest: block checkout with sign-in.

### 7.4 Refresh & lists

- `WidgetsRefreshList` on scrollable screens.
- Loading / empty / error via `WidgetsAsyncStateCard` patterns.

### 7.5 Do not merge routes without PRD update

Keep separate: admin detail vs management, report filter vs reports, plate editor vs plates management, stepped checkout screens behind flag.

---

## 8. Riverpod

- Prefer `ConsumerWidget` / `ConsumerStatefulWidget`.
- `AsyncValue` for repository-fed lists.
- `ref.invalidate()` after writes.
- No network inside widgets.

| Provider | Responsibility |
|----------|----------------|
| `appRoleProvider` | Current UI role |
| `appLocaleProvider` | ar/en |
| `sessionProvider` | Auth session + pending |
| `goRouterProvider` | Router + guard |
| `cartProvider` | Cart lines |
| `checkoutDraftProvider` | Stepped checkout |
| `placeOrderProvider` | Submit order (mock repo) |
| `menuCategoriesProvider` / `menuItemsProvider` | Menu |
| `userProfileProvider` | Profile + prefs |
| `visibleOffersProvider` | Approved/active offers only |
| `kitchenBoardProvider` | Kitchen tickets |
| `supportTicketsProvider` / `supportChatQueueProvider` | Support |

---

## 9. Security & accessibility (production targets + UI rules)

1. Production source of truth: `profiles.role` + `profiles.status` — not client picker after login.
2. `RoleSelectionScreen` only for multiple approved roles.
3. RLS uses `auth.uid()` — never trust client claims alone.
4. Attendance timestamps from server only (production).
5. Secrets via `--dart-define` / CI — never committed.
6. Audit logs on financial mutations.
7. TalkBack/VoiceOver · WCAG 2.1 AA · text scale to 200% · gold buttons use dark on-primary text `#4A3325`.

Sensitive data matrix (UI):

| Data | operator | owner | cashier | kitchen | delivery | customer |
|------|----------|-------|---------|---------|----------|----------|
| recipe_cost | R/W | per config | ❌ | ❌ | ❌ | ❌ |
| tip_ledger (distributed) | read | summary | own | own | own | ❌ |
| deposit on order | R/W pre-close | read | by state | ❌ | return | own |
| monthly distribution | full | customized | ❌ | ❌ | ❌ | ❌ |

---

## 10. Strict never / always

**Never:** hardcode colors/spacing/type in screens · add Supabase/HTTP in UI-only tasks · bottom nav · guest fake payment success · self-assign operator/owner · duplicate widgets · invent ratings · treat Stitch HTML as product truth · guess unfamiliar APIs when docs MCP available.

**Always:** match `docs/prdv1.md` · use `CoreColors`/`UtilitySizer` · `ConsumerWidget` for providers · light+dark via `CoreTheme.themeFor` · `WidgetsRefreshList` · keep food/tip/deposit separate · EN+AR ARB · close cycles with shared state.

---

## 11. Gap classification (when auditing actions)

| Gap | Meaning | Fix |
|-----|---------|-----|
| EMPTY | Silent no-op | Feedback or disabled |
| MOCK | Snackbar only | Provider/repository mutation |
| MISSING_ERROR | No error UI | Async error card + retry |
| MISSING_EMPTY | Empty list no CTA | Empty card + CTA |
| MISSING_LOADING | No spinner | Disable + progress |
| COMPLETE | Closed cycle | Document backend swap only |

Preferred close patterns: repository interface + mock · Riverpod · `placeOrderProvider` · `WidgetsAsyncStateCard` · `UtilityMockFeedback` after real mutation · cart/checkout providers.

Do not add real backend unless explicitly requested. Do not create commits unless asked.

---

## 12. Scope (mock phase)

- **Do:** UI, mock data, navigation, Riverpod, repository mocks, ARB, honest copy.
- **Do not:** Supabase, REST, durable persistence, production payments — until backend sprint.
- **Prefer:** thin repositories over direct `MockupCatalog` in screens.

---

## 13. Batch acceptance & handoff

**Before merge:** route registered · guard correct · drawer OK · no bottom nav · no raw hex/fontSize · order-type colors ≠ role primary · tip/deposit/food separated · RTL/JOD · no empty primary `onPressed` · guest blocked correctly · analyze clean.

**Handoff summary:** screens changed · routes · actions → state · data/widgets · PRD updates if behavior changed · commands run.

---

*End — Ayletna Development Rules v2.0.0*
