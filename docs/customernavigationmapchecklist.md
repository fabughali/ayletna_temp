# Customer Navigation Map Checklist

> **Version:** 1.0.0 · **Generated:** 2026-06-19  
> **Source audit:** `lib/screens/customer/` (30 screens) + shared widgets (`widgets_app_drawer.dart`, `widgets_scaffold_page.dart`, `widgets_customer_search_bar.dart`, `widgets_cart_icon_button.dart`)

Use this document to verify every tappable control on customer-facing screens: where it goes, what it does, and whether behavior is real navigation or mock/demo feedback.

---

## Legend

| Symbol | Meaning |
|--------|---------|
| ✅ | Real route navigation (`context.go` / `context.push`) |
| 🔄 | In-place state change (filter, expand, quantity, toggle) — no route change |
| 📋 | Opens dialog, bottom sheet, or customization sheet |
| 🧪 | Mock/demo action (`UtilityMockFeedback`, external URI launch, snackbar only) |
| 👤 | Behavior differs for **Guest** vs **Customer** |
| ⚙️ | Depends on `AppConfig` flag |

**Route paths** reference `lib/navigation/app_route_paths.dart`.

---

## Global Navigation (All Customer Screens)

### App scaffold (`WidgetsScaffoldPage`)

| Control | When visible | Action |
|---------|--------------|--------|
| ☰ Menu icon (leading) | On drawer-shell routes: `/home`, `/search`, `/cart`, `/order-history`, `/notifications`, `/profile` | Opens `WidgetsAppDrawer` |
| ← Back button (leading) | On all other routes when `context.canPop()` | Pops navigation stack |
| Drawer | Always available on scaffold pages | See drawer table below |

### Drawer — Customer role (`AppRole.customer`)

| Drawer item | Route | Also highlights when on |
|-------------|-------|-------------------------|
| Home | ✅ `/home` | `/search` |
| Menu | ✅ `/category` | `/product-detail`, `/order-type`, `/dine-in`, `/takeaway`, `/delivery-address`, `/plated-info`, `/combo` |
| Cart | ✅ `/cart` | `/checkout`, `/payment`, `/tip`, `/order-confirmation` |
| Orders | ✅ `/order-history` | `/order-tracking`, `/rating-review` |
| Rewards | ✅ `/rewards` | `/loyalty`, `/redemption`, `/offers`, `/discounts` |
| Notifications | ✅ `/notifications` | — |
| Profile | ✅ `/profile` | `/account-settings`, `/edit-profile`, `/addresses`, `/map-picker`, `/wallet`, `/plated-return-reminder`, `/payment-history`, `/rewards-history` |
| Support | ✅ `/support` | `/support-chat`, `/faq` |

### Drawer — Guest role (`AppRole.guest`)

Same as customer **except**:
- No **Orders** or **Profile** entries
- Extra **Sign in** item → ✅ `/login`
- Cart active routes exclude `/order-confirmation`

### Shared app-bar actions (most customer screens)

| Control | Action |
|---------|--------|
| 🔔 Notifications icon | ✅ `/notifications` |
| 🛒 Cart icon (`WidgetsCartIconButton`) | ✅ `/cart` (always visible) |

### Shared widget — Search bar (`WidgetsCustomerSearchBar`)

| Control | Action |
|---------|--------|
| Text field submit (non-empty query) | ✅ `/search?q={query}` |
| Search icon button | Same as submit |
| Empty query submit | No action |

### Shared widget — Cart customization sheet

Opened from food cards across Home, Category, Search, Discounts, Combo (add flows).

| Control | Action |
|---------|--------|
| Configure & add | 🔄 Adds configured item to `cartProvider` |
| Dismiss | Closes sheet |

---

## Config Flags Affecting Navigation

