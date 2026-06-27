# Foundation UI/UX Checklist

Scope: `lib/widgets`, `lib/utilities`, and `lib/core`.

Reference documents checked:

- `prd.md`
- `ui_design_prompt.txt`
- `mockup_logic_prompt.md`

MCP cross-checks used:

- `user-filesystem` MCP confirmed flat file trees for `lib/core`, `lib/widgets`, and `lib/utilities`.
- `user-taste-skill` MCP confirmed the installed Taste Skill bundle is available and design guidance was reviewed.

## File Inventory

### Core Files

- `[x]` `lib/core/core_colors.dart`
- `[x]` `lib/core/core_color_scheme.dart`
- `[x]` `lib/core/core_content_sizes.dart`
- `[x]` `lib/core/core_router.dart`
- `[x]` `lib/core/core_spacing.dart`
- `[x]` `lib/core/core_theme.dart`
- `[x]` `lib/core/core_theme_extensions.dart`
- `[x]` `lib/core/core_typography.dart`

### Utility Files

- `[x]` `lib/utilities/utility_format_jod.dart`
- `[x]` `lib/utilities/utility_mock_feedback.dart`
- `[x]` `lib/utilities/utility_responsive_breakpoints.dart`
- `[x]` `lib/utilities/utility_route_guard.dart`
- `[x]` `lib/utilities/utility_url_actions.dart`

### Widget Files

- `[x]` 64 active files exist under `lib/widgets`.
- `[x]` Folder is flat, with no widget subfolders.
- `[x]` File naming follows the project pattern `widgets_<name>.dart`.
- `[~]` Some widget files intentionally expose more than one public widget class, such as `widgets_phone_text.dart`, `widgets_nav_tile.dart`, `widgets_financial_summary.dart`, and `widgets_operations_cards.dart`. This is acceptable for closely related primitives, but large multi-widget files should be split later if they keep growing.

## Automated Scans

- `[x]` No `withOpacity(...)` usage found in `lib/core`, `lib/widgets`, or `lib/utilities`.
- `[x]` No `TODO`, `FIXME`, `print(...)`, or `debugPrint(...)` found in the foundation layer.
- `[x]` No obvious empty callbacks like `onPressed: () {}` or `onTap: () {}` found in widget files.
- `[x]` No linter errors reported for `lib/core`, `lib/widgets`, or `lib/utilities`.
- `[~]` Color literals exist inside `CoreColors`, `CoreColorScheme`, and `CoreTheme`, which is centralized and acceptable. For stricter traceability, role palette literals can be lifted into named `CoreColors` tokens later.
- `[~]` One widget-level `Colors.transparent` exists for modal bottom sheet background. This is a technical transparency value, not a brand color violation.

## Core Checklist

### Design Tokens

- `[x]` `CoreColors` contains brand colors, light/dark surfaces, order-type colors, financial semantic colors, and PWA colors.
- `[x]` Order-type colors are separate from role theme colors, matching `prd.md` and `ui_design_prompt.txt`.
- `[x]` Financial semantic colors exist for tip, deposit, revenue, success, warning, and error.
- `[x]` Opacity helpers use `withValues(alpha: ...)`, not legacy opacity APIs.
- `[~]` Some role-specific colors are still raw `Color(0x...)` values inside `CoreColorScheme` and `CoreTheme`; this is centralized but could be made cleaner by naming every role token in `CoreColors`.

### Theme And Typography

- `[x]` `CoreTheme.themeFor` is role-aware and uses Material 3.
- `[x]` Theme changes with `AppRole` and brightness.
- `[x]` `CoreThemeExtensions` centralizes button height, icon button size, OTP style, splash gradient, and decoration values by responsive band.
- `[x]` `CoreTypography` applies a shared fallback stack suitable for Arabic and English.
- `[x]` `main.dart` wraps the app in `ProviderScope`, applies `CoreTheme.themeFor`, supports generated l10n locales, and defaults unsupported locales to Arabic.

### Router And Role Access

