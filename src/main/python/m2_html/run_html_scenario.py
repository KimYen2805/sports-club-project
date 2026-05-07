#!/usr/bin/env python3
"""Run one of the six M2 HTML scenarios by scenario number."""
from __future__ import annotations

import sys
from pathlib import Path

CURRENT_DIR = Path(__file__).resolve().parent
if str(CURRENT_DIR) not in sys.path:
    sys.path.insert(0, str(CURRENT_DIR))

from common import run_transform

SCENARIOS = {
    "1": ("ss1_members.xsl", "ss1.html"),
    "2": ("ss2_training.xsl", "ss2_training.html"),
    "3": ("ss3_teams.xsl", "ss3.html"),
    "4": ("ss4_bookings.xsl", "ss4_bookings.html"),
    "5": ("ss5_equipment.xsl", "ss5_equipment.html"),
    "6": ("ss6_dashboard.xsl", "ss6_dashboard.html"),
}


def main() -> int:
    if len(sys.argv) != 2 or sys.argv[1] not in SCENARIOS:
        print("Usage: python src/main/python/m2_html/run_html_scenario.py <1|2|3|4|5|6>")
        return 1
    xsl_name, output_name = SCENARIOS[sys.argv[1]]
    return run_transform(xsl_name, output_name)


if __name__ == "__main__":
    raise SystemExit(main())
