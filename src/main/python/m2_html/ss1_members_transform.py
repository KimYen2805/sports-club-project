#!/usr/bin/env python3
"""M2 HTML scenario 1: member list with membership status."""
from __future__ import annotations
import sys
from pathlib import Path

CURRENT_DIR = Path(__file__).resolve().parent
if str(CURRENT_DIR) not in sys.path:
    sys.path.insert(0, str(CURRENT_DIR))

from common import run_transform


if __name__ == "__main__":
    raise SystemExit(run_transform("ss1_members.xsl", "ss1.html"))
