#!/usr/bin/env python3
"""Run remaining P1 Stitch waves sequentially (one process, file-locked writes)."""

import subprocess
import sys

WAVES = [2, 3, 4]
BATCH = 10


def main():
    start = int(sys.argv[1]) if len(sys.argv) > 1 else 2
    for wave in [w for w in WAVES if w >= start]:
        print(f"=== Wave {wave} ===", flush=True)
        rc = subprocess.call(
            ["python3", "docs/tools/stitch_generate_p1.py", str(wave), str(BATCH)]
        )
        if rc != 0:
            sys.exit(rc)
        subprocess.call(["python3", "docs/tools/mark_ops_p1_complete.py"])
    print("All waves done.", flush=True)


if __name__ == "__main__":
    main()