| Flag | Effect |
|------|--------|
| `AppConfig.useSteppedCheckoutRoutes == true` | Cart **Proceed** → ✅ `/checkout` → `/payment` → `/order-confirmation` |
| `AppConfig.useSteppedCheckoutRoutes == false` | Cart **Proceed** → ✅ `/order-confirmation` directly |
| Guest session | Cart **Proceed** / guest banners → ✅ `/login` instead of checkout |

---

## Screen-by-Screen Checklists

---

### 1. Customer Home — `/home`
**File:** `customer_home_screen.dart`

#### App bar
| Control | Action |
|---------|--------|
| ☰ Menu | Opens drawer |
| 🔔 Notifications | ✅ `/notifications` |
| 🛒 Cart | ✅ `/cart` |

#### Pull-to-refresh
| Control | Action |
|---------|--------|
| Pull down | 🔄 Invalidates `menuCategoriesProvider`, `menuItemsProvider` |

#### Search
| Control | Action |
|---------|--------|
| `WidgetsCustomerSearchBar` | ✅ `/search?q=…` |

#### Offers section
| Control | Action |
|---------|--------|
| Section header **View all** | ✅ `/offers` |
| Offer entry card (tap card) | ✅ `/offers` |
| Offer card action button | ✅ `/offers` |

#### Combos section
| Control | Action |
|---------|--------|
| Section header **View all** | ✅ `/combo` |
| Combo entry card | ✅ `/combo` |

#### Discounts rail
| Control | Action |
|---------|--------|
| Section header **View all** | ✅ `/discounts` |
| Discount food card — tap body | ✅ `/product-detail` (sets `selectedMenuItemIdProvider`) |
| Discount card — add icon | 📋 Customization sheet → cart |

#### Subscriptions rail
| Control | Action |
|---------|--------|
| Section header **View all** | ✅ `/loyalty` |
| Subscription card — tap body | ✅ `/product-detail` |
| Subscription card — subscribe icon | 📋 Customization sheet |

#### Categories section
| Control | Action |
|---------|--------|
| **View all** | ✅ `/category` |
| Category tile | 🔄 Sets `selectedCategoryIdProvider` + ✅ `/category` |

#### Popular this week
| Control | Action |
|---------|--------|
| **View all** | ✅ `/category` |
| Featured hero — **Order now** | 🔄 Sets item id + ✅ `/product-detail` |
| Featured hero — **Category** | ✅ `/category` |
| Popular food card — tap | ✅ `/product-detail` |
| Popular food card — add | 📋 Customization sheet |

#### Stories / plated promo
| Control | Action |
|---------|--------|
| Section header **Learn how it works** | ✅ `/offers` |
| Plated hero card — **Order now** | ✅ `/cart` |
| Promo story cards | Display only (no tap handler) |

#### Sustainability banner
| Control | Action |
|---------|--------|
| **Learn how it works** | ✅ `/terms` |

---

### 2. Customer Search — `/search` (+ `?q=`)
**File:** `customer_search_screen.dart`

#### App bar
| ☰ / 🔔 / 🛒 | Same global pattern |

#### Search hero
| Control | Action |
|---------|--------|
| Search field submit | 🔄 Updates local query filter |
| Search suffix icon | Same |

#### Suggestion chips
| Control | Action |
|---------|--------|
| Category suggestion chip | 🔄 Fills query & runs search |

#### Empty / no-results states
| Control | Action |
|---------|--------|
| **Browse menu** button | ✅ `/category` |
| **View categories** button | ✅ `/category` |

#### Result cards
| Control | Action |
|---------|--------|
| Food card — tap | 🔄 Sets `selectedMenuItemIdProvider` + ✅ `/product-detail` |
| Food card — add | 📋 Customization sheet |

---

### 3. Customer Category (Menu) — `/category`
**File:** `customer_category_screen.dart`

#### App bar
| ☰ / 🔔 / 🛒 | Same global pattern |

#### Pull-to-refresh
| Control | Action |
|---------|--------|
| Pull down | 🔄 Invalidates menu providers |

#### Search bar
| Control | Action |
|---------|--------|
| Submit | ✅ `/search?q=…` |

