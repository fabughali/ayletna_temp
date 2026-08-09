# AGENTS.md — Ayletna Restaurant App (Agent Brief)

| Field | Value |
|-------|-------|
| **Updated** | 2026-08-01 |
| **Phase** | UI mock complete · frontend cycles closed · backend not started |
| **Product truth** | `docs/prdv1.md` |
| **How to code** | `docs/development_rules.md` |
| **RBAC matrix** | `docs/user_roles_permissions_matrix.md` |
| **Visual** | `DESIGN.md` · `PRODUCT.md` |

This brief is self-contained for routine agent work. Prefer editing existing screens/widgets; do not invent features that conflict with the PRD.

---

## 1. Architecture

```
Screens (~103) → Riverpod providers (in-memory) → Repository interfaces
                                                   ↓
                                        Mock implementations (today)
                                        Supabase classes (planned)
```

| Layer | Fact |
|-------|------|
| Network | No supabase/http/dio/firebase clients wired |
| Persistence | None — restart clears state |
| Switch point | `lib/data/repositories/repository_providers.dart` + new `*Supabase` repos |
| State | `StateNotifier` / `Provider` / `FutureProvider` |
| Nav | `go_router` + `UtilityRouteGuard` · drawer-first · no bottom nav |
| l10n | `app_en.arb` + `app_ar.arb` · Arabic default RTL |
| Flags | `demoModeEnabled=false` · `useSteppedCheckoutRoutes=true` |

**Cycle PASS:** mutate shared state another screen/role can see. Snackbar alone = FAIL. Smoke: `flutter test test/frontend_cycle_smoke_test.dart` (S1–S5).

---

## 2. Non-negotiable rules

1. `WidgetsScaffoldPage` on every screen; pre-auth: no app bar/drawer/avatar.
2. Shared `Widgets*` only — generic names; one brand (gold `#C98A42`) for all roles.
3. No raw hex / literal fontSize / bare px spacing in screens — `CoreColors` / `UtilitySizer` (390 · 0.70–1.18).
4. No `.withOpacity()` — use `withValues(alpha:)`.
5. EN+AR ARB for all UI strings.
6. Food / tip / deposit always separate lines; plated color `#7B1FA2` locked.
7. Guests: no fake payment success.
8. Stitch refresh ≤25% deviation; Stitch loses to PRD on chrome/fields.
9. No backend/HTTP unless user explicitly starts backend sprint.
10. No commits unless user asks.

---

## 3. Roles & hubs

| Role | Hub |
|------|-----|
| admin | `/app-admin` |
| operator | `/operator` |
| owner | `/owner` |
| support | `/support-desk` |
| marketing | `/marketing` |
| cashier / kitchen / delivery / inventory / staff | role prefixes |
| customer / guest | `/home` |

Legacy `/admin*` = redirect-only. Multi-role: one login, switch from Settings. Offers need Marketing + Operator approval. Support may refund/cancel + escalate. Subscriptions = content only until payments.

Financial constants: currency JOD · owner min 300 · operator salary 450 · 50/50 surplus · deposit default 10 · return reminder 60 min.

---

## 4. Known mock limits (honest)

- All CRUD is in-memory; copy must not claim durable/external delivery unless true.
- Catalog model gaps (tags, prepStation persistence, some AR subtitle fields) remain for backend schema.
- Realtime chat / FCM / OAuth / Maps / payments are adapters or mocks only.
- Remaining product work is **backend wiring** (Auth, orders realtime, payments, RLS) — not more UI checklists.

---

## 5. Backend switch sketch

1. Keep repository interfaces; implement `RepositoryMenuSupabase`, `RepositoryOrderSupabase`, `RepositoryAddressSupabase`.
2. Wire them in `repository_providers.dart` only.
3. Prioritize tables: profiles, menu_categories, menu_items, menu_addons, orders, addresses, offers, tickets, kitchen tickets, loyalty.
4. Schema detail: `docs/prdv1.md` §10.
5. Screens stay provider-facing — no HTTP in widgets.

---

## 6. Doc map (canonical only)

| File | Use |
|------|-----|
| `docs/prdv1.md` | Product, screens, fields, journeys, backend targets |
| `docs/development_rules.md` | Implementation rules (widgets, sizer, mock cycles, routing) |
| `docs/user_roles_permissions_matrix.md` | Full RBAC |
| `DESIGN.md` | Visual tokens |
| `PRODUCT.md` | Short product brief |
| `color_list_chat_gpt.txt` | Hex source (mirrored in DESIGN / CoreColors) |
| `.cursor/rules/stitch-redesign.mdc` | Stitch workflow |

Finished checklists and historical audits were removed after UI mock completion (2026-08).
