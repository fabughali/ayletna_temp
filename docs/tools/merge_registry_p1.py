#!/usr/bin/env python3
"""Merge missing P1 registry entries without overwriting existing rows."""

import json
import os

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
REG = os.path.join(ROOT, "docs/stitch_generated_screens.json")

# Known Stitch outputs (from generation log / prior registry snapshots).
MISSING = [
    {
        "prdRoute": "/register",
        "flutterFile": "lib/screens/auth/auth_register_screen.dart",
        "stitchTitle": "Ayletna - Registration (Bilingual)",
        "stitchScreenId": "765eeefbe2c6426b9a6a3473e2cb5235",
        "status": "flutter_complete",
        "priority": "P1",
    },
    {
        "prdRoute": "/role-selection",
        "flutterFile": "lib/screens/auth/auth_role_selection_screen.dart",
        "stitchTitle": "Ayletna - Role Selection Gateway",
        "stitchScreenId": "998ea1f9bf424ab9bb2f533b44ed8e11",
        "status": "flutter_complete",
        "priority": "P1",
    },
    {
        "prdRoute": "/pending-approval",
        "flutterFile": "lib/screens/auth/auth_pending_approval_screen.dart",
        "stitchTitle": "Ayletna - Staff Registration Pending",
        "stitchScreenId": "bdd3d7f2f1a349f2bc7c51a2f970b88c",
        "status": "flutter_complete",
        "priority": "P1",
    },
    {
        "prdRoute": "/search",
        "flutterFile": "lib/screens/customer/customer_search_screen.dart",
        "stitchTitle": "Ayletna - Menu Search Results",
        "stitchScreenId": "6fe84bacc1e94a8b8447cb519ad08448",
        "status": "flutter_complete",
        "priority": "P1",
    },
    {
        "prdRoute": "/category",
        "flutterFile": "lib/screens/customer/customer_category_screen.dart",
        "stitchTitle": "Ayletna - Category Browse",
        "stitchScreenId": "a7bdbb41133c4eb8bd48885668f71d9d",
        "status": "flutter_complete",
        "priority": "P1",
    },
    {
        "prdRoute": "/product-detail",
        "flutterFile": "lib/screens/customer/customer_product_detail_screen.dart",
        "stitchTitle": "Ayletna - Product Detail (Mansaf)",
        "stitchScreenId": "5adde0ab72cc4457a1d20fc3b426f29a",
        "status": "flutter_complete",
        "priority": "P1",
    },
    {
        "prdRoute": "/order-confirmation",
        "flutterFile": "lib/screens/customer/customer_order_confirmation_screen.dart",
        "stitchTitle": "Ayletna - Order Confirmation",
        "stitchScreenId": "824c4cb9b5ea42d383b90d17a7085856",
        "status": "flutter_complete",
        "priority": "P1",
    },
    {
        "prdRoute": "/order-tracking",
        "flutterFile": "lib/screens/customer/customer_order_tracking_screen.dart",
        "stitchTitle": "Ayletna - Order Tracking",
        "stitchScreenId": "cf4cd39bd4784f8395d60ae9eeb441cb",
        "status": "flutter_complete",
        "priority": "P1",
    },
]


def main():
    data = json.load(open(REG))
    routes = {s["prdRoute"] for s in data["screens"]}
    added = 0
    for entry in MISSING:
        if entry["prdRoute"] not in routes:
            data["screens"].append(entry)
            added += 1
    # Mark wave-1 customer stitch_pending as flutter_complete
    done_pending = {"/support-chat", "/combos", "/subscriptions"}
    for screen in data["screens"]:
        if screen["prdRoute"] in done_pending:
            screen["status"] = "flutter_complete"
    json.dump(data, open(REG, "w"), indent=2)
    p1 = [s for s in data["screens"] if s.get("priority") == "P1"]
    complete = sum(1 for s in p1 if s["status"] == "flutter_complete")
    print(f"Added {added} missing entries. P1 flutter_complete: {complete}/{len(p1)} total registry: {len(data['screens'])}")


if __name__ == "__main__":
    main()