#### Category chips
| Control | Action |
|---------|--------|
| Category chip tap | 🔄 Updates `selectedCategoryIdProvider` (filters grid in place) |

#### Menu grid cards
| Control | Action |
|---------|--------|
| Card — tap / open | 🔄 Sets item id + ✅ `/product-detail` |
| Card — add button | 📋 Customization sheet |

---

### 4. Customer Product Detail — `/product-detail`
**File:** `customer_product_detail_screen.dart`

#### App bar
| ← Back / 🔔 / 🛒 | Back pops; notifications & cart as global |

#### Gallery
| Control | Action |
|---------|--------|
| Page swipe | 🔄 Changes selected image index |
| Gallery dot | 🔄 Jumps to image |

#### Product options
| Control | Action |
|---------|--------|
| Portion chips (single / family) | 🔄 Updates price & config |
| Extra jameed / almonds toggles | 🔄 Updates price |
| No pine nuts toggle | 🔄 Updates config |
| Special instructions field | 🔄 Text input |

#### Meta row
| Control | Action |
|---------|--------|
| Rating row tap | 📋 Review preview bottom sheet (mock reviews) |
| **See all reviews** link | ✅ `/product-reviews` |

#### Related items rail
| Control | Action |
|---------|--------|
| Related card — tap | 🔄 Sets new item id (same screen, new data) |
| Related card — add | 📋 Customization sheet |

#### Sticky bottom panel
| Control | Action |
|---------|--------|
| − / + quantity | 🔄 Adjust quantity |
| **Add to cart** | 🔄 Adds to cart + 📋 Reward dialog |

#### Reward dialog (after add)
| Control | Action |
|---------|--------|
| Close (×) | Closes dialog |
| **Continue shopping** | ✅ `/category` |
| **Checkout** | ✅ `/cart` |

---

### 5. Customer Product Reviews — `/product-reviews`
**File:** `customer_product_reviews_screen.dart`

| Control | Action |
|---------|--------|
| ← Back | Pop stack |
| 🔔 Notifications | ✅ `/notifications` |
| Review list / cards | Display only |
| Pull-to-refresh (if present) | 🧪 Info snackbar |

---

### 6. Customer Cart — `/cart`
**File:** `customer_cart_screen.dart`

#### App bar
| ☰ / 🔔 / 🛒 | Drawer on ☰; cart icon still visible |

#### Empty cart state
| Control | Action |
|---------|--------|
| **Browse menu** | ✅ `/category` |

#### Cart line items
| Control | Action |
|---------|--------|
| − / + quantity | 🔄 Updates cart quantity |
| Remove item | 📋 Confirm dialog → 🔄 removes from cart + 🧪 info |
| Clear all | 📋 Confirm dialog → 🔄 clears cart + 🧪 info |

#### Checkout step strip (in-page)
| Control | Action |
|---------|--------|
| Step chip tap | 🔄 Scrolls to section (items / fulfillment / payment / summary) |

#### Fulfillment chips
| Control | Action |
|---------|--------|
| Dine-in / Takeaway / Delivery / Group / Plated | 🔄 Selects fulfillment; if address required & none → 📋 Address picker dialog |

#### Address picker dialog
| Control | Action |
|---------|--------|
| Select saved address | 🔄 Sets selected address |
| **Add address** | ✅ `/map-picker?return=profile` |

#### Payment type chips
| Control | Action |
|---------|--------|
| Card / Cash | 🔄 Selects payment type |

#### Tip selector
| Control | Action |
|---------|--------|
| Tip chips / custom | 🔄 Updates tip amount |

#### Promo code
| Control | Action |
|---------|--------|
| Apply promo | 🧪 Success snackbar (mock apply) |

#### Plated deposit / terms
| Control | Action |
|---------|--------|
| Terms link | ✅ `/terms` |

#### Guest banner 👤
| Control | Action |
|---------|--------|
| **Sign in** | ✅ `/login` |

