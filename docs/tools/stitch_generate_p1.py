#!/usr/bin/env python3
"""Generate P1 Stitch screens for Ayletna PRD v1.1 redesign."""

import fcntl
import json
import os
import sys
import time
import urllib.request

API_KEY = os.environ.get("STITCH_API_KEY")
if not API_KEY:
    sys.exit("STITCH_API_KEY environment variable is required")
PROJECT = "11783570360337788529"
DS = "assets/1765c34e66d04c27bc00fd90abc4ed99"
ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
REG_PATH = os.path.join(ROOT, "docs/stitch_generated_screens.json")
LOG_PATH = os.path.join(ROOT, "docs/stitch_generation_log.txt")

P1 = [
    ("/language", "lib/screens/auth/auth_language_selection_screen.dart", "Ayletna bilingual language gateway /language. Arabic and English cards with emblems. Warm cream gold brand. Continue CTA."),
    ("/otp", "lib/screens/auth/auth_otp_verification_screen.dart", "Ayletna OTP verification /otp. 6-digit code fields, resend timer, verify CTA. Bilingual warm brand."),
    ("/register", "lib/screens/auth/auth_register_screen.dart", "Ayletna registration /register. Customer vs staff type selector. Name phone email password. Warm restaurant brand."),
    ("/role-selection", "lib/screens/auth/auth_role_selection_screen.dart", "Ayletna role selection /role-selection. Approved roles only cards with hub accents. Multi-role picker."),
    ("/pending-approval", "lib/screens/auth/auth_pending_approval_screen.dart", "Ayletna staff pending approval /pending-approval. Waiting state illustration status timeline contact support."),
    ("/search", "lib/screens/customer/customer_search_screen.dart", "Ayletna menu search /search. Search hero suggestion chips results list with food cards JOD prices Add buttons."),
    ("/category", "lib/screens/customer/customer_category_screen.dart", "Ayletna category browse /category. Category hero product horizontal filters grid of items."),
    ("/product-detail", "lib/screens/customer/customer_product_detail_screen.dart", "Ayletna product detail /product-detail. Hero image customization options add to cart sticky CTA reviews link."),
    ("/order-confirmation", "lib/screens/customer/customer_order_confirmation_screen.dart", "Ayletna order confirmation /order-confirmation. Success hero invoice block food tip deposit separate JOD lines track order CTA."),
    ("/order-tracking", "lib/screens/customer/customer_order_tracking_screen.dart", "Ayletna order tracking /order-tracking. Status timeline order type chip driver info plated return notice."),
    ("/order-history", "lib/screens/customer/customer_order_history_screen.dart", "Ayletna order history /order-history. Past orders list reorder CTA invoice preview."),
    ("/loyalty", "lib/screens/customer/customer_loyalty_screen.dart", "Ayletna loyalty /loyalty. Tier progress points balance perks grid redeem CTA gold accent."),
    ("/rewards", "lib/screens/customer/customer_rewards_catalog_screen.dart", "Ayletna rewards catalog /rewards. Redeemable rewards cards points cost filter sort."),
    ("/profile", "lib/screens/customer/customer_profile_screen.dart", "Ayletna profile hub /profile. Avatar wallet balance loyalty shortcut addresses orders settings sign out."),
    ("/addresses", "lib/screens/customer/customer_addresses_screen.dart", "Ayletna saved addresses /addresses. Address cards default badge edit delete add new map picker."),
    ("/offers", "lib/screens/customer/customer_offers_screen.dart", "Ayletna offers hub /offers. Promo cards combos subscriptions tabs warm food imagery."),
    ("/support", "lib/screens/customer/customer_support_screen.dart", "Ayletna customer support /support. FAQ chat ticket call options help cards."),
    ("/support-chat", "lib/screens/customer/customer_support_chat_screen.dart", "Ayletna live support chat /support-chat. Message bubbles agent avatar input bar attach."),
    ("/combos", "lib/screens/customer/customer_combos_screen.dart", "Ayletna combo bundles /combos. Bundle cards savings badge build combo CTA."),
    ("/subscriptions", "lib/screens/customer/customer_subscriptions_screen.dart", "Ayletna meal subscriptions /subscriptions. Plan cards weekly monthly pricing subscribe CTA."),
    ("/offers/:id", "lib/screens/customer/customer_promo_detail_screen.dart", "Ayletna promo detail /offers/:id. Hero offer terms eligibility add to cart share."),
    ("/kitchen", "lib/screens/kitchen/kitchen_dashboard_screen.dart", "Ayletna kitchen dashboard /kitchen. Prep ready lanes order-type color chips station load."),
    ("/kitchen-prep", "lib/screens/kitchen/kitchen_order_prep_screen.dart", "Ayletna kitchen prep detail /kitchen-prep. Order items checklist status bump actions."),
    ("/delivery", "lib/screens/delivery/delivery_dashboard_screen.dart", "Ayletna delivery dashboard /delivery. Active tasks map preview deposit collect chips."),
    ("/delivery-order", "lib/screens/delivery/delivery_order_screen.dart", "Ayletna delivery order /delivery-order. Collect food tip deposit separate lines confirm delivery."),
    ("/plated-return-task", "lib/screens/delivery/delivery_plated_return_task_screen.dart", "Ayletna plated return tasks /plated-return-task. Return queue timer deposit status."),
    ("/plated-return-process", "lib/screens/delivery/delivery_plated_return_process_screen.dart", "Ayletna plated return process /plated-return-process. Damage inspection settlement steps deposit refund."),
    ("/cashier", "lib/screens/cashier/cashier_order_screen.dart", "Ayletna cashier POS /cashier. Order tabs menu cart payment tip deposit separate totals."),
    ("/cashier-deposit-refund", "lib/screens/cashier/cashier_deposit_refund_screen.dart", "Ayletna deposit refund wizard /cashier-deposit-refund. Plate count damage settlement JOD refund."),
    ("/app-admin/audit", "lib/screens/admin/admin_audit_log_screen.dart", "Ayletna audit log /app-admin/audit. Timeline filters governance KPIs export."),
    ("/app-admin/owner-config", "lib/screens/admin/admin_owner_view_config_screen.dart", "Ayletna owner view config /app-admin/owner-config. Field masking toggles per report area."),
    ("/operator/orders", "lib/screens/admin/admin_orders_management_screen.dart", "Ayletna operator orders board /operator/orders. Live orders filters order-type chips status columns."),
    ("/operator/order-detail", "lib/screens/admin/admin_order_detail_screen.dart", "Ayletna operator order detail /operator/order-detail. Invoice block status actions tip deposit lines."),
    ("/operator/menu", "lib/screens/admin/admin_menu_management_screen.dart", "Ayletna menu management /operator/menu. Category sections product list CRUD actions."),
    ("/operator/product-editor", "lib/screens/admin/admin_product_editor_screen.dart", "Ayletna product editor /operator/product-editor. Form name price category image options save."),
    ("/operator/tips/distribute", "lib/screens/admin/admin_daily_tip_distribution_screen.dart", "Ayletna tip distribution /operator/tips/distribute. Pool breakdown approve distribute staff shares."),
    ("/operator/plates", "lib/screens/admin/admin_plates_management_screen.dart", "Ayletna plates management /operator/plates. Plate assets inventory out on delivery returned."),
    ("/operator/attendance", "lib/screens/admin/admin_attendance_hr_screen.dart", "Ayletna HR attendance /operator/attendance. Staff roster check-in status hours."),
    ("/operator/reports", "lib/screens/admin/admin_reports_screen.dart", "Ayletna reports center /operator/reports. Revenue tip deposit charts export filters."),
    ("/operator/financial-close", "lib/screens/admin/admin_financial_calculation_screen.dart", "Ayletna financial close /operator/financial-close. Monthly surplus owner minimum tip deposit isolation JOD."),
    ("/support-desk/tickets", "lib/screens/admin/admin_support_tickets_screen.dart", "Ayletna support tickets /support-desk/tickets. Ticket queue priority SLA assign resolve."),
    ("/support-desk/chat", "lib/screens/support/support_chat_queue_screen.dart", "Ayletna support chat queue /support-desk/chat. Waiting customers claim chat agent view."),
    ("/support-desk/order-lookup", "lib/screens/support/support_order_lookup_screen.dart", "Ayletna order lookup /support-desk/order-lookup. Search order ID customer status invoice."),
    ("/marketing/offers", "lib/screens/admin/admin_offers_management_screen.dart", "Ayletna marketing offers mgmt /marketing/offers. Offer list create edit publish approval."),
    ("/marketing/promotions", "lib/screens/admin/admin_promotions_management_screen.dart", "Ayletna promotions mgmt /marketing/promotions. Tabs combos discounts subscriptions calendar."),
    ("/marketing/loyalty", "lib/screens/admin/admin_loyalty_config_screen.dart", "Ayletna loyalty config /marketing/loyalty. Tier rules points multiplier rewards setup."),
]

