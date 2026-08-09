#!/usr/bin/env python3
"""Rebuild canonical stitch registry from known P0+P1 snapshots (idempotent)."""

import json
import os

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
REG = os.path.join(ROOT, "docs/stitch_generated_screens.json")

META = {
    "projectId": "11783570360337788529",
    "projectTitle": "Ayletna PRD v1.1 Code-Aligned Redesign",
    "designMdUploaded": True,
    "designSystemAsset": "assets/1765c34e66d04c27bc00fd90abc4ed99",
}

# flutter_complete = implemented per promptv1.md
FLUTTER_DONE = {
    "/language",
    "/otp",
    "/register",
    "/role-selection",
    "/pending-approval",
    "/search",
    "/category",
    "/product-detail",
    "/order-confirmation",
    "/order-tracking",
    "/order-history",
    "/loyalty",
    "/rewards",
    "/profile",
    "/addresses",
    "/offers",
    "/support",
    "/support-chat",
    "/combos",
    "/subscriptions",
    "/offers/:id",
}

P1_SCREENS = [
    ("/language", "lib/screens/auth/auth_language_selection_screen.dart", "Ayletna - Language Selection Gateway", "dc6cbda880f34b9d898876859b69ad33"),
    ("/otp", "lib/screens/auth/auth_otp_verification_screen.dart", "Ayletna - OTP Verification", "92fc8aef5bed4001928887b98d5fe81e"),
    ("/register", "lib/screens/auth/auth_register_screen.dart", "Ayletna - Registration (Bilingual)", "765eeefbe2c6426b9a6a3473e2cb5235"),
    ("/role-selection", "lib/screens/auth/auth_role_selection_screen.dart", "Ayletna - Role Selection Gateway", "998ea1f9bf424ab9bb2f533b44ed8e11"),
    ("/pending-approval", "lib/screens/auth/auth_pending_approval_screen.dart", "Ayletna - Staff Registration Pending", "bdd3d7f2f1a349f2bc7c51a2f970b88c"),
    ("/search", "lib/screens/customer/customer_search_screen.dart", "Ayletna - Menu Search Results", "6fe84bacc1e94a8b8447cb519ad08448"),
    ("/category", "lib/screens/customer/customer_category_screen.dart", "Ayletna - Category Browse", "a7bdbb41133c4eb8bd48885668f71d9d"),
    ("/product-detail", "lib/screens/customer/customer_product_detail_screen.dart", "Ayletna - Product Detail (Mansaf)", "5adde0ab72cc4457a1d20fc3b426f29a"),
    ("/order-confirmation", "lib/screens/customer/customer_order_confirmation_screen.dart", "Ayletna - Order Confirmation", "824c4cb9b5ea42d383b90d17a7085856"),
    ("/order-tracking", "lib/screens/customer/customer_order_tracking_screen.dart", "Ayletna - Order Tracking", "cf4cd39bd4784f8395d60ae9eeb441cb"),
    ("/order-history", "lib/screens/customer/customer_order_history_screen.dart", "Ayletna - Order History", "c050d0d2515140ec923b80d0b4c2f32f"),
    ("/loyalty", "lib/screens/customer/customer_loyalty_screen.dart", "Ayletna - Loyalty & Rewards Progress", "509c5bb046bf4dfe88ec546527299d6d"),
    ("/rewards", "lib/screens/customer/customer_rewards_catalog_screen.dart", "Ayletna - Rewards Catalog", "a209c8bd812a4f6bbaa73696d82b29c4"),
    ("/profile", "lib/screens/customer/customer_profile_screen.dart", "Ayletna - Profile Hub", "18c0b49681a54d689c4896196dcc8c6c"),
    ("/addresses", "lib/screens/customer/customer_addresses_screen.dart", "Ayletna - Saved Addresses", "a6b6429e518344da85a2318d4b24c601"),
    ("/offers", "lib/screens/customer/customer_offers_screen.dart", "Ayletna - Offers Hub", "9b7647b073c14e38a3ed61e8fc4555bd"),
    ("/support", "lib/screens/customer/customer_support_screen.dart", "Ayletna - Support Hub Dashboard", "a5e49b0aaafe45d49a298fc524bc4640"),
    ("/support-chat", "lib/screens/customer/customer_support_chat_screen.dart", "Ayletna - Live Support Chat", "380a0a3bc86a4f36a3d1f8d35cfbcfef"),
    ("/combos", "lib/screens/customer/customer_combos_screen.dart", "Ayletna - Combo Bundles", "d84842f023134426b98ea6b9c4dba558"),
    ("/subscriptions", "lib/screens/customer/customer_subscriptions_screen.dart", "Ayletna - Meal Subscriptions", "1680de958f9d41b3bebd1637c8673841"),
]