#### Order summary — Proceed 👤 ⚙️
| Control | Action |
|---------|--------|
| **Proceed to checkout** (guest) | ✅ `/login` |
| **Proceed** (customer, invalid) | Disabled |
| **Proceed** (customer, valid, stepped) | 🔄 Syncs `checkoutDraftProvider` + ✅ `/checkout` |
| **Proceed** (customer, valid, legacy) | ✅ `/order-confirmation` |

#### Help card
| Control | Action |
|---------|--------|
| **Support** | ✅ `/support` |

---

### 7. Customer Checkout (Step 2 — Fulfillment) — `/checkout`
**File:** `customer_checkout_screen.dart` · Only when `useSteppedCheckoutRoutes`

| Control | Action |
|---------|--------|
| ← Back | Pop |
| Checkout step strip tap | ⚙️ Step 0 → ✅ `/cart`; Step 2 → ✅ `/payment` |
| Fulfillment choice chips | 🔄 Updates `checkoutDraftProvider.fulfillment` |
| Address picker (when required) | 🔄 Sets `selectedAddressId` on draft |
| **Continue** | ✅ `/payment` (disabled if address required but missing) |
| **Back to cart** | ✅ `/cart` |

---

### 8. Customer Checkout Payment (Step 3) — `/payment`
**File:** `customer_checkout_payment_screen.dart`

| Control | Action |
|---------|--------|
| ← Back | Pop |
| Step strip — step 0 | ✅ `/cart` |
| Step strip — step 1 | ✅ `/checkout` |
| Payment method chips | 🔄 Updates draft payment type |
| Tip controls | 🔄 Updates draft tip |
| **Place order** 👤 | Guest → ✅ `/login`; Customer → ✅ `/order-confirmation` |

---

### 9. Customer Order Confirmation — `/order-confirmation`
**File:** `customer_order_confirmation_screen.dart`

| Control | Action |
|---------|--------|
| ← Back | Pop (if stack allows) |
| **Track order** | ✅ `/order-tracking` |
| **Back to home** | ✅ `/home` |
| Invoice / summary blocks | Display only |

---

### 10. Customer Order Tracking — `/order-tracking`
**File:** `customer_order_tracking_screen.dart`

| Control | Action |
|---------|--------|
| ← Back | Pop |
| 🔔 Notifications | ✅ `/notifications` |
| Timeline step info buttons | 🧪 Info snackbar |
| **Contact driver** (or similar) | 🧪 Coming soon |
| **Rate order** | ✅ `/rating-review` |

---

### 11. Customer Order History — `/order-history`
**File:** `customer_order_history_screen.dart`

#### App bar
| ☰ / 🔔 / 🛒 | Same global pattern |

#### Hero filter chips
| Control | Action |
|---------|--------|
| Last 30 days / Active / Completed / Cancelled | 🔄 Filters displayed orders |

#### Order cards
| Control | Action |
|---------|--------|
| **View status** (active orders) | 📋 Progress bottom sheet + 🧪 success toast |
| **View invoice** (completed) | 📋 Invoice dialog |
| **Reorder** / **Try again** | 🧪 Success toast + ✅ `/cart` |
| **Rate order** | ✅ `/rating-review` |

#### Footer
| Control | Action |
|---------|--------|
| **Show more** | 🧪 Info snackbar (mock pagination) |

---

### 12. Customer Rating & Review — `/rating-review`
**File:** `customer_rating_review_screen.dart`

| Control | Action |
|---------|--------|
| ← Back / 🔔 | Pop / `/notifications` |
| Star rating tap | 🔄 Sets rating |
| Review text field | 🔄 Input |
| **Submit review** | 🧪 Success snackbar + ✅ `/loyalty` |
| **Skip for now** | ✅ `/order-history` |

---

### 13. Customer Offers — `/offers`
**File:** `customer_offers_screen.dart`