SUFFIX = " Ayletna restaurant cream #F9F6F0 gold #C98A42. Drawer nav only no bottom bar. Bilingual Arabic RTL Noto Sans."


def call(tool, args):
    body = json.dumps(
        {
            "jsonrpc": "2.0",
            "id": 1,
            "method": "tools/call",
            "params": {"name": tool, "arguments": args},
        }
    ).encode()
    req = urllib.request.Request(
        "https://stitch.googleapis.com/mcp",
        data=body,
        headers={"Content-Type": "application/json", "X-Goog-Api-Key": API_KEY},
    )
    with urllib.request.urlopen(req, timeout=300) as r:
        data = json.loads(r.read())
    if data.get("result", {}).get("isError"):
        raise RuntimeError(data["result"]["content"][0]["text"])
    return json.loads(data["result"]["content"][0]["text"])


def load_registry():
    if not os.path.exists(REG_PATH):
        return {
            "projectId": PROJECT,
            "projectTitle": "Ayletna PRD v1.1 Code-Aligned Redesign",
            "designMdUploaded": True,
            "designSystemAsset": DS,
            "screens": [],
        }
    return json.load(open(REG_PATH))


def save_registry(registry):
    with open(REG_PATH, "w") as f:
        fcntl.flock(f, fcntl.LOCK_EX)
        json.dump(registry, f, indent=2)
        fcntl.flock(f, fcntl.LOCK_UN)


