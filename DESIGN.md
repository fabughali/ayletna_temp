# DESIGN.md — Ayletna Restaurant (عيلتنا)

| Field | Value |
|-------|-------|
| **Updated** | 2026-08-01 |
| **Product** | Ayletna Restaurant · مطعم عيلتنا (Jordan, JOD) |
| **Platform** | Flutter · Material 3 · Arabic RTL default + English LTR |
| **Use** | Impeccable design agents · Google Stitch `upload_design_md` / screen generation |

Self-contained visual system. Flutter maps tokens via `lib/core/core_colors.dart`, `core_typography.dart`, `core_spacing.dart`, `core_content_sizes.dart`, `UtilitySizer` (design width **390**, scale clamp **0.70–1.18**).

---

## 1. Visual theme & atmosphere

Premium Levantine restaurant app — warm, trustworthy, operational clarity. Density **5/10** (customer) to **7/10** (ops hubs). Drawer-first navigation — **no bottom navigation bar**. Material 3 surfaces with falafel-gold brand warmth, not cold corporate gray. One brand / one widget kit for all roles; hubs tint chrome only.

---

## 2. Color palette

| Role | Name | Hex | Usage |
|------|------|-----|--------|
| Primary | Falafel Gold | `#C98A42` | CTAs, brand accents, revenue highlights |
| On-primary | Deep Brown | `#4A3325` | Text on gold buttons |
| Secondary | Olive Green | `#6E6A35` | Tips, loyalty, secondary actions |
| Accent | Warm Orange | `#D88A52` | Promos, warmth |
| Background light | Cream | `#F9F6F0` | App background |
| Background dark | — | `#121212` | Dark mode |
| Surface | White | `#FFFFFF` | Cards, sheets |
| Text primary | Espresso | `#2B211A` | Headlines, body |
| Text secondary | Taupe | `#6D5C4D` | Captions, metadata |
| Error | — | `#C62828` | Errors, destructive |
| Success | — | `#27AE60` | Success states |

### Order-type semantics (chips — never use role theme color)

| Type | Hex |
|------|-----|
| Dine-in | `#00897B` |
| Takeaway | `#F9A825` |
| Delivery | `#1976D2` |
| Plated delivery | `#7B1FA2` (locked) |

Order-type chips always show **icon + label + color**.

### Financial semantics

| Line | Color | Rule |
|------|-------|------|
| Food revenue | Gold `#C98A42` | Profit-eligible |
| Tips | Olive `#6E6A35` | Isolated from revenue |
| Deposits | Brown `#5D4037` | Temporary liability |

### Hub accents (drawer / app bar tint only)

| Hub | Accent |
|-----|--------|
| App Admin | `#37474F` |
| Operator | `#2C3E50` |
| Owner | `#6A4E23` |
| Support | `#1565C0` |
| Marketing | `#8E24AA` |

### Web / PWA

| Token | Hex |
|-------|-----|
| theme_color | `#C98A42` |
| background_color | `#F9F6F0` |

---

## 3. Typography

- **Arabic:** Noto Sans Arabic
- **English/Latin:** System sans or Noto Sans
- **Currency:** JOD suffix — amount bold, currency medium
- Scale: M3 display → label; max ~65 chars per line on body
- All type sizes via `CoreTypography` / scaled `ThemeData.textTheme` — no literal `fontSize` in screens

---

## 4. Layout & chrome

- 8px grid; mobile margins 16px
- Shell: `WidgetsScaffoldPage` = app bar + drawer + scroll body
- Pre-auth: **no** app bar, drawer, or profile avatar
- Customer home: hero → popular → categories → one promo rail
- Default checkout: stepped (`/cart` → `/checkout` → `/payment`); strip labels Basket → Fulfillment → Payment → Review
- Ops: glance chips, order-type color chips; quieter cards (glow reserved for food merchandising)
- Long lists: prefer `ListView.builder`
- Primary CTAs / list rows: Semantics labels

---

## 5. Component language

Shared Flutter widgets only (`WidgetsAppButton`, `WidgetsAppCard`, `WidgetsFoodCard`, `WidgetsListItem`, `WidgetsChoiceCard`, …). No per-role widget kits. No bottom navigation. No invented star ratings.

Brand mark: falafel logo (`assets/images/logo_falafel.png`) via `WidgetsLogoIcon`. Splash: cream `#F9F6F0` + gold loader.

---

## 6. Anti-patterns (NEVER)

- Bottom navigation bar
- Purple/neon AI gradient aesthetic
- Pure black `#000000` backgrounds
- Fake payment success for guests
- Mixing tips/deposits into revenue totals
- Generic “John Doe” / lorem-only screens without restaurant context
- English-only mockups when shipping Flutter (Stitch prompts may be EN-only; app ships EN+AR)
- Rainbow role primaries / parallel design systems
- Fake ratings (`4.8`, hash-based scores)

---

## 7. Stitch / generation notes

When generating a screen:
- Include route + `AppRole` guard
- Drawer destinations for that role
- Required product fields (orders, money lines, plated deposit when relevant)
- JOD, Amman/Jordan context, brand **Ayletna / عيلتنا**
- English UI copy in Stitch only
- Visual refresh of existing app (≤25% structural deviation) — not a rewrite
- Ignore Stitch chrome on auth screens if it shows app bar/drawer/avatar