| Control | Action |
|---------|--------|
| ← Back / 🔔 / 🛒 | Standard |
| Pull-to-refresh | 🧪 Info snackbar |
| Featured offer — **Claim** | 🧪 Success + ✅ `/cart` |
| Bundle offer — **Claim** | 🧪 Success + ✅ `/combo` or `/cart` (offer type) |
| Combo upsell — **Build combo** | ✅ `/combo` |

---

### 14. Customer Discounts — `/discounts`
**File:** `customer_discounts_screen.dart`

| Control | Action |
|---------|--------|
| ← Back / 🔔 / 🛒 | Standard |
| Discount food cards — tap | ✅ `/product-detail` |
| Discount cards — add | 📋 Customization sheet |
| **Browse full menu** | ✅ `/category` |

---

### 15. Customer Combo Builder — `/combo`
**File:** `customer_combo_builder_screen.dart`

| Control | Action |
|---------|--------|
| ← Back / 🔔 / 🛒 | Standard |
| Pull-to-refresh | 🧪 Info snackbar |
| Combo slot item chips | 🔄 Selects slot item |
| Drink / side toggles | 🔄 Updates combo config |
| **Add combo to cart** | 🧪 Success + ✅ `/cart` |

---

### 16. Customer Loyalty — `/loyalty`
**File:** `customer_loyalty_screen.dart`

| Control | Action |
|---------|--------|
| ← Back / 🔔 | Standard (no cart in app bar) |
| Pull-to-refresh | 🧪 Info snackbar |
| Perks card — **Explore rewards** | ✅ `/rewards` |
| Treats-only toggle | 🔄 Filters reward list |
| Reward treat card — **Redeem** | ✅ `/redemption` (disabled if locked) |
| Stamp card / hero (guest) | Display; may prompt sign-in via copy |

---

### 17. Customer Rewards Catalog — `/rewards`
**File:** `customer_rewards_catalog_screen.dart`

| Control | Action |
|---------|--------|
| ← Back / 🔔 | Standard |
| Pull-to-refresh | 🧪 Info snackbar |
| Tier filter chips | 🔄 Filters catalog |
| Reward card — **Redeem** 👤 | Guest → ✅ `/register`; Locked → 🧪 info; Else → ✅ `/redemption` |
| Hero CTA (guest) | ✅ `/register` |

---

### 18. Customer Redemption Confirm — `/redemption`
**File:** `customer_redemption_confirm_screen.dart`

| Control | Action |
|---------|--------|
| ← Back | Pop |
| **Confirm redemption** | 🧪 Success snackbar + ✅ `/cart` |
| **Back to rewards** | ✅ `/rewards` |

---

### 19. Customer Rewards History — `/rewards-history`
**File:** `customer_rewards_history_screen.dart`

| Control | Action |
|---------|--------|
| ← Back / 🔔 | Standard |
| History list items | Display only |

---

### 20. Customer Notifications — `/notifications`
**File:** `customer_notifications_screen.dart`

#### App bar
| ☰ Menu | Opens drawer |
| Filled 🔔 (badge) | 🧪 Info snackbar |
| Avatar | Display only |

#### Header actions
| Control | Action |
|---------|--------|
| **Clear all** | 📋 Confirm → 🧪 success snackbar |
| **Preferences** | ✅ `/profile` |

#### Pull-to-refresh
| Control | Action |
|---------|--------|
| Pull down | 🧪 Info snackbar |

#### Category summary rows
| Control | Action |
|---------|--------|
| Category row overflow (⋮) | 📋 Action sheet → 🧪 info per option |

#### Weekly report card
| Control | Action |
|---------|--------|
| Card actions | 🧪 Info / action sheet (mock) |

#### Notification cards
| Control | Action |
|---------|--------|
| Primary/secondary action buttons | 🧪 Info snackbar (label echoed) |
| Dismiss (×) | 🧪 Info snackbar |

---

### 21. Customer Profile — `/profile`
**File:** `customer_profile_screen.dart`

