# Ayletna Mock-Up Logic Implementation Prompt

Use this prompt to implement front-end-only mock logic for Ayletna Restaurant after the branding phase.

## Scope

- Implement UI-only behavior. Do not add backend, API, Supabase, or persistence integration.
- Keep mock data in `lib/data/**`, preferably `lib/data/mockup/mockup_catalog.dart` and typed models in `lib/data/models/**`.
- Keep screens aligned with `prd.md`, `prd_full_v5_technical.txt`, and `ui_design_prompt.txt`.
- Preserve Arabic-first RTL, localization through ARB, Material 3, Riverpod, GoRouter, and the completed branding component system.

## Required Study Before Each Batch

1. Read the target screen and its route in `lib/core/core_router.dart`.
2. Confirm the route exists in `lib/navigation/app_route_paths.dart`.
3. Confirm role access in `lib/utilities/utility_route_guard.dart`.
4. Identify every button, icon button, card tap, switch, filter, form submit, refresh action, and destructive action.
5. Check whether the screen uses inline mock data. Move business data to `lib/data`.
6. Check the PRD purpose of the screen and verify each action supports that purpose.

## Navigation Rules

- Every primary CTA must navigate to the PRD-expected next screen or show front-end feedback.
- Every bottom navigation destination must be role-appropriate.
- No button should silently do nothing unless it is explicitly disabled or intentionally decorative.
- Back/cancel actions should use `context.pop()` when returning to the previous screen and `context.go(...)` when returning to a fixed workflow root.
- Deep links such as `/order/:id` and `/tip/daily/:date` must keep working.

## Button And Action Rules

For each action, choose one mock behavior:

- Navigate to a target screen.
- Show `SnackBar` for save/success/apply/refresh/mock-complete actions.
- Show confirmation dialog for delete, deactivate, cancel order, refund, breakage, and irreversible actions.
- Show bottom sheet/dialog for filters, details, export options, sharing, and item previews.
- Toggle local/Riverpod mock state for switches, filters, quantity, selected chips, and workflow steps.
- Disable the button if the action is not available, with visible explanation where needed.

## Mock Data Rules

- Business mock data must live in `lib/data`.
- Localized labels stay in ARB, not in mock data.
- Screens may keep visual-only constants such as chart ratios, painter coordinates, layout counts, and UI animation values.
- Move restaurant data, users, staff, orders, payments, reports, inventory rows, plate rows, transactions, addresses, rewards, notification rows, and operational logs into typed mock models/catalogs.

## UX Rules

- Keep flows short, discoverable, and role-appropriate.
- Use snackbars/dialogs for feedback after user action.
- Use tabs only when they reduce duplicate screens without breaking PRD routes.
- Do not delete or merge screens unless routes and PRD navigation remain clear.
- If a new mock-only screen is needed, add it only when a PRD action has no reasonable existing destination.
- Any new or modified UI must follow `ui_design_prompt.txt` and the branding checklist.

## Output Requirements Per Batch

- List screens changed.
- List routes verified.
- List buttons/actions completed.
- List mock data moved/created in `lib/data`.
- List new screens/components created, if any.
- Run `dart format`, `flutter analyze`, focused branding scan, and lints for edited files.
