# Ayletna Restaurant

Ayletna Restaurant is a warm, Arabic-first digital restaurant experience built to make ordering, operations, and management feel elegant from the first tap. It brings the food menu, cart, loyalty, kitchen workflow, delivery tasks, cashier POS, inventory, staff tips, and admin reporting into one polished hospitality platform.

The app is designed around the real rhythm of a restaurant: guests browse rich food cards, customers build orders and track kitchen progress, cashiers work from a fast POS, kitchen staff see clear prep tickets, delivery teams handle pickups and plated returns, and managers monitor sales, staff, reports, deposits, and menu readiness from command-center screens.

## Highlights

- Arabic-first, RTL-ready customer journey with English support.
- Real menu mockup for shawarma, qalayat, hummus, ful, drinks, sandwiches, falafel, pizza, manaqeesh, pastries, snacks, and burgers.
- Food-focused storefront with dish imagery, price badges, popular picks, offers, combo builder, cart, checkout, payment, rewards, and order tracking.
- Restaurant operations screens for cashier POS, order history, kitchen pass, kitchen prep, delivery pickup, plated return, inventory, stock adjustment, staff attendance, and staff tip history.
- Admin command center for orders, reports, menu management, deposits, plates, users, loyalty, offers, pre-orders, audit logs, and settings.
- Responsive Material 3 interface with role-aware themes, drawer navigation, full-width scrolling behavior, and polished mock feedback for every action.

## Technical Foundation

- Built with Flutter for a responsive web and mobile-ready experience.
- Uses Riverpod for predictable state management.
- Uses GoRouter for role-aware navigation and route flows.
- Uses Flutter localization with Arabic-first copy and RTL support.
- Uses centralized mock data models so the prototype feels realistic while staying easy to evolve.
- Uses shared design tokens and reusable widgets for consistent cards, buttons, food media, price badges, drawers, reports, operations tickets, and screen layouts.

## Links

- Source code: https://github.com/fabughali/ayletna-restaurant-app
- Live app (GitHub Pages): https://fabughali.github.io/ayletna_temp/
- CI deploy preview: https://fabughali.github.io/ayletna-restaurant-app/

## Deploy

Push to `main` on the source repository triggers a GitHub Actions build and deploy to GitHub Pages.

To refresh the legacy live URL at `ayletna_temp`, run from the project root:

```bash
./deploy-only.sh
```