#### App bar
| ☰ Menu | Opens drawer |

#### Pull-to-refresh
| Control | Action |
|---------|--------|
| Pull down | 🧪 Coming soon info |

#### Profile summary card
| Control | Action |
|---------|--------|
| **Edit details** | ✅ `/edit-profile` |
| Avatar edit overlay | 📋 Action sheet → 🧪 success (mock photo) |

#### Loyalty status card
| Control | Action |
|---------|--------|
| **View loyalty** | ✅ `/loyalty` |

#### Contact card
| Control | Action |
|---------|--------|
| Phone row tap | 🔄 Launches tel URI or 🧪 fallback warning |

#### Points activity card
| Control | Action |
|---------|--------|
| **Rewards history** | ✅ `/rewards-history` |

#### Payment history card
| Control | Action |
|---------|--------|
| **View payments** | ✅ `/payment-history` |

#### Saved addresses card
| Control | Action |
|---------|--------|
| Address row tap | 🔄 Selects default (in-place) |
| **Add address** | ✅ `/map-picker?return=profile` |
| Delete address | 📋 Confirm → 🧪 warning snackbar |
| **Manage all** | ✅ `/addresses` |

#### Notification preferences card
| Control | Action |
|---------|--------|
| Toggle switches | 🔄 Local state only (mock prefs) |

#### Account actions
| Control | Action |
|---------|--------|
| **Log out** | 🔄 Clears session + ✅ `/login` |
| **Deactivate account** | 📋 Confirm → 🧪 coming soon warning |

---

### 22. Customer Edit Profile — `/edit-profile`
**File:** `customer_edit_profile_screen.dart`

| Control | Action |
|---------|--------|
| ← Back | Pop |
| Form fields | 🔄 Input |
| **Save** | 🧪 Success snackbar + pop |

---

### 23. Customer Addresses — `/addresses`
**File:** `customer_addresses_screen.dart`

| Control | Action |
|---------|--------|
| ← Back | ✅ `/profile` (or pop) |
| 🔔 | ✅ `/notifications` |
| Pull-to-refresh | 🧪 Info snackbar |
| Address card tap | 🔄 Select address |
| **Add address** | ✅ `/map-picker?return=profile` |
| Delete address | 📋 Confirm → 🧪 warning |

---

### 24. Customer Map Picker — `/map-picker?return={route}`
**File:** `customer_map_picker_screen.dart`

| Control | Action |
|---------|--------|
| ← Back | ✅ `return` query param route (default `/cart`) |
| Map pan / pin drag | 🔄 Updates picked coordinates |
| **Confirm location** | 🧪 Success snackbar + ✅ `return` route |

---

### 25. Customer Payment History — `/payment-history`
**File:** `customer_payment_history_screen.dart`

| Control | Action |
|---------|--------|
| ← Back / 🔔 | Standard |
| Transaction rows | Display only |

---

### 26. Customer Support — `/support`
**File:** `customer_support_screen.dart`

| Control | Action |
|---------|--------|
| ← Back / 🔔 / 🛒 | Standard |
| **Live chat** card | ✅ `/support-chat` |
| **Call us** card | 🔄 Opens `tel:` URI or 🧪 fallback warning |
| **WhatsApp** card | 🔄 Opens `wa.me` URI or 🧪 fallback |
| **FAQ** card | ✅ `/faq` |
| Support ticket row tap | 📋 Ticket detail bottom sheet |
| Ticket sheet — status actions | 🧪 Success snackbars (mock) |
| Ticket sheet — star rating | 🔄 Sets rating + 🧪 success on submit |

---

### 27. Customer Support Chat — `/support-chat`
**File:** `customer_support_chat_screen.dart`

| Control | Action |
|---------|--------|
| ← Back / 🔔 | Standard |
| Quick reply chips | 🧪 Info snackbar |
| Message input + send | 🔄 Appends mock message to thread |

---

### 28. Customer FAQ — `/faq`
**File:** `customer_faq_screen.dart`

