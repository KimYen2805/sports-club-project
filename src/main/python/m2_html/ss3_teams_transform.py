#!/usr/bin/env python3
"""M2 HTML scenario 3: teams and coaches."""
from __future__ import annotations
import sys
from pathlib import Path

CURRENT_DIR = Path(__file__).resolve().parent
if str(CURRENT_DIR) not in sys.path:
    sys.path.insert(0, str(CURRENT_DIR))

from common import run_transform


if __name__ == "__main__":
    raise SystemExit(run_transform("ss3_teams.xsl", "ss3.html"))
