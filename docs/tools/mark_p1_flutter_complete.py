#!/usr/bin/env python3
"""Mark P1 screens as flutter_complete in stitch registry (idempotent)."""

import json
import os

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
REG = os.path.join(ROOT, "docs/stitch_generated_screens.json")

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
}


def main():
    data = json.load(open(REG))
    for screen in data["screens"]:
        if screen["prdRoute"] in FLUTTER_DONE:
            screen["status"] = "flutter_complete"
    json.dump(data, open(REG, "w"), indent=2)
    p1 = [s for s in data["screens"] if s.get("priority") == "P1"]
    done = sum(1 for s in p1 if s["status"] == "flutter_complete")
    print(f"P1 flutter_complete: {done}/{len(p1)} (registry total {len(data['screens'])})")
    for s in sorted(p1, key=lambda x: x["prdRoute"]):
        print(f"  {s['prdRoute']}: {s['status']}")


if __name__ == "__main__":
    main()