| Control | Action |
|---------|--------|
| ← Back / 🔔 / 🛒 | Standard |
| FAQ accordion card tap | 🔄 Expand / collapse answer |

---

### 29. Customer Terms — `/terms`
**File:** `customer_terms_screen.dart`

| Control | Action |
|---------|--------|
| ← Back / 🔔 / 🛒 | Standard |
| Terms sections | Display / scroll only |

---

### 30. Customer Plated Return Reminder — `/plated-return-reminder`
**File:** `customer_plated_return_reminder_screen.dart` · Custom scaffold (not drawer shell)

| Control | Action |
|---------|--------|
| ← Back (app bar) | ✅ `/order-history` |
| 🔔 Notifications | ✅ `/notifications` |
| **Schedule pickup** | 📋 Action sheet → 🧪 success (mock schedule) |
| **Remind me later** | 🧪 Info snackbar |

---

## Cross-Screen Flow Summary

```
Home ──search──► Search ──item──► Product Detail ──add──► Cart
  │                  │                    │
  ├──category───────►│                    └──reviews──► Product Reviews
  ├──offers─────────► Offers ──claim──► Cart / Combo
  ├──combo──────────► Combo Builder ──add──► Cart
  ├──discounts──────► Discounts ──item──► Product Detail
  ├──loyalty────────► Loyalty ──redeem──► Redemption ──confirm──► Cart
  └──drawer──────────────────────────────────────────────────────────────► All main hubs

Cart ──proceed──► [Checkout ──► Payment] ──► Order Confirmation ──► Order Tracking
                      (stepped)                    │                      │
Cart ──proceed──► Order Confirmation (legacy)    ├──► Home              └──► Rating Review
Guest anywhere checkout ──► Login
Profile ──► Edit Profile | Addresses | Map Picker | Payment History | Rewards History | Loyalty
Support ──► Support Chat | FAQ | tel: | WhatsApp
Notifications ──► Profile (preferences)
```

---

## Review Checklist (for QA)

Use `[ ]` when verifying each screen in a test pass:

- [ ] **Global:** Drawer items reach correct routes for Customer and Guest roles
- [ ] **Global:** Cart icon visible and navigates to `/cart` from all screens that show it
- [ ] **Global:** Search bar only navigates when query is non-empty
- [ ] **Home:** All section "View all" links reach correct destinations
- [ ] **Home:** Category tiles pre-select category on menu screen
- [ ] **Menu:** Category chips filter without leaving screen
- [ ] **Product detail:** Add-to-cart shows reward dialog with both CTAs working
- [ ] **Cart:** Guest blocked at checkout; customer proceeds per `useSteppedCheckoutRoutes`
- [ ] **Cart:** Address-required fulfillment opens picker; add address reaches map picker
- [ ] **Checkout flow:** Step strip jumps between cart / checkout / payment
- [ ] **Orders:** Active vs completed cards show correct action buttons
- [ ] **Rewards:** Guest redirected to register on redeem
- [ ] **Profile:** Logout returns to login; address management round-trips through map picker
- [ ] **Support:** External call/WhatsApp fallbacks show warning when launch fails
- [ ] **Notifications:** All action buttons currently mock-only (no deep links yet)

---

## Notes for Production Hardening

1. **Notifications** — Action buttons and dismiss controls use `UtilityMockFeedback` only; wire to real deep links (`/order-tracking`, `/plated-return-reminder`, etc.) in a future pass.
2. **Order history "View status"** — Opens bottom sheet instead of `/order-tracking`; consider unifying.
3. **Drawer shell routes** — Category, Rewards, Support are **not** drawer-leading routes; they show ← back instead of ☰.
4. **Map picker return param** — Cart uses `?return=profile`; confirm this matches intended post-save destination.

---

*Audited via MCP filesystem (`directory_tree`, `read_multiple_files`, `read_text_file`) and codebase grep across `lib/screens/customer/`.*