def main():
    wave = int(sys.argv[1]) if len(sys.argv) > 1 else 0
    batch_size = int(sys.argv[2]) if len(sys.argv) > 2 else len(P1)
    start = wave * batch_size
    end = min(start + batch_size, len(P1))
    batch = P1[start:end]

    registry = load_registry()
    existing = {s["prdRoute"] for s in registry.get("screens", [])}

    with open(LOG_PATH, "a") as log:
        for route, flutter, prompt in batch:
            if route in existing:
                log.write(f"SKIP {route}\n")
                print(f"SKIP {route}")
                continue
            log.write(f"START {route}\n")
            print(f"Generating {route}...")
            try:
                out = call(
                    "generate_screen_from_text",
                    {
                        "projectId": PROJECT,
                        "deviceType": "MOBILE",
                        "modelId": "GEMINI_3_1_PRO",
                        "designSystem": DS,
                        "prompt": prompt + SUFFIX,
                    },
                )
                scr = out["outputComponents"][0]["design"]["screens"][0]
                sid = scr.get("id") or scr["name"].split("/")[-1]
                entry = {
                    "prdRoute": route,
                    "flutterFile": flutter,
                    "stitchTitle": scr.get("title", route),
                    "stitchScreenId": sid,
                    "screenshotUrl": scr.get("screenshot", {}).get("downloadUrl"),
                    "status": "stitch_complete_flutter_pending",
                    "priority": "P1",
                }
                registry = load_registry()
                registry.setdefault("screens", []).append(entry)
                save_registry(registry)
                existing.add(route)
                log.write(f"OK {route} {sid}\n")
                print(f"  OK {entry['stitchTitle']} -> {sid}")
            except Exception as e:
                log.write(f"FAIL {route} {e}\n")
                print(f"  FAIL {e}")
            time.sleep(2)

    print(f"Wave done. Registry total: {len(registry.get('screens', []))}")


if __name__ == "__main__":
    main()
