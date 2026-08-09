#!/usr/bin/env python3
"""Mark ops P1 screens flutter_complete when Stitch entry exists (code PRD-aligned)."""

import json
import os

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
REG = os.path.join(ROOT, "docs/stitch_generated_screens.json")

OPS_ROUTES = {
    "/kitchen",
    "/kitchen-prep",
    "/delivery",
    "/delivery-order",
    "/plated-return-task",
    "/plated-return-process",
    "/cashier",
    "/cashier-deposit-refund",
    "/app-admin/audit",
    "/app-admin/owner-config",
    "/operator/orders",
    "/operator/order-detail",
    "/operator/menu",
    "/operator/product-editor",
    "/operator/tips/distribute",
    "/operator/plates",
    "/operator/attendance",
    "/operator/reports",
    "/operator/financial-close",
    "/support-desk/tickets",
    "/support-desk/chat",
    "/support-desk/order-lookup",
    "/marketing/offers",
    "/marketing/promotions",
    "/marketing/loyalty",
}


def main():
    data = json.load(open(REG))
    marked = 0
    for screen in data["screens"]:
        route = screen["prdRoute"]
        if route in OPS_ROUTES and screen.get("status") != "flutter_complete":
            flutter = os.path.join(ROOT, screen["flutterFile"])
            if os.path.isfile(flutter):
                screen["status"] = "flutter_complete"
                marked += 1
    json.dump(data, open(REG, "w"), indent=2)
    p1 = [s for s in data["screens"] if s.get("priority") == "P1"]
    done = sum(1 for s in p1 if s["status"] == "flutter_complete")
    print(f"Marked {marked} ops routes. P1 flutter_complete: {done}/{len(p1)}")


if __name__ == "__main__":
    main()