P0_SCREENS = [
    ("/home", "lib/screens/customer/customer_home_screen.dart", "Ayletna - Customer Home", "90a89adcc5f749f8be0aeccf20b7c93d"),
    ("/cart", "lib/screens/customer/customer_cart_screen.dart", "Ayletna - Unified Cart & Checkout", "e0514d3557be4c4cb5ea858c24c771c5"),
    ("/login", "lib/screens/auth/auth_login_screen.dart", "Ayletna - Login & Demo Hub", "ac055a3105224582a7ed42d0225a9fd3"),
    ("/app-admin", "lib/screens/admin/app_admin_dashboard_screen.dart", "Ayletna - App Admin Hub", "b55344e25af140a1b9d3c4d61cb2f78c"),
    ("/app-admin/roles", "lib/screens/admin/app_admin_role_permissions_screen.dart", "Ayletna - Role Permissions Matrix", "532b348fc55746d68e93d513eaa4fc37"),
    ("/app-admin/users", "lib/screens/admin/app_admin_user_permissions_screen.dart", "Ayletna - User Management List", "b876dd2ff274450e9a11334fc85ab8fd"),
    ("/app-admin/users/:id", "lib/screens/admin/app_admin_user_detail_permissions_screen.dart", "Ayletna - User Permissions Detail", "aecee2d1b2794310ac29b77095a0bf1c"),
    ("/operator", "lib/screens/admin/admin_dashboard_screen.dart", "Ayletna - Operator Hub", "352204684a7b49a082b991b1167c3c57"),
    ("/owner", "lib/screens/owner/owner_dashboard_screen.dart", "Ayletna - Owner Hub Dashboard", "70d14d1e08c142f2832bfe892f90f9d1"),
    ("/support-desk", "lib/screens/support/support_dashboard_screen.dart", "Ayletna - Support Tickets", "1111f240b65c4ac3a9761df56db4fc29"),
    ("/marketing", "lib/screens/marketing/marketing_dashboard_screen.dart", "Ayletna - Marketing Hub Dashboard", "e9fefd74445045f0aa16629602e767db"),
]


def main():
    current = {}
    if os.path.exists(REG):
        for s in json.load(open(REG)).get("screens", []):
            current[s["prdRoute"]] = s

    screens = []
    for route, flutter, title, sid in P0_SCREENS:
        row = current.get(route, {})
        screens.append({
            "prdRoute": route,
            "flutterFile": flutter,
            "stitchTitle": row.get("stitchTitle", title),
            "stitchScreenId": row.get("stitchScreenId", sid),
            "screenshotUrl": row.get("screenshotUrl"),
            "status": "flutter_complete",
        })

    for route, flutter, title, sid in P1_SCREENS:
        row = current.get(route, {})
        screens.append({
            "prdRoute": route,
            "flutterFile": flutter,
            "stitchTitle": row.get("stitchTitle", title),
            "stitchScreenId": row.get("stitchScreenId", sid),
            "screenshotUrl": row.get("screenshotUrl"),
            "status": "flutter_complete" if route in FLUTTER_DONE else row.get("status", "stitch_complete_flutter_pending"),
            "priority": "P1",
        })

    # Preserve any extra stitch-generated ops routes not in canonical lists
    known = {s[0] for s in P0_SCREENS + P1_SCREENS}
    for route, row in current.items():
        if route not in known:
            screens.append(row)

    data = {**META, "screens": screens}
    json.dump(data, open(REG, "w"), indent=2)
    p1 = [s for s in screens if s.get("priority") == "P1"]
    done = sum(1 for s in p1 if s["status"] == "flutter_complete")
    print(f"Rebuilt registry: {len(screens)} screens, P1 flutter_complete {done}/{len(p1)}")


if __name__ == "__main__":
    main()