- `[x]` `CoreRouter` uses GoRouter and Riverpod refresh listeners.
- `[x]` Auth, customer, guest, support, admin, cashier, kitchen, delivery, inventory, and staff route groups are registered.
- `[x]` Legacy checkout routes redirect safely to cart after checkout consolidation.
- `[x]` Guest route sets `AppRole.guest` and redirects to shared home.
- `[x]` `UtilityRouteGuard` protects role-specific routes and permits shared support/FAQ where appropriate.
- `[x]` Guest access matches the current decision: browse home/menu/product/cart/rewards/support, but signup is required for checkout/order/profile/history flows.

## Utilities Checklist

### `utility_responsive_breakpoints.dart`

- `[x]` Provides the single source of truth for mobile, tablet, and web breakpoints.
- `[x]` Matches `ui_design_prompt.txt`: mobile `<= 479`, tablet `480-991`, web `> 991`.
- `[x]` Provides max content width by content band.

### `utility_route_guard.dart`

- `[x]` Aligns with PRD role separation at the mock UI layer.
- `[x]` Keeps public auth paths open.
- `[x]` Redirects unauthenticated protected access to login.
- `[x]` Handles guest-specific allowed and signup-required paths.
- `[x]` Keeps support, support chat, and FAQ accessible to relevant roles.

### `utility_mock_feedback.dart`

- `[x]` Centralizes mock success/info/warning snackbars.
- `[x]` Removes the current snackbar before showing the next one.
- `[x]` Provides confirmation dialogs for destructive/mock-decision flows.
- `[x]` Provides branded action sheets using shared card, button, icon button, spacing, and typography primitives.

### `utility_url_actions.dart`

- `[x]` Centralizes external URL launching.
- `[x]` Uses `url_launcher` external application mode for phone/WhatsApp style flows.
- `[x]` Fails gracefully with `false` instead of throwing into the UI.

### `utility_format_jod.dart`

- `[x]` Provides centralized JOD formatting.
- `[~]` Default suffix is Arabic (`د.أ`). Most screens pass the localized suffix explicitly, but the default should be treated as a fallback only.

## Widgets Checklist

### Layout And Shell

- `[x]` `WidgetsScreenLayout` owns screen-level max width and edge-attached vertical scroll zones.
- `[x]` `WidgetsScaffoldPage` provides the standard app bar, drawer, safe area, and screen layout wrapper.
- `[x]` `WidgetsCustomerShell` wraps customer routes without bottom navigation, matching the drawer-first navigation decision.
- `[x]` `WidgetsAppDrawer` is role-aware and shows different destinations for customer and guest.
- `[x]` Drawer active label is dynamic instead of fixed.
- `[x]` Drawer support destination points to the shared customer support route.

### Core UI Primitives

- `[x]` `WidgetsAppButton` centralizes button variants and shared sizing.
- `[x]` `WidgetsIconButton` centralizes icon-only actions and size behavior.
- `[x]` `WidgetsAppCard` provides the premium shared card shell.
- `[x]` `WidgetsAppTextField` centralizes text field styling.
- `[x]` `WidgetsFilterChip`, `WidgetsStatusPill`, `WidgetsInfoBanner`, `WidgetsListItem`, and `WidgetsEmptyState` provide reusable state/display primitives.
- `[x]` `WidgetsQuantityStepper`, `WidgetsTipSelector`, `WidgetsTermsCheckbox`, and `WidgetsOrderTypeChip` support common ordering interactions.

### Food And Cart Components

- `[x]` `WidgetsFoodCard` supports image-forward food cards, title/description truncation, reward label, price/rating/dining tags, and add-to-cart action.
- `[x]` `WidgetsFoodMediaPanel` and `WidgetsMockFoodImage` support online food imagery with fallback.
- `[x]` `WidgetsCartIconButton` shows the app-bar cart count badge only when needed.
- `[x]` `WidgetsCartCustomizationSheet` supports quantity, remarks, portion, addons, and configured cart insertion.
- `[x]` `WidgetsCartCustomizationSheet` reads option keys/prices from typed mock data in `lib/data`; visible option labels remain localized through ARB.

### Admin/Operations Widgets

