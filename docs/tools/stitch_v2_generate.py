#!/usr/bin/env python3
"""Stitch v2: PRD-led batches (max 6 screens, one call per screen)."""

import base64
import fcntl
import json
import os
import sys
import time
import urllib.request

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
BATCHES_PATH = os.path.join(ROOT, "docs/tools/stitch_v2_batches.json")
REG_PATH = os.path.join(ROOT, "docs/stitch_generated_screens.json")
LOG_PATH = os.path.join(ROOT, "docs/stitch_generation_log.txt")

API_KEY = os.environ.get("STITCH_API_KEY")
if not API_KEY:
    sys.exit("STITCH_API_KEY environment variable is required")

EN_SUFFIX = (
    " ENGLISH UI TEXT ONLY. No Arabic characters. No RTL layout in mockup. "
    "Mobile restaurant app Ayletna. Drawer navigation only — no bottom tab bar. "
    "Cream #F9F6F0 background, gold #C98A42 primary, espresso #2B211A text. "
    "Premium warm Levantine food brand. Material 3 cards."
)

PER_CALL_TIMEOUT = 600
MAX_RETRIES = 3


def call(tool, args, timeout=PER_CALL_TIMEOUT):
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
    with urllib.request.urlopen(req, timeout=timeout) as r:
        data = json.loads(r.read())
    if data.get("result", {}).get("isError"):
        raise RuntimeError(data["result"]["content"][0]["text"])
    return json.loads(data["result"]["content"][0]["text"])


def load_registry():
    if os.path.exists(REG_PATH):
        return json.load(open(REG_PATH))
    return {"screens": []}


def save_registry(registry):
    with open(REG_PATH, "w") as f:
        fcntl.flock(f, fcntl.LOCK_EX)
        json.dump(registry, f, indent=2)
        fcntl.flock(f, fcntl.LOCK_UN)


def ensure_design_uploaded(project_id):
    reg = load_registry()
    if reg.get("designMdUploaded"):
        return reg.get("designSystemAsset")
    design = open(os.path.join(ROOT, "docs/DESIGN.md"), "rb").read()
    b64 = base64.b64encode(design).decode()
    try:
        out = call("upload_design_md", {"projectId": project_id, "designMdBase64": b64}, timeout=120)
        asset = out.get("designSystem") or out.get("designSystemAsset")
        reg["designMdUploaded"] = True
        if asset:
            reg["designSystemAsset"] = asset
        save_registry(reg)
        return asset
    except Exception as e:
        with open(LOG_PATH, "a") as log:
            log.write(f"DESIGN_UPLOAD_FAIL {e}\n")
        return reg.get("designSystemAsset")


def generate_one(project_id, design_system, route, prompt):
    args = {
        "projectId": project_id,
        "deviceType": "MOBILE",
        "modelId": "GEMINI_3_1_PRO",
        "prompt": f"Ayletna mobile screen route {route}. {prompt}{EN_SUFFIX}",
    }
    if design_system:
        args["designSystem"] = design_system
    return call("generate_screen_from_text", args)


def main():
    batch_id = sys.argv[1] if len(sys.argv) > 1 else None
    batches_cfg = json.load(open(BATCHES_PATH))
    project_id = batches_cfg["projectId"]
    batches = batches_cfg["batches"]
    if batch_id:
        batches = [b for b in batches if b["id"] == batch_id]
        if not batches:
            print(f"Unknown batch: {batch_id}")
            sys.exit(1)

    registry = load_registry()
    registry.setdefault("projectId", project_id)
    existing = {s["prdRoute"] for s in registry.get("screens", [])}
    design_system = ensure_design_uploaded(project_id)

    for batch in batches:
        print(f"=== Batch {batch['id']}: {batch['title']} (max {batches_cfg['maxPerBatch']}) ===")
        for item in batch["screens"][: batches_cfg["maxPerBatch"]]:
            route = item["route"]
            if route in existing:
                print(f"SKIP {route}")
                continue
            for attempt in range(1, MAX_RETRIES + 1):
                print(f"Generating {route} (attempt {attempt})...")
                with open(LOG_PATH, "a") as log:
                    log.write(f"START {route} attempt={attempt}\n")
                try:
                    out = generate_one(project_id, design_system, route, item["prompt"])
                    scr = out["outputComponents"][0]["design"]["screens"][0]
                    sid = scr.get("id") or scr["name"].split("/")[-1]
                    entry = {
                        "prdRoute": route,
                        "batchId": batch["id"],
                        "prdSection": batch["prdSection"],
                        "stitchTitle": scr.get("title", route),
                        "stitchScreenId": sid,
                        "screenshotUrl": scr.get("screenshot", {}).get("downloadUrl"),
                        "status": "stitch_generated_flutter_pending",
                        "flutterStatus": "pending",
                        "type": "main",
                        "tab": 1,
                    }
                    if item.get("flutterFile"):
                        entry["flutterFile"] = item["flutterFile"]
                    registry = load_registry()
                    registry.setdefault("screens", []).append(entry)
                    save_registry(registry)
                    existing.add(route)
                    with open(LOG_PATH, "a") as log:
                        log.write(f"OK {route} {sid}\n")
                    print(f"  OK {entry['stitchTitle']} -> {sid}")
                    break
                except Exception as e:
                    with open(LOG_PATH, "a") as log:
                        log.write(f"FAIL {route} attempt={attempt} {e}\n")
                    print(f"  FAIL {e}")
                    if attempt < MAX_RETRIES:
                        time.sleep(5 * attempt)
                    else:
                        print(f"  GIVING UP on {route} after {MAX_RETRIES} tries")
            time.sleep(2)

    print(f"Done. Registry total: {len(load_registry().get('screens', []))}")


if __name__ == "__main__":
    main()