- `[x]` Operations widgets use shared tokens, semantic colors, and role-appropriate operational patterns.
- `[x]` `WidgetsAdminGrowthHub` consolidates admin growth/privacy/loyalty/offers concepts into a reusable hub widget.
- `[x]` `WidgetsAdminGrowthHub` user-facing labels now use ARB localization.
- `[x]` `WidgetsReportFilterSheet` user-facing labels now use ARB localization.

### Input, Feedback, And Accessibility Basics

- `[x]` `WidgetsOtpInput` is a reusable OTP input with controlled callbacks.
- `[x]` `WidgetsPhoneText` and `WidgetsMixedPhoneText` support LTR phone rendering inside RTL content.
- `[x]` Shared buttons and icon buttons expose labels/tooltips through caller-provided strings or Material localizations.
- `[~]` Full accessibility semantics are acceptable for Flutter widgets, but Flutter web still exposes limited Playwright semantics for canvas-rendered content. Widget tests would be better for fine-grained a11y validation.

## PRD Compliance

- `[x]` Core roles match PRD roles through `AppRole`.
- `[x]` Order types match PRD order types through `OrderType`.
- `[x]` Customer/guest route rules reflect the latest redesigned guest/customer flow.
- `[x]` Financial color separation exists for revenue, tips, deposits, success, warning, and error.
- `[x]` Responsive design exists through centralized breakpoints and content width caps.
- `[~]` PRD originally describes guest as menu/price browsing only, while the current UX decision allows guests to add to cart and reach signup gate. This is intentionally documented by the latest customer/guest chapter decision.

## `ui_design_prompt.txt` Compliance

- `[x]` `lib/core`, `lib/widgets`, and `lib/utilities` are flat folders.
- `[x]` Core naming and main public class naming generally follow the required pattern.
- `[x]` Material 3, role-aware theming, responsive bands, and Arabic-first localization are wired.
- `[x]` Screens can use `WidgetsScreenLayout` as the single max-width wrapper.
- `[x]` Foundation widgets use `CoreSpacing`, `CoreTypography`, `CoreColors`, `CoreThemeExtensions`, and theme color schemes.
- `[x]` No `.withOpacity()` usage exists in foundation files.
- `[x]` Previously identified inline labels in reusable/admin widgets were moved to ARB.
- `[~]` Some role palette literals are centralized but not individually named in `CoreColors`.

## `mockup_logic_prompt.md` Compliance

- `[x]` Route guard, router, and shell widgets support front-end-only mock navigation.
- `[x]` Mock feedback helpers support snackbars, dialogs, bottom sheets, and confirmations.
- `[x]` Interactive widget primitives expose callbacks for screens to implement navigation or state changes.
- `[x]` No backend, API, Supabase, or persistence integration was added in these foundation layers.
- `[x]` Cart customization option pricing/configuration moved into typed mock data under `lib/data`.
- `[x]` Inline admin/report labels moved to ARB.

## Remaining Foundation Items

Implemented cleanup:

1. `[x]` Move inline labels from `widgets_admin_growth_hub.dart` to ARB.
2. `[x]` Move inline labels from `widgets_report_filter_sheet.dart` to ARB.
3. `[x]` Move the inline quantity label in `widgets_cart_customization_sheet.dart` to ARB.
4. `[x]` Move cart customization option definitions/prices from `WidgetsCartCustomizationSheet` into typed mock data under `lib/data`.

Remaining optional foundation items:

1. `[ ]` Optionally promote all role palette literals in `CoreColorScheme` and `CoreTheme` into named `CoreColors` tokens for stricter traceability to `color_list_chat_gpt.txt`.
2. `[ ]` Add focused widget tests later for `WidgetsScreenLayout`, `WidgetsOtpInput`, `WidgetsCartCustomizationSheet`, `WidgetsFoodCard`, and `UtilityRouteGuard`.

## Final Status

Foundation structure status: **DONE**

Customer/guest/auth foundation support status: **DONE**

Strict whole-app foundation compliance status: **DONE**

Remaining work is optional hardening only: stricter token naming for role palettes and focused widget tests.
